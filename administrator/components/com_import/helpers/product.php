<?php

/**
 * get pattern for created product hash
 * 
 * @return string
 */
function getPattern() {
    return '/[^a-zA-Z0-9а-яА-Я]/ui';
}

/**
 * update product name
 * 
 * @return integer
 */
function updateProductName() {
    $db = JFactory::getDbo();

    $db->setQuery('SELECT product_id, product_name FROM #__vm_product');
    $rows = $db->LoadObjectList();

    if (count($rows) > 0) {
        foreach ($rows as $row) {
            $product_name = htmlentities($row->product_name, ENT_QUOTES, 'UTF-8');
            $db->setQuery('UPDATE #__vm_product SET product_name = \'' . $product_name . '\' WHERE product_id = ' . $row->product_id);

            $db->query();
        }
    }
}

/**
 * update product hash
 * 
 * @return integer
 */
function updateHash() {
    $db = JFactory::getDbo();

    $db->setQuery('SELECT virtuemart_product_id, product_name FROM #__virtuemart_products_ru_ru WHERE hash = "" OR hash IS NULL');
    $rows = $db->LoadObjectList();

    if (count($rows) > 0) {
        foreach ($rows as $row) {
            $hash = preg_replace(getPattern(), '', $row->product_name);
            $db->setQuery('UPDATE #__virtuemart_products_ru_ru SET hash = \'' . $hash . '\' WHERE virtuemart_product_id = ' . $row->virtuemart_product_id);
            $db->query();
        }
    }

    return count($rows);
}

/**
 * check isset product by hash
 * 
 * @param string $product_name
 * @return integer
 */
function checkIssetProductByHash($product_name) {
    $db   = JFactory::getDbo();
    $hash = preg_replace(getPattern(), '', $product_name);

    $db->setQuery('SELECT virtuemart_product_id FROM #__virtuemart_products_ru_ru WHERE hash = \'' . $hash . '\'');
    $product_id = $db->LoadResult();

    return ($product_id > 0) ? $product_id : 0;
}

/**
 * unpublish sklad
 * 
 * @param string $sklad
 */
function unpublishSklad($sklad) {
    $db = JFactory::getDbo();
    $db->setQuery("UPDATE `#__virtuemart_products` SET `published` = 0 WHERE `product_sku` LIKE '%$sklad%'");
    $db->query();
}

/**
 * get options price
 * 
 * @param string $price_type
 * @return object
 */
function getOptionsPrice($price_type) {
    $db  = JFactory::getDbo();
    $sql = 'SELECT * FROM `#__import_sklads` WHERE `price_name`=\'' . $price_type . '\'';
    $db->setQuery($sql);
    return $db->LoadObject();
}

/**
 * update product
 * 
 * @param integer $product_id
 * @param string  $product_name
 * @param string  $product_hash
 * @param string  $sklad
 * @param string  $product_desk
 * @param string  $product_s_desk
 * @param integer $newProduct
 * @return integer
 */
function updateProduct($product_id, $product_name, $product_hash, $sklad, $product_desk, $product_s_desk, &$newProduct) {
    $db = JFactory::getDbo();

    $product_name   = mysql_real_escape_string($product_name);
    $product_desk   = mysql_real_escape_string($product_desk);
    $product_s_desk = mysql_real_escape_string($product_s_desk);

    $num_category = 109;

    if ($product_id > 0) {
        $sql = 'UPDATE `#__vm_product` '
                . 'SET `product_name`=\'' . $product_name . '\',`product_publish`=\'Y\' '
                . 'WHERE `product_id`=' . $product_id;
        $db->setQuery($sql);
        $db->query();
    } else {
        $newProduct++;
        $sql = "INSERT INTO `jos_vm_product` 
                (`vendor_id`, `product_sku`, `product_publish`, `product_s_desc`, `product_desc`, `hash`, 			
                `product_available_date`, `product_special`, `cdate`, `mdate`, `product_name`,
                `product_unit`, `child_options`, `quantity_options`, `product_order_levels`) 
                VALUES 
                ('1', '" . $sklad . rand(1000, 9999) . "', 'Y', '$product_s_desk', '$product_desk', '$product_hash',
                '" . time() . "', 'N', '" . time() . "', '" . time() . "', '$product_name',
                'шт.', 'N,N,N,N,N,N,20%,10%,', 'none,0,0,1', '0,0')";
        $db->setQuery($sql);
        $db->query();

        $product_id = $db->insertid();

        $product_sku = $sklad . $product_id;
        $sql2        = "UPDATE `#__vm_product` SET `product_sku`='$product_sku' "
                . "WHERE `product_id`='$product_id'";
        $db->setQuery($sql2);
        $db->query();

        $sql3 = "INSERT INTO `jos_vm_product_category_xref` (`category_id`, `product_id`) "
                . "VALUES ('$num_category', '$product_id')";
        $db->setQuery($sql3);
        $db->query();

        $sql4 = "INSERT INTO `jos_vm_product_mf_xref` (`product_id`, `manufacturer_id`) "
                . "VALUES ('$product_id', '1')";
        $db->setQuery($sql4);
        $db->query();
    }

    return $product_id;
}

/**
 * get category by id
 * 
 * @param integer $product_id
 * @return integer
 */
function getCategoryById($product_id) {
    $db = JFactory::getDbo();

    $sql = 'SELECT virtuemart_category_id '
            . 'FROM #__virtuemart_product_categories '
            . 'WHERE virtuemart_product_id = ' . $product_id;

    $db->setQuery($sql);
    $category_id = $db->loadResult();

    $num_category = 109;

    return ($category_id > 0) ? $category_id : $num_category;
}

/**
 * update product price
 * 
 * @param integer $id
 * @param float   $price
 * @param string  $currency
 */
function updatePrice($id, $price, $currency) {
    $db = JFactory::getDbo();

    if ($id > 0) {
        $db->setQuery('DELETE FROM `#__vm_product_price` WHERE  `product_id`=' . $id);
        $db->query();
    }

    $product_price = number_format($price, 2, '.', '');

    $sql = "INSERT INTO `#__vm_product_price` (`product_id`, `product_price`, `product_currency`, `cdate`, `mdate`, `shopper_group_id`) "
            . "VALUES ('$id', '$product_price', '$currency', " . time() . ", " . time() . ", '5')";

    $db->setQuery($sql);
    $db->query();
}
