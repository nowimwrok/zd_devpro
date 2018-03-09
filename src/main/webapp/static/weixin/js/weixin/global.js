
//格式化日期
Date.prototype.format = function(format) {
	/*
	 * eg:format="YYYY-MM-dd hh:mm:ss";
	 */
	var o = {
			"M+" : this.getMonth() + 1, //month
			"d+" : this.getDate(), //day
			"h+" : this.getHours(), //hour
			"m+" : this.getMinutes(), //minute
			"s+" : this.getSeconds(), //second
			"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter
			"S" : this.getMilliseconds()
			//millisecond
	}

	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, (this.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
	}

	for ( var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1,
					RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
							.substr(("" + o[k]).length));
		}
	}
	return format;
};

function getWebPath() {
	//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
	var curWwwPath = window.document.location.href;
	//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
	var pathName = window.document.location.pathname;
	var pos = curWwwPath.indexOf(pathName);
	//获取主机地址，如： http://localhost:8083
	var localhostPaht = curWwwPath.substring(0, pos);
	//获取带"/"的项目名，如：/uimcardprj
	var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
//	return (localhostPaht + projectName);
	//if(projectName=='\wlpt'||projectName=='\common')
	//{
	//	projectName='';		
	//}
	 
	return {
		host:"",
		projName:""
	};
}
//是否已登录
window.isLogined=function(){
	var islogin=false;
	$.ajax({
		url : "${pageContext.request.contextPath}/weixin/user/islogined",
		type : "POST",
		data : {},
		async:false,
		success : function(res) {
			if(res.result=='success'){
				islogin=true;
			}else{
				islogin=false;	
			}
		}
	});
	return islogin;
}

//是否已经验证
window.isStatused=function(){
	var status="";
	if(isLogined()){
		$.ajax({
			url : "${pageContext.request.contextPath}/weixin/user/islogined",
			type : "GET",
			data : {},
			async:false,  ///同步请求传递
			success : function(data) {
				status=data.status;
			}
		});
	}
	return status;
}
//获取角色类型
function getRoleName(){
	var roleName="";
	$.ajax({
		url : getWebPath().projName +"/wlpt/user/islogined",
		type : "GET",
		data : {},
		async:false,
		success : function(data) {
			roleName=data.role;
		}
	});
	return roleName;
}
//判断时间，时间必须大于当前时间
function diffDate(indate) {
	var evalue = indate.val();
	var dB = new Date(evalue.replace(/-/g, "/"));
	if (new Date() <= Date.parse(dB)) {
		return true;
	} else {
		indate.tips({
			msg : '日期必须大于当前时间！',
            side: 3,
            bg:"#FF7300",
            time : 2
		});
		return false;
	}
}
//判断时间，当前时间小于传入的值
function diffAfterDate(indate,msg) {
	var dB = new Date(indate.replace(/-/g, "/"));
	if (new Date() > Date.parse(dB)) {
		return false;
	} else {
		return true;
	}
}
//判断两个时间的先后
function completeDate(beforedate,laterdate,em) {
	beforedate = new Date(beforedate.replace(/-/g, "/"));
	laterdate = new Date(laterdate.replace(/-/g, "/"));
	if (Date.parse(beforedate)< Date.parse(laterdate)) {
		return true;
	} else {
		em.tips({
			side : 3,
			msg : '开始时间必须大于结束时间！',
			bg : '#AE81FF',
			time : 2
		});
		return false;
	}
}
///发送短信验证码按钮的间隔操作
var wait = 60;// 时间
function time(o) {// o为按钮的对象，这里是60秒过后，提示文字的改变
	if (wait == 0) {
		o.removeAttr("disabled");
		o.css("background", "#F74000");
		o.val("获取验证码");// 改变按钮中value的值
		wait = 60;
	} else {
		o.attr("disabled", true);// 倒计时过程中禁止点击按钮
		o.val(wait + "秒后重新获取");// 改变按钮中value的值
		o.css("background", "#CCC");
		wait--;
		setTimeout(function() {
			time(o);// 循环调用
		}, 1000);
	}
}
/**
 * 订单发送短信 
 * phone：对方电话号码，
 * code：短信模板名称，数据库相对应作为查询的条件，
 * file:发送短信成功后需要跳转到的页面路径
 */

function orderSendSMS(phone,code,orderNo,file){
	$.ajax({
		type : "POST",
		url :getWebPath().projName
		+ '/wlpt/trade/phonenotice.do?tm='
		+ new Date().getTime(),
		dataType : 'json',
		cache : false,
		data : {
			PHONE : phone,
			code:code,
			orderNo:orderNo
		},
		success : function(data) {
			if(file!=""&&file!=null){
				window.location.href=getWebPath().projName+file;
			}
		}
	});
}


/**
 * 添加收藏 
 * 先判断是否已登录
 * TARGETTYPE：收藏的类型，0、车源 1、货源 2、专线 3、物流企业
 * id:数据库的标识
 */

function collect(id,type) {
	if (!isLogined()) {
		//弹出登录窗口，先登录，后刷新页面
		window.open(getWebPath().projName
				+ "/wlpt/user/login");
		return;
	}
	var jsons = {};
	//车源收藏
	if(type == 0){		
		jsons = {
				CARSOURCEID:id,
				TARGETTYPE:type
		};
	}
	//货源收藏
	else if(type == 1){		
		jsons = {
				GOODSID:id,
				TARGETTYPE:type
		};
	}
	//专线收藏
	else if(type == 2){		
		jsons = {
				LINEID : id,
				TARGETTYPE : type
		};
	}
	//企业收藏
	else{
		var arr = id.split("-");
		jsons = {
				LINEID:arr[0],
				TARGETTYPE:3,
				COMPANYNAME:arr[1]
		};
	}
	$.ajax({
		url :getWebPath().projName
		+ "/wlpt/mycollect/addcollection.do",
		data : jsons,
		dataType : 'json',
		cache : false,
		type : "POST",
		success : function(data) {
			if (data.result == 'success') {
				window.location.reload();

			} else {
				$.alert("收藏失败！", function() {
				});
			}
		},
		error : function() {
			$.alert("收藏失败！", function() {
			});
		}
	});
}
//弹出服务窗口
var newWindow;//定义一个窗口，有利于窗口间的通讯
function openagreement(id) {
	if (!newWindow || newWindow.closed) {
		var width = 900;
		var height = 500;
		var left = parseInt((screen.availWidth / 2) - (width / 2));//屏幕居中
		var top = parseInt((screen.availHeight / 2) - (height / 2));
		var windowFeatures = "width="
				+ width
				+ ",height="
				+ height
				+ ",left="
				+ left
				+ ",top="
				+ top
				+ "screenX="
				+ left
				+ ",toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no,screenY="
				+ top;
		newWindow = window
				.open(
						getWebPath().projName+"/wlpt/agreement/AgreementInfo.do?AGREEMENT_ID="
								+ id, "卓大协议", windowFeatures);
	} else {
		// window is already open, so bring it to the front
		newWindow.focus();
	}
}
function fmoney(source, num) {
	var isReturnInt = false;
	source = (source + "").replace(/[^\d\.-]/g, ""); // 删除所有非(数字小数点或负号)的字符
	if (num == 0) {
		isReturnInt = true;
	}
	num = (num > 0 && num <= 20) ? num : 2; // 保留20位以内的小数位	
	source = parseFloat(source).toFixed(num) + "";

	var left = source.split(".")[0].split("").reverse();
	var right = source.split(".")[1];
	var target = "";
	for (i = 0; i < left.length; i++) {
		target += left[i] + ((i + 1) % 3 == 0 && (i + 1) != left.length ? "," : "");
	}
	if (isReturnInt == true) {
		return target.split("").reverse().join("");
	} else {
		return target.split("").reverse().join("") + "." + right;
	}
}