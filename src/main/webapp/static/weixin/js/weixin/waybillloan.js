/**
 * 运单贷js
 */

/** 检查用户姓名输入状态* */
function checkUserName() {
	var userName = $("#txtUserName").val();
	if ("" == userName) {
		$("#txtUserName").tips({
			side : 3,
			msg : "用户姓名不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	return true;
}

/** 检查联系电话输入状态* */
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
	}
	return true;
}

/** 检查公司名称输入状态* */
function checkCompanyName() {
	var companyName = $("#txtCompanyName").val();
	if ("" == companyName) {
		$("#txtCompanyName").tips({
			side : 3,
			msg : "公司名称不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	return true;
}

/** 检查公司地址输入状态* */
function checkCompanyAddress() {
	var companyAddress = $("#txtCompanyAddress").val();
	if ("" == companyAddress) {
		$("#txtCompanyAddress").tips({
			side : 3,
			msg : "公司地址不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	return true;
}

/** 检查贷款金额* */
function checkLoanValue() {
	var loanValue = $("#txtLoanValue").val();
	if ("" == loanValue) {
		$("#txtLoanValue").tips({
			side : 3,
			msg : "贷款金额不能为空！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	}
	if (isNaN(loanValue)) { // 不是数字
		$("#txtLoanValue").tips({
			side : 3,
			msg : "请输入数字！",
			bg : '#FF5080',
			time : 3
		});
		return false;
	} else {
		var iLoanValue = parseInt(loanValue);
		if (10 > iLoanValue || 100 < iLoanValue) { // 贷款范围(10万<贷款金额<100万)
			$("#txtLoanValue").tips({
				side : 3,
				msg : "贷款金额在10-100之间，单位：万元",
				bg : '#FF5080',
				time : 3
			});
			return false;
		}
	}
	return true;
}