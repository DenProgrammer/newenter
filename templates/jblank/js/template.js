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
    var targets = $( '*[rel=tooltip]' ),
        target  = false,
        tooltip = false,
        title   = false;
  
    targets.bind( 'mouseenter', function()
    {
        target  = $( this );
        tip     = target.attr( 'title' );
        tooltip = $( '<div id="tooltip"></div>' );
  
        if( !tip || tip === '' ){
            return false;
        }
  
        target.removeAttr( 'title' );
        tooltip.css( 'opacity', 0 )
               .html( tip )
               .appendTo( 'body' );
  
        var init_tooltip = function()
        {
            if( $( window ).width() < tooltip.outerWidth() * 1.5 )
                tooltip.css( 'max-width', $( window ).width() / 2 );
            else
                tooltip.css( 'max-width', 340 );
  
            var pos_left = target.offset().left + ( target.outerWidth() / 2 ) - ( tooltip.outerWidth() / 2 ),
                pos_top  = target.offset().top - tooltip.outerHeight() - 20;
  
            if( pos_left < 0 )
            {
                pos_left = target.offset().left + target.outerWidth() / 2 - 20;
                tooltip.addClass( 'left' );
            }
            else
                tooltip.removeClass( 'left' );
  
            if( pos_left + tooltip.outerWidth() > $( window ).width() )
            {
                pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
                tooltip.addClass( 'right' );
            }
            else
                tooltip.removeClass( 'right' );
  
            if( pos_top < 0 )
            {
                var pos_top  = target.offset().top + target.outerHeight();
                tooltip.addClass( 'top' );
            }
            else
                tooltip.removeClass( 'top' );
  
            tooltip.css( { left: pos_left, top: pos_top } )
                   .animate( { top: '+=10', opacity: 1 }, 50 );
        };
  
        init_tooltip();
        $( window ).resize( init_tooltip );
  
        var remove_tooltip = function()
        {
            tooltip.animate( { top: '-=10', opacity: 0 }, 50, function()
            {
                $( this ).remove();
            });
  
            target.attr( 'title', tip );
        };
  
        target.bind( 'mouseleave', remove_tooltip );
        tooltip.bind( 'click', remove_tooltip );
    });

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
        $.get('index.php?option=com_virtuemart&nosef=1&view=cart&task=deleteAll&format=json', {}, function () {
            $('div.vm_cart_products div.vmcontainer').html('');
            $('div.total_products').html('Корзина пуста');
        });
    });

    $('body').css('background', '#000000 url("/templates/jblank/images/body-bg.png") repeat-x left top');

    if (typeof SqueezeBox !== 'undefined') {
        SqueezeBox.initialize({});
        SqueezeBox.assign($('a.modal').get(), {
            parse: 'rel'
        });
    }

    $('#VMmenu05_75748 li.VmClose ul').hide();
    $('#VMmenu05_75748 li .VmArrowdown').click(function () {
        if ($(this).parent().next('ul').is(':hidden')) {
            $('#VMmenu05_75748 ul:visible').delay(500).slideUp(500, 'linear')
                    .parents('li').addClass('VmClose').removeClass('VmOpen');
            $(this).parent().next('ul').slideDown(500, 'linear');
            $(this).parents('li').addClass('VmOpen').removeClass('VmClose');
        }
    });

    $('body').on('click', 'form#simpleForm2_103 input.button-gloss', function () {
        $("form#simpleForm2_103").simpleform({
            url: "/modules/mod_simpleform2/index.php",
            loaderImg: "/modules/mod_simpleform2/images/loading.gif",
            checkCallBack: function (id) {
                var phone = $('#' + id).find('input#sf2_103_vash_nomer').val();

                var re = /^[0-9]*$/;
                var valid = re.test(phone);

                if (!valid) {
                    alert('Введите ваш телефонный номер');

                    return false;
                }
                return true;
            }
        });
    });
});
