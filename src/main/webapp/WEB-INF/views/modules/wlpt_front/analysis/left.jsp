<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>平台用户分析</title>
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

        .col-md-12 {
            height: 100%;
            background-color: #2D3440;
            padding: 0;
        }

        .list-group{
            border: none;
        }

        .list-group-item {
            background-color: #2D3440;
            border: none;
            padding-left: 50px;
            border-radius: 0 !important;
            color: #FFFFFF !important;
        }

        a.list-group-item:hover, a.list-group-item:active, a.list-group-item:focus {
            background-color: #2D3440;
        }

        h3{
            height: 80px;
            line-height: 80px;
            margin-top: 0;
            color: #ffffff;
            background-color: #374149;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
           <h3 class="text-center">物流鹰眼</h3>
            <div class="list-group">
                <c:forEach items="${menus}" var="menu">
                    <a href="${wlpt}${menu.href}" target="view_frame" class="list-group-item">${menu.name}</a>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script>
    $("a").bind("click", function () {
        $("a").removeClass("active");
        $(this).addClass("active");
    });

</script>
</body>
</html>
