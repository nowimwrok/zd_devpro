<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>${fns:getConst('SYSTEMTITLE')}--一卡通密码修改</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">

    <script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
    <link href="${ctxStatic}/weixin/css/register.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/updatecardpassword.js"></script>
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
<style type="text/css">
/*整体div -top布局*/
.data_top{
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}
.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
	background-color: rgba(32, 162, 226, 1);
}
.data_tab {
	clear: both;
	width: 100%;
}
.data_tab div {
	width: 33.3%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}
.selected {
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
input {
    margin-top: 20px;
    background-position: left;
    background-repeat: no-repeat;
    background-size: 30px auto;
    background-image: url(/LogisticsSystem/static/images/weixin/pwd_icon.png);
    background-position-x: 3px;
}
</style>
<body>
<div class="data_top data_tab" style="width:100%;padding:0px;color: white;">
		<div class="data_tab_left">登录密码</div>
		<div class="data_tab_center">支付密码</div>
		<div class="selected data_tab_right">一卡通密码</div>
</div>
<div id="content" style="    padding-top: 20px;">
    <%-- <%@ include file="./pagetitle.jsp" %> --%>
    <div>
        <form>
            <div id="form">
                <table align="center">
                	<tr>
                        <td><input type="text"  name="cardid" id="cardid" value="${userMetroCard.cardid}" 
                                   placeholder="一卡通账号" readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td><input type="text" id="txtPhoneNumber" name="txtPhoneNumber" value="${userMetroCard.mobile}"
                                   placeholder="手机号码" maxlength="11" readonly="readonly"/></td>
                    </tr>
					<tr>
                        <td><input type="password" id="oldpassword" name="oldpassword" onblur="checkPwd()"
                                   placeholder="旧密码请输入一卡通旧密码)" maxlength="16"/></td>
                    </tr>
                    <tr>
                        <td><input type="password" id="txtPassWord" name="txtPassWord" onblur="checkPwd()"
                                   placeholder="新密码(6-16位数字，字母，符号)" maxlength="16"/></td>
                    </tr>
                    <tr>
                        <td><input type="password" id="txtConfirmPwd" name="txtConfirmPwd" onblur="checkConfirmPwd()"
                                   placeholder="请再次输入新密码以确认" maxlength="16"/></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" id="txtSmsCode" name="txtSmsCode" onblur="checkCode()"
                                   placeholder="短信验证码" maxlength="6"/>
                            <input id="btnSendCode" type="button" onclick="sendSmscode()" value="获取短信验证码"/>
                        </td>
                    </tr>
                    <tr>
                        <td><input id="btnSubmit" type="button" onclick="changePwd()" value="提    交"/><input type="hidden"
							id="path" value="${wx}" /><input type="hidden"id="zdpath" value="${wlpt}" /></td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</div>
<script>
    $(".data_tab div").click(function() {
    	var i = $(this).index();
    	$(this).addClass("selected");
    	$(".data_tab div").not(this).removeClass("selected");
    	if (i == 0) {
    		window.location.href = '${wx}/weixin/user/changepassword';
    	} else if (i == 1){
    		window.location.href = '${wx}/weixin/user/updatecashpass';
    	}else {
    		window.location.href = '${wx}/weixin/user/toUpdatePasswordCard';
    	}
    });
</script>
</body>
</html>
