<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>添加子账户</title>
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

input[type="password"] {
	width: 40%;
	text-indent: 5px;
	padding:5px;
}

#box {
	margin: 50px auto;
	width: 540px;
	min-height: 400px;
	background: #FF9
}

#demo {
	margin: 50px auto;
	width: 540px;
	min-height: 800px;
	background: #CF9
}

.user_infor_right {
	width: 70%;
	text-align: left;
	padding-left: 10px;
	height: 50px;
	line-height: 50px;
}
.radiobuttons{
margin: 10px 0px;
}
</style>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script src="/static/common/jeesite.js" type="text/javascript"></script>
</head>
<body>
	<p class="user_data">
		<img src="${ctxStatic }/images/wlptfront/line-left.png"><span
			class="title_blue">添加</span><span class="title_orange">子账户</span><img
			src="${ctxStatic}/images/wlptfront/line-right.png">
	</p>
	<form:form id="inputForm" modelAttribute="user"
		action="${wlpt}/wlpt/account/saveMyuser" method="post"
		class="form-horizontal">
		<input type="hidden" id="userId" value="${userId} " />
		<table class="user-infor">
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>登录名:</td>
				<td class="user_infor_right"><form:input path="loginName"
						onblur="validLoginName()" id="loginName" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>姓名:</td>
				<td class="user_infor_right"><form:input path="name" id="name" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>用户类型:</td>
				<td class="user_infor_right"><form:radiobuttons id="userrole" 
						path="role.enname" items="${fns:getDictList('account_role')}"
						itemLabel="label" itemValue="value" htmlEscape="false" class="radiobuttons" />
				</td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>手机号码:</td>
				<td class="user_infor_right"><form:input path="phone"
						onblur="validPhone()" id="phone" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>密码:</td>
				<td class="user_infor_right"><input id="password"
					name="password" type="password" value="" maxlength="16"
					minlength="3" class="" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>确认密码:</td>
				<td class="user_infor_right"><input id="repassword"
					name="repassword" type="password" value="" maxlength="16"
					minlength="3" equalTo="#newPassword" /></td>
			</tr>
			<tr>
				<td class="user_infor_left">固定电话:</td>
				<td class="user_infor_right"><form:input id="telphone"
						path="mobile" placeholder="请输入固话号码" htmlEscape="false"
						maxlength="32" class="input-xlarge " /></td>
			</tr>
			<tr>
				<td class="user_infor_left">Email:</td>
				<td class="user_infor_right"><form:input id="email"
						path="email" htmlEscape="false" maxlength="32"
						class="input-xlarge " /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>支付密码:</td>
				<td class="user_infor_right"><input id="cashpassword"
													name="userinfo.cashpassword" type="password" value="" maxlength="10"
													minlength="3" class="" /></td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>确认支付密码:</td>
				<td class="user_infor_right"><input id="recashpassword"
													name="recashpassword" type="password" value="" maxlength="10"
													minlength="3" equalTo="#cashpassword" /></td>
			</tr>
			<tr>
				<td class="user_infor_left" style="vertical-align: text-top;">备注:</td>
				<td class="user_infor_right"><form:textarea path="remarks"
						id="remarks"
						style="margin-top: 5px;line-height:24px;text-indent:12px;"
						htmlEscape="false" rows="3" cols="50" maxlength="255"
						class="input-xxlarge " /></td>
			</tr>

			<tr>
				<td class="user_infor_left">上传头像:</td>
				<td class="user_infor_right"><img
					src="${ctxStatic }/images/wlptfront/photo.png" class="photo_up"><span>图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</span>
				</td>
			</tr>
			<tr>
				<td colspan=2>
					<div class="controls">
						<form:hidden id="nameImage" isdelall="false" path="photo"
							htmlEscape="false" maxlength="255" class="input-xlarge" />
						<sys:ckfinder input="nameImage" type="images" uploadPath="/photo"
							selectMultiple="false" maxWidth="100" maxHeight="100" />
					</div>

				</td>
			</tr>
			<tr>
				<td colspan=2>
					<button type='button' class="btn btn-defalut btn-warning"
						id="btn-warning">保存</button>
				</td>
			</tr>
		</table>
	</form:form>
	</div>
	<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		function validLoginName() {
			var userid = $("#userId").val();
			var loginname = $("#loginName").val();
			if (userid != null && userid != "" && loginname != null
					&& loginname != "") {
				$.ajax({
					type : "POST",
					url : '${wlpt}/wlpt/personal/validateLoginName',
					dataType : 'json',
					data : {
						"LoginName" : loginname,
						"ID" : userid
					},
					cache : false,
					success : function(data) {
						if (!data) {
							$("#loginName").tips({
								side : 3,
								msg : '用户名已存在',
								bg : '#00A2E9',
								time : 4
							});
							$("#loginName").val("");
							$("#loginName").focus();
							return false;
						} else {
							return true;
						}
					}
				});
			}

		}

		function validPhone() {
			var phone = $("#phone").val();
			if (phone != null && phone != "") {
				$.ajax({
					type : "POST",
					url : '${wlpt}/wlpt/personal/checkPhone',
					dataType : 'json',
					data : {
						phone : phone
					},
					cache : false,
					success : function(data) {
						if (data) {
							$("#phone").tips({
								side : 3,
								msg : '该号码已经注册',
								bg : '#00A2E9',
								time : 4
							});
							$("#phone").val("");
							$("#phone").focus();
							return false;
						} else {
							return true;
						}
					}
				});
			}

		}

		$(function() {
			$("#userrole1").attr("checked","checked");
			$("#btn-warning")
					.click(
							function() {
								var isnul = true;
								isnul = isnul && $("#loginName").valid({
									methods : "required|string"
								});
								isnul = isnul && $("#name").valid({
									methods : "required|isName"
								});
								if(isnul&&($("input[name='role.enname']:checked").val()==null&&$("input[name='role.enname']:checked").val())){
									$.MsgBox.Alert("温馨提示", "请选择子账户角色");
									return false;
								}
								isnul = isnul && $("#phone").valid({
									methods : "required|isPhone"
								});
								if ($("#telphone").val() != null
										&& $("#telphone").val() != "") {
									isnul = isnul && $("#telphone").valid({
										methods : "isTel"
									});
								}
								if ($("#email").val() != null && $("#email").val() != "") {
									isnul = isnul && $("#email").valid({
										methods : "isEmail"
									});
								}
								if ($("#remarks").val() != null
										&& $("#remarks").val() != "") {
									isnul = isnul && $("#remarks").valid({
										methods : "string"
									});
								}
								isnul = isnul && $("#password").valid({
									methods : "required|isPassWord"
								});
								isnul = isnul && $("#repassword").valid({
									methods : "required"
								});
								isnul = isnul && $("#cashpassword").valid({
											methods : "required|isPassWord"
										});
								isnul = isnul && $("#recashpassword").valid({
											methods : "required"
										});
								if (!isnul) {
									return false;
								}
								var passWord = $("#password").val();
								var repassWord = $("#repassword").val();
								if (passWord.length < 6) {
									$("#password").tips({
										side : 3,
										msg : '密码长度不能小于6位！',
										bg : '#00A2E9',
										time : 3
									});
									return false;
								}
								if (passWord.length > 16) {
									$("#password").tips({
										side : 3,
										msg : '密码长度不能大于16位！',
										bg : '#00A2E9',
										time : 3
									});
									return false;
								}
								if (repassWord.length < 6) {
									$("#repassword").tips({
										side : 3,
										msg : '密码长度不能小于6位！',
										bg : '#00A2E9',
										time : 3
									});
									return false;
								}
								if (repassWord.length > 16) {
									$("#repassword").tips({
										side : 3,
										msg : '密码长度不能大于16位！',
										bg : '#00A2E9',
										time : 3
									});
									return false;
								}
								if ($("#password").val() != $("#repassword")
												.val()) {
									$("#repassword").tips({
										side : 3,
										msg : '请输入与上面相同的密码',
										bg : '#00A2E9',
										time : 4
									});
									$("#repassword").focus();
									return false;
								}
								if ($("#cashpassword").val() != $("#recashpassword").val()) {
									$("#recashpassword").tips({
										side : 3,
										msg : '请输入与上面相同的支付密码',
										bg : '#00A2E9',
										time : 4
									});
									$("#recashpassword").focus();
									return false;
								}
								if (!isnul) {
									return false;
								}
								$
										.ajax({
											cache : true,
											type : "POST",
											url : "${wlpt}/wlpt/account/saveMyuser",
											data : $('#inputForm').serialize(),// 你的formid
											async : false,
											error : function(request) {
												$.MsgBox.Alert("保存提示", "保存失败");
											},
											success : function(data) {
												$.MsgBox.Alert("保存提示",
														data.message);
												window.location.href = "${wlpt}/wlpt/account/toAccountList";
											}
										});
							});

		});
	</script>
</body>
</html>
