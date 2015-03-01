<?php

function pr($var) {
    echo '<pre>';
    print_r($var);
    echo '</pre>';
}

function create_small($name_big, $name_small, $max_x, $max_y) {
    list($x, $y, $t, $attr) = getimagesize($name_big);

    if ($t == IMAGETYPE_GIF)
        $big = imagecreatefromgif($name_big);
    else if ($t == IMAGETYPE_JPEG)
        $big = imagecreatefromjpeg($name_big);
    else if ($t == IMAGETYPE_PNG)
        $big = imagecreatefrompng($name_big);
    else
        return;

    if ($x > $y) {
        $xs = $max_x;
        $ys = $max_x / ($x / $y);
    } else {
        $ys = $max_y;
        $xs = $max_y / ($y / $x);
    }
    $small = imagecreatetruecolor($xs, $ys);
    $res   = imagecopyresampled($small, $big, 0, 0, 0, 0, $xs, $ys, $x, $y);
    imagedestroy($big);
    imagejpeg($small, $name_small);
    imagedestroy($small);
}

function getExtension2($filename, $exe, $bigexe) {
    $path_info = pathinfo($filename);
    return (($path_info['extension'] == $exe) or ($path_info['extension'] == $bigexe)) ? true : false;
}

function getDocumentList() {
    if (!is_dir('../images/prices')) {
        mkdir('../images/prices');
    }
    $dir   = opendir('../images/prices');
    $array = null;
    $i     = 1;
    while ($file  = readdir($dir)) {
        if ((( $file != ".") && ($file != "..")) and (getExtension2($file, 'csv', 'CSV'))) {
            $mas = pathinfo($file);

            $array[$i] = new stdClass();

            $array[$i]->basename  = $mas['basename'];
            $array[$i]->extension = $mas['extension'];
            $array[$i]->filename  = $mas['filename'];
            $array[$i]->filepath  = '../images/prices/' . $file;
            $array[$i]->filesize  = 64;
            $array[$i]->dataload  = '12.12.1012';
            $i++;
        }
    }
    closedir($dir);

    return $array;
}

function checkSkladName($name = '') {
    $db = JFactory::getDbo();

    $sql = 'SELECT `id` FROM `#__import_sklads` WHERE `price_name`=\'' . trim($name) . '\'';
    $db->setQuery($sql);
    return $db->loadResult();
}

function getNadbavkaList() {
    $db  = JFactory::getDbo();
    $sql = 'SELECT * FROM `#__import_xref`';

    $db->setQuery($sql);
    $rows = $db->loadObjectList();
    foreach ($rows as $row) {
        $data[$row->id] = new stdClass();

        $data[$row->id]->id      = $row->id;
        $data[$row->id]->sum     = $row->sum;
        $data[$row->id]->sum_tax = $row->sum_tax;
        $data[$row->id]->tax     = $row->tax;
    }

    return $data;
}

function setVars($name, $value) {
    $db  = JFactory::getDbo();
    $sql = "SELECT `id` FROM `#__import_vars` WHERE `name`='$name'";
    $db->setQuery($sql);
    $id  = $db->loadResult();

    if ($id > 0) {
        $sql = "UPDATE `#__import_vars` SET `value`='$value' WHERE `name`='$name'";
    } else {
        $sql = "INSERT INTO `#__import_vars` (`name`) VALUES ('$name')";
    }
    $db->setQuery($sql);
    $db->execute();
}

function getVars($name) {
    $db  = JFactory::getDbo();
    $sql = "SELECT `value` FROM `#__import_vars` WHERE `name`='$name'";
    $db->setQuery($sql);
    return $db->loadResult();
}

function getCountNadbavkaList() {
    $db  = JFactory::getDbo();
    $sql = 'SELECT COUNT(id) AS countid FROM `#__import_xref`';
    $db->setQuery($sql);
    return $db->loadResult();
}

function getConfig($id) {
    $db     = JFactory::getDbo();
    $sql    = 'SELECT `params` FROM `#__extensions` WHERE `extension_id`=' . $id;
    $db->setQuery($sql);
    $params = $db->loadResult();

    return json_decode($params);
}

function setConfig($id, $params) {
    $db  = JFactory::getDbo();
    $sql = 'UPDATE `#__extensions` SET `params`=\'' . json_encode($params) . '\' WHERE `extension_id`=' . $id;
    $db->setQuery($sql);
    $db->execute();
}

function deleteClearNadbavka() {
    $db  = JFactory::getDbo();
    $sql = "DELETE FROM `#__import_xref` WHERE `sum`='' OR `sum_tax`='' OR `tax`=''";
    $db->setQuery($sql);
    $db->execute();
}

function getProductList() {
    $db  = JFactory::getDbo();
    $sql = 'SELECT `pr`.*, prds.published, prds.product_sku ,`price`.`product_price`, (
                    SELECT COUNT(*) FROM #__virtuemart_product_medias WHERE virtuemart_product_id = pr.virtuemart_product_id
                ) as image 
                FROM `#__virtuemart_products_ru_ru` AS `pr` 
                LEFT JOIN `#__virtuemart_products` AS `prds` ON `pr`.`virtuemart_product_id`=`prds`.`virtuemart_product_id` 
                LEFT JOIN `#__virtuemart_product_categories` AS `pcx` ON `pr`.`virtuemart_product_id`=`pcx`.`virtuemart_product_id` 
                LEFT JOIN `#__virtuemart_product_prices` AS `price` ON `pr`.`virtuemart_product_id`=`price`.`virtuemart_product_id` 
                WHERE prds.published = 1 ';

    $where = (isset($_SESSION['import']['category_id'])) ? ' AND `pcx`.`virtuemart_category_id`=' . $_SESSION['import']['category_id'] : '';

    if (isset($_SESSION['import']['filtr'])) {
        $where = ' AND (`pr`.`product_name` LIKE \'%' . $_SESSION['import']['filtr'] . '%\' OR `prds`.`product_sku` LIKE \'%' . $_SESSION['import']['filtr'] . '%\')';
    }
    $where .= ' LIMIT 100';

    $sql .= $where;
    $db->setQuery($sql);
    $rows = $db->loadObjectList();
    $mass = array();
    foreach ($rows as $row) {
        $mass[$row->virtuemart_product_id] = new stdClass();

        $mass[$row->virtuemart_product_id]->product_id     = $row->virtuemart_product_id;
        $mass[$row->virtuemart_product_id]->product_sku    = $row->product_sku;
        $mass[$row->virtuemart_product_id]->product_s_desc = $row->product_s_desc;
        $mass[$row->virtuemart_product_id]->product_desc   = $row->product_desc;
        $mass[$row->virtuemart_product_id]->image          = $row->image;
        $mass[$row->virtuemart_product_id]->product_name   = $row->product_name;
        $mass[$row->virtuemart_product_id]->product_price  = number_format($row->product_price, 2, ',', '');
    }

    return $mass;
}

function getCategoryList($id = 0, $lvl = 0) {
    $db   = JFactory::getDbo();
    $mass = array();

    $sql  = 'SELECT `c`.* 
            FROM `#__virtuemart_categories_ru_ru` AS `c`
            LEFT JOIN `#__virtuemart_category_categories` AS `cx` 
            ON `cx`.`category_child_id`=`c`.`virtuemart_category_id`
            WHERE `cx`.`category_parent_id`=\'' . $id . '\'
            ORDER BY `ordering`';
    $db->setQuery($sql);
    $rows = $db->LoadObjectList();
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

function getDataFromXML($data, $tag, $sep = false) {
    $st_tag = '<' . $tag . '>';
    $ed_tag = '</' . $tag . '>';
    $st     = strpos($data, $st_tag) + strlen($st_tag);
    $ed     = strpos($data, $ed_tag);
    $lenght = $ed - $st;

    $ret = substr($data, $st, $lenght);

    if ($sep) {
        $ret = $st_tag . $ret . $ed_tag;
    }

    return $ret;
}

function parseProductName($product_id) {
    $db  = JFactory::getDbo();
    $obj = new stdClass();

    $sql = 'SELECT `product_name` FROM `#__virtuemart_products_ru_ru` WHERE `virtuemart_product_id`=' . $product_id;
    $db->setQuery($sql);

    $obj->product_name = $db->loadResult();

    $sql = 'SELECT `model` FROM `#__import_model` WHERE `product_id`=' . $product_id;
    $db->setQuery($sql);

    $obj->model = $db->loadResult();

    return $obj;
}

function createBakup() {
    $sql = 'SELECT * FROM `jos_vm_category`';
    $rs  = ImportModelImport::querySql($sql);

    $str = "INSERT INTO `jos_vm_category` (`category_id`, `vendor_id`, `category_name`, `category_description`, `category_thumb_image`, `category_full_image`, `category_publish`, `cdate`, `mdate`, `category_browsepage`, `products_per_row`, `category_flypage`, `list_order`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $category_id          = $row->category_id;
        $vendor_id            = $row->vendor_id;
        $category_name        = $row->category_name;
        $category_description = $row->category_description;
        $category_thumb_image = $row->category_thumb_image;
        $category_full_image  = $row->category_full_image;
        $category_publish     = $row->category_publish;
        $cdate                = $row->cdate;
        $mdate                = $row->mdate;
        $category_browsepage  = $row->category_browsepage;
        $products_per_row     = $row->products_per_row;
        $category_flypage     = $row->category_flypage;
        $list_order           = $row->list_order;

        $str .= $sep . " 
					('$category_id', '$vendor_id', '$category_name', '$category_description', '$category_thumb_image', '$category_full_image', '$category_publish', '$cdate', '$mdate', '$category_browsepage', '$products_per_row', '$category_flypage', '$list_order') \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $sql = 'SELECT * FROM `jos_vm_category_xref`';
    $rs  = ImportModelImport::querySql($sql);

    $str .= "INSERT INTO `jos_vm_category_xref` (`category_parent_id`, `category_child_id`, `category_list`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $category_parent_id = $row->category_parent_id;
        $category_child_id  = $row->category_child_id;
        $category_list      = $row->category_list;

        $str .= $sep . " ('$category_parent_id', '$category_child_id', '$category_list') \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $sql = 'SELECT * FROM `jos_vm_product`';
    $rs  = ImportModelImport::querySql($sql);

    $str .= "INSERT INTO `jos_vm_product` (`product_id`, `vendor_id`, `product_parent_id`, `product_sku`, `product_s_desc`, `product_desc`, `product_thumb_image`, `product_full_image`, `product_publish`, `product_weight`, `product_weight_uom`, `product_length`, `product_width`, `product_height`, `product_lwh_uom`, `product_url`, `product_in_stock`, `product_available_date`, `product_availability`, `product_special`, `product_discount_id`, `ship_code_id`, `cdate`, `mdate`, `product_name`, `product_sales`, `attribute`, `custom_attribute`, `product_tax_id`, `product_unit`, `product_packaging`, `child_options`, `quantity_options`, `child_option_ids`, `product_order_levels`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $product_id             = $row->product_id;
        $vendor_id              = $row->vendor_id;
        $product_parent_id      = $row->product_parent_id;
        $product_sku            = $row->product_sku;
        $product_s_desc         = $row->product_s_desc;
        $product_desc           = $row->product_desc;
        $product_thumb_image    = $row->product_thumb_image;
        $product_full_image     = $row->product_full_image;
        $product_publish        = $row->product_publish;
        $product_weight         = $row->product_weight;
        $product_weight_uom     = $row->product_weight_uom;
        $product_length         = $row->product_length;
        $product_width          = $row->product_width;
        $product_height         = $row->product_height;
        $product_lwh_uom        = $row->product_lwh_uom;
        $product_url            = $row->product_url;
        $product_in_stock       = $row->product_in_stock;
        $product_available_date = $row->product_available_date;
        $product_availability   = $row->product_availability;
        $product_special        = $row->product_special;
        $product_discount_id    = $row->product_discount_id;
        $ship_code_id           = $row->ship_code_id;
        $cdate                  = $row->cdate;
        $mdate                  = $row->mdate;
        $product_name           = $row->product_name;
        $product_sales          = $row->product_sales;
        $attribute              = $row->attribute;
        $custom_attribute       = $row->custom_attribute;
        $product_tax_id         = $row->product_tax_id;
        $product_unit           = $row->product_unit;
        $product_packaging      = $row->product_packaging;
        $child_options          = $row->child_options;
        $quantity_options       = $row->quantity_options;
        $child_option_ids       = $row->child_option_ids;
        $product_order_levels   = $row->product_order_levels;

        $str .= $sep . " ('$product_id', '$vendor_id', '$product_parent_id', '$product_sku', '$product_s_desc', '$product_desc', '$product_thumb_image', '$product_full_image', '$product_publish', '$product_weight', '$product_weight_uom', '$product_length', '$product_width', '$product_height', '$product_lwh_uom', '$product_url', '$product_in_stock', '$product_available_date', '$product_availability', '$product_special', '$product_discount_id', '$ship_code_id', '$cdate', '$mdate', '$product_name', '$product_sales', '$attribute', '$custom_attribute', '$product_tax_id', '$product_unit', '$product_packaging', '$child_options', '$quantity_options', '$child_option_ids', '$product_order_levels') \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $sql = 'SELECT * FROM `jos_vm_product_category_xref`';
    $rs  = ImportModelImport::querySql($sql);

    $str .= "INSERT INTO `jos_vm_product_category_xref` (`category_id`, `product_id`, `product_list`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $category_id  = $row->category_id;
        $product_id   = $row->product_id;
        $product_list = $row->product_list;

        $str .= $sep . " ('$category_id', '$product_id', '$product_list') \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $sql = 'SELECT * FROM `jos_vm_product_mf_xref`';
    $rs  = ImportModelImport::querySql($sql);

    $str .= "INSERT INTO `jos_vm_product_mf_xref` (`product_id`, `manufacturer_id`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $product_id      = $row->product_id;
        $manufacturer_id = $row->manufacturer_id;

        $str .= $sep . " ('$product_id', '$manufacturer_id') \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $sql = 'SELECT * FROM `jos_vm_product_price`';
    $rs  = ImportModelImport::querySql($sql);

    $str .= "INSERT INTO `jos_vm_product_price` (`product_price_id`, 	`product_id`, 		`product_price`, 	`product_currency`, 	`product_price_vdate`, `product_price_edate`, 	`cdate`, `mdate`, 	`shopper_group_id`, `price_quantity_start`, `price_quantity_end`) VALUES \r\n";
    $sep = '';
    while ($row = mysql_fetch_object($rs)) {
        $product_price_id     = $row->product_price_id;
        $product_id           = $row->product_id;
        $product_price        = $row->product_price;
        $product_currency     = $row->product_currency;
        $product_price_vdate  = $row->product_price_vdate;
        $product_price_edate  = $row->product_price_edate;
        $cdate                = $row->cdate;
        $mdate                = $row->mdate;
        $shopper_group_id     = $row->shopper_group_id;
        $price_quantity_start = $row->price_quantity_start;
        $price_quantity_end   = $row->price_quantity_end;

        $str .= $sep . " (`$product_price_id`, `$product_id`, `$product_price`, `$product_currency`, `$product_price_vdate`, `$product_price_edate`, `$cdate`, `$mdate`, `$shopper_group_id`, `$price_quantity_start`, `$price_quantity_end`) \r\n";
        $sep = ' , ';
    }

    $str .= " ; \r\n\r\n\r\n";

    $filename = 'bacup_' . date("d.m.Y") . '_' . time() . '.sql';
    $path     = $this->file_directory . 'bacup/' . $filename;
    $f        = fopen($path, "w");
    fwrite($f, $str);
    fclose($f);
}
