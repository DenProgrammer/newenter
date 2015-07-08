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

vmJsApi::addJScript('assembly', "
		jQuery( function($) {

			$('#addItem').click(function() {
				var newRow   = $('table#items tr:nth-child(2)').clone();
				var countRow = $('table#items tr').length;
                                
                                newRow.find('td:nth-child(1) input')
                                    .attr('value', 0)
                                    .attr('id', 'products['+countRow+'][id]')
                                    .attr('name', 'products['+countRow+'][id]');
                                    
                                newRow.find('td:nth-child(2) input')
                                    .attr('value', 0)
                                    .attr('id', 'products['+countRow+'][count]')
                                    .attr('name', 'products['+countRow+'][count]');
                                    
                                $('table#items').append(newRow);
			});

			$('input.delete').click(function() {
				$(this).parent().parent().remove();
			});

		});

		");

AdminUIHelper::startAdminArea($this);
$editor = JFactory::getEditor();
?>

<form action="index.php" method="post" id="adminForm" name="adminForm" enctype="multipart/form-data">
    <?php
// Loading Templates in Tabs
    AdminUIHelper::buildTabs($this, array(
        'details'  => 'COM_VIRTUEMART_ASSEMBLY_DETAILS_FORM_LBL',
        'products' => 'COM_VIRTUEMART_ASSEMBLY_PRODUCTS_FORM_LBL',
        'images'   => 'COM_VIRTUEMART_IMAGES'
            ), $this->assembly->id);
    ?>
    <input type="hidden" name="id" value="<?php echo $this->assembly->id; ?>" />
    <input type="hidden" name="assembly_id" value="<?php echo $this->assembly->id; ?>" />

    <?php echo $this->addStandardHiddenToForm(); ?>

</form>
<?php
AdminUIHelper::endAdminArea();
