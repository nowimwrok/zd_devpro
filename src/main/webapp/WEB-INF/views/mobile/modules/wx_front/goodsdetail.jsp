<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>货物详情信息</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>


	<link href="static/css/weixin/goodsdetail.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div>
		<%-- <%@ include file="./pagetitle.jsp" %> --%>
		<div id="carDetailInfo">
			<div id="divInfo">
				<div id="fromAddress" class="divBorder">
					<span class="attribute addres">始发地：</span>${detail.FromAddress}
				</div>
				<div id="toAddress" class="divBorder">
					<span class="attribute addres">目的地：</span>${detail.ToAddress }
				</div>
				<div id="carNumber" class="divBorder">
					<span class="attribute">货物名称：</span>${detail.GOODSNAME }
				</div>
				<div id="carLength" class="divBorder">
					<span class="attribute">货物类型：</span>${detail.GOODSTYPE}
				</div>
				<div id="ReMainWeight" class="divBorder">
					<span class="attribute">货物价值：</span>${detail.WORTH }元
				</div>
				<div id="carType" class="divBorder">
					<span class="attribute">运输车型：</span>${detail.CARTYPE}
				</div>
				<div id="effectDay" class="divBorder">
					<span class="attribute">车&nbsp;长：</span>${detail.CARLENGTH }${detail.LENGTHUNIT }
				</div>									
				<div id="credit" class="divBorder">
					<span class="attribute">有效期：</span>${detail.EffectDays }天
				</div>
				<div id="contactName" class="divBorder">
					<span class="attribute">联系人：</span>${detail.LINKMAN }
				</div>
				<div id="contactMobile" class="divBorder">
					<span class="attribute">电&nbsp;话：</span>${detail.LINKMOBILE }
				</div>
				<div id="departureTime" class="divBorder">
					<span class="attribute">发货时间：</span>${detail.SendTime }
				</div>
				<span class="divBorder addremarks">
				<span id="additional" class="attribute">补充说明：</span>${detail.REMARKS}
				</span>
			</div>
		</div>
	</div>
</body>
</html>
