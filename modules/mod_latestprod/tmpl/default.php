<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
?>
<div class="latest_products">
    <ul>
        <?php
        foreach ($products as $product) {
            $image = $product->images[0];
            ?>
            <li>
                <div class="prod_title">
                    <a href ="<?php echo $product->link; ?>">
                        <?php echo $product->product_name; ?>
                    </a>
                </div>
                <div class="prod_img">
                    <?php echo $image->displayMediaThumb("", true, "rel='vm-additional-images'"); ?>
                </div>
                <div class="prod_price">
                    <span><?php echo JText::_('MOD_LATESTPROD_PRICE') ?></span>
                    <span><?php echo round($product->prices['salesPrice'], 2); ?> USD / <?php echo round($product->prices['salesPrice'] * $kurs); ?> Сом</span>
                </div>
            </li>
            <?php
        }
        ?>        
    </ul>
</div>
