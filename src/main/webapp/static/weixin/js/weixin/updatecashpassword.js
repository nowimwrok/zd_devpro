var path = $("#path").val();
var zdpath = $("#zdpath").val();
/**
 * 微信修改支付密码界面js文件
 */
function altmesg() {
	$("#btnSubmit").show();
	$("#loading").hide();
	$("#loadtext").html("加载中，请稍等！");
};
function changePwd() {
	$("#btnSubmit").hide();
	$("#loading").show();
	var phoneNumber = $("#txtPhoneNumber").val();
	var passWord = $("#txtPassWord").val();
	var confirmPwd = $("#txtConfirmPwd").val();
	var smsCode = $("#txtSmsCode").val();
	
	
	bool = checkPwd();
	if (!bool) {
		altmesg();
		return;
	}

	bool = checkConfirmPwd();
	if (!bool) {
		altmesg();
		return;
	}

	bool = checkCode();
	if (!bool) {
		altmesg();
		return;
	}

	$.ajax({
		type : "POST",
		url : $("#path").val()+'/weixin/user/saveCashPass',
		data : {
			"user.phone" : phoneNumber,
			cashpassword : passWord,
			recashpassword : confirmPwd
		},
		dataType : 'json',
		cache : false,
		success : function(data) {
				if (data.state==1) {
					 $("#btnSubmit").show();
					 $("#btnSubmit").html("支付密码修改成功");
					 $("#btnSubmit").unbind();
					setTimeout(function() {
						window.location.href = $("#path").val()+"/weixin/user/userHome";
					}, 3000);
				}else {
					altmesg();
					$("#txtConfirmPwd").tips({
						side : 3,
						msg : data.message,
						bg : '#FF5080',
						time : 3
					});
				}
				/*if ("pwdError" == result[i]) {
					$("#txtPassWord").tips({
						side : 3,
						msg : "请输入6-16位长度的密码！",
						bg : '#FF5080',
						time : 3
					});
				}*/
				
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
			$.ajax({
				type : "POST",
				url : $("#zdpath").val()+'/wlpt/personal/checkPhone',
				data : {
					phone:phoneNumber
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if (data) {
						flag = false;
						$.ajax({
							type : "POST",
							url : $("#zdpath").val()+'/wlpt/personal/sendRegCode',
							data : {
								phone: phoneNumber
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data) {
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
										msg : "短信验证码发送失败！",
										bg : '#FF5080',
										time : 3
									});
								}
							}
						});
					} else {
						flag = true;
						$("#txtPhoneNumber").tips({
							side : 3,
							msg : "该手机号码用户不存在！",
							bg : '#FF5080',
							time : 3
						});
					}
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

//timer处理函数
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
	}

	if (pwd != confirmPwd) {
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
	var bool = true; 
	var smsCode = $("#txtSmsCode").val();
	var phoneNumber = $("#txtPhoneNumber").val();
	if (smsCode == "") {
		$("#txtSmsCode").tips({
			side : 3,
			msg : '验证码不能为空！',
			bg : '#FF5080',
			time : 3
		});
		bool = false;
		return false;
	} else {
		$.ajax({
			url : $("#zdpath").val()+"/wlpt/personal/checkRegCode",
			type : "POST",
			data : {
				phone : phoneNumber,
				regcode : smsCode
			},
			dataType : 'json',
			cache : false,
			async : false, ///同步请求传递
			success : function(data) {
				if (data) {
					$("#txtSmsCode").tips({
						side : 3,
						msg : "验证码正确",
						bg : '#AE81FF',
						time : 3
					});
				} else {
					$("#txtSmsCode").tips({
						side : 3,
						msg : "验证码错误或已过期",
						bg : '#FF5080',
						time : 3
					});
					bool = false;
				}
			}
		});
	}
	return bool;
}