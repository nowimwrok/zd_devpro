<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="">

<title>--支付运费</title>

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
	margin-bottom:50px;
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
    line-height:40px;
    text-align: right;
    background:rgba(241, 234, 234, 0.67);
}
.in_txt{
	border-bottom:1px solid #CCC;
	height:40px;
	font-size:16px;
	width:50%;
}
</style>
</head>

<body>
	<div class="data_box data_box0">
		<div class="dt_top">
			<div class="flt" style="padding-left:10px;">运单:<span id="orderNo">${result.data.ORDERNO }</span></div>
			<div class="frt" style="padding-right:10px;">${result.data.SHORTTIME }</div>
		</div>
		<div class="data_title">承运方信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">账号：</div>
				<div class="cb_val">
					<div>${result.data.BUYERCOMPANYNAME }</div>
					<div>
						<c:choose>
							<c:when test="${result.data.BUYERSTATUS eq '2' }">
								<span class="authened">已认证</span>
							</c:when>
							<c:otherwise>
								<span class="unauthen">未认证</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<img id="imgCredit"
							src="${pageContext.request.contextPath}/static/images/commom/wlpt/pointlevel/point_level_${result.data.SELLERLEVEL!=null?result.data.BUYERLEVEL:'1' }.gif" />
					</div>
				</div>
				<!--cb_val end  -->
			</div>
			<!--ct_lf end  -->
		</div>
		<!--data_cent end  -->
		<div class="data_title">交易信息
		</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="ic_img">
					<img alt="货物"
						src="${pageContext.request.contextPath}/static/images/weixin/ic_goods.png">
				</div>
				<!--ic_img end  -->
				<div>${result.data.GOODSNAME }</div>
				<div>${result.data.GOODS_LOADWEIGHT }${result.data.GOODS_WEIGHTUNIT }</div>
			</div>
			<!--ct_lf end  -->
			<div class="ct_lf">
				<div class="cb_tle">支付运费：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">￥<span id="payMoney">${result.data.TOTALCOST }</span></div>
				<div class="cb_tle"></div>
				<div id="eromsg" class="cb_val red" style="font-size:14;font-weight:bold;display:none">账户余额不足!</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">油气金额：</div>
				<div class="cb_val"><input type="text" id="OGMONEY" name="OGMONEY" class="in_txt" />元</div>
			</div>
		</div>
		<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
	</div>
		<!--data_cent end  -->
		<c:if test="${loginId ne 'a1' }">
			<c:if test="${result.data.SUPPLIERID eq loginId}">
				<div class="sub_btn" id="Orderpay">确认支付</div>
			</c:if>
		</c:if>
		<div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">支付须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、确认承运方账户是否正确。</p>
				<p>2、确认支付运费是否与无误。</p>
				<p>3、确认平台余额是否充足，余额不足请及时充值。</p>
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
		src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
<script type="text/javascript">
$(function(){
	$("#loading").hide();
	var webPetrol='${session.USERPD.PETROLBALANCE}';
	$("#Orderpay").click(function(){
		if(!checkInfo()){
			return ;
		}
		$("#loading").show();

		$.ajax({
			url : "${pageContext.request.contextPath}/weixin/trade/editOrder",
			data : {ORDERNO:$("#orderNo").html(),ORDERSTATUS:5,payMoney:$("#payMoney").html()*1,OGMONEY:($("#OGMONEY").val()*1)},
			type : 'post',
			dataType : 'json',
			cache : false,
			async:false,
			success : function(data) {
				if (data.state == "1") {
					$("#loadtext").html("保存成功");
				} else {
					$("#loadtext").html(data.message);
					$("#eromsg").html(data.message).show();
				}
				window.setTimeout(altmesg(data.state), 3000);
			}
		});
	});
	
	window.checkInfo=function(){
		var isnul = true;
		isnul = isnul && $("#OGMONEY").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		if((webPetrol<$("#OGMONEY").val()*1)&&($("#OGMONEY").val()*1)!=0){
			$("#OGMONEY").tips({
				side : 3,
				msg : '油气余额不足！',
				bg : '#AE81FF',
				time : 2
			});
			isnul = false;
		}
		return isnul;
};
	
	
	window.altmesg = function(state) {
		if(state=="1"){
			$("#Orderpay").hide();
			window.location.href="${pageContext.request.contextPath}/weixin/trade/order_list";
		}else{
			$("#Orderpay").show();
		}
		$("#loading").hide(); 
		$("#loadtext").html("小卓正在努力加载，请稍等！"); 
	};
});
</script>
</html>
