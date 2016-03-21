/* JCE Editor - 2.5.15 | 10 March 2016 | http://www.joomlacontenteditor.net | Copyright (C) 2006 - 2016 Ryan Demmer. All rights reserved | GNU/GPL Version 2 or later - http://www.gnu.org/licenses/gpl-2.0.html */
JCEMediaBox={Popup:{addons:{},setAddons:function(n,o){if(typeof this.addons[n]=='undefined'){this.addons[n]={};}
$.extend(this.addons[n],o);},getAddons:function(n){if(n){return this.addons[n];}
return this.addons;},getAddon:function(v,n){var t=this,cp=false,r;var addons=this.getAddons(n);$.each(addons,function(addon,o){var fn=o[addon]||function(){};r=fn.call(this,v);if(typeof r!='undefined'){cp=r;}});return cp;}},trim:function(s){return $.trim(s);},setDimensions:function(w,h){$.Plugin.setDimensions(w,h,'jcemediabox_popup_');}};WFPopups.addPopup('jcemediabox',{params:{'attribute':'data-mediabox','popup_group':'','popup_icon':1,'popup_icon_position':'','popup_autopopup':'','popup_hide':0,'popup_mediatype':''},setup:function(){var self=this;$('#jcemediabox_popup_icon').change(function(){self.setIcon();});$('span.add','#jcemediabox_popup_params').click(function(){var $item=$('li:first','#jcemediabox_popup_params').clone().appendTo('#jcemediabox_popup_params');$('input',$item).val('');$('span.add',$item).hide();$('span.remove',$item).css('display','inline-block').click(function(){$item.remove();});});$.each(this.params,function(k,v){if(k==='popup_icon_position'){v=v.replace('icon-','zoom-');}
$('#jcemediabox_'+k).val(v);});},check:function(n){return/jce(popup|_popup|lightbox)/.test(n.className);},getMediaType:function(n){var mt;switch(n.type){case'image/gif':case'image/jpeg':case'image/png':case'image/*':case'image':mt='image';break;case'iframe':mt='iframe';break;case'director':case'application/x-director':mt='application/x-director';break;case'windowsmedia':case'mplayer':case'application/x-mplayer2':mt='application/x-mplayer2';break;case'quicktime':case'video/quicktime':mt='video/quicktime';break;case'real':case'realaudio':case'audio/x-pn-realaudio-plugin':mt='audio/x-pn-realaudio-plugin';break;case'divx':case'video/divx':mt='video/divx';break;case'flash':case'application/x-shockwave-flash':mt='application/x-shockwave-flash';break;case'ajax':case'text/xml':case'text/html':mt='text/html';break;}
if(!mt&&n.href){JCEMediaBox.options={popup:{google_viewer:0,pdfjs:0}};var o=JCEMediaBox.Popup.getAddon(n.href);if(o&&o.type){mt=o.type;}}
return mt||n.type||'';},getImageType:function(s){var e=/\.(jp(eg|g)|png|bmp|gif|tiff)$/.exec(s);if(e){if(e[1]==="jpg"){e[1]="jpeg";}
return"image/"+e[1];}
return"image/jpeg";},remove:function(n){var ed=tinyMCEPopup.editor;$.each(['jcepopup','jcelightbox','jcebox','icon-left','icon-right','icon-top-left','icon-top-right','icon-bottom-left','icon-bottom-right','zoom-left','zoom-right','zoom-top-left','zoom-top-right','zoom-bottom-left','zoom-bottom-right','noicon','noshow','autopopup-single','autopopup-multiple'],function(i,v){ed.dom.removeClass(n,v);});ed.dom.setAttrib(n,'data-mediabox',null);ed.dom.setAttrib(n,'data-mediabox-title',null);ed.dom.setAttrib(n,'data-mediabox-caption',null);ed.dom.setAttrib(n,'data-mediabox-group',null);},convertData:function(s){var a=[];function trim(s){return s.replace(/:"([^"]+)"/,function(a,b){return':"'+b.replace(/^\s+|\s+$/,'').replace(/\s*::\s*/,'::')+'"';});}
if(/^{[\w\W]+}$/.test(s)){return $.parseJSON(trim(s));}
if(/\w+\[[^\]]+\]/.test(s)){var data={};tinymce.each(tinymce.explode(s,';'),function(p){var args=p.match(/([\w-]+)\[(.*)\]$/);if(args&&args.length===3){data[args[1]]=args[2];}});return data;}},getAttributes:function(n,index){var ed=tinyMCEPopup.editor,data={},rv,v;index=index||0;index=index||0;var title=ed.dom.getAttrib(n,'title');var rel=ed.dom.getAttrib(n,'rel');var icon=/noicon/g.test(n.className);var hide=/noshow/g.test(n.className);if(/(autopopup(.?|-single|-multiple))/.test(n.className)){v=/autopopup-multiple/.test(n.className)?'autopopup-multiple':'autopopup-single';$('#jcemediabox_popup_autopopup').val(v);}
$('#jcemediabox_popup_icon').val(icon?0:1);$('#jcemediabox_popup_icon_position').prop('disabled',icon);$('#jcemediabox_popup_hide').val(hide?1:0);if(s=/(zoom|icon)-(top-right|top-left|bottom-right|bottom-left|left|right)/.exec(n.className)){var v=s[0];if(v){v=v.replace('icon-','zoom-');$('#jcemediabox_popup_icon_position').val(v);}}
var relRX=/(\w+|alternate|stylesheet|start|next|prev|contents|index|glossary|copyright|chapter|section|subsection|appendix|help|bookmark|nofollow|licence|tag|friend)\s+?/g;var json=ed.dom.getAttrib(n,'data-json')||ed.dom.getAttrib(n,'data-mediabox');if(json){data=this.convertData(json);}
if(rel&&/\w+\[.*\]/.test(rel)){var ra='';if(rv=relRX.exec(rel)){ra=rv[1];rel=rel.replace(relRX,'');}
if(/^\w+\[/.test((rel))){data=this.convertData($.trim(rel))||{};data.rel=ra;}}else{var group=$.trim(rel.replace(relRX,''));$('#jcemediabox_popup_group').val(group);}
var params=[];if($.isEmptyObject(data)){$.each(ed.dom.getAttribs(n),function(i,at){var name=at.name;if(name&&name.indexOf('data-mediabox-')!==-1){var k=name.replace('data-mediabox-','');data[k]=ed.dom.getAttrib(n,name);}});}
if(data.title&&/::/.test(data.title)){var parts=data.title.split('::');if(parts.length>1){data.caption=parts[1];}
data.title=parts[0];}
$.each(data,function(k,v){if($('#jcemediabox_popup_'+k).get(0)&&v!==""){if(k=='title'||k=='caption'||k=='group'){v=decodeURIComponent(v);}
v=tinymce.DOM.decode(v);if(k=='title'||k=='caption'){$('input[name^="jcemediabox_popup_'+k+'"]').eq(index).val(v);}else{$('#jcemediabox_popup_'+k).val(v);}
delete data[k];}});var x=0;$.each(data,function(k,v){if(v!==''){try{v=decodeURIComponent(v);}catch(e){}
if(x==0){$('li:first input.name','#jcemediabox_popup_params').val(k);$('li:first input.value','#jcemediabox_popup_params').val(v);}else{var $item=$('li:first','#jcemediabox_popup_params').clone().appendTo('#jcemediabox_popup_params');$('input.name',$item).val(k);$('input.value',$item).val(v);$('span.add',$item).hide();$('span.remove').css('display','inline-block');}}
x++;});$('#jcemediabox_popup_mediatype').val(this.getMediaType(n));$.extend(data,{src:ed.dom.getAttrib(n,'href'),type:ed.dom.getAttrib(n,'type')||''});return data;},setAttributes:function(n,args,index){var self=this,ed=tinyMCEPopup.editor;index=index||0;this.remove(n);index=index||0;ed.dom.addClass(n,'jcepopup');var auto=$('#jcemediabox_popup_autopopup').val();if(auto){ed.dom.addClass(n,auto);}
var data={};if(args.title){ed.dom.setAttrib(n,'title',args.title);delete args.title;}
tinymce.each(['group','width','height','title','caption'],function(k){var v;if(k=='title'||k=='caption'){v=$('input[name^="jcemediabox_popup_'+k+'"]').eq(index).val();}else{v=$('#jcemediabox_popup_'+k).val();}
if(v==''||v==null||typeof v==='undefined'){if(args[k]){v=args[k];}else{return;}}
data[k]=v;});$('li','#jcemediabox_popup_params').each(function(){var k=$('input.name',this).val();var v=$('input.value',this).val();if(k!==''&&v!==''){data[k]=v;}});$.extend(data,args.data||{});var mt=$('#jcemediabox_popup_mediatype').val()||n.type||data.type||'';if(mt=="image"){mt=this.getImageType(n.href);}
ed.dom.setAttrib(n,'type',mt);if(data.type){delete data.type;}
var rel=ed.dom.getAttrib(n,'rel','');if(rel){rel=rel.replace(/([a-z0-9]+)(\[([^\]]+)\]);?/gi,'');}
$.each(data,function(k,v){ed.dom.setAttrib(n,'data-mediabox-'+k,ed.dom.encode(v));});ed.dom.setAttrib(n,'rel',$.trim(rel));if($('#jcemediabox_popup_icon').val()==0){ed.dom.addClass(n,'noicon');}else{ed.dom.addClass(n,$('#jcemediabox_popup_icon_position').val());}
if($('#jcemediabox_popup_hide').val()==1){ed.dom.addClass(n,'noshow');}
ed.dom.setAttrib(n,'target','_blank');},setIcon:function(){var v=$('#jcemediabox_popup_icon').val();if(parseInt(v)){$('#jcemediabox_popup_icon_position').removeAttr('disabled');}else{$('#jcemediabox_popup_icon_position').attr('disabled','disabled');}},onSelect:function(){},onSelectFile:function(args){$.each(args,function(k,v){$('#jcemediabox_popup_'+k).val(v);});}});