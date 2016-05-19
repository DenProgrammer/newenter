<?php
/**
 *
 * Layout for the shopper mail, when he confirmed an ordner
 *
 * The addresses are reachable with $this->BTaddress, take a look for an exampel at shopper_adresses.php
 *
 * With $this->orderDetails['shipmentName'] or paymentName, you get the name of the used paymentmethod/shippmentmethod
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
?>

<html>
    <head>
        <link rel="stylesheet" href="components/com_virtuemart/assets/css/invoice.css">
        <?php
        if ($this->vendor->vendor_letter_header == 1 || $this->vendor->vendor_letter_footer == 1) {
            echo '<style type="text/css">'.$this->vendor->vendor_letter_css.'</style>';
        }
        ?> 
    </head>

    <body>
        <div class="wrapper">
            <table class="main-table">
                <tr>
                    <td>
                        <?php
                        if ($this->recipient == 'shopper') {
                            echo $this->loadTemplate('header');
                        } else {
                            echo $this->loadTemplate('headeradmin');
                        }

                        echo $this->loadTemplate('orderinfo');
                        echo $this->loadTemplate('shopperaddresses');
                        echo $this->loadTemplate('pricelist');
                        echo $this->loadTemplate($this->recipient);
                        echo $this->loadTemplate($this->recipient.'_more');
                        echo $this->loadTemplate('footer');
                        ?>
                    </td>
                </tr>
            </table>
        </div>
    </body>
</html>