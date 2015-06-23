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

function createSlug($productName){
    return $productName;
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
function updateProduct($product_id, $product_name, $product_hash, $sklad, $product_desk, $price) {
    $db = JFactory::getDbo();

    $product_name   = mysql_real_escape_string($product_name);
    $product_desk   = mysql_real_escape_string($product_desk);
    $product_s_desk = mysql_real_escape_string($product_s_desk);
    $product_slug = createSlug($product_s_desk);

    $num_category = 109;

    if ($product_id > 0) {
        $sqlProduct = "UPDATE `#__virtuemart_products` "
                . "SET `published` = 1 "
                . "WHERE `virtuemart_product_id` = $product_id";
        $db->setQuery($sqlProduct);
        $db->query();
        
        $sqlProdRu = "UPDATE `#__virtuemart_products_ru_ru` "
                . "SET `product_name` = '$product_name', `slug` = '$product_slug', `hash` = '$product_hash'"
                . "WHERE `virtuemart_product_id` = $product_id";
        $db->setQuery($sqlProdRu);
        $db->query();
    } else {
        $sqlProduct = "INSERT INTO `#__virtuemart_products` ("
                . "`virtuemart_product_id`, `virtuemart_vendor_id`, `product_parent_id`, `product_sku`, "
                . "`product_gtin`, `product_mpn`, `product_weight`, `product_weight_uom`, "
                . "`product_length`, `product_width`, `product_height`, `product_lwh_uom`, "
                . "`product_url`, `product_in_stock`, `product_ordered`, `low_stock_notification`, "
                . "`product_available_date`, `product_availability`, `product_special`, `product_sales`, "
                . "`product_unit`, `product_packaging`, `product_params`, `hits`, "
                . "`intnotes`, `metarobot`, `metaauthor`, `layout`, "
                . "`published`, `pordering`, `created_on`, `created_by`, "
                . "`modified_on`, `modified_by`, `locked_on`, `locked_by`"
                . ") VALUES ("
                . "NULL, 1, 0, '$sklad', "
                . "NULL, NULL, NULL, 'KG', "
                . "NULL, NULL, NULL, 'M', "
                . "'', 1, 3, 0, "
                . "'2015-2-8 00:00:00', NULL, 0, 0, "
                . "'KG', NULL, 'min_order_level=null|max_order_level=null|step_order_level=null|product_box=null|', NULL, "
                . "'', '', '', '0', "
                . "1, 0, '2015-6-22 17:59:03', 436, "
                . "'2015-6-22 17:59:03', 436, '0000-0-0 00:00:00', 0)";
        $db->setQuery($sqlProduct);
        $db->query();

        $product_id = $db->insertid();

        $sqlProdRu = "INSERT INTO `#__virtuemart_products_ru_ru` ("
                . "`virtuemart_product_id`, `product_s_desc`, `product_desc`, `product_name`, "
                . "`metadesc`, `metakey`, `customtitle`, `slug`, `hash`"
                . ") VALUES ("
                . "$product_id, '', '$product_desk', '$product_name', "
                . "'', '', '', '$product_slug', '$product_hash')";
        $db->setQuery($sqlProdRu);
        $db->query();
    }

    $sqlCategory = "INSERT INTO `#__virtuemart_product_categories` ("
            . "`virtuemart_product_id`, `virtuemart_category_id`, `ordering`"
            . ") VALUES ("
            . "$product_id, $num_category, 0)";
        $db->setQuery($sqlCategory);
        $db->query();

    $sqlPrices = "INSERT INTO `#__virtuemart_product_prices` ("
            . "`virtuemart_product_id`, `virtuemart_shoppergroup_id`, `product_price`, `override`, "
            . "`product_override_price`, `product_tax_id`, `product_discount_id`, `product_currency`, "
            . "`product_price_publish_up`, `product_price_publish_down`, `price_quantity_start`, `price_quantity_end`, "
            . "`created_on`, `created_by`, `modified_on`, `modified_by`, `locked_on`, `locked_by`"
            . ") VALUES ("
            . "$product_id, 0, $price, 0, "
            . "0.00000, -1, 0, 202, "
            . "'0000-0-0 00:00:00', '0000-0-0 00:00:00', 0, 0, "
            . "'2015-6-22 17:59:03', 436, '2015-6-22 17:59:03', 436, '0000-0-0 00:00:00', 0)";
        $db->setQuery($sqlPrices);
        $db->query();

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
