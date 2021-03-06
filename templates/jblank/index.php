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
$doc->addScript('/templates/'.$this->template.'/js/jquery.myplugins.js');
$doc->addScript('/templates/'.$this->template.'/js/template.js');

// Add Stylesheets
$doc->addStyleSheet('/templates/'.$this->template.'/css/template.css');

// Load optional RTL Bootstrap CSS
JHtml::_('bootstrap.loadCss', false, $this->direction);

$client = new JWebClient();

// Logo file or site title param
if ($this->params->get('logoFile')) {
    $logo = '<img src="'.JUri::root().$this->params->get('logoFile').'" alt="'.$sitename.'" />';
} elseif ($this->params->get('sitetitle')) {
    $logo = '<span class="site-title" title="'.$sitename.'">'.htmlspecialchars($this->params->get('sitetitle')).'</span>';
} else {
    $logo = '<span class="site-title" title="'.$sitename.'">'.$sitename.'</span>';
}
?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $this->language; ?>" lang="<?php echo $this->language; ?>" dir="<?php echo $this->direction; ?>">
    <head>
        <jdoc:include type="head" />
        <link rel="stylesheet" media="screen, projection" href="/templates/jblank/css/drift-basic.css" />
        <script type="text/javascript" src="/modules/mod_simpleform2/ajax/jquery.form.js"></script>
        <script type="text/javascript" src="/modules/mod_simpleform2/ajax/jquery.simpleform.js"></script>
        <script src="/templates/jblank/js/Drift.min.js"></script>
    </head>

    <body class="site <?php
    echo $option
    .' view-'.$view
    .($layout ? ' layout-'.$layout : ' no-layout')
    .($task ? ' task-'.$task : ' no-task')
    .($itemid ? ' itemid-'.$itemid : '')
    .($params->get('fluidContainer') ? ' fluid' : '');
    ?>">

        <!-- Yandex.Metrika counter -->
        <script type="text/javascript">
            (function (d, w, c) {
                (w[c] = w[c] || []).push(function () {
                    try {
                        w.yaCounter34077300 = new Ya.Metrika({id: 34077300,
                            webvisor: true,
                            clickmap: true,
                            accurateTrackBounce: true});
                    } catch (e) {
                    }
                });

                var n = d.getElementsByTagName("script")[0],
                        s = d.createElement("script"),
                        f = function () {
                            n.parentNode.insertBefore(s, n);
                        };
                s.type = "text/javascript";
                s.async = true;
                s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

                if (w.opera == "[object Opera]") {
                    d.addEventListener("DOMContentLoaded", f, false);
                } else {
                    f();
                }
            })(document, window, "yandex_metrika_callbacks");
        </script>
        <noscript><div><img src="//mc.yandex.ru/watch/34077300" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
        <!-- /Yandex.Metrika counter -->

        <div id="main">
            <div id="header_top">
                <jdoc:include type="modules" name="position-0" style="xhtml" />
            </div>
            <div id="header_block">
                <div id="header_block_div">
                    <?php if ($client->mobile === false) { ?>
                        <jdoc:include type="modules" name="position-1" style="xhtml" />
                    <?php } else { ?>
                        <jdoc:include type="modules" name="position-11" style="xhtml" />
                    <?php } ?>
                    <jdoc:include type="modules" name="position-10" style="xhtml" />
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

        <center> <!-- WWW.NET.KG , code for http://www.enter.kg --> <noscript>
 <a href='http://www.net.kg/stat.php?id=545&amp;fromsite=545' target='_blank'><img
  src="http://www.net.kg/img.php?id=545" border='0' alt='WWW.NET.KG' width='88'
  height='31' /></a>
</noscript> <!-- /WWW.NET.KG --> </center>
    </body>
</html>