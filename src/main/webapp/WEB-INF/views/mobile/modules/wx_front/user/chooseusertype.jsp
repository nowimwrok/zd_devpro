<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>${fns:getConst('SYSTEMTITLE')}--选择用户类型</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">

	<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
	<link href="${ctxStatic}/weixin/css/chooseusertype.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function choose(type) {
			window.location.href="${wx}/weixin/user/toregister?type=" + type + "&openId=" + "${openId }";
		}
	</script>
	  <script>
		  var _hmt = _hmt || [];
		  (function() {
			  var hm = document.createElement("script");
			  hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			  var s = document.getElementsByTagName("script")[0];
			  s.parentNode.insertBefore(hm, s);
		  })();
	  </script>


  </head>
  
  <body>
    <%-- <div id="title"><p class="title">${pd.ECSYSNAME }</p></div> --%>
	<!-- <div id="displayInfo">
    	<img class="imgDisplay" src="static/images/weixin/info_display.png" />
    </div> -->
    <div class="divider"></div>
    <div id="carOwner" onclick="choose('goodsOwner')">
    	<div class="divPadding">
        	<div class="left">
        		<p><img class="imgTypeIcon" src="${ctxStatic}/images/weixin/goods_owner.png" /><strong>我是货主</strong></p>
           		<p class="desc">货主身份通过系统认证之后，您将拥有查找车源、发布货源、推荐优质车源等特权</p>
            </div>
            <div class="right">
            	<img class="imgDetail" src="${ctxStatic}/images/weixin/more.png" />
            </div>
        </div>
    </div>
    <div class="divider"></div>
    <div id="cargoOwner" onclick="choose('carOwner')">
    	<div class="divPadding">
        	<div class="left">
        		<p><img class="imgTypeIcon" src="${ctxStatic}/images/weixin/car_owner.png" /><strong>我是车主</strong></p>
           		
           		<p class="desc">车主身份通过系统认证之后，您将拥有查找货源、发布车源、推荐优质货源等特权</p>
            </div>
            <div class="right">
            	<img class="imgDetail" src="${ctxStatic}/images/weixin/more.png" />
            </div>
        </div>
    </div>
    <div class="divider"></div>
    <div id="enterprise" onclick="choose('enterprise')">
    	<div class="divPadding">
        	<div class="left">
        		<p><img class="imgTypeIcon" src="${ctxStatic}/images/weixin/enterprise.png" /><strong>我是企业</strong></p>
           		<p class="desc">企业身份通过系统认证之后，您将拥有查找车源货源、发布车源货源、车队管理、企业门户展示等特权</p>
            </div>
            <div class="right">
            	<img class="imgDetail" src="${ctxStatic}/images/weixin/more.png" />
            </div>
        </div>
    </div>
    <div class="divider"></div>
  </body>
</html>
