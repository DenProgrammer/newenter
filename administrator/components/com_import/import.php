<?php

// no direct access
defined('_JEXEC') or die('Restricted access');

header('Content-type: text/html; charset=utf-8');

define('PATH_ASSETS', 'components/com_import/assets');

// Require the com_content helper library
require_once (JPATH_COMPONENT . '/controller.php');
include_once('helpers/functions.php');
include_once('helpers/product.php');
include_once('helpers/PHPExcel/IOFactory.php');
include_once('models/import.php');
include 'components/com_virtuemart/helpers/config.php';

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

$task   = JRequest::getVar('task');
$ajax   = JRequest::getVar('ajax');
$type   = JRequest::getVar('type');
$remove = JRequest::getVar('remove');

init();
if (!$ajax) {
    updateHash();
}

require_once (JPATH_COMPONENT . '/views/view.html.php');
