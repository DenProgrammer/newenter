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
 * @version $Id: default.php 8534 2014-10-28 10:23:03Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

AdminUIHelper::startAdminArea($this);
?>
<form action="index.php" method="post" name="adminForm" id="adminForm">
    <div id="editcell">
        <table class="adminlist table table-striped" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th class="admin-checkbox">
                        <input type="checkbox" name="toggle" value="" onclick="Joomla.checkAll(this)" />
                    </th>

                    <th>
                        <?php echo vmText::_('COM_VIRTUEMART_VENDOR_NAME') ?>
                    </th>
                    <th width="20">
                        <?php echo vmText::_('COM_VIRTUEMART_PUBLISHED'); ?>
                    </th>
                    <th><?php echo vmText::_('COM_VIRTUEMART_ID') ?></th>
                </tr>
            </thead>
            <?php
            $k = 0;
            for ($i = 0, $n = count($this->invoicetemplates); $i < $n; $i++) {
                $row       = $this->invoicetemplates[$i];
                $published = $this->gridPublished($row, $i);

                $checked = JHtml::_('grid.id', $i, $row->id);

                $editlink = JROUTE::_('index.php?option=com_virtuemart&view=invoicetemplates&task=edit&cid[]=' . $row->id);
                $ordering = $row->ordering;
                ?>
                <tr class="row<?php echo $k; ?>">
                    <td class="admin-checkbox">
                        <?php echo $checked; ?>
                    </td>
                    <td align="left">
                        <a href="<?php echo $editlink; ?>"><?php echo vmText::_($row->title); ?></a>
                    </td>
                    <td align="center"><?php echo $published; ?></td>
                    <td width="10">
                        <?php echo $row->id; ?>
                    </td>
                </tr>
                <?php
                $k        = 1 - $k;
            }
            ?>
        </table>
    </div>

    <?php echo $this->addStandardHiddenToForm(); ?>
</form>

<?php
AdminUIHelper::endAdminArea();
