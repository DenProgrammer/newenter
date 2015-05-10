<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
?>
<!--BEGIN Search Box -->
<style>
    input.vm_search{
        padding-top: 5px; 
        width: 190px; 
        height: 23px; 
        background: #000000; 
        color: white; 
        border: 1px solid #585858;
    }
    #keyword{
        width: 190px;
    }
    #search_categories{
        width: 195px;
    }
    input.prices{
        width: 50px;
    }
    option.level0{
        font-weight: bold;
        color: red;
    }
    option.level1{
        padding-left: 10px;
        font-size: 10px;
    }
    div.advanced_search p{
        margin-top: 8px;
        margin-bottom: 4px;
    }
    div.advanced_search{
        /*height: 0px;*/
    }
    #advanced_search_btn{
        text-decoration: underline;
        cursor: pointer;
        margin-top: 10px;
        margin-bottom: 5px;
        display: inline-block;
    }
</style>
<script>
    jQuery('document').ready(function($) {
        $('div.advanced_search').hide();

        $('#keyword').focus(function() {
            if ($(this).val() === 'Что ищем?') {
                $(this).val('');
            }
        }).blur(function() {
            if ($(this).val() === '') {
                $(this).val('Что ищем?');
            }
        });

        $('input.vm_search').click(function() {
            if ($('#keyword').val() === 'Что ищем?') {
                $('#keyword').val('');
            }
        });

        $('#advanced_search_btn').click(function() {
            if ($('div.advanced_search').css('display') === 'none') {
                $('div.advanced_search').show();
            } else {
                $('div.advanced_search').hide();
            }
            return false;
        });
    });
</script>
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

<!-- End Search Box -->
