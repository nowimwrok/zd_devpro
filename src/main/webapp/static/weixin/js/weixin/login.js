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
	$.ajax({
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
				window.location.href =  "/wx/weixin/user/userHome";
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
	});
}

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