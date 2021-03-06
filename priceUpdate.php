<?php

/**
 * Constant that is checked in included files to prevent direct access.
 * define() is used in the installation folder rather than "const" to not error for PHP 5.2 and lower
 */
define('_JEXEC', 1);

if (file_exists(__DIR__.'/defines.php')) {
    include_once __DIR__.'/defines.php';
}

if (!defined('_JDEFINES')) {
    define('JPATH_BASE', __DIR__);
    require_once JPATH_BASE.'/includes/defines.php';
}

require_once JPATH_BASE.'/includes/framework.php';

define('AC_DIR', 'administrator/components/com_import');

require_once( AC_DIR.'/helpers/PriceUpdate.php');

$priceUpdate = new PriceUpdate();

$priceUpdate->execute();
