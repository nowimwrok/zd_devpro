<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
<style type="text/css">
    html, body {
        margin: 0;
        height: 100%;
    }
</style>
</head>
<body>

<div class="container-fluid" id="main-container" style="height:100%;">
    <div id="page-content" class="clearfix content" style="background-color: #eee;height:100%;margin: 0px;padding: 0px;">
        <div class="box-top">物流平台货物流向分析</div>
        <div class="box" style="width: 100%;height: 100%;display: block;">
            <iframe name="mainFrame" id="userFrame" frameborder="0" height="100%" width="100%"
                    src="${wlpt}/wlpt/dataCenter/flow_trend"
                    style="margin:0 auto;width:100%;height:100%;" scrolling="no"></iframe>

        </div>

    </div>

</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->


</body>
</html>

