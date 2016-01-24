/**
 * @package     Joomla.Site
 * @subpackage  Templates.protostar
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 * @since       3.2
 */

function jModalClose() {
    SqueezeBox.close();
}

jQuery(document).ready(function ($)
{
    $('*[rel=tooltip]').tooltip();

    $('div.vm-pagination ul li a').removeClass('hasTooltip');

    // Turn radios into btn-group
    $('.radio.btn-group label').addClass('btn');
    $(".btn-group label:not(.active)").click(function ()
    {
        var label = $(this);
        var input = $('#' + label.attr('for'));

        if (!input.prop('checked')) {
            label.closest('.btn-group').find("label").removeClass('active btn-success btn-danger btn-primary');
            if (input.val() == '') {
                label.addClass('active btn-primary');
            } else if (input.val() == 0) {
                label.addClass('active btn-danger');
            } else {
                label.addClass('active btn-success');
            }
            input.prop('checked', true);
        }
    });

    $(".btn-group input[checked=checked]").each(function ()
    {
        if ($(this).val() == '') {
            $("label[for=" + $(this).attr('id') + "]").addClass('active btn-primary');
        } else if ($(this).val() == 0) {
            $("label[for=" + $(this).attr('id') + "]").addClass('active btn-danger');
        } else {
            $("label[for=" + $(this).attr('id') + "]").addClass('active btn-success');
        }
    });

    $('body').scrollBtn(options = $.extend({"posH": "right", "btnText2": "Вниз", "btnText": "Вверх"}));

    $('input[name=delcoocie]').click(function () {
        jQuery.get('index.php?option=com_virtuemart&nosef=1&view=cart&task=deleteAll&format=json', {}, function () {
            jQuery('div.vm_cart_products div.vmcontainer').html('');
            jQuery('div.total_products').html('Корзина пуста');
        });
    });

    $('body').css('background', '#000000 url("/templates/jblank/images/body-bg.png") repeat-x left top');

    SqueezeBox.initialize({});
    SqueezeBox.assign($('a.modal').get(), {
        parse: 'rel'
    });

    $("form#simpleForm2_103").simpleform({
        url: "/modules/mod_simpleform2/index.php",
        loaderImg: "/modules/mod_simpleform2/images/loading.gif"
    });

    $('#VMmenu05_75748 li.VmClose ul').hide();
    $('#VMmenu05_75748 li .VmArrowdown').click(function () {
        if ($(this).parent().next('ul').is(':hidden')) {
            $('#VMmenu05_75748 ul:visible').delay(500).slideUp(500, 'linear')
                    .parents('li').addClass('VmClose').removeClass('VmOpen');
            $(this).parent().next('ul').slideDown(500, 'linear');
            $(this).parents('li').addClass('VmOpen').removeClass('VmClose');
        }
    });

});

(function ($) {
    window.addEvent('domready', function () {
        this.Slider105 = new DJImageSliderModule({id: '105', slider_type: 1, slide_size: 211, visible_slides: 2, show_buttons: 0, show_arrows: 1, preload: 800}, {auto: 1, transition: Fx.Transitions.Expo.easeInOut, duration: 1000, delay: 4000});
    });
    window.addEvent('domready', function () {
        this.Slider109 = new DJImageSliderModule({id: '109', slider_type: 1, slide_size: 211, visible_slides: 2, show_buttons: 0, show_arrows: 1, preload: 800}, {auto: 1, transition: Fx.Transitions.Expo.easeInOut, duration: 1000, delay: 4000});
    });
    window.addEvent('domready', function () {
        this.Slider101 = new DJImageSliderModule({id: '101', slider_type: 2, slide_size: 700, visible_slides: 1, show_buttons: 0, show_arrows: 1, preload: 800}, {auto: 1, transition: Fx.Transitions.linear, duration: 600, delay: 3600});
    });
})(document.id);