<?php
/**
 *
 * Order detail view
 *
 * @package	VirtueMart
 * @subpackage Orders
 * @author Oscar van Eijk, Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: details_order.php 5341 2012-01-31 07:43:24Z alatak $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');
?>

<?php
if ($this->doctype == 'invoice') {
    if ($this->invoiceNumber) {
        ?>
        <h1><?php echo vmText::_('COM_VIRTUEMART_INVOICE').' '.$this->invoiceNumber; ?> </h1>
        <?php
    }
} elseif ($this->doctype == 'deliverynote') {
    ?>
    <h1><?php echo vmText::_('COM_VIRTUEMART_DELIVERYNOTE'); ?> </h1>
<?php } elseif ($this->doctype == 'confirmation') { ?>
    <h1><?php echo vmText::_('COM_VIRTUEMART_CONFIRMATION'); ?> </h1>

<?php } ?>
<br />
<table width="100%" cellspacing="0" cellpadding="0" border="0">
    <tr>
        <th align="left">Информация о клиенте</th>
        <th align="left">Информация о Заказе</th>
    </tr>
    <tr>
        <td valign="top">
            <table border="0"><?php
                foreach ($this->shipmentfields['fields'] as $field) {
                    if (!empty($field['value'])) {
                        echo '<tr><td class="key">'.$field['title'].'</td>'
                        .'<td>'.$field['value'].'</td></tr>';
                    }
                }
                ?></table>
        </td>
        <td valign="top" >
            <table border="0">
                <tr>
                    <td class="key" ><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_NUMBER') ?></td>
                    <td align="left"><strong>
                            <?php echo $this->orderDetails['details']['BT']->virtuemart_order_id; ?>
                        </strong>
                    </td>
                </tr>

                <tr>
                    <td class="key"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_DATE') ?></td>
                    <td align="left"><?php echo vmJsApi::date($this->orderDetails['details']['BT']->created_on, 'LC2', true); ?></td>
                </tr>
                <?php if ($this->orderDetails['details']['BT']->customer_note) { ?>
                    <tr>
                        <td class="key"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_CUSTOMER_NOTE') ?></td>
                        <td valign="top" align="left" width="50%"><?php echo $this->orderDetails['details']['BT']->customer_note; ?></td>
                    </tr>
                <?php } ?>
            </table>
        </td>
    </tr>
</table>
