<?php

/**
 * @package     Joomla.Site
 * @subpackage  mod_curency
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

/**
 * Helper for mod_feed
 *
 * @package     Joomla.Site
 * @subpackage  mod_rate
 * @since       1.5
 */
class ModCurencyHelper {

    /**
     * get currency
     * 
     * @return object
     */
    public static function getCurrency() {
        $db = JFactory::getDbo();

        $sql = 'SELECT * FROM #__virtuemart_currencies WHERE currency_code_3 = "KGS"';
        $db->setQuery($sql);

        return $db->loadObject();
    }

}
