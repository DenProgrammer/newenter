<?php
/**
 *
 * Show the product prices
 *
 * @package    VirtueMart
 * @subpackage
 * @author Max Milbers, Valerie Isaksen
 * @link http://www.virtuemart.net
 * @copyright Copyright (c) 2004 - 2014 VirtueMart Team. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 * VirtueMart is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * @version $Id: default_showprices.php 8024 2014-06-12 15:08:59Z Milbo $
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');
$product  = $viewData['product'];
$currency = $viewData['currency'];

$prodCount = isset($viewData['product_count']) ? $viewData['product_count'] : 0;
?>
<?php
if ($product->prices['salesPrice'] <= 0 and VmConfig::get('askprice', 1) and isset($product->images[0]) and !$product->images[0]->file_is_downloadable) {
    $askquestion_url = JRoute::_('index.php?option=com_virtuemart&view=productdetails&task=askquestion&virtuemart_product_id=' . $product->virtuemart_product_id . '&virtuemart_category_id=' . $product->virtuemart_category_id . '&tmpl=component', FALSE);
    ?>
    <a class="ask-a-question bold" href="<?php echo $askquestion_url ?>" rel="nofollow" ><?php echo vmText::_('COM_VIRTUEMART_PRODUCT_ASKPRICE') ?></a>
    <?php
} else {
    echo round($currency->roundForDisplay($product->prices['salesPrice'], 165, 1, 0)) . ' '
    . JText::_('COM_VIRTUEMART_CURRENCY_KGS')
    . ' / '
    . round($product->prices['salesPrice'], 2) . ' $';

    if ($prodCount) {
        echo '<br />' . $currency->roundForDisplay($prodCount * $product->prices['salesPrice'], 165, 1, 0, 0) . ' '
        . JText::_('COM_VIRTUEMART_CURRENCY_KGS')
        . ' / '
        . round($prodCount * $product->prices['salesPrice'], 2) . ' $';
    }
}
