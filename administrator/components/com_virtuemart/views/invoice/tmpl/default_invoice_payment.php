<?php
$items          = $this->data->order['items'];
$details        = $this->data->order['details']['BT'];
?>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <title>Счет на оплату № <?php echo $details->virtuemart_order_id; ?></title>

        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.all.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.base.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.core.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.datepicker.css" type="text/css" />
        <link rel="stylesheet" href="components/com_import/assets/css/jquery.ui.theme.css" type="text/css" />

        <script type="text/javascript" src="http://enter.kg/media/system/js/jquery.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.core.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.datepicker-ru.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.datepicker.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.ui.widget.js"></script>
        <script type="text/javascript" src="components/com_import/assets/js/jquery.base64.js"></script>
        <script>
            $('document').ready(function() {
                $.base64.utf8encode = true;
                $("#vendorselect").change(function() {
                    var id = $(this).val();
                    $("div.vendor").css("display", "none");
                    $("div.vendor" + id).css("display", "block");
                    $("div.cond").css("display", "none");
                    $("div.cond" + id).css("display", "block");
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

                    var vendor_info_id = $('#vendorselect').val();
                    $.post('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=saveOrder', {
                        order_id: '<?php echo $details->virtuemart_order_id; ?>',
                        vendor_info_id: vendor_info_id, nrt: nrt
                    }, function(data) {
                    });

                    $("#client").html($("#clienttext").val());

                    var items = new Object;
                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;
                        var order_item_id = $(this).attr('rel');
                        var itemname = $("#" + id + " td input.itemnametext").val();
                        var itemquantity = $("#" + id + " td input.itemquantitytext").val();
                        var itemprice = $("#" + id + " td input.itempricetext").val();
                        var itemguaranty = $("#" + id + " td input.itemguarantytext").val();
                        var itemsku = $("#" + id + " td input.itemskutext").val();
                        var itemsn = $("#" + id + " td input.itemsntext").val();
                        var orderdate = $("input.orderdatetext").val();
                        $("#" + id + " td div.itemname").html(itemname);
                        $("#" + id + " td div.itemquantity").html(itemquantity);
                        $("#" + id + " td div.itemprice").html(itemprice);
                        $("#" + id + " td div.itemguaranty").html(itemguaranty);
                        $("#" + id + " td div.itemsku").html(itemsku);
                        $("span.orderdate").html(orderdate);

//                        itemname = $.base64.encode(itemname);

                        items[id] = {
                            'order_item_id': order_item_id,
                            'itemname': itemname,
                            'itemguaranty': itemguaranty,
                            'itemsn': itemsn,
                            'itemquantity': itemquantity,
                            'itemprice': itemprice,
                            'itemsku': itemsku
                        };
                    });

                    $.post('index.php?option=com_virtuemart&view=invoice&task=save&tmpl=ajax&action=saveItems',
                            {order_id: '<?php echo $details->virtuemart_order_id; ?>', items: items, nrt: nrt});

                    editregim = false;
                }
                else
                {
                    $(".editelement").css("display", "block");
                    $(".changeelement").css("display", "none");

                    $("#clienttext").val($("#client").html());
                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;
                        $("#" + id + " td input.itemnametext").val($("#" + id + " td div.itemname").html());
                        $("#" + id + " td input.itemquantitytext").val($("#" + id + " td div.itemquantity").html());
                        $("#" + id + " td input.itempricetext").val($("#" + id + " td div.itemprice").html());
                        $("#" + id + " td input.itemskutext").val($("#" + id + " td div.itemsku").html());
                        $("#" + id + " td input.itemguarantytext").val($("#" + id + " td div.itemguaranty").html());
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

                $("td.total").html(total.toFixed(0));
            }
            function changeNRT()
            {
                var oldnrt = nrt;
                var tempnrt = parseFloat($("#nrt").attr("value"));
                if (tempnrt >= 0)
                {
                }
                else
                    return;
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
            }
            function getExcelLink()
            {
                var vendor = $('#vendorselect').val();
                $.get('index.php?option=com_import_2&id=<?php echo $details->virtuemart_order_id; ?>&type=schnaopl&ajax=showExcelDocument', {vendor: vendor}, function(data) {
                    document.location = data;
                });
            }
        </script>
        <style>
            <!--
            /* Font Definitions */
            @font-face
            {font-family:"Times New Roman CYR";
             panose-1:2 2 6 3 5 4 5 2 3 4;
             mso-font-charset:204;
             mso-generic-font-family:roman;
             mso-font-pitch:variable;
             mso-font-signature:-536855825 -1073711039 9 0 511 0;}
            @font-face
            {font-family:"Bookman Old Style";
             panose-1:2 5 6 4 5 5 5 2 2 4;
             mso-font-charset:204;
             mso-generic-font-family:roman;
             mso-font-pitch:variable;
             mso-font-signature:647 0 0 0 159 0;}
            /* Style Definitions */
            p.MsoNormal, li.MsoNormal, div.MsoNormal
            {mso-style-parent:"";
             margin:0cm;
             margin-bottom:.0001pt;
             mso-pagination:widow-orphan;
             font-size:12.0pt;
             font-family:"Times New Roman";
             mso-fareast-font-family:"Times New Roman";}
            /* Page Definitions */
            @page
            {mso-page-border-surround-header:no;
             mso-page-border-surround-footer:no;}
            @page Section1
            {size:612.0pt 792.0pt;
             margin:2.0cm 42.5pt 2.0cm 3.0cm;
             mso-header-margin:36.0pt;
             mso-footer-margin:36.0pt;
             mso-paper-source:0;}
            div.Section1
            {page:Section1;}
            div.vendor{display:none}
            div.vendor:first-child{display:block}
            .editelement{
                display:none;
            }
            p{
                margin-top:3px;
                margin-bottom:3px;
            }
            td,p{
                font-size:12px;
            }
            .editelement{
                display:none;
            }
            #ui-datepicker-div{
                width:240px;
            }
            -->
        </style>
    </head>
    <body lang=RU style='tab-interval:35.4pt;text-justify-trim:punctuation'>
        <div class="Section1" style="width:780px;position:relative;">
            <div style="position:absolute;right:0px;cursor:pointer;width:48px;height:48px;display:inline-block;background:url(http://enter.kg/images/M_images/excel_icon.png) no-repeat;" title="Скачать в формате EXCEL" onclick="getExcelLink()"></div>
            <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                <span style='font-family:"Times New Roman CYR"'></span></p>

            <p class=MsoNormal align=center style='text-align:center;mso-pagination:none;
               mso-layout-grid-align:none;text-autospace:none'><b><span style='font-size:20.0pt;
                       font-family:"Bookman Old Style";mso-bidi-font-family:"Bookman Old Style"' onclick="edit()">Счет на оплату № <?php echo $details->virtuemart_order_id; ?></span></b></p>

            <p class=MsoNormal align=center style='text-align:center;mso-pagination:none;
               mso-layout-grid-align:none;text-autospace:none'><span style='font-size:9.0pt;
                    font-family:"Times New Roman CYR"'></span></p>
            <select id="vendorselect" class="editelement">
                <?php
                foreach ($this->data->invoicetemplates as $row) {
                    $sel = ($details->vendor_info_id == $row->id) ? 'selected' : '';
                    $vendorlist .= '<option ' . $sel . ' value="' . $row->id . '">' . $row->title . '</option>';
                    $vendorinfo .= '<div class="vendor vendor' . $row->id . '">' . html_entity_decode($row->content_invoice_payment) . '</div>';
                    $condinfo .= '<div class="cond cond' . $row->id . '">' . html_entity_decode($row->footer_invoice_payment) . '</div>';
                }

                echo $vendorlist;
                ?>
            </select>
            <?php echo $vendorinfo; ?>
            <div class="editelement">НРТ <input onkeyup="changeNRT()" type="text" id="nrt" value="<?php echo $details->nrt; ?>"/></div>
            <table class="MsoNormalTable" border=0 cellspacing=0 cellpadding=0 style='margin-left:4.8pt;border-collapse:collapse;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
                <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:15.0pt'>
                    <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt; mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>кол-во</span>
                        </p>
                    </td>
                    <td width=434 valign=bottom style='width:325.2pt;border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Наименование</span>
                        </p>
                    </td>
                    <td width=65 valign=bottom style='width:48.85pt;border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR"; color:black'>Артикул</span>
                        </p>
                    </td>
                    <td width=67 valign=bottom style='width:50.0pt;border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Цена сом</span>
                        </p>
                    </td>
                    <td width=71 valign=bottom style='width:53.0pt;border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Итого сом</span>
                        </p>
                    </td>
                    <td width=71 valign=bottom style='width:53.0pt;border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Гарантия</span>
                        </p>
                    </td>
                </tr>
                <?php
                $num   = 0;
                $total = 0;
                foreach ($items as $item) {
                    $num++;
                    $item_id    = $item->virtuemart_order_item_id;
                    $itemname   = $item->order_item_name;
                    $itemsku    = $item->order_item_sku;
                    $quantity   = $item->product_quantity;
                    $price      = round($item->product_final_price * (1 + $details->nrt / 100), 2);
                    $totalprice = $price * $quantity;
                    $attribute  = json_decode($item->product_attribute);

                    $total += $totalprice;

                    $guaranty = isset($attribute->guaranty) ? $attribute->guaranty : null;
                    $sn       = isset($attribute->sn) ? $attribute->sn : null;
                    ?>
                    <tr id='row<?php echo $num; ?>' rel='<?php echo $item_id; ?>' class='itemrow' style='mso-yfti-irow:1;height:15.0pt'>
                        <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                            <div class='itemquantity changeelement'><?php echo $quantity; ?></div>
                            <input onkeyup='resumm(<?php echo $num; ?>)' size='2' id='itemquantitytext<?php echo $num; ?>' class='itemquantitytext editelement' type='text'/>
                        </td>
                        <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                            <div class='itemname changeelement'><?php echo $itemname; ?></div>
                            <input size='67' id='itemnametext<?php echo $num; ?>' class='itemnametext editelement' type='text'/>
                        </td>
                        <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                            <div class='itemsku changeelement'><?php echo $itemsku; ?></div>
                            <input size='10' id='itemskutext<?php echo $num; ?>' class='itemskutext editelement' type='text'/>
                        </td>
                        <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                            <div class='itemprice changeelement'><?php echo $price; ?></div>
                            <input onkeyup='resumm(<?php echo $num; ?>)' size='2'id='itempricetext<?php echo $num; ?>' class='itempricetext editelement' type='text'/>
                        </td>
                        <td width=71 style='border:solid 1px black;text-align:right;'>
                            <div id='itemitogo<?php echo $num; ?>' class='itemitogo'><?php echo $totalprice; ?></div>
                        </td>
                        <td style='border:solid 1px black;text-align:right;'>
                            <div class='itemguaranty changeelement'><?php echo $guaranty; ?></div>
                            <input size='5' id='itemguarantytext<?php echo $num; ?>' class='itemguarantytext editelement' type='text'/>
                            <input type="hidden" id='itemsntext<?php echo $num; ?>' class='itemsntext editelement' value="<?php echo $sn; ?>" />
                        </td>
                    </tr>
                <?php } ?>
                <tr style='mso-yfti-irow:2;mso-yfti-lastrow:yes;height:15.0pt'>
                    <td width=51 valign=bottom style='width:38.0pt;border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'><span style='mso-spacerun:yes'>  </span></span>
                        </p>
                    </td>
                    <td width=434 valign=bottom style='width:325.2pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Итого к оплате</span>
                        </p>
                    </td>
                    <td width=65 valign=bottom style='width:48.85pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
                    </td>
                    <td width=67 valign=bottom style='width:50.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
                    </td>
                    <td class="total" width=71 valign=bottom style='width:53.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <?php echo $total; ?>
                    </td>
                    <td valign=bottom style='width:53.0pt;border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td align="left" width="580">
                        &nbsp;
                    </td>
                    <td align="right">

                        <p class=MsoNormal align=right style='text-align:right;mso-pagination:none;tab-stops:225.2pt;mso-layout-grid-align:none;text-autospace:none'>
                            <b>
                                <i>
                                    <span class="orderdate changeelement" style='font-size:10.0pt;font-family:"Bookman Old Style";mso-bidi-font-family:"Bookman Old Style"'><?php echo date("d.m.Y", strtotime($details->created_on)); ?></span>
                                    <input type="text" class="orderdatetext editelement" value="<?php echo date("d.m.Y", strtotime($details->created_on)); ?>"/>
                                </i>
                            </b>

                        </p>

                    </td>
                </tr>
            </table>

            <?php echo $condinfo; ?>

        </div>

    </body>

</html>
