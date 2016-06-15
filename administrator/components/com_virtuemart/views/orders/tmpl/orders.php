<?php
/**
 *
 * Description
 *
 * @package    VirtueMart
 * @subpackage
 * @author
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: orders.php 8539 2014-10-30 15:52:48Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');
AdminUIHelper::startAdminArea($this);

$styleDateCol = 'style="width:5%;min-width:110px"';
?>
<form action="index.php" method="post" name="adminForm" id="adminForm">
    <div id="header">
        <div id="filterbox">
            <table>
                <tr>
                    <td align="left" width="100%">
                        <?php echo $this->displayDefaultViewSearch('COM_VIRTUEMART_ORDER_PRINT_NAME', 'search', true); ?>
                    </td>
                </tr>
            </table>
        </div>
        <div id="resultscounter"><?php echo $this->pagination->getResultsCounter(); ?></div>
    </div>
    <div style="text-align: left;">
        <table class="adminlist table table-striped" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th class="admin-checkbox"><input type="checkbox" name="toggle" value="" onclick="Joomla.checkAll(this)"/></th>
                    <th><?php echo $this->sort('virtuemart_order_id', 'COM_VIRTUEMART_ORDER_LIST_ID') ?></th>
                    <th><?php echo $this->sort('order_name', 'COM_VIRTUEMART_ORDER_PRINT_NAME') ?></th>
                    <th colspan="2"><?php echo JText::_('COM_VIRTUEMART_ORDER_INVOICES') ?></th>
                    <th style="min-width:110px;"><?php echo vmText::_('COM_VIRTUEMART_PRINT_VIEW'); ?></th>
                    <th class="admin-dates"><?php echo $this->sort('created_on', 'COM_VIRTUEMART_ORDER_CDATE') ?></th>
                    <th><?php echo $this->sort('order_total', 'COM_VIRTUEMART_TOTAL') ?></th>

                </tr>
            </thead>
            <tbody>
                <?php
                if (count($this->orderslist) > 0) {
                    $i       = 0;
                    $k       = 0;
                    $keyword = vRequest::getCmd('keyword');

                    foreach ($this->orderslist as $key => $order) {
                        $checked = JHtml::_('grid.id', $i, $order->virtuemart_order_id);
                        $link    = 'index.php?option=com_virtuemart&view=orders&task=edit&virtuemart_order_id='.$order->virtuemart_order_id;
                        ?>
                        <tr class="row<?php echo $k; ?>">
                            <!-- Checkbox -->
                            <td class="admin-checkbox">
                                <?php echo $checked; ?>
                            </td>
                            <td>
                                <?php echo JHtml::_('link', JRoute::_($link, FALSE), $order->virtuemart_order_id, array('title' => vmText::_('COM_VIRTUEMART_ORDER_EDIT_ORDER_ID').' '.$order->virtuemart_order_id)); ?>
                            </td>
                            <td>
                                <?php
                                if ($order->virtuemart_user_id) {
                                    $userlink = JROUTE::_('index.php?option=com_virtuemart&view=user&task=edit&virtuemart_user_id[]='.$order->virtuemart_user_id, FALSE);
                                    echo JHtml::_('link', JRoute::_($userlink, FALSE), $order->order_name, array('title' => vmText::_('COM_VIRTUEMART_ORDER_EDIT_USER').' '.htmlentities($order->order_name)));
                                } else {
                                    echo $order->order_name;
                                }
                                ?>
                            </td>
                            <!-- invoices -->
                            <td>
                                <a href="index.php?option=com_virtuemart&view=invoice&task=commercial_invoice&order_id=<?php echo $order->virtuemart_order_id ?>&tmpl=ajax">Счет-фактура</a><br />
                                <a href="index.php?option=com_virtuemart&view=invoice&task=waybill&order_id=<?php echo $order->virtuemart_order_id ?>&tmpl=ajax">Накладная</a><br />
                                <a href="index.php?option=com_virtuemart&view=invoice&task=commercial_offer&order_id=<?php echo $order->virtuemart_order_id ?>&tmpl=ajax">Комм. предл.</a>
                            </td>
                            <td>
                                <a href="index.php?option=com_virtuemart&view=invoice&task=invoice_payment&order_id=<?php echo $order->virtuemart_order_id ?>&tmpl=ajax">Счет на оплату</a><br />
                                <a href="index.php?option=com_virtuemart&view=invoice&task=app&tmpl=ajax">Приложение</a><br />
                                <a href="index.php?option=com_virtuemart&view=invoice&task=guaranty&order_id=<?php echo $order->virtuemart_order_id ?>&tmpl=ajax">Гарантия</a>
                            </td>
                            <!-- Print view -->
                            <?php
                            /* Print view URL */
                            $print_url  = juri::root().'index.php?option=com_virtuemart&view=invoice&layout=invoice&tmpl=raw&virtuemart_order_id='.$order->virtuemart_order_id.'&order_number='.$order->order_number.'&order_pass='.$order->order_pass;
                            $print_link = "<a href=\"javascript:void window.open('$print_url', 'win2', 'status=no,toolbar=no,scrollbars=yes,titlebar=no,menubar=no,resizable=yes,width=640,height=480,directories=no,location=no');\"  >";
                            $print_link .= '<span class="hasTip print_32" title="'.vmText::_('COM_VIRTUEMART_PRINT').'">&nbsp;</span></a>';
                            ?>
                            <td><?php
                                echo $print_link;
                                ?>
                            </td>
                            <!-- Order date -->
                            <td><?php echo vmJsApi::date($order->created_on, 'LC2', TRUE); ?></td>
                            <td><?php echo round($order->order_salesPrice * $order->exchange_usd).' Сом / '.$order->order_total; ?></td>

                        </tr>
                        <?php
                        $k          = 1 - $k;
                        $i++;
                    }
                }
                ?>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="12">
                        <?php echo $this->pagination->getListFooter(); ?>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
    <!-- Hidden Fields -->
    <?php echo $this->addStandardHiddenToForm(); ?>
</form>
<?php AdminUIHelper::endAdminArea(); ?>
<script type="text/javascript">
<!--

    jQuery('.show_comment').click(function () {
        jQuery(this).prev('.element-hidden').show();
        return false
    });

    jQuery('.element-hidden').mouseleave(function () {
        jQuery(this).hide();
    });
    jQuery('.element-hidden').mouseout(function () {
        jQuery(this).hide();
    });
-->
</script>

<script>
    jQuery(document).ready(function () {
        jQuery('.orderstatus_select').change(function () {

            var name = jQuery(this).attr('name');
            var brindex = name.indexOf("orders[");
            if (brindex >= 0) {
                //yeh, yeh, maybe not the most elegant way, but it does, what it should
                var s = name.indexOf("[") + 1;
                var e = name.indexOf("]");
                var id = name.substring(s, e);

<?php
$orderstatusForShopperEmail = VmConfig::get('email_os_s', array('U', 'C', 'S', 'R', 'X'));
if (!is_array($orderstatusForShopperEmail))
    $orderstatusForShopperEmail = array($orderstatusForShopperEmail);
$jsOrderStatusShopperEmail  = json_encode($orderstatusForShopperEmail);
?>
                var orderstatus = <?php echo $jsOrderStatusShopperEmail ?>;
                var selected = jQuery(this).val();
                var selStr = '[name="orders[' + id + '][customer_notified]"]';
                var elem = jQuery(selStr);

                if (jQuery.inArray(selected, orderstatus) != -1) {
                    elem.attr("checked", true);
                    // for the checkbox    
                    jQuery(this).parent().parent().find('input[name="cid[]"]').attr("checked", true);
                } else {
                    elem.attr("checked", false);
                }

            }

        });

    });
</script>
