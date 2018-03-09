<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title>${fns:getConst('SYSTEMTITLE')}--重置密码</title>

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
    <script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/resetpassword.js"></script>
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
    <%-- <%@ include file="./pagetitle.jsp" %> --%>
    <div>
        <form>
            <div id="form">
                <table align="center">
                    <tr>
                        <td><input type="text" id="txtPhoneNumber" name="txtPhoneNumber" onblur="checkPhone()"
                                   placeholder="手机号码（输入11位手机号码）" maxlength="11"/></td>
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
</body>
</html>
