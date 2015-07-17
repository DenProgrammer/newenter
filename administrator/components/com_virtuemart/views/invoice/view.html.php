<?php

/**
 *
 * View class for the product
 *
 * @package	VirtueMart
 * @subpackage
 * @author
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: view.html.php 8533 2014-10-27 18:10:04Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

/**
 * HTML View class for the VirtueMart Component
 *
 * @package		VirtueMart
 * @author RolandD,Max Milbers
 */
if (!class_exists('VmViewAdmin')) {
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'vmviewadmin.php');
}

class VirtuemartViewInvoice extends VmViewAdmin {

    function display($tpl = null) {

        // Get the task
        $task    = vRequest::getCmd('task');
        $layout  = vRequest::getCmd('layout', $this->getLayout());
        $orderId = vRequest::getInt('order_id', 0);
        // Load helpers
        if (!class_exists('NumberAnaliz')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'string.php');
        }
        if (!class_exists('PHPExcel')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'PHPExcel.php');
        }
        if (!class_exists('IOFactory')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'PHPExcel/IOFactory.php');
        }

        $tpl  = $task;
        $data = $this->prepareData($task, $orderId);
        $this->assignRef('data', $data);

//        if (JRequest::getVar('type') == 'excel') {
//            $html = $this->loadTemplate($task);
//
//            $inputFileType  = 'HTML';
//            $inputFileName  = 'test.html';
//            $outputFileType = 'Excel2007';
//            $outputFileName = 'myExcelFile.xlsx';
//
//            $objPHPExcelReader = PHPExcel_IOFactory::createReader($inputFileType);
//            $objPHPExcel       = $objPHPExcelReader->load($inputFileName);
//
//            $objPHPExcelWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $outputFileType);
//            $objPHPExcel       = $objPHPExcelWriter->save($outputFileName);
//            echo $html;
//        }
        parent::display($tpl);
    }

    protected function prepareData($type, $orderId) {
        $data    = new stdClass();
        $invoice = VmModel::getModel('invoice');
        $db      = JFactory::getDBO();

        $data->invoicetemplates = $invoice->getTemplates();

        switch ($type) {
            case 'commercial_invoice':
            case 'invoice_payment':
            case 'waybill':
            case 'commercial_offer': {
                    $orderModel     = VmModel::getModel('orders');
                    $NumberAnalyser = new NumberAnaliz();

                    $data->order = $orderModel->getOrder($orderId);

                    $this->exchange = $data->order['details']['BT']->exchange_usd;

                    if ($data->order['details']['BT']->order_currency == 165) {
                        $total = round($data->order['details']['BT']->order_total);
                    } else {
                        $total = round($data->order['details']['BT']->order_total * $this->exchange);
                    }
                    $data->document_id  = rand(1, 1000);
                    $data->total_string = $NumberAnalyser->CurrencyToText($total, "KGS");

                    break;
                }
            case 'guaranty': {
                    $orderModel     = VmModel::getModel('orders');
                    $NumberAnalyser = new NumberAnaliz();

                    $data->order = $orderModel->getOrder($orderId);

                    $this->exchange = $data->order['details']['BT']->exchange_usd;

                    if ($data->order['details']['BT']->order_currency == 165) {
                        $total = round($data->order['details']['BT']->order_total);
                    } else {
                        $total = round($data->order['details']['BT']->order_total * $this->exchange);
                    }
                    $data->document_id  = rand(1, 1000);
                    $data->total_string = $NumberAnalyser->CurrencyToText($total, "KGS");

                    $data->guaranty = null;
                    if (count($data->order['items']) == 1) {
                        $sql = 'SELECT `fulltext` FROM `#__content` WHERE `id`=10';

                        $db->setQuery($sql);
                        $data->guaranty = str_replace('src="', 'src="../', $db->LoadResult());
                    }

                    break;
                }
            case 'app': {
                    $sql = 'SELECT `fulltext` FROM `#__content` WHERE `id`=10';

                    $db->setQuery($sql);
                    $data = str_replace('src="', 'src="../', $db->LoadResult());

                    break;
                }
        }

        return $data;
    }

}

//pure php no closing tag
