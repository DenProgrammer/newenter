<?php
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

class ImportController {

    var $file_directory           = '';
    var $file_directory_arhiv     = '';
    var $upload_images            = '1';
    var $upload_images_path       = '';
    var $create_small_images      = true;
    var $size_main_images_width   = '300';
    var $size_main_images_height  = '300';
    var $size_small_images_width  = '100';
    var $size_small_images_height = '100';
    var $separator_rows           = '^';
    var $separator_cols           = '~';
    var $file                     = '';
    var $filepath                 = '';
    var $data                     = '';
    var $img                      = '';
    var $password                 = '';
    var $access                   = false;
    var $error;
    var $debbuger                 = 0;
    var $movefile                 = 1;
    var $show_error               = 0;
    var $metod                    = 'clear';
    var $price_type               = 'default';
    var $checkMetod               = 'identificator';
    var $currency                 = 'KGS';
    var $start_prod               = 0;

    function __construct($file)
    {

        $config = getConfig($_SESSION['import']['component_id']);

        if (JRequest::getInt('debugger') == 1) {
            $this->debbuger = 1;
        }

        $this->file_directory       = $config->file_directory . '/';
        $this->file_directory_arhiv = $config->file_directory_arhiv . '/';
        $this->movefile             = $config->move_file;
        $this->show_error           = $config->show_error;

        if (file_exists(($this->file_directory) . $file)) {
            $this->file     = trim($file);
            $this->filepath = ($this->file_directory) . trim($file);
        }
        $this->access = true;
    }

    function getExtension2($filename, $exe, $bigexe)
    {
        $path_info = pathinfo($filename);
        return (($path_info['extension'] == $exe) or ( $path_info['extension'] == $bigexe)) ? true : false;
    }

    function setVar($varname, $value)
    {
        $this->$varname = $value;
    }

    function getVar($var)
    {
        return $this->$var;
    }

    public function getData()
    {
        if ($this->debbuger == 1) {
            echo 'getData<br>';
        }
        return $this->data;
    }

    /**
     * get tax
     * 
     * @return array
     */
    public function getTax()
    {
        $db = JFactory::getDbo();

        $db->setQuery('SELECT sum, sum_tax, tax FROM `#__import_xref`');

        return $db->loadObjectList();
    }

    /**
     * get markup summa
     * 
     * @param float $summa
     * @return float
     */
    protected function getMarkupSumm($summa)
    {
        $db      = JFactory::getDbo();
        $sum     = 0;
        $sum_tax = 0;
        $select  = '';

        if (!$summa) {
            return 0;
        }

        $sql = 'SELECT * FROM `#__import_xref` WHERE `sum`>=' . $summa . ' ORDER BY `sum` LIMIT 1';
        $db->setQuery($sql);
        $row = $db->LoadObject();
        if ($row) {
            $sum     = $row->sum;
            $sum_tax = $row->sum_tax;
            $select  = $row->tax;
        }

        $markupSumma = 0;
        switch ($select) {
            case 'fix': {
                    $markupSumma = $summa + $sum_tax;
                    break;
                }
            case 'per': {
                    $markupSumma = $summa * (1 + ($sum_tax) / 100);
                    break;
                }
        }

        if ($markupSumma == 0) {
            $markupSumma = $summa;
        }

        return $markupSumma;
    }

    function getPercent($s)
    {
        $db = JFactory::getDbo();

        $sum     = 0;
        $sum_tax = 0;
        $select  = '';

        if ($s) {
            $s = (float) str_replace(',', '.', $s);

            $sql = 'SELECT * FROM `#__import_xref` WHERE `sum`>=' . $s . ' ORDER BY `sum` LIMIT 1';
            if ($this->debbuger == 1) {
                echo $sql . '<br><br>';
            }

            $db->setQuery($sql);
            $row = $db->LoadObject();

            $sum     = $row->sum;
            $sum_tax = $row->sum_tax;
            $select  = $row->tax;

            $summa = 0;
            if ($this->debbuger == 1) {
                echo " sum = $sum ; sum_tax =	$sum_tax ; select = $select<br>";
            }

            switch ($select) {
                case 'fix': {
                        $summa = $s + $sum_tax;
                        break;
                    }
                case 'per': {
                        $summa = $s * (1 + ($sum_tax) / 100);
                        break;
                    }
            }
            if ($this->debbuger == 1) {
                echo $summa . '<br>';
            }

            if ($summa == 0) {
                $summa = $s;
            }
        } else {
            $summa = 0;
        }

        return $summa;
    }

    public function winToUtf8($s)
    {
        static $table = array
            (
            "\xC0" => "\xD0\x90", "\xC1" => "\xD0\x91", "\xC2" => "\xD0\x92", "\xC3" => "\xD0\x93", "\xC4" => "\xD0\x94",
            "\xC5" => "\xD0\x95", "\xA8" => "\xD0\x81", "\xC6" => "\xD0\x96", "\xC7" => "\xD0\x97", "\xC8" => "\xD0\x98",
            "\xC9" => "\xD0\x99", "\xCA" => "\xD0\x9A", "\xCB" => "\xD0\x9B", "\xCC" => "\xD0\x9C", "\xCD" => "\xD0\x9D",
            "\xCE" => "\xD0\x9E", "\xCF" => "\xD0\x9F", "\xD0" => "\xD0\xA0", "\xD1" => "\xD0\xA1", "\xD2" => "\xD0\xA2",
            "\xD3" => "\xD0\xA3", "\xD4" => "\xD0\xA4", "\xD5" => "\xD0\xA5", "\xD6" => "\xD0\xA6", "\xD7" => "\xD0\xA7",
            "\xD8" => "\xD0\xA8", "\xD9" => "\xD0\xA9", "\xDA" => "\xD0\xAA", "\xDB" => "\xD0\xAB", "\xDC" => "\xD0\xAC",
            "\xDD" => "\xD0\xAD", "\xDE" => "\xD0\xAE", "\xDF" => "\xD0\xAF", "\xAF" => "\xD0\x87", "\xB2" => "\xD0\x86",
            "\xAA" => "\xD0\x84", "\xA1" => "\xD0\x8E", "\xE0" => "\xD0\xB0", "\xE1" => "\xD0\xB1", "\xE2" => "\xD0\xB2",
            "\xE3" => "\xD0\xB3", "\xE4" => "\xD0\xB4", "\xE5" => "\xD0\xB5", "\xB8" => "\xD1\x91", "\xE6" => "\xD0\xB6",
            "\xE7" => "\xD0\xB7", "\xE8" => "\xD0\xB8", "\xE9" => "\xD0\xB9", "\xEA" => "\xD0\xBA", "\xEB" => "\xD0\xBB",
            "\xEC" => "\xD0\xBC", "\xED" => "\xD0\xBD", "\xEE" => "\xD0\xBE", "\xEF" => "\xD0\xBF", "\xF0" => "\xD1\x80",
            "\xF1" => "\xD1\x81", "\xF2" => "\xD1\x82", "\xF3" => "\xD1\x83", "\xF4" => "\xD1\x84", "\xF5" => "\xD1\x85",
            "\xF6" => "\xD1\x86", "\xF7" => "\xD1\x87", "\xF8" => "\xD1\x88", "\xF9" => "\xD1\x89", "\xFA" => "\xD1\x8A",
            "\xFB" => "\xD1\x8B", "\xFC" => "\xD1\x8C", "\xFD" => "\xD1\x8D", "\xFE" => "\xD1\x8E", "\xFF" => "\xD1\x8F",
            "\xB3" => "\xD1\x96", "\xBF" => "\xD1\x97", "\xBA" => "\xD1\x94", "\xA2" => "\xD1\x9E"
        );

        return strtr($s, $table);
    }

    /**
     * check type record
     * 
     * @param array   $data
     * @param integer $posName
     * @param integer $posPrice
     * @return string
     */
    protected function checkType($data, $posName, $posPrice)
    {
        return (trim($data[$posName]) != '' && floatval($data[$posPrice]) > 0) ? 'PRODUCT' : '';
    }

    /**
     * read file 
     * 
     * @param integer $clear_line
     * @return array file
     */
    protected function readFile($options, $clear_line = 0)
    {
        $excel = PHPExcel_IOFactory::load($this->filepath);

        $data = array();
        foreach ($excel->getWorksheetIterator() as $worksheet) {
            $highestRow         = $worksheet->getHighestRow() + 1;
            $highestColumn      = $worksheet->getHighestColumn();
            $highestColumnIndex = PHPExcel_Cell::columnIndexFromString($highestColumn);
            for ($row = 1; $row <= $highestRow; ++$row) {
                if ($clear_line > $row) {
                    continue;
                }
                $arr = array();
                for ($col = 0; $col < $highestColumnIndex; ++$col) {
                    $cell  = $worksheet->getCellByColumnAndRow($col, $row);
                    $arr[] = trim(str_replace(array(chr(194) . chr(160)), ' ', $cell->getValue()));
                }

                if ($arr[$options->position_product_name] && $arr[$options->position_product_price] > 0) {
                    $data[$row] = array(
                        'product_name'  => $arr[$options->position_product_name],
                        'product_price' => $arr[$options->position_product_price],
                        'product_desk'  => $arr[$options->position_product_s_desk],
                    );
                }
            }
        }

        return $data;
    }

    //parsing csv files for update sklads
    function parceCSV()
    {
        $start  = microtime(1);
//        echo round(microtime(1) - $start, 2) . '<br>';
        $offset = JRequest::getInt('offset');

        $markup_fix_value = JRequest::getVar('markup_fix_value');

        //get options from current price
        $options                 = getOptionsPrice($this->price_type);
//        echo round(microtime(1) - $start, 2) . '<br>';
        $sklad                   = $options->sklad_name;
        $position_product_name   = $options->position_product_name;
        $position_product_price  = $options->position_product_price;
        $position_product_s_desc = $options->position_product_s_desk;
        $clear_line              = $options->clear_line;
        $markup                  = $options->markup;
        $this->checkMetod        = $options->price_name;
        $currency                = $options->currency == 'USD' ? 202 : 165;

        if (($sklad) and ( $offset == 0)) {
            unpublishSklad($sklad);
        }
//        echo round(microtime(1) - $start, 2) . '<br>';

        $db = JFactory::getDbo();

        $db->setQuery('SELECT virtuemart_product_id, hash FROM #__virtuemart_products_ru_ru');
        $items = $db->loadObjectList();

        $productHash = array();
        foreach ($items as $item) {
            $productHash[$item->hash] = $item->virtuemart_product_id;
        }

//        echo round(microtime(1) - $start, 2) . '<br>';

        if ((file_exists($this->filepath)) and ( trim($this->file) != '')) {
            $data = $this->readFile($options, $clear_line);
            echo mb_detect_encoding(current($data)['product_name']) . "<br>\n";
            echo current($data)['product_name'] . "<br>\n";
            echo iconv('cp1251', 'utf-8',current($data)['product_name']) . "<br>\n";
//            echo decode_utf8(current($data)['product_name']) . "<br>\n";
            echo '<pre>';
            print_r($data);
            exit;
//            echo round(microtime(1) - $start, 2) . '<br>';

            $newProduct    = 0;
            $updateProduct = 0;
            $record        = 0;
            $errors        = 0;

            foreach ($data as $item) {
                $record++;
                $product_name = str_replace('\\', '&#92;', htmlentities($item['product_name'], ENT_QUOTES, 'UTF-8'));
                $hash         = preg_replace(getPattern(), '', $item['product_name']);
                $product_id   = isset($productHash[$hash]) ? $productHash[$hash] : 0;
                $product_desc = trim(htmlentities($item['product_desk'], ENT_QUOTES, 'UTF-8'));

                $product_price = preg_replace('/[^0-9\.]/', '', str_replace(',', '.', $item['product_price']));

                if ($markup == 1) {
                    $product_price = $this->getMarkupSumm($product_price);
                }
                if ($markup == 2 && $markup_fix_value > 0) {
                    $product_price = $product_price * (1 + $markup_fix_value / 100);
                }
                if (strlen($product_desc) < 6) {
                    $product_desc = '';
                }

                $category_id = getCategoryById($product_id);

                $data = $this->getProductTemplate(
                        $product_id, time() . rand(1000, 9999), $product_name, $product_price, $category_id, $product_desc, $hash, $currency
                );

                vRequest::setVar(JSession::getFormToken(), 1);
                $model = VmModel::getModel('product');
                $id    = $model->store($data);
                if (!$id > 0) {
//    echo '<pre>';print_r($data);exit;
                    $errors++;
                    continue;
                }
                $this->setProductSku($id, $sklad . $id);
                if ($product_id == 0) {
                    $newProduct++;
                } else {
                    $updateProduct++;
                }
            }
//            echo round(microtime(1) - $start, 2) . '<br>';
        }

        $data = array(
            'count'  => $record,
            'new'    => $newProduct,
            'update' => $updateProduct,
            'errors' => $errors,
            'time'   => round(microtime(1) - $start, 2),
        );

        echo json_encode($data);
        exit;
    }

    function moveFile()
    {
        if (!file_exists($this->filepath)) {
            return;
        }

        $arhiv = $this->file_directory_arhiv;
        if (file_exists($arhiv)) {
            $catalog = $arhiv . 'import_arhiv_' . date("Y");
            if (!((file_exists($catalog)) and ( is_dir($catalog)))) {
                mkdir($catalog);
            }
            $filepath = $this->filepath;
            unlink($filepath);
        }
    }

    public function setProductSku($product_id, $product_sku)
    {
        $db = JFactory::getDbo();
        $db->setQuery("UPDATE #__virtuemart_products "
                . "SET product_sku = '$product_sku' "
                . "WHERE virtuemart_product_id = $product_id");
        $db->execute();
    }

    /**
     * get product template
     * 
     * @param integer $product_id
     * @param string  $sku
     * @param string  $name
     * @param float   $price
     * @param integer $category_id
     * @param string  $desc
     * @return array
     */
    public function getProductTemplate($product_id, $sku, $name, $price, $category_id, $desc, $hash, $currency = 202)
    {
        $db   = JFactory::getDbo();
        $lang = JFactory::getLanguage();
        $slug = $lang->transliterate($name);

        if ($product_id > 0) {
            $sql = 'SELECT virtuemart_product_price_id '
                    . 'FROM #__virtuemart_product_prices '
                    . 'WHERE product_currency = 202 AND virtuemart_product_id = ' . $product_id;
            $db->setQuery($sql);

            $virtuemart_product_price_id = $db->loadResult();
        } else {
            $virtuemart_product_price_id = 0;
        }

        $product = array(
            'product_name'           => $name,
            'published'              => 1,
            'product_special'        => 0,
            'slug'                   => $slug,
            'product_sku'            => $sku,
            'product_gtin'           => null,
            'product_mpn'            => null,
            'layout'                 => 0,
            'product_url'            => null,
            'categories'             => array($category_id),
            'ordering'               => 0,
            'mprices'                => array(
                'product_price'               => array($price),
                'virtuemart_product_price_id' => array($virtuemart_product_price_id),
                'product_currency'            => array($currency),
                'virtuemart_shoppergroup_id'  => array(),
                'basePrice'                   => array(0),
                'product_tax_id'              => array(-1),
                'salesPrice'                  => array(),
                'product_discount_id'         => array(0),
                'product_price_publish_up'    => array(),
                'product_price_publish_down'  => array(),
                'product_override_price'      => array(),
                'price_quantity_start'        => array(),
                'price_quantity_end'          => array(),
            ),
            'intnotes'               => null,
            'product_s_desc'         => $desc,
            'product_desc'           => $desc,
            'customtitle'            => null,
            'metakey'                => null,
            'metadesc'               => null,
            'metarobot'              => null,
            'metaauthor'             => null,
            'product_in_stock'       => 1,
            'product_ordered'        => 3,
            'low_stock_notification' => 0,
            'step_order_level'       => null,
            'min_order_level'        => null,
            'max_order_level'        => null,
            'product_available_date' => '2015-02-08',
            'product_availability'   => null,
            'image'                  => null,
            'customer_email_type'    => 'customer',
            'notification_template'  => 1,
            'notify_number'          => null,
            'product_length'         => null,
            'product_lwh_uom'        => 'M',
            'product_width'          => null,
            'product_height'         => null,
            'product_weight'         => null,
            'product_weight_uom'     => 'KG',
            'product_packaging'      => null,
            'product_unit'           => 'KG',
            'product_box'            => null,
            'searchMedia'            => null,
            'media_published'        => 1,
            'file_title'             => null,
            'file_description'       => null,
            'file_meta'              => null,
            'file_url'               => 'images/stories/virtuemart/product/',
            'file_url_thumb'         => null,
            'media_roles'            => 'file_is_displayable',
            'media_action'           => 0,
            'file_is_product_image'  => 1,
            'active_media_id'        => 0,
            'virtuemart_product_id'  => $product_id,
            'product_parent_id'      => 0,
            'hash'                   => $hash,
        );

        return $product;
    }

}
