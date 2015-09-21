<fieldset class="vm-fieldset-pricelist">
    <table
        class="cart-summary" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <th align="left"><?php echo vmText::_('COM_VIRTUEMART_CART_NAME') ?></th>
            <th align="left"><?php echo vmText::_('COM_VIRTUEMART_CART_SKU') ?></th>
            <th
                align="center"
                width="120px"><?php echo vmText::_('COM_VIRTUEMART_CART_PRICE') ?></th>
            <th
                align="right"
                width="110px"><?php echo vmText::_('COM_VIRTUEMART_CART_QUANTITY') ?>
                / <?php echo vmText::_('COM_VIRTUEMART_CART_ACTION') ?></th>

            <th align="right" width="120px"><?php echo vmText::_('COM_VIRTUEMART_CART_TOTAL') ?></th>
        </tr>

        <?php
        $i = 1;

        foreach ($this->cart->products as $pkey => $prow) {
            ?>
            <tr valign="top" class="sectiontableentry<?php echo $i ?>">
                <td align="left">
                    <?php if ($prow->virtuemart_media_id) { ?>
                        <span class="cart-images">
                            <?php
                            if (!empty($prow->images[0])) {
                                echo $prow->images[0]->displayMediaThumb('', FALSE);
                            }
                            ?>
                        </span>
                    <?php } ?>
                    <?php
                    echo JHtml::link($prow->url, html_entity_decode($prow->product_name));
                    echo $this->customfieldsModel->CustomsFieldCartDisplay($prow);
                    ?>

                </td>
                <td align="left"><?php echo preg_replace('/(sklad-)([0-9]{1,3})([-]{1})([0-9]*)/', '$4', $prow->product_sku); ?></td>
                <td align="center">
                    <?php
                    echo round($this->currency->roundForDisplay($prow->prices['salesPrice'], 165, 1, 0)) . ' '
                    . JText::_('COM_VIRTUEMART_CURRENCY_KGS')
                    . ' / '
                    . round($prow->prices['salesPrice'], 2) . ' $';
                    ?>
                </td>
                <td align="right"><?php
                    $step = ($prow->step_order_level) ? $prow->step_order_level : 1;

                    if ($step == 0) {
                        $step = 1;
                    }
                    ?>
                    <input type="text"
                           onblur="Virtuemart.checkQuantity(this,<?php echo $step ?>, '<?php echo vmText::_('COM_VIRTUEMART_WRONG_AMOUNT_ADDED') ?>');"
                           onclick="Virtuemart.checkQuantity(this,<?php echo $step ?>, '<?php echo vmText::_('COM_VIRTUEMART_WRONG_AMOUNT_ADDED') ?>');"
                           onchange="Virtuemart.checkQuantity(this,<?php echo $step ?>, '<?php echo vmText::_('COM_VIRTUEMART_WRONG_AMOUNT_ADDED') ?>');"
                           onsubmit="Virtuemart.checkQuantity(this,<?php echo $step ?>, '<?php echo vmText::_('COM_VIRTUEMART_WRONG_AMOUNT_ADDED') ?>');"
                           title="<?php echo vmText::_('COM_VIRTUEMART_CART_UPDATE') ?>" 
                           class="quantity-input js-recalculate" size="3" maxlength="4" 
                           name="quantity[<?php echo $pkey; ?>]" 
                           value="<?php echo $prow->quantity ?>"
                           style="display: inline;"/>

                    <button type="submit" class="vmicon vm2-add_quantity_cart" name="updatecart.<?php echo $pkey ?>" title="<?php echo vmText::_('COM_VIRTUEMART_CART_UPDATE') ?>" />

                    <button type="submit" class="vmicon vm2-remove_from_cart" name="delete.<?php echo $pkey ?>" title="<?php echo vmText::_('COM_VIRTUEMART_CART_DELETE') ?>" />
                </td>

                <td colspan="1" align="right">
                    <?php
                    echo round($this->currency->roundForDisplay($prow->prices['salesPrice'] * $prow->quantity, 165, 1, 0)) . ' '
                    . JText::_('COM_VIRTUEMART_CURRENCY_KGS')
                    . ' / '
                    . round($prow->prices['salesPrice'] * $prow->quantity, 2) . ' $';
                    ?>
                </td>
            </tr>
            <?php
            $i = ($i == 1) ? 2 : 1;
        }
        ?>
        <!--Begin of SubTotal, Tax, Shipment, Coupon Discount and Total listing -->
        <?php
        if (VmConfig::get('show_tax')) {
            $colspan = 2;
        } else {
            $colspan = 1;
        }
        ?>

        <tr>
            <td colspan="4">&nbsp;</td>
            <td colspan="<?php echo $colspan ?>">
                <hr/>
            </td>
        </tr>
        <tr class="sectiontableentry2">
            <td colspan="4" align="right"><?php echo vmText::_('COM_VIRTUEMART_CART_TOTAL') ?>:</td>

            <td align="right"><strong><?php echo $this->currencyDisplay->createPriceDiv('billTotal', '', $this->cart->cartPrices['billTotal'], FALSE); ?></strong></td>
        </tr>
        <?php
        if ($this->totalInPaymentCurrency) {
            ?>

            <tr class="sectiontableentry2">
                <td colspan="4" align="right"><?php echo vmText::_('COM_VIRTUEMART_CART_TOTAL_PAYMENT') ?>:</td>
                <td align="right"><strong><?php echo $this->totalInPaymentCurrency; ?></strong></td>
            </tr>
            <?php
        }
        ?>

    </table>
</fieldset>
