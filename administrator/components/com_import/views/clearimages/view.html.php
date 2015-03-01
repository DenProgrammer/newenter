<?php

/**
 * @version		$Id: view.html.php 14401 2010-01-26 14:10:00Z louis $
 * @package		Joomla
 * @subpackage	Media
 * @copyright	Copyright (C) 2005 - 2010 Open Source Matters. All rights reserved.
 * @license		GNU/GPL, see LICENSE.php
 * Joomla! is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * See COPYRIGHT.php for copyright notices and details.
 */
// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted access');

$db = JFactory::getDbo();

$path    = '../components/com_virtuemart/shop_image/';
$source  = $path . 'product';
$bakup   = $path . 'product_bkp';
$sourcer = $path . 'product/resized';
$bakupr  = $path . 'product_bkp/resized';
$action  = JRequest::getVar('action');

if (!is_dir($bakup)) {
    mkdir($bakup);
}
if (!is_dir($bakupr)) {
    mkdir($bakupr);
}

$responce = new stdClass();

switch ($action) {
    case 'clear': {
            $sql = 'delete from images';
            $db->setQuery($sql);
            $db->query();

            $responce->message = 'succes';

            break;
        }
    case 'prepare': {
            $dirHandle = opendir($source);
            $count     = 0;

            $sqlHead  = 'INSERT IGNORE INTO images VALUES ';
            $sep      = '';
            $countIns = 0;
            $sql      = '';
            while ($file     = readdir($dirHandle)) {
                $objectpath = $source . '/' . $file;
                if (is_file($objectpath)) {
                    $count++;
                    $sql .= $sep . ' (NULL, \'' . $file . '\', \'' . date("Y-m-d", filemtime($objectpath)) . '\', 0)';
                    $sep = ', ';
                    $countIns++;

                    if ($countIns == 1000) {
                        $db->setQuery($sqlHead . $sql);
                        $db->query();

                        $countIns = 0;
                        $sql      = '';
                        $sep      = '';
                    }
                }
            }

            if ($sql) {
                $db->setQuery($sqlHead . $sql);
                $db->query();

                $countIns = 0;
                $sql      = '';
                $sep      = '';
            }

            $dirHandler = opendir($sourcer);

            while ($file = readdir($dirHandler)) {
                $objectpath = $sourcer . '/' . $file;
                if (is_file($objectpath)) {
                    $count++;
                    $sql .= $sep . ' (NULL, \'resized/' . $file . '\', \'' . date("Y-m-d", filemtime($objectpath)) . '\', 0)';
                    $sep = ', ';
                    $countIns++;

                    if ($countIns == 1000) {
                        $db->setQuery($sqlHead . $sql);
                        $db->query();

                        $countIns = 0;
                        $sql      = '';
                        $sep      = '';
                    }
                }
            }

            if ($sql) {
                $db->setQuery($sqlHead . $sql);
                $db->query();
            }

            $responce->message = 'succes';
            $responce->count   = $count;

            break;
        }
    case 'detect': {
            $sql = 'select product_full_image, product_thumb_image '
                    . 'from jos_vm_product '
                    . 'where product_publish = \'Y\' '
                    . 'AND ((product_full_image <> "" and product_full_image is not null) '
                    . 'or (product_thumb_image <> "" and product_thumb_image is not null)) ';

            $db->setQuery($sql);
            $storesImages = $db->LoadObjectList();
            $allImages    = array();
            foreach ($storesImages as $item) {
                $allImages[] = $item->product_full_image;
                $allImages[] = $item->product_thumb_image;
            }

            $sql    = 'select * from images '
                    . 'where status = 0 and created < \'2014-01-01\'';
            $db->setQuery($sql);
            $images = $db->LoadObjectList();
            $count  = 0;

            foreach ($images as $image) {
                if (in_array($image->name, $allImages)) {
                    $status = 1;
                } else {
                    $status = 2;
                    $count++;
                }
                $sql = 'update images '
                        . 'set status = ' . $status . ' '
                        . 'where id = ' . $image->id;
                $db->setQuery($sql);
                $db->query();
            }

            $responce->message = 'succes';
            $responce->count   = $count;

            break;
        }
    case 'move': {
            $sql       = 'select * from images where status = 2 limit 100';
            $db->setQuery($sql);
            $images    = $db->LoadObjectList();
            $count     = 0;
            $iteration = JRequest::getInt('iteration');
            $iteration++;

            foreach ($images as $image) {
                if (rename($source . '/' . $image->name, $bakup . '/' . $image->name)) {
                    $status = 3;
                    $count++;
                } else {
                    $status = 4;
                }
                $sql = 'update images '
                        . 'set status = ' . $status . ' '
                        . 'where id = ' . $image->id;
                $db->setQuery($sql);
                $db->query();
            }

            $responce->message = 'succes';
            $responce->count   = $count;
            
            break;
        }
    default : {
            
        }
}

$debug .= date('d H:i:s') . ' done<br>';



include_once 'tmpl/default.php';
