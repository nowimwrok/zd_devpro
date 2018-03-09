<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--用户注册</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<link href="${ctxStatic}/weixin/css/register.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/register.js?id=2"></script>
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
		<%-- <%@ include file="./pagetitle.jsp"%> --%>
		<div>
			<form>
				<div id="form">
					<table align="center">
						<tr>
							<td><input type="text" id="txtLoginName" name="txtLoginName"
								onblur="checkloginName()" placeholder="登陆名（输入中文或英文）"
								maxlength="20" /></td>
						</tr>
						<tr>
							<td><input type="text" id="txtPhoneNumber"
								name="txtPhoneNumber" onblur="checkPhone()"
								placeholder="手机号码（输入11位手机号码）" maxlength="11"
								style="margin-top: 20px;" /></td>
						</tr>
						<tr>
							<td><input type="password" id="txtPassWord"
								name="txtPassWord" onblur="checkPwd()"
								placeholder="密码(6-16位数字，字母，符号)" maxlength="16" /></td>
						</tr>
						<tr>
							<td><input type="password" id="txtConfirmPwd"
								name="txtConfirmPwd" onblur="checkConfirmPwd()"
								placeholder="请再次输入密码以确认" maxlength="16" /></td>
						</tr>
						<tr>
							<td><input type="text" id="txtReferee" oblur=""
								placeholder="请输入推荐人信息" style="display: none" /></td>
						</tr>
						<tr>
							<td><input type="text" id="txtSmsCode" name="txtSmsCode"
								onblur="checkCode()" placeholder="短信验证码" maxlength="6" /> <input
								id="btnSendCode" type="button" onclick="sendSmscode()"
								value="获取短信验证码" /></td>
						</tr>
						<tr>
							<td><input type="hidden" id="txtOpenID" name="txtOpenID"
								value="${openID}" /> <input type="hidden" id="txtUserType"
								name="txtUserType" value="${type}" /> <input id="btnSubmit"
								type="button" onclick="register()" value="注    册" /><input type="hidden"
							id="path" value="${wx}" /></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
