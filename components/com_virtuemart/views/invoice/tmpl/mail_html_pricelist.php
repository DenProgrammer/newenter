<?php
/**
 *
 * Layout for the shopping cart
 *
 * @package	VirtueMart
 * @subpackage Cart
 * @author Max Milbers, Valerie Isaksen
 *
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 *
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

$oldlayout = $this->getLayout();
$this->setLayout('invoice');
echo $this->loadTemplate('items');
$this->setLayout($oldlayout);
?>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="html-email">
    <tr>
        <td colspan="2">
            <hr />
        </td>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Примечание покупателя:
        </td>
        <td class="vmdoc-header-text">
            <?php echo $this->orderDetails['details']['BT']->note; ?>
        </td>
    </tr>
</table>

