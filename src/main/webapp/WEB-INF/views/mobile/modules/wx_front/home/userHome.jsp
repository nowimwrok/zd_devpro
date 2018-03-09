<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
    <title>主页</title>

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
    <link href="/static/weixin/css/swiper.min.css" rel="stylesheet"
          type="text/css">
    <style type="text/css">
        @charset 'utf-8';

        * {
            font-family: "微软雅黑";
            margin: 0;
        }

        body {
            padding: 0px;
            margin: 0px;
        }

        ul {
            list-style: none;
            display: block;
            padding: 0px;
            margin: 0px;
        }

        li {
            display: block;
        }

        a {
            text-decoration: none;
        }

        a:hover {
            text-decoration: none;
            cursor: pointer;
        }

        img {
            border: none;
            width: 30px;
        }

        .col_gray {
            color: rgba(0, 0, 0, 0.52);
        }

        /*------------------------------*/
        .div_box {
            width: 100%;
            height: 100%;
            display: block;
            background-color: rgba(204, 204, 204, 0.07);
            /* background-image: url(./static/images/weixin/u34.png);
            background-repeat: no-repeat;
            background-position: 100%; */
        }

        /*所有块分隔*/
        .div_top, .div_midle, .div_bottom, .dv_split_bold, .dv_split_fine {
            width: 100%;
            display: block;
            clear: both;
        }

        .div_top {
            width: 96%;
            padding: 5px 0px;
            height: 80px;
        }

        .div_midle {
            height: auto;
            display: block;
            margin-bottom: 50px;
            /* height: auto;
            display: block;
            border-bottom: solid 2px #00CCFF;
            margin-bottom: 50px; */
        }

        .div_bottom {
            height: 55px;
            position: fixed;
            bottom: 0px;
            background-color: #00CCFF;
        }

        .dv_split_bold {
            height: 10px;
            background-color: rgba(235, 235, 235, 0.5);
        }

        .dv_split_fine {
            height: 2px;
            position: fixed;
            bottom: 57px;
            background-color: #00CCFF;
        }

        .top_head {
            height: 80px;
            line-height: 80px;
        }

        .top_head > div {
            float: left;
        }

        .hed_img_div {
            width: 23%;
            position: relative;
            height: 80px;
        }

        .hed_img {
            margin: 10px auto;
            width: 60px;
        }

        .hed_img img {
            width: 60px;
            height: 60px;
            border-radius: 5px;
        }

        /*-------------头像结束，基本信息开始 头部高度60px;上下padding:10--------------*/
        .hed_uinfo_div {
            width: 65%;
            height: 80px;
            display: block;
            font-size: 14px;
        }

        .hed_uinfo_div > div {
            width: 100%;
            height: 25px;
            display: block;
        }

        .uinfo_info {
            line-height: 34px;
        }

        .uinfo_phone {
            line-height: 25px;
        }

        .p_level_img {
            width: 15px;
            height: 15px;
            padding-top: 5px;
        }

        .level_img {
            width: 19px;
            height: 19px;
        }

        .hed_link {
            float: right;
            width: 5%;
            text-align: right;
            height: 30px;
            padding: 25px 0px;
        }

        .hed_link img {
            margin: 5px;
            height: 15px;
            width: 8px;
        }

        /*----------菜单栏-------------------------*/
        .mid_menu_tp {
            width: 100%;
            margin: 0 auto;
        }

        .menu_ul {
            width: 100%;
            margin: 0px auto;
            overflow: hide;
            display: block;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

        .menu_ul li {
            color: #847878;
            background-color: white;
            display: block;
            border-right: 1px solid #EBEBEB;
            border-bottom: 1px solid #EBEBEB;
            float: left;
            width: 49%;
            margin: 0px auto;
            flex: auto;
            position: relative;
            padding: 0px;
            /* background-color: rgba(0, 204, 255, 0.02); */
            margin: 1px;
            height: 75px;
            /* display: block;
            border-right: 1px solid #CCC;
            border-bottom: 1px solid #CCC;
            float: left;
            width: 32%;
            flex: auto;
            position: relative;
            padding: 0px */
        }

        .menu_dl, .menu_dl_bm {
            width: 90%;
            height: 50px;
            margin: 5px auto;
            padding: 5px;
            position: absolute;
            display: inline-block;
            clear: left;
        }

        .menu_dl dt {
            float: left;
            width: 25px;
            margin-right: 5px;
            height: 50px;
        }

        .menu_dl_bm dt img {
            height: 30px;
            padding: 12.5px 10px;
        }

        /* .menu_dl dt img,.menu_dl_bm dt img {
            width: 25px;
            height: 25px;
        } */
        .menu_dl dd {
            float: left;
        }

        .menu_dl_bm dt {
            text-align: center;
            float: left;
        }

        .menu_dl_bm dd {
            text-align: center;
            float: left;
            padding: 2px 0;
        }

        /*-------------------------*/
        .banner {
            width: 100%;
            display: block;
            height: 70px;
        }

        .banner img {
            width: 100%;
            height: 70px;
        }

        /*-----------------*/
        .div_bottom {
            width: 100%;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

        .div_bottom > div {
            flex: auto;
            width: 32%;
            text-align: center;
            line-height: 45px;
            font-weight: bold;
            color: #FFFFFF;
            float: left;
        }

        .btn span {
            width: 40px;
            border-radius: 50%;
            /* padding: 5px; */
            -webkit-box-shadow: 5px 5px 5px blue;
            -moz-box-shadow: 5px 5px 5px blue;
            box-shadow: 0 0 10px rgba(67, 172, 195, 0.5);
        }

        .btn img {
            width: 20px;
            margin-top: 5px;
            height: 20px;
        }

        .btndivtop {
            height: 35%;
        }

        .btndivbtm {
            height: 65%;
        }

        /* li + li {
            border-left: 0px solid red;
        } */
        /*图片的适应*/
        .hed_img div {
            width: 50px;
            height: 50px;
            border-radius: 40px;
        }

        .swiper-slide {
            text-align: center;
            height: 70px;
            /* font-size: 18px;
            Center slide text vertically display : -webkit-box;
            display: -ms-flexbox; display : -webkit-flex; display : flex;
            -webkit-box-pack : center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: center */
        }

        .swiper-pagination {
            position: relative;
            margin-top: -10px;
        }

        .swiper-pagination span {
            background: blue;
        }

        .div_poster div, .div_poster img {
            float: left;
        }

        .authened {
            background-color: rgba(20, 181, 47, 0.83);
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            color: white;
            font-size: 13px;
        }

        .icon {
            width: 35px;
            vertical-align: middle;
        }

        .uinfo_menu {
            line-height: 25px;
        }

        .topimg {
            width: 15px;
            padding: 6px 0px;
        }

        .toplidiv {
            font-size: 12px;
        }

        @media screen and(max-width: 400px) {
            .toplidiv {
                font-size: 0.75em;
            }
        }
    </style>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

</head>

<body>
<div class="div_box">
    <div class="div_top">
        <div class="top_head">
            <div class="hed_img_div">
                <div class="hed_img" onclick="editUserInfo()">
                    <c:choose>
                        <c:when test="${fns:getUser().photo!=null }">
                            <img id="imgUpload"
                                 src="${fns:getUser().photo }"/>
                        </c:when>
                        <c:otherwise>
                            <img id="imgUpload" src="${ctxStatic }/images/weixin/ic_user.png"/>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <!-- hed_img_div 头像 -->
            <div class="hed_uinfo_div">
                <div class="uinfo_info" onclick="editUserInfo()">
						<span id="usernameval"><c:choose>
                            <c:when test="${empty fns:getUser().loginName}">
                                ${fns:getUser().name!=null?fns:getUser().name:fns:getUser().userinfo.companyname }
                            </c:when>
                            <c:otherwise>
                                ${fns:getUser().loginName }
                            </c:otherwise>
                        </c:choose> </span>
                    <%-- <c:if test="${empty sessionScope.USERPD.USERNAME}"></c:if>
                    ${sessionScope.USERPD.USERNAME } --%>

						<span style="padding-left:10%;"> <c:choose>
                            <c:when test="${(user.userinfo.status!=null?user.userinfo.status:(fns:getUser().userinfo.status)) eq '2' }">
                                <img class="icon" alt="认证"
                                     src="${ctxStatic}/images/weixin/rz.png"/>
                            </c:when>
                            <c:when test="${(user.userinfo.status!=null?user.userinfo.status:(fns:getUser().userinfo.status)) eq '1' }">
                                <img class="icon" alt="认证中"
                                     src="${ctxStatic}/images/weixin/wrz.png"/>
                            </c:when>
                            <c:otherwise>
                                <img class="icon" alt="未认证"
                                     src="${ctxStatic}/images/weixin/wrz.png"/>
                            </c:otherwise>
                        </c:choose>
						</span>
                </div>
                <!-- uinfo_info end -->
                <div class="uinfo_phone" onclick="editUserInfo()">
						<span class="col_gray">${fns:getUser().phone!=null?fns:getUser().phone:''
                                }</span>
                </div>
                <!-- uinfo_phone end -->
                <div class="uinfo_menu" style="width:120%;">
                    <div style="width:25%;float:left;" onclick="goAuthen()">
                        <div style="width:20%;float:left;">
                            <img class="topimg" alt="s"
                                 src="${ctxStatic }/images/weixin/wxicon_usercenter_profile.png">
                        </div>
                        <div class="toplidiv"
                             style="width:80%;float:left;text-align:center;line-height:28px;">实名认证
                        </div>
                    </div>
                    <div
                            style="width:1%;height:20px;float:left;border-right:2px solid #ccc;margin: 2.5px 0;margin-right: 3%;">
                        &nbsp;</div>
                    <div style="width:25%;float:left;" onclick="goActivitylottery()">
                        <div style="width:20%;float:left;">
                            <img class="topimg" alt="s"
                                 src="${ctxStatic }/images/weixin/wxic_line_bid.png">
                        </div>
                        <div class="toplidiv"
                             style="width:80%;float:left;text-align:center;line-height:28px;">我的礼品
                        </div>
                    </div>
                    <div
                            style="width:1%;height:20px;float:left;border-right:2px solid #ccc;margin: 2.5px 0;margin-right: 3%;margin: 2.5px 0;margin-right: 3%;">
                        &nbsp;</div>
                    <div style="width:40%;float:left;" onclick="goLevelpower()">
                    <c:if test="${user.userinfo.pointlevle=='5'}">
                        <div style="width:40%;float:left;">
                            <img class="topimg" alt="s" style="width:54px;"
                                 src="${ctxStatic }/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif">
                        </div>
                    </c:if>
                    <c:if test="${user.userinfo.pointlevle=='4'}">
                        <div style="width:34%;float:left;">
                            <img class="topimg" alt="s" style="width:46px;"
                                 src="${ctxStatic }/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif">
                        </div>
                    </c:if>
                    <c:if test="${user.userinfo.pointlevle=='3'}">
                        <div style="width:30%;float:left;">
                            <img class="topimg" alt="s" style="width:40px;"
                                 src="${ctxStatic }/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif">
                        </div>
                    </c:if>
                    <c:if test="${user.userinfo.pointlevle=='2'}">
                        <div style="width:24%;float:left;">
                            <img class="topimg" alt="s" style="width:32px;"
                                 src="${ctxStatic }/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif">
                        </div>
                    </c:if>  
                    <c:if test="${user.userinfo.pointlevle=='1'||user.userinfo.pointlevle=='0'}">
                        <div style="width:19%;float:left;">
                            <img class="topimg" alt="s" style="width:26px;"
                                 src="${ctxStatic }/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif">
                        </div>
                    </c:if>   
                        <div class="toplidiv"
                             style="width:40%;float:left;text-align:center;line-height:28px;" onclick="toUserAccountInfo()">特权
                        </div>
                    </div>
                </div>
            </div>
            <!-- hed_uinfo_div 用户信息-->
            <div class="hed_link" style="float:right;" onclick="editUserInfo()">
                <img class="editMore" src="${ctxStatic }/images/weixin/more.png"/>
            </div>
            <!-- hed_link 链接 -->
        </div>
        <!-- top_head 顶部头部 -->
    </div>
    <!-- div_top  上-->
    <div class="dv_split_bold"></div>
    <!-- dv_split_bold 粗分隔线 -->
    <div style="width:100%;height:45px;border-bottom:2.5px solid #EBEBEB;"
         onclick="goOrderpay()">
        <div style="width:60%;height:45px;float:left;">
            <div
                    style="height:45px;float:left;overflow:auto; vertical-align:middle;line-height:45px;">
                <span style="padding-left:20px;font-size:18px;">${(user.userPurse.availablebalance!=null?user.userPurse.availablebalance:(fns:getUser().userPurse.availablebalance))}</span>
            </div>
            <div style="height:45px;width:20%;float:left;line-height:45px;"></div>
        </div>
        <div style="width:40%;height:45px;float:left;">
            <div
                    style="height:45px;width:80%;float:left;font-size:14px;color:rgba(25, 105, 91, 0.72);overflow:auto; vertical-align:middle;line-height:45px;">
                账户安全险保障中
            </div>
            <div
                    style="height:45px;width:20%;float:left;line-height:45px;float:right;">
                <img class="editMore"
                     style="width:8px;height:15px;padding:15px 0px;"
                     src="${ctxStatic }/images/weixin/more.png"/>
            </div>
        </div>
    </div>
    <div class="div_midle">
        <div class="mid_menu_tp">
            <c:set var="menuList" value="${fns:getWeixinMenu()}"/>
            <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                <c:if test="${menu.parent.id eq fns:getConst('MUNE_WX_ID') && menu.isShow eq '1'}">
                    <div class="dv_split_bold" style="height:9px;margin-top:-1px;"></div>
                    <ul class="menu_ul">
                        <c:forEach items="${menuList}" var="menu2">
                            <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
                                <li id="webMoney"
                                    onclick="siMenu('${fn:indexOf(menu2.href, '://') eq -1 ? wx : ''}${not empty menu2.href ? menu2.href : '#'}')">
                                    <dl class="menu_dl_bm">
                                        <dt>
                                            <img alt="s" src="/static/images/weixin/${menu2.icon }">
                                        </dt>
                                        <dd>
                                            <div class="tl">${menu2.name }</div>
                                        </dd>
                                        <dd>
                                            <div class="tl"
                                                 style="font-size:14px;color:rgba(132, 120, 120, 0.61);">${menu2.remarks}</div>
                                        </dd>
                                    </dl>
                                </li>
                                <%--<li>
                                    <a href="${fn:indexOf(menu2.href, '://') eq -1 ? wlpt : ''}${not empty menu2.href ? menu2.href : '/404'}"
                                       target="content">${menu2.name}</a>
                                </li>--%>

                            </c:if>
                        </c:forEach>
                    </ul>
                    </li>
                </c:if>
            </c:forEach>
            <%--<c:forEach items="${menulist.data.menuList}" var="menu"
                varStatus="i">
                <c:if test="${i.count eq 4}">
                    <div class="dv_split_bold" style="height:9px;margin-top:-1px;"></div>
                </c:if>
                <c:if test="${menu.hasMenu}">
                    <ul class="menu_ul">
                        <c:forEach items="${menu.subMenu}" var="sub">
                            <c:if test="${sub.hasMenu}">
                                <c:choose>
                                    <c:when test="${not empty sub.MENU_URL}">
                                        <li id="webMoney" onclick="siMenu('${sub.MENU_URL }')">
                                            <dl class="menu_dl_bm">
                                                <dt>
                                                    <img alt="s" src="static/images/weixin/${sub.MENU_ICON }">
                                                </dt>
                                                <dd>
                                                    <div class="tl">${sub.MENU_NAME }</div>
                                                </dd>
                                                <dd>
                                                    <div class="tl"
                                                        style="font-size:14px;color:rgba(132, 120, 120, 0.61);">${sub.MENU_STATE
                                                        }</div>
                                                </dd>
                                            </dl>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="javascript:void(0);">${sub.MENU_NAME }</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <!--
                            <div class="dv_split_bold" id="btmsoild" style="display:none;"></div> -->
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${i.count eq 4}">
                    <div class="dv_split_bold"></div>
                    <div class="banner" style="overflow: hidden;">
                        <div class="div_poster swiper-wrapper">
                            <div class="swiper-slide">
                                <img
                                    src="${pageContext.request.contextPath}/static/images/weixin/u85.jpg" />
                            </div>
                            <div class="swiper-slide">
                                <img
                                    src="${pageContext.request.contextPath}/static/images/weixin/u34.png" />
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                        <!-- div_poster end 广告 -->
                    </div>
                    <div class="dv_split_bold"></div>
                </c:if>
            </c:forEach>--%>
        </div>
    </div>
</div>
<!-- div_box end 整个页面的box -->
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/include/jqthumb.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/include/swiper.min.js"></script>
<script type="text/javascript">
    $(function () {
        var ischild = "${fns:getUser().ischild}";
        var usernameval = $.trim($("#usernameval").html());
        if (usernameval != null && usernameval != ''
                && usernameval.length > 8) {
            usernameval = usernameval.substring(0, 7) + "…";
            $("#usernameval").html(usernameval);
        }
        //头部导航点击
        window.goAuthen = function () {
            if(ischild=="true"){
                return false;
            }
            window.location.href = "${wx}/weixin/authentication/toAuthentication";
        };
        window.goActivitylottery = function() {
            window.location.href = "${wx}/weixin/activitylottery/toaward";
        };
        /*
         window.goLevelpower = function() {
         window.location.href = "
        ${wx}/weixin/authentication/toAuthentication";
         }; */
        window.goOrderpay = function () {
            if(ischild=="true"){
                return false;
            }
            window.location.href = "${wx}/weixin/user/toAccountBalance";
        };
        //菜单方法
        window.siMenu = function (path) {
            if (path != "${wx}/#") {
                window.location.href = path;
            }
        };
        //编辑个人信息
        window.editUserInfo = function () {
            if(ischild=="true"){
                return false;
            }
            window.location.href = "${wx}/weixin/user/toEditUserInfo";
        };
      //编辑个人信息
        window.toUserAccountInfo = function () {
            window.location.href = "http://139.129.231.71:8080/cboard/starterOther.html#/dashboard/%E6%80%BB%E8%A7%88/8";
        };
        
        
    });
</script>
</body>
</html>
