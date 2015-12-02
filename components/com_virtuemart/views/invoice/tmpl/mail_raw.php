<?php
/**
 *
 * Layout for the shopper mail, when he confirmed an ordner
 *
 * The addresses are reachable with $this->BTaddress, take a look for an exampel at shopper_adresses.php
 *
 * With $this->cartData->paymentName or shipmentName, you get the name of the used paymentmethod/shippmentmethod
 *
 * In the array order you have details and items ($this->orderDetails['details']), the items gather the products, but that is done directly from the cart data
 *
 * $this->orderDetails['details'] contains the raw address data (use the formatted ones, like BTaddress). Interesting informatin here is,
 * order_number ($this->orderDetails['details']['BT']->order_number), order_pass, coupon_code, order_status, order_status_name,
 * user_currency_rate, created_on, customer_note, ip_address
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

$days = array(
    0 => 'Воскресенье',
    1 => 'Понедельник',
    2 => 'Вторник',
    3 => 'Среда',
    4 => 'Четверг',
    5 => 'Пятница',
    6 => 'Суббота',
);

$months = array(
    1  => 'Января',
    2  => 'Февраля',
    3  => 'Марта',
    4  => 'Апреля',
    5  => 'Мая',
    6  => 'Июня',
    7  => 'Июля',
    8  => 'Августа',
    9  => 'Сентября',
    10 => 'Октября',
    11 => 'Ноября',
    12 => 'Декабря',
);

$order = $this->orderDetails['details']['BT'];
$items = $this->orderDetails['items'];

$time = strtotime($order->created_on);

$daystr = date('N',$time);
$day = date('d',$time);
$month = date('m',$time);
$year = date('Y',$time);
?>

Получен следующий заказ.



Информация о заказе

------------------------------------------------------------------------

Номер заказа: <?php echo $order->virtuemart_order_id; ?>

Дата заказа:   <?php echo $days[$daystr],', ',$day,' ',$months[$month],' ',$year; ?>



ФИО:    <?php echo $order->first_name; ?>

Адрес доставки:    <?php echo $order->address_1; ?>

Телефон:    <?php echo $order->phone_1; ?>

IP-адрес:    <?php echo $order->ip_address; ?>



Содержание заказа

-----------



<?php foreach ($items as $item) { ?>
    Товар = <?php echo $item->order_item_name; ?> 

    Количество = <?php echo $item->product_quantity; ?>

    Артикул = <?php echo $item->order_item_sku; ?>

    Цена = <?php echo round($item->product_item_price * $order->exchange_usd); ?> Сом / <?php echo round($item->product_item_price, 2); ?> $

    

<?php } ?>
-----------

Итого    = <?php echo round($order->order_total * $order->exchange_usd); ?> Сом / <?php echo round($order->order_total, 2); ?> $



------------------------------------------------------------------------

Комментарий покупателя

<?php echo $order->note; ?> 

------------------------------------------------------------------------





Чтобы просмотреть заказ, проследуйте по ссылке ниже.

<?php
echo vmText::_('COM_VIRTUEMART_MAIL_SHOPPER_YOUR_ORDER_LINK') . ' : ' . JURI::root()
 . 'index.php?option=com_virtuemart&view=orders&layout=details&order_number='
 . $order->order_number . '&order_pass=' . $order->order_pass . "\n";


