jQuery("document").ready(function(a){a("div.advanced_search").hide();a("#keyword").focus(function(){"\u0427\u0442\u043e \u0438\u0449\u0435\u043c?"===a(this).val()&&a(this).val("")}).blur(function(){""===a(this).val()&&a(this).val("\u0427\u0442\u043e \u0438\u0449\u0435\u043c?")});a("input.vm_search").click(function(){"\u0427\u0442\u043e \u0438\u0449\u0435\u043c?"===a("#keyword").val()&&a("#keyword").val("")});a("#advanced_search_btn").click(function(){"none"===a("div.advanced_search").css("display")?a("div.advanced_search").show():a("div.advanced_search").hide();return!1})});