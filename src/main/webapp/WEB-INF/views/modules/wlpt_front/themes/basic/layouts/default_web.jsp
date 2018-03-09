<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title default="欢迎光临"/> - ${site.title} -
        招标、找车、找货-海量货源车源永久免费</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <sitemesh:head/>
    <%@include
            file="/WEB-INF/views/modules/wlpt_front/include/head_web.jsp" %>
    <style type="text/css">

    </style>
</head>
<body onkeydown="keyLogin();">
<!--手机端蒙版-->
<div class="mask"></div>
<div class="loginBtn_box" id="loginBtn_box">
    <div id="loginStatus" class="btn loginBtn text-center">登录/注册</div>
</div>
<!--加载中 蒙版-->
<%--<div class="mask" id="maskloading">
    <div class="loading">
        <div class="loader loader-4"></div>
    </div>
</div>--%>
<div class="header">
    <div class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <img src="${ctxStatic }/images/wlptfront/index/icon.png" class="navbar-toggle collapsed"
                     data-toggle="collapse" data-target="#drop"/>
                <a href="${wlpt }"><img src="${ctxStatic }/images/wlptfront/logo.png" alt=""
                                        class="navbar-brand"/></a>
                <img src="${ctxStatic }/images/wlptfront/index/logo_text.png" alt="" class="navbar-brand"/>
            </div>
            <div class="navbar-collapse collapse navbar-left" id="drop">
                <ul class="nav navbar-nav">
                    <c:set var="menuList" value="${fns:getWlptNavMenu()}"/>
                    <c:set var="firstMenu" value="true"/>
                    <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                        <c:if test="${menu.parent.id eq fns:getConst('MUNE_NAV_ID') &&menu.isShow eq '1'}">
                            <li>
                                <a href="${fn:indexOf(menu.href, '://') eq -1 and not empty menu.href ? wlpt: ''}${not empty menu.href ? menu.href : '#'}?index=${idxStatus.index}"
                                   class="text-center button button--nina button--text-thick button--text-upper button--size-s"
                                   data-text="${menu.name}">
                                    <span> ${menu.name}</span>
                                </a>
                            </li>
                            <c:set var="firstMenu" value="false"/>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
            <div class="pull-right nav_phone clearfix">
                <div class="pull-left">
                    <span class="glyphicon glyphicon-earphone"></span>
                </div>
                <div class="pull-left nav_phone_text">
                    <div>服务热线</div>
                    <p>${fns:getConst('SCREENINFORMATIONPHONE')}</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!--end-header-->

<sitemesh:body/>
<!--main-container-->

<!--main-container-->
<!--footer-->
<div class="footer">
    <div class="container">
        <div class="row">
            <div class="col-sm-4 col-xs-6 contact">
                <i>联系我们</i>
                <p>电话：${fns:getConst('SCREENINFORMATIONPHONE')}</p>
                <p>邮箱：zhuoda56@qq.com</p>
                <p>QQ：2127724161</p>
                <p>地址：邯郸市复兴区309邯钢现货交易中心</p>
            </div>
            <div class="col-sm-4 col-xs-6 column text-center">
                <span>关注微信</span>
                <p class="text-center">
                    <img src="${ctxStatic }/images/wlptfront/weichat_card_hover.jpg" alt=""/>
                </p>
            </div>
            <div class="col-sm-4 col-xs-12 copy">
                <span>版权归属</span>
                <p>${fns:getSite("1").copyright}
                    <script type="text/javascript"
                            src="http://121.28.80.66:8089/hbwjww/VieidServlet?webId=90df6a4846787e9b08517753ac0911d5&width=25&heigth=30"></script>
                </p>
            </div>
            <div class="col-sm-12 col-xs-12">
                <p>云服务商&nbsp;:&nbsp;众翔科技</p>
            </div>
        </div>
    </div>
</div>
<!--右边悬浮 功能框-->
<div class="side">
    <ul>
        <li>
            <a href="#" class="login_select">
                <div class="sidebox"><img src="${ctxStatic }/front/img/home.png"></div>
            </a>
        </li>
        <li>
            <a href="#">
                <div class="sidebox">
                    <img src="${ctxStatic }/front/img/wechat.png">
                </div>
            </a>
            <img src="${ctxStatic }/images/wlptfront/weichat_card_hover.jpg" alt="" class="erCode"/>
        </li>
        <li>
            <a href="javascript:void(0);">
                <div class="sidebox">
                    <span class="side_text">1425402567</span>
                    <img src="${ctxStatic }/front/img/qq.png">
                </div>
            </a>
        </li>
        <li>
            <a href="javascript:void(0);">
                <div class="sidebox">
                    <span class="side_text">0310-3188756</span>
                    <img src="${ctxStatic }/front/img/phone.png">
                </div>
            </a>
        </li>
    </ul>
</div>
<!--登录弹出框-->
<div class="box wow">
    <span class="close">&times;</span>
    <div class="box_content">
        <div class="login_box clearfix">
            <form action="${wlpt }/login?login=login" id="loginForm" name="loginForm" method="post"
                  class="col-sm-12 col-xs-12 clearfix">
                <div class="front col-sm-12 col-xs-12">

                    <input type="hidden" name="zd" value="front"/>
                    <div class="front_mm">
                        <h3 class="login_title text-center" style="margin-bottom:30px;">卓大物流平台</h3>
                        <div class="col-sm-12 col-xs-12 has-feedback form-group">
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>
                            <input type="text" class="form-control" id="username" name="username"
                                   placeholder="请输入用户名/手机号码"/>
                        </div>
                        <div class="col-sm-12 col-xs-12 has-feedback form-group">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="请输入密码"/>
                        </div>
                        <div class="col-sm-12 col-xs-12 ">
                            <button class="btn btn-block" id="sub_form" type="button">登录</button>
                        </div>
                        <div class="col-sm-12 col-xs-12 clearfix">
                            <p class="pull-right login_zc">免费注册</p>
                            <p class="pull-right"><a href="${wlpt}/wlpt/personal/forgetpass">忘记密码</a></p>
                        </div>
                    </div>
                </div>
                <div class="back col-sm-12 col-xs-12">
                    <div class="col-sm-12 col-xs-12 text-center">
                        <h3>选择注册类型</h3>
                    </div>
                    <div class="col-sm-12 col-xs-12">
                        <p class="text-center role-type" data-owner="carowner">我是车主</p>
                    </div>
                    <div class="col-sm-12 col-xs-12">
                        <p class="text-center role-type" data-owner="goodsowner">我是货主</p>
                    </div>
                    <div class="col-sm-12 col-xs-12">
                        <p class="text-center role-type" data-owner="enterprise">物流企业</p>
                    </div>
                    <div class="col-sm-12 col-xs-12 text-center" style="color:#fff">
                        （账户类型一经创建，不得修改）
                    </div>
                    <div class="col-sm-12 col-xs-12">
                        <button class="btn btn-block" id="toRegister" type="button">确认创建用户</button>
                    </div>
                    <div class="col-sm-12 col-xs-12 text-center" style="margin-top:15px;">
                        <a href="" style="color:#426DED" class="back_login">登录</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<a href="#header" class="back_top text-center">top</a>
<!-- /container -->
<script type="text/javascript">
    var parid = "${param.index}";
    if (parid) {
        $(".navbar-nav li").removeClass("active");
        $(".navbar-nav li").eq(parid).addClass("active");
    } else {
        $(".navbar-nav li").removeClass("active");
        $(".navbar-nav li").eq(0).addClass("active");
    }
    $('.footer').appendTo('.footerP');

    var brower_w = $(window).width();
    if (brower_w > 768) {
        $('.content_none').addClass('content_home');
        $('.content_none').addClass('swiper-container');
        $('.wrapper_none').addClass('swiper-wrapper');
        $('.swiper_none').addClass('swiper-slide');
    }
    if (brower_w < 768) {
        if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
            new WOW().init();
        }
        ;
        $('.fadeInDown').addClass('wow');
        $('.slideInRight').addClass('wow');
        $('.funs .col-sm-4').addClass('wow').addClass('slideInRight');
        $('.funs .wow_fd').addClass('wow').addClass('fadeInDown');
    }
    $('#loginForm').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            "username": {
                message: '用户名无效',
                validators: {
                    notEmpty: {
                        message: '用户名不能位空'
                    }
                }
            },
            "password": {
                message: '密码无效',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    }
                }
            }
        }
    });


    function keyLogin() {
        if (window.event.keyCode == 13)  //回车键的键值为13
            $("#sub_form").click(); //调用登录按钮的登录事件
    }

    $("#sub_form").click(function () {
        var bootstrapValidator = $("#loginForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            document.getElementById('loginForm').submit();
        }
    });
    //返回顶部
    $('.index_back').smoothScroll({
        offset: 0,
        speed: 1000,
        easing: 'swing',
    });
    //免费注册
    $('.login_zc').click(function () {
        $('.front').css('transform', 'rotatey(180deg)').css('-webkit-transform', 'rotatey(180deg)').css('-moz-transform', 'rotatey(180deg)').css('-o-transform', 'rotatey(180deg)');
        $('.back').css('transform', 'rotatey(0deg)').css('-webkit-transform', 'rotatey(0deg)').css('-moz-transform', 'rotatey(0deg)').css('-o-transform', 'rotatey(0deg)');
    });
    //登录
    $('.back_login').click(function (e) {
        e.preventDefault();
        $('.front').css('transform', 'rotatey(0deg)').css('-webkit-transform', 'rotatey(0deg)').css('-o-transform', 'rotatey(0deg)').css('-moz-transform', 'rotatey(0deg)');
        $('.back').css('transform', 'rotatey(180deg)').css('-webkit-transform', 'rotatey(180deg)').css('-o-transform', 'rotatey(180deg)').css('-moz-transform', 'rotatey(180deg)');

    });


    //免费注册 对勾
    $('.back p').click(function () {
        $('.back p>img').remove();
        var str = '<img src="${ctxStatic }/front/img/right.png" alt="" class="right"/>';
        $(this).append(str);
    });
    var role = "carowner";
    $(".role-type").on("click", function () {
        $(".change-id img").remove();
        $(this).css("position", "relative");
        role = $(this).attr("data-owner");
    });
    $("#toRegister").click(function () {
        $("#toRegister").css("display", "none");
        setTimeout(location.href = "${wlpt}/wlpt/register?ename=" + role, 4000);
        return false;
    });
    //ie9
    if (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE", "")) < 11) {

        $('.back').hide();
        $('.login_zc').click(function () {
            $('.front').hide(500);
            $('.back').show(500);
        });
        $('.back_login').click(function (e) {
            e.preventDefault();
            $('.front').show(500);
            $('.back').hide(500);
        });
    }
    //登录弹出框
    var status = '${fns:getUser().phone==null or fns:getUser().phone eq ''}';
    if (status != 'true') {
        $("#loginStatus").html('业务平台');
    }
    $('.login_select').click(function () {
        status = '${fns:getUser().phone==null or fns:getUser().phone eq ''}';
        if (status == 'true') {
            $('.mask').show().css('background-color', 'rgba(0,0,0,.8)');
            $('.box').show().addClass('bounceInDown');
            status++;
        } else {
            window.location.href = '${wlpt}/loginSuccess';
        }
    });
    $('.loginBtn_box').click(function () {
        status = '${fns:getUser().phone==null or fns:getUser().phone eq ''}';
        if (status == 'true') {
            $('.mask').show().css('background-color', 'rgba(0,0,0,.8)');
            $('.box').show().addClass('bounceInDown');
            status++;
        } else {
            window.location.href = '${wlpt}/loginSuccess';
        }
    });
    //鼠标滚动 返回顶部
    $('.back_top').smoothScroll({
        offset: 0,
        speed: 1000,
        easing: 'swing',
    });
    $(window).scroll(function () {
        var a = $(window).scrollTop();
        if (a > 400) {
            $('.back_top').show(500);
        }
        if (a == 0) {
            $('.back_top').hide(500);
        }
    });

</script>
</body>
</html>