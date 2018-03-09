<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--充值</title>

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

<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
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
/*整体div -top布局*/
.data_top,.data_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
}

.dt_top,.data_tab {
	clear: both;
	width: 100%;
}

.dt_top {
	height: 40px;
	line-height: 40px;
}

.dt_top div {
	
}

.data_tab div {
	width: 24.5%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}

.bord_rt {
	border-right: 1px solid #CCC;
}

/* 数据中部信息 */
.data_box {
	width: 97%;
	margin: 0 auto;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 14px;
	background: #EBEBEB;
	height: 40px;
	line-height: 40px;
	width: 100%;
	text-indent: 10px;
}

.data_cent {
	width: 96%;
	padding: 5px 0px;
	padding-left: 4%;
}

.ct_lf {
	width: 100%;
	height: 35px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 45px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell
}

.ic_img {
	height: 35px;
	display: table;
}

.ic_img img {
	width: 30px;
	margin-top: 7px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_tle {
	width: 25%;
	text-align: right;
	float: left;
}

.cb_val {
	width: 70%;
	float: left;
}

.val_info {
	width: 30%;
}

.disnone {
	display: none;
}

.img_text {
	font-size: 1em;
	width: 60px;
	text-align: center;
	background-image: url(${ctxStatic}/images/weixin/pic_bg_normal.png);
	height: 60px;
	background-repeat: no-repeat;
	line-height: 35px;
	background-size: 60px;
	margin: 5%;
	float: left;
	cursor: pointer;
	position: relative;
	clear: both;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 60px;
	height: 35px;
}

.upimg {
	width: 60px;
	height: 60px;
}

#imgCredit {
	margin-top: 15px;
}

.up_ct {
	clear: both;
	width: 100%;
	margin-top: 10px;
	height: 50px;
}

.data_bottom {
	bottom: 0px;
	height: 40px;
	line-height: 40px;
	text-align: right;
	background: rgba(241, 234, 234, 0.67);
}

input[type='text'] {
	border-bottom: 1px solid #ccc;
	font-size: 18px;
	line-height: 25px;
	height: 30px;
}
</style>
</head>

<body>
	<div class="data_box data_box0">
		<div class="data_title">账户信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">账号：</div>
				<div class="cb_val">
					<div><span id="usernameval">${user.loginName!=null?user.loginName:user.phone}</span></div>
					<div>
						<c:choose>
							<c:when test="${user.userinfo.status eq '2' }">
								<span class="authened" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">已认证</span>
							</c:when>
							<c:otherwise>
								<span class="unauthen" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">未认证</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<img id="imgCredit"
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_1.gif" />
					</div>
				</div>
				<!--cb_val end  -->
				<div class="cb_tle">可用余额：</div>
				<div class="cb_val">${user.userPurse.availablebalance!=null?user.userPurse.availablebalance:'0.00' }<!-- <div class="regbt" style="width:80px;margin-top:10px;float:right;height:25px;line-height:25px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;"><a href="weixin/cash/toCash" style="font-size:13px;color:white;">申请提现</a></div> -->
				</div>
			</div>
			<!--ct_lf end  -->
		</div>
		<!--data_cent end  -->
		<div class="data_title">充值信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">充值金额：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<div style="float:left;width:10%;">￥</div><div style="float:left;width:80%;padding-top:10px;"><input type="text" id="payMoney" value="0.01" style="width:90%;"/></div>
				</div>
			</div>
		</div>
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='static/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<!--data_cent end  -->
		<div class="sub_btn" id="Orderpay" onclick="callpay()"
			style="background: rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">微信支付</div>
		<div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">支付须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、确认账户是否正确。</p>
				<p>2、确认支付金额是否与无误。</p>
				<p>3、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$("#loading").hide();
	var usernameval = $.trim($("#usernameval").html());
	if (usernameval != null && usernameval != ''
			&& usernameval.length > 8) {
		usernameval = usernameval.substring(0, 7) + "…";
		$("#usernameval").html(usernameval);
	}
	function callpay() {
		//获取预支付单号
		var payMoney = $("#payMoney").val() * 1;
		if (payMoney <= 0) {
			$("#payMoney").tips({
				side : 3,
				msg : '充值金额必须大于0元！',
				bg : '#AE81FF',
				time : 2
			});
		} else {
			$("#loading").show();
			$.ajax({
						type : "POST",
						url : "weixin/pay/orderPostPay",
						data : {
							WIDtotal_fee : payMoney
						}, //参数自己根据业务定义
						dataType : "json",
						success : function callback(data, textStatus) {
							if (data.data.saveMessage == 'success') {
								$("#loading").hide();
								var appId = data.data.appId;
								var timestamp = data.data.timeStamp;
								var nonceStr = data.data.nonceStr;
								var packages = data.data.packages;
								var finalsign = data.data.finalsign;
								var signType = data.data.signType;
							/* 	alert("appId="+data.data.appId);alert("timeStamp="+data.data.timeStamp);
								alert("nonceStr="+data.data.nonceStr);alert("package="+data.data.packages);
								alert("signType="+data.data.signType);alert("paySign="+data.data.finalsign); */
								WeixinJSBridge.invoke('getBrandWCPayRequest',
									{
										"appId" : appId,
										"timeStamp" : timestamp,
										"nonceStr" : nonceStr,
										"package" : packages,
										"signType" : signType,
										"paySign" : finalsign
									},function(res) {
										WeixinJSBridge.log(res.err_msg);
										if (res.err_msg == "get_brand_wcpay_request:ok") {
											alert("支付成功!");
											WeixinJSBridge.call('closeWindow');
										} else if (res.err_msg == "get_brand_wcpay_request:cancel") {
											alert("用户取消支付!");
										} else {
											alert("支付失败!");
											WeixinJSBridge.call('closeWindow');
										}
									});
							}else{
								alert("支付失败!");
							}
							//自动关闭微信浏览器
							WeixinJSBridge.call('closeWindow');
						}
					});
		}
	}
</script>

</html>
