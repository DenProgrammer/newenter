<?php

/**
 * @package     Joomla.Site
 * @subpackage  mod_curency
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

// Include the syndicate functions only once
require_once __DIR__ . '/helper.php';

$currency = ModCurencyHelper::getCurrency();

$currencyValue = round($currency->currency_exchange_rate, 2);
$delivery      = round($currency->currency_delivery, 2);

require JModuleHelper::getLayoutPath('mod_currency', $params->get('layout', 'default'));
