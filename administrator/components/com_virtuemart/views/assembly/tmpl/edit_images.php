<?php
/**
 *
 * Description
 *
 * @package	VirtueMart
 * @subpackage OrderStatus
 * @author Oscar van Eijk
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: edit.php 8080 2014-06-29 07:31:28Z alatak $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');
?>
<div class="col50">
    <div class="selectimage">
        <?php
        if ($this->assembly->virtuemart_media_id) {
            echo $this->assembly->images[0]->displayFilesHandler($this->assembly->virtuemart_media_id, 'assembly');
        } else {
            echo $this->assembly->images[0]->displayFilesHandler(null, 'assembly');
        }
        ?>
    </div>
</div>
