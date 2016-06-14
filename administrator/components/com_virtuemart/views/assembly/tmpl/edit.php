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
				var newRow   = '<tr style=\"display:none;\" id=\"row_ID\">';
                                newRow   += '<td valign=\"top\">';
                                newRow   += '   <input ';
                                newRow   += '       type=\"text\" ';
                                newRow   += '       value=\"\" ';
                                newRow   += '       name=\"products[ID][type]\" ';
                                newRow   += '       id=\"products_ID_type\" ';
                                newRow   += '       class=\"inputbox\" ';
                                newRow   += '   />';
                                newRow   += '</td>';
                                newRow   += '<td valign=\"top\">';
                                newRow   += '   <input ';
                                newRow   += '       type=\"hidden\" ';
                                newRow   += '       value=\"1\" ';
                                newRow   += '       name=\"products[ID][id]\" ';
                                newRow   += '       id=\"products_ID_id\" ';
                                newRow   += '       class=\"inputbox\" ';
                                newRow   += '   />';
                                newRow   += '   <input ';
                                newRow   += '       type=\"text\" ';
                                newRow   += '       value=\"\" ';
                                newRow   += '       name=\"products[ID][name]\" ';
                                newRow   += '       id=\"products_ID_name\" ';
                                newRow   += '       class=\"inputbox\" ';
                                newRow   += '   />';
                                newRow   += '</td>';
                                newRow   += '<td valign=\"top\">';
                                newRow   += '    <a ';
                                newRow   += '       rel=\"{handler: \'iframe\', size: {x: 700, y: 400}}\" ';
                                newRow   += '       href=\"index.php?option=com_virtuemart&view=product&layout=modal&tmpl=component&fieldId=ID\" ';
                                newRow   += '       title=\"Выбрать продукт\" ';
                                newRow   += '       class=\"btn modal-button\"';
                                newRow   += '       >';
                                newRow   += '       <span class=\"icon-file-add\"></span>';
                                newRow   += '       Продукт	';
                                newRow   += '   </a>';
                                newRow   += '</td>';
                                newRow   += '<td valign=\"top\">';
                                newRow   += '   <input ';
                                newRow   += '      type=\"text\" ';
                                newRow   += '      value=\"1\" ';
                                newRow   += '      name=\"products[ID][count]\" ';
                                newRow   += '      id=\"products[ID][count]\" ';
                                newRow   += '      class=\"inputbox\" ';
                                newRow   += '      />';
                                newRow   += '</td>';
                                newRow   += '<td valign=\"top\">';
                                newRow   += '    <input ';
                                newRow   += '        type=\"button\" ';
                                newRow   += '        value=\"Удалить продукт\" ';
                                newRow   += '        onclick=\"deleteRow(ID)\" ';
                                newRow   += '        class=\"delete btn modal-button\"';
                                newRow   += '        />';
                                newRow   += '</td>';
                                newRow   += '</tr>';
        
				var countRow = $('table#items tr').length;
                                
                                newRow = newRow.replace(/ID/g,countRow);
                                    
                                $('table#items').append(newRow);
                                
                                $('.btn-success').click();
                        });

		});

                function selectProduct(fieldId, productId, productName) {
                    jQuery('#products_' + fieldId + '_id').attr('value', productId);
                    jQuery('#products_' + fieldId + '_name').attr('value', productName);
                    jQuery('#sbox-window').modal('hide');
                    jQuery('#sbox-overlay').modal('hide');
                }
                
                function deleteRow(id){
                    jQuery('#row_' + id).remove();
                }
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
