/**
 * @package     Joomla.Site
 * @subpackage  Templates.protostar
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 * @since       3.2
 */

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
});