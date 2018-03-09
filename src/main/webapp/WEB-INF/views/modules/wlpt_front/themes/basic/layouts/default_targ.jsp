<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title default="欢迎光临"/> - ${site.title} -
        招标、找车、找货-海量货源车源永久免费</title>
    <%@include
            file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <sitemesh:head/>
    <style type="text/css">
        .fir_menu li, .sec_menu li {
            cursor: pointer;
        }

        #notic_nav img {
            width: 15px;
            margin-top: -2px;
        }

        #notic_nav a {
            cursor: pointer;
        }
    	.serchBtn .btn{padding:0 12px;height:30px;letter-spacing: 1px;position:relative;top:-1px;border-radius:0;}
    	.main_search{width:auto;}
    	.serchBox{position:relative;padding-right:5px}
    	.main_search i{right:8px;top:19px;}
        
    </style>
</head>
<body style="background: #f5f5f5;animation:none;-webkit-animation:none;">
<div id="guide" style="position:fixed;left:0;top:0;z-index:10;">
    <div id='searchTipBg'></div>
    <div id='searchTip'>
        <div class="company_guide">
            <div class='tipbox' id='step1'><div class='tipword'>平台业务以招标、货源业务为主，签订合同、生成运单进行业务的流转</div><span class='tipboxBtn' onclick='hideTip()'></span><span class='tipboxNextbtn' onclick='nextStep(2)'></span></div>
            <div class='tipbox' id='step2'><div class='tipword'>请完善您的资料，红色*为必填项</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow03' class='tipboxNextbtn' onclick='nextStep(3)'></a><a href='#stepflow02' class='tipboxPrebtn' onclick='preStep(1)'>上一步</a></div>
            <div class='tipbox' id='step3'><div class='tipword'>完善个人设置后便可发起资质认证，资质是业务操作的前置要求</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow04' class='tipboxNextbtn' onclick='nextStep(4)'></a><a href='#stepflow03' class='tipboxPrebtn' onclick='preStep(2)'>上一步</a></div>
            <div class='tipbox' id='step4'><div class='tipword'>业务管理功能菜单，可查看本人的招标、竞标、合同和货源</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow05' class='tipboxNextbtn' onclick='nextStep(5)'></a><a href='#stepflow04' class='tipboxPrebtn' onclick='preStep(3)'>上一步</a></div>
            <div class='tipbox' id='step5'><div class='tipword'>调度管理功能菜单，可操作司机管理，添加车辆等功能</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow06' class='tipboxNextbtn' onclick='nextStep(6)'></a><a href='#stepflow05' class='tipboxPrebtn' onclick='preStep(4)'>上一步</a></div>
            <div class='tipbox' id='step6'><div class='tipword'>财务管理菜单功能，查看账户余额、交易记录，添加银行卡</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow07' class='tipboxNextbtn' onclick='nextStep(7)'></a><a href='#stepflow06' class='tipboxPrebtn' onclick='preStep(5)'>上一步</a></div>
            <div class='tipbox' id='step7'><div class='tipword'>新增加增值服务功能菜单，可查看一卡通消费记录和保单等</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow08' class='tipboxNextbtn' onclick='nextStep(8)'></a><a href='#stepflow07' class='tipboxPrebtn' onclick='preStep(6)'>上一步</a></div>
            <div class='tipbox' id='step8'><div class='tipword'>公司管理菜单功能，可查看企业的资料和资质认证，修改账户密码等</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow09' class='tipboxNextbtn' onclick='nextStep(9)'></a><a href='#stepflow08' class='tipboxPrebtn' onclick='preStep(7)'>上一步</a></div>
            <div class='tipbox' id='step9'><div class='tipword'>新增加数据中心菜单功能，清楚了解企业的招投标、运单和财务数据的变化情况</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow10' class='tipboxNextbtn' onclick='nextStep(10)'></a><a href='#stepflow09' class='tipboxPrebtn' onclick='preStep(8)'>上一步</a></div>
            <div class='tipbox' id='step10'><div class='tipword'>首页现有资金展示，清楚了解自己的资金状态</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow11' class='tipboxNextbtn' onclick='nextStep(11)'></a><a href='#stepflow10' class='tipboxPrebtn' onclick='preStep(9)'>上一步</a></div>
            <div class='tipbox' id='step11'><div class='tipword'>招标业务、货源业务点击切换进行竞价、报价操作</div><span class='tipboxBtn' onclick='hideTip()'></span><span class='tipboxNextbtn' onclick='hideTip();noShow()'></span><div class='notip'><input type='checkbox' id='notip' /><label for='notip'>不再提示</label></div></div>
        </div>
        <div class="car_guide">
            <div class='tipbox' id='step12'><div class='tipword'>首页进行货源的报价，运单中心进行运单的接单、运输提货、卸货操作</div><span class='tipboxBtn' onclick='hideTip()'></span><span class='tipboxNextbtn' onclick='nextStep(16)'></span></div>
            <div class='tipbox' id='step16'><div class='tipword'>请完善您的资料，红色*为必填项</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#tipbar12' class='tipboxNextbtn' onclick='nextStep(13)'></a><a href='#stepflow02' class='tipboxPrebtn' onclick='preStep(12)'>上一步</a></div>

            <!--业务指引-->
            <div class='tipbox' id='step13'><div class='tipword'>业务操作分为调度管理，新增增值服务、数据中心等功能菜单</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow14' class='tipboxNextbtn' onclick='nextStep(14)'></a><a href='#stepflow13' class='tipboxPrebtn' onclick='preStep(16)'>上一步</a></div>
            <!--资金-->
            <div class='tipbox' id='step14'><div class='tipword'>首页现有资金展示，清楚了解自己的资金状态</div><span class='tipboxBtn' onclick='hideTip()'></span><a href='#stepflow15' class='tipboxNextbtn' onclick='nextStep(15)'></a><a href='#stepflow13' class='tipboxPrebtn' onclick='preStep(13)'>上一步</a></div>
            <!--模块-->
            <div class='tipbox' id='step15'><div class='tipword'>招标业务、货源业务点击切换进行竞价、报价操作</div><span class='tipboxBtn' onclick='hideTip()'></span><span class='tipboxNextbtn' onclick='hideTip();noShow()'></span><div class='notip'><input type='checkbox' id='notip' /><label for='notip'>不再提示</label></div></div>
        </div>
    </div>
    <div class='tipbarwrap'>
        <div class='tipbardiv'>
            <div class="company_guide">
                <div class='tipbar' id='tipbar1'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明1</div></div></div>
                <div class='tipbar' id='tipbar2'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明2</div></div></div>
                <div class='tipbar' id='tipbar3'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明3</div></div></div>
                <div class='tipbar' id='tipbar4'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明4</div></div></div>
                <div class='tipbar' id='tipbar5'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明5</div></div></div>
                <div class='tipbar' id='tipbar6'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明6</div></div></div>
                <div class='tipbar' id='tipbar7'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明7</div></div></div>
                <div class='tipbar' id='tipbar8'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明8</div></div></div>
                <div class='tipbar' id='tipbar9'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明9</div></div></div>
                <div class='tipbar' id='tipbar10'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明10</div></div></div>

            </div>
            <div class="car_guide">
                <!--个人设置-->
                <div class='tipbar' id='tipbar15'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明1</div></div></div>
                <!--业务-->
                <div class='tipbar' id='tipbar12'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明2</div></div></div>
                <!--资金显示-->
                <div class='tipbar' id='tipbar13'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明3</div></div></div>
                <!--模块-->
                <div class='tipbar' id='tipbar14'><div class='tipbarInner'><div class='arrow'></div><div class='tipBarword'>说明4</div></div></div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <!--begain-header-->
    <div class="header bg_light_black clearfix">
        <div class="welcome pull-left">
            <a href="">欢迎使用卓大物流平台</a>
        </div>
        <div class="tools pull-right">
            <span class="" style="margin-right: 10px;">客服热线：${fns:getConst('SCREENINFORMATIONPHONE')}</span>
            <span class="">QQ：2127724161</span>
            <i class="ace-icon fa fa-power-off" style="margin-left: 15px;cursor: pointer"
               onclick="location.href='${wlpt}/logout'"></i>
            <!-- <a onclick="toSaas()">跳转到saas</a> -->
        </div>
        <div class="per_select pull-right dropdown">
            <a href="javascript:" class="btn dropdown-toggle" id="dropdownTop"
               data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"
               style="padding: 2px 12px;"> <c:if
                    test="${fns:getUser().ischild}">
                ${fns:getUser().childUser.loginName}
            </c:if> <c:if test="${fns:getUser().ischild eq false}">
                ${fns:getUser().loginName}
            </c:if> <span class="caret"></span>
            </a>
            <ul id="dropdown_menu_ul" class="dropdown-menu" aria-labelledby="dropdownTop">
                <li><c:if test="${fns:getUser().ischild}">
                    ${fns:getUser().childUser.loginName}
                </c:if> <c:if test="${fns:getUser().ischild eq false}">
                    ${fns:getUser().loginName}
                </c:if></li>
                <li><a class="menu_a" href="${wlpt}/wlpt/personal/userinfo">个人设置</a></li>
                <li><a class="menu_a" href="${wlpt }/wlpt/personal/updatepass">账户安全</a></li>
                <li class="divider"></li>
                <li><a href="${wlpt }/logout">退出</a></li>
            </ul>
        </div>
    </div>
</div>
<!--end-header-->
<!--start-top-->
<div class="main_menu clearfix">
    <div class="login pull-left col-lg-2" id="login_div">
        <a href="${wlpt }" target="_blank">
            <img src="${ctxStatic}/images/wlptfront/logo.png" alt="logo"
                 width="150px">
        </a>
    </div>
    <div class="pull-left col-lg-10 clearfix main_menu_div">
        <ul class="top-menu clearfix pull-left" id="index_top_menu">
            <li class="active" id="demo_index"><a
                    href="${wlpt}/wlpt/personal/home_index">首页</a></li>
            <c:if test="${fns:getUser().role.enname ne 'carowner'}">
                <li id="top-menu-goods"><a
                        href="${wlpt}/wlpt/goods/toSave?topmenu=top-menu-goods">发布货源</a></li>
            </c:if>
            <li id="top-menu-pubbid"><a
                    href="${wlpt}/wlpt/bid/publshBid?topmenu=top-menu-pubbid">发布招标</a></li>
            <li id="top-menu-cargps"><a
                    href="${wlpt}/wlpt/trade/toTradeGpsInfo?topmenu=top-menu-cargps">地图车辆</a></li>
            <li id="top-menu-wallet"><a
                    href="${wlpt}/wlpt/consume/toPurse?topmenu=top-menu-wallet">钱包账户</a></li>

        </ul>
        <div class="main_search pull-right">
        	<div class="serchBox pull-left">
        		<input type="text" id="ordno" name="" value="" placeholder="请输入搜索条件">
        	</div>
            <div class="serchBtn pull-left">
	            <button class="btn btn-primary" id="ordseach">查运单</button>
	            <button class="btn btn-success" id="findcar">查车</button>
        	</div>
        </div>
    </div>
</div>
<!--end-top-->

<!--main-container-->
<div class="container clearfix" id="all_con"
     style="padding: 0; width: 100%; margin-top: 10px; overflow: hidden; background: #f5f5f5;">
    <!--begain-sidebar-->
    <div class="sidebar col-sm-2" id="sidebar">
        <ul class="fir_menu">
            <c:set var="menuList" value="${fns:getWlptPersonalnMenu()}"/>

            <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                <c:if test="${menu.parent.id eq fns:getConst('MUNE_PERSONAL_ID') && menu.isShow eq '1'}">
                    <li><a class=href=
                        "javascript:;"
                        style="background: url('${ctxStatic}/front/img/menu_icon/${menu.remarks}.png') 20px
                        no-repeat;background-size:20px;">
                            ${menu.name}</a>
                        <ul class="sec_menu" data-ma="${menu.name}">
                            <c:forEach items="${menuList}" var="menu2">
                                <c:if
                                        test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
                                    <li class="sidebar_active"><a id="${menu2.id}"
                                                                  href="${fn:indexOf(menu2.href, '://') eq -1 ? wlpt : ''}${not empty menu2.href ? menu2.href : '/404'}?mueid=${menu2.id}"
                                                                  class="sidemenu"
                                                                  target="${menu2.target eq '_blank' ? '_blank':'sitbody_iframe' }">
                                        <img
                                                src="${ctxStatic}/front/img/menu_icon/${menu2.remarks}.png">
                                            ${menu2.name}<span class="label label-default bg_orange"></span></a>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    <!--end-sidebar-->
    <div class="container col-sm-10" id="main_con"
         style="background: #f5f5f5; width: 85%;">

        <!--加载中 蒙版-->
        <div class="mask" id="maskloading">
            <div class="loading">
                <div class="loader loader-4"></div>
            </div>
        </div>
        <!--右边悬浮 功能框-->
        <div class="side">
            <ul>
                <li>
                    <a href="${wlpt }">
                        <div class="sidebox"><img src="${ctxStatic }/front/img/home.png">&nbsp;&nbsp;首页</div>
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
                            <span class="side_text">2127724161</span>
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


        <sitemesh:body/>
        <%-- <div class="loading_lock"
            style="width: 100%; display: none; text-align: center;">
            <img src="${ctxStatic }/images/loading.gif">
            <p>等待中</p>
        </div> --%>
    </div>
</div>
<!--main-container-->
<div class="foot bg_light_black text-center">${site.copyright}
</div>
</div>

<!-- /container -->
</body>
<script src="${ctxStatic}/jquery-plugin/jquery.cookie.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/modules/wlpt/include/jqthumb.min.js"></script>
<%-- <script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script> --%>
<script src="${ctxStatic}/front/js/guide.js"></script>
		<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
<script>


    $(function () {

        function clientHei() {
            var bheight = document.documentElement.clientHeight;
            var bwidth = document.documentElement.clientWidth;
            var hmain = document.getElementById("all_con");
            hmain.style.width = '100%';
            hmain.style.height = (bheight - 120) + 'px';
            var sidebarHei = document.getElementById("sidebar");
            sidebarHei.style.height = (bheight - 120) + 'px';
            var mainCon = document.getElementById("main_con");
            mainCon.style.height = (bheight - 120) + 'px';
            mainCon.style.width = (bwidth - 195) + 'px';
        }

        clientHei();
        /*iframe*/
        var mainCon_h = $("#main_con").height();
        $('iframe').height(mainCon_h + 'px');
        var w = document.documentElement.clientWidth;
        //定义加载中的高和宽
        $('.mask').width($('iframe').width() + 'px');
        $('.mask').height($('#main_con').height() + 'px');
        if (w < 1200) {
            $('iframe').height(mainCon_h - 83 + 'px');
        }
        $("#sidebar a.sidemenu").click(function () {
            // 一级菜单焦点
            var target = $(this).attr("target");
            if (target == "_blank") {
                toSaas();
                return false;
            } else {
                $(".sec_menu").hide();
                $(".sec_menu li a").removeClass("sidebar_active");
                $(this).addClass("sidebar_active");
                $(this).parents(".sec_menu").css("display", "block");
                $("#notic_nav").html('<span class="glyphicon glyphicon-chevron-right"></span>'
                    + '<a href="' + $(this).attr("href") + '" class="text">' + $(this).html() + '</a>');
                $("#notic_pro").html($(this).parents(".sec_menu").attr("data-ma"));
                $("#sitbody_iframe").attr("src", $(this).attr("href"));
                // 大小宽度调整
                clientHei();
                return false;
            }
        });

        $("#notic_nav").click(function () {
            $("#sitbody_iframe").attr("src", $(this).find("a").attr("href"));

            // 大小宽度调整
            clientHei();
            return false;
        });
        $("#index_top_menu li a").click(function () {
            $("#index_top_menu li").removeClass("active");
            $(this).parents("li").addClass("active");
            $("#sitbody_iframe").attr("src", $(this).attr("href"));
            $("#notic_nav").html('');
            $("#notic_pro").html($(this).html());
            // 大小宽度调整
            clientHei();
            return false;
        });

        $("#dropdown_menu_ul li .menu_a").click(function () {
            $("#notic_nav").html('<span class="glyphicon glyphicon-chevron-right"></span>'
                + '<a href="' + $(this).attr("href") + '" class="text">' + $(this).html() + '</a>');
            $("#notic_pro").html("账户设置");

            $("#sitbody_iframe").attr("src", $(this).attr("href"));
            // 大小宽度调整
            clientHei();
            return false;
        });

        $('.dropdown-menu').hover(function () {
        }, function () {
            $(this).hide();
        });
        $('.per_select a.dropdown-toggle').click(function () {
            $('.open>.dropdown-menu').show();
        });
        var leftWidth = 194; // 左侧窗口大小
        var tabTitleHeight = 33; // 页签的高度
        var htmlObj = $("html"), mainObj = $("#sidebar");
        var headerObj = $("#header"), footerObj = $("#footer");
        var frameObj = $("#left, #openClose, #right, #right iframe");

        function wSize() {
            var minHeight = 500, minWidth = 980;
            var strs = getWindowSize().toString().split(",");
            htmlObj.css({
                "overflow-x": strs[1] < minWidth ? "auto" : "hidden",
                "overflow-y": strs[0] < minHeight ? "auto" : "hidden"
            });
            mainObj.css("width", strs[1] < minWidth ? minWidth - 10 : "auto");
            frameObj.height((strs[0] < minHeight ? minHeight : strs[0]) - headerObj.height() - footerObj.height() - (strs[1] < minWidth ? 42 : 28));
            $("#openClose").height($("#openClose").height() - 5);// <c:if test="${tabmode eq '1'}">
            $(".jericho_tab iframe").height($("#right").height() - tabTitleHeight); // </c:if>
            wSizeWidth();
        }

        function wSizeWidth() {
            if (!$("#openClose").is(":hidden")) {
                var leftWidth = ($("#sidebar").width() < 0 ? 0 : $("#sidebar").width());
                alert(leftWidth);
                $("#main_con").width($("#all_con").width() - leftWidth - 5);
            } else {
                $("#main_con").width("100%");
            }
        }

        $(window).resize(function () {
            clientHei();
        });
        var topmenu = '${param.topmenu}';
        var menuid = '${param.mueid}';
        if (menuid != $.cookie("menuid") && menuid) {
            $.cookie("menuid", menuid);
        } else {
            menuid = $.cookie("menuid");
        }
        if (topmenu != $.cookie("topmenu") && topmenu) {
            $.cookie("topmenu", '${param.topmenu}');
        } else {
            topmenu = $.cookie("topmenu");
        }
        /* 	if (menuid) {
                $(".sec_menu").hide();
                $(".sec_menu li a").removeClass("sidebar_active");
                $("#" + menuid).addClass("sidebar_active");
                $("#" + menuid).parents(".sec_menu").css("display", "block");
            } */

        //    头部导航
        if (topmenu) {
            $(".top-menu li").removeClass("active");
            $("#" + topmenu).addClass("active");
        }
        //    侧边导航
        //$(".sec_menu").eq(0).show();
        $(".fir_menu>li>a").click(function () {
            $(".sec_menu").hide();
            $(this).next().css("display", "block");
        });
        $(".fir_menu>li>a").click(function () {
            $(".sec_menu").hide();
            $(this).next().css("display", "block");
        });

        //tab_
        $(".tab_button button").click(function () {
            $(".tab_button button").removeClass("btn-active");
            $(this).addClass("btn-active");
        });
        $("#ordseach").bind(
                {
                    "mouseover": function () {
                        $("#linkkh").hide();
                        $("#orderspan").show(2000);
                        $("#orderspan").animate({
                            "left": 480
                        }, 2500);

                    },
                    "click": function () {
                        var orderNo = $("#ordno").val();
                        $("#linkkh").show("slow");
                        $("#orderspan").hide('slow');
                        if (orderNo.length < 18) {
                            $("#ordno").val("请输入正确条件").css("color",
                                "red");
                            return false;
                        }
                        window.location.href = "${wlpt}/wlpt/trade/searchOrder?orderno="
                            + $("#ordno").val();
                    }
                });
		        $('#findcar').click(function(e){
		        	var carnumber = $("#ordno").val();
		        	console.log(carnumber);
		        	var express =/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
		        	if(express.test(carnumber)){
					var href="${wlpt}/wlpt/trade/findCar?carNumber="+$("#ordno").val();
					 $("#sitbody_iframe").attr("src", href);
		        	}else{
		        		$.MsgBox.Alert('系统信息','请输入正确的车牌号！');
		        	}
				}); 
    })

    $('.side ul li').hover(function () {
        var index = $(this).index();
        if (index == 1) {
            $(this).find('.erCode').show(500);
            $(this).find('div').css('background-color', '#b20e10');
        }
        else if (index == 2 || index == 3) {
            $(this).find('span').show(500);
            $(this).find('div').css('background-color', '#b20e10');
        }
    }, function () {
        var index = $(this).index();
        if (index == 1) {
            $(this).find('.erCode').hide(500);
            $(this).find('div').css('background-color', 'rgba(0,0,0,.5)');
        }
        else if (index == 2 || index == 3) {
            $(this).find('span').hide(500);
            $(this).find('div').css('background-color', 'rgba(0,0,0,.5)');
        }
    });

    /* var iframe = document.getElementById('sitbody_iframe');
    if (iframe.attachEvent){
      iframe.attachEvent("onload", function(){
        $('.mask').hide();
      });
    } else {
      iframe.onload = function(){
        $('.mask').hide();
      };
    } */
    //公告无缝滚动
    var timer;
    var marquee = document.getElementById('marquee');
    var offset = 0;
    var scrollheight = marquee.offsetHeight;
    var firstNode = marquee.children[0].cloneNode(true);
    $("#marquee").append("<br>" + $("#marquee").html() + "<br>");
    marquee.appendChild(firstNode);//还有这里
    function start() {
        if (offset == scrollheight) {
            offset = 0;
        }
        marquee.style.marginTop = "-" + offset + "px";
        offset += 1;
    }

    timer = setInterval(start, 60);
    $('#marquee p').hover(function () {
        clearInterval(timer);
        timer = null;
    }, function () {
        timer = setInterval(start, 50);
    });
    //搜索框所在 宽度及其位置
    var main_con_w=$(window).width()-185-40;
    $('.main_menu_div').width(main_con_w+'px');
    //alert(main_con_w);
    //操作指引
    function guideShow(){
        var options = {
            expires : 1
        };
        if ($.cookie('visits') == null) {
            $.cookie('visits', '1', options);
            $('#guide').show();
            $('#searchTipBg').show();
        }else{
            $('#guide').hide();
            $('#guide').css('z-index','0');
        }
    }
    guideShow();
    var identity='${fns:getUser().role.enname}';
    function live(){
        if(identity=='carowner'){
            $('.company_guide').hide();
            $('.car_guide').show();
            $('#step12').show();
        }
        else{
            $('.company_guide').show();
            $('.car_guide').hide();
            $('#step1').show();
        }
    }
    live();
    var g_bwidth=$(window).width();
    var g_bheight=$(window).height();
    $('#guide-step').width(g_bwidth+'px').height(g_bheight+'px');
    $('.tipbarwrap').width(g_bwidth+'px').height(g_bheight+'px');
    $('#searchTip').width(g_bwidth+'px').height(g_bheight+'px');
    $('#guide').width(g_bwidth+'px').height(g_bheight+'px');
    $('.tipbox .tipboxBtn').click(function(){
        $('#guide').css('z-index','0');
    });
    $('#step15 .tipboxNextbtn').click(function(){
        $('#guide').css('z-index','0');
    });
    $('#step11 .tipboxNextbtn').click(function(){
        $('#guide').css('z-index','0');
    });
    
    
     //查车查位置
    var mainPage=$('iframe',parent.document);
    
		
</script>
</html>