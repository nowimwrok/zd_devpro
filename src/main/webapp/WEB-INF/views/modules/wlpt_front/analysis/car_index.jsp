<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
</head>
<body>
<div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix content" style="background-color: #eee;margin: 0px;padding: 0px;">
        <div class="box-top">车辆流向分析</div>
        <div class="box" style="height: 900px;">
                <iframe name="mainFrame" frameborder="0" src="${wlpt}/wlpt/hall/towlptCar"
                        style="margin:0 auto;width:100%;height:100%;" scrolling="no"></iframe>
        </div>

    </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>

</body>
</html>

