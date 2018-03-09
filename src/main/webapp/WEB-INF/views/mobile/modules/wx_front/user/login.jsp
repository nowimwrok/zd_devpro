<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--帐号绑定</title>

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

<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<link href="${ctxStatic}/weixin/css/login.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<%-- <script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/login.js"></script> --%>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
	$(function(){
		var msg ='${message}';
		if(msg!=''){
			$("#txtPhoneOrUserName").tips({
				side : 3,
				msg : msg,
				bg : '#FF5080',
				time : 3
			});
			var user = '${user}';
			if(user!=''){
				$("#txtPhoneOrUserName").val("${not empty user.loginName?user.loginName:''}");
			}
		}
	})
	/* $("#loading").hide(); */
	/**
	 * 微信登录界面js文件
	 */
	function login() {
		var phoneNumber = $("#txtPhoneOrUserName").val();
		var passWord = $("#txtPassWord").val();
		var openID = $("#txtOpenId").val();
		var fromPage = $("#txtFromPage").val();
		var path = $("#path").val();

		var bool = checkPhoneOrUserName();
		if (!bool) {
			return;
		}

		bool = checkPwd();
		if (!bool) {
			return;
		}
		$("#loading").show();
		$('#inputForm').submit();
		/* $.ajax({
			type : "POST",
			url : path + '/weixin/user/loginuser',
			data : {
				loginName : phoneNumber,
				password : passWord,
				openid : openID,
				FromPage : fromPage
			},
			dataType : 'json',
			cache : false,
			async : false,
			success : function(data) {
				if (1 == data.state) {
					window.location.href =  "${wx}/weixin/user/userHome";
					//window.setTimeout(altmesg, "1000");
					
				} else if (0 == data.state) {
					$("#txtPhoneOrUserName").tips({
						side : 3,
						msg : "用户名或密码输入有误！",
						bg : '#FF5080',
						time : 3
					});
				} else {
					$("#txtPhoneOrUserName").tips({
						side : 3,
						msg : data.message,
						bg : '#FF5080',
						time : 3
					});
				}
			}
		}); */
	}
	window.altmesg=function(){
			window.location.href =  "${wx}/weixin/user/userHome";
			/* $("#loading").hide();
			$("#loadtext").html("小运正在努力加载，请稍等！"); */
	  };

	/* 检查手机号码输入框 */
	function checkPhoneOrUserName() {
		var phoneNumber = $("#txtPhoneOrUserName").val();
		if ("" == phoneNumber) {
			$("#txtPhoneOrUserName").tips({
				side : 3,
				msg : "手机号码不能为空！",
				bg : '#FF5080',
				time : 3
			});
			return false;
		}
		return true;
	}

	/* 检查密码输入框 */
	function checkPwd() {
		var passWord = $("#txtPassWord").val();
		if (passWord == "") {
			$("#txtPassWord").tips({
				side : 3,
				msg : '密码不得为空！',
				bg : '#FF5080',
				time : 3
			});
			return false;
		}

		if (passWord.length < 6) {
			$("#txtPassWord").tips({
				side : 3,
				msg : '密码长度不能小于6位！',
				bg : '#FF5080',
				time : 3
			});
			return false;
		}
		if (passWord.length > 16) {
			$("#txtPassWord").tips({
				side : 3,
				msg : '密码长度不能大于16位！',
				bg : '#FF5080',
				time : 3
			});
			return false;
		}
		return true;
	}
	
	
</script>


</head>

<body>
	<div id="content">
		<%-- <%@ include file="./pagetitle.jsp"%> --%>
		<div id="user">
			<img id="imgUser" src="${headImgUrl}" /><strong id="userName">${userName}
			</strong> <input id="txtHeadImgUrl" type="hidden" value="${headImgUrl}">
		</div>
		<p class="binding">绑定您已注册的${fns:getConst('SYSTEMTITLE')}账号</p>
		<div>
			<form id="inputForm" modelAttribute="userCompany" action="${wx}/weixin/user/loginuser" method="post">
				<table>
					<tr>
						<td><input type="text" id="txtPhoneOrUserName"
							name="loginName" onblur="checkPhoneOrUserName()"
							placeholder="请输入手机号码/登陆名" required="required" maxlength="11" /></td>
					</tr>
					<tr>
						<td><input type="password" id="txtPassWord"
							name="password" onblur="checkPwd()"
							placeholder="密码(6-16位数字，字母，符号)" required="required"
							maxlength="16" /></td>
					</tr>
					<tr>
						<td id="forgetPwd"><a class="aRegister"
							href="${wx}/weixin/user/chooseusertype?openID=${openID}">注册账号</a><a
							class="aResetPwd" href="${wx}/weixin/user/resetpassword">找回密码？</a></td>
					</tr>
					<tr style="display: none">
						<td><input type="text" id="verifyCode" oblur="checkCode()"
							placeholder="请输入验证码" /><img id="imgCode" alt="验证码" src="code.do" />
						</td>
					</tr>
					<tr>
						<td><input type="hidden" id="txtOpenId" name="openid"
							value="${openID}" /> <input type="hidden" id="txtFromPage"
							name="txtFromPage" value="${fromPage}" /> <input id="btnLogin"
							style="background-color: rgb(32, 134, 226);" type="button"
							onclick="login()" value="登    录" /><input type="hidden"
							id="path" value="${wx}" /></td>
					</tr>
				</table>
			</form>
			<!-- <div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/weixin/loading.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
			</div> -->
		</div>
	</div>
</body>
</html>
