<?php
defined('_JEXEC') or die('Restricted access');
$category = getCategoryList();
?>
<img id="import_prldr" src="<?php echo PATH_ASSETS; ?>/images/prldr.gif">

<div id="import_loading">
    <h3>Загрузка прайса</h3>
    <img src="../images/loading.GIF" />
</div>

<div id="parse_panel" style="display:none;"></div>
<div id="sklads" style="display:none;"></div>
<table style="table-layout:fixed;width:100%;" border="0">
    <tr id="top_btns">
        <td align="center">
            <div id="top_btns_1" onclick="selectMenu(1)" class="active">Обновление / Добавление Товаров</div>
        </td>
        <td align="center">
            <div id="top_btns_2" onclick="selectMenu(2)">Автозаполнение Яндекс Маркет</div>
        </td>
        <td align="center">
            <div id="top_btns_3" onclick="selectMenu(3)">Архивы / Экспорт</div>
        </td>
    </tr>
</table>
<div id="page">
    <div id="page_lt" class="round"></div>
    <div id="page_rt" class="round"></div>
    <div id="page_lb" class="round"></div>
    <div id="page_rb" class="round"></div>

    <div id="page_conteyner_1" class="page_conteyner" style="position:relative;">
        <div onclick="showWinNadbavka()" style="cursor:pointer;position:absolute;right:10px;top:10px;color:red;text-decoration:underline;">Редактировать надбавки</div>
        <table border="0" width="100%">
            <tr>
                <td width="450" valign="top">
                    <div id="win">
                        <div class="win_lt round"></div>
                        <div class="win_rt round"></div>
                        <div class="win_lb round"></div>
                        <div class="win_rb round"></div>

                        <div id="scroll">
                            <div id="bar"></div>
                        </div>

                        <div class="data">
                            <table id="doclisttable">
                                <?php
                                $mas      = getDocumentList();
                                //pr($mas);
                                $num      = 0;
                                $str      = '';
                                for ($i = 1; $i <= count($mas); $i++) {
                                    if ($num == 0)
                                        $str .= '<tr>';
                                    $str .= '<td valign="top">
                                                <div id="doc' . $i . '" class="documents" onclick="selectDocument(' . $i . ')">
                                                    <div class="d_lt round"></div>
                                                    <div class="d_lb round"></div>
                                                    <div class="d_rt round"></div>
                                                    <div class="d_rb round"></div>
                                                    <h3>' . ($mas[$i]->basename) . '</h3>
                                                    <img src="' . PATH_ASSETS . '/images/document.png">
                                                    <div class="doc_info">
                                                        Размещен	:' . ($mas[$i]->dataload) . '<br>
                                                        Формат	: ' . ($mas[$i]->extension) . '</br>
                                                        Размер	: ' . ($mas[$i]->filesize) . 'kb
                                                    </div>
                                                </div>
                                            </td>';
                                    if ($num == 1) {
                                        $str .= '<tr>';
                                    }

                                    $num++;
                                    if ($num > 1) {
                                        $num = 0;
                                    }
                                }

                                echo $str;
                                ?>
                            </table>
                        </div>
                    </div>
                </td>
                <td rowspan="2" valign="top" align="center">
                    <div id="options_update" class="options">
                        <h3>Настройки обновления</h3>
                        <table border="0">
                            <tr>
                                <td class="opt_update_text">
                                    Укажите склад 
                                </td>
                                <td rowspan="6" width="10">&nbsp;</td>
                                <td>
                                    <div class="select_conteyner">
                                        <div id="price_top" class="select_top select_top_options">
                                            <?php echo $dataPriceType[0]; ?>
                                        </div>
                                        <select id="price" onchange="changePrice()">
                                            <?php
                                            if ($dataPriceType)
                                                foreach ($dataPriceType as $item) {
                                                    echo "<option value=\"$item\">$item</option>";
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div style="position:relative;">
                                        <img 
                                            style="cursor: pointer;position: absolute;right: -55px;top: -45px;" 
                                            src="<?php echo PATH_ASSETS; ?>/images/options.png" 
                                            onclick="getWinListSklad()" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="opt_update_text">
                                    Укажите валюту
                                </td>
                                <td>
                                    <div id="currency_top" class="select_top select_top_options">
                                        <?php
                                        if ($currencys[$dataPriceType[0]] == 'USD') {
                                            echo 'Доллар США';
                                        } else {
                                            echo 'Сом';
                                        }
                                        ?>
                                    </div>
                                    <select id="currency" onchange="changeCurrency()">
                                        <option <?php if ($currencys[$dataPriceType[0]] == 'USD') { ?>selected<?php } ?> value="USD">Доллар США</option>
                                        <option <?php if ($currencys[$dataPriceType[0]] == 'KGS') { ?>selected<?php } ?> value="KGS">Сом</option>
                                    </select>
                                    <script type="text/javascript">
                                        var currencys = new Array();
<?php
foreach ($currencys as $key => $val) {
    echo "currencys['$key'] = '$val';\n";
}
?>
                                    </script>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="opt_update_text">
                                    Выделять новые
                                </td>
                                <td>
                                    <div class="select_conteyner">
                                        <div id="akcent_top" class="select_top select_top_options">
                                            <?php
                                            if ($_SESSION['import']['akcent'] == 'on') {
                                                echo 'Выделять';
                                            } else {
                                                echo 'Не выделять';
                                            }
                                            ?>
                                        </div>
                                        <select id="akcent" onchange="changeAkcent('akcent')">
                                            <option <?php if ($_SESSION['import']['akcent'] == '') echo 'selected'; ?> value="">Не выделять</option>
                                            <option <?php if ($_SESSION['import']['akcent'] == 'on') echo 'selected'; ?> value="on">Выделять</option>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="opt_update_text">
                                    Товар будет новым
                                </td>
                                <td>
                                    <?php
                                    $table = array(
                                        "1"   => "1 час",
                                        "2"   => "2 часа",
                                        "4"   => "4 часа",
                                        "6"   => "6 часов",
                                        "12"  => "12 часов",
                                        "24"  => "1 день",
                                        "48"  => "2 дня",
                                        "72"  => "3 дня",
                                        "96"  => "4 дня",
                                        "120" => "5 дней",
                                        "144" => "6 дней",
                                        "168" => "7 дней"
                                    );
                                    ?>
                                    <div class="select_conteyner">
                                        <div id="akcent_time_top" class="select_top select_top_options">
                                            <?php echo $table[$_SESSION['import']['akcent_time']]; ?>
                                        </div>
                                        <select id="akcent_time" onchange="changeAkcent('akcent_time')">
                                            <?php
                                            foreach ($table as $k => $v) {
                                                $sel = ($k == $_SESSION['import']['akcent_time']) ? 'selected' : '';

                                                echo "<option $sel value='$k'>$v</option>";
                                            }
                                            ?>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="opt_update_text">
                                    Добавлять надбавку
                                </td>
                                <td>
                                    <div class="select_conteyner">
                                        <div id="markup_top" class="select_top select_top_options">
                                            <?php
                                            switch ($markups[$dataPriceType[0]]) {
                                                case 1: {
                                                        $value = 'Да';
                                                        break;
                                                    }
                                                case 2: {
                                                        $value = 'Фикс. %';
                                                        break;
                                                    }
                                                default: {
                                                        $value = 'Нет';
                                                    }
                                            }

                                            echo $value;
                                            ?>
                                        </div>
                                        <select id="markup" onchange="changeMarkup()">
                                            <option <?php if ($markups[$dataPriceType[0]] == 1) { ?>selected<?php } ?> value='1'>Да</option>
                                            <option <?php if ($markups[$dataPriceType[0]] == 0) { ?>selected<?php } ?> value='0'>Нет</option>
                                            <option <?php if ($markups[$dataPriceType[0]] == 2) { ?>selected<?php } ?> value='2'>Фикс. %</option>
                                        </select>
                                        <script type="text/javascript">
                                            var markups = new Array();
<?php
foreach ($markups as $key => $val) {
    echo 'markups["' . $key . '"] = ' . $val . ";\n";
}
?>
    
                                            var fix_markups = new Array();
<?php
foreach ($fix_markups as $key => $val) {
    echo 'fix_markups["' . $key . '"] = ' . $val . ";\n";
}
?>
                                        </script>
                                    </div>
                                </td>
                            </tr>
                            <tr id="show_fix_markup">
                                <td class="opt_update_text">&nbsp;</td>
                                <td>
                                    <div class="select_conteyner">
                                        <div id="markup_top" class="select_top select_top_options_input">
                                            <input type="text" id="markup_fix_value" onkeyup="changeMarkupFix(this.value)" value="<?php echo $fix_markups['brand']; ?>" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <input type="button" id="input_update" class="start_btn" onclick="startUpdate(0)" value="обновить"/>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div id="options_addprice" class="options">
                        <img src="<?php echo PATH_ASSETS; ?>/images/close.png" onclick="closeWinNadbavka()" style="float:right;cursor:pointer;"/>
                        <div class="content">
                            <table id="addprice_table">
                                <tr>
                                    <td class="opt_update_text">Цена «До»</td>
                                    <td class="opt_update_text">Надбавка</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <?php
                                $data = getNadbavkaList();

                                foreach ($data as $item) {
                                    $id      = $item->id;
                                    $sum     = $item->sum;
                                    $sum_tax = $item->sum_tax;
                                    $tax     = $item->tax;

                                    if ($tax == 'fix') {
                                        $vs = 'Фиксиров';
                                        $fs = 'selected';
                                        $ps = '';
                                    } else {
                                        $vs = 'Проценты';
                                        $fs = '';
                                        $ps = 'selected';
                                    }

                                    echo '<tr id="tr_' . $id . '">
                                            <td>
                                                <input onchange="changeNadbavka(' . $id . ')" id="price_' . $id . '" type="text" value="' . $sum . '"/>
                                            </td>
                                            <td>
                                                <input onchange="changeNadbavka(' . $id . ')" id="nadbavka_' . $id . '" type="text" value="' . $sum_tax . '"/>
                                            </td>
                                            <td>
                                                <div class="select_conteyner">
                                                    <div id="type_nadbavka_' . $id . '_top" class="select_top select_top_addprice">
                                                        ' . $vs . '
                                                    </div>
                                                    <select id="type_nadbavka_' . $id . '" onchange="changeNadbavka(' . $id . ')">
                                                        <option ' . $fs . ' value="fix">Фиксиров</option>
                                                        <option ' . $ps . ' value="per">Проценты</option>
                                                    </select>
                                                </div>
                                            </td>
                                    </tr>';
                                }
                                ?>

                            </table>
                            <div onclick="addNadbavka()" style="text-decoration:underline;cursor:pointer;">Добавить надбавку</div>
                        </div>
                    </div>
                </td>
            </tr>
            <tr height="90">
                <td>
                    <form method="post" id="upload_price" action="index.php?option=com_import" enctype="multipart/form-data">
                        <table>
                            <tr>
                                <td colspan="2">
                                    <span style="color:#000000;font:bold 13px Arial;text-decoration:underline;text-transform:uppercase;">Загрузить с компьютера</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div id="upload_str">

                                        <input type="file" name="price" onchange="jQuery('#file_str').html(this.value)"/>
                                        <div id="file_str" style="position:absolute;top:10px;left:10px;"></div>
                                        <input type="button" onclick="jQuery('#upload_price input[type=file]').click()" value="Обзор"/>
                                    </div>
                                </td>
                                <td>
                                    <input type="submit" value="Загрузить"/>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" name="load_file" value="1"/>
                    </form>
                </td>
            </tr>
        </table>


    </div>

    <div id="page_conteyner_2" class="page_conteyner">

        <table border="0" width="100%">
            <tr>
                <td width="130" class="txt1">Список товаров</td>
                <td width="460" align="right">
                    <div style="float:left;padding-top:3px;">Поиск <input onchange="changeCategory(0, this.value)" type="text" id="filtr" class="model_input"/></div>
                    <div class="select_conteyner width_long" style="margin-right:10px;">
                        <div id="category_top" class="select_top select_top_options select_long width_long">
                            <?php echo $_SESSION['import']['category_title']; ?>
                        </div>
                        <select id="category" class="width_long" onchange="changeCategory(this.value, '')">
                            <option value='0'>Выбрать категорию</option>
                            <?php
                            foreach ($category as $item) {
                                if ($item->category_id == $_SESSION['import']['category_id'])
                                    $sel = 'selected';
                                else
                                    $sel = '';
                                if ($item->level > 0)
                                    $lvl = 'style="font-style:italic;padding-left:10px;"';
                                else
                                    $lvl = '';
                                echo '<option ' . $sel . ' ' . $lvl . ' value=' . $item->category_id . '>' . $item->category_name . '</option>';
                            }
                            ?>
                        </select>
                    </div>
                </td>
                <td class="txt1" align="center">Настройки обновления</td>
            </tr>
            <tr>
                <td colspan="2" valign="top">
                    <div id="win2">
                        <div class="win_lt round"></div>
                        <div class="win_rt round"></div>
                        <div class="win_lb round"></div>
                        <div class="win_rb round"></div>

                        <div id="scroll2">
                            <div id="bar2"></div>
                        </div>

                        <div class="data">
                            <table id="doclisttable2" cellpadding="0" cellspacing="0" style="width:560px;table-layout:fixed;">
                                <thead>
                                    <tr>
                                        <td>Наименование</td>
                                        <td width="70">Артикул</td>
                                        <td width="30">Цена</td>
                                        <td width="30" align="center">Фото</td>
                                        <td width="30" align="center">Крат.</td>
                                        <td width="20" align="center">Полн.</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    $mas = null;
                                    $mas = getProductList();
                                    $str = '';
                                    if ($mas)
                                        foreach ($mas as $item) {
                                            if ($item->image)
                                                $photo  = 'да';
                                            else
                                                $photo  = 'нет';
                                            if ($item->product_s_desc)
                                                $s_desc = 'да';
                                            else
                                                $s_desc = 'нет';
                                            if ($item->product_desc)
                                                $desc   = 'да';
                                            else
                                                $desc   = 'нет';

                                            $str .= '<tr id="parseProductName' . $item->product_id . '" class="parseProductName" onclick="parseProductName(' . $item->product_id . ')">
                                                        <td>' . $item->product_name . '</td>
                                                        <td>' . $item->product_sku . '</td>
                                                        <td align="right">' . $item->product_price . '</td>
                                                        <td align="center">' . $photo . '</td>
                                                        <td align="center">' . $s_desc . '</td>
                                                        <td align="center">' . $desc . '</td>
                                                     <tr>';

                                            $num++;
                                            if ($num > 1) {
                                                $num = 0;
                                            }
                                        }

                                    echo $str;
                                    ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td valign="top">
                                <div class="txt2">Модель</div>
                                <input onchange="setModel(this.value)" type="text" id="model" class="model_input"/>
                            </td>
                            <td id="parse_model">&nbsp;</td>
                        </tr>
                    </table>
                    <div class="txt2" style="text-align:left;margin:10px 0;">Найденные модели на Яндексе</div>
                    <div id="search">&nbsp;</div>
                    <input type="button" class="start_btn" onclick="setDataForProduct()" value="обновить"/>
                </td>
            </tr>
        </table>
    </div>

    <div id="page_conteyner_3" class="page_conteyner">
        <fieldset class="adminform">
            <legend>Настройки архивирования</legend>
            <table cellpadding="10" cellspacing="10">
                <tr>
                    <td>Дата создания</td>
                    <td>
                        <select id="datetype">
                            <option value="cdate">дата создания</option>
                            <option value="mdate">дата изменения</option>
                        </select>	
                    </td>
                    <td><input type="text" id="datecreate_import"/></td>
                </tr>
                <tr>
                    <td><input type="text" onclick="setClear()" value="Очистить данные"/></td>
                </tr>
            </table>
        </fieldset>
        <fieldset class="adminform">
            <legend>Выгрузка прайса</legend>
            <input title="Путь , куда будет скопирован созданый прайс" type="text" value="images/stories" id="pricepath"/>
            <input type="button" onclick="createPrice()" value="Выгрузить"/>
        </fieldset>
        <fieldset class="adminform">
            <legend>Очистка картинок</legend>
            <input type="button" id="clearImages-btn" onclick="clearImages()" value="Очистить"/>
            <div id="clearImages-status">

            </div>
        </fieldset>
        <fieldset class="adminform">
            <legend>Загрузка продуктов с http://enter.kg. внимание, перед загрузкой база будет очищена</legend>
            <a target="blank" href="index.php?option=com_import&tmpl=ajax&ajax=loadProducts">Начать загрузку</a>
        </fieldset>
    </div>
</div>

<script>
    var page = '<?php echo $_SESSION['import']['page']; ?>';
    var product_id = '<?php echo $_SESSION['import']['product_id']; ?>';
</script>
