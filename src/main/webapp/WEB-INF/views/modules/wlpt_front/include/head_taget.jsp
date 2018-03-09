<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<meta http-equiv="Cache-Control" content="no-store"/>
<meta http-equiv="Pragma" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta name="author" content="http://www.zhuoda56.com"/>
<meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"> 
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Pragma" content="no-cache" />
<link href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
<link href="${ctxStatic}/front/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/bootstrap-table.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/bootstrap-table-fixed-columns.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/bootstrap-select.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/bootstrapValidator.css" type="text/css" rel="stylesheet"/>

<link href="${ctxStatic}/front/css/per_global.css?id=5" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/personal.css?id=2" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/add.css?id=6" type="text/css" rel="stylesheet"/>


<script src="${ctxStatic}/front/js/jquery.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/common/global.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/bootstrap-table.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/bootstrap-table-fixed-columns.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/bootstrap-table-zh-CN.min.js"></script>
<script src="${ctxStatic}/front/js/labelauty.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js?id=2" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/bootstrap-select.min.js"></script>
<script src="${ctxStatic}/front/js/bootstrapValidator.js?id=2"></script>
<script src="${ctxStatic}/front/js/angular.min.js"></script>
<script src="${ctxStatic}/front/js/tm.pagination.js"></script>
<script src="${ctxStatic}/front/js/jquery.nicescroll.js"></script>




<!--[if lte IE 6]><link href="${ctxStatic}/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script>
<![endif]-->
<!--[if lte IE 11]>
<div id="ie6-warning" style="height:35px;line-height:35px;position:relative;">您当前使用的浏览器版本较低，在本页面的显示效果可能有差异。建议您升级到 <a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie/" target="_blank">Internet Explorer 11</a> 或以下浏览器： <a href="http://www.mozillaonline.com/">Firefox</a> / <a href="http://www.google.com/chrome/?hl=zh-CN">Chrome</a> / <a href="http://www.apple.com.cn/safari/">Safari</a> / <a href="http://www.operachina.com/">Opera</a>
</div>
<script type="text/javascript">
function position_fixed(el, eltop, elleft){
// check if this is IE6
if(!window.XMLHttpRequest)
window.onscroll = function(){
el.style.top = (document.documentElement.scrollTop + eltop)+"px";
el.style.left = (document.documentElement.scrollLeft + elleft)+"px";
}
else el.style.position = "relative";
}
position_fixed(document.getElementById("ie6-warning"),0, 0);
</script>

<![endif]-->
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    var w = document.documentElement.clientWidth;
    if(w<1200){
    	$('.row').css('width','1010px').css('background-color','#fff');
    	$('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }
    
    //var bheight = document.documentElement.clientHeight;
	//var bwidth = document.documentElement.clientWidth;
  //弹框
    //$('#modal').css('width', bwidth / 3 * 2 + 'px').css('max-height','400px');
    //$('.modal-body').css('max-height', bheight / 3 * 2 + 'px');
</script>

<script type='text/javascript'>
    var _vds = _vds || [];
    window._vds = _vds;
    (function(){
        _vds.push(['setAccountId', '836d553009a4d7a3']);
        (function() {
            var vds = document.createElement('script');
            vds.type='text/javascript';
            vds.async = true;
            vds.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'assets.growingio.com/vds.js';
            var s = document.getElementsByTagName('script')[0];
            s.parentNode.insertBefore(vds, s);
        })();
    })();
</script>