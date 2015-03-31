<?php

/**
 * @package     Joomla.Administrator
 * @subpackage  com_sincroniser
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

/**
 * Sincroniser component helper.
 *
 * @package     Joomla.Administrator
 * @subpackage  com_sincroniser
 * @since       1.5
 */
class SincroniserHelper {

    function pr($var) {
        echo '<pre>';
        print_r($var);
        echo '</pre>';
    }

}
