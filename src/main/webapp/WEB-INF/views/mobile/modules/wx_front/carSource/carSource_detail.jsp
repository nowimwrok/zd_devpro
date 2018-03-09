<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>车源详情</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-con trol" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<style type="text/css">
body {
	padding: 0px;
	margin: 0px;
}

.font-red {
	color: Red
}

input {
	border: none;
	font-size: 18px;
	height: 35px;
	line-height: 35px;
	text-align:left;
}
.input_full{
	width:100%;
}
.input_eigth{
	width:80%;
}
table {
	border: 1px solid #CCC;
	width: 95%;
	margin: 5px auto;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}

table tr {
	line-height: 35px;
}

table tr td {
	border-bottom: 1px solid #CCC;
	font-size: 18px;
	line-height:35px;
}
.span_flt_right {
	float: right;
	text-align: left;
	width: 15%;
}
.btn {
	width: 20%;
	height: 35px;
	line-height:35px;
	border: solid 1px;
	color: #FFFFFF;
	font-size:14px;
	background: rgb(32, 134, 226);;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}

</style>
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

</head>
<body>
	<div id="content">
		<%-- <%@ include file="../pagetitle.jsp"%> --%>
		<div>
			<form
				action="${pageContext.request.contextPath}/wlpt/goods/addGoodsSource"
				id="goodsfabu" method="post">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="30%" style="text-align:right;">
						<col width="65%" style="text-align:right;">
					</colgroup>
					<tbody>
						<tr>
							<td align="right"> 车牌号码：</td>
							<td>${result.data.CARNUMBER}
							<input type="hidden" id="statu" name="status" value="${result.data.STATUS }">
									<input type="hidden" id="carSourceId" name="CARSOURCEID" value="${result.data.CARSOURCEID }"></td>
						</tr>
						<tr>
							<td  align="right"> 始发地：</td>
							<td>${result.data.CAR_FROMADDRESS }</td>
						</tr>
						<tr>
							<td align="right">详细地址：</td>
							<td>${result.data.FROMADDRESS}</td>
						</tr>
						<tr>
							<td align="right"> 目的地：</td>
							<td>${result.data.CAR_TOADDRESS }</td>
						</tr>
						<tr>
							<td align="right">详细地址：</td>
							<td>${result.data.TOADDRESS}</td>
						</tr>
						<tr>
							<td align="right"> 发车时间：</td>
							<td>${result.data.DEPARTURETIME }</td>
						</tr>
						<tr>
							<td align="right">车型：</td>
							<td>${result.data.CARTYPE}</td>
						</tr>
						<tr>
							<td align="right"> 车长：</td>
							<td>${result.data.CARLENGTH}米</td>
						</tr>
						<tr>
							<td align="right">载重：</td>
							<td>${result.data.LOADWEIGHT }吨</td>
						</tr>
						<tr>
							<td align="right">剩余载重：</td>
							<td>${result.data.REMAINWEIGHT }吨</td>
						</tr>
						<tr>
							<td align="right"> 有效天数：</td>
							<td>${result.data.EFFECTDAY!=null?result.data.EFFECTDAY:'7'}天</td>
						</tr>
						<tr>
							<td valign="top" align="right">补充说明：</td>
							<td>${result.data.REMARKS }</td>
						</tr>
						<tr>
							<td style="text-align:left;" colspan="2">联系人信息</td>
						</tr>
						<tr>
							<td align="right"> 姓名：</td>
							<td>${result.data.CONTACTNAME }</td>
						</tr>
						<tr>
							<td style="border:none;" align="right"> 手机号码：</td>
							<td style="border:none;">${result.data.CONTACTMOBILE }</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px;display:none;'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;display:none;">
				<button class="btn" id="returnPub">返程发布</button>
				<button class="btn" id="onekeyPub">一键重发</button>
				<button id="edit" class="btn">修&nbsp;&nbsp;改</button>
				<button class="btn" id="delt">删&nbsp;&nbsp;除</button>
				<button class="btn" style="width:93%;display:none;" id="trading">正在交易</button>
			</p>
		</div>
	</div>
	<!-- content-end -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"
	language="javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zDialog/zDialog.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zDialog/zDrag.js"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/myjs/wlpt/config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.gridSelector.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/myjs/global.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){
	var carSourceId=$("#carSourceId").val();
	var status=$("#DEALSTATUS").val();
	if(status==1){
		$("#trading").show();
		$("#returnPub").hide();
		$("#onekeyPub").hide();
		$("#edit").hide();
		$("#delt").hide();
	}
	$("#returnPub").click(function(){
		window.location.href="${pageContext.request.contextPath}/weixin/carSource/carSource_return?CARSOURCEID="+carSourceId;
	});
	$("#onekeyPub").click(function(){
		window.location.href="${pageContext.request.contextPath}/weixin/carSource/carSource_edit?CARSOURCEID="+carSourceId;
	});
	$("#edit").click(function(){
		window.location.href="${pageContext.request.contextPath}/weixin/carSource/carSource_edit?CARSOURCEID="+carSourceId;
	});
	$("#delt").click(function(){
		$("#loading").show();
		$("#returnPub").hide();
		$("#onekeyPub").hide();
		$("#edit").hide();
		$("#delt").hide();
		$.ajax({
			url: "${pageContext.request.contextPath}/weixin/carSource/deltCarSource",
			data:{CARSOURCEID:carSourceId},
			type:'post',
			dataType:'json',
			cache : false,
			success:function(data){
				if(data.state=="1"){
					$("#loadtext").html("删除成功");
					$("#returnPub").hide();
					$("#onekeyPub").hide();
					$("#edit").hide();
					$("#delt").hide().attr("disabled","true");
					$("#trading").html("删除成功").show();
				}else{
					$("#loadtext").html("删除失败");
					$("#returnPub").show();
					$("#delt").show();
					$("#onekeyPub").show();
					$("#edit").show();
				}
				window.setTimeout(altmesg, "1000");
			}
		});
	});
	window.altmesg=function(){
			$("#loading").hide();
			$("#loadtext").html("小卓正在努力加载，请稍等！");
	  };
});

</script>
</body>
</html>
