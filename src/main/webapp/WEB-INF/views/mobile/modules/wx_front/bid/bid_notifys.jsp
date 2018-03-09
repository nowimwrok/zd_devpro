<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--中标通知书</title>

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

.data_tab_cente {
	width: 100%;
}

.data_notice div {
	margin-bottom: 0px;
}
</style>
</head>

<body>
	<div class="data_box">
		<div class="data_top data_tab" style="width:100%;padding:0px;">
			<div class="selected data_tab_cente">竞标通知书</div>
		</div>

		<div class="data_center data_notice"
			style="width:95%;margin:0px auto;margin-top:10px;">
			<input type="hidden" id="username" value="${bidding.bidinfo.biduser.loginName!=null?bidding.bidinfo.biduser.loginName:bidding.bidinfo.biduser.phone}"/>
			<input type="hidden" id="ISBIDDING"
				value="${bidding.biddingstatus}" />
			<input type="hidden" id="loadWeight" value="${bidding.bidinfo.goods.freightvolume}" />
			<input type="hidden" id="noticeTime" value="<fmt:formatDate value='${bidding.updateDate}'/>"/>
			<div style="text-align:center;font-size:20px;color:red">中标通知</div>
			<div>${bidding.biddinguser.loginName!=null?bidding.biddinguser.loginName:bidding.biddinguser.phone}:</div>
			<div style="text-indent:32px;line-height:25px;word-break:break-all;clear:both;">
			恭喜！你单位在卓大平台上招标文号为<font style="border-bottom:1px solid #CCC;">${bidding.bidinfo.bidcode}</font>的招标项目中，经评委综合评审，你单位满足招标要求确定为此项目中标单位。
			请务必在<span id="thistimes" style="font-size:16px"></span>日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756
			 </div>
			 <input type="hidden" id="biddingPrice" value="${bidding.biddingprice}"/>
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
			var username=$("#username").val();
			if(username.length>8){
				username=username.substring(0, 7)+"…";
				//$("#username").val(username);
			}
			var price = ($("#biddingPrice").val()*1)*($("#loadWeight").val()*1);
			$("#price").html(price);
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
			
			
			//格式数字后面的0
			function geShi(num){
				if(num!=null&&num!=""){
					return parseFloat(num);
				}else{
					return "--";
				}
			}
			$("#biddingprice").val(geShi($("#biddingprice").val()));
			var weight = geShi($("#loadWeight").val()*1);
			$("#bidloadweight").html(weight);
			
			var notifystimes=$("#noticeTime").val();
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
