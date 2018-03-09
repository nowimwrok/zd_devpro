<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>--货源详情</title>

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

	<link href="static/css/weixin/global.css" rel="stylesheet"
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
	width:97%;
	height: 50px;
	line-height: 50px;
	padding-left:3%;
	border-bottom: 1px solid #CCC;
}

.data_center {
	width:100%;
}

.data_bottom {
	height: 200px;
	margin-top:20px;
	border-top:1px solid #CCC;
	padding-top:10px;
	padding-left:10px;
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
	padding-top:10px;
}

.center_top {
	height: 80px;
	border-bottom:1px solid #CCC;
}

.ct_left {
	width: 84%;
	height: 80px;
}

.ct_right {
	width: 15%;
	height: 80px;
}

.split {
	clear: both;
	width: 100%;
	border:1px solid #CCC;
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

#imgCredit{
	margin-top:5px;
}
.ic_call{
	margin-top:10px;
	width:50px;
}
.cb_tle{
	width:32.5%;
	text-align:right;
}
.cb_val{
	width:60%;
}
.cb_val_rt{
	width:25%
}
.in_txt{
	border-bottom:1px solid #CCC;
	height:30px;
	font-size:16px;
	width:50%;
}
.sub_btn{
	width:95%;
	height:50px;
	font-size:20px;
	text-align:center;
	line-height:45px;
	margin:0 auto;
	margin-top:20px;
	font-weight:bold;
	color:#FFF;
	background-color:rgb(32, 134, 226);
	letter-spacing:10px;
	clear:both;
}
.authened {
	color: white;
	margin-right: 5px;
	background: rgb(32, 134, 226);
	font-size: 0.8em;
	vertical-align: text-top;
	padding:5px;
}
.unauthen {
	color: white;
	margin-left: 5px;
	margin-right: 5px;
	background: rgb(1232,173,109);
	font-size: 0.8em;
	vertical-align: text-top;
}
.linediv p{
	line-height:20px;
}
</style>
</head>

<body>
<div class="data_box">
	<div class="data_top">
		<div class="top_icon flt_left" style="padding-left:10px;"><img alt="出发地" src="${pageContext.request.contextPath}/static/images/weixin/ic_start.png"></div>
		<div class="top_text flt_left">${result.data.FROMPROVINCE }&nbsp;${result.data.FROMCITY }</div>
		<div class="top_icon flt_left"><img alt="目的地" src="${pageContext.request.contextPath}/static/images/weixin/ic_end.png"></div>
		<div class="top_text flt_left">${result.data.TOPROVINCE }&nbsp;${result.data.TOCITY }</div>
	</div><!-- data_top end -->
	<div class="data_center">
		<div class="center_top">
			<div class="ct_left flt_left">
			<div class="ct_lf">
				<div class="ic_img"><img class="icon" alt="用户" src="${pageContext.request.contextPath}/static/images/weixin/ic_user.png"></div>
				<div>${result.data.NAME!=null?result.data.NAME:result.data.USER_PHONE }</div>
			</div>
			<div class="ct_lf">
				<div class="ic_img"><img class="icon" alt="用户" src="${pageContext.request.contextPath}/static/images/weixin/personal_certificate.png"></div>
				<!-- <div>13560021828</div> -->
				<div>
					<c:choose>
						<c:when test="${result.data.USER_STATUS eq '2' }">
							<span class="authened">已认证</span>
						</c:when>
						<c:otherwise>
							<span class="unauthen">未认证</span>
						</c:otherwise>
					</c:choose>
				</div>
				<div><img id="imgCredit" src="${pageContext.request.contextPath}/static/images/commom/wlpt/pointlevel/point_level_${result.data.POINTLEVEL }.gif" /></div>
			</div>
			</div><!-- ct_left end -->
			<div class="ct_right flt_left" style="display:none;">
				<img class="ic_call" alt="拨打电话" src="${pageContext.request.contextPath}/static/images/weixin/ic_call.png">
			</div><!-- ct_right end -->
		</div><!-- center_top end -->
		<div class="center_bottom">
			<div class="cbm_info">
				<div class="ct_lf">
					<div class="ic_img"><img class="icon" alt="货物" src="${pageContext.request.contextPath}/static/images/weixin/ic_goods.png"></div>
					<div class="cb_tle" style="width:24%;">货物名称：</div>
					<div class="cb_val" style="width:60%;">${result.data.GOODSNAME }</div>
				</div>
				<div class="ct_lf">
					<div class="cb_tle">招标吨位：</div>
					<div class="cb_val">${result.data.LOADWEIGHT }吨/方</div>
				</div>
				<div class="ct_lf">
					<div class="cb_tle">拦标价：</div>
					<div class="cb_val">${result.data.EXPECTEDPRICE }元/吨</div>
					<!-- <div class="cb_val_rt">已有<span class="red font_weight font16">200</span>竞价</div> -->
				</div>
				<div class="ct_lf">
					<div class="cb_tle">截止时间：</div>
					<div class="cb_val" id="endtime">${result.data.ENDTIME }</div>
				</div>
				<div class="ct_lf">
					<div class="cb_tle">结算方式：</div>
					<div class="cb_val">
							<c:choose>
							<c:when test="${result.data.PAYTYPE eq '0' }">
								回执单现金结算
							</c:when>
							<c:otherwise>
								其他
							</c:otherwise>
							</c:choose>
					</div>
				</div>
				<div class="ct_lf" id="wantBid">
					<div class="cb_tle">我要竞价：</div>
					<div class="cb_val">
						<input type="hidden" id="loginId" value="${loginId}"/>
						<input type="hidden" id="role" value="${role}"/>
						<input type="hidden" id="bidUserId" value="${result.data.USERID}"/>
						<input type="hidden" id="bidIsOld" value="${result.data.BIDSTATUS}"/>
						<input type="hidden" id="bidId" value="${result.data.BIDINFO_ID}"/>
						<input type="hidden" id="hadbidding" value="${hadbidding}"/>
						<input class="in_txt" id="bidPrice" maxlength="6" style="width:60%;font-size:25px;" type="text"/>元/吨
					</div>
				</div>
				<div class="ct_lf" style="color:#F74000;font-size:14px;">
					<div class="cb_tle">交纳保证金：</div><%-- ${result.data.ENDTIME } --%>
					<div class="cb_val" id="endtime"><span style="color:red;font-size:18px;font-weight:bold;">1000</span>元</div>
				</div>
			</div><!-- cbm_info end -->
			<div class="cbm_btn sub_btn" id="sub_btn">提交竞价</div><!-- cbm_btn end -->
		</div><!-- center_bottom end -->
		<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>
	</div><!-- data_center end -->
	<div class="data_bottom">
		<div style="font-size:20px;">本标要求</div>
		<div style="line-height:20px;font-size:14px;margin-top:10px;">
			${result.data.BREMARKS}
		</div>
		<div style="font-size:20px;margin-top:10px;">投标须知</div>
		<div class="linediv" style="line-height:15px;font-size:14px;">
			<p>1、参与招投标的用户必须为平台认证会员。</p>
			<p>2、单次竞价投标，需缴纳1000元/标投标保证金。账户余额不足，无法参与投标。</p>
			<p>3、竞价投标提交后，同一标的不可进行二次投标。</p>
			<p>4、投标结束后，中标者保证金由平台暂时扣除，未中标的会员全额退还保证金。</p>
		</div>
		<div style="font-size:20px;">招标流程</div>
		<div style="margin:0 auto;margin-top:10px;width:94%;"><img style="width:100%;" alt="流程" src="${pageContext.request.contextPath}/static/images/weixin/Process.png"></div>
	</div><!-- data_bottom end -->
</div><!-- data_box end -->
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
	<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/weixin/global.js"></script>
	<script type="text/javascript">
		$(function(){
			///提交数据
			var iscancel=0;
			var btn_val="提交竞价";
			if(!diffAfterDate($("#endtime").html())){
				iscancel=1;
				btn_val="招标已结束";
			/* 	$('#sub_btn').html("招标已结束").css("background-color","rgb(146, 154, 160)");
				$('#sub_btn').removeAttr("id"); */
			}
			if($("#hadbidding").val()=="true"){
				iscancel=1;
				btn_val="您已竞价成功";
				/* $('#sub_btn').html("已竞标成功");
				$('#sub_btn').removeAttr("id");
				$("#wantBid").hide(); */
			}
			if($("#loginId").val()==$("#bidUserId").val()){
				iscancel=1;
				btn_val="内部招标信息";
				/* $('#sub_btn').html("内部招标信息").css("background-color","rgb(146, 154, 160)");
				$('#sub_btn').removeAttr("id");
				$("#wantBid").hide(); */
			}
			if($("#role").val()!="enterprise"){
				iscancel=1;
				btn_val="物流企业才能竞标";
				/* $('#sub_btn').html("物流企业才能竞标").css("background-color","rgb(146, 154, 160)");
				$('#sub_btn').removeAttr("id");
				$("#wantBid").hide(); */
			}
			if("#bidIsOld"=="4"){
				iscancel=1;
				btn_val="废标";
				/* $('#sub_btn').html("废标").css("background-color","rgb(146, 154, 160)");
				$('#sub_btn').removeAttr("id");
				$("#wantBid").hide(); */
			}
			if($("#loginId").val()==""){
				iscancel=1;
				btn_val="未登录,请绑定登录";
				/* $('#sub_btn').html("未登录,请绑定登录").css({"background-color":"rgb(146, 154, 160)"}); */
			/* 	$('#sub_btn').removeAttr("id").click(function(){
					window.close();
				}); */
			}
			if(iscancel>0){
				 $('#sub_btn').html(btn_val).css("background-color","rgb(146, 154, 160)");
				$('#sub_btn').removeAttr("id");
				$("#wantBid").hide(); 
			}
			$("#sub_btn").click(function(){
				if(!checkInfo()){
					return;
				}
					$("#loading").show();
					$("#sub_btn").hide();
					$.ajax({
						url: "${pageContext.request.contextPath}/weixin/bidBiz/saveBiddingInfo",
						data:{BIDID:$("#bidId").val(),BIDDINGPRICE:$("#bidPrice").val()*1},
						type:'post',
						dataType:'json',
						cache : false,
						success:function(data){
								if(data.state=="1"){
										$("#loadtext").html("保存成功");
										$('#sub_btn').html("竞价成功");
										$('#sub_btn').unbind();
									}else{
										$("#loadtext").html(data.message);
								}
								window.setTimeout(altmesg, "1000");
						}
					});
			});
			window.altmesg=function(){
				  $("#sub_btn").show();
					$("#loading").hide();
					$("#loadtext").html("加载中，请稍等！");
			  };
		});
		window.checkInfo=function(){
			var isnul = true;
			isnul = isnul && $("#bidPrice").valid({
				methods : "required|isdecimal",tipSide : "3"
			});
			if(isnul){
					var money = $("#bidPrice").val() * 1;
					if (money <1) {
						$("#bidPrice").tips({
							side : 3,
							msg : '充值金额必须大于1元！',
							bg : '#AE81FF',
							time : 2
						});
					isnul = false;
					}
			}
			return isnul;
	};
	</script>
</body>
</html>
