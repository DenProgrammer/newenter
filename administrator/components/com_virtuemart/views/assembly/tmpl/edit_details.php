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
?>

<table class="adminform">
    <tr>
        <td valign="top" colspan="2">
            <fieldset>
                <legend><?php echo vmText::_('COM_VIRTUEMART_FORM_GENERAL'); ?></legend>
                <table width="100%" border="0">
                    <?php
                    echo VmHTML::row('input', 'COM_VIRTUEMART_ASSEMBLY_TITLE', 'title', $this->assembly->title, 'class="inputbox"', '', 100, 50);
                    echo VmHTML::row('booleanlist', 'COM_VIRTUEMART_PUBLISHED', 'published', $this->assembly->published);
                    echo VmHTML::row('editor', 'COM_VIRTUEMART_ASSEMBLY_DESCRIPTION', 'description', $this->assembly->description);
                    ?>
                </table>
            </fieldset>
        </td>
        <td></td>
    </tr>
</table>


