<?php

/**
 *
 * Handle the category view
 *
 * @package	VirtueMart
 * @subpackage
 * @author RolandD
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: view.html.php 8532 2014-10-27 14:47:41Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

// Load the view framework
if (!class_exists('VmView'))
    require(VMPATH_SITE . DS . 'helpers' . DS . 'vmview.php');

/**
 * Handle the category view
 *
 * @package VirtueMart
 * @author RolandD
 * @todo set meta data
 * @todo add full path to breadcrumb
 */
class VirtuemartViewAssembly extends VmView {

    /**
     * display view
     * 
     * @param string $tpl
     * @return boolean
     */
    public function display($tpl = null) {
        if (!class_exists('calculationHelper')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'calculationh.php');
        }

        if (!class_exists('shopFunctionsF')) {
            require(VMPATH_SITE . DS . 'helpers' . DS . 'shopfunctionsf.php');
        }

        // add javascript for price and cart, need even for quantity buttons, so we need it almost anywhere
        vmJsApi::jPrice();

        $document = JFactory::getDocument();
        $app      = JFactory::getApplication();

        if (!class_exists('VmImage')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'image.php');
        }

        $this->assemblyId = vRequest::getInt('assembly_id', -1);

        $assemblyModel = VmModel::getModel('assembly');

        if (vRequest::getCmd('layout', 'default') == 'list') {
            $this->setLayout('list');

            $assemblyIds = vRequest::getInt('assembly_ids', -1);
            $assembly    = array();
            foreach ($assemblyIds as $item) {
                $assemblyItem = $assemblyModel->getAssembly($item);
                $this->getAssemblyData($assemblyItem);
                $assembly[]   = $assemblyItem;
                unset($assemblyItem);
            }
        } else {
            $assembly = $assemblyModel->getAssembly($this->assemblyId);
            $this->getAssemblyData($assembly);
        }

        $this->assignRef('assembly', $assembly);

        // Set the titles
        if (isset($assembly->title)) {
            $title = strip_tags($assembly->title);
        } else {
            $title = $this->setTitleByJMenu($app);
        }

        if (vRequest::getInt('error')) {
            $title .=' ' . vmText::_('COM_VIRTUEMART_PRODUCT_NOT_FOUND');
        }

        $document->setTitle($title);

        parent::display($tpl);
    }

    protected function getAssemblyData(&$assembly) {
        $assemblyModel = VmModel::getModel('assembly');
        $productModel  = VmModel::getModel('product');

        if (!empty($assembly)) {

            // Load the products in the given category
            $ids = $assemblyModel->getAssemblyIds($assembly->id);

            $assembly->assemblyProducts = $assemblyModel->getAssemblyProducts($assembly->id);

            $this->perRow       = 1;
            $assembly->products = $productModel->getProducts($ids, 1, 1, false);

            $productModel->addImages($assembly->products, 1);

            if ($assembly->products) {
                $assembly->currency = CurrencyDisplay::getInstance();
            }

            $assemblyModel->addImages($assembly, 1);

            $this->productsLayout = 'products';
        } else {
            //Backward compatibility
            if (!isset($assembly)) {
                $assembly = new stdClass();

                $assembly->title       = '';
                $assembly->description = '';
            }
        }
    }

    /**
     * set title by JMenu
     * 
     * @param object $app
     * @return string
     */
    public function setTitleByJMenu($app) {
        $menus = $app->getMenu();
        $menu  = $menus->getActive();

        $title = 'VirtueMart Category View';
        if ($menu)
            $title = $menu->title;
        // $title = $this->params->get('page_title', '');
        // Check for empty title and add site name if param is set
        if (empty($title)) {
            $title = $app->getCfg('sitename');
        } elseif ($app->getCfg('sitename_pagetitles', 0) == 1) {
            $title = vmText::sprintf('JPAGETITLE', $app->getCfg('sitename'), $title);
        } elseif ($app->getCfg('sitename_pagetitles', 0) == 2) {
            $title = vmText::sprintf('JPAGETITLE', $title, $app->getCfg('sitename'));
        }
        return $title;
    }

    /**
     * set canonical link
     * 
     * @param string  $tpl
     * @param object  $document
     * @param integer $categoryId
     * @param integer $manId
     */
    public function setCanonicalLink($tpl, $document, $categoryId, $manId) {
        // Set Canonic link
        if (!empty($tpl)) {
            $format = $tpl;
        } else {
            $format = vRequest::getCmd('format', 'html');
        }
        if ($format == 'html') {

            $link = 'index.php?option=com_virtuemart&view=category';
            if ($categoryId !== -1) {
                $link .= '&virtuemart_category_id=' . $categoryId;
            }
            if ($manId !== -1) {
                $link .= '&virtuemart_manufacturer_id=' . $manId;
            }

            $document->addHeadLink(JRoute::_($link, FALSE), 'canonical', 'rel', '');
        }
    }

    /**
     * generate custom fields list to display as search in FE
     */
    public function getSearchCustom() {

        $emptyOption            = array('virtuemart_custom_id' => 0, 'custom_title' => vmText::_('COM_VIRTUEMART_LIST_EMPTY_OPTION'));
        $this->_db              = JFactory::getDBO();
        $this->_db->setQuery('SELECT `virtuemart_custom_id`, `custom_title` FROM `#__virtuemart_customs` WHERE `field_type` ="P"');
        $this->options          = $this->_db->loadAssocList();
        $this->custom_parent_id = 0;
        if ($this->custom_parent_id = vRequest::getInt('custom_parent_id', 0)) {
            $this->_db->setQuery('SELECT `virtuemart_custom_id`, `custom_title` FROM `#__virtuemart_customs` WHERE custom_parent_id=' . $this->custom_parent_id);
            $this->selected           = $this->_db->loadObjectList();
            $this->searchCustomValues = '';
            foreach ($this->selected as $selected) {
                $this->_db->setQuery('SELECT `custom_value` as virtuemart_custom_id,`custom_value` as custom_title FROM `#__virtuemart_product_customfields` WHERE virtuemart_custom_id=' . $selected->virtuemart_custom_id);
                $valueOptions = $this->_db->loadAssocList();
                $valueOptions = array_merge(array($emptyOption), $valueOptions);
                $this->searchCustomValues .= vmText::_($selected->custom_title) . ' ' . JHtml::_('select.genericlist', $valueOptions, 'customfields[' . $selected->virtuemart_custom_id . ']', 'class="inputbox"', 'virtuemart_custom_id', 'custom_title', 0);
            }
        }

        // add search for declared plugins
        JPluginHelper::importPlugin('vmcustom');
        $dispatcher = JDispatcher::getInstance();
        $plgDisplay = $dispatcher->trigger('plgVmSelectSearchableCustom', array(&$this->options, &$this->searchCustomValues, $this->custom_parent_id));

        if (!empty($this->options)) {
            $this->options          = array_merge(array($emptyOption), $this->options);
            // render List of available groups
            vmJsApi::chosenDropDowns();
            $this->searchCustomList = vmText::_('COM_VIRTUEMART_SET_PRODUCT_TYPE') . ' ' . JHtml::_('select.genericlist', $this->options, 'custom_parent_id', 'class="inputbox vm-chzn-select"', 'virtuemart_custom_id', 'custom_title', $this->custom_parent_id);
        } else {
            $this->searchCustomList = '';
        }
    }

}
