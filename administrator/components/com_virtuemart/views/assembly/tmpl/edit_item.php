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
    $i = 0;
    foreach ($this->assembly->items as $items) {
        ?>
        <tr>
            <td>
                <input 
                    type="text" 
                    value="<?php echo $items->product_id; ?>" 
                    size="10" 
                    name="products[<?php echo $i; ?>][id]" 
                    id="products[<?php echo $i; ?>][id]" 
                    class="inputbox" 
                    />
            </td>
            <td>
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
                    id="del_<?php echo $i; ?>" 
                    class="delete btn modal-button"
                    />
            </td>
        </tr>
        <?php
        $i++;
    }
} else {
    ?>
    <tr>
        <td>
            <input 
                type="text" 
                value="" 
                size="10" 
                name="products[0][id]" 
                id="products[0][id]" 
                class="inputbox" 
                />
        </td>
        <td>
            <input 
                type="text" 
                value="1" 
                size="2" 
                name="products[0][count]" 
                id="products[0][count]" 
                class="inputbox" 
                />
        </td>
            <td valign="top">
                <input 
                    type="button" 
                    value="<?php echo vmText::_('COM_VIRTUEMART_ASSEMBLY_DEL_PRODUCTS'); ?>" 
                    id="del_0" 
                    class="delete btn modal-button"
                    />
            </td>
    </tr>
<?php
}