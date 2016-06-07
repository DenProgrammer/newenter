<?php
/**
 * Display form details
 *
 * @package	VirtueMart
 * @subpackage Orders
 * @author Oscar van Eijk
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: order.php 8536 2014-10-29 10:37:31Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

AdminUIHelper::startAdminArea($this);
AdminUIHelper::imitateTabs('start', 'COM_VIRTUEMART_ORDER_PRINT_PO_LBL');

// Get the plugins
JPluginHelper::importPlugin('vmshopper');
JPluginHelper::importPlugin('vmshipment');
JPluginHelper::importPlugin('vmpayment');
?>
<div style="text-align: left;">
    <form name='adminForm' id="adminForm">
        <input type="hidden" name="task" value="" />
        <input type="hidden" name="option" value="com_virtuemart" />
        <input type="hidden" name="view" value="orders" />
        <input type="hidden" name="virtuemart_order_id" value="<?php echo $this->orderID; ?>" />
        <?php echo JHtml::_('form.token'); ?>

        <table class="adminlist table" style="table-layout: fixed;">
            <tr>
                <td valign="top">
                    <table class="adminlist" cellspacing="0" cellpadding="0">
                        <thead>
                            <tr>
                                <th colspan="2"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_LBL') ?></th>
                            </tr>
                        </thead>
                        <?php
                        $print_url  = juri::root().'index.php?option=com_virtuemart&view=invoice&layout=invoice&tmpl=component&virtuemart_order_id='.$this->orderbt->virtuemart_order_id.'&order_number='.$this->orderbt->order_number.'&order_pass='.$this->orderbt->order_pass;
                        $print_link = "<a title=\"".vmText::_('COM_VIRTUEMART_PRINT')."\" href=\"javascript:void window.open('$print_url', 'win2', 'status=no,toolbar=no,scrollbars=yes,titlebar=no,menubar=no,resizable=yes,width=640,height=480,directories=no,location=no');\"  >";
                        $print_link .= ' (Печать) </a>';
                        ?>
                        <tr>
                            <td class="key"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_NUMBER') ?></strong></td>
                            <td><?php echo $this->orderbt->virtuemart_order_id.$print_link; ?></td>
                        </tr>
                        <tr>
                            <td class="key"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_DATE') ?></strong></td>
                            <td><?php echo vmJsApi::date($this->orderbt->created_on, 'LC2', true); ?></td>
                        </tr>
                        <tr>
                            <td class="key"><strong>Курс валюты</strong></td>
                            <td><?php echo $this->orderbt->exchange_usd; ?></td>
                        </tr>
                        <tr>
                            <td class="key"><strong>Сдача по курсу</strong></td>
                            <td><?php echo $this->orderbt->delivery; ?></td>
                        </tr>
                        <tr>
                            <td class="key"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_IPADDRESS') ?></strong></td>
                            <td><?php echo $this->orderbt->ip_address; ?></td>
                        </tr>
                        <?php if ($this->orderbt->coupon_code) { ?>
                            <tr>
                                <td class="key"><strong><?php echo vmText::_('COM_VIRTUEMART_COUPON_CODE') ?></strong></td>
                                <td><?php echo $this->orderbt->coupon_code; ?></td>
                            </tr>
                        <?php } ?>
                        <?php
                        if ($this->orderbt->invoiceNumber and ! shopFunctions::InvoiceNumberReserved($this->orderbt->invoiceNumber)) {
                            $invoice_url  = juri::root().'index.php?option=com_virtuemart&view=invoice&layout=invoice&format=pdf&tmpl=component&virtuemart_order_id='.$this->orderbt->virtuemart_order_id.'&order_number='.$this->orderbt->order_number.'&order_pass='.$this->orderbt->order_pass;
                            $invoice_link = "<a title=\"".vmText::_('COM_VIRTUEMART_INVOICE_PRINT')."\"  href=\"javascript:void window.open('$invoice_url', 'win2', 'status=no,toolbar=no,scrollbars=yes,titlebar=no,menubar=no,resizable=yes,width=640,height=480,directories=no,location=no');\"  >";
                            $invoice_link .= $this->orderbt->invoiceNumber.'</a>';
                            ?>
                            <tr>
                                <td class="key"><strong><?php echo vmText::_('COM_VIRTUEMART_INVOICE') ?></strong></td>
                                <td><?php echo $invoice_link; ?></td>
                            </tr>
                        <?php } ?>
                    </table>
                </td>
                <td valign="top">
                    <table class="adminlist table">
                        <thead>
                            <tr>
                                <th  style="text-align: center;" colspan="2"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_BILL_TO_LBL') ?></th>
                            </tr>
                        </thead>
                        <?php
                        unset($this->userfields['fields']['tos']);
                        foreach ($this->userfields['fields'] as $_field) {
                            ?>
                            <tr>
                                <td class="key">
                                    <label for="<?php echo $_field['name']; ?>_field">
                                        <?php echo $_field['title'].($_field['required'] ? ' *' : ''); ?>
                                    </label>
                                </td>
                                <td>
                                    <?php echo $_field['value']; ?>
                                </td>
                            </tr>
                        <?php } ?>
                        <tr>
                            <td class="key"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_CUSTOMER_NOTE') ?></td>
                            <td><?php echo $this->orderbt->note; ?></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>

    <table width="100%">
        <tr>
            <td colspan="2">
                <form action="index.php" method="post" name="orderItemForm" id="orderItemForm"><!-- Update linestatus form -->
                    <table class="adminlist table"  id="itemTable" >
                        <thead>
                            <tr>
                                <th class="title" width="3" align="center">#</th>
                                <th class="title" width="" align="center"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_NAME') ?></th>
                                <th class="title" width="10%" align="center"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_SKU') ?></th>
                                <th class="title" width="47" align="center"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_QUANTITY') ?></th>
                                <th class="title" width="140" align="center"><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_FORM_PRICE_NET') ?></th>
                                <th class="title" width="140" align="center"><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?></th>
                            </tr>
                        </thead>
                        <?php
                        $i = 1;
                        foreach ($this->orderdetails['items'] as $item) {
                            ?>
                            <!-- Display the order item -->
                            <tr valign="top" ><?php /* id="showItem_<?php echo $item->virtuemart_order_item_id; ?>" data-itemid="<?php echo $item->virtuemart_order_item_id; ?>"> */ ?>
                                    <!--<td>
                                <?php $removeLineLink = JRoute::_('index.php?option=com_virtuemart&view=orders&orderId='.$this->orderbt->virtuemart_order_id.'&orderLineId='.$item->virtuemart_order_item_id.'&task=removeOrderItem'); ?>
                                            <a class="vmicon vmicon-16-bug" title="<?php echo vmText::_('remove'); ?>" onclick="javascript:confirmation('<?php echo $removeLineLink; ?>');"></a>

                                            <a href="javascript:enableItemEdit(<?php echo $item->virtuemart_order_item_id; ?>)"> <?php echo JHtml::_('image', 'administrator/components/com_virtuemart/assets/images/icon_16/icon-16-category.png', "Edit", NULL, true); ?></a>
                                    </td> -->
                                <td>
                                    <?php echo ($i++) ?>
                                </td>
                                <td>
                                    <span class='ordereditI'><?php echo $item->order_item_name; ?></span>
                                    <!--<input class='orderedit' style="width: 90%;" type="text"  name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][order_item_name]" value="<?php echo $item->order_item_name; ?>"/>-->
                                    <?php
                                    //echo $item->order_item_name;
                                    //if (!empty($item->product_attribute)) {
                                    if (!class_exists('VirtueMartModelCustomfields')) {
                                        require(VMPATH_ADMIN.DS.'models'.DS.'customfields.php');
                                    }
                                    $product_attribute = VirtueMartModelCustomfields::CustomsFieldOrderDisplay($item, 'BE');
                                    if ($product_attribute) {
                                        echo '<div>'.$product_attribute.'</div>';
                                    }
                                    //}
                                    $_dispatcher   = JDispatcher::getInstance();
                                    $_returnValues = $_dispatcher->trigger('plgVmOnShowOrderLineBEShipment', array($this->orderID, $item->virtuemart_order_item_id));
                                    $_plg          = '';
                                    foreach ($_returnValues as $_returnValue) {
                                        if ($_returnValue !== null) {
                                            $_plg .= $_returnValue;
                                        }
                                    }
                                    if ($_plg !== '') {
                                        echo '<table border="0" celspacing="0" celpadding="0">'
                                        .'<tr>'
                                        .'<td width="8px"></td>' // Indent
                                        .'<td>'.$_plg.'</td>'
                                        .'</tr>'
                                        .'</table>';
                                    }
                                    ?>
                                    <?php if (empty($item->virtuemart_product_id)) { ?>
                                        <span class='orderedit'>Product ID:</span>
                                        <input class='orderedit' type="text" size="10" name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][virtuemart_product_id]" value="<?php echo $item->virtuemart_product_id; ?>"/>
                                    <?php } ?>
                                </td>
                                <td>
                                    <span class='ordereditI'><?php echo $item->order_item_sku; ?></span>
                                    <!--<input class='orderedit' type="text"  name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][order_item_sku]" value="<?php echo $item->order_item_sku; ?>"/>-->
                                </td>
                                <td>
                                    <span class='ordereditI'><?php echo $item->product_quantity; ?></span>
                                    <!--<input class='orderedit' type="text" size="3" name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][product_quantity]" value="<?php echo $item->product_quantity; ?>"/>-->
                                </td>
                                <td align="right" style="padding-right: 5px;">
                                    <?php
                                    $item->product_discountedPriceWithoutTax = (float) $item->product_discountedPriceWithoutTax;
//                                    if (!empty($item->product_priceWithoutTax) && $item->product_discountedPriceWithoutTax != $item->product_priceWithoutTax) {
//                                        echo '<span style="text-decoration:line-through">'.$this->currency->priceDisplay($item->product_item_price).'</span><br />';
//                                        echo '<span >'.$this->currency->priceDisplay($item->product_discountedPriceWithoutTax).'</span><br />';
//                                    } else {
//                                        echo '<span >'.$this->currency->priceDisplay($item->product_item_price).'</span><br />';
//                                    }

                                    echo ceil($item->product_item_price * $this->orderbt->exchange_usd).' Сом / '.round($item->product_item_price, 2).' $';
                                    ?>
                                    <!--<input class='orderedit' type="text" size="8" name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][product_item_price]" value="<?php echo $item->product_item_price; ?>"/>-->
                                </td>
                                <td align="right" style="padding-right: 5px;">
                                    <?php
                                    $item->product_basePriceWithTax = (float) $item->product_basePriceWithTax;
                                    if (!empty($item->product_basePriceWithTax) && $item->product_basePriceWithTax != $item->product_final_price) {
                                        echo '<span style="text-decoration:line-through" >'.$this->currency->priceDisplay($item->product_basePriceWithTax, $this->currency, $item->product_quantity).'</span><br />';
                                    } elseif (empty($item->product_basePriceWithTax) && $item->product_item_price != $item->product_final_price) {
                                        echo '<span style="text-decoration:line-through">'.$this->currency->priceDisplay($item->product_item_price, $this->currency, $item->product_quantity).'</span><br />';
                                    }
//                                    echo $this->currency->priceDisplay($item->product_subtotal_with_tax);
                                    echo ceil($item->product_subtotal_with_tax * $this->orderbt->exchange_usd).' Сом / '.round($item->product_subtotal_with_tax, 2).' $';
                                    ?>
                                    <!--<input class='orderedit' type="hidden" size="8" name="item_id[<?php echo $item->virtuemart_order_item_id; ?>][product_subtotal_with_tax]" value="<?php echo $item->product_subtotal_with_tax; ?>"/>-->
                                </td>
                            </tr>

                        <?php } ?>
<!--                        <tr id="updateOrderItemStatus">

                            <td colspan="6">
                                <a class="updateOrderItemStatus" href="#"><span class="icon-nofloat vmicon vmicon-16-save"></span><?php echo vmText::_('COM_VIRTUEMART_SAVE'); ?></a>
                            </td>
                        </tr>-->
                        <!--/table -->
                        <input type="hidden" name="task" value="" />
                        <input type="hidden" name="option" value="com_virtuemart" />
                        <input type="hidden" name="view" value="orders" />
                        <input type="hidden" name="virtuemart_order_id" value="<?php echo $this->orderID; ?>" />
                        <input type="hidden" name="virtuemart_paymentmethod_id" value="<?php echo $this->orderbt->virtuemart_paymentmethod_id; ?>" />
                        <input type="hidden" name="virtuemart_shipmentmethod_id" value="<?php echo $this->orderbt->virtuemart_shipmentmethod_id; ?>" />
                        <input type="hidden" name="order_total" value="<?php echo $this->orderbt->order_total; ?>" />
                        <?php echo JHtml::_('form.token'); ?>
                        <tr>
                            <td align="right" colspan="4"><strong><?php echo vmText::_('COM_VIRTUEMART_ORDER_PRINT_TOTAL') ?>:</strong></td>
                            <td align="right" style="padding-right: 5px;">&nbsp;</td>
                            <td align="right" style="padding-right: 5px;"><strong><?php echo ceil($this->orderbt->order_total * $this->orderbt->exchange_usd).' Сом / '.round($this->orderbt->order_total, 2).' $'; ?></strong>
                            </td>
                        </tr>
                        <?php if ($this->orderbt->user_currency_rate != 1.0) { ?>
                            <tr>
                                <td align="right" colspan="5"><em><?php echo vmText::_('COM_VIRTUEMART_ORDER_USER_CURRENCY_RATE') ?>:</em></td>
                                <td  align="right" style="padding-right: 5px;">&nbsp;</td>
                                <td  align="right" style="padding-right: 5px;">&nbsp;</td>
                                <td  align="right" style="padding-right: 5px;">&nbsp;</td>
                                <td  align="right" style="padding-right: 5px;">&nbsp;</td>
                                <td  align="right" style="padding-right: 5px;">&nbsp;</td>
                                <td   align="right" style="padding-right: 5px;"><em><?php echo $this->orderbt->user_currency_rate ?></em></td>
                            </tr>
                        <?php }
                        ?>
                    </table>
                </form>
            </td>
        </tr>
    </table>
    &nbsp;
    <table width="100%">
        <tr>
            <td valign="top" width="50%">
                <?php
                JPluginHelper::importPlugin('vmpayment');
                $_dispatcher   = JDispatcher::getInstance();
                $_returnValues = $_dispatcher->trigger('plgVmOnShowOrderBEPayment', array($this->orderID, $this->orderbt->virtuemart_paymentmethod_id, $this->orderdetails));

                foreach ($_returnValues as $_returnValue) {
                    if ($_returnValue !== null) {
                        echo $_returnValue;
                    }
                }
                ?>
            </td>
            <td valign="top">
                &nbsp;
            </td>
        </tr>

    </table>

</div>

<?php
AdminUIHelper::imitateTabs('end');
AdminUIHelper::endAdminArea();
?>

<script type="text/javascript">

    jQuery('.show_element').click(function () {
        jQuery('.element-hidden').toggle();
        return false;
    });
// jQuery('select#order_items_status').change(function() {
    ////selectItemStatusCode
    // var statusCode = this.value;
    // jQuery('.selectItemStatusCode').val(statusCode);
    // return false
// });
    jQuery('.updateOrderItemStatus').click(function () {
        document.orderItemForm.task.value = 'updateOrderItemStatus';
        document.orderItemForm.submit();
        return false;
    });
    jQuery('.updateOrder').click(function () {
        document.orderForm.submit();
        return false;
    });
    jQuery('.createOrder').click(function () {
        document.orderForm.task.value = 'CreateOrderHead';
        document.orderForm.submit();
        return false;
    });
    jQuery('.newOrderItem').click(function () {
        document.orderItemForm.task.value = 'newOrderItem';
        document.orderItemForm.submit();
        return false;
    });
    function confirmation(destnUrl) {
        var answer = confirm("<?php echo addslashes(vmText::_('COM_VIRTUEMART_ORDER_DELETE_ITEM_JS')); ?>");
        if (answer) {
            window.location = destnUrl;
        }
    }
    /* JS for editstatus */

    jQuery('.orderStatFormSubmit').click(function () {
        //document.orderStatForm.task.value = 'updateOrderItemStatus';
        document.orderStatForm.submit();

        return false;
    });

    var editingItem = 0;

</script>
