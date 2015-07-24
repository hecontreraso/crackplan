/*!
 * jquery-timepicker v1.8.1 - A jQuery timepicker plugin inspired by Google Calendar. It supports both mouse and keyboard navigation.
 * Copyright (c) 2015 Jon Thornton - http://jonthornton.github.com/jquery-timepicker/
 * License: MIT
 */
!function(e){"object"==typeof exports&&exports&&"object"==typeof module&&module&&module.exports===exports?e(require("jquery")):"function"==typeof define&&define.amd?define(["jquery"],e):e(jQuery)}(function(e){function t(e){var i=e[0];return i.offsetWidth>0&&i.offsetHeight>0}function r(i){if(i.minTime&&(i.minTime=b(i.minTime)),i.maxTime&&(i.maxTime=b(i.maxTime)),i.durationTime&&"function"!=typeof i.durationTime&&(i.durationTime=b(i.durationTime)),"now"==i.scrollDefault)i.scrollDefault=function(){return i.roundingFunction(b(new Date),i)};else if(i.scrollDefault&&"function"!=typeof i.scrollDefault){var t=i.scrollDefault;i.scrollDefault=function(){return i.roundingFunction(b(t),i)}}else i.minTime&&(i.scrollDefault=function(){return i.roundingFunction(i.minTime,i)});if("string"===e.type(i.timeFormat)&&i.timeFormat.match(/[gh]/)&&(i._twelveHourTime=!0),i.showOnFocus===!1&&-1!=i.showOn.indexOf("focus")&&i.showOn.splice(i.showOn.indexOf("focus"),1),i.disableTimeRanges.length>0){for(var r in i.disableTimeRanges)i.disableTimeRanges[r]=[b(i.disableTimeRanges[r][0]),b(i.disableTimeRanges[r][1])];i.disableTimeRanges=i.disableTimeRanges.sort(function(e,i){return e[0]-i[0]});for(var r=i.disableTimeRanges.length-1;r>0;r--)i.disableTimeRanges[r][0]<=i.disableTimeRanges[r-1][1]&&(i.disableTimeRanges[r-1]=[Math.min(i.disableTimeRanges[r][0],i.disableTimeRanges[r-1][0]),Math.max(i.disableTimeRanges[r][1],i.disableTimeRanges[r-1][1])],i.disableTimeRanges.splice(r,1))}return i}function n(i){var t=i.data("timepicker-settings"),r=i.data("timepicker-list");if(r&&r.length&&(r.remove(),i.data("timepicker-list",!1)),t.useSelect){r=e("<select />",{"class":"ui-timepicker-select"});var n=r}else{r=e("<ul />",{"class":"ui-timepicker-list"});var n=e("<div />",{"class":"ui-timepicker-wrapper",tabindex:-1});n.css({display:"none",position:"absolute"}).append(r)}if(t.noneOption)if(t.noneOption===!0&&(t.noneOption=t.useSelect?"Time...":"None"),e.isArray(t.noneOption)){for(var o in t.noneOption)if(parseInt(o,10)==o){var c=a(t.noneOption[o],t.useSelect);r.append(c)}}else{var c=a(t.noneOption,t.useSelect);r.append(c)}if(t.className&&n.addClass(t.className),(null!==t.minTime||null!==t.durationTime)&&t.showDuration){{"function"==typeof t.step?"function":t.step}n.addClass("ui-timepicker-with-duration"),n.addClass("ui-timepicker-step-"+t.step)}var u=t.minTime;"function"==typeof t.durationTime?u=b(t.durationTime()):null!==t.durationTime&&(u=t.durationTime);var m=null!==t.minTime?t.minTime:0,d=null!==t.maxTime?t.maxTime:m+y-1;m>d&&(d+=y),d===y-1&&"string"===e.type(t.timeFormat)&&t.show2400&&(d=y);var h=t.disableTimeRanges,g=0,w=h.length,x=t.step;"function"!=typeof x&&(x=function(){return t.step});for(var o=m,C=0;d>=o;C++,o+=60*x(C)){var D=o,O=T(D,t);if(t.useSelect){var R=e("<option />",{value:O});R.text(O)}else{var R=e("<li />");R.data("time",86400>=D?D:D%86400),R.text(O)}if((null!==t.minTime||null!==t.durationTime)&&t.showDuration){var S=v(o-u,t.step);if(t.useSelect)R.text(R.text()+" ("+S+")");else{var M=e("<span />",{"class":"ui-timepicker-duration"});M.text(" ("+S+")"),R.append(M)}}w>g&&(D>=h[g][1]&&(g+=1),h[g]&&D>=h[g][0]&&D<h[g][1]&&(t.useSelect?R.prop("disabled",!0):R.addClass("ui-timepicker-disabled"))),r.append(R)}if(n.data("timepicker-input",i),i.data("timepicker-list",n),t.useSelect)i.val()&&r.val(s(b(i.val()),t)),r.on("focus",function(){e(this).data("timepicker-input").trigger("showTimepicker")}),r.on("blur",function(){e(this).data("timepicker-input").trigger("hideTimepicker")}),r.on("change",function(){f(i,e(this).val(),"select")}),f(i,r.val(),"initial"),i.hide().after(r);else{var F=t.appendTo;"string"==typeof F?F=e(F):"function"==typeof F&&(F=F(i)),F.append(n),p(i,r),r.on("mousedown","li",function(){i.off("focus.timepicker"),i.on("focus.timepicker-ie-hack",function(){i.off("focus.timepicker-ie-hack"),i.on("focus.timepicker",H.show)}),l(i)||i[0].focus(),r.find("li").removeClass("ui-timepicker-selected"),e(this).addClass("ui-timepicker-selected"),k(i)&&(i.trigger("hideTimepicker"),r.on("mouseup.timepicker","li",function(){r.off("mouseup.timepicker"),n.hide()}))})}}function a(i,t){var r,n,a;return"object"==typeof i?(r=i.label,n=i.className,a=i.value):"string"==typeof i?r=i:e.error("Invalid noneOption value"),t?e("<option />",{value:a,"class":n,text:r}):e("<li />",{"class":n,text:r}).data("time",a)}function s(e,i){return e=i.roundingFunction(e,i),null!==e?T(e,i):void 0}function o(){return new Date(1970,1,1,0,0,0)}function c(i){var t=e(i.target),r=t.closest(".ui-timepicker-input");0===r.length&&0===t.closest(".ui-timepicker-wrapper").length&&(H.hide(),e(document).unbind(".ui-timepicker"),e(window).unbind(".ui-timepicker"))}function l(e){var i=e.data("timepicker-settings");return(window.navigator.msMaxTouchPoints||"ontouchstart"in document)&&i.disableTouchKeyboard}function u(i,t,r){if(!r&&0!==r)return!1;var n=i.data("timepicker-settings"),a=!1,r=n.roundingFunction(r,n);return t.find("li").each(function(i,t){var n=e(t);if("number"==typeof n.data("time"))return n.data("time")==r?(a=n,!1):void 0}),a}function p(e,i){i.find("li").removeClass("ui-timepicker-selected");var t=b(d(e),e.data("timepicker-settings"));if(null!==t){var r=u(e,i,t);if(r){var n=r.offset().top-i.offset().top;(n+r.outerHeight()>i.outerHeight()||0>n)&&i.scrollTop(i.scrollTop()+r.position().top-r.outerHeight()),r.addClass("ui-timepicker-selected")}}}function m(i,t){if(""!==this.value&&"timepicker"!=t){var r=e(this);if(!r.is(":focus")||i&&"change"==i.type){var n=r.data("timepicker-settings"),a=b(this.value,n);if(null===a)return void r.trigger("timeFormatError");var s=!1;null!==n.minTime&&a<n.minTime?s=!0:null!==n.maxTime&&a>n.maxTime&&(s=!0),e.each(n.disableTimeRanges,function(){return a>=this[0]&&a<this[1]?(s=!0,!1):void 0}),n.forceRoundTime&&(a=n.roundingFunction(a,n));var o=T(a,n);s?f(r,o,"error")&&r.trigger("timeRangeError"):f(r,o)}}}function d(e){return e.is("input")?e.val():e.data("ui-timepicker-value")}function f(e,i,t){if(e.is("input")){e.val(i);var r=e.data("timepicker-settings");r.useSelect&&"select"!=t&&"initial"!=t&&e.data("timepicker-list").val(s(b(i),r))}return e.data("ui-timepicker-value")!=i?(e.data("ui-timepicker-value",i),"select"==t?e.trigger("selectTime").trigger("changeTime").trigger("change","timepicker"):"error"!=t&&e.trigger("changeTime"),!0):(e.trigger("selectTime"),!1)}function h(i){var r=e(this),n=r.data("timepicker-list");if(!n||!t(n)){if(40!=i.keyCode)return!0;H.show.call(r.get(0)),n=r.data("timepicker-list"),l(r)||r.focus()}switch(i.keyCode){case 13:return k(r)&&H.hide.apply(this),i.preventDefault(),!1;case 38:var a=n.find(".ui-timepicker-selected");return a.length?a.is(":first-child")||(a.removeClass("ui-timepicker-selected"),a.prev().addClass("ui-timepicker-selected"),a.prev().position().top<a.outerHeight()&&n.scrollTop(n.scrollTop()-a.outerHeight())):(n.find("li").each(function(i,t){return e(t).position().top>0?(a=e(t),!1):void 0}),a.addClass("ui-timepicker-selected")),!1;case 40:return a=n.find(".ui-timepicker-selected"),0===a.length?(n.find("li").each(function(i,t){return e(t).position().top>0?(a=e(t),!1):void 0}),a.addClass("ui-timepicker-selected")):a.is(":last-child")||(a.removeClass("ui-timepicker-selected"),a.next().addClass("ui-timepicker-selected"),a.next().position().top+2*a.outerHeight()>n.outerHeight()&&n.scrollTop(n.scrollTop()+a.outerHeight())),!1;case 27:n.find("li").removeClass("ui-timepicker-selected"),H.hide();break;case 9:H.hide();break;default:return!0}}function g(i){var r=e(this),n=r.data("timepicker-list"),a=r.data("timepicker-settings");if(!n||!t(n)||a.disableTextInput)return!0;switch(i.keyCode){case 96:case 97:case 98:case 99:case 100:case 101:case 102:case 103:case 104:case 105:case 48:case 49:case 50:case 51:case 52:case 53:case 54:case 55:case 56:case 57:case 65:case 77:case 80:case 186:case 8:case 46:a.typeaheadHighlight?p(r,n):n.hide()}}function k(e){var i=e.data("timepicker-settings"),t=e.data("timepicker-list"),r=null,n=t.find(".ui-timepicker-selected");return n.hasClass("ui-timepicker-disabled")?!1:(n.length&&(r=n.data("time")),null!==r&&("string"!=typeof r&&(r=T(r,i)),f(e,r,"select")),!0)}function v(e,i){e=Math.abs(e);var t,r,n=Math.round(e/60),a=[];return 60>n?a=[n,x.mins]:(t=Math.floor(n/60),r=n%60,30==i&&30==r&&(t+=x.decimal+5),a.push(t),a.push(1==t?x.hr:x.hrs),30!=i&&r&&(a.push(r),a.push(x.mins))),a.join(" ")}function T(i,t){if(null===i)return null;var r=new Date(w.valueOf()+1e3*i);if(isNaN(r.getTime()))return null;if("function"===e.type(t.timeFormat))return t.timeFormat(r);for(var n,a,s="",o=0;o<t.timeFormat.length;o++)switch(a=t.timeFormat.charAt(o)){case"a":s+=r.getHours()>11?x.pm:x.am;break;case"A":s+=r.getHours()>11?x.PM:x.AM;break;case"g":n=r.getHours()%12,s+=0===n?"12":n;break;case"G":n=r.getHours(),i===y&&(n=24),s+=n;break;case"h":n=r.getHours()%12,0!==n&&10>n&&(n="0"+n),s+=0===n?"12":n;break;case"H":n=r.getHours(),i===y&&(n=24),s+=n>9?n:"0"+n;break;case"i":var c=r.getMinutes();s+=c>9?c:"0"+c;break;case"s":i=r.getSeconds(),s+=i>9?i:"0"+i;break;case"\\":o++,s+=t.timeFormat.charAt(o);break;default:s+=a}return s}function b(e,i){if(""===e)return null;if(!e||e+0==e)return e;if("object"==typeof e)return 3600*e.getHours()+60*e.getMinutes()+e.getSeconds();e=e.toLowerCase().replace(/[\s\.]/g,""),("a"==e.slice(-1)||"p"==e.slice(-1))&&(e+="m");var t="("+x.am.replace(".","")+"|"+x.pm.replace(".","")+"|"+x.AM.replace(".","")+"|"+x.PM.replace(".","")+")?",r=new RegExp("^"+t+"([0-2]?[0-9])\\W?([0-5][0-9])?\\W?([0-5][0-9])?"+t+"$"),n=e.match(r);if(!n)return null;var a=parseInt(1*n[2],10),s=n[1]||n[5],o=a;if(12>=a&&s){var c=s==x.pm||s==x.PM;o=12==a?c?12:0:a+(c?12:0)}var l=1*n[3]||0,u=1*n[4]||0,p=3600*o+60*l+u;if(!s&&i&&i._twelveHourTime&&i.scrollDefault){var m=p-i.scrollDefault();0>m&&m>=y/-2&&(p=(p+y/2)%y)}return p}var w=o(),y=86400,x={am:"am",pm:"pm",AM:"AM",PM:"PM",decimal:".",mins:"mins",hr:"hr",hrs:"hrs"},H={init:function(t){return this.each(function(){var a=e(this),s=[];for(var o in e.fn.timepicker.defaults)a.data(o)&&(s[o]=a.data(o));var c=e.extend({},e.fn.timepicker.defaults,s,t);if(c.lang&&(x=e.extend(x,c.lang)),c=r(c),a.data("timepicker-settings",c),a.addClass("ui-timepicker-input"),c.useSelect)n(a);else{if(a.prop("autocomplete","off"),c.showOn)for(i in c.showOn)a.on(c.showOn[i]+".timepicker",H.show);a.on("change.timepicker",m),a.on("keydown.timepicker",h),a.on("keyup.timepicker",g),c.disableTextInput&&a.on("keypress.timepicker",function(e){e.preventDefault()}),m.call(a.get(0))}})},show:function(i){var r=e(this),a=r.data("timepicker-settings");if(i&&i.preventDefault(),a.useSelect)return void r.data("timepicker-list").focus();l(r)&&r.blur();var s=r.data("timepicker-list");if(!r.prop("readonly")&&(s&&0!==s.length&&"function"!=typeof a.durationTime||(n(r),s=r.data("timepicker-list")),!t(s))){r.data("ui-timepicker-value",r.val()),p(r,s),H.hide(),s.show();var o={};o.left=a.orientation.match(/r/)?r.offset().left+r.outerWidth()-s.outerWidth()+parseInt(s.css("marginLeft").replace("px",""),10):r.offset().left+parseInt(s.css("marginLeft").replace("px",""),10);var m;m=a.orientation.match(/t/)?"t":a.orientation.match(/b/)?"b":r.offset().top+r.outerHeight(!0)+s.outerHeight()>e(window).height()+e(window).scrollTop()?"t":"b","t"==m?(s.addClass("ui-timepicker-positioned-top"),o.top=r.offset().top-s.outerHeight()+parseInt(s.css("marginTop").replace("px",""),10)):(s.removeClass("ui-timepicker-positioned-top"),o.top=r.offset().top+r.outerHeight()+parseInt(s.css("marginTop").replace("px",""),10)),s.offset(o);var f=s.find(".ui-timepicker-selected");if(f.length||(d(r)?f=u(r,s,b(d(r))):a.scrollDefault&&(f=u(r,s,a.scrollDefault()))),f&&f.length){var h=s.scrollTop()+f.position().top-f.outerHeight();s.scrollTop(h)}else s.scrollTop(0);return a.stopScrollPropagation&&e(document).on("wheel.ui-timepicker",".ui-timepicker-wrapper",function(i){i.preventDefault();var t=e(this).scrollTop();e(this).scrollTop(t+i.originalEvent.deltaY)}),e(document).on("touchstart.ui-timepicker mousedown.ui-timepicker",c),e(window).on("resize.ui-timepicker",c),a.closeOnWindowScroll&&e(document).on("scroll.ui-timepicker",c),r.trigger("showTimepicker"),this}},hide:function(){var i=e(this),r=i.data("timepicker-settings");return r&&r.useSelect&&i.blur(),e(".ui-timepicker-wrapper").each(function(){var i=e(this);if(t(i)){var r=i.data("timepicker-input"),n=r.data("timepicker-settings");n&&n.selectOnBlur&&k(r),i.hide(),r.trigger("hideTimepicker")}}),this},option:function(i,t){return this.each(function(){var a=e(this),s=a.data("timepicker-settings"),o=a.data("timepicker-list");if("object"==typeof i)s=e.extend(s,i);else if("string"==typeof i&&"undefined"!=typeof t)s[i]=t;else if("string"==typeof i)return s[i];s=r(s),a.data("timepicker-settings",s),o&&(o.remove(),a.data("timepicker-list",!1)),s.useSelect&&n(a)})},getSecondsFromMidnight:function(){return b(d(this))},getTime:function(e){var i=this,t=d(i);if(!t)return null;var r=b(t);if(null===r)return null;e||(e=new Date);var n=new Date(e);return n.setHours(r/3600),n.setMinutes(r%3600/60),n.setSeconds(r%60),n.setMilliseconds(0),n},setTime:function(e){var i=this,t=i.data("timepicker-settings");if(t.forceRoundTime)var r=s(b(e),t);else var r=T(b(e),t);return e&&null===r&&t.noneOption&&(r=e),f(i,r),i.data("timepicker-list")&&p(i,i.data("timepicker-list")),this},remove:function(){var e=this;if(e.hasClass("ui-timepicker-input")){var i=e.data("timepicker-settings");return e.removeAttr("autocomplete","off"),e.removeClass("ui-timepicker-input"),e.removeData("timepicker-settings"),e.off(".timepicker"),e.data("timepicker-list")&&e.data("timepicker-list").remove(),i.useSelect&&e.show(),e.removeData("timepicker-list"),this}}};e.fn.timepicker=function(i){return this.length?H[i]?this.hasClass("ui-timepicker-input")?H[i].apply(this,Array.prototype.slice.call(arguments,1)):this:"object"!=typeof i&&i?void e.error("Method "+i+" does not exist on jQuery.timepicker"):H.init.apply(this,arguments):this},e.fn.timepicker.defaults={className:null,minTime:null,maxTime:null,durationTime:null,step:30,showDuration:!1,showOnFocus:!0,showOn:["click","focus"],timeFormat:"g:ia",scrollDefault:null,selectOnBlur:!1,disableTextInput:!1,disableTouchKeyboard:!1,forceRoundTime:!1,roundingFunction:function(e,i){if(null===e)return null;var t=e%(60*i.step);return t>=30*i.step?e+=60*i.step-t:e-=t,e},appendTo:"body",orientation:"l",disableTimeRanges:[],closeOnWindowScroll:!1,typeaheadHighlight:!0,noneOption:!1,show2400:!1,stopScrollPropagation:!1}});