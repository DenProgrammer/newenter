<?php

/**
 * @package    Joomla.Site
 *
 * @copyright  Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */
if (version_compare(PHP_VERSION, '5.3.10', '<')) {
    die('Your host needs to use PHP 5.3.10 or higher to run this version of Joomla!');
}

/**
 * Constant that is checked in included files to prevent direct access.
 * define() is used in the installation folder rather than "const" to not error for PHP 5.2 and lower
 */
define('_JEXEC', 1);

if (file_exists(__DIR__ . '/defines.php')) {
    include_once __DIR__ . '/defines.php';
}

if (!defined('_JDEFINES')) {
    define('JPATH_BASE', __DIR__);
    require_once JPATH_BASE . '/includes/defines.php';
}

require_once JPATH_BASE . '/includes/framework.php';

// Mark afterLoad in the profiler.
JDEBUG ? $_PROFILER->mark('afterLoad') : null;

// Instantiate the application.
$app = JFactory::getApplication('site');

function getCategoryList($id = 0, $lvl = 0) {
    $db = JFactory::getDbo();

    $sql  = 'SELECT c.* '
            . 'FROM #__virtuemart_categories_ru_ru AS c '
            . 'LEFT JOIN #__virtuemart_categories AS cc '
            . 'ON cc.virtuemart_category_id = c.virtuemart_category_id '
            . 'INNER JOIN #__virtuemart_category_categories AS cx '
            . 'ON cx.category_child_id = c.virtuemart_category_id '
            . 'WHERE cx.category_parent_id=\'' . $id . '\' AND cc.published = 1 '
            . 'ORDER BY cc.ordering';
    $db->setQuery($sql);
    $rows = $db->loadObjectList();

    $mass = array();
    foreach ($rows as $row) {
        $mass[$row->virtuemart_category_id] = new stdClass();

        $mass[$row->virtuemart_category_id]->category_id   = $row->virtuemart_category_id;
        $mass[$row->virtuemart_category_id]->category_name = $row->category_name;
        $mass[$row->virtuemart_category_id]->level         = $id;
        $mass[$row->virtuemart_category_id]->lvl           = $lvl;

        $temp = getCategoryList($row->virtuemart_category_id, ($lvl + 1));

        if ($temp) {
            foreach ($temp as $item) {
                $mass[$item->category_id] = new stdClass();

                $mass[$item->category_id]->category_id   = $item->category_id;
                $mass[$item->category_id]->category_name = $item->category_name;
                $mass[$item->category_id]->level         = $item->level;
                $mass[$item->category_id]->lvl           = $item->lvl;
            }
        }
    }

    return $mass;
}

$db = JFactory::getDBO();

$query = " SELECT * FROM #__virtuemart_currencies WHERE currency_code_3 = 'KGS' LIMIT 1";
$db->setQuery($query);

$currencyUsd = $db->loadObject();

$kurs = round($currencyUsd->currency_exchange_rate,2);

$categories = getCategoryList(0);

$date = date('d-m-Y');

$content = "<tr style='border-bottom: solid 1px #ffffff;'>"
        . "<td width='750' style='background: #000000; color: white; font-size: 18px;padding-left:10px;'>Прайс-лист магазина EnterKG</td>"
        . "<td colspan=2 style='background: #000000; color: white; font-size: 16px;text-align: center;'>курс доллара $kurs, &nbsp;&nbsp;&nbsp;&nbsp;дата $date</td>"
        . "</tr>"
        . "<tr height=2>"
        . "<td colspan=3 style='background: #ffffff; font-size: 1px;'>&nbsp;</td>"
        . "</tr>"
        . "<tr>"
        . "<td style='background: #000000; color: white; font-size: 16px;padding-left:10px;'>Наименование</td>"
        . "<td style='background: #000000; color: white; font-size: 16px;text-align: center;'>Цена USD</td>"
        . "<td style='background: #000000; color: white; font-size: 16px;text-align: center;'>Цена KGS</td>"
        . "</tr>";
foreach ($categories as $c) {
    $id   = $c->category_id;
    $name = $c->category_name;
    $lvl  = $c->lvl;

    if ($lvl == 0) {
        $content .= "<tr><td colspan=3 style='background: #f90000; color: white; font-size: 16px;'>$name</td></tr>";
    } else {
        $content .= "<tr><td colspan=3 style='text-decoration: underline;'><strong>$name</strong></td></tr>";
    }
    $subsql = "SELECT p.virtuemart_product_id, p.product_name, pr.product_price, pr.product_currency
                FROM #__virtuemart_products_ru_ru AS p
                LEFT JOIN #__virtuemart_products AS vp ON vp.virtuemart_product_id = p.virtuemart_product_id
                LEFT JOIN #__virtuemart_product_prices AS pr ON p.virtuemart_product_id = pr.virtuemart_product_id
                WHERE vp.published = '1' AND p.virtuemart_product_id IN 
                    (
                        SELECT virtuemart_product_id 
                        FROM #__virtuemart_product_categories 
                        WHERE virtuemart_category_id = $id
                    )";
    $db->setQuery($subsql);
    $rows   = $db->LoadObjectList();
    $bool   = true;
    foreach ($rows as $row) {
        $bool          = !$bool;
        $product_id    = $row->virtuemart_product_id;
        $product_name  = $row->product_name;
        $product_price = ($row->product_currency == '202') ? $row->product_price : round($row->product_price / $kurs, 2);

        if ($row->product_currency == '202') {
            $price_usd = round($row->product_price, 2);
            $price_kgs = round($row->product_price * $kurs);
        } else {
            $price_usd = round($row->product_price / $kurs, 2);
            $price_kgs = round($row->product_price);
        }

        $price_usd = str_replace('.', ',', $price_usd);
        $price_kgs = str_replace('.', ',', $price_kgs);

        $color = $bool ? 'cccccc' : 'ffffff';
        $content .= "<tr>"
                . "<td style='background: #$color;'>$product_name</td>"
                . "<td style='background: #$color;'>$price_usd</td>"
                . "<td style='background: #$color;'>$price_kgs</td>"
                . "</tr>";
    }
}

$template = '<html>
                            <head>
                                <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
                            <head>
                            <body>
                                <table class="price" border=1 width=1000>%CONTENT%</table>';
$filetext = str_replace('%CONTENT%', $content, $template);

$f = fopen("images/stories/price.xls", 'w');
fwrite($f, $filetext);
fclose($f);

echo 'Прайс лист обновлен';

