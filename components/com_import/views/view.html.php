<?php
/**jhjgаришо
* @version		$Id: view.html.php 19343 2010-11-03 18:12:02Z ian $
* @package		Joomla
* @subpackage	Config
* @copyright	Copyright (C) 2005 - 2010 Open Source Matters. All rights reserved.
* @license		GNU/GPL, see LICENSE.php
* Joomla! is free software. This version may have been modified pursuant
* to the GNU General Public License, and as distributed it includes or
* is derivative of works licensed under the GNU General Public License or
* other free or open source software licenses.
* See COPYRIGHT.php for copyright notices and details.
*/

// no direct access
defined( '_JEXEC' ) or die( 'Restricted access' );

jimport( 'joomla.application.component.view');

	$ajax = $_GET['ajax'];

	switch($_GET['ajax'])
		{	
			case 'showDocument':
				{
					switch($_GET['type'])
						{
							case 'etiketka':
								{
									$db = JFactory::getDBO();
									
									//получение информации о товаре
									$product_id = $_GET['id'];
									
									$sql = 'SELECT * FROM `#__vm_product` WHERE `product_id`='.$product_id;
									$db->setQuery($sql);
									$product = $db->LoadObject();
									
									//получение цены товара
									$sql = 'SELECT `product_price` FROM `#__vm_product_price` WHERE `shopper_group_id`=5 AND `product_id`='.$product_id;
									$db->setQuery($sql);
									$product_price = $db->LoadResult();
									$product_price = round($product_price,2);
									
									$query =" SELECT params FROM jos_modules WHERE id = 51";
									$db->setQuery($query);
									$rows = $db->loadObjectList();
									foreach($rows as $row)
										{
											$params = $row->params;
										}
										
									$str1 = explode("\n",$params);
									$str2 = explode("=",$str1[0]);
									
										
									$kurs = $str2[1];
									$sep = ' / ';

									$price = $product_price;
									$product_price_som = number_format(($price*$kurs),2,'.','');
									$product_price .= ' $ / '.$product_price_som.' сом' ;
	
									//получение категории товара
									$sql = 'SELECT `category_name` FROM `#__vm_category` WHERE `category_id`=(
												SELECT `category_id` FROM `#__vm_product_category_xref` WHERE `product_id`='.$product_id.' LIMIT 1)';
									$db->setQuery($sql);
									$catname = $db->LoadResult();
									$prodsku = explode('-',$product->product_sku);
									$sklad = $prodsku[1].'-'.$prodsku[2];
									$art = $prodsku[2];
									
									$tmpl = 'images/docs/tmpl/etiketka.htm';
									$prodname = str_replace(',',', ',$product->product_name);
									$prodname = str_replace('  ',' ',$prodname);
									
									$arrkey = array('%CATNAME%','%SKLAD%','%PRODNAME%','%PRICE%','%PRICESOM%','%DATE%','%ART%');
									$arrvalue = array($catname,$sklad,$prodname,$product_price,$product_price_som,date("d.m.Y"),$art);
									
									$file = implode(file($tmpl));
									$file = str_replace($arrkey,$arrvalue,$file);
									
									echo $file;
									
									break;
								}
						}
					break;
				}
			case 'createPrice':
				{
					$dbo = JFactory::getDBO();
					
					$categories = getCategoryList(0);
					$content = '';
					foreach($categories as $c)
						{
							$id = $c->category_id;
							$name = $c->category_name;
							$lvl = $c->lvl;
							
							if ($lvl==0)
								{
									$content .= "<tr><td colspan=2 style='background: #f90000; color: white; font-size: 16px;'>$name</td></tr>";
								}
							else
								{
									$content .= "<tr><td colspan=2><strong>$name</strong></td></tr>";
								}
							$subsql = "SELECT `product_id`, `product_name`, 
										(
											SELECT `product_price` 
											FROM `jos_vm_product_price` 
											WHERE `product_id`=`jos_vm_product`.`product_id` AND `product_currency`='USD' 
											LIMIT 1
										) AS `product_price`
									FROM `jos_vm_product` 
									WHERE `product_publish`='Y' AND `product_id` IN 
										(
											SELECT `product_id` 
											FROM `jos_vm_product_category_xref` 
											WHERE `category_id`=$id
										)";
							$dbo->setQuery($subsql);
							$rows = $dbo->LoadObjectList();
							foreach($rows as $row)
								{
									$product_id = $row->product_id;  	 	
									$product_name = $row->product_name; 
									$product_price = $row->product_price; 

									$content .= "<tr><td>$product_name</td><td>$product_price</td></tr>";
								}
						}
					
					$template = '<html>
								<head>
									<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
								<head>
								<body>
									<table class="price" border=1 width=1000>%CONTENT%</table>';					
					$filetext = str_replace('%CONTENT%',$content,$template);
					
					$f = fopen("images/stories/price.xls", 'w');
					fwrite($f,$filetext);
					fclose($f);	
					
					echo 'Прайс лист обновлен';
					
					break;
				}
		}
?>