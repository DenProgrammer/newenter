

/*******************************************global vars****************************************/

jQuery.noConflict();
var sdvig = 320;
var sdvig2 = 360;
var scroll_action = false;
var scroll_action2 = false;
var show_preloader = false;
var timerUpdate = 0;
var product_id = 0;
var yandex_product_id = 0;
var search_page = 1;
var action_document = '';
var updateComplite = 0;

/******************************************functions*************************************************/

function getDataFromXML(data, tag)
{
    var st_tag = '<' + tag + '>';
    var ed_tag = '</' + tag + '>';
    var st = data.indexOf(st_tag) + st_tag.length;
    var ed = data.indexOf(ed_tag);

    return data.substring(st, ed);
}
//выбор пункта меню вверху
function selectMenu(num)
{
    jQuery("#top_btns td div").removeClass('active');
    jQuery("#top_btns_" + num).addClass('active');

    jQuery(".page_conteyner").css('display', 'none');
    jQuery("#page_conteyner_" + num).css('display', 'block');


    var url = mainurl + '&ajax=set_page';
    jQuery.get(url, {id: num});
}
//выбор документа
function selectDocument(num)
{
    showPreloader();
    jQuery(".documents").removeClass('documents_active');
    jQuery("#doc" + num).addClass('documents_active');

    var url = mainurl + '&ajax=set_active_document';
    jQuery.get(url, {id: num}, function() {
        hidePreloader();
    });
    action_document = num;

    jQuery("#options_update").animate({height: "show"}, 500);
    jQuery(".progres_panel").css("display", "none");
}
//прокрутка списка документов
function scrollDocumentList(a)
{
    var height = jQuery("#win div.data").css("height");
    height = height.replace('px', '');

    var height_min = 170;

    var cdvig_min = Math.round(a * height_min / height);

    jQuery("#bar").animate({"margin-top": cdvig_min}, 500);
    jQuery("#win div.data").animate({"margin-top": -a}, 500);
}
function closeWinNadbavka()
{
    jQuery("#options_addprice").animate({opacity: "hide"}, 500);
}
function showWinNadbavka()
{
    jQuery("#options_addprice").animate({opacity: "show"}, 500);
}

/*************************************preloader***********************************/

function showPreloader()
{
    jQuery("#import_prldr").css("display", "block");
    show_preloader = true;
}
function hidePreloader()
{
    jQuery("#import_prldr").css("display", "none");
    show_preloader = false;
}
/****************************************scrolling********************************/

jQuery(document).ready(function() {

    jQuery("#bar").mousemove(function(e) {

        var checkdiv = jQuery("#win").css("height");
        var checktable = jQuery("#doclisttable").css("height");

        checkdiv = parseInt(checkdiv.replace('px', ''));
        checktable = parseInt(checktable.replace('px', ''));

        if ((scroll_action) && (e.pageY >= sdvig) && (e.pageY <= (sdvig + 170)) && (checktable > checkdiv))
        {
            jQuery("#bar").css("margin-top", e.pageY - sdvig);

            var height = jQuery("#win div.data").css("height");
            height = height.replace('px', '');
            var margin = Math.round((height / 170 - 1) * (e.pageY - sdvig));
            jQuery("#win div.data").css("margin-top", -margin);
        }
    }).mouseout(function() {
        scroll_action = false;
    }).mouseover(function() {
        scroll_action = true;
    });

    jQuery("#bar2").mousemove(function(e) {

        var checkdiv = jQuery("#win2").css("height");
        var checktable = jQuery("#doclisttable2").css("height");

        checkdiv = parseInt(checkdiv.replace('px', ''));
        checktable = parseInt(checktable.replace('px', ''));

        if ((scroll_action2) && (e.pageY >= sdvig2) && (e.pageY <= (sdvig2 + 170)) && (checktable > checkdiv))
        {
            jQuery("#bar2").css("margin-top", e.pageY - sdvig2);

            var height = jQuery("#win2 div.data").css("height");
            height = height.replace('px', '');
            var margin = Math.round((height / 170 - 1) * (e.pageY - sdvig2));
            jQuery("#win2 div.data").css("margin-top", -margin);
        }
    }).mouseout(function() {
        scroll_action2 = false;
    }).mouseover(function() {
        scroll_action2 = true;
    });

    var url = mainurl + '&ajax=get_active_document';
    jQuery.get(url, {}, function(data) {
        var id = getDataFromXML(data, 'id');
        var count = getDataFromXML(data, 'count');
        if (id > 0)
        {
            var a = (count - 1) * 100;
            selectDocument(id);
            scrollDocumentList(a);
        }
    });

    selectMenu(page);
    parseProductName(product_id);

    jQuery("#datecreate_import").datepicker();

}).mousemove(function(e) {
    jQuery("#import_prldr").css("left", e.clientX).css("top", e.clientY)
}).mouseout(function(e) {
    jQuery("#import_prldr").css("display", "none");
}).mouseover(function(e) {
    if (show_preloader)
        jQuery("#import_prldr").css("display", "block");
});


/***************************************options******************************************/
//изменение значения селекта
function changeSelect(id)
{
    var value = jQuery("#" + id).val();
    var html = jQuery("#" + id + " [value=" + value + "]").html();
    jQuery("#" + id + "_top").html(html);

    var url = mainurl + '&ajax=set_select';
    jQuery.get(url, {type: id, value: value});
}
//изменение значения прайса
function changePrice()
{
    var value = jQuery("#price").val();
    var html = jQuery("#price [value=" + value + "]").html();
    jQuery("#price_top").html(html);

    var markup = markups[value];
    var markupStr = (markup === 2) ? 'Фикс. %' : (markup === 1) ? 'Да' : 'Нет';

    if (markup === 2) {
        jQuery('#show_fix_markup').css('display', 'table-row');
    } else {
        jQuery('#show_fix_markup').css('display', 'none');
    }

    jQuery('#markup_top').html(markupStr);
    jQuery('#markup').val(markup);

    var currency = currencys[value];
    var currencyStr = (currency === 'USD') ? 'Доллар США' : 'Сом';

    jQuery('#currency_top').html(currencyStr);
    jQuery('#currency').val(currency);

    var url = mainurl + '&ajax=set_select';
    jQuery.get(url, {type: 'price', value: value});
}
//изменение значения селекта
function changeNadbavka(id)
{
    var value = jQuery("#type_nadbavka_" + id).val();
    var sum = jQuery("#price_" + id).val();
    var sum_tax = jQuery("#nadbavka_" + id).val();
    var html = jQuery("#type_nadbavka_" + id + " [value=" + value + "]").html();
    jQuery("#type_nadbavka_" + id + "_top").html(html);

    var url = mainurl + '&ajax=setNadbavka';
    jQuery.get(url, {id: id, value: value, sum: sum, sum_tax: sum_tax});
}
//изменение значения селекта
function changeAkcent(id)
{
    var value = jQuery("#" + id).val();
    var html = jQuery("#" + id + " [value=" + value + "]").html();
    jQuery("#" + id + "_top").html(html);

    var akcent = jQuery("#akcent").val();
    var akcent_time = jQuery("#akcent_time").val();

    var url = mainurl + '&ajax=setAkcent';
    jQuery.get(url, {akcent: akcent, akcent_time: akcent_time});
}
//изменение значения селекта
function changeMarkup()
{
    var value = jQuery("#markup").val();
    var html = jQuery("#markup [value=" + value + "]").html();
    jQuery("#markup_top").html(html);

    var markup = jQuery("#markup").val();
    var price = jQuery("#price").val();

    if (markup === '2') {
        jQuery('#show_fix_markup').css('display', 'table-row');
    } else {
        jQuery('#show_fix_markup').css('display', 'none');
    }

    markups[price] = markup;

    var url = mainurl + '&ajax=setMarkup';
    jQuery.get(url, {markup: markup, price: price});
}
//изменение значения селекта
function changeCategory(value, filtr)
{
    var html = jQuery("#category [value=" + value + "]").html();
    jQuery("#category_top").html(html);

    var url = mainurl + '&ajax=setCategory';
    jQuery.get(url, {id: value, title: html, filtr: filtr}, function(data) {
        jQuery("#doclisttable2 tbody").html(data);
    });
}
//изменение значения валюты
function changeCurrency()
{
    var currency = jQuery("#currency").val();
    var price = jQuery("#price").val();
    var html = jQuery("#currency [value=" + currency + "]").html();
    jQuery("#currency_top").html(html);

    currencys[price] = currency;

    var url = mainurl + '&ajax=setCurrency';
    jQuery.get(url, {currency: currency, price: price});
}
//добавить еще одну строку для надбавок
function addNadbavka()
{
    showPreloader();
    var url = mainurl + '&ajax=get_nadbavka';
    jQuery.get(url, {}, function(data) {
        var content = getDataFromXML(data, 'content');

        jQuery("#addprice_table tbody").append(content);
        hidePreloader();
    });
}

/***************************************update******************************************/

/**
 * start import products
 */
function startUpdate()
{
    var markup_fix_value = jQuery('#markup_fix_value').val();

    var url = mainurl + '&ajax=startUpdate&markup_fix_value=' + markup_fix_value;
    jQuery('#import_loading').show();

    jQuery.get(url, {}, function(data) {
        jQuery('#import_loading').hide();

        data = jQuery.parseJSON(data);
        var message = "Обновление завершено.\n";
        message += 'Обновлено ' + data.count + " товаров.\n";
        message += 'Из них новых товаров ' + data.new + ".\n";
        message += 'Удалить файл?';

        if (confirm(message))
        {
            var url = mainurl + '&ajax=delete_price';
            jQuery.get(url, {}, function(data) {
                var content = getDataFromXML(data, 'content');
                jQuery("div.data table").html(content);
                document.location = 'index.php?option=com_import';
            });
        }
        else
        {
            document.location = 'index.php?option=com_import';
        }
    });
}
//обновление содержимого панели информации
var temp_update_status = 0;
var last_product_time = 0;

/**************************************парсинг информации о продукте**************************************/

function parseProductName(id)
{
    showPreloader();

    jQuery("tr.parseProductName").css("background", "#ffffff");
    jQuery("#parseProductName" + id).css("background", "#AEB0C8");

    jQuery("#search").html("");

    product_id = id;
    var url = mainurl + '&ajax=parseProductName';
    jQuery.get(url, {id: id}, function(data) {
        var model = getDataFromXML(data, 'model');
        var content = getDataFromXML(data, 'content');

        jQuery("#model").attr("value", model);
        jQuery("#parse_model").html(content);

        if (model)
            searchText();
        else
            hidePreloader();
    });
}
function setModelForProduct(id, value)
{
    showPreloader();
    var url = mainurl + '&ajax=setModelForProduct';
    jQuery.get(url, {id: id, value: value}, function(data) {
        var model = getDataFromXML(data, 'model');
        jQuery("#model").attr("value", model);
        searchText();
    });
}
function setModel(value)
{
    showPreloader();
    var url = mainurl + '&ajax=setModelForProduct';
    jQuery.get(url, {id: product_id, value: value}, function(data) {
        var model = getDataFromXML(data, 'model');
        jQuery("#model").attr("value", model);

        searchText();
    });
}

/**************************************поиск***********************************/


function searchText()
{
    showPreloader();
    var url = mainurl + '&ajax=search&page=' + search_page;
    var id = '';
    var name = '';
    var img = '';
    var v = 1;

    text = jQuery("#model").attr("value");
    var str = '<table>';
    jQuery.get(url, {text: text}, function(data) {
        jQuery("#parse_panel").html(data);

        jQuery("#parse_panel div.b-pager__pages a").each(function() {
            v = jQuery(this).html();
            jQuery(this).attr("href", "javascript:search_page=" + v + ";searchText()");
        });

        var pagination = jQuery("#parse_panel div.b-pager__pages").html();

        jQuery("#parse_panel div.b-offers").each(function() {
            id = jQuery(this).attr("id");
            name = jQuery(this).find("a.b-offers__name").html();
            img = jQuery(this).find("img.b-offers__img").attr("src");

            str += '<tr onclick="searchById(\'' + id + '\')"><td valign="top"><img src="' + img + '"/></td><td width="10">&nbsp;</td><td valign="top">' + name + '</td></tr>';
        });
        if (pagination)
            str += '<td colspan="3">' + pagination + '</td></table>';
        jQuery("#search").html(str);

        hidePreloader();
    });
}

function searchById(id)
{
    showPreloader();
    var url = mainurl + '&ajax=searchById';
    var bigimg = '';
    var img = '';
    var text = '';
    var s_desc = '';
    var desc = '';

    yandex_product_id = id;

    var str = '';
    jQuery.get(url, {id: id}, function(data) {
        jQuery("#parse_panel").html(data);

        bigimg = jQuery(".b-model-pictures__big a").attr("href");
        if (bigimg == 'undefined')
            bigimg = jQuery(".b-model-pictures__big img").attr("src");
        img = jQuery(".b-model-pictures__big a img[border=0]").attr("src");
        if (img == undefined)
            img = jQuery(".b-model-pictures__big img").attr("src");
        s_desc = jQuery(".b-vlist").html();
        desc = jQuery(".b-properties").html();
        text = '<img class="bimg" src="' + img + '"/><hr><div class="s_desc"><ul>' + s_desc + '</ul></div><hr><div class="desc"><table>' + desc + '</table></div><div style="display:none;"><input type="text" class="img" value="' + img + '"/><input type="text" class="bimg" value="' + bigimg + '"/></div>';

        jQuery("#search").html(text);

        hidePreloader();
    });
}

function setDataForProduct()
{
    var bigimg = jQuery("#search input.bimg").attr("value");
    var img = jQuery("#search input.img").attr("value");
    var s_desc = jQuery("#search div.s_desc").html();
    var desc = jQuery("#search div.desc").html();
    var model = jQuery("#model").attr("value");

    var url = mainurl + '&ajax=setDataForProduct';
    jQuery.post(url, {product_id: product_id, yandex_product_id: yandex_product_id, bigimg: bigimg, img: img, s_desc: s_desc, desc: desc, model: model}, function(data) {
        alert('Информация о товаре обновлена');
    });
}

/*****************************************************sklads, add, edit, delete***************************************************/

function getWinAddNewSklad()
{
    var url = mainurl + '&ajax=getWinAddNewSklad';
    jQuery.post(url, {}, function(data) {
        jQuery("#sklads").html(data).animate({opacity: "show"}, 500);
    });
}

function hideWinAddNewSklad()
{
    jQuery("#sklads").animate({opacity: "hide"}, 500, function() {
        jQuery("#sklads").html("")
    });
}

function getWinListSklad()
{
    var url = mainurl + '&ajax=getWinListSklad';
    jQuery.post(url, {}, function(data) {
        jQuery("#sklads").html(data).animate({opacity: "show"}, 500);
    });
}

function saveEditSklad(id)
{
    var priceName = jQuery("#priceName").attr("value");
    var clearLine = jQuery("#clearLine").attr("value");
    var categoryNamePosition = jQuery("#categoryNamePosition").attr("value");
    var productNamePosition = jQuery("#productNamePosition").attr("value");
    var productPricePosition = jQuery("#productPricePosition").attr("value");
    var productDescPosition = jQuery("#productDescPosition").attr("value");

    var url = mainurl + '&ajax=saveEditSklad';
    jQuery.post(url, {id: id, clearLine: clearLine, categoryNamePosition: categoryNamePosition,
        productNamePosition: productNamePosition, productPricePosition: productPricePosition,
        productDescPosition: productDescPosition, priceName: priceName}, function(data) {
        var msg = getDataFromXML(data, 'message');
        var st = getDataFromXML(data, 'status');
        if (st === '1')
        {
            if (confirm(msg))
            {
                getWinListSklad();
            }
            else
            {
                hideWinAddNewSklad();
            }
        }
        else
        {
            alert(msg);
        }
    });
}
function addNewSklad()
{
    var priceName = jQuery("#priceName").attr("value");
    var clearLine = jQuery("#clearLine").attr("value");
    var categoryNamePosition = jQuery("#categoryNamePosition").attr("value");
    var productNamePosition = jQuery("#productNamePosition").attr("value");
    var productPricePosition = jQuery("#productPricePosition").attr("value");
    var productDescPosition = jQuery("#productDescPosition").attr("value");

    var url = mainurl + '&ajax=addNewSklad';
    jQuery.post(url, {priceName: priceName, clearLine: clearLine, categoryNamePosition: categoryNamePosition,
        productNamePosition: productNamePosition, productPricePosition: productPricePosition, productDescPosition: productDescPosition}, function(data) {
        var msg = getDataFromXML(data, 'message');
        var st = getDataFromXML(data, 'status');
        if (st === '1')
        {
            if (confirm(msg))
            {
                getWinListSklad();
            }
            else
            {
                hideWinAddNewSklad();
            }
        }
        else
        {
            alert(msg);
        }
    });
}
function editPrice(id)
{
    var url = mainurl + '&ajax=editPrice';
    jQuery.get(url, {id: id}, function(data) {
        jQuery("#sklads").html(data).animate({opacity: "show"}, 500);
    });
}
function deletePrice(id)
{
    if (confirm('Тип прайса будет удален, вы уверены?'))
    {
        var url = mainurl + '&ajax=deletePrice';
        jQuery.get(url, {id: id}, function(data) {
            var msg = getDataFromXML(data, 'message');

            alert(msg);
            getWinListSklad();
        });
    }
}



/**************************************************архивирование и очистка данных*************************************************/

function setClear()
{
    var clearDateType = jQuery("#datetype").val();
    var clearDateValue = jQuery("#datecreate_import").attr("value");

    var url = mainurl + '&ajax=setClear';
    jQuery.get(url, {clearDateType: clearDateType, clearDateValue: clearDateValue}, function(data) {
        alert(data);
    });
}
function createPrice()
{
    var pricepath = jQuery("#pricepath").attr("value");

    var url = mainurl + '&ajax=createPrice';
    jQuery.get(url, {pricepath: pricepath}, function(data) {
        alert(data);
    });
}

/*********************************clear images*********************************/
var clearImagesStatus = false;
function clearData() {
    jQuery('#clearImages-status').html('');
    jQuery('#clearImages-status').append('Инициализация<br>');
    jQuery.get('index.php?option=com_import&view=clearimages&tmpl=ajax&action=clear', {}, function() {
        jQuery('#clearImages-status').append('Выполнено!<br>');

        prepareData();
    });
}
function prepareData() {
    jQuery('#clearImages-status').append('Сбор данных по изображениям<br>');
    jQuery.get('index.php?option=com_import&view=clearimages&tmpl=ajax&action=prepare', {}, function(data) {
        var data = jQuery.parseJSON(data);
        jQuery('#clearImages-status').append('Выполнено, изображений найдено ' + data.count + '!<br>');

        detectImages();
    });
}
function detectImages() {
    jQuery('#clearImages-status').append('Определение ненужных изображений<br>');
    jQuery.get('index.php?option=com_import&view=clearimages&tmpl=ajax&action=detect', {}, function(data) {
        var data = jQuery.parseJSON(data);
        jQuery('#clearImages-status').append('Выполнено, будет удалено ' + data.count + ' изображений!<br>');

        moveImages();
    });
}
function moveImages() {
    jQuery('#clearImages-status').append('Перемещение изображений<br>');
    jQuery('#clearImages-status').append('Перемещено <span id="moveImages">0</span><br>');

    moveImagesProcees();
}
function moveImagesProcees() {
    jQuery.get('index.php?option=com_import&view=clearimages&tmpl=ajax&action=move', {}, function(data) {
        var data = jQuery.parseJSON(data);
        var move = parseInt(jQuery('#moveImages').html());

        move = move + data.count;
        jQuery('#moveImages').html(move);
        if (data.count > 0) {
            moveImagesProcees();
        } else {
            jQuery('#clearImages-status').append('Выполнено!<br>');
            finishOperation();
        }
    });
}
function finishOperation() {
    jQuery('#clearImages-status').append('Работа завершена, перемещенные изображения находятся в каталоге<br>');
    jQuery('#clearImages-status').append('components/com_virtuemart/shop_image/product_bkp<br>');
    clearImagesStatus = false;
}
function clearImages() {
    if (clearImagesStatus) {
        return;
    }

    clearImagesStatus = true;

    clearData();
}

		