<?php
/**
 *
 * Order detail view
 * //index.php?option=com_virtuemart&view=invoice&layout=invoice&format=pdf&tmpl=component&order_number=xx&order_pass=p_yy
 * @package    VirtueMart
 * @subpackage Orders
 * @author Max Milbers, Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: details.php 5412 2012-02-09 19:27:55Z alatak $
 */
defined('_JEXEC') or die('Restricted access');
JHtml::stylesheet('vmpanels.css', JURI::root().'components/com_virtuemart/assets/css/');

if ($this->_layout == "invoice") {
    $document = JFactory::getDocument();
    $document->setTitle(vmText::_('COM_VIRTUEMART_ORDER_PRINT_PO_NUMBER').' '.$this->orderDetails['details']['BT']->order_number.' '.$this->vendor->vendor_store_name);
}

$vendorCompanyName = (!empty($this->vendor->vendorFields["fields"]["company"]["value"])) ? $this->vendor->vendorFields["fields"]["company"]["value"] : $this->vendor->vendor_store_name;

if (!empty($this->vendor->vendor_letter_css)) {
    ?>
    <style type="text/css">
    <?php echo $this->vendor->vendor_letter_css; ?>
    </style>
    <?php
}

$this->vendor->vendor_letter_header_image;

if ($this->print) {
    ?>
    <html>
        <head>
            <title>Вид для печати</title>
            <style type="text/css">
                html, p, td, th, a{
                    font-size: 12px;
                    color: black;
                    text-decoration: none;
                }
                h2{
                    font-size: 16px;
                }
                table{
                    border-collapse: collapse;
                }
                span.note{
                    font-size: 16px;
                    font-weight: bold;
                }
            </style>
        </head>
        <body onload="javascript:print2();">
        <?php }
        ?>
        <table width = "100%">
            <tr>
                <td id = "vmPage" style = "width:80%;vertical-align:top;padding-left: 5px;">
                    <style type = 'text/css' media = 'print'>
                        .vmNoPrint { 
                            display: none;
                        }
                    </style>
                    <table width = "100%" align = "center" border = "0" cellspacing = "0" cellpadding = "2">
                        <tr>
                            <td valign = "top">
                                <h2>Информация о заказе</h2>
                                <p>Салон компьютерной техники WWW.ENTER.KG<br />
                                    пр. Чуй, 170<br />
                                    ул.Московская, 195<br />
                                    Бишкек, 720000</p>
                            </td>
                            <td valign = "top" width = "10%" align = "right">
                                <img border = "0" height="100" src = "images/printlogo.jpg" alt = "Салон компьютерной техники WWW.ENTER.KG" />
                            </td>
                        </tr>
                    </table>
                    <?php
                    echo $this->loadTemplate('order');
                    ?>
                    <br />
                    <table border = "0" cellspacing = "0" cellpadding = "2" width = "100%">
                        <!--Begin Order Items Information -->
                        <tr class = "sectiontableheader">
                            <th align = "left">Содержание заказа</th>
                            <th align = "right">
                                <strong> Курс доллара к сому: </strong> <?php echo $this->orderDetails['details']['BT']->exchange_usd; ?> сом
                                &nbsp; &nbsp; &nbsp; &nbsp;
                                <strong> Сдача по курсу: </strong> <?php echo $this->orderDetails['details']['BT']->delivery; ?> сом
                            </th>
                        </tr>
                        <tr>
                            <td colspan = "2">
                                <?php echo $this->loadTemplate('items'); ?>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <span class="note">
                        Примечание покупателя: <?php echo $this->orderDetails['details']['BT']->note; ?>
                    </span>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </body>

</html>
