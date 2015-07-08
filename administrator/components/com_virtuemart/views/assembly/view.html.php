<?php

/**
 *
 * Description
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
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

// Load the view framework
if (!class_exists('VmViewAdmin'))
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'vmviewadmin.php');

/**
 * HTML View class for the VirtueMart Component
 *
 * @package		VirtueMart
 * @author
 */
class VirtuemartViewAssembly extends VmViewAdmin {

    function display($tpl = null) {
        if (!class_exists('VmHTML')) {
            require(VMPATH_ADMIN . DS . 'helpers' . DS . 'html.php');
        }

        $model = VmModel::getModel('assembly');

        $layoutName = vRequest::getCmd('layout', 'default');

        if ($layoutName == 'edit') {
            $cid = JRequest::getVar('cid');

            if (is_array($cid)) {
                $assembly_id = isset($cid[0]) ? $cid[0] : 0;
            } else {
                $assembly_id = intval($cid);
            }
            $assembly = $model->getAssembly($assembly_id);

            $assembly->items = $model->getAssemblyProducts($assembly->id);
            $this->SetViewTitle('', vmText::_($assembly->title));

            $model->addImages($assembly);

            $this->assignRef('assembly', $assembly);

            $this->addStandardEditViewCommands();
        } else {
            $this->SetViewTitle('');
            $this->addStandardDefaultViewCommands();

            $assemblies = $model->getAssemblies();
            $this->assignRef('assemblies', $assemblies);

            $pagination = $model->getPagination();
            $this->assignRef('pagination', $pagination);
        }

        parent::display($tpl);
    }

}
