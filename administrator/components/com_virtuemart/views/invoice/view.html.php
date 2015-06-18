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
        $task    = vRequest::getCmd('task', $this->getLayout());
        $orderId = vRequest::getInt('order_id', 0);

        // Load helpers
        if (!class_exists('NumberAnaliz')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'string.php');
        }

        if (is_file(VMPATH_ADMIN . DS . 'views/invoice/tmpl/default_' . $task . '.php')) {
            $tpl  = $task;
            $data = $this->prepareData($task, $orderId);
            $this->assignRef('data', $data);
        }


        parent::display($tpl);
    }

    protected function prepareData($type, $orderId) {
        $data    = new stdClass();
        $invoice = VmModel::getModel('invoice');

        $data->invoicetemplates = $invoice->getTemplates();

        switch ($type) {
            case 'commercial_invoice': 
            case 'invoice_payment': 
            case 'waybill': 
            case 'guaranty': 
            case 'commercial_offer': {
                    $orderModel     = VmModel::getModel('orders');
                    $NumberAnalyser = new NumberAnaliz();

                    $data->order = $orderModel->getOrder($orderId);

                    $total = round($data->order['details']['BT']->order_total);

                    $data->document_id  = rand(1, 1000);
                    $data->total_string = $NumberAnalyser->CurrencyToText($total, "USD");

                    break;
                }
        }

        return $data;
    }

}

//pure php no closing tag
