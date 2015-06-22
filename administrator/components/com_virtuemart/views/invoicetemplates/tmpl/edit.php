<?php
/**
 *
 * Description
 *
 * @package	VirtueMart
 * @subpackage OrderStatus
 * @author Oscar van Eijk
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: edit.php 8080 2014-06-29 07:31:28Z alatak $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

AdminUIHelper::startAdminArea($this);
AdminUIHelper::imitateTabs('start', 'COM_VIRTUEMART_ORDERSTATUS_DETAILS');
?>

<form action="index.php" method="post" name="adminForm" id="adminForm">
    <div class="col50">
        <fieldset>
            <legend><?php echo vmText::_('COM_VIRTUEMART_VENDOR_DESCRIPTION'); ?></legend>
            <table class="admintable">
                <?php
                echo VmHTML::row('input', 'COM_VIRTUEMART_VENDOR_NAME', 'title', $this->invoicetemplates->title, 'class="inputbox"', '', 10, 50);
                echo VmHTML::row('input', 'COM_VIRTUEMART_NRT', 'nrt', $this->invoicetemplates->nrt, 'class="inputbox" ', '', 3, 10);
                ?>
            </table>
            <ul class="nav nav-tabs">
                <li class="active">
                    <a data-toggle="tab" href="#commercial_invoice">
                        <?php echo JText::_('COM_VIRTUEMART_COMMERCIAL_INVOICE'); ?>
                    </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#commercial_offer">
                        <?php echo JText::_('COM_VIRTUEMART_COMMERCIAL_OFFER'); ?>
                    </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#guaranty">
                        <?php echo JText::_('COM_VIRTUEMART_GUARANTY'); ?>
                    </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#invoice_payment">
                        <?php echo JText::_('COM_VIRTUEMART_INVOICE_PAYMENT'); ?>
                    </a>
                </li>
                <li>
                    <a data-toggle="tab" href="#waybill">
                        <?php echo JText::_('COM_VIRTUEMART_WAYBILL'); ?>
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div id="commercial_invoice" class="tab-pane active">
                    <table class="admintable">
                        <?php
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_HEAD_COMMERCIAL_INVOICE', 'content_commercial_invoice', $this->invoicetemplates->content_commercial_invoice, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_FOOTER_COMMERCIAL_INVOICE', 'footer_commercial_invoice', $this->invoicetemplates->footer_commercial_invoice, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        ?>
                    </table>
                </div>
                <div id="commercial_offer" class="tab-pane">
                    <table class="admintable">
                        <?php
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_HEAD_COMMERCIAL_OFFER', 'content_commercial_offer', $this->invoicetemplates->content_commercial_offer, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_FOOTER_COMMERCIAL_OFFER', 'footer_commercial_offer', $this->invoicetemplates->footer_commercial_offer, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        ?>
                    </table>
                </div>
                <div id="guaranty" class="tab-pane">
                    <table class="admintable">
                        <?php
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_HEAD_GUARANTY', 'content_guaranty', $this->invoicetemplates->content_guaranty, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_FOOTER_GUARANTY', 'footer_guaranty', $this->invoicetemplates->footer_guaranty, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        ?>
                    </table>
                </div>
                <div id="invoice_payment" class="tab-pane">
                    <table class="admintable">
                        <?php
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_HEAD_INVOICE_PAYMENT', 'content_invoice_payment', $this->invoicetemplates->content_invoice_payment, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_FOOTER_INVOICE_PAYMENT', 'footer_invoice_payment', $this->invoicetemplates->footer_invoice_payment, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        ?>
                    </table>
                </div>
                <div id="waybill" class="tab-pane">
                    <table class="admintable">
                        <?php
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_HEAD_WAYBILL', 'content_waybill', $this->invoicetemplates->content_waybill, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        echo VmHTML::row('editor', 'COM_VIRTUEMART_FOOTER_WAYBILL', 'footer_waybill', $this->invoicetemplates->footer_waybill, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                        ?>
                    </table>
                </div>
            </div>
        </fieldset>
    </div>

    <input type="hidden" name="id" value="<?php echo $this->invoicetemplates->id; ?>" />
    <?php echo $this->addStandardHiddenToForm(); ?>
</form>


<?php
AdminUIHelper::imitateTabs('end');
AdminUIHelper::endAdminArea();
