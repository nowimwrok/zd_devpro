<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title><%=request.getAttribute("title")%>
    </title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-con trol" content="no-cache">
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
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>


    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }

        body {
            margin: 0 auto;
            width: 100%;
            background-color: #EBEBEB;
        }

        #resultinfo {
            width: 80%;
            margin-left: 10%;
            margin-right: 10%;
            margin-top: 10%;
            text-align: center;
        }

        .imgWarn {
            width: 30%;
        }

        p {
            font-size: 1.5em;
            color: #F26522;
            margin-top: 3%;
        }
    </style>
</head>

<body>
<div>
    <%-- <%@ include file="./pagetitle.jsp"%> --%>
    <div id="resultinfo">
        <img class="imgWarn" src="./static/images/weixin/warn.png"/>
        <p><%=request.getAttribute("result")%>
        </p>
    </div>
</div>
</body>
</html>
