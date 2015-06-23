<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
?>
<div class="latest_products">
    <ul>
        <?php
        foreach ($products as $product) {
            if (!isset($product->virtuemart_product_id)) {
                continue;
            }
            $image = $product->images[0];
            ?>
            <li>
                <div class="prod_title">
                    <a href ="<?php echo $product->link; ?>">
                        <?php echo html_entity_decode($product->product_name); ?>
                    </a>
                </div>
                <div class="prod_img">
                    <a href ="<?php echo $product->link; ?>">
                        <?php echo $image->displayMediaThumb("", false, ""); ?>
                    </a>
                </div>
                <div class="prod_price">
                    <!--<label class="pricelbl"><?php echo JText::_('MOD_LATESTPROD_PRICE') ?>: </label>-->
                    <span class="price" style="margin-right: 0px;"><?php echo round($product->prices['salesPrice'] * $kurs); ?> Сом / <?php echo round($product->prices['salesPrice'], 2); ?> $</span>
                </div>
            </li>
            <?php
        }
        ?>        
    </ul>
</div>
