<?php

/**
 * @version		$Id: mod_wrapper.php 14401 2010-01-26 14:10:00Z louis $
 * @package		Joomla
 * @copyright	Copyright (C) 2005 - 2010 Open Source Matters. All rights reserved.
 * @license		GNU/GPL, see LICENSE.php
 * Joomla! is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * See COPYRIGHT.php for copyright notices and details.
 */
// no direct access
defined('_JEXEC') or die('Restricted access');

defined('DS') or define('DS', DIRECTORY_SEPARATOR);
defined('VMPATH_ADMIN') or define('VMPATH_ADMIN', JPATH_ROOT.DS.'administrator'.DS.'components'.DS.'com_virtuemart');
defined('VMPATH_ROOT') or define('VMPATH_ROOT', JPATH_ROOT);

if (!class_exists('VmImage')) {
    require(VMPATH_ADMIN . '/helpers/image.php');
}

if (!class_exists('vRequest')) {
    return;
}

// Include the syndicate functions only once
require_once (dirname(__FILE__) . '/helper.php');

$products = modLatestprodHelper::getProducts($params);
$kurs     = modLatestprodHelper::getKurs();

if ($products) {
    require(JModuleHelper::getLayoutPath('mod_latestprod'));
}