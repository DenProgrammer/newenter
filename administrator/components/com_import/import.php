<?php

// no direct access
defined('_JEXEC') or die('Restricted access');

header('Content-type: text/html; charset=utf-8');

define('PATH_ASSETS', 'components/com_import/assets');

// Require the com_content helper library
require_once (JPATH_COMPONENT . '/controller.php');
include_once('helpers/functions.php');
include_once('models/import.php');
include 'components/com_virtuemart/helpers/config.php';


//$_SESSION['import'] = null;
$document = JFactory::getDocument();
$document->addStyleSheet(PATH_ASSETS . '/css/import.css');
$document->addStyleSheet(PATH_ASSETS . '/css/jquery.ui.all.css');
$document->addStyleSheet(PATH_ASSETS . '/css/jquery.ui.base.css');
$document->addStyleSheet(PATH_ASSETS . '/css/jquery.ui.core.css');
$document->addStyleSheet(PATH_ASSETS . '/css/jquery.ui.datepicker.css');
$document->addStyleSheet(PATH_ASSETS . '/css/jquery.ui.theme.css');
$document->addScript('../media/jui/js/jquery.min.js');
$document->addScript(PATH_ASSETS . '/js/jquery.ui.core.js');
$document->addScript(PATH_ASSETS . '/js/jquery.ui.datepicker-ru.js');
$document->addScript(PATH_ASSETS . '/js/jquery.ui.datepicker.js');
$document->addScript(PATH_ASSETS . '/js/jquery.ui.widget.js');
$document->addScript(PATH_ASSETS . '/js/import.js');
$document->addScriptDeclaration("var mainurl = 'index.php?option=com_import&tmpl=ajax';");

JToolbarHelper::custom('searches.reset', 'refresh.png', 'refresh_f2.png', 'JSEARCH_RESET', false);
JToolbarHelper::title(JText::_('COM_IMPORT'));
JToolbarHelper::divider();
JToolbarHelper::preferences('com_import');
JToolbarHelper::divider();
JToolbarHelper::help('JHELP_COMPONENTS_SEARCH');

$task = JRequest::getVar('task');
$type = JRequest::getVar('type');

$remove = JRequest::getVar('remove');

/* * ****************************************global vars******************************************* */

$db  = JFactory::getDbo();
$sql = 'SELECT `extension_id` FROM `#__extensions` WHERE `element`=\'com_import\'';

$db->setQuery($sql);
$_SESSION['import']['component_id'] = $db->loadResult();

$config = getConfig($_SESSION['import']['component_id']);

//значения по умолчанию
$def['page']            = 1;
$def['active_document'] = 0;
$def['currency']        = 'USD';
$def['price']           = 'alifco';
$def['akcent']          = $config->shownewproduct;
$def['akcent_time']     = $config->actualtime;
$def['category_id']     = 0;
$def['category_title']  = 'Выбрать категорию';
$def['product_id']      = 0;

$_SESSION['import']['def']           = $def;
$_SESSION['import']['document_list'] = getDocumentList();

if (!isset($_SESSION['import']['price'])) {
    $_SESSION['import']['price'] = $_SESSION['import']['def']['price'];
}
if (!isset($_SESSION['import']['page'])) {
    $_SESSION['import']['page'] = $_SESSION['import']['def']['page'];
}
if (!isset($_SESSION['import']['currency'])) {
    $_SESSION['import']['currency'] = $_SESSION['import']['def']['currency'];
}
if (!isset($_SESSION['import']['akcent'])) {
    $_SESSION['import']['akcent'] = $_SESSION['import']['def']['akcent'];
}
if (!isset($_SESSION['import']['akcent_time'])) {
    $_SESSION['import']['akcent_time'] = $_SESSION['import']['def']['akcent_time'];
}
if (!isset($_SESSION['import']['category_title'])) {
    $_SESSION['import']['category_title'] = $_SESSION['import']['def']['category_title'];
}
if (!isset($_SESSION['import']['product_id'])) {
    $_SESSION['import']['product_id'] = $_SESSION['import']['def']['product_id'];
}


/* * ********************************************************************************************** */

require_once (JPATH_COMPONENT . '/views/view.html.php');
