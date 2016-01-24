<?php

/**
 * @package     Joomla.Plugin
 * @subpackage  System.sef
 *
 * @copyright   Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

/**
 * Joomla! SEF Plugin.
 *
 * @since  1.5
 */
class PlgSystemMfr extends JPlugin
{

    /**
     * Add the canonical uri to the head.
     *
     * @return  void
     *
     * @since   3.0
     */
    public function onAfterRender()
    {
        $doc = JFactory::getDocument();

        if (!file_exists(JPATH_ROOT.'/cache/script.js')) {
            $text = null;
            foreach ($doc->_scripts as $script => $params) {
                $path = JPATH_ROOT.'/'.current(explode('?', $script));

                $text .= file_get_contents($path)."\n";
            }

            file_put_contents(JPATH_ROOT.'/cache/script.js', $text);
        }

        if (!file_exists(JPATH_ROOT.'/cache/style.css')) {
            $style = null;
            foreach ($doc->_styleSheets as $script => $params) {
                $path = JPATH_ROOT.'/'.current(explode('?', $script));

                $style .= file_get_contents($path)."\n";
            }

            file_put_contents(JPATH_ROOT.'/cache/style.css', $style);
        }
    }
}
