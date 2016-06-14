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
?>
<div class="col50">
    <input type="button" id="addItem" class="btn modal-button" 
           value="<?php echo vmText::_('COM_VIRTUEMART_ASSEMBLY_ADD_PRODUCTS'); ?>" />
    <br />
    <br />
    <table class="admintable" id="items">
        <tr>
            <td>Product Type</td>
            <td>Product ID</td>
            <td>Count</td>
            <td>&nbsp;</td>
        </tr>
        <?php
        echo $this->loadTemplate('item');
        ?>
    </table>
</div>


