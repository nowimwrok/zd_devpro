<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head> 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>个人认证</title>
<link rel="stylesheet" type="text/css"
	href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">
<link rel="stylesheet" type="text/css"
	href="${ctxStatic }/modules/wlpt/front/css/personal.css">
<link rel="stylesheet" type="text/css"
	href="${ctxStatic }/modules/wlpt/front/css/top_menu.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	width: 100%;
	margin: 0 auto;
	text-align: center;
	border: 1px solid #D6D3CE;
	font-family: "微软雅黑"
}

input[type="text"] {
	width: 40%;
	text-indent: 5px;
}

ol li img {
	height: 165px;
}
</style>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
	type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js"
	type="text/javascript"></script>
</head>
<body>
	<p class="user_data">
		<img src="${ctxStatic }/images/wlptfront/line-left.png"><span
			class="title_blue">个人</span><span class="title_orange">认证</span><img
			src="${ctxStatic}/images/wlptfront/line-right.png">
	</p>
	<form:form id="inputForm" modelAttribute="user"
		action="${wlpt}/wlpt/user/save" method="post" class="form-horizontal">

		<table class="user-infor" style="line-height: 40px;">

			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>姓名:</td>
				<td class="user_infor_right"><form:input id="name" path="name"
						htmlEscape="false" maxlength="10" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>身份证:</td>
				<td class="user_infor_right"><form:input id="identitycard"
						path="userinfo.identitycard" placeholder="请输入身份证"
						htmlEscape="false" maxlength="18" class="input-xlarge " /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>手机号码:</td>
				<td class="user_infor_right"><input value="${user.phone}"
					type="text" class="input-xlarge" readonly="true"/></td>
			</tr>

			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>身份证:</td>
				<td class="user_infor_right"><img
					src="${ctxStatic }/images/wlptfront/photo.png" class="photo_up"><span>图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</span>
				</td>
			</tr>


			<tr>
				<td colspan=2>
					<div class="controls">
						<form:hidden id="slocalphoto"
							path="userinfo.userIdcard.slocalphoto" htmlEscape="false"
							maxlength="255" class="input-xlarge" />
						<c:choose>
							<c:when
								test="${user.userinfo.status==1||user.userinfo.status==2}">
								<sys:ckfinder input="slocalphoto" type="images"
									uploadPath="/useridcard" selectMultiple="false" maxWidth="165"
									maxHeight="165" readonly="true" />
							</c:when>
							<c:otherwise>
								<sys:ckfinder input="slocalphoto" type="images"
									uploadPath="/useridcard" selectMultiple="false" maxWidth="165"
									maxHeight="165" btnName="上传照片" />
							</c:otherwise>
						</c:choose>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<button type='button' class="btn btn-defalut btn-warning"
						onclick="save()" id="btn-warning">申请认证</button>
				</td>
			</tr>
			<c:if test="${us.userinfo.status=='3' and not empty us}">
			<tr>
				<td colspan="2">
					
					您的上一次审核不通过,审核结果:${quality.certifycomment }
					
				</td>
			</tr>
			</c:if>
		</table>
	</form:form>

	<script type="text/javascript">
		$(function() {
			window.save = function() {

				var isnul = true;
				isnul = isnul && $("#name").valid({
					methods : "required|isName"
				});
				isnul = isnul && $("#identitycard").valid({
					methods : "required|isIDCard"
				});

				isnul = isnul && $("#slocalphoto").valid({
					methods : "required"
				});

				if ($("#slocalphoto").val() == null
						|| $("#slocalphoto").val() == "") {
					$.MsgBox.Alert("上传提示", "请上传完整图片");
					return false;
				}

				if (!isnul) {
					return false;
				}
				$("#btn-warning").attr("disabled", "disabled");
				$("#btn-warning").html("正在提交中...");
				$
						.ajax({
							cache : true,
							type : "POST",
							url : "${wlpt}/wlpt/authentication/personal_authentication",
							data : $('#inputForm').serialize(),// 你的formid
							async : false,
							error : function(request) {
								$.MsgBox.Alert("系统提示", "数据异常,请联系平台人员");
							},
							success : function(data) {
								$.MsgBox.Alert("保存提示", data.message);
								window.location.href = "${wlpt}/wlpt/personal/authentication";
							}
						});
			}

			var status = '${user.userinfo.status}';
			if (status == '1' || status == '2') {
				$("#name").attr("readonly", "true");
				$("#identitycard").attr("readonly", "true");
				$("#btn-warning").html("已申请认证");
				$("#btn-warning").attr("disabled", "true");
				$("#btn-warning").css("background-color", "#ccc");
				$("#btn-warning").css("border-color", "#ccc");
			}
		});
	</script>
</body>
</html>
