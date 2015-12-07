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
$showRating        = $viewData['showRating'];
$verticalseparator = " vertical-separator";

$userGroup   = JFactory::getUser()->getAuthorisedGroups();
$allowGroups = array(7, 8);
$showSku     = array_intersect($allowGroups, $userGroup);

$categoryNames = array();

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
                ?><h2><?php echo $product->category_name; ?></h2>
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

                // Show Products 
                ?>
                <div class="product vm-col<?php echo ' vm-col-'.$products_per_row.$show_vertical_separator ?>">
                    <table width="100%">
                        <tr>
                            <td width="140">
                                <?php if ($product->images[0]->virtuemart_media_id > 0) { ?>
                                    <a title="<?php echo $product->product_name ?>" href="<?php echo $product->link; ?>">
                                    <?php } else { ?>
                                        <a title="Найти в Google" target="blank" href="http://www.google.kg/search?q=<?php echo $product->product_name; ?>&tbm=isch">
                                        <?php } ?>
                                        <?php
                                        echo $product->images[0]->displayMediaThumb('class="browseProductImage"', false);
                                        ?>
                                    </a>
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
