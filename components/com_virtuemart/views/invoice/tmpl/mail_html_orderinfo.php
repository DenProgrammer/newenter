<?php
/**
 *
 * Define here the Header for order mail success !
 *
 * @package    VirtueMart
 * @subpackage Cart
 * @author Kohl Patrick
 * @author Valérie Isaksen
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

$order = $this->orderDetails['details']['BT'];

?>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="html-email">
    <tr>
        <th class="vmdoc-header-text">
            Информация о заказе
        </th>
        <th>
            &nbsp;
        </th>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Номер заказа:
        </td>
        <td class="vmdoc-header-text">
            <?php echo $order->virtuemart_order_id; ?>
        </td>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Дата заказа:
        </td>
        <td class="vmdoc-header-text">
            <?php echo date("d.m.Y",strtotime($order->created_on)); ?>
        </td>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Курс валюты:
        </td>
        <td class="vmdoc-header-text">
            <?php echo $order->exchange_usd; ?> KGS
        </td>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Сдача по курсу:
        </td>
        <td class="vmdoc-header-text">
            <?php echo $order->delivery; ?> KGS
        </td>
    </tr>
    <tr>
        <td class="vmdoc-header-text">
            Примечание:
        </td>
        <td class="vmdoc-header-text">
            <?php echo $order->note; ?> KGS
        </td>
    </tr>
</table>
