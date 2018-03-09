<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--绑定司机</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div -top布局*/
.data_top,.result_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
	background-color: rgba(32, 162, 226, 1);
}

.dt_top,.data_tab {
	clear: both;
	width: 100%;
}

.dt_top {
	height: 40px;
	line-height: 40px;
}

.dt_top div {
	
}

.data_tab div {
	width: 50%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}

.bord_rt {
	border-right: 1px solid #CCC;
}

/* 数据中部信息 */
.data_box {
	width: 97%;
	margin: 0 auto;
	padding-top: 50px;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 14px;
	background: #EBEBEB;
	height: 40px;
	line-height: 40px;
	width: 100%;
	text-indent: 10px;
}

.data_cent {
	width: 96%;
	padding: 5px 0px;
	padding-left: 4%;
}

.ct_lf {
	width: 100%;
	height: 35px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 45px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell
}

.ic_img {
	height: 35px;
	display: table;
}

.ic_img img {
	width: 30px;
	margin-top: 7px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_tle {
	width: 25%;
	text-align: right;
	float: left;
}

.cb_val {
	width: 70%;
	float: left;
}

.val_info {
	width: 30%;
}

.disnone {
	display: none;
}

.img_text {
	font-size: 1em;
	width: 60px;
	text-align: center;
	background-image: url(${ctxStatic}/images/weixin/pic_bg_normal.png);
	height: 60px;
	background-repeat: no-repeat;
	line-height: 35px;
	background-size: 60px;
	margin: 5%;
	float: left;
	cursor: pointer;
	position: relative;
	clear: both;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 60px;
	height: 35px;
}

.upimg {
	width: 60px;
	height: 60px;
}

#imgCredit {
	margin-top: 15px;
}

.up_ct {
	clear: both;
	width: 100%;
	margin-top: 10px;
	height: 50px;
}

.data_bottom {
	bottom: 0px;
	height: 40px;
	line-height: 40px;
	text-align: right;
	background: rgba(241, 234, 234, 0.67);
}

input[type='text'] {
	border-bottom: 1px solid #ccc;
	font-size: 18px;
	line-height: 25px;
	height: 30px;
}

.data_div {
	width: 98%;
	background-color: #EBEBEB;
	clear: both;
	height: 62px;
	margin: 0 auto;
	margin-bottom: 5px;
}

.data_content {
	vertical-align: middle;
	display: table-cell;
}

.top_icon {
	width: 20px;
	height: 35px;
}

.top_text {
	width: 43%;
	height: 40px;
	line-height: 40px;
}

.top_icon img {
	width: 20px;
	margin-top: 5px;
}

.icon {
	width: 25px;
}

.ic_img {
	width: 30px;
}

.data_row {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
	clear: both;
	height: 40px;
}

.data_row div {
	font-size: 16px;
}

.mag_right {
	margin-right: 4%;
}

.flt {
	float: left;
	text-align: left;
}

.frt {
	float: right;
	text-align: right;
}

.data_btm {
	width: 98%;
	padding-left: 6px;
	height: 25px;
	padding-top: 5px;
}

.data_btm div {
	float: left;
	margin-right: 3%;
	line-height: 25px;
}
.selected {
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
 .detail-row {
            display: none;
        }
        input {
    border: none;
    font-size: 0.9em;
    height: 35px;
    line-height: 35px;
    text-align: center;
}
 input {
    border: none;
    font-size: 0.9em;
    height: 35px;
    line-height: 35px;
    text-align: center;
}
input[type='text']{
    border: none;
    font-size: 0.9em;
    height: 35px;
    line-height: 35px;
    text-align: left;
}
</style>

</head>

<body>
	<div class="data_top data_tab" style="width:100%;padding:0px;color: white;">
		<div class="data_tab_left"><a style="display:block;width:100%;color:white;" href="${wx}/weixin/driver/driver_list">我的司机</a></div>
		<div class="selected data_tab_right">绑定司机</div>
	</div>
	<form:form id="inputForm" modelAttribute="user" action="${wlpt}/wlpt/driver/saveAttach" method="post">
            <input id="userid" name="reuser.id" type="hidden"/>
            <input id="role" type="hidden"/>
	<div class="data_box data_box1">
		<div class="data_title">用户信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">用户：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<div style="float:left;width:65%;padding-top:10px;">
						<input type="text" id="searchinfo" placeholder="请输入用户名/手机号" style="width:100%;" />
					</div>
					<div style="float:left;width:30%;">
						<span onclick="search();" class="unauthen" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;background: rgb(32, 134, 226);">搜索</span>
					</div>
				</div>
			</div>
		</div>
		<div class="data_cent detail-row" id="info">
			<div class="ct_lf ">
				<div class="cb_tle">登录名：</div>
				<div class="cb_val " id="login">
				</div>	
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">真实姓名：</div>
				<div class="cb_val " id="name">
						
				</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">电话：</div>
				<div class="cb_val " id="phone">
						
				</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">邮箱：</div>
				<div class="cb_val " id="email">
						
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">性别：</div>
				<div class="cb_val "id="sex">
						
				</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">认证：</div>
				<div class="cb_val " id="status">
						
				</div>
			</div>	
		</div>
		
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic}/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<div class="sub_btn" id="callCash" onclick="cashSave()"
			style="background:rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">请求绑定</div>
	</div>
	</form:form>
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		
		$("#loading").hide();
		var reuserenname;
	    var flag;
		
		window.cashSave=function() {
			var status='${user.userinfo.status}';
			if(status==null||status==''||status==undefined||status!='2'){
				$("#callCash").tips({
		            side: 3,
		            msg: '请先完成认证',
		            bg: '#00A2E9',
		            time: 4
		        });
		        return false;
			}
			$("#loading").show();
			$("#callCash").hide();
			 if ($("#status").html() == "认证：未通过") {
		            $("#btnSubmit").tips({
		                side: 3,
		                msg: '用户未认证，不可绑定！',
		                bg: '#00A2E9',
		                time: 4
		            });
		            altmesg();
		            return false;
		        }
		        if ($("#role").val() != "enterprise" && $("#role").val() != "carowner") {
		            $("#searchinfo").tips({
		                side: 3,
		                msg: '绑定的用户只能是车主或物流企业！',
		                bg: '#00A2E9',
		                time: 4
		            });
		            altmesg();
		            return false;
		        }

		        $.ajax({
		            url: "${wx}/weixin/driver/saveAttach?" + $("#inputForm").serialize(),
		            dataType: 'json',
		            type: "post",
		            success: function (data) {
		                if (data.value.state == 1) {
		                	$("#callCash").show();
							 $("#callCash").html("申请成功");
							 $("#callCash").unbind();
		                    window.location.href = '${wx}/weixin/driver/driver_list';
		                } else {
		                    $.MsgBox.Alert("保存提示", data.value.message);
		                    window.setTimeout(altmesg, "1000");
		                }
		            }
		        });
		};
		window.altmesg = function() {
			$("#callCash").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};

		$(".data_tab div").click(function() {
			var i = $(this).index();
			$(this).addClass("selected");
			$(".data_tab div").not(this).removeClass("selected");
			if (i == 0) {
				//window.location.href = '${wx}/weixin/driver/driver_list';
			} else {
				//window.location.href = "${wx}/weixin/driver/toSave";
			}
		});
		
		
	    $("#searchinfo").change(function () {
	        search();
	    });
	    window.search=function(){
	        var isnul = true;
	        
	        if ($("#searchinfo").val()==""||$("#searchinfo").val()==null) {
	        	$("#searchinfo").tips({
                    side: 3,
                    msg: '请输入用户名或手机号码',
                    bg: '#00A2E9',
                    time: 4
                });
	        	isnul = false;
	        }
	        if (isnul) {
	        	$("#loading").show();
				$("#callCash").hide();
	            var searchinfo = $("#searchinfo").val();
	            $.ajax({
	                url: "${wlpt}/wlpt/personal/searchInfo",
	                dataType: 'json',
	                data: {searchinfo: searchinfo},
	                cache: false,
	                success: function (data) {
	                    $(".loading_lock").hide();
	                    if (data) {
	                        if (data.value == '未查到指定用户') {
	                            $("#info").addClass("detail-row");
	                            flag = "false";
	                            $("#searchinfo").tips({
	                                side: 3,
	                                msg: '未找到指定用户',
	                                bg: '#00A2E9',
	                                time: 4
	                            });
	                            $("#callCash").show();
	                			$("#loading").hide();
	                        } else {
	                            flag = "true";
	                            if (data.value.user.id) {
	                                $("#userid").val(data.value.user.id);
	                            }
	                            if (data.value.role.enname) {
	                            	 $("#role").val(data.value.role.enname);
	                            }
	                            if (data.value.user.loginName) {
	                            	var usernameval = $.trim(data.value.user.loginName);
	                        		if (usernameval != null && usernameval != ''
	                        				&& usernameval.length > 8) {
	                        			usernameval = usernameval.substring(0, 7) + "…";
	                        		}
	                                $("#login").html(usernameval);
	                            }
	                            if (data.value.user.name) {
	                                $("#name").html(data.value.user.name);
	                            }
	                            if (data.value.user.phone) {
	                                $("#phone").html(data.value.user.phone);
	                            }
	                            if (data.value.user.email) {
	                                $("#email").html(data.value.user.email);
	                            }
	                            if (data.value.info.sex) {
	                                if (data.value.info.sex == '1') {
	                                    $("#sex").html('男');
	                                }
	                                if (data.value.info.sex == '0') {
	                                    $("#sex").html('女');
	                                }
	                            }
	                            if (data.value.info.status) {
	                                if (data.value.info.status == '2') {
	                                    $("#status").html('认证通过');
	                                } else {
	                                    $("#status").html('未通过');
	                                }

	                            }
	                            $("#info").removeClass("detail-row");
	                            $("#callCash").show();
	                			$("#loading").hide();
	                        }
	                    }
	                }
	            });
	        }
	    }
	});
</script>

</html>
