<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>用户资料</title>
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
</style>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script src="/static/common/jeesite.js" type="text/javascript"></script>
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
</head>
<body>
	<p class="user_data">
		<img src="${ctxStatic }/images/wlptfront/line-left.png"><span
			class="title_blue">用户</span><span class="title_orange">资料</span><img
			src="${ctxStatic}/images/wlptfront/line-right.png">
	</p>
	<form:form id="inputForm" modelAttribute="userinfo"
		action="${wlpt}/wlpt/user/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="user.id" />
		<form:hidden path="userCompany.id" />
		<input type="hidden" id="userId" name="userId" value="${userinfo.id }" />
		<table class="user-infor">
			<tr>
				<td class="user_infor_left"><span class="star_red"></span>登录名:</td>
				<td class="user_infor_right">
					<%-- <form action="" method="post">${userinfo.user.loginName}</form> --%>
					<form:input path="user.loginName" onblur="validLoginName()"
						id="loginName"  /><span style="color: red; display: none;"
					id="Name_validate">用户名已存在</span>
					<%-- ${userinfo.user.loginName} --%>
				</td>
			</tr>
			<tr>
				<td class="user_infor_left star_red">注意:</td>
				<td class="user_infor_right star_red">已认证用户部分信息不可修改</td>
			</tr>
			<tr>
				<td class="user_infor_left">姓名:</td>
				<td class="user_infor_right">
				<c:choose>
				<c:when test="${fns:getUser().role.enname ne 'enterprise' && (userinfo.status==1||userinfo.status==2)}">
				${userinfo.user.name}</c:when>
			      <c:otherwise>
                  <form:input id="username" path="user.name" />
                  </c:otherwise>
                  </c:choose> 
                  </td>
			</tr>
			<tr>
				<td class="user_infor_left">性别:</td>
				<td class="user_infor_right"><form:radiobutton path="sex"
						id="boy" cssStyle="margin-left: 5px" value="1" />男 <form:radiobutton
						path="sex" id="girl" cssStyle="margin-left: 5px" value="0" />女

				</td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>公司名称:</td>
				<td class="user_infor_right">
				<c:choose>
				<c:when test="${fns:getUser().role.enname eq 'enterprise'&& !empty userinfo.companyname && (userinfo.status==1||userinfo.status==2)}">
				  ${userinfo.companyname}</c:when>
				  <c:otherwise>
				  <form:input id="companyname"
						path="companyname" htmlEscape="false" maxlength="32"
						class="input-xlarge " />
                  </c:otherwise>
					</c:choose> 
				  </td>
			</tr>
			<tr>
				<td class="user_infor_left"><span class="star_red">*</span>手机号码:</td>
				<td class="user_infor_right">${userinfo.user.phone}</td>
			</tr>
			<tr>
				<td class="user_infor_left">固定电话:</td>
				<td class="user_infor_right"><form:input id="telphone"
						path="telphone" placeholder="请输入固话号码" htmlEscape="false"
						maxlength="32" class="input-xlarge " /></td>
			</tr>
			<tr>
				<td class="user_infor_left">Email:</td>
				<td class="user_infor_right"><form:input id="email"
						path="user.email" htmlEscape="false" maxlength="32"
						class="input-xlarge " /></td>
			</tr>
			<tr>
				<td class="user_infor_left">QQ号码:</td>
				<td class="user_infor_right"><form:input id="qq" path="qq"
						htmlEscape="false" maxlength="32" onblur="validRegCode()"
						class="input-xlarge qq" /> <span id="QQ_validate"
					style="color: red; display: none;">该QQ号码已存在</span></td>
			</tr>
			<tr>
				<td class="user_infor_left" style="vertical-align: text-top;">联系地址:</td>
				<td class="user_infor_right"><form:textarea
						path="contactaddress"
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
						<form:hidden id="nameImage" isdelall="false" path="user.photo"
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
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		function validRegCode() {
			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/validateQQ',
				dataType : 'json',
				data : {
					QQ : $("#qq").val(),
					ID : $("#userId").val()
				},
				cache : false,
				success : function(data) {
					if (!data) {
						$("#QQ_validate").show();
					} else {
						$("#QQ_validate").hide()
					}
				},
				error : function() {
					top.$.jBox.tip('该QQ号码已存在', 'warning');
				}
			});
		}
		function validLoginName() {
			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/validateLoginName',
				dataType : 'json',
				data : {
					LoginName : $("#loginName").val(),
					ID : $("#userId").val()
				},
				cache : false,
				success : function(data) {
					if (!data) {
						$("#Name_validate").show();
					} else {
						$("#Name_validate").hide()
					}
				},
				error : function() {
					$.MsgBox.Alert("该用户名已存在", data.message)
				}
			});
		}

		$(function() {
			$("#btn-warning").click(
					function() {
						var isnul = true;
						if ($("#telphone").val() != ""
								&& $("#telphone").val() != null) {
							isnul = isnul && $("#telphone").valid({
								methods : "required|isTel"
							});
						}
						isnul = isnul && $("#loginName").valid({
							methods : "required"
						}); 
						if($("#companyname").val()!=''&&$("#companyname").val()!=null){
							isnul = isnul && $("#companyname").valid({
								methods : "ischinese"
							});
						}
						/* <c:if test="${fns:getUser().role.enname eq 'enterprise' && (userinfo.status!=1||userinfo.status!=2)}">
						isnul = isnul && $("#username").valid({
							methods : "required"
						});
						</c:if> */
						if ($("#email").val() != ""
								&& $("#email").val() != null) {
							isnul = isnul && $("#email").valid({
								methods : "isEmail"
							});
						}
						if ($("#qq").val() != "" && $("#qq").val() != null) {
							isnul = isnul && $("#qq").valid({
								methods : "isQQ"
							});
						}
						if (!isnul) {
							return false;
						}
						$.ajax({
							cache : true,
							type : "POST",
							url : "${wlpt}/wlpt/personal/saveUserInfo",
							data : $('#inputForm').serialize(),// 你的formid
							async : false,
							error : function(request) {
								$.MsgBox.Alert("保存提示", "保存失败");
							},
							success : function(data) {
								$.MsgBox.Alert("保存提示", data.message)
							}
						});
					});

			if ('${userinfo.user.photo}' != "") {
				$("#showimg").attr("src", '${userinfo.user.photo}');
				$("#showimg").attr("src", $("#nameImage").val());
			}
			if ("${userinfo.sex}" == 1) {
				$("#boy").attr("checked", true);
			} else {
				$("#girl").attr("checked", true);
			}

		});
	</script>
</body>
</html>
