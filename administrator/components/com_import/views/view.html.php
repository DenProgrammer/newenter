<?php

/* * jhjgаришо
 * @version		$Id: view.html.php 19343 2010-11-03 18:12:02Z ian $
 * @package		Joomla
 * @subpackage	Config
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

jimport('joomla.application.component.view');

if (JRequest::getVar('view') == 'clearimages') {
    include_once 'clearimages/view.html.php';
    return;
}

$tpl  = JRequest::getVar('tpl');
$ajax = JRequest::getVar('ajax');
$db   = JFactory::getDBO();

if ($ajax) {
    $tpl = 'ajax';
}

switch (JRequest::getVar('ajax')) {
    case 'getsumstring': {
            require_once('./components/com_import/helpers/string.php');
            $summa          = JRequest::getInt('summa');
            $NumberAnalyser = new NumberAnaliz();
            $totalstr       = $NumberAnalyser->CurrencyToText($summa, "KGS");
            echo $totalstr;
            break;
        }
    case 'saveChange'://обновление данных о товаре в заказе
        {
            $db = JFactory::getDBO();

            $order_item_id = (int) $_POST['order_item_id'];
            $order_id      = (int) $_POST['order_id'];
            $itemcount     = (float) $_POST['itemcount'];
            $itemprice     = (float) $_POST['itemprice'];
            $itemname      = (string) $_POST['itemname'];
            $itemsku       = (string) $_POST['itemsku'];
            $shopper_info  = (string) $_POST['shopper_info'];
            $nrt           = (float) $_POST['nrt'];
            $realprice     = ($nrt > 0) ? round($itemprice / (1 + $nrt / 100)) : $itemprice;

            $itemname = str_replace(' ', '+', $itemname);
            $itemname = base64_decode($itemname);
            $itemname = htmlentities($itemname);
            $itemname = str_replace('\\', '&#' . ord('\\') . ';', $itemname);

            $sql = "UPDATE `#__vm_orders` 
                    SET `shopper_info`='$shopper_info', `nrt`='$nrt'
                    WHERE `order_id`=$order_id";
            $db->setQuery($sql);
            $db->query();

            $sql = "UPDATE `#__vm_order_item` 
                    SET `order_item_name`='$itemname', `product_quantity`='$itemcount', 
                    `product_item_price`='$realprice', `product_final_price`='$realprice' ";
            if ($itemsku) {
                $sql .= ", `order_item_sku`='$itemsku'";
            }
            $sql .= "WHERE `order_item_id`=$order_item_id";
            $db->setQuery($sql);
            $db->query();

            break;
        }
    case 'saveJson'://обновление данных о товаре в заказе
        {
            $db = JFactory::getDBO();

            $json     = $_POST['strjson'];
            $nrt      = (float) $_POST['nrt'];
            $order_id = (float) $_POST['order_id'];

            $sql = "UPDATE `#__vm_orders` SET `nrt`='$nrt' WHERE `order_id`=$order_id";
            $db->setQuery($sql);
            $db->query();

            $obj = json_decode($json);

            foreach ($obj as $v) {
                $order_item_id = (int) $v->id;
                $itemcount     = (float) $v->count;
                $itemprice     = (float) $v->price;
                $itemname      = (string) $v->name;
                $itemsku       = (string) $v->sku;
                $realprice     = ($nrt > 0) ? round($itemprice / (1 + $nrt / 100)) : $itemprice;

                $itemname = str_replace('*AMPERSAND*', '&', $itemname);

                $sql               = "SELECT `product_attribute` FROM `#__vm_order_item` WHERE `order_item_id`=$order_item_id";
                $db->setQuery($sql);
                $product_attribute = $db->LoadResult();
                $t1                = explode(';', $product_attribute);
                if ($t1)
                    foreach ($t1 as $item) {
                        $t2       = explode('=', $item);
                        $k        = trim($t2[0]);
                        $val      = trim($t2[1]);
                        if ($k)
                            $attr[$k] = $val;
                    }

                $sn        = ($v->param->sn) ? $v->param->sn : $attr['sn'];
                $garantiya = ($v->param->garantiya) ? $v->param->garantiya : $attr['garantiya'];

                $product_attribute = "sn=$sn;\r\ngarantiya=$garantiya;\r\n";

                $sql = "UPDATE `#__vm_order_item` 
                        SET `order_item_name`='$itemname', 
                                `product_quantity`='$itemcount', 
                                `order_item_sku`='$itemsku', 
                                `product_item_price`='$realprice', 
                                `product_final_price`='$realprice', 
                                `product_attribute`='$product_attribute'
                        WHERE `order_item_id`=$order_item_id";
                $db->setQuery($sql);
                $db->query();
            }
            break;
        }
    case 'saveJsonNew'://обновление данных о товаре в заказе
        {
            $json = $_POST['strjson'];

            $obj = json_decode($json);

            $nrt      = (float) $obj->nrt;
            $order_id = (float) $obj->order_id;

            $sql = "UPDATE `#__vm_orders` SET `nrt`='$nrt' WHERE `order_id`=$order_id";
            $db->setQuery($sql);
            $db->query();


            foreach ($obj->items as $v) {
                $orderitemid = (int) $v->id;
                $itemcount   = (float) $v->count;
                $itemprice   = (float) $v->price;
                $itemname    = (string) $v->name;
                $itemsku     = (string) $v->sku;
                $realprice   = ($nrt > 0) ? round($itemprice / (1 + $nrt / 100)) : $itemprice;

                $itemname = str_replace('*AMPERSAND*', '&', $itemname);

                $sql               = "SELECT `product_attribute` FROM `#__vm_order_item` WHERE `order_item_id`=$orderitemid";
                $db->setQuery($sql);
                $product_attribute = $db->LoadResult();
                $t1                = explode(';', $product_attribute);
                if ($t1)
                    foreach ($t1 as $item) {
                        $t2       = explode('=', $item);
                        $k        = trim($t2[0]);
                        $val      = trim($t2[1]);
                        if ($k)
                            $attr[$k] = $val;
                    }

                $sn        = ($v->sn) ? $v->sn : $attr['sn'];
                $garantiya = ($v->g_ya) ? $v->g_ya : $attr['garantiya'];

                $product_attribute = "sn=$sn;\r\ngarantiya=$garantiya;\r\n";

                $sql = "UPDATE `#__vm_order_item` 
                        SET `order_item_name`='$itemname', 
                                `product_quantity`='$itemcount', 
                                `order_item_sku`='$itemsku', 
                                `product_item_price`='$realprice', 
                                `product_final_price`='$realprice', 
                                `product_attribute`='$product_attribute'
                        WHERE `order_item_id`=$orderitemid";
                $db->setQuery($sql);
                $db->query();
            }
            break;
        }
    case 'saveVendor'://обновление данных о товаре в заказе
        {
            $order_id       = (int) $_POST['order_id'];
            $vendor_info_id = (int) $_POST['vendor_info_id'];

            $sql = "UPDATE `#__vm_orders` 
                    SET `vendor_info_id`='$vendor_info_id'
                    WHERE `order_id`=$order_id";
            $db->setQuery($sql);
            $db->query();

            break;
        }
    case 'setparamfororderitem': {
            $orditemid = JRequest::getInt('orditemid');
            $pkey      = JRequest::getVar('pkey');
            $pvalue    = JRequest::getVar('pvalue');

            $sql = "SELECT `product_attribute` FROM `#__vm_order_item` WHERE `order_item_id`=$orditemid";
            $db->setQuery($sql);

            $product_attribute = $db->LoadResult();

            $t1 = explode(';', $product_attribute);
            if ($t1) {
                foreach ($t1 as $item) {
                    $t2 = explode('=', $item);
                    $k  = trim($t2[0]);
                    $v  = trim($t2[1]);
                    if ($k) {
                        $attr[$k] = $v;
                    }
                }
            }

            $attr[$pkey]       = $pvalue;
            $product_attribute = '';
            foreach ($attr as $k => $v) {
                $product_attribute .= "$k=$v;\r\n";
            }

            $sql = "UPDATE `#__vm_order_item` SET `product_attribute`='$product_attribute' WHERE `order_item_id`=$orditemid";
            $db->setQuery($sql);
            $db->query();
            echo $sql;
        }
    case 'showExcelDocument': {
            require_once './components/com_import/helpers/PHPExcel.php';
            require_once './components/com_import/helpers/PHPExcel/IOFactory.php';
            require_once('./components/com_import/helpers/string.php');

            $objPHPExcel = new PHPExcel();
            $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
                    ->setLastModifiedBy("Maarten Balliauw")
                    ->setTitle("Office 2007 XLSX Test Document")
                    ->setSubject("Office 2007 XLSX Test Document")
                    ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
                    ->setKeywords("office 2007 openxml php")
                    ->setCategory("Test result file");
            switch ($_GET['type']) {
                case 'schetfactura': {
                        $vendor = (int) JRequest::getInt('vendor');

                        //получение номера счет фактуры
                        $sql             = "SELECT `value` FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $schetfacturanum = (int) $db->LoadResult();
                        $schetfacturanum++;

                        if ($schetfacturanum > 1000) {
                            $schetfacturanum = 1;
                        }

                        $sql = "DELETE FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $db->query();
                        $sql = "INSERT INTO `#__conf` (`key`,`value`) VALUES ('schetfacturanum','$schetfacturanum')";
                        $db->setQuery($sql);
                        $db->query();

                        //получение информации о заказе
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql    = "SELECT * FROM `#__content` WHERE `catid`=$vendor_info_id AND `title`='schfactura' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                        $db->setQuery($sql);
                        $vendor = $db->LoadObject();
                        $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $vendor->introtext . '</div>';
                        $vendorinfo2 .= '<div class="cond cond' . $row->id . '">' . $vendor->fulltext . '</div>';

                        $sh_br_count  = (int) substr_count($shopper_info, '<br>');
                        if (!$sh_br_count > 0)
                            $sh_br_count  = 1;
                        $shopper_info = str_replace('<br>', chr(10), $shopper_info);

                        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                        if (!$vr_br_count > 0)
                            $vr_br_count = 1;
                        $vendorinfo  = strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo));

                        // Create a first sheet
                        $objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(20 * $vr_br_count);
                        $objPHPExcel->getActiveSheet()->getRowDimension(3)->setRowHeight(20 * $sh_br_count);
                        $objPHPExcel->setActiveSheetIndex(0);
                        $objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Счет-фактура $schetfacturanum");
                        $objPHPExcel->getActiveSheet()->mergeCells('A2:B2')->setCellValue('A2', "Продавец");
                        $objPHPExcel->getActiveSheet()->mergeCells('C2:F2')->setCellValue('C2', $vendorinfo)->getStyle('C2')->getAlignment()->setWrapText(true);
                        $objPHPExcel->getActiveSheet()->mergeCells('A3:B3')->setCellValue('A3', "Покупатель");
                        $objPHPExcel->getActiveSheet()->mergeCells('C3:F3')->setCellValue('C3', $shopper_info)->getStyle('C3')->getAlignment()->setWrapText(true);
                        $objPHPExcel->getActiveSheet()->setCellValue('A4', "");

                        $objPHPExcel->getActiveSheet()->setCellValue('A5', "№");
                        $objPHPExcel->getActiveSheet()->mergeCells('B5:C5')->setCellValue('B5', "Наименование");
                        $objPHPExcel->getActiveSheet()->setCellValue('D5', "Кол-во");
                        $objPHPExcel->getActiveSheet()->setCellValue('E5', "Цена");
                        $objPHPExcel->getActiveSheet()->setCellValue('F5', "Всего");

                        //получение позиций в заказе
                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        $z         = 5;
                        foreach ($orderitem as $row) {
                            $i++;
                            $z++;
                            $order_item_id = $row->order_item_id;
                            $itemname      = $row->order_item_name;
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $i);
                            $objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':C' . $z)->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('C' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemcount);
                            $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemprice);
                            $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $itemitogo);

                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(4);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
                        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $total);
                        $z++;
                        $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
                        $objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

                        $z++;
                        $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $orderdate);
                        $z += 2;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, "                   м.п.                                 Руководитель                             гл. Бухгалтер");

                        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
                        $objPHPExcel->setActiveSheetIndex(0);

                        // Save Excel 2007 file
                        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
                        $objWriter->save('../images/docs/schetfactura_' . $order->order_id . '.xlsx');
                        echo 'http://enter.kg/images/docs/schetfactura_' . $order->order_id . '.xlsx';

                        break;
                    }
                case 'nakladnaya': {
                        $vendor   = (int) JRequest::getInt('vendor');
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql    = "SELECT * FROM `#__content` WHERE `catid`=$vendor_info_id AND `title`='nakladnaya' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                        $db->setQuery($sql);
                        $vendor = $db->LoadObject();
                        $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $vendor->introtext . '</div>';
                        $vendorinfo2 .= '<div class="cond cond' . $row->id . '">' . $vendor->fulltext . '</div>';

                        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                        if (!$vr_br_count > 0)
                            $vr_br_count = 1;
                        $vendorinfo  = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

                        // Create a first sheet
                        $objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(22 * $vr_br_count);
                        $objPHPExcel->setActiveSheetIndex(0);

                        $center = array(
                            'alignment' => array(
                                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
                            )
                        );
                        $objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Накладная");
                        $objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

                        $objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
                        $objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
                        $objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
                        $objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
                        $objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        $z         = 3;
                        foreach ($orderitem as $row) {
                            $i++;
                            $z++;
                            $itemname      = $row->order_item_name;
                            $order_item_id = $row->order_item_id;
                            $itemsku       = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                            $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                            $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                            $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                            $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/schetfactura.htm';

                        $arrkey   = array('%NOMER%', '%ITENROWS%', '%TOTAL%',
                            '%DATE%', '%TOTALSTR%', '%VENDORINFO%',
                            '%SHOPPER_INFO%', '%ORDERID%', '%NRT%',
                            '%ORDERDATE%', '%NOWDATE%'
                        );
                        $arrvalue = array($schetfacturanum, $itemrows, $total,
                            $date, $totalstr, $vendorinfo,
                            $shopper_info, $order->order_id, $order->nrt,
                            $orderdate, $nowdate);


                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
                        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
                        $z++;
                        $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
                        $objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

                        $z += 2;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, "                  Отпустил_____________________                     Принял________________________    ");

                        $z += 2;
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
                        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
                        $objPHPExcel->setActiveSheetIndex(0);

                        // Save Excel 2007 file
                        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
                        $objWriter->save('../images/docs/schetfactura_' . $order->order_id . '.xlsx');
                        echo 'http://enter.kg/images/docs/schetfactura_' . $order->order_id . '.xlsx';


                        break;
                    }
                case 'compred': {
                        $vendor   = (int) JRequest::getInt('vendor');
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql    = "SELECT * FROM `#__content` WHERE `catid`=$vendor_info_id AND `title`='compred' LIMIT 1";
                        $db->setQuery($sql);
                        $vendor = $db->LoadObject();
                        $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $vendor->introtext . '</div>';
                        $vendorinfo2 .= '<div class="cond cond' . $row->id . '">' . $vendor->fulltext . '</div>';

                        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                        if (!$vr_br_count > 0)
                            $vr_br_count = 1;
                        $vendorinfo  = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

                        // Create a first sheet
                        $objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(20 * $vr_br_count);
                        $objPHPExcel->setActiveSheetIndex(0);

                        $center = array(
                            'alignment' => array(
                                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
                            )
                        );
                        $objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Коммерческое предложение");
                        $objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

                        $objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
                        $objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
                        $objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
                        $objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
                        $objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        $z         = 3;
                        foreach ($orderitem as $row) {
                            $i++;
                            $z++;
                            $itemname      = $row->order_item_name;
                            $order_item_id = $row->order_item_id;
                            $itemsku       = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                            $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                            $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                            $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                            $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
                        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
                        $z++;
                        $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
                        $objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

                        $z += 2;
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, trim(strip_tags($vendorinfo2)))->getStyle('A' . $z)->getAlignment()->setWrapText(true);
                        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
                        $objPHPExcel->setActiveSheetIndex(0);

                        // Save Excel 2007 file
                        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
                        $objWriter->save('../images/docs/compred_' . $order->order_id . '.xlsx');
                        echo 'http://enter.kg/images/docs/compred_' . $order->order_id . '.xlsx';


                        break;
                    }
                case 'schnaopl': {
                        $vendor   = (int) JRequest::getInt('vendor');
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql    = "SELECT * FROM `#__content` WHERE `catid`=$vendor_info_id AND `title`='schnaopl' LIMIT 1";
                        $db->setQuery($sql);
                        $vendor = $db->LoadObject();
                        $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $vendor->introtext . '</div>';
                        $vendorinfo2 .= '<div class="cond cond' . $row->id . '">' . str_replace('&nbsp;', ' ', $vendor->fulltext) . '</div>';

                        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                        if (!$vr_br_count > 0)
                            $vr_br_count = 1;
                        $vendorinfo  = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

                        // Create a first sheet
                        $objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(20 * $vr_br_count);
                        $objPHPExcel->setActiveSheetIndex(0);

                        $center = array(
                            'alignment' => array(
                                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
                            )
                        );
                        $objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Счет на оплату");
                        $objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

                        $objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
                        $objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
                        $objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
                        $objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
                        $objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        $z         = 3;
                        foreach ($orderitem as $row) {
                            $i++;
                            $z++;
                            $itemname      = $row->order_item_name;
                            $order_item_id = $row->order_item_id;
                            $itemsku       = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                            $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                            $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                            $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                            $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
                        $objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
                        $z++;
                        $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
                        $objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

                        $z += 2;
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
                        $z++;
                        $objPHPExcel->getActiveSheet()->getRowDimension($z)->setRowHeight(80);
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, trim(strip_tags($vendorinfo2)))->getStyle('A' . $z)->getAlignment()->setWrapText(true);
                        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
                        $objPHPExcel->setActiveSheetIndex(0);

                        // Save Excel 2007 file
                        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
                        $objWriter->save('../images/docs/schnaopl_' . $order->order_id . '.xlsx');
                        echo 'http://enter.kg/images/docs/schnaopl_' . $order->order_id . '.xlsx';


                        break;
                    }
                case 'garantiya': {
                        $vendor   = (int) JRequest::getInt('vendor');
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов, из материалов в категории условия для счет фактуры, id=15
                        if ($vendor > 0) {
                            $sql = 'SELECT * FROM `#__content` WHERE `id`=' . $vendor;
                        } else {
                            $sql = 'SELECT * FROM `#__content` WHERE `catid`=15 ORDER BY `ordering` LIMIT 1';
                        }
                        $db->setQuery($sql);
                        $vendors    = $db->LoadObject();
                        $vendorinfo = $vendors->introtext;

                        $sh_br_count  = (int) substr_count($shopper_info, '<br>');
                        if (!$sh_br_count > 0)
                            $sh_br_count  = 1;
                        $shopper_info = str_replace('<br>', chr(10), $shopper_info);

                        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                        if (!$vr_br_count > 0)
                            $vr_br_count = 1;
                        $vendorinfo  = strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo));

                        // Create a first sheet
                        $objPHPExcel->setActiveSheetIndex(0);
                        $objPHPExcel->getActiveSheet()->mergeCells('A1:G1')->setCellValue('A1', "Гарантийный талон");

                        $objPHPExcel->getActiveSheet()->setCellValue('A2', "Кол-во");
                        $objPHPExcel->getActiveSheet()->setCellValue('B2', "Наименование");
                        $objPHPExcel->getActiveSheet()->setCellValue('C2', "Артикул");
                        $objPHPExcel->getActiveSheet()->setCellValue('D2', "Цена");
                        $objPHPExcel->getActiveSheet()->setCellValue('E2', "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('F2', "Серийник");
                        $objPHPExcel->getActiveSheet()->setCellValue('G2', "Гарантия");

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        $z         = 2;
                        foreach ($orderitem as $row) {
                            $i++;
                            $z++;
                            $itemname      = $row->order_item_name;
                            $order_item_id = $row->order_item_id;
                            $itemsku       = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';
                            $sn        = str_replace('<br>', chr(10), $attr['sn']);

                            $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                            $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                            $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                            $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                            $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $sn)->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->setCellValue('G' . $z, $garantiya);

                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                            $objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
                        $objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(10);
                        $objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
                        $objPHPExcel->getActiveSheet()->getStyle('A1:G1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A2:G2')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));


                        $objPHPExcel->getActiveSheet()->getStyle('A2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('A2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('B2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('B2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('C2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('C2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('D2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('D2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('E2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('E2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('F2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('F2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

                        $objPHPExcel->getActiveSheet()->getStyle('G2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
                        $objPHPExcel->getActiveSheet()->getStyle('G2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));


                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
                        $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
                        $z++;
                        $objPHPExcel->getActiveSheet()->mergeCells('F' . $z . ':G' . $z)->setCellValue('F' . $z, $orderdate);

                        if ($i == 1) {
                            $db       = JFactory::getDBO();
                            //описание гарантии
                            $sql      = 'SELECT `fulltext` FROM `#__content` WHERE `id`=65';
                            $db->setQuery($sql);
                            $material = $db->LoadResult();
                            $material = trim(strip_tags(str_replace(array('src="', '&nbsp;'), array('src="../', ' '), $material)));

                            $z++;
                            $objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':G' . $z)->setCellValue('A' . $z, $material)->getStyle('A' . $z)->getAlignment()->setWrapText(true);
                            $objPHPExcel->getActiveSheet()->getRowDimension($z)->setRowHeight(900);
                        }

                        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
                        $objPHPExcel->setActiveSheetIndex(0);

                        // Save Excel 2007 file
                        $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
                        $objWriter->save('../images/docs/garantiya_' . $order->order_id . '.xlsx');
                        echo 'http://enter.kg/images/docs/garantiya_' . $order->order_id . '.xlsx';


                        break;
                    }
            }
            break;
        }
    case 'showDocument': {
            require_once('./components/com_import/helpers/string.php');
            switch (JRequest::getVar('type')) {
                case 'schetfactura': {
                        //получение номера счет фактуры
                        $sql             = "SELECT `value` FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $schetfacturanum = (int) $db->LoadResult();
                        $schetfacturanum++;

                        if ($schetfacturanum > 1000) {
                            $schetfacturanum = 1;
                        }

                        $sql = "DELETE FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $db->query();
                        $sql = "INSERT INTO `#__conf` (`key`,`value`) VALUES ('schetfacturanum','$schetfacturanum')";
                        $db->setQuery($sql);
                        $db->query();

                        //получение информации о заказе
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql        = 'SELECT * FROM `#__categories` WHERE `id` IN (18,19,20,21)';
                        $db->setQuery($sql);
                        $rows       = $db->LoadObjectList();
                        $vendorinfo = '';
                        $vendorlist = '<select id="vendorselect" class="editelement">';
                        foreach ($rows as $row) {
                            $catid = $row->id;

                            $sql  = "SELECT * FROM `#__content` WHERE `catid`=$catid AND `title`='schfactura' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                            $db->setQuery($sql);
                            $item = $db->LoadObject();

                            $sel = ($vendor_info_id == $row->id) ? 'selected' : '';
                            $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                            $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $item->introtext . '</div>';
                            $condinfo .= '<div class="cond cond' . $row->id . '">' . $item->fulltext . '</div>';
                        }

                        $vendorlist .= '</select>';
                        $vendorinfo = $vendorlist . $vendorinfo;

                        //получение позиций в заказе
                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        foreach ($orderitem as $row) {
                            $i++;
                            $order_item_id = $row->order_item_id;
                            $itemname      = $row->order_item_name;
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $itemrows .="<tr id='row$i' rel='$order_item_id' class='itemrow' height=20 style='height:15.0pt'>
                                            <td height=20 class=xl68 align=right style='height:15.0pt;border:solid 1px black;text-align:center;' x:num>1</td>
                                            <td colspan=7 class=xl71 style='border:solid 1px black;text-align:left;'>
                                                    <div class='itemname changeelement'>$itemname</div>
                                                    <input size='67' id='itemnametext$i' class='itemnametext editelement' type='text'/>
                                            </td>
                                            <td class=xl68 style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemcount changeelement'>$itemcount</div>
                                                    <input onkeyup='resumm($i)' size='2' id='itemcounttext$i' class='itemcounttext editelement' type='text'/>
                                            </td>
                                            <td class=xl68 style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemprice changeelement'>$itemprice</div>
                                                    <input onkeyup='resumm($i)' size='2'id='itempricetext$i' class='itempricetext editelement' type='text'/>
                                            </td>
                                            <td style='border:solid 1px black;text-align:right;'><div id='itemitogo$i' class='itemitogo'>$itemitogo</div></td>
                                        </tr>";
                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/schetfactura.htm';

                        $arrkey   = array('%NOMER%', '%ITENROWS%', '%TOTAL%',
                            '%DATE%', '%TOTALSTR%', '%VENDORINFO%',
                            '%SHOPPER_INFO%', '%ORDERID%', '%NRT%',
                            '%ORDERDATE%', '%NOWDATE%'
                        );
                        $arrvalue = array($schetfacturanum, $itemrows, $total,
                            $date, $totalstr, $vendorinfo,
                            $shopper_info, $order->order_id, $order->nrt,
                            $nowdate, $nowdate);

                        $file = implode(file($tmpl));
                        $file = str_replace($arrkey, $arrvalue, $file);

                        echo $file;

                        break;
                    }
                case 'nakladnaya': {
                        //получение номера счет фактуры
                        $sql             = "SELECT `value` FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $schetfacturanum = (int) $db->LoadResult();
                        $schetfacturanum++;

                        $sql = "DELETE FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $db->query();
                        $sql = "INSERT INTO `#__conf` (`key`,`value`) VALUES ('schetfacturanum','$schetfacturanum')";
                        $db->setQuery($sql);
                        $db->query();

                        //получение информации о заказе
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $nrt            = $order->nrt;
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql        = 'SELECT * FROM `#__categories` WHERE `id` IN (18,19,20,21)';
                        $db->setQuery($sql);
                        $rows       = $db->LoadObjectList();
                        $vendorinfo = '';
                        $vendorlist = '<select id="vendorselect" class="editelement">';
                        foreach ($rows as $row) {
                            $catid = $row->id;

                            $sql  = "SELECT * FROM `#__content` WHERE `catid`=$catid AND `title`='nakladnaya' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                            $db->setQuery($sql);
                            $item = $db->LoadObject();

                            $sel = ($vendor_info_id == $row->id) ? 'selected' : '';
                            $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                            $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $item->introtext . '</div>';
                            $condinfo .= '<div class="cond cond' . $row->id . '">' . $item->fulltext . '</div>';
                        }

                        $vendorlist .= '</select>';
                        $vendorinfo = $vendorlist . $vendorinfo;

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        foreach ($orderitem as $row) {
                            $i++;
                            $itemname      = $row->order_item_name;
                            $order_item_id = $row->order_item_id;
                            $itemsku       = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount     = $row->product_quantity;
                            $itemprice     = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo     = round($itemprice * $itemcount);

                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $itemrows .="<tr id='row$i' rel='$order_item_id' class='itemrow' style='mso-yfti-irow:1;height:15.0pt'>
                                            <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemcount changeelement'>$itemcount</div>
                                                    <input onkeyup='resumm($i)' size='2' id='itemcounttext$i' class='itemcounttext editelement' type='text'/>
                                            </td>
                                            <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemname changeelement'>$itemname</div>
                                                    <input size='67' id='itemnametext$i' class='itemnametext editelement' type='text'/>
                                            </td>
                                            <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemsku changeelement'>$itemsku</div>
                                                    <input size='10' id='itemskutext$i' class='itemskutext editelement' type='text'/>
                                            </td>
                                            <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemprice changeelement'>$itemprice</div>
                                                    <input onkeyup='resumm($i)' size='2'id='itempricetext$i' class='itempricetext editelement' type='text'/>
                                            </td>
                                            <td style='border:solid 1px black;text-align:right;'><div id='itemitogo$i' class='itemitogo'>$itemitogo</div></td>
                                            <td style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemgerantiya changeelement'>$garantiya</div>
                                                    <input size='5' id='itemgerantiyatext$i' class='itemgerantiyatext editelement' type='text'/>
                                            </td>
                                        </tr>";
                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/nakladnaya.htm';

                        $arrkey   = array('%NOMER%', '%ITENROWS%', '%TOTAL%',
                            '%DATE%', '%TOTALSTR%', '%VENDORINFO%',
                            '%ORDERDATE%', '%NOWDATE%', '%CONDINFO%',
                            '%ORDERID%', '%NRT%');
                        $arrvalue = array($schetfacturanum, $itemrows, $total,
                            $date, $totalstr, $vendorinfo,
                            $nowdate, $nowdate, $condinfo,
                            $order->order_id, $nrt);

                        $file = implode(file($tmpl));
                        $file = str_replace($arrkey, $arrvalue, $file);

                        echo $file;

                        break;
                    }
                case 'compred': {
                        //получение номера счет фактуры
                        $sql             = "SELECT `value` FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $schetfacturanum = (int) $db->LoadResult();
                        $schetfacturanum++;

                        $sql      = "DELETE FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $db->query();
                        $sql      = "INSERT INTO `#__conf` (`key`,`value`) VALUES ('schetfacturanum','$schetfacturanum')";
                        $db->setQuery($sql);
                        $db->query();
                        //получение информации о заказе
                        $order_id = $_GET['id'];
                        $date     = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql        = 'SELECT * FROM `#__categories` WHERE `id` IN (18,19,20,21)';
                        $db->setQuery($sql);
                        $rows       = $db->LoadObjectList();
                        $vendorinfo = '';
                        $vendorlist = '<select id="vendorselect" class="editelement">';
                        foreach ($rows as $row) {
                            $catid = $row->id;

                            $sql  = "SELECT * FROM `#__content` WHERE `catid`=$catid AND `title`='compred' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                            $db->setQuery($sql);
                            $item = $db->LoadObject();

                            $sel = ($vendor_info_id == $row->id) ? 'selected' : '';
                            $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                            $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $item->introtext . '</div>';
                            $condinfo .= '<div class="cond cond' . $row->id . '">' . $item->fulltext . '</div>';
                        }

                        $vendorlist .= '</select>';
                        $vendorinfo = $vendorlist . $vendorinfo;

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        foreach ($orderitem as $row) {
                            $i++;
                            $itemname          = $row->order_item_name;
                            $order_item_id     = $row->order_item_id;
                            $itemsku           = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount         = $row->product_quantity;
                            $itemprice         = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo         = round($itemprice * $itemcount);
                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $itemrows .="<tr id='row$i' rel='$order_item_id' class='itemrow' style='mso-yfti-irow:1;height:15.0pt'>
                                            <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemcount changeelement'>$itemcount</div>
                                                    <input onkeyup='resumm($i)' size='2' id='itemcounttext$i' class='itemcounttext editelement' type='text'/>
                                            </td>
                                            <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemname changeelement'>$itemname</div>
                                                    <input size='67' id='itemnametext$i' class='itemnametext editelement' type='text'/>
                                            </td>
                                            <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemsku changeelement'>$itemsku</div>
                                                    <input size='10' id='itemskutext$i' class='itemskutext editelement' type='text'/>
                                            </td>
                                            <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemprice changeelement'>$itemprice</div>
                                                    <input onkeyup='resumm($i)' size='2'id='itempricetext$i' class='itempricetext editelement' type='text'/>
                                            </td>
                                            <td width=71 style='border:solid 1px black;text-align:right;'><div id='itemitogo$i' class='itemitogo'>$itemitogo</div></td>
                                            <td style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemgerantiya changeelement'>$garantiya</div>
                                                    <input size='5' id='itemgerantiyatext$i' class='itemgerantiyatext editelement' type='text'/>
                                            </td>
                                        </tr>";
                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/compred.htm';

                        $arrkey   = array('%NOMER%', '%ITENROWS%', '%TOTAL%',
                            '%DATE%', '%TOTALSTR%', '%VENDORINFO%',
                            '%CONDINFO%', '%SHOPPER_INFO%', '%ORDERDATE%',
                            '%NOWDATE%', '%NRT%', '%ORDERID%');
                        $arrvalue = array($schetfacturanum, $itemrows, $total,
                            $date, $totalstr, $vendorinfo,
                            $condinfo, $shopper_info, $orderdate,
                            $nowdate, $nrt, $order->order_id);

                        $file = implode(file($tmpl));
                        $file = str_replace($arrkey, $arrvalue, $file);

                        echo $file;

                        break;
                    }
                case 'schnaopl': {
                        //получение номера счет фактуры
                        $sql             = "SELECT `value` FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $schetfacturanum = (int) $db->LoadResult();
                        $schetfacturanum++;

                        $sql      = "DELETE FROM `#__conf` WHERE `key`='schetfacturanum'";
                        $db->setQuery($sql);
                        $db->query();
                        $sql      = "INSERT INTO `#__conf` (`key`,`value`) VALUES ('schetfacturanum','$schetfacturanum')";
                        $db->setQuery($sql);
                        $db->query();
                        //получение информации о заказе
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql            = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order          = $db->LoadObject();
                        $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt            = $order->nrt;
                        $vendor_info_id = (int) $order->vendor_info_id;
                        $orderdate      = date("d.m.Y", $order->cdate);
                        $nowdate        = date("d.m.Y");

                        //получение списка продавцов
                        $sql        = 'SELECT * FROM `#__categories` WHERE `id` IN (18,19,20,21)';
                        $db->setQuery($sql);
                        $rows       = $db->LoadObjectList();
                        $vendorinfo = '';
                        $vendorlist = '<select id="vendorselect" class="editelement">';
                        foreach ($rows as $row) {
                            $catid = $row->id;

                            $sql  = "SELECT * FROM `#__content` WHERE `catid`=$catid AND `title`='schnaopl' LIMIT 1"; //echo str_replace('#__','jos_',$sql).'<br>';
                            $db->setQuery($sql);
                            $item = $db->LoadObject();

                            $sel = ($vendor_info_id == $row->id) ? 'selected' : '';
                            $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                            $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . $item->introtext . '</div>';
                            $condinfo .= '<div class="cond cond' . $row->id . '">' . $item->fulltext . '</div>';
                        }

                        $vendorlist .= '</select>';
                        $vendorinfo = $vendorlist . $vendorinfo;

                        $sql       = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem = $db->LoadObjectList();
                        $total     = 0;
                        $i         = 0;
                        foreach ($orderitem as $row) {
                            $i++;
                            $itemname          = $row->order_item_name;
                            $order_item_id     = $row->order_item_id;
                            $itemsku           = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount         = $row->product_quantity;
                            $itemprice         = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo         = round($itemprice * $itemcount);
                            $product_attribute = $row->product_attribute;

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $itemrows .="<tr id='row$i' rel='$order_item_id' class='itemrow' style='mso-yfti-irow:1;height:15.0pt'>
                                            <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemcount changeelement'>$itemcount</div>
                                                    <input onkeyup='resumm($i)' size='2' id='itemcounttext$i' class='itemcounttext editelement' type='text'/>
                                            </td>
                                            <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemname changeelement'>$itemname</div>
                                                    <input size='67' id='itemnametext$i' class='itemnametext editelement' type='text'/>
                                            </td>
                                            <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemsku changeelement'>$itemsku</div>
                                                    <input size='10' id='itemskutext$i' class='itemskutext editelement' type='text'/>
                                            </td>
                                            <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemprice changeelement'>$itemprice</div>
                                                    <input onkeyup='resumm($i)' size='2'id='itempricetext$i' class='itempricetext editelement' type='text'/>
                                            </td>
                                            <td width=71 style='border:solid 1px black;text-align:right;'><div id='itemitogo$i' class='itemitogo'>$itemitogo</div></td>
                                            <td style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemgerantiya changeelement'>$garantiya</div>
                                                    <input size='5' id='itemgerantiyatext$i' class='itemgerantiyatext editelement' type='text'/>
                                            </td>
                                        </tr>";
                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/schnaopl.htm';

                        $arrkey   = array('%NOMER%', '%ITENROWS%', '%TOTAL%',
                            '%DATE%', '%TOTALSTR%', '%VENDORINFO%',
                            '%CONDINFO%', '%SHOPPER_INFO%', '%ORDERDATE%',
                            '%NOWDATE%', '%ORDERID%', '%NRT%');
                        $arrvalue = array($schetfacturanum, $itemrows, $total,
                            $date, $totalstr, $vendorinfo,
                            $condinfo, $shopper_info, $orderdate,
                            $nowdate, $order->order_id, $nrt);

                        $file = implode(file($tmpl));
                        $file = str_replace($arrkey, $arrvalue, $file);

                        echo $file;

                        break;
                    }
                case 'prilogenie': {
                        //описание гарантии
                        $sql      = 'SELECT `fulltext` FROM `#__content` WHERE `id`=65';
                        $db->setQuery($sql);
                        $material = $db->LoadResult();
                        $material = str_replace('src="', 'src="../', $material);

                        echo '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<title>Приложение к гарантийному талону</title>
<style>
 p{font-size:10.0pt;
	font-family:"Times New Roman";
	margin-top:3px;
	margin-bottom:3px;
}
</style>
</head>
<body lang=RU>
<h3>Приложение к гарантийному талону</h3>';
                        echo $material;

                        echo '</body></html>';

                        break;
                    }
                case 'garantiya': {
                        //получение информации о заказе
                        $order_id = $_GET['id'];

                        $date = date("d.m.Y");

                        $sql          = 'SELECT * FROM `#__vm_orders` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $order        = $db->LoadObject();
                        $orderdate    = date("d.m.Y", $order->cdate);
                        $shopper_info = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                        $nrt          = $order->nrt;
                        $sql          = 'SELECT * FROM `#__vm_order_item` WHERE `order_id`=' . $order_id;
                        $db->setQuery($sql);
                        $orderitem    = $db->LoadObjectList();
                        $total        = 0;
                        $i            = 0;
                        foreach ($orderitem as $row) {
                            $i++;
                            $itemid            = $row->order_item_id;
                            $itemname          = $row->order_item_name;
                            $itemsku           = str_replace('sklad-', '', $row->order_item_sku);
                            $itemcount         = $row->product_quantity;
                            $product_attribute = $row->product_attribute;
                            $itemprice         = round($row->product_final_price * (1 + $nrt / 100));
                            $itemitogo         = round($itemprice * $itemcount);

                            $t1 = explode(';', $product_attribute);
                            if ($t1)
                                foreach ($t1 as $item) {
                                    $t2       = explode('=', $item);
                                    $k        = trim($t2[0]);
                                    $v        = trim($t2[1]);
                                    if ($k)
                                        $attr[$k] = $v;
                                }

                            $sn        = $attr['sn'];
                            $garantiya = ($attr['garantiya']) ? $attr['garantiya'] : '12 мес.';

                            $itemrows .="<tr id='row$i' rel='$itemid' class='itemrow' style='mso-yfti-irow:1;height:15.0pt'>
                                            <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemcount changeelement'>$itemcount</div>
                                                    <input onkeyup='resumm($i)' size='2' id='itemcounttext$i' class='itemcounttext editelement' type='text'/>
                                            </td>
                                            <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemname changeelement'>$itemname</div>
                                                    <input size='67' id='itemnametext$i' class='itemnametext editelement' type='text'/>
                                            </td>
                                            <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemsku changeelement'>$itemsku</div>
                                                    <input size='10' id='itemskutext$i' class='itemskutext editelement' type='text'/>
                                            </td>
                                            <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                                                    <div class='itemprice changeelement'>$itemprice</div>
                                                    <input onkeyup='resumm($i)' size='2'id='itempricetext$i' class='itempricetext editelement' type='text'/>
                                            </td>
                                            <td width=71 style='border:solid 1px black;text-align:right;'><div id='itemitogo$i' class='itemitogo'>$itemitogo</div></td>
                                            <td class='itemsn' valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>$sn</td>
                                            <td style='border:solid 1px black;text-align:right;'>
                                                    <div class='itemgerantiya changeelement'>$garantiya</div>
                                                    <input size='5' id='itemgerantiyatext$i' class='itemgerantiyatext editelement' type='text'/>
                                            </td>
                                        </tr>";
                            $total += $itemitogo;
                        }
                        $total          = round($total);
                        $NumberAnalyser = new NumberAnaliz();
                        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

                        $tmpl = '../images/docs/tmpl/garantiya.htm';

                        $arrkey   = array('%ITENROWS%', '%TOTAL%', '%DATE%', '%TOTALSTR%', '%ORDERID%', '%ORDERDATE%', '%NRT%');
                        $arrvalue = array($itemrows, $total, $date, $totalstr, $order_id, $orderdate, $nrt);

                        $file = implode(file($tmpl));
                        $file = str_replace($arrkey, $arrvalue, $file);

                        echo $file;

                        if ($i == 1) {
                            $db       = JFactory::getDBO();
                            //описание гарантии
                            $sql      = 'SELECT `fulltext` FROM `#__content` WHERE `id`=65';
                            $db->setQuery($sql);
                            $material = $db->LoadResult();
                            $material = str_replace('src="', 'src="../', $material);

                            echo $material;
                        }
                        echo '</body></html>';

                        break;
                    }
            }
            break;
        }
    case 'addNewSklad': {
            $priceName            = JRequest::getVar('priceName');
            $clearLine            = JRequest::getVar('clearLine');
            $categoryNamePosition = JRequest::getVar('categoryNamePosition');
            $productNamePosition  = JRequest::getVar('productNamePosition');
            $productPricePosition = JRequest::getVar('productPricePosition');

            if (!$_POST['productDescPosition'])
                $productDescPosition = -1;
            else
                $productDescPosition = JRequest::getVar('productDescPosition');
            if (!checkSkladName($priceName) > 0) {
                $sql     = 'SELECT MAX(`list`) AS `maxlist` FROM `#__import_sklads`';
                $db->setQuery($sql);
                $maxlist = $db->loadResult();

                $maxlist++;
                $skladName = 'sklad-' . $maxlist . '-';
                $sql2      = "INSERT INTO `#__import_sklads` (
                            `price_name`, `sklad_name`, `curency`, `position_category_name`, 
                            `position_product_name`, `position_product_price`, `position_product_s_desk`, `clear_line`, `list`
                            ) VALUES (
                            '$priceName', '$skladName', '', '$categoryNamePosition', 
                            '$productNamePosition', '$productPricePosition', '$productDescPosition', '$clearLine', '$maxlist')";
                $db->setQuery($sql2);
                $db->execute();

                $msg    = 'Создан тип прайса ' . $priceName . ' / ' . $skladName . ', перейти в список складов?';
                $status = 1;
            } else {
                $msg    = 'Тип прайса с таким именем уже существует, введите другое имя';
                $status = 0;
            }

            echo '<xml>
	<message>' . $msg . '</message>
	<status>' . $status . '</status>
</xml>';

            break;
        }
    case 'saveEditSklad': {
            $id        = JRequest::getInt('id');
            $clearLine = JRequest::getVar('clearLine');
            $priceName = JRequest::getVar('priceName');

            $categoryNamePosition = JRequest::getVar('categoryNamePosition');
            $productNamePosition  = JRequest::getVar('productNamePosition');
            $productPricePosition = JRequest::getVar('productPricePosition');

            $productDescPosition = (JRequest::getVar('productDescPosition')) ? JRequest::getVar('productDescPosition') : -1;

            if ($id > 0) {
                $sql = "UPDATE `#__import_sklads` SET
                        `position_category_name`='$categoryNamePosition', `position_product_name`='$productNamePosition', 
                        `position_product_price`='$productPricePosition', `position_product_s_desk`='$productDescPosition', 
                        `clear_line`='$clearLine', `price_name` = '$priceName' WHERE `id`=$id";
                $db->setQuery($sql);
                $db->query();

                $msg    = 'Обновлен тип прайса, перейти в список складов?';
                $status = 1;
            } else {
                $msg    = 'Тип прайса не существует';
                $status = 0;
            }

            echo '<xml>
	<message>' . $msg . '</message>
	<status>' . $status . '</status>
</xml>';

            break;
        }
    case 'getWinListSklad': {
            $sql  = 'SELECT * FROM `#__import_sklads`';
            $db->setQuery($sql);
            $rows = $db->LoadObjectList();
            foreach ($rows as $row) {
                $data[$row->id] = new stdClass();

                $data[$row->id]->id         = $row->id;
                $data[$row->id]->price_name = $row->price_name;
                $data[$row->id]->sklad_name = $row->sklad_name;
                $data[$row->id]->curency    = $row->curency;
            }

            break;
        }
    case 'getWinAddNewSklad': {
            break;
        }
    case 'editPrice': {
            $id = JRequest::getInt('id');

            if ($id > 0) {
                $sql  = 'SELECT * FROM `#__import_sklads` WHERE `id`=' . $id;
                $db->setQuery($sql);
                $rows = $db->loadObjectList();
                foreach ($rows as $row) {
                    $price_name              = $row->price_name;
                    $sklad_name              = $row->sklad_name;
                    $curency                 = $row->curency;
                    $position_category_name  = $row->position_category_name;
                    $position_product_name   = $row->position_product_name;
                    $position_product_price  = $row->position_product_price;
                    $position_product_s_desk = $row->position_product_s_desk;
                    $clear_line              = $row->clear_line;
                }
            }


            break;
        }
    case 'deletePrice': {
            $id = JRequest::getInt('id');

            if ($id > 0) {
                $sql = 'DELETE FROM `#__import_sklads` WHERE `id`=' . $id;
                $db->setQuery($sql);
                $db->execute();

                $st  = 1;
                $msg = 'Тип прайса удален';
            } else {
                $st  = 0;
                $msg = 'Ошибка, неверный id типа прайса';
            }

            echo '<xml>
	<message>' . $msg . '</message>
	<status>' . $st . '</status>
</xml>';

            break;
        }
    case 'startUpdate': {
            $i  = $_SESSION['import']['active_document'];
            $id = JRequest::getInt('id');

            $filename               = $_SESSION['import']['document_list'][$i]->basename;
            $controller             = new ImportController($filename);
            $controller->start_prod = $id;
            $controller->price_type = $_SESSION['import']['price'];
            $controller->currency   = $_SESSION['import']['currency'];
            $controller->parceCSV();

            break;
        }
    case 'getUpdateStatus': {
            $status             = getVars('update_status');
            $update_status_name = getVars('update_status_name');

            $count = getVars('count_products');
            $prod  = getVars('works_products');
            $time  = getVars('works_products_time');
            if ($count == 0) {
                $count = 0.01;
            }
            $per = round($prod * 100 / $count);

            if (($time > 0) and (time() - $time > 5)) {
                $reload = 1;
                $prod--;
                setVars('works_products_time', 0);
                setVars('works_products', $prod);
            } else {
                $reload = 0;
            }

            echo '<xml>
	<update_status>' . $status . '</update_status>				
	<update_status_name>' . $update_status_name . '</update_status_name>				
	<count>' . $count . '</count>				
	<prod>' . $prod . '</prod>					
	<reload>' . $reload . '</reload>							
	<per>' . $per . '</per>			
</xml>';
            break;
        }
    case 'clearUpdateVars': {
            setVars('update_status', 0);
            setVars('update_status_name', '');
            setVars('count_products', 0);
            setVars('works_products', 0);

            break;
        }
    case 'delete_price': {
            $i        = $_SESSION['import']['active_document'];
            $filepath = $_SESSION['import']['document_list'][$i]->filepath;

            unlink($filepath);
            $mas = getDocumentList();

            $num = 0;
            $str = '';
            for ($i = 1; $i <= count($mas); $i++) {
                if ($num == 0) {
                    $str .= '<tr>';
                }
                $str .= '<td valign="top">
                            <div id="doc' . $i . '" class="documents" onclick="selectDocument(' . $i . ')">
                                <div class="d_lt round"></div>
                                <div class="d_lb round"></div>
                                <div class="d_rt round"></div>
                                <div class="d_rb round"></div>
                                <img src="components/com_import/assets/images/document.png"/>	
                                <h3>' . ($mas[$i]->basename) . '</h3>
                                <div class="doc_info">
                                        Размещен	:' . ($mas[$i]->dataload) . '<br>
                                        Формат	: ' . ($mas[$i]->extension) . '</br>
                                        Размер	: ' . ($mas[$i]->filesize) . 'kb
                                </div>
                            </div>
                        </td>';
                if ($num == 1) {
                    $str .= '<tr>';
                }

                $num++;
                if ($num > 1) {
                    $num = 0;
                }
            }

            $_SESSION['import']['active_document'] = 0;

            echo '<xml>
	<content>
	' . $str . '
	</content>
</xml>';

            break;
        }
    case 'set_select': {
            $_SESSION['import'][$_GET['type']] = $_GET['value'];
            break;
        }
    case 'set_page': {
            $_SESSION['import']['page'] = $_GET['id'];
            break;
        }
    case 'setCategory': {
            $_SESSION['import']['category_id']    = JRequest::getInt('id');
            $_SESSION['import']['category_title'] = JRequest::getVar('title');
            $_SESSION['import']['filtr']          = JRequest::getVar('filtr');

            $mas = getProductList();
            $str = '';
            if ($mas) {
                foreach ($mas as $item) {
                    $photo  = ($item->product_thumb_image) ? 'да' : 'нет';
                    $s_desc = ($item->product_s_desc) ? 'да' : 'нет';
                    $desc   = ($item->product_desc) ? 'да' : 'нет';

                    $str .= '<tr onclick="parseProductName(' . $item->product_id . ')">
                                <td>' . $item->product_name . '</td>
                                <td>' . $item->product_sku . '</td>
                                <td align="right">' . $item->product_price . '</td>
                                <td align="center">' . $photo . '</td>
                                <td align="center">' . $s_desc . '</td>
                                <td align="center">' . $desc . '</td>
                        <tr>';

                    $num++;
                    if ($num > 1) {
                        $num = 0;
                    }
                }
            }

            echo $str;

            break;
        }
    case 'parseProductName': {
            $product_id = JRequest::getInt('id');

            $_SESSION['import']['product_id'] = $product_id;

            $data = parseProductName($product_id);

            $mas     = explode(' ', $data->product_name);
            $content = '';
            $x       = 0;
            $sep     = '';
            $link    = '';
            foreach ($mas as $item) {
                $x++;

                $link .= $sep . $item;
                $sep = ' ';
                if ($x == 3) {
                    break;
                }
            }
            $content .= '<a onclick="setModelForProduct(' . $product_id . ',\'' . $link . '\')">' . $link . '</a>';
            $lenght = strlen($link);
            foreach ($mas as $item) {
                $lenght = $lenght + strlen($item);
                $content .= '<a onclick="setModelForProduct(' . $product_id . ',\'' . $item . '\')">' . $item . '</a>';
                if ($lenght > 40) {
                    $content .= '<br>';
                    $lenght = 0;
                }
            }

            echo '<xml>
    <model>' . $data->model . '</model>
    <content>' . $content . '</content>
</xml>';

            break;
        }
    case 'setModelForProduct': {
            $product_id = JRequest::getInt('id');
            $value      = JRequest::getVar('value');

            $sql = 'SELECT id FROM `#__import_model` WHERE `product_id`=' . $product_id;
            $db->setQuery($sql);
            $id  = $db->loadResult();

            if ($id > 0) {
                $sql = 'UPDATE `#__import_model` SET `model`=\'' . $value . '\' WHERE `product_id`=' . $product_id;
            } else {
                $sql = 'INSERT INTO `#__import_model` (`product_id`, `model`) VALUES (\'' . $product_id . '\', \'' . $value . '\')';
            }
            $db->setQuery($sql);
            $db->execute();

            echo '<xml>
    <model>' . $value . '</model>
</xml>';
            break;
        }
    case 'setDataForProduct': {
            $product_id        = $_POST['product_id'];
            $yandex_product_id = $_POST['yandex_product_id'];
            $bigimg            = $_POST['bigimg'];
            $img               = $_POST['img'];
            $s_desc            = $_POST['s_desc'];
            $desc              = $_POST['desc'];
            $model             = $_POST['model'];

            if ($bigimg == 'undefined')
                $bigimg = '';
            if ($img == 'undefined')
                $img    = '';

            if ($bigimg) {
                $bigimgname = time() . '.jpg';
                create_small($bigimg, '../components/com_virtuemart/shop_image/product/' . $bigimgname, 800, 600);
            }
            if ($img) {
                $imgname = 'resized/' . time() . '_120x80.jpg';
                create_small($img, '../components/com_virtuemart/shop_image/product/' . $imgname, 120, 80);
            }

            $sql = 'UPDATE `jos_yaros_import_model` SET `model`=\'' . $model . '\', `yandex_product_id`=\'' . $yandex_product_id . '\' WHERE `product_id`=' . $product_id;
            echo $sql;
            ImportModelImport::insSql($sql);

            $sql = 'UPDATE `jos_vm_product` SET `product_s_desc`=\'' . $s_desc . '\', `product_desc`=\'' . $desc . '\'';
            if ($img)
                $sql .= ', `product_thumb_image`=\'' . $imgname . '\'';
            if ($bigimg)
                $sql .= ', `product_full_image`=\'' . $bigimgname . '\' ';
            $sql .= ' WHERE `product_id`=' . $product_id;
            ImportModelImport::insSql($sql);

            break;
        }
    case 'setNadbavka': {
            $id      = JRequest::getInt('id');
            $value   = JRequest::getVar('value');
            $sum     = (JRequest::getVar('sum') > 0) ? JRequest::getVar('sum') : null;
            $sum_tax = (JRequest::getVar('sum_tax') > 0) ? JRequest::getVar('sum_tax') : null;

            if ($id > 0) {
                $sql = "UPDATE `#__import_xref` "
                        . "SET `sum`='$sum', `sum_tax`='$sum_tax', `tax`='$value' "
                        . "WHERE `id`=$id";
                $db->setQuery($sql);
                $db->execute();
            }

            break;
        }
    case 'setAkcent': {
            $akcent      = JRequest::getVar('akcent');
            $akcent_time = JRequest::getVar('akcent_time');

            $config = getConfig($_SESSION['import']['component_id']);

            $_SESSION['import']['akcent']      = $akcent;
            $_SESSION['import']['akcent_time'] = $akcent_time;

            $config['shownewproduct'] = $akcent;
            $config['actualtime']     = $akcent_time;

            setConfig($_SESSION['import']['component_id'], $config);

            break;
        }
    case 'setMarkup': {
            $markup = JRequest::getInt('markup');
            $price  = JRequest::getVar('price');

            $db->setQuery('UPDATE #__import_sklads SET markup = ' . $markup . ' WHERE price_name = "' . $price . '"');
            $db->query();

            break;
        }
    case 'get_active_document': {
            $id = $_SESSION['import']['active_document'];

            $count = ceil($id / 2);

            echo '<xml>
                        <id>' . $id . '</id>
                        <count>' . $count . '</count>
                </xml>';

            break;
        }
    case 'set_active_document': {
            $_SESSION['import']['active_document'] = JRequest::getInt('id');
            break;
        }
    case 'get_price_list': {
            $mas = getDocumentList();
            //pr($mas);
            $num = 0;
            $str = '';
            for ($i = 1; $i <= count($mas); $i++) {
                if ($num == 0) {
                    $str .= '<tr>';
                }
                $str .= '<td valign="top">
                            <div id="doc' . $i . '" class="documents" onclick="selectDocument(' . $i . ')">
                                <div class="d_lt round"></div>
                                <div class="d_lb round"></div>
                                <div class="d_rt round"></div>
                                <div class="d_rb round"></div>
                                <img src="' . PATH_ASSETS . '/images/document.png"/>	
                                <h3>' . ($mas[$i]->basename) . '</h3>
                                <div class="doc_info">
                                        Размещен	:' . ($mas[$i]->dataload) . '<br>
                                        Формат	: ' . ($mas[$i]->extension) . '</br>
                                        Размер	: ' . ($mas[$i]->filesize) . 'kb
                                </div>
                            </div>
                        </td>';
                if ($num == 1) {
                    $str .= '<tr>';
                }
                $num++;
                if ($num > 1) {
                    $num = 0;
                }
            }

            echo '<xml>
	<content>
	' . $str . '
	</content>
</xml>';

            break;
        }
    case 'setClear': {
            $clearDateType  = $_GET['clearDateType'];
            $clearDateValue = $_GET['clearDateValue'];

            $cleartime = strtotime($clearDateValue);
            $i         = 0;
            $sql       = "SELECT * FROM `jos_vm_product` WHERE `$clearDateType`<$cleartime AND `product_publish`='N'";
            $rs        = ImportModelImport::querySql($sql);
            while ($row       = mysql_fetch_object($rs)) {
                $product_id = $row->product_id;

                $sql = "DELETE FROM `jos_vm_product` WHERE `product_id`='$product_id'";
                ImportModelImport::insSql($sql);
                $sql = "DELETE FROM `jos_vm_product_category_xref` WHERE `product_id`='$product_id'";
                ImportModelImport::insSql($sql);
                $sql = "DELETE FROM `jos_vm_product_mf_xref` WHERE `product_id`='$product_id'";
                ImportModelImport::insSql($sql);
                $sql = "DELETE FROM `jos_vm_product_price` WHERE `product_id`='$product_id'";
                ImportModelImport::insSql($sql);
                $sql = "DELETE FROM `jos_yaros_import_model` WHERE `product_id`='$product_id'";
                ImportModelImport::insSql($sql);

                $i++;
            }

            if ($i > 0)
                $str = "Очистка завершена, удалено $i товаров";
            else
                $str = 'Нет товаров соответствующих условиям поиска';

            echo $str;

            break;
        }
    case 'createPrice': {
            $pricepath = JRequest::getVar("pricepath");

            $cleartime  = strtotime($clearDateValue);
            $i          = 0;
            $categories = getCategoryList(0);
            $content    = '';
            foreach ($categories as $c) {
                $id   = $c->category_id;
                $name = $c->category_name;
                $lvl  = $c->lvl;

                if ($lvl == 0) {
                    $content .= "<tr><td colspan=2 style='background: #f90000; color: white; font-size: 16px;'>$name</td></tr>";
                } else {
                    $content .= "<tr><td colspan=2><strong>$name</strong></td></tr>";
                }
                $subsql = "SELECT `product_id`, `product_name`, 
                                    (
                                            SELECT `product_price` 
                                            FROM `jos_vm_product_price` 
                                            WHERE `product_id`=`jos_vm_product`.`product_id` AND `product_currency`='USD' 
                                            LIMIT 1
                                    ) AS `product_price`
                            FROM `jos_vm_product` 
                            WHERE `product_publish`='Y' AND `product_id` IN 
                                    (
                                            SELECT `product_id` 
                                            FROM `jos_vm_product_category_xref` 
                                            WHERE `category_id`=$id
                                    )";
                $db->setQuery($subsql);
                $rows   = $db->LoadObjectList();
                foreach ($rows as $row) {
                    $product_id    = $row->product_id;
                    $product_name  = $row->product_name;
                    $product_price = $row->product_price;

                    $content .= "<tr><td>$product_name</td><td>$product_price</td></tr>";
                }
            }

            $template = '<html>
                            <head>
                                <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
                            <head>
                            <body>
                                <table class="price" border=1 width=1000>%CONTENT%</table>';
            $filetext = str_replace('%CONTENT%', $content, $template);

            $f = fopen("../$pricepath/price.xls", 'w');
            fwrite($f, $filetext);
            fclose($f);

            echo 'Прайс лист обновлен';

            break;
        }
    case 'get_nadbavka': {
            $sql = "INSERT INTO `#__import_xref` (`id`, `sum`, `sum_tax`, `tax`) VALUES (NULL, '', '', 'fix')";
            $db->setQuery($sql);
            $db->query();
            $id  = $db->insertid();

            echo "<xml>
                    <content>
                        <tr id=\"tr_$id\">
                            <td>
                                <input onchange=\"changeNadbavka($id)\" id='price_$id' type='text'/>
                            </td>
                            <td>
                                <input onchange=\"changeNadbavka($id)\" id='nadbavka_$id' type='text'/>
                            </td>
                            <td>
                                <div class='select_conteyner'>
                                    <div id='type_nadbavka_" . $id . "_top' class='select_top select_top_addprice'>
                                        Фиксиров
                                    </div>
                                    <select id='type_nadbavka_$id' onchange='changeNadbavka($id)'>
                                        <option value='fix'>Фиксиров</option>
                                        <option value='per'>Проценты</option>
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </content>
                </xml>";
            break;
        }
    case 'search': {
            $text = JRequest::getVar('text');
            $page = JRequest::getVar('page');

            $url  = "http://market.yandex.ru/search.xml?&text=$text&page=$page";
            $data = file_get_contents($url);
            $data = str_replace(array("\r\n", "\r\n"), '', $data);

            $pattern1 = '/(<table[^>]*class=[\'"]{1}l-page[^>]*[\'"]{1}[^>]*>)(.*)(<\/table>)/Usmu';
            preg_match_all($pattern1, $data, $mas1);

            $data = (isset($mas1[2][1])) ? $mas1[2][1] : null;

            echo $data;

            break;
        }
    case 'searchById': {
            $id   = $_GET['id'];
            $page = $_GET['page'];
            $test = $_GET['test'];

            $url  = "http://market.yandex.ru/model.xml?&modelid=$id";
            $data = file_get_contents($url);

            $pattern1 = '/(.*)(<table[^>]*id=[\'"]model-pictures[\'"][^>]*>)(.*)(<\/table>)(.*)/Us';
            preg_match_all($pattern1, $data, $mas1);

            $mas1[3][0] = preg_replace('/<meta[^>]*>/Us', '', $mas1[3][0]);
            $result1    = $mas1[2][0] . $mas1[3][0] . $mas1[4][0];

            $pattern2 = '/(<ul[^>]*class=["\'][^>]*b-vlist_type_friendly["\']>)(.*)(<\/ul>)/Us';
            preg_match_all($pattern2, $data, $mas2);

            $result2 = $mas2[1][0] . $mas2[2][0] . $mas2[3][0];

            $url   = "http://market.yandex.ru/model-spec.xml?&modelid=$id";
            $data3 = file_get_contents($url);

            $pattern3 = '/(.*)(<table[^>]*class=[\'"]b-properties[\'"][^>]*>)(.*)(<\/table>)(.*)/Us';
            preg_match_all($pattern3, $data3, $mas3);

            $result3 = $mas3[2][0] . $mas3[3][0] . $mas3[4][0];

            echo $result1 . '<br><br>' . $result2 . '<br><br>' . $result3;

            break;
        }
    case 'loadProducts': {
            define('AC_DIR', dirname(__FILE__));

            require_once( AC_DIR . '/../helpers/RollingCurl.php');
            require_once( AC_DIR . '/../helpers/AngryCurl.php');
            require_once( AC_DIR . '/../helpers/ProductImport.php');

            $productImport = new ProductImport();

            $productImport->execute();

            break;
        }
    case 'setCurrency': {
            $currency = JRequest::getVar('currency');
            $price    = JRequest::getVar('price');

            $db->setQuery("UPDATE #__import_sklads SET currency = '$currency' WHERE price_name = '$price'");
            $db->query();

            break;
        }
    default: {
            deleteClearNadbavka();

            $sql = 'SELECT * FROM `#__import_sklads`';

            $db->setQuery($sql);
            $rows = $db->loadObjectList();

            $markups   = array();
            $currencys = array();
            foreach ($rows as $row) {
                $dataPriceType[] = $row->price_name;

                $markups[$row->price_name]   = $row->markup;
                $currencys[$row->price_name] = $row->currency;
            }
        }
}

if (JRequest::getVar('load_file') == 1) {
    $filepath = $_FILES['price']['tmp_name'];
    $filename = $_FILES['price']['name'];

    copy($filepath, '../images/prices/' . $filename);
}
if (($tpl) and (file_exists("components/com_import/views/tmpl/$tpl.php"))) {
    include("tmpl/$tpl.php");
} else {
    include('tmpl/default.php');
}