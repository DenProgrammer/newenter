<?php
/**
 * @version $Id: cpanel.php 5 2013-01-11 10:22:28Z szymon $
 * @package DJ-ImageSlider
 * @subpackage DJ-ImageSlider Component
 * @copyright Copyright (C) 2012 DJ-Extensions.com, All rights reserved.
 * @license http://www.gnu.org/licenses GNU/GPL
 * @author url: http://dj-extensions.com
 * @author email contact@dj-extensions.com
 * @developer Szymon Woronowski - szymon.woronowski@design-joomla.eu
 *
 *
 * DJ-ImageSlider is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * DJ-ImageSlider is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with DJ-ImageSlider. If not, see <http://www.gnu.org/licenses/>.
 *
 */

// No direct access
defined('_JEXEC') or die;

jimport('joomla.application.component.controllerform');

class DJImageSliderControllerCPanel extends JControllerLegacy {
	
	function __construct($config = array())
	{
		parent::__construct($config);
	}
	
}

?>