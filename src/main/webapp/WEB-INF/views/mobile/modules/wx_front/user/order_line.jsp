<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<title>我的订阅</title>

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
	text-align: left;
	float: left;
}

hr {
	margin: 0px;
	clear: both;
	border:1px solid #CCC;
}

.input_full {
	width: 80%;
}

.input_load {
	width: 40%;
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
	line-height: 35px;
}

.span_flt_right {
	float: right;
	text-align: left;
	width: 10%;
}

.regbt {
	width: 85%;
	height: 35px;
	border: solid 1px;
	color: #FFFFFF;
	background: #F74000;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}

.icon {
	float: left;
	width: 26px;
	height: 26px;
	margin-top: 7px;
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
							<td align="right">订阅线路1：</td>
							<td><img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/local.png" /><input
								type="text" readonly="readonly" placeholder="请选择省市"
								id="fromAddress1" class="input_full" value="${result.data.fromAddress1 }" />
								<hr> <img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />
								<input type="text" id="toAddress1" readonly="readonly"
								placeholder="请选择省市" class="input_full" value="${result.data.toAddress1 }" /></td>
						</tr>
						<tr>
							<td align="right">订阅线路2：</td>
							<td><img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/local.png" /><input
								type="text" readonly="readonly" placeholder="请选择省市"
								id="fromAddress2" class="input_full" value="${result.data.fromAddress2 }" />
								<hr> <img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />
								<input type="text" id="toAddress2" readonly="readonly"
								placeholder="请选择省市" class="input_full" value="${result.data.toAddress2 }" /></td>
						</tr>
						<tr>
							<td align="right">订阅线路3：</td>
							<td><img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/local.png" /><input
								type="text" readonly="readonly" placeholder="请选择省市"
								id="fromAddress3" class="input_full" value="${result.data.fromAddress3 }" />
								<hr> <img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />
								<input type="text" id="toAddress3" readonly="readonly"
								placeholder="请选择省市" class="input_full" value="${result.data.toAddress3 }" /></td>
						</tr>
						<tr>
							<td align="right">载重：</td>
							<td><input type="text" placeholder="最低载重" id="MINWEIGHT"
								class="input_load" value="${result.data.MINWEIGHT }" /><span
								style="float:left;width:10%;">至</span> <input type="text"
								placeholder="最高载重" class="input_load" id="MAXWEIGHT"
								value="${result.data.MAXWEIGHT }" /><span class="span_flt_right">吨</span></td>
						</tr>
					</tbody>
				</table>
			</form>
			<div id='loading'
				style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				<button class="regbt" id="fabu">
					<span style="margin-top: -1px;">保&nbsp;存</span>
				</button>
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
		//********************************************************初始化地区********************************************************//

		$("#fromAddress1").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + " ";
				}
				if (data.city) {
					str += data.city.NAME;
				}
				if(str!=" "){
					$("#fromAddress1").val(str);
				}else{
					$("#fromAddress1").val("");
				}
			}
		});

		$("#toAddress1").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + " ";
				}
				if (data.city) {
					str += data.city.NAME;
				}
				if(str!=" "){
					$("#toAddress1").val(str);
				}else{
					$("#toAddress1").val("");
				}
			}
		});
		$("#fromAddress2").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + " ";
				}
				if (data.city) {
					str += data.city.NAME;
				}
				if(str!=" "){
					$("#fromAddress2").val(str);
				}else{
					$("#fromAddress2").val("");
				}
			}
		});

		$("#toAddress2").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + " ";
				}
				if (data.city) {
					str += data.city.NAME;
				}
				if(str!=" "){
					$("#toAddress2").val(str);
				}else{
					$("#toAddress2").val("");
				}
			}
		});
		$("#fromAddress3").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME+" ";
				}
				if (data.city) {
					str +=  data.city.NAME;
				}
				if(str!=" "){
					$("#fromAddress3").val(str);
				}else{
					$("#fromAddress3").val("");
				}
			}
		});

		$("#toAddress3").PCC({
			hasCounty : false,
			width : "85%",
			height : 325,
			//color: "blue"
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME+" ";
				}
				if (data.city) {
					str += data.city.NAME;
				}
				if(str!=" "){
					$("#toAddress3").val(str);
				}else{
					$("#toAddress3").val("");
				}
			}
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$("#loading").hide();
			$("#fabu").click(function() {
								if (isnull()) {
									$("#loading").show();
									$("#fabu").hide();
									var fromAdd="";
									if($("#fromAddress1").val()!=""){
										fromAdd=$("#fromAddress1").val()+"-"+$("#toAddress1").val();
									}
									if($("#fromAddress2").val()!=""){
										fromAdd+=","+$("#fromAddress2").val()+"-"+$("#toAddress2").val();
									}
									if($("#fromAddress3").val()!=""){
										fromAdd+=","+$("#fromAddress3").val()+"-"+$("#toAddress3").val();
									}
									
									var Data = {};
									if($("#MINWEIGHT").val()!=""){
										Data.MINWEIGHT= $("#MINWEIGHT").val();
									}
									if( $("#MAXWEIGHT").val()!=""){
										Data.MAXWEIGHT = $("#MAXWEIGHT").val();
									}
									Data.SUBSCRIPTIONLINE = fromAdd;
									$.ajax({
												url : "${pageContext.request.contextPath}/weixin/user/saveSubLine",
												data : Data,
												type : 'post',
												dataType : 'json',
												cache : false,
												success : function(data) {
													if(data.state=="1"){
														$("#loadtext").html("保存成功");
													}else{
														$("#loadtext").html("保存失败");
													}
													window.setTimeout(altmesg, "1000");
												}
											});
								}
							});
			window.altmesg=function(){
				  $("#fabu").show();
					$("#loading").hide();
					$("#loadtext").html("小卓正在努力加载，请稍等！");
			  };
			window.isnull = function() {
				var isnul = true;
				if($("#MINWEIGHT").val()!=""){
					isnul = isnul && $("#MINWEIGHT").valid({
						methods : "isdecimal",tipSide : "3"
					});
				}
				if($("#MAXWEIGHT").val()!=""){
					isnul = isnul && $("#MAXWEIGHT").valid({
						methods : "isdecimal",tipSide : "3"
					});
					if($("#MINWEIGHT").val()*1>$("#MAXWEIGHT").val()*1){
						$("#MAXWEIGHT").tips({
							side : 3,
							msg : "最大载重必须大于最小载重！",
							bg : '#FF5080',
							time : 3
						});
						isnul=false;
					}
				}
				return isnul;
			};
		});
	</script>
</body>
</html>
