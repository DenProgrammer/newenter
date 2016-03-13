<?php
/**
 *
 * Show the product details page
 *
 * @package	VirtueMart
 * @subpackage
 * @author Max Milbers, Valerie Isaksen

 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2010 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: default_images.php 8508 2014-10-22 18:57:14Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

if (!empty($this->product->images)) {
    $image = $this->product->images[0];
    ?>
    <div class="main-image">
        <a href="<?php echo $image->file_url; ?>" rel="vm-additional-images">
            <img alt="" src="<?php echo $image->file_url; ?>" data-zoom="<?php echo $image->file_url; ?>">
        </a>
        <div class="clear"></div>
    </div>
    <div class="wrap-detail"><div class="detail"></div></div>
    <script>
        jQuery(function ($) {
            $('div.main-image a img').on('mouseover', '', function () {
                $('div.detail').css('display', 'block');
            }).on('mouseout', '', function () {
                $('div.detail').css('display', 'none');
            });

            $('a[rel=vm-additional-images]').click(function () {

                var wrapper = $('<div/>', {'class': 'images-wrapper'});
                var container = $('<img/>', {'src': $(this).attr('href'), 'class': 'images-container'});

                wrapper.append(container);
                $('body').append(wrapper);

                $('div.images-wrapper').show();
                $('div.images-wrapper').find('img').css('margin-top',- $('div.images-wrapper').find('img').height()/2);

                return false;
            });

            $('body').on('click', 'div.images-wrapper', function () {
                $('div.images-wrapper').hide().remove();
            });

            new Drift(document.querySelector('.main-image a img'), {
                paneContainer: document.querySelector('.detail'),
                inlinePane: 900,
                inlineOffsetY: -85,
                zoomFactor: 3,
                containInline: true
            });
        });

    </script>
    <?php
}
