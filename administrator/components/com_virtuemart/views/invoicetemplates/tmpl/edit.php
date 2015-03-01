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
            <legend><?php echo vmText::_('COM_VIRTUEMART_ORDERSTATUS_DETAILS'); ?></legend>
            <table class="admintable">
                <?php
                echo VmHTML::row('input', 'COM_VIRTUEMART_ORDER_STATUS_NAME', 'title', $this->invoicetemplates->title, 'class="inputbox"', '', 10, 50);
                echo VmHTML::row('input', 'COM_VIRTUEMART_ORDER_STATUS_CODE', 'nrt', $this->invoicetemplates->nrt, 'class="inputbox ' . $readonly . '" ' . $readonly . '', '', 3, 10);
                echo VmHTML::row('editor', 'COM_VIRTUEMART_DESCRIPTION', 'content', $this->invoicetemplates->content, '100%;', '250', array('image', 'pagebreak', 'readmore'));
                ?>
            </table>
        </fieldset>
    </div>

    <input type="hidden" name="id" value="<?php echo $this->invoicetemplates->id; ?>" />
    <?php echo $this->addStandardHiddenToForm(); ?>
</form>


<?php
AdminUIHelper::imitateTabs('end');
AdminUIHelper::endAdminArea();
