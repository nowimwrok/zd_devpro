<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>实名认证</title>
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	width: 100%;
	margin: 0 auto;
	text-align: center;
	border: 1px solid #D6D3CE;
	font-family: "微软雅黑";
}

.th_fo_right img {
	width: 100%;
	height: 100%;
}

ul p span a input td {
	font-family: "微软雅黑";
}
</style>
<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/top_menu.css">
<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/personal.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body>
	<div class="content-1 shiming-list">
		<p class="user_data">
			<img src="/static/images/wlptfront/line-left.png"><span
				class="title_blue">实名</span><span class="title_orange">认证</span><img
				src="/static/images/wlptfront/line-right.png">
		</p>
		<div class="list_one">
			<span class="list_one_1"> <c:choose>
					<c:when test="${user.role.enname eq 'enterprise'}">企业认证</c:when>
					<c:when test="${user.role.enname eq 'carowner'}">个人认证</c:when>
					<c:when test="${user.role.enname eq 'goodsowner'}">个人认证</c:when>
					<c:otherwise>个人认证</c:otherwise>
				</c:choose>
			</span> <span class="list_one_2"> <c:if
					test="${user.userinfo.status==0}">未认证</c:if> <c:if
					test="${user.userinfo.status==1}">认证中</c:if> <c:if
					test="${user.userinfo.status==2}">已认证</c:if> <c:if
					test="${user.userinfo.status==3}">未认证</c:if> <c:if
					test="${user.userinfo.status==null}">未认证</c:if>
			</span>
			<c:choose>
				<c:when test="${user.role.enname eq 'enterprise'}">
					<a onclick="enterprise()" class="list_one_3 btn btn-warning"
						id="btn-warning" style="width: 80px;">
				</c:when>
				<c:when test="${user.role.enname eq 'carowner'}">

					<a onclick="carowner()" class="list_one_3 btn btn-warning"
						id="btn-warning" style="width: 80px;">
				</c:when>
				<c:when test="${user.role.enname eq 'goodsowner'}">

					<a onclick="goodsowner()" class="list_one_3 btn btn-warning"
						id="btn-warning" style="width: 80px;">
				</c:when>
				<c:otherwise>
					<a onclick="goodsowner()" class="list_one_3 btn btn-warning"
						id="btn-warning" style="width: 80px;">
				</c:otherwise>
			</c:choose>


			<c:choose>
				<c:when test="${user.userinfo.status==2}">认证信息</c:when>
				<c:otherwise>申请认证</c:otherwise>
			</c:choose>
			</a>
		</div>
	</div>





	<div class="content-2 shiming-list">
		<p class="user_data">
			<img src="/static/images/wlptfront/line-left.png"><span
				class="title_blue">重要</span><span class="title_orange">说明</span><img
				src="/static/images/wlptfront/line-right.png">
		</p>
		<p class="list_two">
			1、您的资料可能会被提交到国家公安机关及其下属单位进行证件真实性核实<br> 2、身份认证一旦通过，不能够取消、删除、修改<br>
			3、企业身份认证一旦通过将与您对应的唯一账户进行绑定，企业身份具有唯一性
		</p>
	</div>




	<div class="content-3 shiming-list">
		<p class="user_data">
			<img src="/static/images/wlptfront/line-left.png"><span
				class="title_blue">个人</span><span class="title_orange">认证示例</span><img
				src="/static/images/wlptfront/line-right.png">
		</p>
		<div class="list_th_fo">
			<p class="th_fo_left" style="line-height: 25px;">
				需要本人手持身份证合影，注意以下几点：<br> 1、建议在光线充足的环境下合影，保证照片清晰不模糊<br>
				2、身份证正面在前，人在后，证件不能遮挡面部，保证证件清晰不模糊<br>
				3、需要完整的身份证正面，保证身份证边缘处于图片内部，姓名、证件号码、照片清晰<br>
				4、可以将照片向前伸，将证件靠近相机镜头，对焦在证件上
			</p>
			<div class="th_fo_right">
				<img src="/static/images/wlptfront/police.png">
				<p>本人手持身份证正面头部照</p>
			</div>
		</div>
	</div>



	<div class="content-4 shiming-list">
		<p class="user_data">
			<img src="/static/images/wlptfront/line-left.png"><span
				class="title_blue">企业</span><span class="title_orange">认证示例</span><img
				src="/static/images/wlptfront/line-right.png">
		</p>
		<div class="list_th_fo">
			<p class="th_fo_left" style="line-height: 25px;">
				需要企业营业执照最新版本，注意以下几点：<br> 1、最好上传企业营业执照的色彩电子版<br>
				2、营业执照复印件电子版需要加盖红色鲜章，并标注作卓大物流资质认证用途<br>
				3、保证营业执照是最新版本，在工商局能够查询到，并且和执照上显示的信息一致<br>
				4、拍照时营业执照纸张边界应处于照片内，右上角“编号”需显示出来<br>
				5、电子版需要保证营业执照的所以文字、二维码和登记机关签章都清晰可辨
			</p>
			<div class="th_fo_right">
				<img src="/static/images/wlptfront/license1.png">
				<p>企业营业执照正面照</p>
			</div>
		</div>
	</div>



	<div class="content-5 shiming-list">
		<p class="user_data">
			<img src="/static/images/wlptfront/line-left.png"><span
				class="title_blue"></span><span class="title_orange">后续</span><img
				src="/static/images/wlptfront/line-right.png">
		</p>
		<p class="list_last" style="line-height: 25px;">
			1、我们有专门的工作人员为您提交的资料进行核对认证<br> 2、如果您没有资质认证，工作人员会通过客服热线与您联系
		</p>
	</div>

	<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"
		type="text/javascript"></script>
	<script
		src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctxStatic}/modules/wlpt/include/jqthumb.min.js"></script>
	<script type="text/javascript">
		var iscompleteinfo = '${user.userinfo.iscompleteinfo}';
		function enterprise() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/tocpy_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请先去个人资料完善信息方可申请认证");
			}
		}
		function carowner() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/tocar_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请先去个人资料完善信息方可申请认证");
			}
		}
		function goodsowner() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/topersonal_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请先去个人资料完善信息方可申请认证");
			}
		}
		$('.th_fo_right img').jqthumb({
			width : 250,
			height : 280,
			after : function(imgObj) {
				imgObj.css('opacity', 0).animate({
					opacity : 1
				}, 1000);
			}
		});
	</script>
</body>
</html>