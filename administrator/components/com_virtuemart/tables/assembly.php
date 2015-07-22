<?php

/**
 *
 * Order status table
 *
 * @package	VirtueMart
 * @subpackage Order status
 * @author Oscar van Eijk
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: orderstates.php 8310 2014-09-21 17:51:47Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if (!class_exists('VmTable')) {
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'vmtable.php');
}

/**
 * Order status table class
 * The class is is used to manage the order statuses in the shop.
 *
 * @package	VirtueMart
 * @author Oscar van Eijk
 * @author Max Milbers
 */
class TableAssembly extends VmTable {

    /** @var int Primary key */
    var $id          = 0;
    var $title       = null;
    var $showimage   = null;
    var $description = null;
    var $alias       = null;

    /** @var int published or unpublished */
    var $published = 1;

    /**
     * @param $db Class constructor; connect to the database
     */
    public function __construct(&$db) {

        parent::__construct('#__virtuemart_assembly', 'id', $db);

        $this->setLoggable();
    }

}
