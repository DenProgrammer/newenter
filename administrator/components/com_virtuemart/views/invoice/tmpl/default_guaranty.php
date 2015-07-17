<?php
$items   = $this->data->order['items'];
$details = $this->data->order['details']['BT'];
?><html>
    <head>
        <meta http-equiv=Content-Type content="text/html; charset=utf8"/>
        <title>Гарантийный талон</title>

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
                });

                $("#vendorselect").change();
                $('img').removeAttr("height").attr("width", 70);
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

                    var items = new Object;
                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;

                        var order_item_id = $(this).attr('rel').replace(/[^0-9]+/g, '');
                        var itemname = $("#" + id + " td input.itemnametext").val();
                        var itemquantity = $("#" + id + " td input.itemquantitytext").val().replace(/[^0-9]+/g, '');
                        var itemprice = $("#" + id + " td input.itempricetext").val().replace(/[^0-9,\.]+/g, '');
                        var itemsku = $("#" + id + " td input.itemskutext").val();
                        var orderdate = $("input.orderdatetext").val().replace(/["']+/g, '');
                        var itemguaranty = $("#" + id + " td input.itemguarantytext").val().replace(/["']+/g, '');
                        $("#" + id + " td div.itemname").html(itemname);
                        $("#" + id + " td div.itemquantity").html(itemquantity);
                        $("#" + id + " td div.itemsku").html(itemsku);
                        $("#" + id + " td div.itemprice").html(itemprice);
                        $("#" + id + " td div.itemguaranty").html(itemguaranty);
                        $("span.orderdate").html(orderdate);

                        var order_item_id = $("#" + id).attr('rel');
                        var itemsn = '';
                        $("#" + id + " td input.itemsntext").each(function(i, el) {
                            itemsn += $(this).val() + '<br>';
                        });
                        itemsn = itemsn.replace(/["']+/g, '');
                        $("#" + id + " td.itemsn").html(itemsn);

//                        itemname = $.base64.encode(itemname);

                        items[order_item_id] = {
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

                    $("tr.itemrow").each(function(i, el) {
                        var id = this.id;

                        $("#" + id + " td input.itemnametext").val($("#" + id + " td div.itemname").html());
                        $("#" + id + " td input.itemquantitytext").val($("#" + id + " td div.itemquantity").html());
                        $("#" + id + " td input.itempricetext").val($("#" + id + " td div.itemprice").html());
                        $("#" + id + " td input.itemskutext").val($("#" + id + " td div.itemsku").html());
                        $("input.orderdatetext").val($("span.orderdate").html());

                        var itemquantity = $("#" + id + " td div.itemquantity").html();
                        var itemsn = $("#" + id + " td.itemsn").html();
                        var arr = itemsn.split('<br>');
                        var str = '';
                        var v = '';
                        for (i = 0; i < itemquantity; i++)
                        {
                            if (arr[i])
                                v = arr[i];
                            else
                                v = '';
                            str += '<input text="text" class="changelement itemsntext" value="' + v + '"/>';
                        }

                        $("#" + id + " td.itemsn").html(str);
                        $("#" + id + " td input.itemguarantytext").val($("#" + id + " td div.itemguaranty").html());
                    });
                    editregim = true;
                }
            }

            function getExcelLink()
            {
                var vendor = $('#vendorselect').val();
                $.get('index.php?option=com_import_2&id=<?php echo $details->virtuemart_order_id; ?>&type=guaranty&ajax=showExcelDocument', {vendor: vendor}, function(data) {
                    document.location = data;
                });
            }
        </script>
        <style>
            p{font-size:12px;
              font-family:"Times New Roman";
              margin-top:3px;
              margin-bottom:3px;
            }
            .editelement{
                display:none;
            }
            ol{
                margin-top:0px;
                margin-bottom:0px;
            }
            #ui-datepicker-div{
                width:240px;
            }
        </style>
    </head>
    <body lang=RU style='tab-interval:35.4pt;text-justify-trim:punctuation'>
        <div class="Section1" style="width:705px;position:relative;">
            <div style="position:absolute;right:0px;cursor:pointer;width:48px;height:48px;display:inline-block;background:url(http://enter.kg/images/M_images/excel_icon.png) no-repeat;" title="Скачать в формате EXCEL" onclick="getExcelLink()"></div>

            <p class=MsoNormal align=center style='text-align:center;mso-pagination:none;
               mso-layout-grid-align:none;text-autospace:none'><b><span style='font-size:20.0pt;
                       font-family:"Bookman Old Style";mso-bidi-font-family:"Bookman Old Style"' onclick="edit()">Гарантийный талон</span></b></p>

            <p class=MsoNormal align=center style='text-align:center;mso-pagination:none;
               mso-layout-grid-align:none;text-autospace:none'><span style='font-size:9.0pt;
                    font-family:"Times New Roman CYR"'></span></p>

            <table class="MsoNormalTable" border=0 cellspacing=0 cellpadding=0 style='table-layout:fixed;margin-left:4.8pt;border-collapse:collapse;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
                <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:15.0pt'>
                    <td width=20 valign=bottom style='border:solid windowtext 1.0pt; mso-border-alt:solid windowtext .5pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>кол.</span>
                        </p>
                    </td>
                    <td valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Наименование</span>
                        </p>
                    </td>
                    <td width=50 valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR"; color:black'>Артикул</span>
                        </p>
                    </td>
                    <td width=45 valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Цена сом</span>
                        </p>
                    </td>
                    <td width=45 valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Итого сом</span>
                        </p>
                    </td>
                    <td valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>SN</span>
                        </p>
                    </td>
                    <td width=25 valign=bottom style='border:solid windowtext 1.0pt;border-left:none;mso-border-top-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Гар. мес.</span>
                        </p>
                    </td>
                </tr>
                <?php
                $num     = 0;
                $total   = 0;
                foreach ($items as $item) {
                    $num++;
                    $item_id                 = $item->virtuemart_order_item_id;
                    $itemname                = $item->order_item_name;
                    $itemsku                 = str_replace('sklad-', '', $item->order_item_sku);
                    $quantity                = $item->product_quantity;
                    $final_price             = $details->order_currency = 202 ? $item->product_final_price * $this->exchange : $item->product_final_price;
                    $price                   = round($final_price * (1 + $details->nrt / 100));
                    $totalprice              = $price * $quantity;
                    $attribute               = json_decode($item->product_attribute);

                    $total += $totalprice;

                    $guaranty = isset($attribute->guaranty) ? $attribute->guaranty : '12 мес.';
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
                            <div id='itemitogo<?php echo $num; ?>' class='itemitogo'>
                                <?php echo $totalprice; ?>
                            </div>
                        </td>
                        <td class='itemsn' valign=bottom 
                            style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'
                            ><?php echo $sn; ?></td>
                        <td style='border:solid 1px black;text-align:right;'>
                            <div class='itemguaranty changeelement'><?php echo $guaranty; ?></div>
                            <input size='5' id='itemguarantytext<?php echo $num; ?>' class='itemguarantytext editelement' type='text'/>
                        </td>
                    </tr>
                <?php } ?>
                <tr style='mso-yfti-irow:2;mso-yfti-lastrow:yes;height:15.0pt'>
                    <td valign=bottom style='border:solid windowtext 1.0pt;border-top:none;mso-border-left-alt:solid windowtext .5pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'><span style='mso-spacerun:yes'>  </span></span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>Итого к оплате</span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal align=right style='text-align:right;mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'><?php echo $total; ?></span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
                    </td>
                    <td valign=bottom style='border-top:none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.0pt'>
                        <p class=MsoNormal style='mso-pagination:none;mso-layout-grid-align:none;text-autospace:none'>
                            <span style='font-size:11.0pt;font-family:"Times New Roman CYR";color:black'>&nbsp;</span>
                        </p>
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
        </div>
        <?php echo $this->data->guaranty; ?>
    </body>
</html>