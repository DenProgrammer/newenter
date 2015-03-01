<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
?>
<style>
    div.latest_products{
        padding: 0 10px;
        text-align: center;
    }
    div.latest_products h2{
        margin-top: 50px;
        margin-bottom: 10px;
    }
    div.latest_products ul{
        padding-left: 0px;
        margin-top: 0px;
        margin-bottom: 0px;
    }
    div.latest_products ul li{
        list-style: none;
        padding: 10px;
        width: 180px;
        height: 180px;
        border: solid 1px red;
        border-radius: 10px;
        display: inline-block;
        margin: 5px 10px;
    }
    div.latest_products ul li a div.prod_title{
        height: 30px;
        overflow: hidden;
    }
    div.latest_products ul li a div.prod_img{
        height: 120px;
        text-align: center;
        vertical-align: middle;
        overflow: hidden;
    }
    div.latest_products ul li a div.prod_img img{
        margin-top: 20px;
    }
    div.latest_products ul li a div.prod_price{
        line-height: 30px;
        text-align: left;
    }
    div.latest_products ul li a div.prod_price span:last-child{
        float: right;
        font-weight: bold;
        color: #f90000;
    }
</style>
<div class="latest_products">
    <ul>
        <?php
        foreach ($products as $product) {
            $image = $product->images[0];
            ?>
            <li>
                <div class="prod_title"><a href ="<?php echo $product->link; ?>">
                        <?php echo $product->product_name; ?>
                    </a>
                </div>
                <div class="prod_img">
                    <img height="80" src="<?php echo $image->createThumb(80, 80); ?>" />
                </div>
                <div class="prod_price">
                    <span><?php echo JText::_('MOD_LATESTPROD_PRICE') ?></span>
                    <span><?php echo round($product->prices['salesPrice'], 2); ?> USD / <?php echo round($product->product_price * $kurs); ?> Сом</span>
                </div>
            </li>
            <?php
        }
        ?>        
    </ul>
</div>
