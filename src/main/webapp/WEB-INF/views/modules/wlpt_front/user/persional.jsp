﻿<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${fns:getConst('SYSTEMTITLE')}</title>

<link href="${ctxStatic }/modules/wlpt/front/css/persional_index.css"
	type="text/css" rel="stylesheet" />
<link href="${ctxStatic }/modules/wlpt/front/css/wlpt_index.css"
	type="text/css" rel="stylesheet" />
<style> 
.table {
	width: 95%;
}

.table-bordered th, .table-bordered td {
	/* border-left: 1px solid #ddd; */
	
}

.table th, .table td {
	border-top: 1px solid #ddd;
	line-height: 20px;
	padding: 8px;
	text-align: center;
	vertical-align: top;
}

.table td {
	border-top: 1px dashed #ddd;
}

.table thead:first-child tr th:last-child, .table tr td:last-child {
	/*  border-right: 1px solid #ddd; */
	
}

.ft14 {
	font-size: 14px;
}

.ft16 {
	font-size: 16px;
}

.adbt {
	width: 65px;
	height: 25px;
	line-height: 25px;
	text-align: center;
	float: left;
	margin-top: 10px;
}

.adbt a {
	color: #FFFFFF
}

.more {
	float: right;
	line-height: 60px;
	padding-right: 10px;
}

.baseinfo-td {
	padding: 0px 20px;
}

.img-td {
	padding: 5px 15px;
}

.tip-td {
	text-align: center;
}

.tip-span {
	color: #f74000;
	font-size: 15px;
}

.ol-condition-div {
	height: 50px;
}

.ol-condition-ul {
	height: 36px;
	margin: 10px 0px;
}

.ol-condition-ul li {
	float: left;
	line-height: 30px;
	color: #666;
	font-size: 16px;
}

.sub-title-div {
	height: 15px;
	margin-top: 2px;
	background: #F5F5F5;
}

.ol-content-div {
	width: 832px;
	border: 1px solid #f2f2f2;
	border-top: 1px solid #EBEBEB;
	background-color: #FFF;
}

.lineinfo {
	display: none;
}

.carinfo {
	display: block;
}
/**
*/
.divbackgroup {
	background-color: #FFF;
	width: 835px;
	margin: 15px 0px 20px 0px;
	padding-top: 1px;
}

.titleborder {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
}

.ordertable_title {
	width: 8%;
	float: left;
	color: rgb(51, 187, 255);
	font-size: 16px;
}

.ordertable_border {
	width: 1px;
	float: left;
	border-right: 1px dashed #999;
	height: 24px;
	margin-top: 15px;
}

.record_title {
	width: 10%;
	float: left;
	color: rgb(51, 187, 255);
	font-size: 16px;
}

.altrow {
	text-align: center;
}
/**
*/
.user-checked {
	background-color: #5CC92E;
	color: white;
}

.cp_content {
	margin-top: 0px;
}

.psnl_baseInfo {
	padding-top: 0px;
}

.cardbtm {
	width: 100px;
	background: #5cec2d;
	border: none;
	padding: 5px 0px;
	border-radius: 5px;
	color: #FFF;
	cursor: pointer;
}

.page-title {
	height: 40px;
}
.personright {
    width: 830px;
    height: 70em;
    padding: 0px;
    margin: 0px auto;
}
.psnl_baseInfo {
    width: 800px;
    height: auto;
    background: #fff;
    display: inline-block;
    padding: 30px 20px 0px 25px;
}
</style>
</head>
<body id="bodyid" style="height: 1200px;">
	<div id="cp_content" style="width: 969px;">

		<div class="personright">
			<div class="psnl_baseInfo">
				<table class="baseinfo">
					<tr>
						<td style="padding: 0px 20px;"><c:choose>
								<c:when test="${empty user.photo}">
									<img width="120px" height="120px;"
										src="${ctxStatic}/images/wlptfront/persional.png" />
								</c:when>
								<c:otherwise>
									<img width="120px" height="120px;" src="${user.photo}" />
								</c:otherwise>
							</c:choose></td>
						<td style="padding: 0px 20px 0px 10px;"><span
							style="font-size: 16px; line-height: 40px;" class="ft14">${user.name==null?user.phone:user.name}</span>
							<br /> <c:if
								test="${user.userinfo.status==0||user.userinfo.status==3}">
								<span class="user-checked" style="width: 36px;">未认证</span>
							</c:if> <c:if test="${user.userinfo.status==1}">
								<span class="user-checked" style="width: 36px;">认证中</span>
							</c:if> <c:if test="${user.userinfo.status==2}">
								<span class="user-checked" style="width: 36px;">已认证</span>
							</c:if> <c:if test="${user.role.enname eq 'enterprise'}">
								<span style="margin-left: 15px;" title="点击进入企业网站"><a
									style="color: #F74000;" target="_blank">企业网站</a></span>
							</c:if> <br /> <br /> <span>账户类型：${user.role.name }</span> <br /> <span>诚信等级：</span>
							<img
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif" /><br />

						 <span>我的积分：<span style="color: #F74000;">${user.userinfo.point!=null?user.userinfo.point:0}</span></span><br />

						<br />
							<a href="${wlpt}/wlpt/personal/toApplyCard"><input
								type="button" class="cardbtm" value="我的一卡通" /></a>
						<!-- <span style="color: #005ea7;"></span> --></td>
						<td>
							<div
								style="border-left: 1px solid #eee; width: 1px; height: 160px;"></div>
						</td>
						<td>
							<table style="padding: 0px 20px;">
								<tr>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_6.png" />
									</td>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_2.png" /></td>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_3.png" /></td>
								</tr>
								<tr>
									<td class="tip-td">运单<span class="tip-span">
											${empty
											userStatistics.tradeordercount ? '0': userStatistics.tradeordercount}
									</span></td>

									<td class="tip-td">报价<span class="tip-span">
											${(empty userStatistics.quotecount ? '0': userStatistics.quotecount)}
									</span></td>

									<td class="tip-td">废标<span class="tip-span">
											${empty userStatistics.cancelbidcount ? '0': userStatistics.cancelbidcount}
									</span>
									</td>
								</tr>
								<tr>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_4.png" /></td>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_5.png" /></td>
									<td class="img-td"><img
										src="${ctxStatic}/images/wlptfront/pointlevel/item_info_1.png" /></td>
								</tr>
								<tr>
									<td class="tip-td">车辆<span class="tip-span">
											${empty userStatistics.addcarcount ? '0': userStatistics.addcarcount}
									</span></td>
									<td class="tip-td">货源<span class="tip-span">
											${empty userStatistics.pubgodscount ? '0': userStatistics.pubgodscount}
									</span></td>
									<td class="tip-td">招标<span class="tip-span">
											${empty userStatistics.pubbidcount ? '0': userStatistics.pubbidcount}
									</span></td>
								</tr>
							</table>
						</td>
						<td><div
								style="border-left: 1px solid #eee; width: 1px; height: 160px;"></div></td>
						<td style="padding: 0px 0px 0px 15px;">
							<%-- <c:if
								test="${ sessionScope.pd.UROLECODE ne 'U_salesman' and sessionScope.pd.UROLECODE ne 'U_financial' }"> --%>
							<span>账户余额:</span> <span><a
								style="font-size: 18px; color: #F74000;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>
								${empty user.userPurse.webbalance ? '0': user.userPurse.webbalance }</c:otherwise>
									</c:choose></a>元</span> <br /> <span style="color: #005ea7;">可用余额:</span> <span
							style="color: #005ea7;"><a
								style="font-size: 14px; color: #005ea7;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>
								${empty user.userPurse.availablebalance ? '0': user.userPurse.availablebalance }</c:otherwise>
									</c:choose></a>元</span>
							<h1 style="height: 0px;"></h1> <span>保证金:</span> <span><a
								style="font-size: 18px; color: #F74000;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>${empty
									user.userPurse.guaranteemone ? '0': user.userPurse.guaranteemone}</c:otherwise>
									</c:choose></a></span> 元<br />

							<h1 style="height: 0px;"></h1> <span>当前卓币:</span> <span><a
								style="font-size: 18px; color: #F74000;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>
								${empty
										user.userPurse.webcoin ? '0': user.userPurse.webcoin}</c:otherwise>
									</c:choose></a></span> 币&nbsp;<br /> <span style="color: #005ea7;">可用卓币:</span> <span
							style="color: #005ea7;"><a
								style="font-size: 14px; color: #005ea7;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>
								${empty user.userPurse.availablecoin ? '0': user.userPurse.availablecoin }</c:otherwise>
									</c:choose></a>币&nbsp;</span>
							<h1 style="height: 0px;"></h1> <span>油气:</span> <span><a
								style="font-size: 18px; color: #F74000;"><c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>${empty
									user.userPurse.petrolbalance ? '0': user.userPurse.petrolbalance}</c:otherwise>
									</c:choose></a></span> 元<br /> <%-- <span> <a style="color:#005ea7;"
									href="${wlpt}/wlpt/petrol/toPetrol"
									style=" color:#666">油汽券</a></span> --%> <%-- </c:if> --%>
						</td>
					</tr>
				</table>
			</div>
			<div class="divbackgroup">
				<div class="page-title">今日业务动态</div>
				<div class="titleborder"></div>
				<div style="height: 400px;">
					<iframe name="mainFrame" frameborder="0"
						src="${wlpt}/wlpt/personal/business_trend"
						style="margin: 0 auto; width: 100%; height: 100%;" scrolling="no"></iframe>
				</div>

			</div>


			<div class="divbackgroup" id="order_info" style="display: none;">
				<input type="hidden" id="orderval" value="0">
				<div style="height: 600px;">
					<iframe name="mainFrame" frameborder="0"
						src="${wlpt}/wlpt/personal/order_statement"
						style="margin: 0 auto; width: 100%; height: 100%;" scrolling="no"></iframe>
				</div>
			</div>
			<!--div end-->

			<!--div end-->
			<div class="divbackgroup">
				<div class="page-title">今日财务动态</div>
				<div class="titleborder"></div>
				<div style="height: 400px;">
					<iframe name="mainFrame" frameborder="0"
						src="${wlpt}/wlpt/personal/financial_trend"
						style="margin: 0 auto; width: 100%; height: 100%;" scrolling="no"></iframe>
				</div>
			</div>
			<!--div end-->
			<div class="divbackgroup" id="financial_info" style="display: none;">
				<input type="hidden" id="financialrval" value="0">
				<div style="height: 650px;">
					<iframe name="mainFrame" frameborder="0"
						src="${wlpt}/wlpt/personal/financial_statement"
						style="margin: 0 auto; width: 100%; height: 100%;" scrolling="no"></iframe>
				</div>
			</div>
			<!--div end-->


		</div>
	</div>

	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>

</body>
</html>
