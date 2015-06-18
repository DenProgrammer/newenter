<?php
//echo '<pre>';
//pr($this->data);
//exit;
$items          = $this->data->order['items'];
$details        = $this->data->order['details']['BT'];
?><html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
    <head>
        <meta http-equiv=Content-Type content="text/html; charset=utf8"/>
        <meta name=ProgId content=Excel.Sheet/>
        <meta name=Generator content="Microsoft Excel 11"/>
        <title>Счет фактура</title>
        <script type="text/javascript" src="http://enter.kg/media/system/js/jquery.js"></script>
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.all.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.base.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.core.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.datepicker.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.theme.css" type="text/css" />
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.core.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.datepicker-ru.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.datepicker.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.widget.js"></script>
        <script type="text/javascript">
            $('document').ready(function() {

                $("#vendorselect").change(function() {
                    var id = $(this).val();
                    $("div.vendor").css("display", "none");
                    $("div.vendor" + id).css("display", "block");
                });
                $("#vendorselect").change();
                $("input.orderdatetext").datepicker();
            });
            var editregim = false;
            var nrt = '<?php echo $details->nrt; ?>';
            function edit()
            {
                if (editregim)
                {
                    $(".editelement").css("display", "none");
                    $(".changeelement").css("display", "block");
                    var clienttext = $("#clienttext").val();
                    clienttext = clienttext.replace(new RegExp("\n", 'g'), '<br>');
                    $("#client").html(clienttext);
                    var vendor_info_id = $('#vendorselect').val();
                    var shopper_info = $("#client").html();
                    $.post('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=saveOrder', {
                        order_id: <?php echo $details->virtuemart_order_id; ?>, vendor_info_id: vendor_info_id,
                        shopper_info: shopper_info, nrt: nrt
                    }, function() {
                    });

                    var items = new Object;
                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;
                        var order_item_id = $(this).attr('rel');
                        var itemname = $("#" + id + " td input.itemnametext").val().replace(/["']+/g, '').replace('&amp;', '*AMPERSAND*').replace('&', '*AMPERSAND*');
                        var itemquantity = $("#" + id + " td input.itemquantitytext").val();
                        var itemprice = $("#" + id + " td input.itempricetext").val();
                        var itemsn = $("#" + id + " td input.itemsntext").val();
                        var orderdate = $("input.orderdatetext").val();
                        shopper_info = shopper_info.replace("'", '');
                        shopper_info = shopper_info.replace('"', '');
                        $("#" + id + " td div.itemname").html(itemname);
                        $("#" + id + " td div.itemquantity").html(itemquantity);
                        $("#" + id + " td div.itemprice").html(itemprice);
                        $("span.orderdate").html(orderdate);

                        items[id] = {
                            'order_item_id': order_item_id,
                            'itemname': itemname,
                            'itemsn': itemsn,
                            'itemquantity': itemquantity,
                            'itemprice': itemprice
                        };

                        $.post('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=saveItems',
                                {order_id: '<?php echo $details->virtuemart_order_id; ?>', items: items, nrt: nrt});
                    });
                    editregim = false;
                }
                else
                {
                    $(".editelement").css("display", "block");
                    $(".changeelement").css("display", "none");
                    var client = $("#client").html();
                    client = client.replace(new RegExp("<br>", 'g'), "\n");
                    $("#clienttext").val(client);
                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;
                        $("#" + id + " td input.itemnametext").val($("#" + id + " td div.itemname").html());
                        $("#" + id + " td input.itemquantitytext").val($("#" + id + " td div.itemquantity").html());
                        $("#" + id + " td input.itempricetext").val($("#" + id + " td div.itemprice").html());
                        $("input.orderdatetext").val($("span.orderdate").html());
                    });
                    editregim = true;
                }
            }
            function resumm(id)
            {
                var count = $("#itemquantitytext" + id).attr("value");
                var price = $("#itempricetext" + id).val();
                price = price.replace(',', '.');
                count = count - 1 + 1;
                price = price - 1 + 1;
                var itog = count * price;
                $("#itemitogo" + id).html(itog.toFixed(0));
                var total = 0;
                $("div.itemitogo").each(function(i, el) {
                    total += parseFloat($(this).html());
                });

                $("td.total").html(Math.round(total));
                $.get('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=getsumstring', {summa: total}, function(data) {
                    $(".totalstr").html(data);
                });
            }
            function changeNRT()
            {
                var oldnrt = nrt;
                var tempnrt = parseFloat($("#nrt").attr("value"));
                if (tempnrt >= 0)
                {
                    nrt = tempnrt;
                    var total = 0;
                    $("tr.itemrow").each(function(i, el) {

                        var itemprice = parseFloat($(this).find("td input.itempricetext").attr("value"));
                        var itemquantity = parseFloat($(this).find("td div.itemquantity").html());
                        var realprice = parseFloat(itemprice / (1 + oldnrt / 100));
                        var newprice = Math.round(realprice * (1 + nrt / 100));
                        var itemitogo = Math.round(newprice * itemquantity);
                        $(this).find("td input.itempricetext").attr("value", newprice);
                        $(this).find("td div.itemitogo").html(itemitogo);
                        total += itemitogo;
                    });

                    $("td.total").html(Math.round(total));
                    $.get('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=getsumstring', {summa: total}, function(data) {
                        $(".totalstr").html(data);
                    });
                }
            }
            function getExcelLink()
            {
                var url = 'index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&id=<?php echo $details->virtuemart_order_id; ?>&type=schetfactura&action=showExcelDocument';
                document.location = url;
            }
        </script>
        <style>
            table
            {mso-displayed-decimal-separator:"\,";
             mso-displayed-thousand-separator:" ";}
            @page
            {margin:.75in .7in .75in .7in;
             mso-header-margin:.3in;
             mso-footer-margin:.3in;}
            tr
            {mso-height-source:auto;}
            col
            {mso-width-source:auto;}
            br
            {mso-data-placement:same-cell;}
            .style0
            {mso-number-format:General;
             text-align:general;
             vertical-align:bottom;
             mso-rotate:0;
             mso-background-source:auto;
             mso-pattern:auto;
             color:black;
             font-size:9.0pt;
             font-weight:400;
             font-style:normal;
             text-decoration:none;
             font-family:Calibri, sans-serif;
             mso-font-charset:204;
             border:none;
             mso-protection:locked visible;
             mso-style-id:0;}
            td
            {mso-style-parent:style0;
             padding-top:1px;
             padding-right:1px;
             padding-left:1px;
             mso-ignore:padding;
             color:black;
             font-size:9.0pt;
             font-weight:400;
             font-style:normal;
             text-decoration:none;
             font-family:Calibri, sans-serif;
             mso-font-charset:204;
             mso-number-format:General;
             text-align:general;
             vertical-align:bottom;
             border:none;
             mso-background-source:auto;
             mso-pattern:auto;
             mso-protection:locked visible;
             mso-rotate:0;}
            .xl65
            {mso-style-parent:style0;
             text-align:left;}
            .xl66
            {mso-style-parent:style0;
             background:silver;
             mso-pattern:auto none;}
            .xl67
            {mso-style-parent:style0;
             vertical-align:top;
             border:.5pt solid windowtext;}
            .xl68
            {mso-style-parent:style0;
             border:.5pt solid windowtext;}
            .xl69
            {mso-style-parent:style0;
             font-weight:700;}
            .xl70
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border:.5pt solid windowtext;}
            .xl71
            {mso-style-parent:style0;
             text-align:center;
             border-top:.5pt solid windowtext;
             border-right:none;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;}
            .xl72
            {mso-style-parent:style0;
             text-align:center;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:none;}
            .xl73
            {mso-style-parent:style0;
             text-align:left;
             border-top:.5pt solid windowtext;
             border-right:none;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;}
            .xl74
            {mso-style-parent:style0;
             text-align:left;
             border-top:.5pt solid windowtext;
             border-right:none;
             border-bottom:.5pt solid windowtext;
             border-left:none;}
            .xl75
            {mso-style-parent:style0;
             text-align:left;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:none;}
            .xl76
            {mso-style-parent:style0;
             font-weight:700;
             border-top:1.0pt solid windowtext;
             border-right:none;
             border-bottom:none;
             border-left:none;
             white-space:normal;}
            .xl77
            {mso-style-parent:style0;
             font-weight:700;
             white-space:normal;}
            .xl78
            {mso-style-parent:style0;
             mso-number-format:000000;
             text-align:left;}
            .xl79
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:none;
             border-left:.5pt solid windowtext;}
            .xl80
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:none;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;}
            .xl81
            {mso-style-parent:style0;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:none;
             border-bottom:none;
             border-left:.5pt solid windowtext;}
            .xl82
            {mso-style-parent:style0;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:none;
             border-left:none;}
            .xl83
            {mso-style-parent:style0;
             vertical-align:top;
             border-top:none;
             border-right:none;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;}
            .xl84
            {mso-style-parent:style0;
             vertical-align:top;
             border-top:none;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:none;}
            .xl85
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:none;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;}
            .xl86
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:none;}
            .xl87
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:.5pt solid windowtext;
             border-right:.5pt solid windowtext;
             border-bottom:none;
             border-left:.5pt solid windowtext;
             white-space:normal;}
            .xl88
            {mso-style-parent:style0;
             text-align:center;
             vertical-align:top;
             border-top:none;
             border-right:.5pt solid windowtext;
             border-bottom:.5pt solid windowtext;
             border-left:.5pt solid windowtext;
             white-space:normal;}
            .xl89
            {mso-style-parent:style0;
             font-size:18.0pt;
             font-weight:700;
             text-align:left;
             border-top:none;
             border-right:none;
             border-bottom:1.0pt solid windowtext;
             border-left:none;}
            .xl90
            {mso-style-parent:style0;
             font-size:18.0pt;
             font-weight:700;
             text-align:left;
             border-top:none;
             border-right:none;
             border-bottom:1.0pt solid windowtext;
             border-left:none;}
            .xl91
            {mso-style-parent:style0;
             font-size:18.0pt;
             font-weight:700;
             text-align:left;
             border-top:none;
             border-right:none;
             border-bottom:1.0pt solid windowtext;
             border-left:none;}
            .xl92
            {mso-style-parent:style0;
             font-weight:700;
             text-align:center;}
            .xl93
            {mso-style-parent:style0;
             font-weight:700;
             text-align:left;
             border-top:1.0pt solid windowtext;
             border-right:none;
             border-bottom:none;
             border-left:none;}
            .xl94
            {mso-style-parent:style0;
             font-weight:700;
             text-align:left;
             border-top:1.0pt solid windowtext;
             border-right:none;
             border-bottom:none;
             border-left:none;}
            .xl95
            {mso-style-parent:style0;
             text-align:center;}
            div.vendor{display:none}
            div.vendor:first-child{display:block}
            .editelement{
                display:none;
            }
            #ui-datepicker-div{
                width:240px;
            }
        </style>
    </head>

    <body link=blue vlink=purple>

        <table border=0 cellpadding=0 cellspacing=0 width=604 style='border-collapse: collapse;table-layout:fixed;width:454pt'>
            <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'/>
            <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'/>
            <col width=23 style='mso-width-source:userset;mso-width-alt:841;width:17pt'/>
            <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'/>
            <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'/>
            <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'/>
            <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'/>
            <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'/>
            <col width=44 span=2 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'/>
            <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'/>
            <tr height=32 style='height:24.0pt'>
                <td colspan=10 height=32 class=xl89 width=590 style='height:24.0pt;width:454pt' onclick="edit()">
                    Счет-фактура <?php echo $this->data->document_id; ?>
                </td>
                <td height=32 class=xl89 style='height:24.0pt;width:454pt'>
                    <div style="cursor:pointer;width:48px;height:48px;display:inline-block;background:url(http://enter.kg/images/M_images/excel_icon.png) no-repeat;" title="Скачать в формате EXCEL" onclick="getExcelLink()"></div>
                </td>
            </tr>
            <tr>
                <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan;vertical-align:top;'>Продавец</td> 
                <td colspan=9 width=171 valign="top" style='width:129pt'>
                    <select id="vendorselect" class="editelement">
                        <?php
                        $vendor_info_id = 0;
                        foreach ($this->data->invoicetemplates as $row) {
                            $sel = ($vendor_info_id == $row->id) ? 'selected' : '';
                            $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                            $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . html_entity_decode($row->content) . '</div>';
                            $condinfo .= '<div class="cond cond' . $row->id . '">' . html_entity_decode($row->footer) . '</div>';
                        }

                        echo $vendorlist;
                        ?>
                    </select>
                    <?php echo $vendorinfo; ?>
                </td> 
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan;vertical-align:top;'>Покупатель:</td>
                <td class=xl66>&nbsp;</td>
                <td class=xl66 colspan=3 style='mso-ignore:colspan'>
                    <div id="client" class="changeelement"><?php echo $details->shoper_info; ?></div>
                    <textarea id="clienttext" class="editelement"></textarea>
                </td>
                <td colspan=5 class=xl66 style='mso-ignore:colspan'>&nbsp;</td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'>
                    <div class="editelement">
                        НРТ <input onkeyup="changeNRT()" type="text" id="nrt" value="<?php echo $details->nrt; ?>"/>
                    </div>
                </td>
            </tr>
            <tr height=20 style='mso-height-source:userset;height:15.0pt'>
                <td height=40 class=xl79 style='border:solid 1px black;height:30.0pt'>№</td>
                <td colspan=7 class=xl81 style='border:solid 1px black;'>Наименование</td>
                <td class=xl79 style='border:solid 1px black;'>Кол-во</td>
                <td class=xl79 style='border:solid 1px black;'>Цена</td>
                <td class=xl70 style='border:solid 1px black;'>Всего</td>
            </tr>
            <?php
            $num   = 0;
            $total = 0;
            foreach ($items as $item) {
                $num++;
                $item_id    = $item->virtuemart_order_item_id;
                $itemname   = $item->order_item_name;
                $quantity   = $item->product_quantity;
                $price      = round($item->product_final_price * (1 + $details->nrt / 100), 2);
                $totalprice = $price * $quantity;

                $total += $totalprice;
                ?>
                <tr id='row<?php echo $item_id; ?>' rel='<?php echo $item_id; ?>' class='itemrow' height=20 style='height:15.0pt'>
                    <td height=20 class=xl68 align=right style='height:15.0pt;border:solid 1px black;text-align:center;' x:num><?php echo $num; ?></td>
                    <td colspan=7 class=xl71 style='border:solid 1px black;text-align:left;'>
                        <div class='itemname changeelement'><?php echo $itemname; ?></div>
                        <input size='67' id='itemnametext<?php echo $item_id; ?>' class='itemnametext editelement' type='text'/>
                    </td>
                    <td class=xl68 style='border:solid 1px black;text-align:right;'>
                        <div class='itemquantity changeelement'><?php echo $quantity; ?></div>
                        <input onkeyup='resumm(<?php echo $item_id; ?>)' size='2' id='itemquantitytext<?php echo $item_id; ?>' class='itemquantitytext editelement' type='text'/>
                    </td>
                    <td class=xl68 style='border:solid 1px black;text-align:right;'>
                        <div class='itemprice changeelement'><?php echo $price; ?></div>
                        <input onkeyup='resumm(<?php echo $item_id; ?>)' size='2'id='itempricetext<?php echo $item_id; ?>' class='itempricetext editelement' type='text'/>
                    </td>
                    <td style='border:solid 1px black;text-align:right;'><div id='itemitogo<?php echo $item_id; ?>' class='itemitogo'><?php echo $totalprice; ?></div></td>
                </tr>
            <?php } ?>
            <tr height=20 style='height:15.0pt'>
                <td colspan=7 height=20 class=xl73 style='border:none;'><span style='mso-spacerun:yes'></span>Итого:</td>
                <td class=xl68 style='border:none'>&nbsp;</td>
                <td class=xl68 style='border:none'>&nbsp;</td>
                <td class=xl68 style='border:none'>&nbsp;</td>
                <td class="xl68 total" style='border:none;text-align:right;'>
                    <?php echo $total; ?>
                </td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 style='height:15.0pt'></td>
                <td>Сумма прописью:</td>
                <td colspan=9 class='totalstr' style='border-bottom:solid 1px black;mso-ignore:colspan;font:italic 12px Arial;'>
                    <?php echo $this->data->total_string; ?>
                </td>
            </tr>
            <tr>
                <td colspan=5 width=171 valign="top" style='width:129pt' align="left">

                </td>
                <td colspan=6 width=171 valign="top" align="right">
                    <span class="orderdate changeelement" style='font-size:10.0pt;font-family:"Bookman Old Style";mso-bidi-font-family:"Bookman Old Style"'><?php echo date("d.m.Y", strtotime($details->created_on)); ?></span>
                    <input type="text" class="orderdatetext editelement" value="<?php echo date("d.m.Y", strtotime($details->created_on)); ?>"/>
            </tr>
            <tr height=60 style='height:45.0pt;mso-xlrowspan:3'>
                <td height=60 colspan=11 style='height:45.0pt;mso-ignore:colspan'></td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 style='height:15.0pt'></td>
                <td>м.п.</td>
                <td></td>
                <td colspan=3 style='mso-ignore:colspan'>Руководитель</td>
                <td colspan=2 style='mso-ignore:colspan'>гл. Бухгалтер</td>
                <td colspan=3 style='mso-ignore:colspan'></td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 colspan=11 style='height:15.0pt;mso-ignore:colspan'></td>
            </tr>
            <tr height=46 style='mso-height-source:userset;height:34.5pt'>
                <td height=46 colspan=11 style='height:34.5pt;mso-ignore:colspan'></td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 class=xl69 style='height:15.0pt'></td>
                <td></td>
                <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
                <td colspan=7 style='mso-ignore:colspan'></td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 class=xl69 style='height:15.0pt'></td>
                <td></td>
                <td colspan=4 class=xl78></td>
                <td colspan=5 style='mso-ignore:colspan'></td>
            </tr>
            <tr height=20 style='height:15.0pt'>
                <td height=20 class=xl69 style='height:15.0pt'></td>
                <td colspan=2 style='mso-ignore:colspan'></td>
                <td class=xl65></td>
                <td colspan=7 style='mso-ignore:colspan'></td>
            </tr>
        </table>
    </body>

</html>
