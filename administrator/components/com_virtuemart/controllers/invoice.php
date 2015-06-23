<?php

/**
 *
 * Product controller
 *
 * @package	VirtueMart
 * @subpackage
 * @author Max Milbers
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: product.php 8561 2014-11-11 13:31:55Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if (!class_exists('VmController'))
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'vmcontroller.php');

/**
 * Product Controller
 *
 * @package    VirtueMart
 * @author
 */
class VirtuemartControllerInvoice extends VmController {

    /**
     * Method to display the view
     *
     * @access	public
     * @author
     */
    function __construct() {
        parent::__construct();
        $this->addViewPath(VMPATH_ADMIN . DS . 'views');
    }

    /**
     * Handle the save task
     * Checks already in the controller the rights and sets the data by filtering the post
     *
     * @author Max Milbers
     */
    function save($data = 0) {

        /* Load the data */
        $data = vRequest::getRequest();

//        print_r($data);
        // Load helpers
        if (!class_exists('NumberAnaliz')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'string.php');
        }
        if (!class_exists('PHPExcel')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'PHPExcel.php');
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'PHPExcel' . DS . 'IOFactory.php');
        }

        $db = JFactory::getDBO();

        switch ($data['action']) {
            case 'saveOrder': {
                    $vendor_info_id = (int) $data['vendor_info_id'];
                    $shopper_info   = isset($data['shopper_info']) ? $data['shopper_info'] : null;
                    $order_id       = (int) $data['order_id'];
                    $nrt            = isset($data['nrt']) ? (float) $data['nrt'] : 0;

                    $sql = "UPDATE `#__virtuemart_orders` 
                    SET `vendor_info_id`='$vendor_info_id', `shoper_info`='$shopper_info', `nrt`='$nrt'
                    WHERE `virtuemart_order_id`=$order_id";
                    $db->setQuery($sql);
                    $db->query();
                    break;
                }
            case 'saveItem': {
                    $order_item_id = (int) $data['order_item_id'];
                    $order_id      = (int) $data['order_id'];
                    $itemcount     = (float) $data['itemcount'];
                    $itemprice     = (float) $data['itemprice'];
                    $itemname      = str_replace('*AMPERSAND*', '&', $data['itemname']);
                    $itemsku       = isset($data['itemsku']) ? $data['itemsku'] : null;
                    $itemsn        = isset($data['itemsn']) ? $data['itemsn'] : null;
                    $itemguaranty  = isset($data['itemguaranty']) ? $data['itemguaranty'] : null;
                    $shopper_info  = isset($data['shopper_info']) ? $data['shopper_info'] : null;
                    $nrt           = isset($data['nrt']) ? (float) $data['nrt'] : 0;
                    $realprice     = round($itemprice / (1 + $nrt / 100));
                    $totalPrice    = $realprice * $itemcount;

                    $sql  = "SELECT product_attribute "
                            . "FROM `#__virtuemart_order_items` "
                            . "WHERE `virtuemart_order_item_id`=$order_item_id "
                            . "LIMIT 1";
                    $db->setQuery($sql);
                    $attr = json_decode($db->loadResult());

                    $attr->guaranty = $itemguaranty;
                    if ($itemsn) {
                        $attr->sn = $itemsn;
                    }
                    $attribute = json_encode($attr);

                    $sql = "UPDATE `#__virtuemart_order_items` 
                    SET `order_item_name`='$itemname', `product_quantity`='$itemcount', 
                    `product_item_price`='$realprice', `product_priceWithoutTax`='$realprice', 
                    `product_discountedPriceWithoutTax`='$realprice', `product_final_price`='$realprice', 
                    `product_subtotal_with_tax`='$totalPrice', product_attribute = '$attribute' ";
                    if ($itemsku) {
                        $sql .= ", `order_item_sku`='$itemsku'";
                    }
                    $sql .= "WHERE `virtuemart_order_item_id`=$order_item_id";
                    $db->setQuery($sql);
                    $db->query();

                    $this->updateTotalPrice($order_id);

                    break;
                }
            case 'saveItems': {
                    $items    = $data['items'];
                    $order_id = $data['order_id'];
                    $nrt      = isset($data['nrt']) ? (float) $data['nrt'] : 0;

                    foreach ($items as $data) {
                        pr($data);
                        $order_item_id = (int) $data['order_item_id'];
                        $itemquantity  = (float) $data['itemquantity'];
                        $itemprice     = (float) $data['itemprice'];
                        $itemname      = str_replace('*AMPERSAND*', '&', $data['itemname']);
                        $itemsku       = isset($data['itemsku']) ? $data['itemsku'] : null;
                        $itemguaranty  = isset($data['itemguaranty']) ? $data['itemguaranty'] : null;
                        $itemsn        = isset($data['itemsn']) ? str_replace('&#60;br&#62;', '<br>', $data['itemsn']) : null;
                        $shopper_info  = isset($data['shopper_info']) ? $data['shopper_info'] : null;
                        $realprice     = round($itemprice / (1 + $nrt / 100));
                        $totalPrice    = $realprice * $itemquantity;

                        $sql  = "SELECT product_attribute "
                                . "FROM `#__virtuemart_order_items` "
                                . "WHERE `virtuemart_order_item_id`=$order_item_id "
                                . "LIMIT 1";
                        $db->setQuery($sql);
                        $attr = json_decode($db->loadResult());
                        pr($attr);
                        if (!$attr) {
                            $attr = new stdClass();
                        }
                        $attr->guaranty = $itemguaranty;
                        if ($itemsn) {
                            $attr->sn = $itemsn;
                        }pr($attr);
                        $attribute = json_encode($attr);

                        $sql = "UPDATE `#__virtuemart_order_items` "
                                . "SET `order_item_name`='$itemname', `product_quantity`='$itemquantity', "
                                . "`product_item_price`='$realprice', `product_priceWithoutTax`='$realprice', "
                                . "`product_discountedPriceWithoutTax`='$realprice', "
                                . "`product_final_price`='$realprice', `product_subtotal_with_tax`='$totalPrice', "
                                . "product_attribute = '$attribute' ";
                        if ($itemsku) {
                            $sql .= ", `order_item_sku`='$itemsku' ";
                        }
                        $sql .= "WHERE `virtuemart_order_item_id`=$order_item_id";
                        $db->setQuery($sql);
                        $db->query();

                        $this->updateTotalPrice($order_id);
                    }
                    break;
                }
            case 'getsumstring': {
                    $summa          = round($data['summa']);
                    $NumberAnalyser = new NumberAnaliz();
                    $totalstr       = $NumberAnalyser->CurrencyToText($summa, "USD");
                    echo $totalstr;
                    break;
                }
            case 'showExcelDocument': {
                    $objPHPExcel = new PHPExcel();
                    $objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
                            ->setLastModifiedBy("Maarten Balliauw")
                            ->setTitle("Office 2007 XLSX Test Document")
                            ->setSubject("Office 2007 XLSX Test Document")
                            ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
                            ->setKeywords("office 2007 openxml php")
                            ->setCategory("Test result file");
                    switch ($data['type']) {
                        case 'schetfactura': {
                                $schetfacturanum = rand(1, 1000);
                                $schetfacturanum++;

                                //получение информации о заказе
                                $order_id = $data['id'];

                                $date = date("d.m.Y");

                                $sql            = 'SELECT * FROM `#__virtuemart_orders` WHERE `virtuemart_order_id`=' . $order_id;
                                $db->setQuery($sql);
                                $order          = $db->LoadObject();
                                $vendor_info_id = (int) $order->vendor_info_id;
                                $shopper_info   = ($order->shopper_info) ? $order->shopper_info : 'Основной клиент';
                                $nrt            = $order->nrt;
                                $orderdate      = date("d.m.Y", strtotime($order->created_on));
                                $nowdate        = date("d.m.Y");

                                //получение списка продавцов
                                $sql    = "SELECT * FROM `#__virtuemart_invoicetemplates` WHERE `id`=$vendor_info_id";
                                $db->setQuery($sql);
                                $vendor = $db->LoadObject();
                                $vendorinfo .= '<div class="vendor vendor' . $vendor->id . '">' . html_entity_decode($vendor->content) . '</div>';

                                $sh_br_count = (int) substr_count($shopper_info, '<br>');
                                if (!$sh_br_count > 0) {
                                    $sh_br_count = 1;
                                }

                                $shopper_info = str_replace('<br>', chr(10), $shopper_info);

                                $vr_br_count = (int) substr_count($vendorinfo, '</p>');
                                if (!$vr_br_count > 0) {
                                    $vr_br_count = 1;
                                }

                                $vendorinfo = strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo));

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

                                $sql       = 'SELECT * FROM `#__virtuemart_order_items` WHERE `virtuemart_order_id`=' . $order_id;
                                $db->setQuery($sql);
                                $orderitem = $db->LoadObjectList();

                                $total = 0;
                                $i     = 0;
                                $z     = 5;
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
                                header('Content-Type: application/vnd.ms-excel');
                                header('Content-Disposition: attachment;filename="file.xls"');
                                header('Cache-Control: max-age=0');
                                $objWriter->save('php://output');

                                exit;

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

                                    $guaranty = ($attr['guaranty']) ? $attr['guaranty'] : '12 мес.';

                                    $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                                    $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                                    $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                                    $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                                    $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                                    $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $guaranty);

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

                                    $guaranty = ($attr['guaranty']) ? $attr['guaranty'] : '12 мес.';

                                    $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                                    $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                                    $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                                    $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                                    $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                                    $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $guaranty);

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

                                    $guaranty = ($attr['guaranty']) ? $attr['guaranty'] : '12 мес.';

                                    $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                                    $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                                    $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                                    $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                                    $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                                    $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $guaranty);

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
                        case 'guaranty': {
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

                                    $guaranty = ($attr['guaranty']) ? $attr['guaranty'] : '12 мес.';
                                    $sn       = str_replace('<br>', chr(10), $attr['sn']);

                                    $objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
                                    $objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                                    $objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
                                    $objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
                                    $objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
                                    $objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $sn)->getStyle('B' . $z)->getAlignment()->setWrapText(true);
                                    $objPHPExcel->getActiveSheet()->setCellValue('G' . $z, $guaranty);

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
                                $objWriter->save('../images/docs/guaranty_' . $order->order_id . '.xlsx');
                                echo 'http://enter.kg/images/docs/guaranty_' . $order->order_id . '.xlsx';


                                break;
                            }
                    }
                    break;
                }
        }
    }

    public function updateTotalPrice($order_id) {
        $db    = JFactory::getDBO();
        $sql   = "SELECT SUM(product_subtotal_with_tax) 
                            FROM #__virtuemart_order_items 
                            WHERE virtuemart_order_id = $order_id";
        $db->setQuery($sql);
        $total = $db->loadResult();

        $sql = "UPDATE `#__virtuemart_orders` 
                            SET `order_total`='$total', `order_subtotal`='$total', 
                            `order_salesPrice`='$total', `order_billTaxAmount`='$total' 
                            WHERE `virtuemart_order_id` = $order_id";
        $db->setQuery($sql);
        $db->query();
    }

}

// pure php no closing tag
