<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>车源查找</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-con trol" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
<link href="static/css/weixin/car_and_goods.css" rel="stylesheet" type="text/css">
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
	<div id="content">
		<%-- <%@ include file="./pagetitle.jsp"%> --%>
		<div id="carInfo">
			<div>
				<p>始发地：</p>
				<input type="text" id="txtStartCity" name="startCity" placeholder="请输入出发城市" readonly="readonly" /> <input type="hidden" name="fromProvince" id="FromProv">
				<input type="hidden" name="fromCity" id="FromCity"> <input type="hidden" name="fromDistrict" id="FromArea">
			</div>
			<div>
				<p>目的地：</p>
				<input type="text" id="txtEndCity" name="endCity" placeholder="请输入到达城市" readonly="readonly" /> <input type="hidden" name="toProvince" id="ToProv"> <input
					type="hidden" name="toCity" id="ToCity"> <input type="hidden" name="toDistrict" id="ToArea">
			</div>
			<div>
				<p>车辆类型：</p>
				<select id="selCarType" name="carType">
					<option id="cartypeoption" value="">---请选择---</option>
				</select>
			</div>
			<div>
				<p>车辆长度：</p>
				<select id="selCarLength" name="carLength">
					<option id="carLengthOption" value="">---请选择---</option>
					<option value="0-6">6米以下</option>
					<option value="6-9">6米-9米</option>
					<option value="9-11">9米-11米</option>
					<option value="11-15">11米-15米</option>
					<option value="15-18">15米-18米</option>
					<option value="18-23">18米-23米</option>
					<option value="23">23米以上</option>
				</select>
			</div>
			<div>
				<p>车辆载重：</p>
				<select id="selGoodsWeight" name="goodsWeight">
					<option value="">---请选择---</option>
					<option value="0-8">8吨以下</option>
					<option value="8-10">8吨-10吨</option>
					<option value="10-15">10吨-15吨</option>
					<option value="15-20">15吨-20吨</option>
					<option value="20-25">20吨-25吨</option>
					<option value="25-30">25吨-30吨</option>
					<option value="30">30吨以上</option>
				</select>
			</div>
			<div>
				<input id="txtFlag" type="hidden" value="<%=request.getAttribute("flag")%>" /> <input id="btnSearch" type="button" onclick="searchCar()" value="搜    索" />
			</div>
		</div>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript" src="static/js/weixin/findcar.js"></script>
	<!-- <script type="text/javascript">
		$(".pcc-content-ul1 li").css({"width":"65px"});
	</script> -->
</body>
</html>
