/**
 * 微信注册界面js文件
 */

function register() {

	var path = $("#path").val();// 路径
	var phoneNumber = $("#txtPhoneNumber").val();
	var passWord = $("#txtPassWord").val();
	var confirmPwd = $("#txtConfirmPwd").val();
	var smsCode = $("#txtSmsCode").val();
	var openID = $("#txtOpenID").val();
	var userType = $("#txtUserType").val();
	var loginName = $("#txtLoginName").val();
	var bool = checkPhone();
	if (!bool) {
		return;
	}

	bool = checkPwd();
	if (!bool) {
		return;
	}

	bool = checkConfirmPwd();
	if (!bool) {
		return;
	}

	bool = checkCode();
	if (!bool) {
		return;
	}
	bool = checkloginName();
	if (!bool) {
		return;
	}
	$.ajax({
		type : "POST",
		url : path + '/weixin/user/registeruser',
		data : {
			'loginName' : loginName,
			'phone' : phoneNumber,
			'password ' : passWord,
			'newPassword' : confirmPwd,
			'SmsCode' : smsCode,
			'userinfo.openid ' : openID,
			'role.enname' : userType
		},
		dataType : 'json',
		cache : false,
		success : function(data) {
			if (data.state == '1') {
				//login();
				window.location.href = path + "/weixin/user/tologin?openID="+openID;
			} else {
				$("#btnSendCode").tips({
					side : 3,
					msg : data.message,
					bg : '#AE81FF',
					time : 3
				});
			}
		}
	});
}
function login() {
	var phoneNumber = $("#txtPhoneNumber").val();
	var passWord = $("#txtPassWord").val();
	var openID = $("#txtOpenID").val();
	var path = $("#path").val();// 路径

	
	$.ajax({
		type : "POST",
		url : path + '/weixin/user/loginuser',
		data : {
			loginName : phoneNumber,
			password : passWord,
			openid : openID
		},
		dataType : 'json',
		cache : false,
		async : false,
		success : function(data) {
			if (1 == data.state) {
				window.location.href =   path + "/weixin/user/userHome";
			} else {
				window.location.href = path + "/weixin/user/tologin?openID="+openID;
			}
		}
	});
}
/** ********发送短信验证码*********** */
var flag = true;
function sendSmscode() {
	if (flag) {
		flag = false;
		var phoneNumber = $("#txtPhoneNumber").val();
		if (phoneNumber != "") {
			var path = $("#path").val();// 路径
			$.ajax({
				type : "POST",
				url : path + '/weixin/user/sendRegCode',
				data : {
					phone : phoneNumber
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if (data.state == 1) {
						flag = false;
						$("#btnSendCode").tips({
							side : 3,
							msg : "短信验证码已经发送到您的手机！",
							bg : '#AE81FF',
							time : 3
						});
						sendMessage();

					} else {
						$("#btnSendCode").tips({
							side : 3,
							msg : "号码已存在！",
							bg : '#FF5080',
							time : 3
						});
					}

				},
				error : function() {
					$("#btnSendCode").tips({
						side : 3,
						msg : "短信验证码发送失败！",
						bg : '#FF5080',
						time : 3
					});
				}
			});
		} else {
			$("#txtPhoneNumber").tips({
				side : 3,
				msg : "请输入手机号码",
				bg : '#FF5080',
				time : 3
			});
		}
	}
}

var InterValObj; // timer变量，控制时间
var count = 60; // 间隔函数，1秒执行
var curCount;// 当前剩余秒数

function sendMessage() {
	curCount = count;
	// 设置button效果，开始计时
	$("#btnSendCode").attr("disabled", "true");
	$("#btnSendCode").val(curCount + "秒");
	InterValObj = window.setInterval(SetRemainTime, 1000); // 启动计时器，1秒执行一次
}

// timer处理函数
function SetRemainTime() {
	if (curCount == 0) {
		flag = true;
		window.clearInterval(InterValObj);// 停止计时器
		$("#btnSendCode").removeAttr("disabled");// 启用按钮
		$("#btnSendCode").val("重新发送验证码");
	} else {
		curCount--;
		$("#btnSendCode").val(curCount + "秒");
	}
}

function checkloginName() {
	var loginNames = $("#txtLoginName").val();
	if (loginNames == "") {
		$("#txtLoginName").tips({
			side : 3,
			msg : "登陆名不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	var bValidate = RegExp(/^[0-9a-zA-Z\u4e00-\u9fa5]+$/).test(loginNames);
	if (!bValidate) {
		$("#txtLoginName").tips({
			side : 3,
			msg : "不能输入非法字符！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	} else {

		var path = $("#path").val();// 路径
		$.ajax({
			type : "POST",
			url : path + '/weixin/user/checkLoginName',
			data : {
				loginName : loginNames
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if (!data) {
					$("#txtLoginName").tips({
						side : 3,
						msg : "登陆名已存在！",
						bg : '#FF5080',
						time : 3
					});
					return false;
				}
			}
		});
	}
	return true;
}

/* 检查手机号码输入框 */
function checkPhone() {
	var phoneNumber = $("#txtPhoneNumber").val();
	if (phoneNumber == "") {
		$("#txtPhoneNumber").tips({
			side : 3,
			msg : "手机号码不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	var bValidate = RegExp(/(^1[3|4|5|7|8][0-9]{9}$)/).test(phoneNumber);
	if (!bValidate) {
		$("#txtPhoneNumber").tips({
			side : 3,
			msg : '手机号码输入有误',
			bg : '#FF5080',
			time : 3
		});
		return false;
	} else {
		/* 验证手机号码是否已注册 */

		var path = $("#path").val();// 路径
		$.ajax({
			type : "POST",
			url : path + '/weixin/user/checkPhone',
			data : {
				phone : phoneNumber
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if (!data) {
					$("#txtPhoneNumber").tips({
						side : 3,
						msg : "手机号码已注册过！",
						bg : '#FF5080',
						time : 3
					});
					return false;
				}
			}
		});

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

/* 验证两次密码是否一致 */
function checkConfirmPwd() {
	var pwd = $("#txtPassWord").val();
	var confirmPwd = $("#txtConfirmPwd").val();

	if (confirmPwd == "") {
		$("#txtConfirmPwd").tips({
			side : 3,
			msg : '请输入确认密码！',
			bg : '#FF5080',
			time : 3
		});
		return false;
	} else if (pwd != confirmPwd) {
		$("#txtConfirmPwd").tips({
			side : 3,
			msg : '两次密码输入不一致！',
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	return true;
}

/* 检查验证码 */
function checkCode() {
	var smsCode = $("#txtSmsCode").val();
	var phoneNumber = $("#txtPhoneNumber").val();
	if (smsCode == "") {
		$("#txtSmsCode").tips({
			side : 3,
			msg : '验证码不能为空！',
			bg : '#FF5080',
			time : 3
		});
		return false;
	} else {
		/*
		 * $.ajax({ type : "POST", url : 'weixin/checksmscode', data : { SmsCode :
		 * smsCode, PhoneNumber : phoneNumber }, dataType : 'json', cache :
		 * false, success : function(data) { if (!data) {
		 * $("#txtSmsCode").tips({ side : 3, msg : "验证码错误", bg : '#FF5080', time :
		 * 3 }); } } });
		 */
	}
	return true;
}