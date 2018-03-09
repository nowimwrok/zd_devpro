<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>招标公告</title>
<meta name="description" content="${DESCRIPTION}">
<meta name="keywords" content="${KEYWORD}">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="/static/favicon.ico" type="image/x-icon" rel="shortcut icon">
<style>
body {
	font-size: 12px;
}

.gs-basic {
	list-style: none;
	padding: 0px;
	padding-left: 12px;
	margin: 0px;
	line-height: 24px;
}

.graybt {
	background: gray none repeat scroll 0 0;
	border: 1px solid;
	color: #ffffff;
	cursor: pointer;
	font-weight: bold;
	height: 35px;
	text-align: center;
	width: 100px;
}

.one-data td {
	border-bottom: 1px dashed #ccc;
	line-height: 20px;
	padding-left: 5px;
}

.one-data span {
	line-height: 25px;
}

.data-detial {
	padding: 2px 2px;
	color: #005ea7;
}

.data-list td {
	height: 60px;
	text-align: left;
	line-height: 60px;
	padding-left: 15px;
}

thead th {
	font-size: 15px;
	color: #555;
}

#allcount {
	font-size: 16px;
	font-weight: 600;
}

#cgs-right-iframe {
	width: 240px;
}

.hides {
	display: none;
}

.page-title2 {
	border-left: solid 2px #FF0000;
	width: 200px;
	height: 1.5em;
	font-size: 13px;
	font-weight: bold;
	line-height: 24px;
	padding-left: 10px;
	color: #555;
	margin: 10px;
	text-align: left;
	margin-left: 33px;
	width: 100%;
}

.cgs-key-text {
	color: black;
	font-weight: normal;
	font-size: 15px;
	text-align: right;
}

.text-right-td {
	text-align: left;
}

.text-right-td input {
	border-top: 0px;
	border-left: 0px;
	border-right: 0px;
}

.black_overlay {
	background: #000 none repeat scroll 0 0;
	cursor: pointer;
	display: block;
	height: 100%;
	left: 0;
	opacity: 0.5;
	position: fixed;
	top: 0;
	width: 100%;
	z-index: 1001;
}

.white_content {
	display: block;
	position: absolute;
	top: 0%;
	left: 18%;
	width: 64%;
	/* height: 90%; */
	background-color: #EFFFEF;
	z-index: 1002;
	overflow: auto;
	height: 100%;
	padding-bottom: 50px;
}

.white_content table {
	font-size: 15px;
}

.orderhead {
	font-size: 18px;
	font-family: 宋体, 隶书;
}

.orderdetail {
	font-size: 14px;
	font-family: 宋体, 隶书;
}

.biaoshi {
	right: 82px;
	position: absolute;
	margin-top: -164px;
	filter: alpha(opacity =   50);
	-moz-opacity: 0.5;
	-khtml-opacity: 0.5;
	opacity: 0.5;
}

.multieditboxline {
	background: #ffffff;
	border-left: #ffffff 1px solid;
	border-right: #ffffff 1px solid;
	border-top: #ffffff 1px solid;
	font-size: 15px;
	margin-top: 0px;
	text-decoration: underline;
	text-decoration-color: #CCCCCC;
}

.close {
	font-size: 18px;
	font-weight: bold;
	color: red;
	text-align: right;
	float: right;
	height: 20px;
	width: 20px;
	margin: 5px;
	margin-right: 10px;
	cursor: pointer;
}

.bidInfo {
	text-indent: 20px;
	font-size: 12px;
	border: solid 1px #CCC;
	height: 35px;
	line-height: 35px;
	letter-spacing: 2px;
}
</style>

</head>

<body>
	<!-- <div id="fade" class="black_overlay">
		<div id="close" title="点击关闭" class="close">X</div>
	</div> -->
	<div id="light" class="white_content">
		<div class="page-title"></div>
		<div style="text-align:center">
			<h1 style="font-size:20px">卓大物流平台招标文件</h1>
		</div>
		<div style="padding-left:70px;padding-bottom:50px;padding-right:70px;">
			<table>
				<colgroup>
					<col width="4%">
					<col width="91%">
				</colgroup>
				<tr>
					<td colspan="2" class="orderhead">一.招标货物信息</td>
				</tr>
				<tr>
					<td>1.</td>
					<td class="orderdetail">货物名称：<span
						style="text-decoration:underline;" id="SGOODSNAME"></span></td>
				</tr>
				<tr>
					<td>2.</td>
					<td class="orderdetail">招标吨位：<span
						style="text-decoration:underline;" id="SLOADWEIGHT"></span></td>
				</tr>
				<tr>
					<td>3.</td>
					<td class="orderdetail">运输路线：<span
						style="text-decoration:underline;" id="SADDRESS"></span></td>
				</tr>
				<tr>
					<td>4.</td>
					<td class="orderdetail">拦标价格：<span
						style="text-decoration:underline;" id="SPRICE"></span></td>
				</tr>
				<tr>
					<td>5.</td>
					<td class="orderdetail">车型要求：<span
						style="text-decoration:underline;" id="SCARTYPE"></span></td>
				</tr>
				<tr>
					<td>6.</td>
					<td class="orderdetail">车长要求：<span
						style="text-decoration:underline;" id="SCARLENGTH"></span></td>
				</tr>
				<tr>
					<td colspan="2" class="orderhead">二.招标要求</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">1.</td>
					<td class="orderdetail" id="SREMARKS"></td>
				</tr>
				<tr>
					<td style="vertical-align:top;">2.</td>
					<td class="orderdetail">中标方保证参运车辆符合招标方车辆要求，安装投标方统一GPS卫星定位系统,(安装方法：先交纳押金，按一年期收取折旧费用)且车辆满足3年内红色重汽或陕汽车辆；前后牌照固定、醒目，四号齐全，起斗报警器完好。</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">3.</td>
					<td class="orderdetail">运输过程中必须严格遵守相关规定，如造成考核及一切损失，由中标方全部承担。</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">4.</td>
					<td class="orderdetail">投标截止时间：<span id="edtime"><span
							id="year"></span>年<span id="month"></span>月<span id="day"></span>日<span
							id="hour"></span>时<span id="min"></span>分</span></td>
				</tr>
				<tr>
					<td colspan="2" class="orderhead">三.招标规则</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">1.</td>
					<td class="orderdetail">定标规则：定标影响要素包括:(1)投标价格(2)押金(3)信誉(4)平台流水，平台根据以上要素对投标者进行排比，最优者中标。</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">2.</td>
					<td class="orderdetail">废标规则：投标方超过招标方拦标价，招标方有权终止招标活动，重新组织招标，平台审批后生效。</td>
				</tr>
				<tr>
					<td colspan="2" class="orderhead">四.结算方式</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">1.</td>
					<td class="orderdetail">本标结算方式:<span
						style="text-decoration: underline;" id="SPAYTYPE">回执单现金结算</span></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align:right;font-weight:bold;" class="orderdetail">招标企业：<span
						id="SUSERNAME"></span></td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align:right;font-weight:bold;" class="orderdetail">
						日期：<span id="STIME"></span>
					</td>
				</tr>
			</table>
			<div class="biaoshi">
				<img alt="卓大物流平台招标专用章"
					src="${pageContext.request.contextPath}/static/images/gz.png">
			</div>
		</div>
	</div>
	

</body>
</html>
