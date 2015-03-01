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

    function __construct($file) {

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

    function getExtension2($filename, $exe, $bigexe) {
        $path_info = pathinfo($filename);
        return (($path_info['extension'] == $exe) or ($path_info['extension'] == $bigexe)) ? true : false;
    }

    function setVar($varname, $value) {
        $this->$varname = $value;
    }

    function getVar($var) {
        return $this->$var;
    }

    public function getData() {
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
    public function getTax() {
        $db = JFactory::getDbo();

        $db->setQuery('SELECT sum, sum_tax, tax FROM `#__import_xref`');

        return $db->loadObjectList();
    }

    function getPercent($s) {
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

    public function winToUtf8($s) {
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

    function checkWhite($s) {
        static $table = array
            (
            "a" => "1", "b" => "1", "c" => "1", "d" => "1", "e" => "1",
            "f" => "1", "g" => "1", "h" => "1", "i" => "1", "j" => "1",
            "k" => "1", "l" => "1", "m" => "1", "n" => "1", "o" => "1",
            "p" => "1", "q" => "1", "r" => "1", "s" => "1", "t" => "1",
            "u" => "1", "v" => "1", "w" => "1", "x" => "1", "y" => "1",
            "z" => "1",
            "A" => "1", "B" => "1", "C" => "1", "D" => "1", "E" => "1",
            "F" => "1", "G" => "1", "H" => "1", "I" => "1", "J" => "1",
            "K" => "1", "L" => "1", "M" => "1", "N" => "1", "O" => "1",
            "P" => "1", "Q" => "1", "R" => "1", "S" => "1", "T" => "1",
            "U" => "1", "V" => "1", "W" => "1", "X" => "1", "Y" => "1",
            "Z" => "1",
            "а" => "1", "б" => "1", "в" => "1", "г" => "1", "д" => "1",
            "е" => "1", "ё" => "1", "ж" => "1", "з" => "1", "и" => "1",
            "й" => "1", "к" => "1", "л" => "1", "м" => "1", "н" => "1",
            "о" => "1", "п" => "1", "р" => "1", "с" => "1", "т" => "1",
            "у" => "1", "ф" => "1", "х" => "1", "ц" => "1", "ч" => "1",
            "ш" => "1", "щ" => "1", "ь" => "1", "ы" => "1", "ъ" => "1",
            "э" => "1", "ю" => "1", "я" => "1",
            "А" => "1", "Б" => "1", "В" => "1", "Г" => "1", "Д" => "1",
            "Е" => "1", "Ё" => "1", "Ж" => "1", "З" => "1", "И" => "1",
            "Й" => "1", "К" => "1", "Л" => "1", "М" => "1", "Н" => "1",
            "О" => "1", "П" => "1", "Р" => "1", "С" => "1", "Т" => "1",
            "У" => "1", "Ф" => "1", "Х" => "1", "Ц" => "1", "Ч" => "1",
            "Ш" => "1", "Щ" => "1", "Ь" => "1", "Ы" => "1", "Ъ" => "1",
            "Э" => "1", "Ю" => "1", "Я" => "1",
            "." => "1", ";" => "1", "," => "1", "(" => "1", ")" => "1",
            "=" => "1", "+" => "1", "-" => "1", "|" => "1",
            "_" => "1",
            "&" => "1", "$" => "1", "@" => "1", "#" => "1",
            "!" => "1", "%" => "1", "^" => "1", "*" => "1", "?" => "1",
            "0" => "1", "1" => "1", "2" => "1", "3" => "1", "4" => "1",
            "5" => "1", "6" => "1", "7" => "1", "8" => "1", "9" => "1"
        );

        $s = $this->winToUtf8($s);

        return (isset($table[$s]) && $table[$s] === "1") ? $s : ' ';
    }

    function checkType($arr, $ppn, $ppp) {
        $arr[$ppp] = str_replace(',', '.', $arr[$ppp]);
        $ret       = (is_numeric($arr[$ppp]) && (number_format($arr[$ppp], 4, '.', '') > 0) && (trim($arr[$ppn]) != '')) ? 'PRODUCT' : false;

        if ($this->debbuger == 1) {
            echo 'checkType<br><br>';
            echo '<pre>';
            print_r($arr);
            echo '</pre>';
            echo '<br>' . $this->checkMetod . '<br>';
            echo $arr[$ppp] . ' => ' . number_format($arr[$ppp], 4, '.', '') . '<br>';
            echo number_format($arr[$ppp], 4, '.', '') . '>0 and ' . trim($arr[$ppn]) . "!=''</br>";
            echo $ret . '<br><br>';
        }

        return $ret;
    }

    //parsing csv files for update sklads
    function parceCSV() {
        $db = JFactory::getDbo();

        $_SESSION['import']['update']['update_status'] = '1';

        setVars('update_status', '1');
        setVars('update_status_name', 'Инициализация обновления');
        sleep(1);

        //get options from current price
        $sql = 'SELECT * FROM `#__import_sklads` WHERE `price_name`=\'' . $this->price_type . '\'';
        $db->setQuery($sql);
        $row = $db->LoadObject();

        $sklad                  = $row->sklad_name;
        $price_name             = $row->price_name;
        $position_category_name = $row->position_category_name;
        $position_product_name  = $row->position_product_name;
        $position_product_price = $row->position_product_price;
        $position_product_desk  = $row->position_product_s_desk;
        $clear_line             = $row->clear_line;
        $this->checkMetod       = $price_name;

        if (($sklad) and ($this->start_prod == 0)) {
            $_SESSION['import']['update']['update_status'] = '2';
            setVars('update_status', '2');
            setVars('update_status_name', "Снятие с публикации всех товаров склада $sklad");

            $sql = "UPDATE `#__virtuemart_products` SET 
                    `published` = 0 WHERE `product_sku` LIKE '%$sklad%'";
            if ($this->debbuger == 1) {
                echo $sql . '<br><br>';
            }

            $db->setQuery($sql);
            $db->execute();
        }

        $_SESSION['import']['update']['update_status'] = '3';
        setVars('update_status', '3');
        setVars('update_status_name', "Создание кэш-массива продуктов");

        $chars = array("А" => "а", "Б" => "б", "В" => "в", "Г" => "г", "Д" => "д", "Е" => "е", "Ё" => "ё", "Ж" => "ж",
            "З" => "з", "И" => "и", "Й" => "й", "К" => "к", "Л" => "л", "М" => "м", "Н" => "н", "О" => "о",
            "П" => "п", "Р" => "р", "С" => "с", "Т" => "т", "У" => "у", "Ф" => "ф", "Х" => "х", "Ц" => "ц", "Ч" => "ч",
            "Ш" => "ш", "Щ" => "щ", "Ь" => "ь", "Ы" => "ы", "Э" => "э", "Ю" => "ю", "Я" => "я",
            "A" => "a", "B" => "b", "C" => "c", "D" => "d", "E" => "e", "F" => "f", "G" => "g", "H" => "h",
            "I" => "i", "J" => "j", "K" => "k", "L" => "l", "M" => "m", "N" => "n", "O" => "o", "P" => "p",
            "Q" => "q", "R" => "r", "S" => "s", "T" => "t", "U" => "u", "V" => "v", "W" => "w",
            "X" => "x", "Y" => "y", "Z" => "z");

        $sql = 'SELECT virtuemart_product_id, product_name FROM `#__virtuemart_products_ru_ru`';
        $db->setQuery($sql);

        $rows      = $db->loadObjectList();
        $blacklist = array(' ', ',', '.', '+', '-', '&', '*', '%', '?', '=', '/', '>', '<', ':', '@', '®');
        $hash      = array();
        foreach ($rows as $row) {
            $product_id_temp = $row->virtuemart_product_id;
            $product_name    = strtr($row->product_name, $chars);

            $nm = str_ireplace('z', '', str_replace($blacklist, '', $product_name));

            $hash[$nm] = $product_id_temp;
        }

        if ($this->debbuger == 1) {
            echo '<pre>';
            print_r($hash);
            echo '</pre>';
        }

        if ((file_exists($this->filepath)) and (trim($this->file) != '')) {
            $_SESSION['import']['update']['update_status'] = '4';
            setVars('update_status', '4');
            setVars('update_status_name', 'Чтение файла импорта ' . $this->file);
            setVars('works_products_time', 0);
            sleep(1);

            if ($this->debbuger == 1) {
                echo 'read file - ' . $this->filepath . '<br>';
            }

            $file_array_temp = file($this->filepath);

            $_SESSION['import']['update']['count_products'] = 0;
            if ($this->start_prod == 0) {
                setVars('count_products', '0');
            }

            for ($i = 0; $i < count($file_array_temp); $i++) {
                if ($i < $clear_line) {
                    $file_array_temp[$i] = '';
                } else {
                    $file_array_temp[$i] = str_replace("<", "-=", $file_array_temp[$i]);
                    $file_array_temp[$i] = str_replace(">", "=-", $file_array_temp[$i]);

                    $temp = '';
                    for ($j = 0; $j < strlen($file_array_temp[$i]); $j++) {
                        $temp .= $this->checkWhite($file_array_temp[$i][$j]);
                    }

                    $file_array[$i] = ($temp) ? $temp : '';

                    $file_array[$i] = str_replace("-=", "<", $file_array[$i]);
                    $file_array[$i] = str_replace("=-", ">", $file_array[$i]);
                }
            }

            if ($this->debbuger == 1) {
                echo '<pre>';
                print_r($file_array);
                echo '</pre>';
            }

            $_SESSION['import']['update']['count_products'] = $i;
            if ($this->start_prod == 0) {
                setVars('count_products', $i);
            }
            $_SESSION['import']['update']['works_products'] = 0;
            if ($this->start_prod == 0) {
                setVars('works_products', '0');
            }

            $num_category = 4;
            $product_id   = 0;

            $_SESSION['import']['update']['update_status'] = '5';
            setVars('update_status', '5');
            setVars('update_status_name', 'Обновление начато, товаров обновить ' . $i);

            $nadbavka = 0;
            $z        = 0;

            foreach ($file_array as $k => $v) {
                $z++;

                if ($this->start_prod > $z)
                    continue;
                $_SESSION['import']['update']['works_products'] = $z;
                setVars('works_products', $z);
                setVars('works_products_time', time());

                $arr_value = explode(';', $v);

                $arr    = explode(' ', $arr_value[$position_category_name]);
                $string = '';
                $sep    = '';
                for ($i = 0; $i < count($arr); $i++) {
                    $arr[$i] = trim($arr[$i]);

                    if ($arr[$i] != '') {
                        $string.=$sep . $arr[$i];
                        $sep = ' ';
                    }
                }

                $arr_value[$position_category_name] = $string;

                $arr_value[$position_product_price] = str_replace(' ', '', trim($arr_value[$position_product_price]));
                $arr_value[$position_product_price] = trim(str_replace('$', '', $arr_value[$position_product_price]));

                if (isset($arr_value[10]) && $arr_value[10] > 0)
                    $nadbavka = $arr_value[10];

                if ($this->checkType($arr_value, $position_product_name, $position_product_price) == 'PRODUCT') {
                    $arr_value[$position_product_name] = str_replace('/', ' ', $arr_value[$position_product_name]);
                    $arr_value[$position_product_name] = str_replace("<", "", $arr_value[$position_product_name]);
                    $arr_value[$position_product_name] = str_replace(">", "", $arr_value[$position_product_name]);

                    $arr    = explode(' ', $arr_value[$position_product_name]);
                    $string = '';
                    $sep    = '';
                    for ($i = 0; $i < count($arr); $i++) {
                        $arr[$i] = trim($arr[$i]);

                        if ($arr[$i] != '') {
                            $string.=$sep . $arr[$i];
                            $sep = ' ';
                        }
                    }

                    $arr_value[$position_product_name] = $string;

                    $prod_temp = str_replace($blacklist, '', $arr_value[$position_product_name]);
                    $prod_temp = str_ireplace('z', '', $prod_temp);
                    $prod_temp = strtr($prod_temp, $chars);

                    $product_id = 0;
                    if (isset($hash[$prod_temp])) {
                        $product_id = $hash[$prod_temp];
                    }
                    if ($this->debbuger == 1) {
                        echo $product_id . ' - ' . $prod_temp . '<br>';
                    }

                    $arr_value[$position_product_price] = trim(str_replace('USD', '', $arr_value[$position_product_price]));
                    $arr_value[$position_product_price] = trim(str_replace(',', '.', $arr_value[$position_product_price]));

                    if (isset($arr_value[$position_product_desk]) && strlen($arr_value[$position_product_desk]) < 6) {
                        $arr_value[$position_product_desk] = '';
                    }
                    $arr_value[$position_product_price] = $this->getPercent($arr_value[$position_product_price]);

                    $product_name  = $arr_value[$position_product_name];
                    $product_price = $arr_value[$position_product_price];
                    $product_desc  = (isset($arr_value[$position_product_desk])) ? $arr_value[$position_product_desk] : null;

                    $sql        = 'SELECT virtuemart_product_id '
                            . 'FROM #__virtuemart_products_ru_ru '
                            . 'WHERE product_name = \'' . $product_name . '\'';
                    $db->setQuery($sql);
                    $product_id = $db->loadResult();

                    $category_id = 0;
                    if ($product_id > 0) {
                        $sql = 'SELECT virtuemart_category_id '
                                . 'FROM #__virtuemart_product_categories '
                                . 'WHERE virtuemart_product_id = ' . $product_id;

                        $db->setQuery($sql);
                        $category_id = $db->loadResult();
                    }

                    $set_category_id = ($category_id > 0) ? $category_id : $num_category;

                    $data = $this->getProductTemplate(
                            $product_id, $sklad . $product_name, $product_name, $product_price, $set_category_id, $product_desc
                    );

                    vRequest::setVar(JSession::getFormToken(), 1);

                    $model = VmModel::getModel('product');
                    $id    = $model->store($data);

                    $this->setProductSku($id, $sklad . $id);
                }
            }
            $_SESSION['import']['update']['update_status'] = '6';
            setVars('update_status', '6');
            setVars('update_status_name', 'Завершение обновления');
            sleep(1);

            $_SESSION['import']['update']['update_status'] = '100';
            setVars('update_status', '100');

            //очистка временных переменных
            setVars('works_products', 0);
            setVars('count_products', 0);
            setVars('update_status_name', '');
            setVars('works_products_time', 0);
        }
    }

    function moveFile() {
        if ($this->debbuger == 1)
            echo 'moveFile<br>';
        if (file_exists($this->filepath)) {
            if ($this->debbuger == 1)
                echo 'moveFile checkOK<br>';
            $year     = date("Y");
            $new_name = date("d.m.Y") . '_' . time() . '.csv';
            $arhiv    = ($this->file_directory_arhiv);
            if (file_exists($arhiv)) {
                if ($this->debbuger == 1)
                    echo 'moveFile arhiv exists<br>';
                $catalog = $arhiv . 'import_arhiv_' . $year;
                if (!((file_exists($catalog)) and (is_dir($catalog)))) {
                    mkdir($catalog);
                }
                $filepath = $this->filepath;
                unlink($filepath);
            }
        }
    }

    public function setProductSku($product_id, $product_sku) {
        $db = JFactory::getDbo();
        $db->setQuery("UPDATE #__virtuemart_products "
                . "SET product_sku = '$product_sku' "
                . "WHERE virtuemart_product_id = $product_id");
        $db->execute();
    }

    public function getProductTemplate($product_id, $sku, $name, $price, $category_id, $desc) {
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
                'product_currency'            => array(202),
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
        );

        return $product;
    }

}
