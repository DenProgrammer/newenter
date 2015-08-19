<?php
/**
 * @package     Joomla.Site
 * @subpackage  Templates.protostar
 *
 * @copyright   Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */
defined('_JEXEC') or die;

$app             = JFactory::getApplication();
$doc             = JFactory::getDocument();
$user            = JFactory::getUser();
$this->language  = $doc->language;
$this->direction = $doc->direction;

// Getting params from template
$params = $app->getTemplate(true)->params;

// Detecting Active Variables
$option   = $app->input->getCmd('option', '');
$view     = $app->input->getCmd('view', '');
$layout   = $app->input->getCmd('layout', '');
$task     = $app->input->getCmd('task', '');
$itemid   = $app->input->getCmd('Itemid', '');
$sitename = $app->get('sitename');

if ($task == "edit" || $layout == "form") {
    $fullWidth = 1;
} else {
    $fullWidth = 0;
}

// Add JavaScript Frameworks
JHtml::_('bootstrap.framework');
$doc->addScript('templates/' . $this->template . '/js/template.js');

// Add Stylesheets
$doc->addStyleSheet('templates/' . $this->template . '/css/template.css');

// Load optional RTL Bootstrap CSS
JHtml::_('bootstrap.loadCss', false, $this->direction);

// Adjusting content width
if ($this->countModules('position-7') && $this->countModules('position-8')) {
    $span = "span6";
} elseif ($this->countModules('position-7') && !$this->countModules('position-8')) {
    $span = "span9";
} elseif (!$this->countModules('position-7') && $this->countModules('position-8')) {
    $span = "span9";
} else {
    $span = "span12";
}

// Logo file or site title param
if ($this->params->get('logoFile')) {
    $logo = '<img src="' . JUri::root() . $this->params->get('logoFile') . '" alt="' . $sitename . '" />';
} elseif ($this->params->get('sitetitle')) {
    $logo = '<span class="site-title" title="' . $sitename . '">' . htmlspecialchars($this->params->get('sitetitle')) . '</span>';
} else {
    $logo = '<span class="site-title" title="' . $sitename . '">' . $sitename . '</span>';
}
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" dir="<?php echo $this->direction; ?>">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <jdoc:include type="head" />
        <?php // Use of Google Font  ?>
        <?php if ($this->params->get('googleFont')) : ?>
            <link href='//fonts.googleapis.com/css?family=<?php echo $this->params->get('googleFontName'); ?>' rel='stylesheet' type='text/css' />
            <style type="text/css">
                h1,h2,h3,h4,h5,h6,.site-title{
                    font-family: '<?php echo str_replace('+', ' ', $this->params->get('googleFontName')); ?>', sans-serif;
                }
            </style>
        <?php endif; ?>
        <?php // Template color  ?>
        <?php if ($this->params->get('templateColor')) : ?>
            <style type="text/css">
                body.site
                {
                    border-top: 3px solid <?php echo $this->params->get('templateColor'); ?>;
                    background-color: <?php echo $this->params->get('templateBackgroundColor'); ?>
                }
                a
                {
                    color: <?php echo $this->params->get('templateColor'); ?>;
                }
                .navbar-inner, .nav-list > .active > a, .nav-list > .active > a:hover, .dropdown-menu li > a:hover, .dropdown-menu .active > a, .dropdown-menu .active > a:hover, .nav-pills > .active > a, .nav-pills > .active > a:hover,
                .btn-primary
                {
                    background: <?php echo $this->params->get('templateColor'); ?>;
                }
                .navbar-inner
                {
                    -moz-box-shadow: 0 1px 3px rgba(0, 0, 0, .25), inset 0 -1px 0 rgba(0, 0, 0, .1), inset 0 30px 10px rgba(0, 0, 0, .2);
                    -webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, .25), inset 0 -1px 0 rgba(0, 0, 0, .1), inset 0 30px 10px rgba(0, 0, 0, .2);
                    box-shadow: 0 1px 3px rgba(0, 0, 0, .25), inset 0 -1px 0 rgba(0, 0, 0, .1), inset 0 30px 10px rgba(0, 0, 0, .2);
                }
            </style>
        <?php endif; ?>
        <!--[if lt IE 9]>
                <script src="<?php echo $this->baseurl; ?>/media/jui/js/html5.js"></script>
        <![endif]-->

        <script type="text/javascript" src="templates/jblank/js/jquery.myplugins.js"></script>
        <script type="text/javascript">
            jQuery(function($) {
                $('body').scrollBtn(options = $.extend({"posH": "right", "btnText2": "Вниз", "btnText": "Вверх"}));

                $('input[name=delcoocie]').click(function() {
                    jQuery.get('index.php?option=com_virtuemart&nosef=1&view=cart&task=delete&format=json', {}, function() {
                        document.location = "index.php";
                    });
                });
            });

        </script>
    </head>

    <body class="site <?php
    echo $option
    . ' view-' . $view
    . ($layout ? ' layout-' . $layout : ' no-layout')
    . ($task ? ' task-' . $task : ' no-task')
    . ($itemid ? ' itemid-' . $itemid : '')
    . ($params->get('fluidContainer') ? ' fluid' : '');
    ?>">
        <div id="main">
            <div id="header_top">
                <jdoc:include type="modules" name="position-0" style="xhtml" />
            </div>
            <div id="header_block">
                <div id="header_block_div">
                    <jdoc:include type="modules" name="position-1" style="xhtml" />

                </div>
                <div style="clear:both"></div>
                <div id="mainmenu_block">
                    <jdoc:include type="modules" name="position-2" style="xhtml" />
                </div>
            </div>
            <div id="wrapper">
                <div id="leftcol">
                    <jdoc:include type="modules" name="position-3" style="xhtml" />
                </div>
                <div id="rightcol">
                    <jdoc:include type="modules" name="position-6" style="xhtml" />
                </div>
                <div id="content">
                    <jdoc:include type="modules" name="position-4" style="xhtml" />
                    <jdoc:include type="component" />
                    <jdoc:include type="modules" name="position-5" style="xhtml" />
                </div>
            </div>
            <div style="clear:both;">&nbsp;</div>
        </div>
        <div id="footer">
            <jdoc:include type="modules" name="footer" style="xhtml" />
        </div>
    </body>
</html>
