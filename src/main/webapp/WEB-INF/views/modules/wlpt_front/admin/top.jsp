<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/top_menu.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/seach_btn.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/foot.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/index_mainbody.css">--%>

<%-- <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>  --%>
<<div class="header">
<div class="wrap">
    <div class="logo"> <a href="index.html"><img src="images/logo.png" alt=""/></a> </div>
    <div class="header-right">
        <div id='cssmenu'>
            <ul>
                <li ><a href=''><span>首页</span></a></li>
                |
                <li ><a href='index.html'><span>业务大厅</span></a>
                    <ul>
                        <li class='has-sub'><a href=''><span>我要找车</span></a></li>
                        <li class='has-sub'><a href=''><span>我要找货</span></a></li>
                        <li class='has-sub'><a href=''><span>招标大厅</span></a></li>
                    </ul>
                </li>
                |
                <li ><a href=''><span>咨询大厅</span></a>
                    <ul>
                        <li class='has-sub'><a href=''><span>咨询首页</span></a></li>
                        <li class='has-sub'><a href=''><span>政策公告</span></a></li>
                        <li class='has-sub'><a href=''><span>诚信</span></a></li>
                        <li class='has-sub'><a href=''><span>价格指数</span></a></li>
                    </ul>
                </li>
                |
                <li class='has-sub'><a href='blog.html'><span>卓大商城</span></a></li>
                |
                <li class='last'><a href='contact.html'><span>我的卓大</span></a></li>
            </ul>
        </div>
    </div>
    <div class="clear"></div>
</div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>

<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script>
    $(".dropdown-toggle").click(function(){

        var href=$(this).attr("href");
        if (href!="/zd/404"){
            window.open(href);
        }
    });
    //点击导航添加背景
    $(".menu li").on("click", function () {
        $(".menu li").removeClass("active-menu");
        $(this).addClass("active-menu")
    });
    $(".menu li").eq(0).addClass("active-menu");

    //鼠标悬停出现二级菜单
    $(".dropdown").mouseover(function () {
        $(this).addClass('open');
    }).mouseout(function () {
        $(this).removeClass('open');
    });


    // 点击导航切换背景
    $(".active-menu li").on("click", function () {
        $(".active-menu li").removeClass("active");
        $(this).addClass("active")
    });
    $(".active-menu li").eq(0).addClass("active")


</script>
