<?php

/**
 *
 * Description
 *
 * @package    VirtueMart
 * @subpackage
 * @author Max Milbers, Patrick Kohl, Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2014 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: product.php 8578 2014-11-18 18:24:06Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');


if (!class_exists('VmModel')) {
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'vmmodel.php');
}

/**
 * Model for VirtueMart Invoices
 *
 * @package VirtueMart
 * @author Denis Shiryaev
 */
class VirtueMartModelInvoicetemplates extends VmModel {

    /**
     * constructs a VmModel
     * setMainTable defines the maintable of the model
     * @author Max Milbers
     */
    function __construct() {
        parent::__construct();
        VmConfig::loadJLang('com_virtuemart_orders', TRUE);
        $this->setMainTable('invoicetemplates');
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getInvoicetemplates($where = '') {
        $db = JFactory::getDbo();

        $sql    = 'SELECT * FROM `#__virtuemart_invoicetemplates` ' . $where;
        $db->setQuery($sql);
        $result = $db->loadObjectList();

        $data = array();
        foreach ($result as $item) {
            $data[$item->id] = $item;
        }

        return $data;
    }

}

// No closing tag