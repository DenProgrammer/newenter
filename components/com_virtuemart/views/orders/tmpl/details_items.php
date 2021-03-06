<?php
/**
 *
 * Order items view
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
 * @version $Id: details_items.php 8310 2014-09-21 17:51:47Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if ($this->format == 'pdf') {
    $widthTable = '100';
    $widthTitle = '27';
} else {
    $widthTable = '100';
    $widthTitle = '49';
}
?>
<table width="<?php echo $widthTable ?>%" cellspacing="0" cellpadding="0" border="0">
    <tr align="left" class="sectiontableheader">
        <th align="left" width="5%"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_SKU') ?></th>
        <th align="left" colspan="2" width="<?php echo $widthTitle ?>%" ><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_NAME_TITLE') ?></th>
        <th align="center" width="10%" ><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PRICE') ?></th>
        <th align="center" width="5%"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_QTY') ?></th>
        <th align="center" width="10%"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></th>
    </tr>
    <?php
    foreach ($this->orderdetails['items'] as $item) {
        $qtt   = $item->product_quantity;
        $_link = JRoute::_('index.php?option=com_virtuemart&view=productdetails&virtuemart_category_id='.$item->virtuemart_category_id.'&virtuemart_product_id='.$item->virtuemart_product_id, FALSE);
        ?>
        <tr valign="top">
            <td align="left">
                <?php echo preg_replace('/(sklad-)([0-9]{1,3})([-]{1})([0-9]*)/', '$4', $item->order_item_sku); ?>
            </td>
            <td align="left" colspan="2" >
                <div><a href="<?php echo $_link; ?>"><?php echo $item->order_item_name; ?></a></div>
                <?php
                if (!class_exists('VirtueMartModelCustomfields')) {
                    require(VMPATH_ADMIN.DS.'models'.DS.'customfields.php');
                }

                $product_attribute              = VirtueMartModelCustomfields::CustomsFieldOrderDisplay($item, 'FE');
                echo $product_attribute;
                ?>
            </td>
            <td align="right"   class="priceCol" >
                <?php
                echo (round($item->product_item_price * $this->orderdetails['details']['BT']->exchange_usd))
                .' Сом / '.round($item->product_item_price, 2).' $';
                ?>
            </td>
            <td align="right" >
                <?php echo $qtt; ?>
            </td>
            <td align="right"  class="priceCol">
                <?php
                $item->product_basePriceWithTax = (float) $item->product_basePriceWithTax;

                echo (round($item->product_subtotal_with_tax * $this->orderdetails['details']['BT']->exchange_usd))
                .' Сом / '.round($item->product_subtotal_with_tax, 2).' $';
                ?>
            </td>
        </tr>

        <?php
    }
    ?>
    <tr>
        <td align="right" class="pricePad" colspan="5"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></strong></td>
        <td align="right">
            <strong>
                <?php echo (round($this->orderdetails['details']['BT']->order_total * $this->orderdetails['details']['BT']->exchange_usd))
                .' Сом / '.round($this->orderdetails['details']['BT']->order_total, 2).' $'; ?>
            </strong>
        </td>
    </tr>

</table>
