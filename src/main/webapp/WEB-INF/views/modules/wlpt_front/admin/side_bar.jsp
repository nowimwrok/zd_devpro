<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>我的卓大目录</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/personal.css">
    <link  href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
</head>
<style type="text/css">
    a {
        text-decoration: none;
    }

    a:hover, a:active {
        text-decoration: none;
    }

    .sidebar_list {
        padding: 0;
        margin: 0;
        font-family: "微软雅黑";
        font-size: 14px;
    }

    .first_level > ul {
        display: inline-block;
        margin: 0;
        padding: 0;
        margin-left: 5px;
        background: #fff;
        margin-left: -1px;
        width: 100%;
        display: none;
    }

    .first_level > a {
        color: #fff;
        display: block;
        padding-bottom: 5px;
    }

    .first_level {
        background: #00A2E9;
        text-align: center;
    }

    .second_level li a {
        color: #000;
    }

    .second_level li {
        padding-bottom: 5px;
    }

    .second_level li a:hover, .second_level li a:active {
        color: #00A2E9;
    }

    .sidebar_list li {
        padding-top: 5px;
    }

    .second_level {
        background: #fff;
    }

    .first_level > ul {
        color: #ccc;
        font-size: 12px;
        margin-left: 0px;
    }
</style>
<body>
<ul class="sidebar_list">
    <c:set var="menuList" value="${fns:getWlptPersonalnMenu()}"/>
    <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
        <c:if test="${menu.parent.id eq fns:getConst('MUNE_PERSONAL_ID') && menu.isShow eq '1'}">
            <li class="first_level">
                <a>
                        ${menu.name}<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
                </a>
                <ul class="second_level">
                    <c:forEach items="${menuList}" var="menu2">
                        <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">

                            <li>
                                <a href="${fn:indexOf(menu2.href, '://') eq -1 ? wlpt : ''}${not empty menu2.href ? menu2.href : '/404'}"
                                   target="content">${menu2.name}</a>
                            </li>

                        </c:if>
                    </c:forEach>
                </ul>
            </li>
        </c:if>
    </c:forEach>

</ul>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

    $(".first_level").on("click", function () {
        $(".second_level").css("display", "none")
        $(this).find(".second_level").css("display", "block")
        $(this).find("a").find("glyphicon-menu-right").css({
            "transform": "rotate(90deg)",
            "-o-transform": "rotate(90deg)",
            "-webkit-transform": "rotate(90deg)",
            "-moz-transform": "rotate(90deg)"
        })
    })
    $(".first_level").eq(0).find(".second_level").css("display", "block")
    $(this).find("a").find("glyphicon-menu-right")
</script>
</body>
</html>
