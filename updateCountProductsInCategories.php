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


function getCountProducts($catId = 0){
    $db = JFactory::getDBO();
    
    $query = "SELECT count(pc.virtuemart_product_id) "
            . "FROM #__virtuemart_product_categories pc "
            . "LEFT JOIN #__virtuemart_products p ON pc.virtuemart_product_id = p.virtuemart_product_id "
            . "WHERE p.published = 1 AND pc.virtuemart_category_id = $catId";
    $db->setQuery($query);
    $count = $db->loadResult();
    
    $query2 = "SELECT cc.category_child_id "
            . "FROM #__virtuemart_category_categories cc "
            . "LEFT JOIN #__virtuemart_categories c ON cc.category_child_id = c.virtuemart_category_id "
            . "WHERE c.published = 1 AND cc.category_parent_id = $catId";
    $db->setQuery($query2);
    $categories = $db->loadObjectList();
    
    foreach ($categories as $category){
        $count += getCountProducts($category->category_child_id);
    }
    
    $query3 = "UPDATE #__virtuemart_categories_ru_ru SET count_products = $count WHERE virtuemart_category_id = $catId";
    $db->setQuery($query3);
    $db->execute();
    
    return $count;
}

getCountProducts();

exit;