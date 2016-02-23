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
?>
<table class="html-email" width="100%" cellspacing="0" cellpadding="0" border="0">
    <tr align="left" class="sectiontableheader">
        <td align="center" width="6%"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_QTY') ?></strong></td>
        <td align="center" colspan="2" ><strong><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_NAME_TITLE') ?></strong></td>
        <td align="center" width="8%"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_SKU') ?></strong></td>
        <?php if ($this->doctype == 'invoice') { ?>
            <td align="center" width="8%" ><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PRICE') ?></strong></td>
        <?php } ?>
        <?php if ($this->doctype == 'invoice') { ?>
            <td align="center" width="8%"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></strong></td>
        <?php } ?>
    </tr>

    <?php
    $menuItemID = shopFunctionsF::getMenuItemId($this->orderDetails['details']['BT']->order_language);

    foreach ($this->orderDetails['items'] as $item) {
        $qtt               = $item->product_quantity;
        $product_link      = JURI::root().'index.php?option=com_virtuemart&view=productdetails&virtuemart_category_id='.$item->virtuemart_category_id.
                '&virtuemart_product_id='.$item->virtuemart_product_id.'&Itemid='.$menuItemID;
        ?>
        <tr valign="top">
            <td align="center" >
                <?php echo $qtt; ?>
            </td>
            <td align="left" colspan="2" >
                <div float="right" ><a href="<?php echo $product_link; ?>"><?php echo $item->order_item_name; ?></a></div>
                <?php
                //if (!empty($item->product_attribute)) {
                if (!class_exists('VirtueMartModelCustomfields'))
                    require(VMPATH_ADMIN.DS.'models'.DS.'customfields.php');
                $product_attribute = VirtueMartModelCustomfields::CustomsFieldOrderDisplay($item, 'FE');
                echo $product_attribute;
                //}
                ?>
            </td>
            <td align="left">
                <?php echo $item->order_item_sku; ?>
            </td>
            <?php if ($this->doctype == 'invoice') { ?>
                <td align="right"   class="priceCol" >
                    <?php
                    $item->product_discountedPriceWithoutTax = (float) $item->product_discountedPriceWithoutTax;
                    if (!empty($item->product_priceWithoutTax) && $item->product_discountedPriceWithoutTax != $item->product_priceWithoutTax) {
                        echo '<span class="line-through">'.$this->currency->priceDisplay($item->product_item_price, $this->currency).'</span><br />';
                        echo '<span >'.$this->currency->priceDisplay($item->product_discountedPriceWithoutTax, $this->currency).'</span><br />';
                    } else {
                        echo '<span >'.$this->currency->priceDisplay($item->product_item_price, $this->currency).'</span><br />';
                    }
                    ?>
                </td>
            <?php } ?>
            <?php if ($this->doctype == 'invoice') { ?>
                <td align="right"  class="priceCol">
                    <?php
                    $item->product_basePriceWithTax = (float) $item->product_basePriceWithTax;
                    $class                          = '';
                    if (!empty($item->product_basePriceWithTax) && $item->product_basePriceWithTax != $item->product_final_price) {
                        echo '<span class="line-through" >'.$this->currency->priceDisplay($item->product_basePriceWithTax, $this->currency, $qtt).'</span><br />';
                    } elseif (empty($item->product_basePriceWithTax) && $item->product_item_price != $item->product_final_price) {
                        echo '<span class="line-through">'.$this->currency->priceDisplay($item->product_item_price, $this->currency, $qtt).'</span><br />';
                    }

                    echo $this->currency->priceDisplay($item->product_subtotal_with_tax, $this->currency); //No quantity or you must use product_final_price 
                    ?>
                </td>
            <?php } ?>
        </tr>

        <?php
    }
    ?>
    <?php if ($this->doctype == 'invoice') { ?>
        <tr><td colspan="6"><hr></td></tr>
        <tr>
            <td align="right" class="pricePad" colspan="5"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></strong></td>
            <td align="right"><strong><?php echo $this->currency->priceDisplay($this->orderDetails['details']['BT']->order_total, $this->currency); ?></strong></td>
        </tr>

    <?php } ?>
</table>
