jQuery('document').ready(function ($) {
    var what = 'Что ищем?';
    $('div.advanced_search').hide();

    $('#keyword').focus(function () {
        if ($(this).val() === what) {
            $(this).val('');
        }
    }).blur(function () {
        if ($(this).val() === '') {
            $(this).val(what);
        }
    });

    $('input.vm_search').click(function () {
        if ($('#keyword').val() === what) {
            $('#keyword').val('');
        }
    });

    $('#advanced_search_btn').click(function () {
        if ($('div.advanced_search').css('display') === 'none') {
            $('div.advanced_search').show();
        } else {
            $('div.advanced_search').hide();
        }
        return false;
    });
});


