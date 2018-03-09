<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
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
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet">
    <link href="${ctxStatic}/weixin/css/shop.css" rel="stylesheet">
        <title>支付完成</title>
    </head>
    <body>
        <%--<header class="top">

            <div>
                <a class="top_left left" href="javascript :;" onClick="javascript :history.back(-1);">
                    <img src="${ctxStatic }/images/weixin/shop_img/payFinish_01.png" border="0" title="返回上一页">
                </a>
                <span class="top_center center">
                     提交订单
                </span>
            </div>

        </header>--%>



        <!--主体内容-->
        <section class="allr_wrap">
            <div class="content_wrap">
                <div class="allright center">
                    <img src="${ctxStatic }/images/weixin/shop_img/payFinish_02.png">
                    <p class="center">支付成功</p>
                </div>

                <button class="btn_bg_color sub_btn no-border" onclick="altmesg();">
                    完成
                </button>
            </div>
        </section>

    </body>
    <script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
    <script type="text/javascript">
    window.altmesg = function() {
    	window.location.href = '${wx}/weixin/shop/index';
	};
    </script>
</html>