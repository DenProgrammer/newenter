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

class VirtuemartViewInvoicetemplates extends VmViewAdmin {

    function display($tpl = null) {
        if (!class_exists('VmHTML')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'html.php');
        }

        $model = VmModel::getModel();

        $layoutName = vRequest::getCmd('layout', 'default');

        if ($layoutName == 'edit') {
            $invoicetemplates = $model->getData();
            $this->SetViewTitle('', vmText::_($invoicetemplates->title));

            $this->assignRef('invoicetemplates', $invoicetemplates);

            $this->addStandardEditViewCommands();
        } else {
            $this->SetViewTitle('');
            $this->addStandardDefaultViewCommands();

            $invoicetemplates = $model->getInvoicetemplates();
            $this->assignRef('invoicetemplates', $invoicetemplates);

            $pagination = $model->getPagination();
            $this->assignRef('pagination', $pagination);
        }

        parent::display($tpl);
    }

}

//pure php no closing tag
