<?php
/**
 *
 * Order items view
 *
 * @package	VirtueMart
 * @subpackage Orders
 * @author Max Milbers, Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: details_items.php 5432 2012-02-14 02:20:35Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

$colspan = 8;

if ($this->doctype != 'invoice') {
    $colspan -= 4;
} elseif (!VmConfig::get('show_tax')) {
    $colspan -= 1;
}

$details = $this->orderDetails['details']['BT'];
?>
<table class="html-email" width="100%" cellspacing="0" cellpadding="0" border="1">
    <tr align="left" class="sectiontableheader">
        <th align="center" width="20"><strong>№<br /> п/п</strong></th>
        <th align="center" width="20"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_QTY') ?></strong></th>
        <th align="center" colspan="2" ><strong><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_NAME_TITLE') ?></strong></th>
        <th align="center" width="80"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_SKU') ?></strong></th>
        <?php if ($this->doctype == 'invoice') { ?>
            <th align="center" width="120" ><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PRICE') ?></strong></th>
        <?php } ?>
        <?php if ($this->doctype == 'invoice') { ?>
            <th align="center" width="140"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></strong></th>
        <?php } ?>
    </tr>

    <?php
    $menuItemID = shopFunctionsF::getMenuItemId($this->orderDetails['details']['BT']->order_language);

    $countAllProducts  = 0;
    $countAllPositions = 0;

    foreach ($this->orderDetails['items'] as $item) {
        $countAllPositions++;
        $countAllProducts += $item->product_quantity;

        $qtt          = $item->product_quantity;
        $product_link = JURI::root().'index.php?option=com_virtuemart&view=productdetails&virtuemart_category_id='.$item->virtuemart_category_id.
                '&virtuemart_product_id='.$item->virtuemart_product_id.'&Itemid='.$menuItemID;
        ?>
        <tr valign="top">
            <td align="center" >
                <?php echo $countAllPositions; ?>
            </td>
            <td align="center" >
                <?php echo $qtt; ?>
            </td>
            <td align="left" colspan="2" >
                <?php echo html_entity_decode($item->order_item_name); ?>
            </td>
            <td align="center">
                <?php echo str_replace('sklad-', '', $item->order_item_sku); ?>
            </td>
            <?php if ($this->doctype == 'invoice') { ?>
                <td align="center"   class="priceCol" >
                    <?php
                    echo round($this->currency->roundForDisplay($item->product_item_price, 165, 1, 0))
                    .' '.JText::_('COM_VIRTUEMART_CURRENCY_KGS').' / '
                    .round($item->product_item_price, 2).' $';
                    ?>
                </td>
            <?php } ?>
            <?php if ($this->doctype == 'invoice') { ?>
                <td align="center"  class="priceCol">
                    <?php
                    echo round($item->product_subtotal_with_tax * $details->exchange_usd).' '
                    .JText::_('COM_VIRTUEMART_CURRENCY_KGS')
                    .' / '
                    .$this->currency->priceDisplay($item->product_subtotal_with_tax, $this->currency);
                    ?>
                </td>
            <?php } ?>
        </tr>

        <?php
    }
    ?>
    <?php if ($this->doctype == 'invoice') { ?>
        <tr>
            <td align="right" class="pricePad" colspan="4">
                <b>Продуктов - <?php echo $countAllProducts; ?></b>&nbsp;&nbsp;
                <b>Артикулов - <?php echo $countAllPositions; ?></b>&nbsp;&nbsp;
            </td>
            <td align="right" class="pricePad" colspan="2">
                <b><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></b>&nbsp;&nbsp;
            </td>
            <td align="center">
                <b> <?php
                    echo round($this->orderDetails['details']['BT']->order_total * $details->exchange_usd).' '
                    .JText::_('COM_VIRTUEMART_CURRENCY_KGS')
                    .' / '
                    .$this->currency->priceDisplay($this->orderDetails['details']['BT']->order_total, $this->currency);
                    ?></b>
            </td>
        </tr>

    <?php } ?>
</table>
