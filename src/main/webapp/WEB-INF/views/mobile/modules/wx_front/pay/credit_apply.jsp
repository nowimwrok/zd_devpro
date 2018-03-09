<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>--授信</title>

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
	background-image: url(./static/images/weixin/pic_bg_normal.png);
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
				<div style="border-bottom: 1px solid #EBEBEB;width:100%;">
					<div class="cb_tle">账号名称：</div>
					<div class="cb_val">
						<div>${userPd.CompanyName!=null?userPd.CompanyName:userPd.NAME
							}</div>
						<%-- <div>
						<c:choose>
							<c:when test="${userPd.STATUS eq '2' }">
								<span class="authened">已认证</span>
							</c:when>
							<c:otherwise>
								<span class="unauthen">未认证</span>
							</c:otherwise>
						</c:choose>
					</div> --%>
						<div>
							<img id="imgCredit"
								src="${pageContext.request.contextPath}/static/images/commom/wlpt/pointlevel/point_level_${userPd.PointLevel!=null?userPd.PointLevel:'0' }.gif" />
						</div>
					</div>
				</div>
				<!--cb_val end  -->
				<div style="width:100%;border-bottom: 1px solid #EBEBEB;">
					<div class="cb_tle">授信余额：</div>
					<div class="cb_val" style="color:#FFBB66;">${creditPd.AVAILABLECREDIT!=null?creditPd.AVAILABLECREDIT:'0'
						}元</div>
				</div>
			</div>
			<!--ct_lf end  -->
		</div>
		<!--data_cent end  -->
		<!-- 		<div class="data_title">充值信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">充值金额：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					￥<input type="text" id="payMoney" value="0.01" />
				</div>
			</div>
		</div> -->
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='static/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<!--data_cent end  -->
		<div class="sub_btn" id="applyCredit" onclick="applyCredit()"
			style="background:rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">申请授信</div>
		<div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">申请须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、确认账户是否正确。</p>
				<p>2、确认账户基本信息是否完善。</p>
				<p>3、授信额度是可用于支付运费,申请授信后请耐心等待工作人员审核。</p>
				<p>4、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$("#loading").hide();
	function applyCredit() {
		$("#applyCredit").attr("disabled", "disabled");
		$
				.ajax({
					url : "${pageContext.request.contextPath}/weixin/user/creditapply_save",
					data : "",
					dataType : 'json',
					cache : false,
					type : "POST",
					success : function(data) {
						if (data.state == '1') {
							alert("授信申请提交成功,请耐心等候平台审核...");
						} else {
							$("#applyCredit").removeAttr("disabled");
							alert(data.message);
						}
					}

				});
	}
</script>

</html>
