<?php

/**
 *
 * @package	VirtueMart
 * @subpackage   Models Fields
 * @author Valérie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2011 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id:$
 */
defined('JPATH_BASE') or die;
defined('DS') or define('DS', DIRECTORY_SEPARATOR);
if (!class_exists('VmConfig'))
    require(JPATH_ROOT . DS . 'administrator' . DS . 'components' . DS . 'com_virtuemart' . DS . 'helpers' . DS . 'config.php');
if (!class_exists('ShopFunctions'))
    require(VMPATH_ADMIN . DS . 'helpers' . DS . 'shopfunctions.php');
if (!class_exists('TableCategories'))
    require(VMPATH_ADMIN . DS . 'tables' . DS . 'categories.php');
jimport('joomla.form.formfield');

/**
 * Supports a modal category picker.
 *
 *
 */
class JFormFieldAssembly extends JFormField {

    var $type = 'assembly';

    /**
     * Method to get the field input markup.
     *
     * @return	string	The field input markup.
     * @since	1.6
     */
    function getInput() {
        $db = JFactory::getDbo();

        $db->setQuery('SELECT * FROM #__virtuemart_assembly');
        $assemblylist = $db->loadObjectList();

        $html = '<select class="inputbox" multiple="multiple" name="' . $this->name . '[]" >';
        $html .= '<option value="0">' . vmText::_('COM_VIRTUEMART_ASSEMBLY') . '</option>';
        foreach ($assemblylist as $item) {
            $selected = $this->value && in_array($item->id, $this->value) ? ' selected ' : '';
            $html .= '<option ' . $selected . ' value="' . $item->id . '">' . $item->title . '</option>';
        }
        $html .="</select>";
        return $html;
    }

}
