<?php

/**
 * @version		$Id: helper.php 14401 2010-01-26 14:10:00Z louis $
 * @package		Joomla
 * @copyright	Copyright (C) 2005 - 2010 Open Source Matters. All rights reserved.
 * @license		GNU/GPL, see LICENSE.php
 * Joomla! is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * See COPYRIGHT.php for copyright notices and details.
 */
// no direct access
defined('_JEXEC') or die('Restricted access');

class modLatestprodHelper {

    /**
     * get products
     * @param Object $params
     * @return array
     */
    public static function getProducts($params) {
        $countProducts = $params->get('count_products', 3);

        $productNumbers = self::getProductNumbers($countProducts);
        $product_model  = VmModel::getModel('product');

        for ($i = 0; $i < count($productNumbers); $i++) {
            $product = $product_model->getProduct($productNumbers[$i]);
            $product_model->addImages($product);

            $products[] = $product;
        }

        return $products;
    }

    /**
     * get numbers products
     * @param integer $countProducts
     * @return array
     */
    public static function getProductNumbers($countProducts) {
        $cookie = (isset($_COOKIE['latestproducts']) && trim($_COOKIE['latestproducts'])) ? explode(',', trim($_COOKIE['latestproducts'])) : array();

        $productId = vRequest::getInt('virtuemart_product_id');

        if ($productId > 0 && !in_array($productId, $cookie)) {
            while (count($cookie) >= $countProducts) {
                array_shift($cookie);
            }
            $cookie[] = $productId;
            setcookie('latestproducts', implode(',', $cookie), time() + 30 * 24 * 3600);
        }

        return $cookie;
    }

    public static function getKurs() {
        $db    = JFactory::getDbo();
        $query = " SELECT currency_exchange_rate FROM #__virtuemart_currencies WHERE currency_code_3 = 'KGS'";
        $db->setQuery($query);
        $kurs  = $db->loadResult();

        return ($kurs) ? $kurs : 1;
    }

}
