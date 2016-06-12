<?php
/**
 * sublayout products
 *
 * @package	VirtueMart
 * @author Max Milbers
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2014 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL2, see LICENSE.php
 * @version $Id: cart.php 7682 2014-02-26 17:07:20Z Milbo $
 */
defined('_JEXEC') or die('Restricted access');
$products_per_row  = $viewData['products_per_row'];
$currency          = $viewData['currency'];
$keyword           = $viewData['keyword'];
$isSearch          = $viewData['isSearch'];
$showRating        = $viewData['showRating'];
$actualTime        = $viewData['actualTime'];
$verticalseparator = " vertical-separator";

$userGroup   = JFactory::getUser()->getAuthorisedGroups();
$allowGroups = array(7, 8);
$showSku     = array_intersect($allowGroups, $userGroup);

$categoryNames = array();
?>
<script>
    jQuery(function ($) {
        $('img[rel=product-image]').each(function () {
            var id = $(this).attr('id');
            var id1 = '.img_' + id;
            var id2 = '.detail_' + id;

            drift = new Drift(document.querySelector(id1), {
                paneContainer: document.querySelector(id2),
                inlinePane: 900,
                inlineOffsetY: -85,
                zoomFactor: 6,
                containInline: true
            });
        });

        $('td a img[rel=product-image]').on('mouseover', '', function () {
            $(this).parent().parent().find('div.detail').css('display', 'block');
        }).on('mouseout', '', function () {
            $(this).parent().parent().find('div.detail').css('display', 'none');
        });

    });

</script>
<style>
    .wrap-detail {
        left: 50%;
        top: 50%;
        position: fixed;
        margin-top: -150px;
        margin-left: -200px;
    }
</style>
<?php
foreach ($viewData['products'] as $type => $products) {

    $rowsHeight = shopFunctionsF::calculateProductRowsHeights($products, $currency, $products_per_row);

    if (!empty($type) and count($products) > 0) {
        $productTitle = vmText::_('COM_VIRTUEMART_'.strtoupper($type).'_PRODUCT');
        ?>
        <div class="<?php echo $type ?>-view">
            <h4><?php echo $productTitle ?></h4>
            <?php
            // Start the Output
        }

        // Calculating Products Per Row
        $cellwidth = ' width'.floor(100 / $products_per_row);

        $BrowseTotalProducts = count($products);

        $col = 1;
        $nb  = 1;
        $row = 1;

        foreach ($products as $product) {

            if (!isset($categoryNames[$product->category_name])) {
                $categoryNames[$product->category_name] = 1;
                ?>
                <?php if ($isSearch) { ?>
                    <h2><?php echo $product->category_name; ?></h2>
                <?php } else { ?>
                    <div style="visibility: hidden; font-size: 1px;">1</div>
                <?php } ?>
                <div class="horizontal-separator vm-product-container"></div><?php
            }

            // Show the horizontal seperator
            if ($col == 1 && $nb > $products_per_row) {
                ?>
                <div class="horizontal-separator"></div>
                <?php
            }

            // this is an indicator wether a row needs to be opened or not
            if ($col == 1) {
                ?>
                <div class="row">
                    <?php
                }

                // Show the vertical seperator
                if ($nb == $products_per_row or $nb % $products_per_row == 0) {
                    $show_vertical_separator = ' ';
                } else {
                    $show_vertical_separator = $verticalseparator;
                }

                if ($showSku) {
                    $sku = str_replace('sklad-', '', $product->product_sku);
                } else {
                    $sku = preg_replace('/(sklad-)([0-9]{1,3})([-]{1})([0-9]*)/', '$4', $product->product_sku);
                }

                $product->product_name = html_entity_decode($product->product_name);

                $now = new \DateTime();
                $old = new \DateTime($product->created_on);

                $obj = $now->diff($old);

                $newimg = $obj->d * 24 + $obj->h < $actualTime ? '<div class="new-product-image"><img src="images/newprod.gif"/></div>' : '';

                // Show Products 
                ?>
                <div class="product vm-col<?php echo ' vm-col-'.$products_per_row.$show_vertical_separator ?>">
                    <table width="100%">
                        <tr>
                            <td width="140">
                                <?php
                                echo $newimg;

                                $target = '';
                                if ($product->images[0]->virtuemart_media_id > 0) {
                                    $title  = $product->product_name;
                                    $href   = $product->link;
                                    $target = '';
                                    $url    = $product->images[0]->file_url;
                                    $rel    = 'product-image';
                                } else {
                                    $title = 'Найти в Google';
                                    $href  = 'http://www.google.kg/search?q='.$product->product_name.'&tbm=isch';
                                    $target = ' target="blank" ';
                                    $url   = 'images/yandex.png';
                                    $rel   = 'product-image-default';
                                }
                                ?>
                                <a title="<?php echo $title; ?>" <?php echo $target; ?> href="<?php echo $href; ?>">
                                    <img 
                                        id="<?php echo $product->virtuemart_product_id; ?>" 
                                        class="img_<?php echo $product->virtuemart_product_id; ?>" alt="" width="100" 
                                        rel="<?php echo $rel; ?>"
                                        src="<?php echo $url; ?>" 
                                        data-zoom="<?php echo $url; ?>">
                                </a>
                                <div style="position: relative;">
                                    <div class="wrap-detail"><div class="detail detail_<?php echo $product->virtuemart_product_id; ?>"></div></div>
                                </div>

                            </td>
                            <td>
                                <div class="rows">
                                    <span rel="tooltip" title="<?php echo $product->product_s_desc; ?>" class="prouct_name"><?php echo JHtml::link($product->link, $product->product_name); ?></span>
                                </div>
                                <div class="rows">
                                    <table width='100%'>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td width='260'>
                                                <label class="pricelbl">Цена: </label>
                                                <span class="price"><?php echo shopFunctionsF::renderVmSubLayout('prices', array('product' => $product, 'currency' => $currency)); ?></span>
                                            </td>
                                            <td width='110'>
                                                <span class="sku">
                                                    <label>Артикул: </label>
                                                    <span><?php echo $sku; ?></span>
                                                </span>
                                            </td>
                                            <td width='100'>
                                                <span class="cart">
                                                    <?php echo shopFunctionsF::renderVmSubLayout('addtocart', array('product' => $product, 'rowHeights' => $rowsHeight[$row])); ?>
                                                </span>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>

                <?php
                $nb ++;

                // Do we need to close the current row now?
                if ($col == $products_per_row || $nb > $BrowseTotalProducts) {
                    ?>
                    <div class="clear"></div>
                </div>
                <?php
                $col = 1;
                $row++;
            } else {
                $col ++;
            }
        }

        if (!empty($type) and count($products) > 0) {
            // Do we need a final closing row tag?
            //if ($col != 1) {
            ?>
            <div class="clear"></div>
        </div>
        <?php
        // }
    }
}
