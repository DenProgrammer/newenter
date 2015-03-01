<?php

// Check to ensure this file is included in Joomla! йцукен
defined('_JEXEC') or die('Restricted access');

class ImportModelImport {

    var $arr = '';
    var $upload_images            = '1';
    var $upload_images_path       = '';
    var $create_small_images      = true;
    var $size_main_images_width   = '300';
    var $size_main_images_height  = '300';
    var $size_small_images_width  = '100';
    var $size_small_images_height = '100';
    var $separator_rows           = '^';
    var $separator_cols           = '~';
    var $data                     = '';
    var $img                      = '';
    var $error;
    var $debbuger                 = 0;
    var $show_error               = 0;

    function ImportModelImport($data) {
        $this->arr = $data;

        $config                         = getConfig($_SESSION['import']['component_id']);
        $this->upload_images            = $config['UPLOAD_IMAGES'];
        $this->upload_images_path       = $config['UPLOAD_IMAGES_PATH'];
        $this->create_small_images      = $config['CREATE_SMALL_IMAGES'];
        $this->size_main_images_width   = $config['SIZE_MAIN_IMAGES_WIDTH'];
        $this->size_main_images_height  = $config['SIZE_MAIN_IMAGES_HEIGHT'];
        $this->size_small_images_width  = $config['SIZE_SMALL_IMAGES_WIDTH'];
        $this->size_small_images_height = $config['SIZE_SMALL_IMAGES_HEIGHT'];
        $this->debbuger                 = $config['DEBBUGER'];
        $this->show_error               = $config['SHOW_ERROR'];

        if ($this->debbuger == 1)
            echo 'ImportModelImport<br>';
    }

    function deleteAll() {
        if ($this->debbuger == 1)
            echo 'deleteAll<br>';

        global $database;

        mysql_query('TRUNCATE TABLE jos_vm_category');
        mysql_query('TRUNCATE TABLE jos_vm_category_xref');
        mysql_query('TRUNCATE TABLE jos_vm_product_type');
        mysql_query('TRUNCATE TABLE jos_vm_product_discount');
        mysql_query('TRUNCATE TABLE jos_vm_product');
        mysql_query('TRUNCATE TABLE jos_vm_product_category_xref');
        mysql_query('TRUNCATE TABLE jos_vm_product_mf_xref');
        mysql_query('TRUNCATE TABLE jos_vm_product_price');
    }

    function insSql($sql) {
        global $database;
        mysql_query($sql);
        $ins_id = mysql_insert_id();

        return $ins_id;
    }

    function checkSql($sql, $pole) {
        $id = 0;

        global $database;
        $rs  = mysql_query($sql);
        while ($row = mysql_fetch_object($rs)) {
            $id = $row->$pole;
        }

        return $id;
    }

    function setTax($tax_sum, $tax_nad, $tax_select) {
        global $database;

        mysql_query('TRUNCATE TABLE jos_yaros_import_xref');

        for ($i = 1; $i < 21; $i++) {
            if (($tax_sum[$i]) and ($tax_nad[$i])) {
                $sql = 'INSERT INTO jos_yaros_import_xref (sum,sum_tax,tax) VALUES (\'' . $tax_sum[$i] . '\',\'' . $tax_nad[$i] . '\',\'' . $tax_select[$i] . '\')';
                //echo $sql.'<br>';
                mysql_query($sql);
            }
        }
    }

    function querySql($sql) {
        $id = 0;

        global $database;
        $rs = mysql_query($sql);

        return $rs;
    }

}
