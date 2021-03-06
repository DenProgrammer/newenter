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
class VirtuemartControllerInvoicetemplates extends VmController {

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

}

// pure php no closing tag
