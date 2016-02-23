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
if (VmConfig::get('usefancy', 1)) {
    vmJsApi::addJScript('fancybox/jquery.fancybox-1.3.4.pack', false);
    vmJsApi::css('jquery.fancybox-1.3.4');
    $document = JFactory::getDocument();
    $imageJS  = '
	jQuery(document).ready(function() {
		Virtuemart.updateImageEventListeners()
	});
	Virtuemart.updateImageEventListeners = function() {
		jQuery("a[rel=vm-additional-images]").fancybox({
			"titlePosition" 	: "inside",
			"transitionIn"	:	"elastic",
			"transitionOut"	:	"elastic"
		});
		jQuery(".additional-images a.product-image.image-0").removeAttr("rel");
		jQuery(".additional-images img.product-image").click(function() {
			jQuery(".additional-images a.product-image").attr("rel","vm-additional-images" );
			jQuery(this).parent().children("a.product-image").removeAttr("rel");
			var src = jQuery(this).parent().children("a.product-image").attr("href");
			jQuery(".main-image img").attr("src",src);
			jQuery(".main-image img").attr("alt",this.alt );
			jQuery(".main-image a").attr("href",src );
			jQuery(".main-image a").attr("title",this.alt );
			jQuery(".main-image .vm-img-desc").html(this.alt);
		}); 
	}
	';
} else {
    vmJsApi::addJScript('facebox', false);
    vmJsApi::css('facebox');
    $document = JFactory::getDocument();
    $imageJS  = '
	jQuery(document).ready(function() {
		Virtuemart.updateImageEventListeners()
	});
	Virtuemart.updateImageEventListeners = function() {
		jQuery("a[rel=vm-additional-images]").facebox();
		var imgtitle = jQuery("span.vm-img-desc").text();
		jQuery("#facebox span").html(imgtitle);
	}
	';
}
//vmJsApi::addJScript('imagepopup', $imageJS);

if (!empty($this->product->images)) {
    $image = $this->product->images[0];
    ?>
    <link rel="stylesheet" media="screen, projection" href="templates/jblank/css/drift-basic.css">
    <style type="text/css">
        body {
            font-family: Helvetica Neue, Arial, sans;
            margin-top: 2em;
            background: #FAFAFA;
        }

        .wrapper {
            margin: 0 auto;
            width: 860px;
        }

        .drift-demo-trigger {
            width: 40%;
            float: left;
        }

        .detail {
            position: relative;
            width: 400px;
            height: 300px;
            border: solid 1px black;
            display: none;
        }

        h1 {
            color: #013C4A;
            margin-top: 1em;
            margin-bottom: 1em;
        }

        p {
            max-width: 32em;
            margin-bottom: 1em;
            color: #23637f;
            line-height: 1.6em;
        }

        p:last-of-type {
            margin-bottom: 2em;
        }

        a {
            color: #00C0FA;
        }

        .ix-link {
            display: block;
            margin-bottom: 3em;
        }
        .wrap-detail{
            position: absolute;
            left: 220px;
            top: 0px;
            z-index: 1000;
        }
        .vm-product-media-container{
            position: relative;
        }   
    </style>
    <script src="templates/jblank/js/Drift.min.js"></script>
    <div class="main-image">
        <img alt="" src="<?php echo $image->file_url; ?>" data-zoom="<?php echo $image->file_url; ?>">
        <div class="clear"></div>
    </div>
    <div class="wrap-detail"><div class="detail"></div></div>

    <script>
        jQuery(function ($) {
            $('div.main-image img').on('mouseover', '', function () {
                $('div.detail').css('display', 'block');
            }).on('mouseout', '', function () {
                $('div.detail').css('display', 'none');
            });

            new Drift(document.querySelector('.main-image img'), {
                paneContainer: document.querySelector('.detail'),
                inlinePane: 900,
                inlineOffsetY: -85,
                zoomFactor: 6,
                containInline: true
            });
        });

    </script>
    <?php
}
