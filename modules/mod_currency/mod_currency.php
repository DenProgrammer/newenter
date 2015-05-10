<?php

/**
 * @package     Joomla.Site
 * @subpackage  mod_curency
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

$currencyValue = $params->get('currency_value', 0);
$delivery  = $params->get('delivery', 0);

require JModuleHelper::getLayoutPath('mod_currency', $params->get('layout', 'default'));