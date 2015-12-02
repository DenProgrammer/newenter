<?php

/**
 * @package    Joomla.Site
 *
 * @copyright  Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */
if (version_compare(PHP_VERSION, '5.3.10', '<')) {
    die('Your host needs to use PHP 5.3.10 or higher to run this version of Joomla!');
}

/**
 * Constant that is checked in included files to prevent direct access.
 * define() is used in the installation folder rather than "const" to not error for PHP 5.2 and lower
 */
define('_JEXEC', 1);

if (file_exists(__DIR__ . '/defines.php')) {
    include_once __DIR__ . '/defines.php';
}

if (!defined('_JDEFINES')) {
    define('JPATH_BASE', __DIR__);
    require_once JPATH_BASE . '/includes/defines.php';
}

require_once JPATH_BASE . '/includes/framework.php';

// Mark afterLoad in the profiler.
JDEBUG ? $_PROFILER->mark('afterLoad') : null;

// Instantiate the application.
$app = JFactory::getApplication('site');


$db = JFactory::getDBO();

$query = " SELECT * FROM #__virtuemart_medias";
$db->setQuery($query);

$medias = $db->loadObjectList();
$count  = 0;

$ids = array();
foreach ($medias as $media) {
    if (!file_exists($media->file_url)) {
        echo $media->file_url . " - file not found<br>\n";
        $ids[] = $media->virtuemart_media_id;
//        $query = 'DELETE FROM #__virtuemart_medias WHERE virtuemart_media_id = ' . $media->virtuemart_media_id;
//        $db->setQuery($query);
//        $db->execute();
//        $query = 'DELETE FROM #__virtuemart_product_medias WHERE virtuemart_media_id = ' . $media->virtuemart_media_id;
//        $db->setQuery($query);
//        $db->execute();

        if (ciont($ids) > 1000) {echo "deleted 1000 images<br>\n";
            $query = 'DELETE FROM #__virtuemart_medias WHERE virtuemart_media_id in (' . implode(',', $ids) . ')';
//    echo $query."\n\n\n";
//            $db->setQuery($query);
//            $db->execute();
            $query = 'DELETE FROM #__virtuemart_product_medias WHERE virtuemart_media_id (' . implode(',', $ids) . ')';
//    echo $query."\n\n\n";
//            $db->setQuery($query);
//            $db->execute();
//            $ids   = array();
        }

        $count++;
    }
}

if ($count > 0) {
    $query = 'DELETE FROM #__virtuemart_medias WHERE virtuemart_media_id in (' . implode(',', $ids) . ')';
//    echo $query."\n\n\n";
//    $db->setQuery($query);
//    $db->execute();
    $query = 'DELETE FROM #__virtuemart_product_medias WHERE virtuemart_media_id (' . implode(',', $ids) . ')';
//    echo $query."\n\n\n";
//    $db->setQuery($query);
//    $db->execute();
}
echo "deleted $count images<br>\n";