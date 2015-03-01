<?php
// Status Of Delimiter
$closeDelimiter = false;
$openTable      = true;
$hiddenFields   = '';

if (!empty($this->userFieldsCart['fields'])) {
    foreach ($this->userFieldsCart['fields'] as $field) {
        ?>
        <fieldset class="vm-fieldset-<?php echo str_replace('_', '-', $field['name']) ?>">
            <div  class="cart <?php echo str_replace('_', '-', $field['name']) ?>" >
                <span class="cart <?php echo str_replace('_', '-', $field['name']) ?>" ><?php echo $field['title'] ?></span>

                <?php
                if ($field['hidden'] == true) {
                    $hiddenFields .= $field['formcode'] . "\n";
                } else {
                    ?>
                    <?php echo $field['formcode'] ?>
                </div>
            <?php } ?>
        </fieldset>
        <?php
    }
    echo $hiddenFields;
}