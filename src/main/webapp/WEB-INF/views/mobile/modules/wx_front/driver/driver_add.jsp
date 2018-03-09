<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>编辑司机</title>

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
<link href="static/css/weixin/global.css" rel="stylesheet" type="text/css">
<style type="text/css">
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
.small_img{
	width:40px;
	height:40px;
}
.img_text {
    font-size: 0.4em;
    width: 40px;
    text-align: center;
    background-image: url(/static/images/weixin/pic_bg_normal.png);
    height: 40px;
    background-repeat: no-repeat;
    line-height: 40px;
    background-size: 40px;
    margin: 5px;
    float: left;
    cursor: pointer;
    position:relative ;
}
.img_t {
    color: rgba(37, 35, 35, 0.57);
    position: absolute;
    bottom: 0px;
    width: 40px;
    height: 28px;
}
.icon {
	float: left;
	width: 26px;
	height: 26px;
	margin-top: 7px;
}
.input_load{
	width:70%;
}
.driver_div{
	width:70%;
	float:left;
	word-break:break-all; width:70%;
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
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="35%" style="text-align:right;">
						<col width="60%" style="text-align:right;">
					</colgroup>
					<tbody>
						<tr>
							<td align="right"><span class="font-red">*</span>司机姓名：</td>
							<td>
								<input id="driverName" name="DRIVERNAME" class="input_full" placeholder="请输入司机姓名"
								type="text" value="${result.data.DRIVERNAME!=null?result.data.DRIVERNAME:'' }"> 
								<input type="hidden" name="DRIVERID" value="${result.data.DRIVERID }"/>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>身份证号：</td>
							<td>
									<input type="text" name="IDCARDNUM" placeholder="请输入身份证号" class="input_full" maxlength="18" />
							</td>
						</tr>
						<tr>
							<td align="right">手机号码：</td>
							<td>
									<input type="text" name="DRIVERMOBILE" id="DRIVERMOBILE"  class="input_full"
										maxlength="11" placeholder="请输入手机号">
							</td>
						</tr>
						<tr>
							<td align="right">司机头像：</td>
							<td>
									<input type="hidden" name="DRIVERHEADIMG" id="DRIVERHEADIMG"/>
									<c:choose>
										<c:when test="${not empty result.data.DRIVERHEADIMG }">
											<div class="img_text" id="driverHeadImg" onclick="uploadImg('driverHeadImg','DRIVERHEADIMG')"><img src="${pageContext.request.contextPath}/upload/${pd.driverHeadImg}" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="driverHeadImg" onclick="uploadImg('driverHeadImg','DRIVERHEADIMG')"><div class="img_t">头像</div></div>
										</c:otherwise>
								</c:choose>
									<!-- <div class="img_text"><div class="img_t">驾驶证</div></div> -->
							</td>
						</tr>
						<tr>
							<td align="right">身份证照：</td>
							<td>
								<input type="hidden" name="IDCARDIMG1" id="IDCARDIMG1"/>
								<input type="hidden" name="IDCARDIMG2" id="IDCARDIMG2"/>
								<c:choose>
										<c:when test="${not empty result.data.idCarImg1 }">
											<div class="img_text" id="idCarImg1" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="idCarImg1" onclick="uploadImg('idCarImg1','IDCARDIMG1')"><div class="img_t">正面</div></div>
										</c:otherwise>
								</c:choose>
								<c:choose>
										<c:when test="${not empty result.data.idCarImg2 }">
											<div class="img_text" id="idCarImg2" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="idCarImg2" onclick="uploadImg('idCarImg2','IDCARDIMG2')"><div class="img_t">反面</div></div>
										</c:otherwise>
								</c:choose>
								<!-- <div class="img_text"><div class="img_t">正面</div></div>
								<div class="img_text"><div class="img_t">反面</div></div> -->
							</td>
						</tr>
						<tr>
							<td align="right">驾驶证照：</td>
							<td>
								<input type="hidden" name="DRIVERLICIMG1" id="DRIVERLICIMG1"/>
								<input type="hidden" name="DRIVERLICIMG2" id="DRIVERLICIMG2"/>
								<c:choose>
										<c:when test="${not empty result.data.driverLicImg1 }">
											<div class="img_text" id="driverLicImg1">
												<img src="${pageContext.request.contextPath}/upload/${result.data.driverLicImg1}" class="upimg"/>
											</div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="driverLicImg1" onclick="uploadImg('driverLicImg1','DRIVERLICIMG1')"><div class="img_t">正面</div></div>
										</c:otherwise>
								</c:choose>
								<c:choose>
										<c:when test="${not empty result.data.driverLicImg2 }">
											<div class="img_text" id="driverLicImg2" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="driverLicImg2" onclick="uploadImg('driverLicImg2','DRIVERLICIMG2')"><div class="img_t">反面</div></div>
										</c:otherwise>
								</c:choose>
								
								<!-- <div class="img_text"><div class="img_t">正面</div></div>
								<div class="img_text"><div class="img_t">反面</div></div> -->
							</td>
						</tr>
					</tbody>
				</table>
			<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
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
	src="${pageContext.request.contextPath}/static/js/weixin/global.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/weixin/weiXinUpload.js"></script>
<script type="text/javascript">
$(function(){
	$("#loading").hide();
	$("#fabu").click(function() {
		if (isnull()) {
			$("#loading").show();
			$("#fabu").hide();
			var IDCARDIMG=$("input[name=IDCARDIMG1]").val()+";"+$("input[name=IDCARDIMG2]").val();
			var DRIVERHEADIMG=$("input[name=DRIVERHEADIMG]").val();
			var DRIVERLICIMG=$("input[name=DRIVERLICIMG1]").val()+";"+$("input[name=DRIVERLICIMG2]").val();
			var data = {
					DRIVERID:$("input[name=DRIVERID]").val(),
					DRIVERNAME:$("input[name=DRIVERNAME]").val(),
					DRIVERMOBILE:$("input[name=DRIVERMOBILE]").val(),
					IDCARDNUM:$("input[name=IDCARDNUM]").val(),
					DRIVERLICIMG:DRIVERLICIMG,
					IDCARDIMG:IDCARDIMG,
					DRIVERHEADIMG:DRIVERHEADIMG
				};
			$.ajax({
				url: "${pageContext.request.contextPath}/weixin/driver/saveDriver",
				data:data,
				type:'post',
				dataType:'json',
				cache : false,
				success:function(data){
						if(data.state=="1"){
								$("#loadtext").html("保存成功");
							}else{
								$("#loadtext").html(data.message);
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
	window.isnull=function() {
		var isnul = true;
		isnul = isnul && $("input[name=DRIVERNAME]").valid({
			methods : "required|isName",tipSide : "3"
		});
		isnul = isnul && $("input[name=IDCARDNUM]").valid({
			methods : "required|isIDCard",tipSide : "3"
		});
		isnul = isnul && $("input[name=DRIVERMOBILE]").valid({
			methods : "required|isPhone",tipSide : "3"
		});
		return isnul;
	};
	});
</script>
</body>
</html>
