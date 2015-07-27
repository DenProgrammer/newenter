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
<div class="assembly">
    <?php
    if ($this->assembly->showimage == 1) {
        echo $this->assembly->images[0]->displayMediaThumb('class="browseProductImage"', false);
    }
    ?>
    <h1><?php echo $this->assembly->title; ?></h1>
    <?php if (!empty($this->assembly->description)) {
        ?>
        <div class="category_description">
            <?php echo html_entity_decode($this->assembly->description); ?>
        </div>
        <?php
    }
    ?>
    <div class="browse-view">
        <?php
        if (!empty($this->assembly->products)) {
            $products = array($this->assembly->products);
            echo shopFunctionsF::renderVmSubLayout('products_assembly', array('products' => $products, 'assemblyProducts' => $this->assembly->assemblyProducts, 'currency' => $this->assembly->currency, 'products_per_row' => $this->perRow, 'showRating' => 0));
        } elseif (!empty($this->keyword)) {
            echo vmText::_('COM_VIRTUEMART_NO_RESULT') . ($this->keyword ? ' : (' . $this->keyword . ')' : '');
        }

        $allPrices = array('usd' => 0, 'kgs' => 0);
        foreach ($this->assembly->products as $product) {
            $allPrices['kgs'] += round($this->assembly->currency->roundForDisplay($product->prices['salesPrice'], 165, 1, 0)) * $this->assembly->assemblyProducts[$product->virtuemart_product_id]->product_count;
            $allPrices['usd'] += round($product->prices['salesPrice'], 2) * $this->assembly->assemblyProducts[$product->virtuemart_product_id]->product_count;
        }
        ?>

        <div class="total_price">
            <label class="pricelbl">Итого получается: </label>
            <span class="price"><?php echo $allPrices['kgs']; ?> Сом / <?php echo $allPrices['usd']; ?> $</span>
        </div>

        <div class="addtocart-area" style="width:100%; height: 50px;float: right;">
            <form action="/newenter/index.php?option=com_virtuemart" class="product js-recalculate" method="post">

                <div class="addtocart-bar">
                    <span class="addtocart-button" style="float: right;">
                        <input 
                            type="submit" 
                            title="Купить" 
                            value="Купить" 
                            class="addtocart-button button-gloss" 
                            name="addtocart" 
                            />                        
                    </span>
                </div>        
                <input type="hidden" value="com_virtuemart" name="option">
                <input type="hidden" value="cart" name="view">
                <?php
                $i = 0;
                foreach ($this->assembly->assemblyProducts as $item) {
                    ?>
                    <input type="hidden" value="<?php echo $item->product_id; ?>" name="virtuemart_product_id[<?php echo $i; ?>]">
                    <input type="hidden" value="<?php echo $item->product_count; ?>" name="quantity[<?php echo $i; ?>]" />
                    <?php
                    $i++;
                }
                ?>
            </form>

        </div>
    </div>
</div>