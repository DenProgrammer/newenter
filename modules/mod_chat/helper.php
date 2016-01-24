<?php

/**
 * @version		$Id: helper.php 14401 2010-01-26 14:10:00Z louis $
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

class modChatHelper
{

    /**
     * checking time output chat
     * @param Object $params
     * @return boolean
     */
    public static function isShow($params)
    {
        $weekdays_start_hour  = $params->get('weekdays_start_hour', 0);
        $weekdays_finish_hour = $params->get('weekdays_finish_hour', 0);
        $weekend_start_hour   = $params->get('weekend_start_hour', 0);
        $weekend_finish_hour  = $params->get('weekend_finish_hour', 0);

        $weekdays_start  = $params->get('weekdays_start', 9);
        $weekdays_finish = $params->get('weekdays_finish', 18);
        $weekend_start   = $params->get('weekend_start', 0);
        $weekend_finish  = $params->get('weekend_finish', 0);

        $date = getdate();

        $wday = $date['wday'];
        $time = time() + 6 * 3600;

        if ($wday == 0 || $wday == 6) {
            $start       = $weekend_start;
            $finish      = $weekend_finish;
            $start_hour  = $weekend_start_hour;
            $finish_hour = $weekend_finish_hour;
        } else {
            $start       = $weekdays_start;
            $finish      = $weekdays_finish;
            $start_hour  = $weekdays_start_hour;
            $finish_hour = $weekdays_finish_hour;
        }

        $start       = modChatHelper::format($start);
        $finish      = modChatHelper::format($finish);
        $start_hour  = modChatHelper::format($start_hour);
        $finish_hour = modChatHelper::format($finish_hour);

        $time_start  = strtotime(date('d.m.Y').' '.$start_hour.':'.$start.':00');
        $time_finish = strtotime(date('d.m.Y').' '.$finish_hour.':'.$finish.':00');

        if ($time_start <= $time && $time_finish >= $time) {
            return false;
        } else {
            return true;
        }
    }

    public static function format($number)
    {
        if ($number < 10) {
            $number = '0'.$number;
        }

        return strval($number);
    }
}
