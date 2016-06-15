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
class VirtueMartModelAssembly extends VmModel {

    /**
     * constructs a VmModel
     * setMainTable defines the maintable of the model
     * @author Max Milbers
     */
    function __construct() {
        parent::__construct();
        VmConfig::loadJLang('com_virtuemart_orders', TRUE);
        $this->setMainTable('assembly');
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getAssemblyProducts($assembly_id = 0) {

        $db = JFactory::getDbo();
        if (!$assembly_id > 0) {
            return array();
        }
        $db->setQuery('SELECT ap.*, ('
                . '     SELECT product_name FROM #__virtuemart_products_ru_ru '
                . '     WHERE virtuemart_product_id = ap.product_id'
                . ') AS product_name FROM #__virtuemart_assembly_products ap '
                . 'WHERE ap.assembly_id = ' . $assembly_id);
        $rows = $db->loadObjectList();

        $assembly = array();
        foreach ($rows as $row) {
            $assembly[$row->product_id] = $row;
        }

        return $assembly;
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getAssemblies($where = '') {

        $ordering = $this->_getOrdering();

        $this->_noLimit = true;
        $this->_data    = $this->exeSortSearchListQuery(0, '*', ' FROM `#__virtuemart_assembly`', '', $where, $ordering);

        return $this->_data;
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getAssembly($assembly_id = 0, $onlyPubished = false) {
        $db = JFactory::getDbo();

        $sql = 'SELECT * FROM #__virtuemart_assembly WHERE id = ' . $assembly_id;
        
        if ($onlyPubished){
            $sql .= ' AND published = 1 ';
        }
        
        $db->setQuery($sql);
        $assembly = $db->loadObject();

        if (!$assembly && $onlyPubished) {
            return false;
        }
        
        if (!$assembly) {
            $assembly = $this->getTable('assembly');
        }

        if (!class_exists('TableAssembly_medias')) {
            require(VMPATH_ADMIN . DS . 'tables' . DS . 'assembly_medias.php');
        }

        $xrefTable = new TableAssembly_medias($db);

        $assembly->virtuemart_media_id = $xrefTable->load($assembly->id);

        return $assembly;
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getAllAssemblies() {
        $db = JFactory::getDbo();

        $db->setQuery('SELECT id FROM #__virtuemart_assembly');
        return $db->loadObjectList();
    }

    /**
     * Retrieve a list of order statuses from the database.
     *
     * @return object List of order status objects
     */
    function getAssemblyIds($assembly_id) {
        $db = JFactory::getDbo();

        $db->setQuery('SELECT product_id FROM #__virtuemart_assembly_products '
                . 'WHERE assembly_id = ' . $assembly_id);
        $rows = $db->loadObjectList();

        $ids = array();
        foreach ($rows as $row) {
            $ids[] = $row->product_id;
        }

        return $ids;
    }

    /**
     * save assembly
     * 
     * @param array $data
     * @return integer
     */
    public function store(&$data) {
        $db = JFactory::getDbo();
        $id = parent::store($data);

        $sqlDel = "DELETE FROM #__virtuemart_assembly_products WHERE assembly_id = $id";
        $db->setQuery($sqlDel);
        $db->execute();

        $sqlIns  = 'INSERT INTO #__virtuemart_assembly_products (assembly_id, product_id, product_count, product_type) VALUES ';
        $inserts = array();
        foreach ($data['products'] as $item) {
            if ($item['id'] > 0 && $item['count'] > 0) {
                $inserts[] = '(' . $id . ', ' . $item['id'] . ', ' . $item['count'] . ', \'' . $item['type'] . '\')';
            }
        }

        if (count($inserts) > 0) {
            $sqlIns .= implode(', ', $inserts);
            $db->setQuery($sqlIns);
            $db->execute();
        }

        // Process the images
        $mediaModel = VmModel::getModel('Media');
        $file_id    = $mediaModel->storeMedia($data, 'assembly');
        $errors     = $mediaModel->getErrors();
        foreach ($errors as $error) {
            vmError($error);
        }

        return $id;
    }

    /**
     * Delete all record ids selected
     *
     * @author Max Milbers
     * @return boolean True is the delete was successful, false otherwise.
     */
    public function remove($ids) {
        $db = JFactory::getDbo();
        if (parent::remove($ids)) {
            $db->setQuery('DELETE FROM #__virtuemart_assembly_products '
                    . 'WHERE assembly_id IN (' . implode(',', $ids) . ')');
            $db->execute();

            return true;
        }

        return false;
    }

}

// No closing tag