<?php

defined('_JEXEC') or die('Direct Access to ' . basename(__FILE__) . ' is not allowed.');
/**
 * @version $Id: mod_virtuemart_search.php 8429 2014-10-14 12:19:39Z Milbo $
 * @package VirtueMart
 * @subpackage modules
 *
 * @copyright (C) 2010-2014 The VirtueMart Team
 * @author Valerie Isaksen, Max Milbers
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
 * VirtueMart is Free Software.
 * VirtueMart comes with absolute no warranty.
 *
 * www.virtuemart.net
 */
defined('DS') or define('DS', DIRECTORY_SEPARATOR);
if (!class_exists('VmConfig')){
    require(JPATH_ROOT . DS . 'administrator' . DS . 'components' . DS . 'com_virtuemart' . DS . 'helpers' . DS . 'config.php');
}

VmConfig::loadConfig();
VmConfig::loadJLang('mod_virtuemart_search', true);


function getChildCategories($catId, &$categories, $level = 0) {
    $db = JFactory::getDBO();

    $sql = 'SELECT c.*, cxr.category_name FROM #__virtuemart_categories c '
            . 'LEFT JOIN #__virtuemart_categories_ru_ru cxr ON c.virtuemart_category_id = cxr.virtuemart_category_id '
            . 'LEFT JOIN #__virtuemart_category_categories cx ON c.virtuemart_category_id = cx.category_child_id '
            . 'WHERE c.published = 1 AND cx.category_parent_id = ' . $catId.' '
            . 'ORDER BY c.ordering, cxr.category_name';

    $db->setQuery($sql);
    $nodes  = $db->LoadObjectList();
    $childs = '';
    $sep    = '';
    foreach ($nodes as $node) {
        $node->level  = $level;
        $categories[] = $node;

        $node->countChild = getChildCategories($node->virtuemart_category_id, $categories, $level + 1);
        $childs .= $sep . $node->virtuemart_category_id;
        $sep              = ',';
    }
    return $catId . $sep . $childs;
}

$categories = array();
getChildCategories(0, $categories);

// Load the virtuemart main parse code
$button          = $params->get('button', 0);
$imagebutton     = $params->get('imagebutton', 0);
$button_pos      = $params->get('button_pos', 'left');
$button_text     = $params->get('button_text', vmText::_('MOD_VIRTUEMART_SEARCH_GO'));
$width           = intval($params->get('width', 20));
$maxlength       = $width > 20 ? $width : 20;
$text            = $params->get('text', vmText::_('MOD_VIRTUEMART_SEARCH_TEXT_TXT'));
$set_Itemid      = intval($params->get('set_itemid', 0));
$moduleclass_sfx = $params->get('moduleclass_sfx', '');

if ($params->get('filter_category', 0)) {
    $category_id = vRequest::getInt('virtuemart_category_id', 0);
} else {
    $category_id = 0;
}

$document = JFactory::getDocument();
$document->addScript('/modules/mod_virtuemart_search/assets/search.js');
$document->addStyleSheet('/modules/mod_virtuemart_search/assets/search.css');

require(JModuleHelper::getLayoutPath('mod_virtuemart_search'));
