<?php
// no direct access
defined('_JEXEC') or die('Restricted access');
//JHTML::stylesheet ( 'menucss.css', 'modules/mod_virtuemart_category/css/', false );

/* ID for jQuery dropdown */
$ID = str_replace('.', '_', substr(microtime(true), -8, 8));
$js = "
//<![CDATA[
jQuery(document).ready(function() {
		jQuery('#VMmenu" . $ID . " li.VmClose ul').hide();
		jQuery('#VMmenu" . $ID . " li .VmArrowdown').click(
		function() {

			if (jQuery(this).parent().next('ul').is(':hidden')) {
				jQuery('#VMmenu" . $ID . " ul:visible').delay(500).slideUp(500,'linear').parents('li').addClass('VmClose').removeClass('VmOpen');
				jQuery(this).parent().next('ul').slideDown(500,'linear');
				jQuery(this).parents('li').addClass('VmOpen').removeClass('VmClose');
			}
		});
	});
//]]>
";

$document = JFactory::getDocument();
$document->addScriptDeclaration($js);
?>
<ul class="VMmenu<?php echo $class_sfx ?>" id="<?php echo "VMmenu" . $ID ?>" >
    <?php
    foreach ($categories as $category) {
        $active_menu = 'class="VmClose"';
        $caturl      = JRoute::_('index.php?option=com_virtuemart&view=category&virtuemart_category_id=' . $category->virtuemart_category_id);
        $cattext     = $category->category_name;
        //if ($active_category_id == $category->virtuemart_category_id) $active_menu = 'class="active"';

        $path = '0,0,6,5,0,10,2,5';
        if (in_array($category->virtuemart_category_id, $parentCategories)) {
            $active_menu = 'class="VmOpen"';
            $path        = '0,2,5,4,10,2,5,8';
        }

        $countProduct = isset($countProducts[$category->virtuemart_category_id]) ? $countProducts[$category->virtuemart_category_id] : 0;
        if ($category->childs) {
            foreach ($category->childs as $child) {
                $countProduct += isset($countProducts[$child->virtuemart_category_id]) ? $countProducts[$child->virtuemart_category_id] : 0;
            }
        }

        if ($countProduct > 0) {
            $cattext .= ' (' . $countProduct . ')';
        }
        ?>
        <li <?php echo $active_menu ?>>
            <div>
                <?php
                echo JHTML::link($caturl, $cattext);
                if ($category->childs) {
                    ?>
                    <span class="VmArrowdown">
                        <svg class="svg" width="10" height="10">
                        <symbol id="s-crown">
                            <polygon points="<?php echo $path; ?>"
                                     fill="white" stroke="orange" stroke-width="0"/>
                        </symbol>
                        <use xlink:href="#s-crown" x="0" y="0"/>
                        </svg>
                    </span>
                    <?php
                }
                ?>
            </div>
            <?php if ($category->childs) { ?>
                <ul class="menu<?php echo $class_sfx; ?>">
                    <?php
                    foreach ($category->childs as $child) {

                        $active_child_menu = 'class="VmClose"';
                        $caturl            = JRoute::_('index.php?option=com_virtuemart&view=category&virtuemart_category_id=' . $child->virtuemart_category_id);
                        $cattext           = $child->category_name;
                        if ($child->virtuemart_category_id == $active_category_id) {
                            $active_child_menu = 'class="VmOpen"';
                        }

                        $countSubProduct = isset($countProducts[$child->virtuemart_category_id]) ? $countProducts[$child->virtuemart_category_id] : 0;

                        if ($countSubProduct > 0) {
                            $cattext .= ' (' . $countSubProduct . ')';
                        }
                        ?>
                        <li <?php echo $active_child_menu ?>>
                        <li>
                            <div ><?php echo JHTML::link($caturl, $cattext); ?></div>
                        </li>
                    <?php } ?>
                </ul>
            <?php } ?>
        </li>
    <?php }
    ?>
</ul>
