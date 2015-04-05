var CodeMirrorConfig=window.CodeMirrorConfig||{};var CodeMirror=(function(){function f(g,i){for(var h in i){if(!g.hasOwnProperty(h)){g[h]=i[h]}}}function d(j,h){for(var g=0;g<j.length;g++){h(j[g])}}f(CodeMirrorConfig,{stylesheet:"",path:"",parserfile:[],basefiles:["base-min.js"],iframeClass:"fileedit",passDelay:200,passTime:50,lineNumberDelay:200,lineNumberTime:50,continuousScanning:false,saveFunction:null,onChange:null,undoDepth:50,undoDelay:800,disableSpellcheck:true,textWrapping:true,readOnly:false,width:"",height:"300px",autoMatchParens:false,parserConfig:null,tabMode:"indent",reindentOnLoad:false,activeTokens:null,cursorActivity:null,lineNumbers:true,indentUnit:2,domain:null});function b(h){var j=document.createElement("DIV"),g=document.createElement("DIV");j.style.position="absolute";j.style.height="100%";if(j.style.setExpression){try{j.style.setExpression("height","this.previousSibling.offsetHeight + 'px'")}catch(i){}}j.style.top="0px";j.style.overflow="hidden";h.appendChild(j);g.className="CodeMirror-line-numbersyj";j.appendChild(g);return j}function e(g){if(typeof g.parserfile=="string"){g.parserfile=[g.parserfile]}if(typeof g.stylesheet=="string"){g.stylesheet=[g.stylesheet]}var h=['<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html><head>'];h.push('<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>');d(g.stylesheet,function(i){h.push('<link rel="stylesheet" type="text/css" href="'+i+'"/>')});d(g.basefiles.concat(g.parserfile),function(i){h.push('<script type="text/javascript" src="'+g.path+i+'"><\/script>')});h.push('</head><body style="border-width: 0;" class="editbox" spellcheck="'+(g.disableSpellcheck?"false":"true")+'"></body></html>');return h.join("")}var c=document.selection&&window.ActiveXObject&&/MSIE/.test(navigator.userAgent);function a(h,i){if(i.dumbTabs){i.tabMode="spaces"}else{if(i.normalTab){i.tabMode="default"}}this.options=i=i||{};f(i,CodeMirrorConfig);var j=this.frame=document.createElement("IFRAME");if(i.iframeClass){j.className=i.iframeClass}j.frameBorder=0;j.style.border="0";j.style.width="100%";j.style.height="100%";j.style.display="block";var k=this.wrapping=document.createElement("DIV");k.style.position="relative";k.className="CodeMirror-wrapping";k.style.width=i.width;k.style.height=i.height;var g=this.textareaHack=document.createElement("TEXTAREA");k.appendChild(g);g.style.position="absolute";g.style.left="-10000px";g.style.width="10px";j.CodeMirror=this;if(i.domain&&c){this.html=e(i);j.src="javascript:(function(){document.open();"+(i.domain?'document.domain="'+i.domain+'";':"")+"document.write(window.frameElement.CodeMirror.html);document.close();})()"}else{j.src="javascript:false"}if(h.appendChild){h.appendChild(k)}else{h(k)}k.appendChild(j);if(i.lineNumbers){this.lineNumbers=b(k)}this.win=j.contentWindow;if(!i.domain||!c){this.win.document.open();this.win.document.write(e(i));this.win.document.close()}}a.prototype={init:function(){if(this.options.initCallback){this.options.initCallback(this)}if(this.options.lineNumbers){this.activateLineNumbers()}if(this.options.reindentOnLoad){this.reindent()}},getCode:function(){return this.editor.getCode()},setCode:function(g){this.editor.importCode(g)},selection:function(){this.focusIfIE();return this.editor.selectedText()},reindent:function(){this.editor.reindent()},reindentSelection:function(){this.focusIfIE();this.editor.reindentSelection(null)},focusIfIE:function(){if(this.win.select.ie_selection){this.focus()}},focus:function(){this.win.focus();if(this.editor.selectionSnapshot){this.win.select.setBookmark(this.win.document.body,this.editor.selectionSnapshot)}},replaceSelection:function(g){this.focus();this.editor.replaceSelection(g);return true},replaceChars:function(h,i,g){this.editor.replaceChars(h,i,g)},getSearchCursor:function(h,g,i){return this.editor.getSearchCursor(h,g,i)},undo:function(){this.editor.history.undo()},redo:function(){this.editor.history.redo()},historySize:function(){return this.editor.history.historySize()},clearHistory:function(){this.editor.history.clear()},grabKeys:function(h,g){this.editor.grabKeys(h,g)},ungrabKeys:function(){this.editor.ungrabKeys()},setParser:function(g){this.editor.setParser(g)},setSpellcheck:function(g){this.win.document.body.spellcheck=g},setStylesheet:function(m){if(typeof m==="string"){m=[m]}var i={};var k={};var h=this.win.document.getElementsByTagName("link");for(var g=0,l;l=h[g];g++){if(l.rel.indexOf("stylesheet")!==-1){for(var n=0;n<m.length;n++){var j=m[n];if(l.href.substring(l.href.length-j.length)===j){i[l.href]=true;k[j]=true}}}}for(var g=0,l;l=h[g];g++){if(l.rel.indexOf("stylesheet")!==-1){l.disabled=!(l.href in i)}}for(var n=0;n<m.length;n++){var j=m[n];if(!(j in k)){var l=this.win.document.createElement("link");l.rel="stylesheet";l.type="text/css";l.href=j;this.win.document.getElementsByTagName("head")[0].appendChild(l)}}},setTextWrapping:function(g){if(g==this.options.textWrapping){return}this.win.document.body.style.whiteSpace=g?"":"nowrap";this.options.textWrapping=g;if(this.lineNumbers){this.setLineNumbers(false);this.setLineNumbers(true)}},setIndentUnit:function(g){this.win.indentUnit=g},setUndoDepth:function(g){this.editor.history.maxDepth=g},setTabMode:function(g){this.options.tabMode=g},setLineNumbers:function(g){if(g&&!this.lineNumbers){this.lineNumbers=b(this.wrapping);this.activateLineNumbers()}else{if(!g&&this.lineNumbers){this.wrapping.removeChild(this.lineNumbers);this.wrapping.style.marginLeft="";this.lineNumbers=null}}},cursorPosition:function(g){this.focusIfIE();return this.editor.cursorPosition(g)},firstLine:function(){return this.editor.firstLine()},lastLine:function(){return this.editor.lastLine()},nextLine:function(g){return this.editor.nextLine(g)},prevLine:function(g){return this.editor.prevLine(g)},lineContent:function(g){return this.editor.lineContent(g)},setLineContent:function(g,h){this.editor.setLineContent(g,h)},removeLine:function(g){this.editor.removeLine(g)},insertIntoLine:function(h,g,i){this.editor.insertIntoLine(h,g,i)},selectLines:function(j,g,i,h){this.win.focus();this.editor.selectLines(j,g,i,h)},nthLine:function(h){var g=this.firstLine();for(;h>1&&g!==false;h--){g=this.nextLine(g)}return g},lineNumber:function(g){var h=0;while(g!==false){h++;g=this.prevLine(g)}return h},jumpToLine:function(g){if(typeof g=="number"){g=this.nthLine(g)}this.selectLines(g,0);this.win.focus()},currentLine:function(){return this.lineNumber(this.cursorLine())},cursorLine:function(){return this.cursorPosition().line},activateLineNumbers:function(){var i=this.frame,p=i.contentWindow,q=p.document,m=q.body,r=this.lineNumbers,n=r.firstChild,s=this;var t=null;function h(){if(i.offsetWidth==0){return}for(var u=i;u.parentNode;u=u.parentNode){}if(!r.parentNode||u!=document||!p.Editor){try{l()}catch(v){}clearInterval(g);return}if(r.offsetWidth!=t){t=r.offsetWidth;r.style.left="-"+(i.parentNode.style.marginLeft=t+"px")}}function j(){r.scrollTop=m.scrollTop||q.documentElement.scrollTop||0}var l=function(){};h();var g=setInterval(h,500);function o(){var y=1,w;function x(){var A=50+Math.max(m.offsetHeight,Math.max(i.offsetHeight,m.scrollHeight||0));var z=new Date().getTime()+s.options.lineNumberTime;while(n.offsetHeight<A&&(!n.firstChild||n.offsetHeight)){n.appendChild(document.createElement("DIV"));n.lastChild.innerHTML=y++;if(new Date().getTime()>z){if(w){clearTimeout(w)}w=setTimeout(x,s.options.lineNumberDelay);break}}j()}var u=p.addEventHandler(p,"scroll",x,true),v=p.addEventHandler(p,"resize",x,true);l=function(){u();v();if(w){clearTimeout(w)}};x()}function k(){var x,A,z,D;function B(F){if(!A){A=n.appendChild(document.createElement("pre"))}A.innerHTML=F;D=A.offsetHeight+A.offsetTop;A=A.nextSibling}function E(){if(!n.parentNode||n.parentNode!=s.lineNumbers){return}var F=new Date().getTime()+s.options.lineNumberTime;while(x){B(z++);for(;x&&!p.isBR(x);x=x.nextSibling){var G=x.offsetTop+x.offsetHeight;while(n.offsetHeight&&G-3>D){B("&nbsp;")}}if(x){x=x.nextSibling}if(new Date().getTime()>F){w=setTimeout(E,s.options.lineNumberDelay);return}}var H=50+Math.max(m.offsetHeight,Math.max(i.offsetHeight,m.scrollHeight||0));while(A||(n.offsetHeight<H&&(!n.firstChild||n.offsetHeight))){B(z++)}j()}function v(){j();x=m.firstChild;A=n.firstChild;D=0;z=1;E()}v();var w=null;function y(){if(w){clearTimeout(w)}if(s.editor.allClean()){v()}else{w=setTimeout(y,200)}}s.updateNumbers=y;var C=p.addEventHandler(p,"scroll",j,true),u=p.addEventHandler(p,"resize",y,true);l=function(){if(w){clearTimeout(w)}if(s.updateNumbers==y){s.updateNumbers=null}C();u()}}(this.options.textWrapping?k:o)()}};a.InvalidLineHandle={toString:function(){return"CodeMirror.InvalidLineHandle"}};a.replace=function(g){if(typeof g=="string"){g=document.getElementById(g)}return function(h){g.parentNode.replaceChild(h,g)}};a.fromTextArea=function(i,h){if(typeof i=="string"){i=document.getElementById(i)}h=h||{};if(i.style.width&&h.width==null){h.width=i.style.width}if(i.style.height&&h.height==null){h.height=i.style.height}if(h.content==null){h.content=i.value}if(i.form){function g(){i.value=k.getCode()}if(typeof i.form.addEventListener=="function"){i.form.addEventListener("submit",g,false)}else{i.form.attachEvent("onsubmit",g)}}function j(l){if(i.nextSibling){i.parentNode.insertBefore(l,i.nextSibling)}else{i.parentNode.appendChild(l)}}i.style.display="none";var k=new a(j,h);return k};a.isProbablySupported=function(){var g;if(window.opera){return Number(window.opera.version())>=9.52}else{if(/Apple Computers, Inc/.test(navigator.vendor)&&(g=navigator.userAgent.match(/Version\/(\d+(?:\.\d+)?)\./))){return Number(g[1])>=3}else{if(document.selection&&window.ActiveXObject&&(g=navigator.userAgent.match(/MSIE (\d+(?:\.\d*)?)\b/))){return Number(g[1])>=6}else{if(g=navigator.userAgent.match(/gecko\/(\d{8})/i)){return Number(g[1])>=20050901}else{if(g=navigator.userAgent.match(/AppleWebKit\/(\d+)/)){return Number(g[1])>=525}else{return null}}}}}};return a})();