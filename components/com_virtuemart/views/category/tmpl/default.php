<?php
/**
 *
 * Show the products in a category
 *
 * @package    VirtueMart
 * @subpackage
 * @author RolandD
 * @author Max Milbers
 * @todo add pagination
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: default.php 8508 2014-10-22 18:57:14Z Milbo $
 */
defined('_JEXEC') or die('Restricted access');
JHtml::_('behavior.modal');

$js = "
jQuery(document).ready(function () {
	jQuery('.orderlistcontainer').hover(
		function() { jQuery(this).find('.orderlist').stop().show()},
		function() { jQuery(this).find('.orderlist').stop().hide()}
	)
});
";

vmJsApi::addJScript('vm.hover', $js);

$imageJS = '
	jQuery(document).ready(function() {
		Virtuemart.updateImageEventListeners()
	});
	Virtuemart.updateImageEventListeners = function() {
		jQuery("a[rel=vm-additional-images]").fancybox({
			"titlePosition" 	: "inside",
			"transitionIn"	:	"elastic",
			"transitionOut"	:	"elastic"
		});
		jQuery(".additional-images a.product-image.image-0").removeAttr("rel");
		jQuery(".additional-images img.product-image").click(function() {
			jQuery(".additional-images a.product-image").attr("rel","vm-additional-images" );
			jQuery(this).parent().children("a.product-image").removeAttr("rel");
			var src = jQuery(this).parent().children("a.product-image").attr("href");
			jQuery(".main-image img").attr("src",src);
			jQuery(".main-image img").attr("alt",this.alt );
			jQuery(".main-image a").attr("href",src );
			jQuery(".main-image a").attr("title",this.alt );
			jQuery(".main-image .vm-img-desc").html(this.alt);
		}); 
	}
	';

vmJsApi::addJScript('imagepopup', $imageJS);
?>
<h1><?php echo $this->category->category_name; ?></h1>
<?php if (empty($this->keyword) and ! empty($this->category)) {
    ?>
    <div class="category_description">
        <?php echo $this->category->category_description; ?>
    </div>
    <?php
}

// Show child categories
if (VmConfig::get('showCategory', 1) and empty($this->keyword)) {
    if (!empty($this->category->haschildren)) {

        echo ShopFunctionsF::renderVmSubLayout('categories', array('categories' => $this->category->children));
    }
}

if ($this->showproducts) {
    ?>
    <div class="browse-view">
        <div class="orderby-displaynumber">
            <div class="floatleft vm-order-list">
                <?php echo $this->orderByList['orderby']; ?>
                <?php echo $this->orderByList['manufacturer']; ?>
            </div>
            <div class="vm-pagination vm-pagination-top">
                <?php echo $this->vmPagination->getPagesLinks(); ?>
                <span class="vm-page-counter"><?php echo $this->vmPagination->getPagesCounter(); ?></span>
            </div>
            <div class="floatright display-number"><?php echo $this->vmPagination->getResultsCounter(); ?><br/><?php echo $this->vmPagination->getLimitBox($this->category->limit_list_step); ?></div>


            <div class="clear"></div>
        </div> <!-- end of orderby-displaynumber -->

        <h1><?php echo $this->category->category_name; ?></h1>

        <?php
        if (!empty($this->products)) {
            $products    = array();
            $products[0] = $this->products;

            $data = array(
                'products'         => $products,
                'currency'         => $this->currency,
                'products_per_row' => $this->perRow,
                'showRating'       => $this->showRating,
                'isSearch'         => $this->isSearch,
            );
            echo shopFunctionsF::renderVmSubLayout($this->productsLayout, $data);
            ?>

            <div class="vm-pagination vm-pagination-bottom">
                <?php echo $this->vmPagination->getPagesLinks(); ?>
                <span class="vm-page-counter"><?php echo $this->vmPagination->getPagesCounter(); ?></span>
            </div>

            <?php
        } elseif (!empty($this->keyword)) {
            ?>

            <div class="vm-no-result">
                <?php echo vmText::_('COM_VIRTUEMART_NO_RESULT').($this->keyword ? ' : ('.$this->keyword.')' : ''); ?>
            </div>
            <?php
        }
        ?>
    </div>

    <?php
} 