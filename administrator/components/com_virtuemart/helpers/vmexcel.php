<?php

/**
 * Configuration helper class
 *
 * This class provides some functions that are used throughout the VirtueMart shop to access confgiuration values.
 *
 * @package	VirtueMart
 * @subpackage Helpers
 * @author Max Milbers
 * @copyright Copyright (c) 2004-2008 Soeren Eberhardt-Biermann, 2009-2014 VirtueMart Team. All rights reserved.
 */
defined('_JEXEC') or die('Restricted access');

class VMExcel {

    protected $objPHPExcel;

    public function __construct() {
        $this->objPHPExcel = new PHPExcel();
        $this->objPHPExcel->getProperties()->setCreator("Maarten Balliauw")
                ->setLastModifiedBy("Maarten Balliauw")
                ->setTitle("Office 2007 XLSX Test Document")
                ->setSubject("Office 2007 XLSX Test Document")
                ->setDescription("Test document for Office 2007 XLSX, generated using PHP classes.")
                ->setKeywords("office 2007 openxml php")
                ->setCategory("Test result file");
    }

    public function showCommercialInvoice($orderId, $data, $task) {
        $schetfacturanum = 1;

        $items   = $data->order['items'];
        $details = $data->order['details']['BT'];

        $vendor_info_id = (int) $details->vendor_info_id;
        $shopper_info   = ($details->shopper_info) ? $details->shopper_info : 'Основной клиент';
        $nrt            = $details->nrt;
        $exchange_usd   = $details->exchange_usd;
        $orderdate      = date("d.m.Y", strtotime($details->created_on));

        $content = "content_$task";
        $footer  = "footer_$task";
        $vendorinfo .= '<div class="vendor vendor' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$content)
                . '</div>';
        $vendorinfo2 .= '<div class="cond cond' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$footer)
                . '</div>';

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
        $this->objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(20 * $vr_br_count);
        $this->objPHPExcel->getActiveSheet()->getRowDimension(3)->setRowHeight(20 * $sh_br_count);
        $this->objPHPExcel->setActiveSheetIndex(0);
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Счет-фактура $schetfacturanum");
        $this->objPHPExcel->getActiveSheet()->mergeCells('A2:B2')->setCellValue('A2', "Продавец");
        $this->objPHPExcel->getActiveSheet()->mergeCells('C2:F2')->setCellValue('C2', $vendorinfo)->getStyle('C2')->getAlignment()->setWrapText(true);
        $this->objPHPExcel->getActiveSheet()->mergeCells('A3:B3')->setCellValue('A3', "Покупатель");
        $this->objPHPExcel->getActiveSheet()->mergeCells('C3:F3')->setCellValue('C3', $shopper_info)->getStyle('C3')->getAlignment()->setWrapText(true);
        $this->objPHPExcel->getActiveSheet()->setCellValue('A4', "");

        $this->objPHPExcel->getActiveSheet()->setCellValue('A5', "№");
        $this->objPHPExcel->getActiveSheet()->mergeCells('B5:C5')->setCellValue('B5', "Наименование");
        $this->objPHPExcel->getActiveSheet()->setCellValue('D5', "Кол-во");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E5', "Цена, сом");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F5', "Всего, сом");

        $total = 0;
        $i     = 0;
        $z     = 5;
        foreach ($items as $row) {
            $i++;
            $z++;
            $itemname  = $row->order_item_name;
            $itemcount = $row->product_quantity;
            $itemprice = $row->product_final_price * (1 + $nrt / 100);
            $itemprice = round($details->order_currency == '202' ? $itemprice * $exchange_usd : $itemprice);
            $itemitogo = round($itemprice * $itemcount);

            $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $i);
            $this->objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':C' . $z)->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('C' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemcount);
            $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemprice);
            $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $itemitogo);

            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $total += $itemitogo;
        }

        $NumberAnalyser = new NumberAnaliz();
        $totalstr       = $NumberAnalyser->CurrencyToText(round($total), "KGS");

        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(4);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(40);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $total);
        $z++;
        $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
        $this->objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

        $z++;
        $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $orderdate);
        $z += 2;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, "                   м.п.                                 Руководитель                             гл. Бухгалтер");

        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->objPHPExcel->setActiveSheetIndex(0);

        // Save Excel 2007 file
        $objWriter = PHPExcel_IOFactory::createWriter($this->objPHPExcel, 'Excel2007');
        $objWriter->save('cache/' . $orderId . '.xlsx');

        header("Location: cache/$orderId.xlsx");
    }

    public function showWaybill($orderId, $data, $task) {
        $date = date("d.m.Y");

        $items   = $data->order['items'];
        $details = $data->order['details']['BT'];

        $vendor_info_id = (int) $details->vendor_info_id;
        $shopper_info   = ($details->shopper_info) ? $details->shopper_info : 'Основной клиент';
        $nrt            = $details->nrt;
        $orderdate      = date("d.m.Y", strtotime($details->created_on));
        $exchange_usd   = $details->exchange_usd;
        $nowdate        = date("d.m.Y");

        $content = "content_$task";
        $footer  = "footer_$task";
        $vendorinfo .= '<div class="vendor vendor' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[0]->$content)
                . '</div>';
        $vendorinfo2 .= '<div class="cond cond' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[0]->$footer)
                . '</div>';

        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
        if (!$vr_br_count > 0) {
            $vr_br_count = 1;
        }
        $vendorinfo = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

        // Create a first sheet
        $this->objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(22 * $vr_br_count);
        $this->objPHPExcel->setActiveSheetIndex(0);

        $center = array(
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
            )
        );
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Накладная");
        $this->objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

        $this->objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
        $this->objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
        $this->objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
        $this->objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

        $total = 0;
        $i     = 0;
        $z     = 3;
        foreach ($items as $row) {
            $i++;
            $z++;
            $itemname  = $row->order_item_name;
            $itemsku   = str_replace('sklad-', '', $row->order_item_sku);
            $itemcount = $row->product_quantity;
            $itemprice = $row->product_final_price * (1 + $nrt / 100);
            $itemprice = round($details->order_currency == '202' ? $itemprice * $exchange_usd : $itemprice);
            $itemitogo = round($itemprice * $itemcount);

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

            $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
            $this->objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
            $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
            $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
            $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $total += $itemitogo;
        }
        $total          = round($total);
        $NumberAnalyser = new NumberAnaliz();
        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
        $z++;
        $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
        $this->objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

        $z += 2;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, "                  Отпустил_____________________                     Принял________________________    ");

        $z += 2;
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->objPHPExcel->setActiveSheetIndex(0);

        // Save Excel 2007 file
        $objWriter = PHPExcel_IOFactory::createWriter($this->objPHPExcel, 'Excel2007');
        $objWriter->save('cache/' . $orderId . '.xlsx');

        header("Location: cache/$orderId.xlsx");
    }

    public function showCommercialOffer($orderId, $data, $task) {
        $date = date("d.m.Y");

        $items   = $data->order['items'];
        $details = $data->order['details']['BT'];

        $vendor_info_id = (int) $details->vendor_info_id;
        $shopper_info   = ($details->shopper_info) ? $details->shopper_info : 'Основной клиент';
        $nrt            = $details->nrt;
        $orderdate      = date("d.m.Y", strtotime($details->created_on));
        $exchange_usd   = $details->exchange_usd;
        $nowdate        = date("d.m.Y");

        $content = "content_$task";
        $footer  = "footer_$task";
        $vendorinfo .= '<div class="vendor vendor' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$content)
                . '</div>';
        $vendorinfo2 .= '<div class="cond cond' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$footer)
                . '</div>';

        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
        if (!$vr_br_count > 0) {
            $vr_br_count = 1;
        }
        $vendorinfo = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

        // Create a first sheet
        $this->objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(22 * $vr_br_count);
        $this->objPHPExcel->setActiveSheetIndex(0);

        $center = array(
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
            )
        );
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Коммерческое предложение");
        $this->objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

        $this->objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
        $this->objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
        $this->objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
        $this->objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

        $total = 0;
        $i     = 0;
        $z     = 3;
        foreach ($items as $row) {
            $i++;
            $z++;
            $itemname  = $row->order_item_name;
            $itemsku   = str_replace('sklad-', '', $row->order_item_sku);
            $itemcount = $row->product_quantity;
            $itemprice = $row->product_final_price * (1 + $nrt / 100);
            $itemprice = round($details->order_currency == '202' ? $itemprice * $exchange_usd : $itemprice);
            $itemitogo = round($itemprice * $itemcount);

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

            $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
            $this->objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
            $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
            $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
            $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $total += $itemitogo;
        }
        $total          = round($total);
        $NumberAnalyser = new NumberAnaliz();
        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
        $z++;
        $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
        $this->objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

        $z += 2;
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, trim(strip_tags($vendorinfo2)))->getStyle('A' . $z)->getAlignment()->setWrapText(true);
        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->objPHPExcel->setActiveSheetIndex(0);

        // Save Excel 2007 file
        $objWriter = PHPExcel_IOFactory::createWriter($this->objPHPExcel, 'Excel2007');
        $objWriter->save('cache/' . $orderId . '.xlsx');

        header("Location: cache/$orderId.xlsx");
    }

    public function showInvoicePayment($orderId, $data, $task) {
        $date = date("d.m.Y");

        $items   = $data->order['items'];
        $details = $data->order['details']['BT'];

        $vendor_info_id = (int) $details->vendor_info_id;
        $shopper_info   = ($details->shopper_info) ? $details->shopper_info : 'Основной клиент';
        $nrt            = $details->nrt;
        $orderdate      = date("d.m.Y", strtotime($details->created_on));
        $exchange_usd   = $details->exchange_usd;
        $nowdate        = date("d.m.Y");

        $content = "content_$task";
        $footer  = "footer_$task";
        $vendorinfo .= '<div class="vendor vendor' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$content)
                . '</div>';
        $vendorinfo2 .= '<div class="cond cond' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$footer)
                . '</div>';

        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
        if (!$vr_br_count > 0) {
            $vr_br_count = 1;
        }
        $vendorinfo = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

        // Create a first sheet
        $this->objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(22 * $vr_br_count);
        $this->objPHPExcel->setActiveSheetIndex(0);

        $center = array(
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
            )
        );
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:F1')->setCellValue('A1', "Счет на оплату");
        $this->objPHPExcel->getActiveSheet()->mergeCells('A2:F2')->setCellValue('A2', $vendorinfo)->getStyle('A2')->getAlignment()->setWrapText(true);

        $this->objPHPExcel->getActiveSheet()->setCellValue('A3', "Кол-во");
        $this->objPHPExcel->getActiveSheet()->setCellValue('B3', "Наименование");
        $this->objPHPExcel->getActiveSheet()->setCellValue('C3', "Артикул");
        $this->objPHPExcel->getActiveSheet()->setCellValue('D3', "Цена");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E3', "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F3', "Гарантия");

        $total = 0;
        $i     = 0;
        $z     = 3;
        foreach ($items as $row) {
            $i++;
            $z++;
            $itemname  = $row->order_item_name;
            $itemsku   = str_replace('sklad-', '', $row->order_item_sku);
            $itemcount = $row->product_quantity;
            $itemprice = $row->product_final_price * (1 + $nrt / 100);
            $itemprice = round($details->order_currency == '202' ? $itemprice * $exchange_usd : $itemprice);
            $itemitogo = round($itemprice * $itemcount);

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

            $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
            $this->objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
            $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
            $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
            $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $garantiya);

            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $total += $itemitogo;
        }
        $total          = round($total);
        $NumberAnalyser = new NumberAnaliz();
        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1:F1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3:F3')->getBorders()->getTop()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('D3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F3')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('A4:F4')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5:F5')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F5')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
        $z++;
        $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, "");
        $this->objPHPExcel->getActiveSheet()->mergeCells('B' . $z . ':F' . $z)->setCellValue('B' . $z, "Сумма прописью:   $totalstr");

        $z += 2;
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $orderdate);
        $z++;
        $this->objPHPExcel->getActiveSheet()->getRowDimension($z)->setRowHeight(80);
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':F' . $z)->setCellValue('A' . $z, trim(strip_tags($vendorinfo2)))->getStyle('A' . $z)->getAlignment()->setWrapText(true);
        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->objPHPExcel->setActiveSheetIndex(0);

        // Save Excel 2007 file
        $objWriter = PHPExcel_IOFactory::createWriter($this->objPHPExcel, 'Excel2007');
        $objWriter->save('cache/' . $orderId . '.xlsx');

        header("Location: cache/$orderId.xlsx");
    }

    public function showGuaranty($orderId, $data, $task) {
        $date = date("d.m.Y");

        $items   = $data->order['items'];
        $details = $data->order['details']['BT'];

        $vendor_info_id = (int) $details->vendor_info_id;
        $shopper_info   = ($details->shopper_info) ? $details->shopper_info : 'Основной клиент';
        $nrt            = $details->nrt;
        $orderdate      = date("d.m.Y", strtotime($details->created_on));
        $exchange_usd   = $details->exchange_usd;
        $nowdate        = date("d.m.Y");

        $content = "content_$task";
        $footer  = "footer_$task";
        $vendorinfo .= '<div class="vendor vendor' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$content)
                . '</div>';
        $vendorinfo2 .= '<div class="cond cond' . $data->invoicetemplates[$details->vendor_info_id]->id . '">'
                . html_entity_decode($data->invoicetemplates[$details->vendor_info_id]->$footer)
                . '</div>';

        $vr_br_count = (int) substr_count($vendorinfo, '</p>');
        if (!$vr_br_count > 0) {
            $vr_br_count = 1;
        }
        $vendorinfo = trim(strip_tags(str_replace(array('&nbsp;'), array(' '), $vendorinfo)));

        // Create a first sheet
        $this->objPHPExcel->getActiveSheet()->getRowDimension(2)->setRowHeight(22 * $vr_br_count);
        $this->objPHPExcel->setActiveSheetIndex(0);

        $center = array(
            'alignment' => array(
                'horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER,
                'vertical'   => PHPExcel_Style_Alignment::VERTICAL_TOP
            )
        );
        $this->objPHPExcel->setActiveSheetIndex(0);
        $this->objPHPExcel->getActiveSheet()->mergeCells('A1:G1')->setCellValue('A1', "Гарантийный талон");

        $this->objPHPExcel->getActiveSheet()->setCellValue('A2', "Кол-во");
        $this->objPHPExcel->getActiveSheet()->setCellValue('B2', "Наименование");
        $this->objPHPExcel->getActiveSheet()->setCellValue('C2', "Артикул");
        $this->objPHPExcel->getActiveSheet()->setCellValue('D2', "Цена");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E2', "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('F2', "Серийник");
        $this->objPHPExcel->getActiveSheet()->setCellValue('G2', "Гарантия");

        $total = 0;
        $i     = 0;
        $z     = 3;
        foreach ($items as $row) {
            $i++;
            $z++;
            $itemname  = $row->order_item_name;
            $itemsku   = str_replace('sklad-', '', $row->order_item_sku);
            $itemcount = $row->product_quantity;
            $itemprice = $row->product_final_price * (1 + $nrt / 100);
            $itemprice = round($details->order_currency == '202' ? $itemprice * $exchange_usd : $itemprice);
            $itemitogo = round($itemprice * $itemcount);

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

            $this->objPHPExcel->getActiveSheet()->setCellValue('A' . $z, $itemcount);
            $this->objPHPExcel->getActiveSheet()->setCellValue('B' . $z, str_replace('&amp;', '&', $itemname))->getStyle('B' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('C' . $z, $itemsku);
            $this->objPHPExcel->getActiveSheet()->setCellValue('D' . $z, $itemprice);
            $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $itemitogo);
            $this->objPHPExcel->getActiveSheet()->setCellValue('F' . $z, $sn)->getStyle('B' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->setCellValue('G' . $z, $garantiya);

            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('A' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('B' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('C' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('D' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('E' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('F' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $this->objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
            $this->objPHPExcel->getActiveSheet()->getStyle('G' . $z)->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

            $total += $itemitogo;
        }
        $total          = round($total);
        $NumberAnalyser = new NumberAnaliz();
        $totalstr       = $NumberAnalyser->CurrencyToText($total, "KGS");

        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setName('Arial');
        $this->objPHPExcel->getActiveSheet()->getDefaultStyle()->getFont()->setSize(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(6);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(40);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(8);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(10);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1')->getFont()->setSize(20);
        $this->objPHPExcel->getActiveSheet()->getStyle('A1:G1')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A2:G2')->getBorders()->getBottom()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));


        $this->objPHPExcel->getActiveSheet()->getStyle('A2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('A2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('B2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('B2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('C2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('C2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('D2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('D2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('E2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('E2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('F2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('F2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));

        $this->objPHPExcel->getActiveSheet()->getStyle('G2')->getBorders()->getLeft()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));
        $this->objPHPExcel->getActiveSheet()->getStyle('G2')->getBorders()->getRight()->applyFromArray(array('style' => PHPExcel_Style_Border::BORDER_THIN, 'color' => array('rgb' => '000000')));


        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':B' . $z)->setCellValue('A' . $z, "Итого");
        $this->objPHPExcel->getActiveSheet()->setCellValue('E' . $z, $total);
        $z++;
        $this->objPHPExcel->getActiveSheet()->mergeCells('F' . $z . ':G' . $z)->setCellValue('F' . $z, $orderdate);

        if ($i == 1) {
            $db  = JFactory::getDbo();
            $sql = 'SELECT `fulltext` FROM `#__content` WHERE `id`=10';

            $db->setQuery($sql);
            $material = html_entity_decode(str_replace('src="', 'src="../', $db->LoadResult()));

            $z++;
            $this->objPHPExcel->getActiveSheet()->mergeCells('A' . $z . ':G' . $z)->setCellValue('A' . $z, $material)->getStyle('A' . $z)->getAlignment()->setWrapText(true);
            $this->objPHPExcel->getActiveSheet()->getRowDimension($z)->setRowHeight(900);
        }

        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $this->objPHPExcel->setActiveSheetIndex(0);

        // Save Excel 2007 file
        $objWriter = PHPExcel_IOFactory::createWriter($this->objPHPExcel, 'Excel2007');
        $objWriter->save('cache/' . $orderId . '.xlsx');

        header("Location: cache/$orderId.xlsx");
    }

}
