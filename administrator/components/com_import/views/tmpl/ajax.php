<?php
switch (JRequest::getVar('ajax')) {
    case 'getWinAddNewSklad': {
            ?>
            <div id="AddNewSklad">
                <input type="text" id="priceName" />
                <input type="text" id="clearLine" />
                <input type="text" id="categoryNamePosition" />
                <input type="text" id="productNamePosition" />
                <input type="text" id="productPricePosition" />
                <input type="text" id="productDescPosition" />
                <input type="button" onclick="hideWinAddNewSklad()" value="Отменить" id="cancel" />
                <input type="button" value="Добавить новый склад" onclick="addNewSklad()" id="save" />
            </div>
            <?php
            break;
        }
    case 'editPrice': {
            ?>
            <div id="AddNewSklad">
                <input type="text" id="priceName" value="<?php echo $price_name; ?>" />
                <input type="text" id="clearLine" value="<?php echo $clear_line; ?>" />
                <input type="text" id="categoryNamePosition" value="<?php echo $position_category_name; ?>" />
                <input type="text" id="productPricePosition" value="<?php echo $position_product_price; ?>" />
                <input type="text" id="productNamePosition" value="<?php echo $position_product_name; ?>" />
                <input type="text" id="productDescPosition" value="<?php echo $position_product_s_desk; ?>" />
                <input type="button" onclick="hideWinAddNewSklad()" value="Отменить" id="cancel" />
                <input type="button" value="Принять изменения" onclick="saveEditSklad(<?php echo $id; ?>)" id="save" />
            </div>
            <?php
            break;
        }
    case 'getWinListSklad': {
            ?>
            <div id="ListSklad">
                <input type="button" value="Создать новый" onclick="getWinAddNewSklad()" id="new" />
                <img src="components/com_import/assets/images/close1.png" id="listSkladClose" onclick="hideWinAddNewSklad()"/>
                <div class="conteyner">
                    <table border="0" style="width:100%">
                        <?php
                        if ($data)
                            foreach ($data as $item) {
                                echo '<tr>
                                        <td>' . $item->price_name . '</td>
                                        <td>' . $item->sklad_name . '</td>
                                        <td width="95" class="btn" onclick="editPrice(' . $item->id . ')">Редакт.</td>
                                        <td width="120" class="btn" onclick="deletePrice(' . $item->id . ')">Удалить</td>
                                    </tr>';
                            }
                        ?>
                    </table>
                </div>
            </div>
            <?php
            break;
        }
}