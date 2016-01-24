<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
?>
<form action="<?php echo JRoute::_('index.php?option=com_virtuemart&view=category&search=true&limitstart=0&virtuemart_category_id=' . $category_id); ?>" method="get">
    <div class="search<?php echo $params->get('moduleclass_sfx'); ?>">
        <div>
            <input 
                name="keyword" 
                id="mod_virtuemart_search" 
                maxlength="<?php echo $maxlength; ?>" 
                alt="<?php echo $button_text; ?>" 
                class="inputbox<?php echo $moduleclass_sfx; ?>" 
                type="text" 
                size="<?php echo $width; ?>" 
                value="<?php echo $text; ?>"  
                onblur="if (this.value == '') {
                            this.value = '<?php echo $text; ?>';
                        }" 
                onfocus="if (this.value == '<?php echo $text; ?>') {
                            this.value = '';
                        }" />
        </div>

        <a id="advanced_search_btn" href="#">Расширенный поиск</a>
        <div class="advanced_search">
            <p>
                <label>Поиск в категориях</label>
                <select id="search_categories" name="advanced_search_categories">
                    <option value="">Все</option>
                    <?php
                    foreach ($categories as $category) {
                        $offset = str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $category->level);
                        echo '<option class="level' . $category->level . '" value="' . $category->countChild . '">'
                        . $offset . $category->category_name
                        . '</option>';
                    }
                    ?>
                </select>
            </p>
            <p>
                <label>Диапазон цен</label>
                <br/>
                От <input name="advanced_search_price_min" class="prices" value="0" />
                &nbsp;&nbsp;
                До <input name="advanced_search_price_max" class="prices" value="0" />
            </p>
            <p>
                <span>
                    USD <input type="radio" checked name="advanced_search_currency" value="USD" />
                    &nbsp;&nbsp;
                    KGS <input type="radio" name="advanced_search_currency" value="KGS" />
                </span>
            </p>
        </div>

        <div>
            <input 
                type="submit" 
                value="<?php echo $button_text; ?>" 
                class="button<?php echo $moduleclass_sfx; ?> right_col_but button-gloss" 
                onclick="this.form.keyword.focus();"
                />
        </div>

    </div>
    <input type="hidden" name="limitstart" value="0" />
    <input type="hidden" name="option" value="com_virtuemart" />
    <input type="hidden" name="view" value="category" />
    <?php
    if (!empty($set_Itemid)) {
        echo '<input type="hidden" name="Itemid" value="' . $set_Itemid . '" />';
    }
    ?>

</form>
