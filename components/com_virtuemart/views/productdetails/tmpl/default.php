<?php
/**
 *
 * Show the product details page
 *
 * @package	VirtueMart
 * @subpackage
 * @author Max Milbers, Eugen Stranz, Max Galt
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2014 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: default.php 8508 2014-10-22 18:57:14Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

/* Let's see if we found the product */
if (empty($this->product)) {
    echo vmText::_('COM_VIRTUEMART_PRODUCT_NOT_FOUND');
    echo '<br /><br />  ' . $this->continue_link_html;
    return;
}

$category_id   = $this->product->categoryItem[0]['virtuemart_category_id'];
$category_name = $this->product->categoryItem[0]['category_name'];

$userGroup   = JFactory::getUser()->getAuthorisedGroups();
$allowGroups = array(7, 8);
$showSku     = array_intersect($allowGroups, $userGroup);

if ($showSku) {
    $sku = str_replace('sklad-', '', $this->product->product_sku);
} else {
    $sku = preg_replace('/(sklad-)([0-9]{1,3})([-]{1})([0-9]*)/', '$4', $this->product->product_sku);
}

echo shopFunctionsF::renderVmSubLayout('askrecomjs', array('product' => $this->product));

vmJsApi::jDynUpdate();
vmJsApi::addJScript('updDynamicListeners', "
jQuery(document).ready(function() { // GALT: Start listening for dynamic content update.
	// If template is aware of dynamic update and provided a variable let's
	// set-up the event listeners.
	if (Virtuemart.container)
		Virtuemart.updateDynamicUpdateListeners();

}); ");

if (vRequest::getInt('print', false)) {
    ?>
    <body onload="javascript:print();">
    <?php } ?>

    <div class="pathway">
        <a href="index.php?option=com_virtuemart&view=category&virtuemart_category_id=<?php echo $category_id; ?>" class="pathway">
            <?php echo $category_name; ?>
        </a>

        <img alt="arrow" src="http://enter.kg/images/M_images/arrow.png">		
        <?php echo html_entity_decode($this->product->product_name); ?>
    </div>

    <div class="productdetails-view productdetails">

        <?php
        // Back To Category Button
        if ($this->product->virtuemart_category_id) {
            $catURL       = JRoute::_('index.php?option=com_virtuemart&view=category&virtuemart_category_id=' . $this->product->virtuemart_category_id, FALSE);
            $categoryName = $this->product->category_name;
        } else {
            $catURL       = JRoute::_('index.php?option=com_virtuemart');
            $categoryName = vmText::_('COM_VIRTUEMART_SHOP_HOME');
        }
        ?>
        <div class="back-to-category">
            <a href="<?php echo $catURL ?>" class="product-details" title="<?php echo $categoryName ?>"><?php echo vmText::sprintf('COM_VIRTUEMART_CATEGORY_BACK_TO', $categoryName) ?></a>
        </div>

        <?php
        // afterDisplayTitle Event
        echo $this->product->event->afterDisplayTitle
        ?>

        <?php
        // Product Edit Link
        echo $this->edit_link;
        // Product Edit Link END
        ?>

        <?php
        // PDF - Print - Email Icon
        if (VmConfig::get('show_emailfriend') || VmConfig::get('show_printicon') || VmConfig::get('pdf_icon')) {
            ?>
            <div class="icons">
                <?php
                $link = 'index.php?tmpl=component&option=com_virtuemart&view=productdetails&virtuemart_product_id=' . $this->product->virtuemart_product_id;

                echo $this->linkIcon($link . '&format=pdf', 'COM_VIRTUEMART_PDF', 'pdf_button', 'pdf_icon', false);
                echo $this->linkIcon($link . '&print=1', 'COM_VIRTUEMART_PRINT', 'printButton', 'show_printicon', false, true, false, 'class="printModal"');
                $MailLink = 'index.php?option=com_virtuemart&view=productdetails&task=recommend&virtuemart_product_id=' . $this->product->virtuemart_product_id . '&virtuemart_category_id=' . $this->product->virtuemart_category_id . '&tmpl=component';
                echo $this->linkIcon($MailLink, 'COM_VIRTUEMART_EMAIL', 'emailButton', 'show_emailfriend', false, true, false, 'class="recommened-to-friend"');
                ?>
                <div class="clear"></div>
            </div>
        <?php } // PDF - Print - Email Icon END
        ?>

        <div class="vm-product-container">
            <table style="width: 100%">
                <tr>
                    <td>
                        <div class="vm-product-media-container">
                            <?php
                            echo $this->loadTemplate('images');
                            ?>
                        </div> 
                    </td>
                    <td valign="top">
                        <div class="vm-product-details-container">

                            <div class="rows">
                                <span class="prouct_name">
                                    <?php echo html_entity_decode($this->product->product_name); ?>
                                </span>
                            </div>
                            <?php
                            // Product Short Description
                            if (!empty($this->product->product_s_desc)) {
                                ?>
                                <div class="product-short-description">
                                    <?php
                                    /** @todo Test if content plugins modify the product description */
                                    echo $this->product->product_s_desc;
                                    ?>
                                </div>
                                <?php
                            } // Product Short Description END
                            ?>
                            <div class="rows">
                                <table width='100%'>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td width='260'>
                                            <label class="pricelbl">Цена: </label>
                                            <span class="price">
                                                <?php echo shopFunctionsF::renderVmSubLayout('prices', array('product' => $this->product, 'currency' => $this->currency)); ?>
                                            </span>
                                        </td>
                                        <td width='110'>
                                            <span class="sku">
                                                <label>Артикул: </label>
                                                <span><?php echo $sku; ?></span>
                                            </span>
                                        </td>
                                        <td width='100'>
                                            <span class="cart">
                                                <?php echo shopFunctionsF::renderVmSubLayout('addtocart', array('product' => $this->product)); ?>
                                            </span>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                        </div>  
                    </td>
                </tr>
            </table>

        </div>

        <?php
        $count_images = count($this->product->images);
        if ($count_images > 1) {
            echo $this->loadTemplate('images_additional');
        }

// event onContentBeforeDisplay
        echo $this->product->event->beforeDisplayContent;
        ?>

        <?php
        // Product Description
        if (!empty($this->product->product_desc)) {
            ?>
            <div class="product-description">
                <?php /** @todo Test if content plugins modify the product description */ ?>
                <span class="title"><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_DESC_TITLE') ?></span>
                <?php echo html_entity_decode($this->product->product_desc); ?>
            </div>
            <?php
        } // Product Description END

        echo shopFunctionsF::renderVmSubLayout('customfields', array('product' => $this->product, 'position' => 'normal'));

        // Product Packaging
        $product_packaging = '';
        if ($this->product->product_box) {
            ?>
            <div class="product-box">
                <?php
                echo vmText::_('COM_VIRTUEMART_PRODUCT_UNITS_IN_BOX') . $this->product->product_box;
                ?>
            </div>
        <?php } // Product Packaging END   ?>

        <?php
        echo shopFunctionsF::renderVmSubLayout('customfields', array('product' => $this->product, 'position' => 'onbot'));

        echo shopFunctionsF::renderVmSubLayout('customfields', array('product' => $this->product, 'position' => 'related_products', 'class' => 'product-related-products', 'customTitle' => true));

        echo shopFunctionsF::renderVmSubLayout('customfields', array('product' => $this->product, 'position' => 'related_categories', 'class' => 'product-related-categories'));
        ?>

        <?php
        // onContentAfterDisplay event
        echo $this->product->event->afterDisplayContent;
        ?>

        <?php
        echo $this->loadTemplate('reviews');
        ?>
        <?php
        // Show child categories
        if (VmConfig::get('showCategory', 1)) {
//            echo $this->loadTemplate('showcategory');
        }
        ?>
        <?php
        echo vmJsApi::writeJS();
        ?>

    </div>
    <script>
        // GALT
        /*
         * Notice for Template Developers!
         * Templates must set a Virtuemart.container variable as it takes part in
         * dynamic content update.
         * This variable points to a topmost element that holds other content.
         */
        // If this <script> block goes right after the element itself there is no
        // need in ready() handler, which is much better.
        //jQuery(document).ready(function() {
        Virtuemart.container = jQuery('.productdetails-view');
        Virtuemart.containerSelector = '.productdetails-view';
        //Virtuemart.container = jQuery('.main');
        //Virtuemart.containerSelector = '.main';
        //});

        // Open print and manufacturer link to Modal window
<?php
if (VmConfig::get('usefancy', 1)) {
    $manulink = JRoute::_('index.php?option=com_virtuemart&view=manufacturer&virtuemart_manufacturer_id=0&tmpl=component', FALSE);
    ?>
            jQuery('a.printModal').click(function(e) {
                jQuery.fancybox({
                    href: '<?php echo $link . '&print=1'; ?>',
                    type: 'iframe',
                    height: '500'
                });
                e.preventDefault();
            });

            jQuery('a.manuModal').click(function(e) {
                jQuery.fancybox({
                    href: '<?php echo $manulink ?>',
                    type: 'iframe'
                });
                e.preventDefault();
            });

    <?php
} else {
    $manulink = JRoute::_('index.php?option=com_virtuemart&view=manufacturer&virtuemart_manufacturer_id=0&tmpl=component', FALSE);
    ?>

            jQuery('a.printModal').click(function(e) {
                jQuery.facebox({
                    iframe: '<?php echo $link . '&print=1'; ?>',
                    rev: 'iframe|550|550'
                });
                e.preventDefault();
            });

            jQuery('a.manuModal').click(function(e) {
                jQuery.facebox({
                    iframe: '<?php echo $manulink; ?>',
                    rev: 'iframe|550|550'
                });
                e.preventDefault();
            });

    <?php
}
?>
    </script>

