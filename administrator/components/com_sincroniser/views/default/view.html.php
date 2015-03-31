<?php

/**
 * @package     Joomla.Administrator
 * @subpackage  com_search
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

/**
 * View class for a list of search terms.
 *
 * @package     Joomla.Administrator
 * @subpackage  com_sincroniser
 * @since       1.5
 */
class SincroniserViewDefault extends JViewLegacy {

    protected $enabled;
    protected $items;
    protected $pagination;
    protected $state;

    /**
     * Display the view
     */
    public function display($tpl = null) {
        parent::display($tpl);
    }

    /**
     * Add the page title and toolbar.
     *
     * @since   1.6
     */
    protected function addToolbar() {
        $canDo = $this->canDo;

        JToolbarHelper::title(JText::_('COM_SEARCH_MANAGER_SEARCHES'), 'search');

        if ($canDo->get('core.edit.state')) {
            JToolbarHelper::custom('searches.reset', 'refresh.png', 'refresh_f2.png', 'JSEARCH_RESET', false);
        }
        JToolbarHelper::divider();
        if ($canDo->get('core.admin')) {
            JToolbarHelper::preferences('com_search');
        }
        JToolbarHelper::divider();
        JToolbarHelper::help('JHELP_COMPONENTS_SEARCH');
    }

}
