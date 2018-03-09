<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>运单贷业务介绍</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">

    <script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?a5165b3e9eb4865f67418be88c91fc33";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

    <link href="static/css/weixin/waybillloanshow.css" rel="stylesheet" type="text/css">
</head>

<body>
<div>
    <%-- <%@ include file="./pagetitle.jsp" %> --%>
    <div id="handleInfo">
        <div>
            <img class="imgLoan" src="${pageContext.request.contextPath}/static/images/weixin/waybill_loan1.png"/>
        </div>
        <div>
            <img class="imgPostLoan" src="${pageContext.request.contextPath}/static/images/weixin/waybill_loan2.png"/>
        </div>
    </div>
</div>
</body>
</html>
