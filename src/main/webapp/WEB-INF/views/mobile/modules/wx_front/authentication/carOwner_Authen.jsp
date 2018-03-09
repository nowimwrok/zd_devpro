<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--车主认证</title> 

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

<script type="text/javascript" src="${ctxStatic}weixin/js/weixin/errorpage.js"></script>
<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div 布局*/
.data_box {
	width: 100%;
	margin: 0 auto;
}

.data_top,.data_center,.data_bottom {
	width: 100%;
	clear: both;
	margin: 0 auto;
	background-color: #FFF;
}

.data_top {
	width: 100%;
	height: 50px;
	line-height: 50px;
	padding-left: 3%;
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
	float: left;
	width: 25%;
	height: 45px;
	position: relative;
}

.ic_img img {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	margin: auto;
}

.center_top,.center_bottom {
	width: 100%;
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
	line-height: 75px;
}

.split {
	clear: both;
	width: 100%;
	border: 1px solid #CCC;
}

.ct_lf {
	clear: both;
	height: 40px;
	line-height: 35px;
}

.ct_lf div {
	float: left;
}

.ct_lf .input_contet {
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
	width: 25%;
	height: 40px;
	line-height: 40px;
	text-align: right;
}

.cb_val {
	width: 74%;
	height: 40px;
	line-height: 40px;
	border-bottom: 1px solid #CCC;
}

.cb_val input {
	width: 90%;
	float: left;
	line-height: 42px;
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

.data_tab div {
	float: left;
	text-align: center;
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

.data_title {
	clear: both;
	font-size: 16px;
	background: #EBEBEB;
	height: 35px;
	line-height: 35px;
	width: 100%;
	margin-top: 10px;
	text-indent: 10px;
}

.data_title span {
	color: red;
}

.input_contet {
	float: left;
	width: 74%;
}

.input_contet div {
	height: 40px;
	width: 100%;
	border-bottom: 1px solid #CCC;
}

.input_contet div input {
	height: 40px;
	width: 100%;
}

.with_unitl {
	width: 74%;
}

.cbm_btn {
	margin-bottom: 20px;
	bottom: 20px;
}

.img_text {
	font-size: 0.4em;
	width: 40px;
	text-align: center;
	background-image: url(${ctxStatic}/images/weixin/pic_bg_normal.png);
	height: 40px;
	background-repeat: no-repeat;
	line-height: 40px;
	background-size: 40px;
	margin: 5px;
	float: left;
	cursor: pointer;
	position: relative;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 40px;
	height: 28px;
}

.img_vh {
	height: 50px;
	line-height: 50px;
}
.upimg{
	width:40px;
	height:40px;
}
</style><script>
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
	<div class="data_box">
		<!-- data_top end -->
		<div id="data">
			<div class="data_center">
				<div class="center_bottom">
					<div class="cbm_info">
						<div class="data_title" style="margin:0px;">
							个人信息<span>*</span>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">真实姓名：</div>
							<div class="cb_val">
								<input type="text" name="NAME" maxlength="20"
									value="${user.driver.drivername}" placeholder="请输入真实姓名" />
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">手机号码：</div>
							<div class="cb_val">
								<input type="text" maxlength="11" id="PHONE" name="PHONE"
									value="${user.driver.drivermobile}" />
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">身份证：</div>
							<div class="cb_val">
								<input type="text" name="IDCARDNUM" id="IDCARDNUM" maxlength="18"
									value="${user.driver.idcardnum}" placeholder="请输入身份证或驾驶证号码" />
							</div>
						</div>


						<div class="data_title">
							上传图片<span>*</span>
						</div>
						<div class="ct_lf">
							<div class="cb_tle img_vh">身份证：</div>
							<div class="cb_val img_vh">
								<input type="hidden" name="IDCARDIMG1" id="IDCARDIMG1" value=""/> <input
									type="hidden" name="IDCARDIMG2" id="IDCARDIMG2" />
								<c:choose>
									<c:when test="${not empty idcard1}">
										<div class="img_text" id="idCarImg1" onclick="uploadImg('idCarImg1','IDCARDIMG1','','','driver')" class="upimg">
											<img
												src="${idcard1}"
												class="upimg" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="img_text" id="idCarImg1"
											onclick="uploadImg('idCarImg1','IDCARDIMG1','','','driver')">
											<div class="img_t">正面</div>
										</div>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${not empty idcard2}">
										<div class="img_text" id="idCarImg2" onclick="uploadImg('idCarImg2','IDCARDIMG2','','','driver')" class="upimg">
											<img
												src="${idcard2}"
												class="upimg" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="img_text" id="idCarImg2"
											onclick="uploadImg('idCarImg2','IDCARDIMG2','','','driver')">
											<div class="img_t">反面</div>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle img_vh">驾驶证：</div>
							<div class="cb_val img_vh">
								<input type="hidden" name="DRIVERLICIMG1" id="DRIVERLICIMG1" value="${user.driver.driverlicimg}" />
								<%-- <input type="hidden" name="DRIVERLICIMG2" id="DRIVERLICIMG2" value="${driverlic2}"/> --%>
								<c:choose>
									<c:when test="${not empty user.driver.driverlicimg}">
										<div class="img_text" id="driverLicImg1"
											onclick="uploadImg('driverLicImg1','DRIVERLICIMG1','','','driver')">
											<img
												src="${user.driver.driverlicimg}"
												class="upimg" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="img_text" id="driverLicImg1"
											onclick="uploadImg('driverLicImg1','DRIVERLICIMG1','','','driver')">
											<div class="img_t">驾驶证</div>
										</div>
									</c:otherwise>
								</c:choose>
								<%-- <c:choose>
									<c:when test="${not empty driverlic2}">
										<div class="img_text" id="driverLicImg2" class="upimg">
											<img
												src="${driverlic2}"
												class="upimg" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="img_text" id="driverLicImg2"
											onclick="uploadImg('driverLicImg2','DRIVERLICIMG2','','','driver')">
											<div class="img_t">反面</div>
										</div>
									</c:otherwise>
								</c:choose> --%>
							</div>
						</div>

						<div class="ct_lf">
							<div class="cb_tle img_vh">司机头像：</div>
							<div class="cb_val img_vh">
								<input type="hidden" name="CARSURFACEIMG1" id="CARSURFACEIMG1"
									value="${user.driver.driverheadimg }" /> 
								<c:choose>
									<c:when test="${not empty user.driver.driverheadimg }">
										<div class="img_text" id="CarSurfaceImg1"
											onclick="uploadImg('CarSurfaceImg1','CARSURFACEIMG1','','','driver')">
											<img class="upimg"
												src="${user.driver.driverheadimg}" />
										</div>
									</c:when>
									<c:otherwise>
										<div class="img_text" id="CarSurfaceImg1"
											onclick="uploadImg('CarSurfaceImg1','CARSURFACEIMG1','','','driver')">
											<div class="img_t">头像</div>
										</div>
									</c:otherwise>
								</c:choose>
												
							</div>
						</div>
					</div>
				</div>
				<!-- center_bottom end -->
			</div>
			<!-- data_center end -->
			<div id='loading'
				style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='${ctxStatic}/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>
			<c:if test="${STATUS!='1' && STATUS!='2'}">
			<div class="cbm_btn sub_btn" id="sub_btn">提交</div>
			</c:if>
			<c:if test="${STATUS=='3' and not empty quality}"> 
				<p><span style="color:red;">您的上一次审核不通过,审核结果:${quality.certifycomment }</span></p>
			</c:if>
			<c:if test="${STATUS=='1'}"> 
				<div class="cbm_btn sub_btn"  style="background: #666666;">认证中</div></c:if>
			<c:if test="${STATUS=='2'}"> 
				<div class="cbm_btn sub_btn" style="background: #666666;">认证通过</div></c:if>
			<input type="hidden" id="userStatus" name="userStatus"
				value="${STATUS}" />
		</div>
	</div>
	<!-- data_box end -->
	<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/myjs/wlpt/config.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/global.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.gridSelector.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"
		src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/weiXinUpload.js"></script>
	<script type="text/javascript">
	</script>
	<script type="text/javascript">
		$(function() {
			if($("#userStatus").val()=="2" || $("#userStatus").val()=="1"){
				$("#sub_btn").hide();
				$(".data_box input").unbind().attr("readonly","readonly");
			}
			$("#loading").hide();
			$("#sub_btn").click(function() {
				if (isnull()) {
					$("#loading").show();
					$("#sub_btn").hide();
					/*真实姓名*/
					var NAME = $("input[name=NAME]")
							.val();
					/*电话号码*/
					var PHONE = $("input[name=PHONE]")
							.val();
					/*身份证*/
					var IDCARDNUM = $(
							"input[name=IDCARDNUM]").val();
					/*身份证*/
					var IDCARDIMG="|"+$("input[name=IDCARDIMG1]").val()+"|"+$("input[name=IDCARDIMG2]").val();
					/*驾驶证*/
					var DRIVERLICIMG=$("input[name=DRIVERLICIMG1]").val();
					/*头像*/
					var CARSURFACEIMG=$("#CARSURFACEIMG1").val();
					/*始发地*/
					var authenData = {
							"driver.drivername" : NAME,
							"driver.idcardnum" : IDCARDNUM,
							"driver.drivermobile" : PHONE,
							"driver.idcardimg" : IDCARDIMG,
							"driver.driverlicimg" : DRIVERLICIMG,
							"driver.driverheadimg" : CARSURFACEIMG
					};
					$.ajax({
						url : "${wx}/weixin/authentication/percarAuthentication",
						data : authenData,
						type : 'post',
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.state == "1") {
								$("#loadtext").html(
										"保存成功");
							} else {
								$("#loadtext").html(
										"保存失败");
							}
							window.setTimeout(altmesg,
									"1000");
						}
					});
				}
			});
			window.altmesg = function() {
				window.location.href = "${wx}/weixin/user/userHome";
				$("#sub_btn").show();
				$("#loading").hide();
				$("#loadtext").html("小运正在努力加载，请稍等！");
			};
			window.isnull = function() {
				var IDCARDIMG=$("input[name=IDCARDIMG1]").val()+"|"+$("input[name=IDCARDIMG2]").val();
				/*驾驶证*/
				var DRIVERLICIMG=$("input[name=DRIVERLICIMG1]").val()+"|"+$("input[name=DRIVERLICIMG2]").val();
				/*头像*/
				var CARSURFACEIMG=$("#CARSURFACEIMG1").val();
				var isnul = true;
				isnul = isnul && $("input[name=NAME]").valid({
					methods : "required|isName",
					tipSide : "3"
				});
				isnul = isnul && $("input[name=PHONE]").valid({
					methods : "required|isPhone",
					tipSide : "3"
				});
				isnul = isnul && $("input[name=IDCARDNUM]").valid({
					methods : "required|isIDCard",
					tipSide : "3"});
		
 				if($("input[name=IDCARDIMG1]").val()==""||$("input[name=IDCARDIMG2]").val()==""){
					$("#idCarImg1").tips({
						side : 3,
						msg : '请上传正反两面图片！',
						bg : '#FF7300',
						time : 2
					});
					isnul=false;
				}
				if($("input[name=DRIVERLICIMG1]").val()==""||$("input[name=DRIVERLICIMG2]").val()==""){
					$("#driverLicImg1").tips({
						side : 3,
						msg : '请上传正反两面图片！',
						bg : '#FF7300',
						time : 2
					});
					isnul=false;
				}

				if($("#CARSURFACEIMG1").val()=="" || $("#CARSURFACEIMG1").val()==""){
					$("#CarSurfaceImg1").tips({
						side : 3,
						msg : '请上传正反两面人车合照图片！',
						bg : '#FF7300',
						time : 2
					});
					isnul=false;
				} 
				return isnul;
			};
		});
	</script>
</body>
</html>
