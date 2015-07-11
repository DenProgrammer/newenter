<?php
/**
 *
 * Description
 *
 * @package	VirtueMart
 * @subpackage OrderStatus
 * @author Oscar van Eijk
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: edit.php 8080 2014-06-29 07:31:28Z alatak $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if (count($this->assembly->items) > 0) {
    $i = 1;
    foreach ($this->assembly->items as $items) {
        ?>
        <tr id="row_<?php echo $i; ?>">
            <td valign="top">
                <input 
                    type="hidden" 
                    value="<?php echo $items->product_id; ?>" 
                    name="products[<?php echo $i; ?>][id]" 
                    id="products_<?php echo $i; ?>_id" 
                    class="inputbox" 
                    />
                <input 
                    type="text" 
                    value="<?php echo $items->product_name; ?>" 
                    name="products[<?php echo $i; ?>][name]" 
                    id="products_<?php echo $i; ?>_name" 
                    class="inputbox" 
                    />
            </td>
            <td valign="top">
                <a 
                    rel="{handler: 'iframe', size: {x: 700, y: 400}}" 
                    href="index.php?option=com_virtuemart&view=product&layout=modal&tmpl=component&fieldId=<?php echo $i; ?>" 
                    title="Выбрать продукт" 
                    class="btn modal-button"
                    >
                    <span class="icon-file-add"></span>
                    Продукт	
                </a>
            </td>
            <td valign="top">
                <input 
                    type="text" 
                    value="<?php echo $items->product_count; ?>" 
                    size="2" 
                    name="products[<?php echo $i; ?>][count]" 
                    id="products[<?php echo $i; ?>][count]" 
                    class="inputbox" 
                    />
            </td>
            <td valign="top">
                <input 
                    type="button" 
                    value="<?php echo vmText::_('COM_VIRTUEMART_ASSEMBLY_DEL_PRODUCTS'); ?>" 
                    onclick="deleteRow(<?php echo $i; ?>)" 
                    class="delete btn modal-button"
                    />
            </td>
        </tr>
        <?php
        $i++;
    }
}