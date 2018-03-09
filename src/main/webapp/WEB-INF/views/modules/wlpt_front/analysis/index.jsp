<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>卓大物流平台数据分析中心</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>

    <style>
        html, body {
            margin: 0;
            height: 100%;
        }

        .container-fluid {
            height: 100%
        }

        .row {
            height: 100%
        }

        .col-md-2 {
            height: 100%;
            padding: 0;
        }

        .col-md-10 {
            height: 100%;
            padding: 0;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <iframe name="left" id="left" width="100%" height="100%" src="${wlpt}/wlpt/dataCenter/left" scrolling="auto " frameborder="0 "></iframe>
        </div>
        <div class="col-md-10" >
            <iframe name="view_frame" id="view_frame" width="100%" height="100%" src="${wlpt}/wlpt/dataCenter/testvalid" scrolling="auto " frameborder="0 "></iframe>
        </div>
    </div>
</div>
<script>
    function changeSrc(){
        var path="${wlpt}/wlpt/dataCenter/testvalid";          //你要变化的路径 你页面是用的jsp吗？如果是，path可以用el表达式动态生成
        document.getElementById("view_frame").src=path;
    }

</script>

</body>
</html>
