<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--竞价详情</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="${ctxStatic}/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

	<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div 布局*/
.data_box {
	width: 100%;
	margin: 0 auto;
}

.data_top,.data_center,.data_bottom {
	width: 97%;
	clear: both;
	margin: 0 auto;
	background-color: #FFF;
}

.data_top {
	width: 97%;
	height: 50px;
	line-height: 50px;
	padding-left: 3%;
	border-bottom: 1px solid #CCC;
	background-color:rgba(32, 162, 226, 1);
	color:white;
}

.data_center {
	width: 100%;
}

.data_bottom {
	height: 200px;
	margin-top: 20px;
	border-top: 1px solid #CCC;
	padding-top: 10px;
	padding-left: 10px;
}
/*top 信息布局*/
.top_icon {
	width: 25px;
	height: 50px;
	margin-right: 10px;
}

.top_text {
	width: 38%;
	height: 50px;
}

.top_icon img {
	width: 25px;
	margin-top: 5px;
}
/*data_center 信息布局*/
.icon {
	width: 25px;
}

.ic_img {
	width: 30px;
}

.center_top,.center_bottom {
	width: 100%;
	padding-top: 10px;
}

.center_top {
	height: 80px;
	border-bottom: 1px solid #CCC;
}

.ct_left {
	width: 70%;
	height: 80px;
}

.ct_right {
	width: 29%;
	height: 80px;
	line-height:75px;
}

.split {
	clear: both;
	width: 100%;
	border: 1px solid #CCC;
}

.ct_lf {
	clear: both;
	height: 35px;
	line-height: 25px;
	padding-left: 10px;
}

.ct_lf div {
	float: left;
}

#imgCredit {
	margin-top: 5px;
}

.ic_call {
	margin-top: 10px;
	width: 50px;
}

.cb_tle {
	width: 32.5%;
	text-align: right;
}

.cb_val {
	width: 60%;
}

.cb_val_rt {
	width: 25%
}

.in_txt {
	border-bottom: 1px solid #CCC;
	height: 30px;
	font-size: 16px;
	width: 50%;
}

.sub_btn {
	width: 95%;
	height: 50px;
	font-size: 20px;
	text-align: center;
	line-height: 45px;
	margin: 0 auto;
	margin-top: 20px;
	font-weight: bold;
	color: #FFF;
	background-color: rgb(32, 134, 226);
	letter-spacing: 10px;
	clear: both;
}

.authened {
	color: white;
	margin-right: 5px;
	background: rgb(32, 134, 226);
	font-size: 0.8em;
	vertical-align: text-top;
	padding: 5px;
}

.unauthen {
	color: white;
	margin-left: 5px;
	margin-right: 5px;
	background: rgb(1232, 173, 109);
	font-size: 0.8em;
	vertical-align: text-top;
}

.linediv p {
	line-height: 20px;
}

.data_tab div {
	float: left;
	text-align: center;
}

.selected {
	color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}

.data_tab_left {
	width: 49%;
}

.data_tab_right {
	width: 50%;
}

.data_notice div {
	margin-bottom: 0px;
}
</style>
</head>

<body>
	<div class="data_box">
		<div class="data_top data_tab" style="width:100%;padding:0px;">
			<div class="selected data_tab_left">详情</div>
			<div class="data_tab_right">中标状态</div>
		</div>
		<!-- data_top end -->
		<div id="data">
			<div class="data_center">
				<div class="center_top">
					<div class="ct_left flt_left">
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" alt="用户"
									src="${ctxStatic}/images/weixin/ic_user.png">
							</div>
							<div id="username">${bidding.bidinfo.biduser.loginName!=null?bidding.bidinfo.biduser.loginName:bidding.bidinfo.biduser.phone}</div>
						</div>
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" alt="用户"
									src="${ctxStatic}/images/weixin/personal_certificate.png">
							</div>
							<!-- <div>13560021828</div> -->
							<div>
								<c:choose>
									<c:when test="${bidding.bidinfo.biduser.userinfo.status eq '2' }">
										<span class="authened" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">已认证</span>
									</c:when>
									<c:otherwise>
										<span class="unauthen" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">未认证</span>
									</c:otherwise>
								</c:choose>
							</div>
							<div>
								<img id="imgCredit" 
								    <c:if test="${bidding.bidinfo.biduser.userinfo.pointlevle=='5'}">style="width:64px;"</c:if> 
								    <c:if test="${bidding.bidinfo.biduser.userinfo.pointlevle=='4'}">style="width:56px;"</c:if> 
								    <c:if test="${bidding.bidinfo.biduser.userinfo.pointlevle=='3'}">style="width:48px;"</c:if> 
								    <c:if test="${bidding.bidinfo.biduser.userinfo.pointlevle=='2'}">style="width:40px;"</c:if> 
								    <c:if test="${bidding.bidinfo.biduser.userinfo.pointlevle=='1'||bidding.bidinfo.biduser.userinfo.pointlevle=='0'}">style="width:30px;"</c:if> 
									src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${bidding.bidinfo.biduser.userinfo.pointlevle!=null?bidding.bidinfo.biduser.userinfo.pointlevle:0}.gif" width="20px;"/>
							</div>
						</div>
					</div>
					<!-- ct_left end -->
					<div class="ct_right flt_left" id="bidstatus">
						中标
					</div>
					<!-- ct_right end -->
				</div>
				<!-- center_top end -->
				<div class="center_bottom">
					<div class="cbm_info">
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" style="width:20px;" alt="出发地"
									src="${ctxStatic}/images/weixin/img_location_start_point.png">
							</div>
							<div>${bidding.bidinfo.goods.shipAddress.province }${bidding.bidinfo.goods.shipAddress.city}${bidding.bidinfo.goods.shipAddress.district}${bidding.bidinfo.goods.shipAddress.address}</div>
						</div>
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" style="width:20px;" alt="目的地"
									src="${ctxStatic}/images/weixin/img_location_end_point.png">
							</div>
							<div>${bidding.bidinfo.goods.consignAddress.province }${bidding.bidinfo.goods.consignAddress.city}${bidding.bidinfo.goods.shipAddress.district}${bidding.bidinfo.goods.shipAddress.address}</div>
						</div>
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" alt="货物"
									src="${ctxStatic}/images/weixin/ic_goods.png">
							</div>
							<div class="cb_tle" style="width:24%;">货物名称：</div>
							<div class="cb_val" style="width:60%;">${bidding.bidinfo.goods.goodsname}</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">招标吨位：</div>
							<div class="cb_val"><span id="loadweight">${bidding.bidinfo.goods.freightvolume}</span>${bidding.bidinfo.goods.freightunit}</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">拦标价：</div>
							<div class="cb_val"><span id="expectedprice">${bidding.bidinfo.expectedprice}</span>元/${bidding.bidinfo.goods.freightunit!=null?bidding.bidinfo.goods.freightunit:"吨" }</div>
							<!-- <div class="cb_val_rt">已有<span class="red font_weight font16">200</span>竞价</div> -->
						</div>
						<div class="ct_lf">
							<div class="cb_tle">截止时间：</div>
							<div class="cb_val" id="endtime"><fmt:formatDate value="${bidding.bidinfo.endtime}"/> </div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">结算方式：</div>
							<div class="cb_val">
								<c:choose>
									<c:when test="${bidding.bidinfo.paytype eq '0' }">
								回执单现金结算
							</c:when>
									<c:otherwise>
								其他
							</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="ct_lf" id="wantBid">
							<div class="cb_tle">我的竞价：</div>
							<div class="cb_val"><span id="biddingprice">${bidding.biddingprice}</span>元/吨</div>
						</div>
						<div class="ct_lf" style="color:#F74000;">
							<div class="cb_tle">缴纳保证金：</div>
							<%-- ${result.data.bidding.ENDTIME } --%>
							<div class="cb_val" id="endtime">
								<span style="color:red;font-weight:bold;">1000</span>元
							</div>
						</div>
					</div>
				</div>
				<!-- center_bottom end -->
			</div>
			<!-- data_center end -->
			<div class="data_bottom">
				<div style="font-size:20px;">本标要求</div>
				<div style="line-height:20px;font-size:14px;margin-top:10px;">
					${bidding.remarks}</div>
				<div style="font-size:20px;margin-top:10px;">投标须知</div>
				<div class="linediv" style="line-height:15px;font-size:14px;">
					<p>1、参与招投标的用户必须为平台认证会员。</p>
					<p>2、单次竞价投标，需缴纳1000元/标投标保证金。账户余额不足，无法参与投标。</p>
					<p>3、竞价投标提交后，同一标的不可进行二次投标。</p>
					<p>4、投标结束后，中标者保证金由平台暂时扣除，未中标的会员全额退还保证金。</p>
				</div>
				<div style="font-size:20px;">招标流程</div>
				<div style="margin:0 auto;margin-top:10px;width:94%;">
					<img style="width:100%;" alt="流程"
						src="${ctxStatic}/images/weixin/Process.png">
				</div>
			</div>
			<!-- data_bottom end -->
		</div>
		<div class="data_center data_notice"
			style="display:none;width:95%;margin:0px auto;margin-top:10px;">
			<input type="hidden" id="ISBIDDING"
				value="${bidding.biddingstatus}" />
			<div style="text-align:center;font-size:20px;color:red">中标通知</div>
			<div>${bidding.biddinguser.loginName!=null?bidding.biddinguser.loginName:bidding.biddinguser.phone}:</div>
			<div style="text-indent:32px;line-height:25px;word-break:break-all;clear:both;">
			恭喜！你单位在卓大平台上招标文号为<font style="border-bottom:1px solid #CCC;">${bidding.bidinfo.bidcode}</font>的招标项目中，经评委综合评审，你单位满足招标要求确定为此项目中标单位。
			请务必在<span id="thistimes" style="font-size:16px"></span>日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756
			 </div>
			 <div id="biddingPrice" style="display:none;">${bidding.biddingprice}</div>
			 <div id="loadWeight" style="display:none;">${bidding.bidinfo.goods.freightvolume}</div>
			 <div style="text-indent:32px;line-height:25px;word-break:break-all;clear:both;">总价：<font style="border-bottom:1px solid #CCC;"><span id="price">0</span></font>元(具体单价详见招标比价单)。</div>
			  <div style="text-indent:32px;line-height:25px;word-break:break-all;clear:both;">重量：<font style="border-bottom:1px solid #CCC;"><span id="bidloadweight">0</span></font>${bidding.bidinfo.goods.freightunit}(具体重量详见招标比价单)。</div>
			 <div style="text-indent:32px;line-height:25px;word-break:break-all;clear:both;">具体要求以招标文件和合同为准。
			</div>
			<div style="text-indent:32px;line-height:25px;">特此通告</div>
			<div class=""
				style="text-align:right;width:90%;right:10%;margin-top:10px;">
				<div>代理单位(盖章)</div>
				<div>日期：<span id="noticeTime"><fmt:formatDate value="${bidding.updateDate}"/></span></div>
				<div style="postion:absolute;margin-top:-80px;">
					<img style="width:100px;" alt="企业盖章"
						src="${ctxStatic}/images/weixin/zd2.png">
				</div>
			</div>
			
		</div>
	</div>
	<!-- data_box end -->
	<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/global.js"></script>
	<script type="text/javascript">
		$(function() {
			var username=$("#username").html();
			if(username.length>8){
				username=username.substring(0, 7)+"…";
				$("#username").html(username);
			}
			$("#price").html($("#biddingPrice").html()*1*$("#loadWeight").html()*1);
			var isbidding = $("#ISBIDDING").val();
			if(isbidding=="1"){
				 $("#bidstatus").html("招标中");
				$(".data_notice").html("正在评标中，请耐心等待招标方进行评标。有任何疑问可以直接联系卓大平台。<br>客服：0310-3188756");
			}
			if(isbidding=="3"){
				 $("#bidstatus").html("未中标");
				$(".data_notice").html("很遗憾，本次竞标中未能中标！感谢您对卓大平台的支持，谢谢参与！");
			} 
			if(isbidding=="2"){
				 $("#bidstatus").html("中标");
			}
			$(".data_tab div").click(function() {
					var i = $(this).index();
					$(this).addClass("selected");
					$(".data_tab div").not(this).removeClass("selected");
					if (i == 0) {
						$(".data_notice").hide();
						$("#data").show();
					} else {
						$(".data_notice").show();
						$("#data").hide();
					}
			});
			
			//格式数字后面的0
			function geShi(num){
				if(num!=null&&num!=""){
					return parseFloat(num);
				}else{
					return "--";
				}
			}
			$("#loadweight").html(geShi($("#loadweight").html()));
			$("#expectedprice").html(geShi($("#expectedprice").html()));
			$("#biddingprice").html(geShi($("#biddingprice").html()));
			$("#bidloadweight").html(geShi($("#loadweight").html()));
			
			var notifystimes=$("#noticeTime").html();
			 var myDate = new Date(notifystimes);
			/*  $("#nowdates").html( myDate.toLocaleDateString()); */	 
				myDate.setDate(myDate.getDate() + 2);
				var thedate = myDate.getDate() < 10 ? "0" + myDate.getDate() : myDate
						.getDate(); //获取当前几号，不足10补0 
				var thetimes=(myDate.getMonth()+1) + "月"
				+ thedate;
				$("#thistimes").html(thetimes);
		});
	</script>
</body>
</html>
