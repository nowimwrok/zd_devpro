<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title default="欢迎光临"/> - ${site.title} -
        Powered By zhuoda56</title>
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head.jsp" %>
    <sitemesh:head/>
    <style type="text/css">
        /*我的账户样式*/
        .my_account_wrap {
            float: left;
            padding: 5px 10px;
            position: relative;
            cursor: pointer;
            width: 126px;
            font-size: 15px;
            margin-top: -7px;
            color: #333;
        }

        .my_account {
            display: block;
            padding: 5px;
            padding-top: 8px;
            padding-bottom: 8px;
        }

        .my_account span {
            color: #333;
        }

        .my_account_over {
            -moz-box-shadow: -3px 0px 4px #ccc;
            -webkit-box-shadow: -3px 0px 4px #ccc;
            box-shadow: -3px 0px 4px #ccc;
        }

        .account_title {
            /* padding-left: 6px;
             padding-right: 10px;*/
            font-size: 15px;
        }

        .account_con_wrap {
            display: none;
            font-family: "Microsoft YaHei";
            background: #fff;
            z-index: 100;
            /*-moz-box-shadow: -3px 0px 4px #ccc;
            -webkit-box-shadow: -3px 0px 4px #ccc;*/
            padding: 15px 0px;
            position: absolute;
            top: 94%;
            right: 10px;

            width: 170%;
            /*background: transparent;
            background-color: rgba(69, 172, 195, 0.46);*/
            /* color: #FFFFFF;
             border-radius: 5px;*/
        }

        .account_con {
            width: 80%;
            margin: 0px auto;
        }

        .con_title {
            height: 65px;
            border-bottom: 1px solid #ccc;
        }

        .con_title img {
            display: block;
            float: left;
        }

        .welcome {
            font-size: 14px;
            margin-top: 2px;
        }

        .welcome h3 {
            font-weight: bold;
            margin: 0px;
            line-height: 20px;
        }

        .account_list li {
            height: 40px;
            line-height: 40px;
            clear: both;
        }

        .account_list li .left {
            float: left;
            color: #080808; /*rgb(255, 255, 255)*/
        }

        .account_list li .right {
            float: right;
            color: #00aeff;
        }

        .con_headimg {
            width: 46px;
            height: 47px;
            float: left;
            border-radius: 50%;
            border: solid 1px #CCC;
            margin-right: 5px;
        }
.con_headimg1 {
            width: 46px;
            height: 47px;
            float: left;
            border-radius: 50%;
            border: solid 1px #CCC;
            margin-right: 5px;
        }
        .con_headimg1 img {
    width: 46px;
            height: 47px;
            float: left;
            border-radius: 50%;
            margin-right: 5px;
}
        .con_headimg img, .jqthumb div {
            width: 100%;
            border-radius: 50%;
            height: 100%;
        }

        .wrap a {
            text-decoration: none;
        }
        #ordno {
            text-align: center;
            background: #ffffff;
            color: #cccccc;
            border: none;
        }
        #orderspan{
            display: none;
            margin-left: 5px;
        }
        #ordseach {
            background-image: url("${ctxStatic}/images/search.png");
            background-repeat: no-repeat;
            background-size: 18px;
            width: 18px;
            display: block;
            height: 18px;
            border: 1px solid #CCC;
            border-radius: 18px;
            float: left;
            margin-left: 4px;
            cursor: pointer;
        }
        .top-warp-r{
            float: right;

        }
        .top-warp-r span{
            float: left;
        }
        .top-warp-r span input{
            height: 20px;
        }
        .has-sub a span{
            color: #428bca;
        }
        /*End--我的账户样式*/
    </style>
</head>
<body>
<div class="top-nav">
    <p class="top-wrap" style="margin-bottom: 0px;">
        <span class="top-l white">欢迎使用卓大物流平台，您的物流贴身管家</span>

        <span class="top-warp-r">
        <span id="orderspan"><input id="ordno" placeholder="请输入运单号"/></span>
        <span id="ordseach"><!--<input type="submit" value="">--></span>
        </span>
        <span
                class="top-r"> <c:if
                test="${fns:getUser().loginName==null or fns:getUser().loginName eq ''}">
            <a href="${wlpt }/login?login=login">登录</a>
            <strong>|</strong>
            <a href="${wlpt }/register">免费注册</a>
        </c:if> <c:if
                test="${fns:getUser().loginName!=null and fns:getUser().loginName ne ''}">
					<span style="color: red;">
                        您好 &nbsp;&nbsp;&nbsp;
                        <a href="${wlpt }/wlpt/personal/index" target="_blank">
                            <c:if test="${fns:getUser().ischild}">
                                ${fns:getUser().childUser.loginName}
                            </c:if>
                            <c:if test="${fns:getUser().ischild eq false}">
                                ${fns:getUser().loginName}
                            </c:if>

                        </a>
						&nbsp;&nbsp;<a href="${wlpt }/logout">退出</a></span>
        </c:if> <a id="linkkh" target="_blank" href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptAboutUs"
                   class="white about-us">客服热线:${fns:getConst('SCREENINFORMATIONPHONE')}</a>
			</span>
    </p>
</div>

<div class="header">
    <div class="wrap" style="width: 80%">
        <div class="logo"><a href="${wlpt }" target="_blank"><img src="${ctxStatic }/images/wlptfront/logo.png"
                                                                  width="180px" height="52px"></a></div>
        <div class="header-right" style="width:75.5%;">
            <div id='cssmenu'>
                <ul style="font-size: 16px;">

                    <c:set var="menuList" value="${fns:getWlptNavMenu()}"/>
                    <c:set var="firstMenu" value="true"/>
                    <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                        <c:if test="${menu.parent.id eq fns:getConst('MUNE_NAV_ID') &&menu.isShow eq '1'}">
                            <c:if test="${!firstMenu}">|</c:if>

                            <li>
                                <a href="${fn:indexOf(menu.href, '://') eq -1 and not empty menu.href ? wlpt: ''}${not empty menu.href ? menu.href : '#'}?index=${idxStatus.index-3}">
                                    <span> ${menu.name}</span>
                                </a>

                                <ul style="padding: 0;" role="menu" aria-labelledby="dLabel">
                                    <c:forEach items="${menuList}" var="menu2">
                                        <c:if test="${menu2.parent.id eq menu.id && menu2.isShow eq '1'}">
                                            <li class='has-sub'>
                                                <a href="${fn:indexOf(menu2.href, '://') eq -1 ? wlpt : ''}${not empty menu2.href ? menu2.href : '/404'}?index=${idxStatus.index-3}"
                                                   target="${menu2.target}">
                                                    <span>${menu2.name}</span>
                                                </a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </li>
                            <c:set var="firstMenu" value="false"/>
                        </c:if>
                    </c:forEach>


                </ul>
            </div>
            <c:if test="${isShowAt eq true}">
                <!--我的账户-->
                <div class="my_account_wrap">


                    <a href="#" class="my_account">
                        <img style="margin-bottom: -3px;vertical-align: inherit;"
                             src="${ctxStatic }/images/weixin/user_easyicon.png"
                             width="15px">
                        <span class="account_title">我的账户</span>
                        <span style="margin-top:2px;">></span>
                    </a>


                    <div class="account_con_wrap">
                        <div class="account_con">
                            <div class="con_title clearfix">
                                <div class="con_headimg">
                                    <img onerror="this.onerror=null;this.src='/static/images/weixin/user_head.png'"
                                         src="${fns:getUser().photo}">
                                </div>
                                <div class="welcome clearfix">
                                    <h3><a href="${wlpt }/wlpt/personal/index" target="_blank">
                                        <c:if test="${fns:getUser().loginName!=null and fns:getUser().loginName ne ''}">
                                            ${fns:getLoadUser(true).loginName}
                                        </c:if>
                                        <c:if test="${fns:getUser().loginName==null or fns:getUser().loginName eq ''}">
                                            请登陆
                                        </c:if></a>
                                    </h3>
                                    <p style="color: #9E9E9E;margin: 0px;">欢迎来到卓大平台</p>
                                </div>
                            </div>
                            <ul class="account_list">
                                <li class="clearfix">
                                    <span class="left">我的钱包</span>
                                <span class="right">
                                    <c:if test="${fns:getUser().userPurse.availablebalance==null or fns:getUser().userPurse.availablebalance eq ''}">
                                        0.00
                                    </c:if>
                                    <c:if test="${fns:getUser().userPurse.availablebalance!=null and fns:getUser().userPurse.availablebalance ne ''}">
                                        ${fns:getLoadUser(true).userPurse.availablebalance}
                                    </c:if>
                                    元
                                </span>
                                </li>
                                <li class="clearfix">
                                    <span class="left">我的卓币</span>
                                <span class="right">
                                 <c:if test="${fns:getUser().userPurse.availablecoin==null or fns:getUser().userPurse.availablecoin eq ''}">
                                     0
                                 </c:if>
                                    <c:if test="${fns:getUser().userPurse.availablecoin!=null and fns:getUser().userPurse.availablecoin ne ''}">
                                        ${fns:getLoadUser(true).userPurse.availablecoin}
                                    </c:if>
                                    币</span>
                                </li>
                                <li class="clearfix">
                                    <span class="left">油气余额</span>
                                <span class="right">
                                    <c:if test="${fns:getUser().userPurse.petrolbalance==null or fns:getUser().userPurse.petrolbalance eq ''}">
                                        0.00
                                    </c:if>
                                    <c:if test="${fns:getUser().userPurse.petrolbalance!=null and fns:getUser().userPurse.petrolbalance ne ''}">
                                        ${fns:getLoadUser(true).userPurse.petrolbalance}
                                    </c:if>元</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div><!--End--我的账户-->
            </c:if>

        </div>
        <div class="clear"></div>
    </div>
</div>


<div class="container" id="default_content_index">
    <div class="content">
        <sitemesh:body/>
    </div>
    <footer>
        <div class="foot-wrap">
            <div class="company-ul">
                <ul class="company-list">
                    <li><a target="_blank" href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptAboutUs">关于我们</a></li>
                    <li><a target="_blank" href="${wlpt}/wlpt/agreement/wlptToolInfo?code=serviceitem">服务协议</a></li>
                    <li><a target="_blank" href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptContactUs">联系我们</a></li>
                    <li><a target="_blank" href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptLegalStatement">法律声明</a>
                    </li>
                </ul>
            </div>
            <%--<div class="company-ul">
                <ul class="company-list">
                    <li>友情链接：</li>
                    <li><a href="http://www.cntr56.cn">广东天润物流市场</a></li>
                    |
                    <li><a href="http://www.hbistc.com">河钢云商</a></li>
                    |
                    <li><a href="http://www.chinawuliu.com.cn">中国物流采购网</a></li>
                    |
                    <li><a href="http://www.ouyeel.cn">欧冶云商</a></li>
                    |
                    <li><a href="http://www.zhaogang.com">找钢网</a></li>
                    |
                    <li><a href="http://www.steelcn.cn">中钢网</a></li>
                    |
                    <li><a href="http://www.baosteel.com">大宗钢铁电子交易</a></li>
                    |
                    <li><a href="http://www.hbzydq.com">河北卓越电气有限责任公司</a></li>
                    |
                    <li><a href="http://wfcg.hgfq.cn">河北邯钢附企公司</a></li>
                </ul>
            </div>--%>

            <div class="copyright" style="padding-bottom: 5px">
					<span>
						Copyright&nbsp;©&nbsp;2015&nbsp;邯郸市众翔信息科技有限公司&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;<img
                            style="padding-bottom: 3px;vertical-align: middle;"
                            src="${ctxStatic }/images/wlptfront/newpolice.png" width="2%">粤ICP&nbsp;备15104668号
					</span>
            </div>
        </div>
    </footer>
</div>
<!-- /container -->
</body>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/include/jqthumb.min.js"></script>
<script>
    $(".dropdown-toggle").click(function () {

        var href = $(this).attr("href");
        if (href != "/zd/404") {
            window.open(href);
        }
    });


    $(window).load(function () {

        $("#ordseach").bind({"mouseover":function(){
            $("#linkkh").hide();
            $("#orderspan").show(2000);
            $("#orderspan").animate({"left":480},2500);

        },"click": function () {
            var orderNo=$("#ordno").val();
            $("#linkkh").show("slow");
            $("#orderspan").hide('slow');
            if (orderNo.length<18){
                $("#ordno").val("请输入正确运单号").css("color","red");
                return false;
            }
            window.location.href="${wlpt}/wlpt/trade/searchOrder?orderno="+$("#ordno").val();
        }});
        $("#flexiselDemo1").flexisel();
        $("#flexiselDemo2").flexisel({
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 1
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 2
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });

        $("#flexiselDemo4").flexisel({
            visibleItems: 5,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: true,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 1
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 2
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });

    });
    //     我的账户悬停出现详细内容
    $(".my_account").bind("mouseover", function () {
        $(".account_con_wrap").show();
        $('.con_headimg img').jqthumb({
            width: 44,
            height: 45,
            after: function (imgObj) {
                imgObj.css('opacity', 0).animate({
                    opacity: 1
                }, 1000);
            }
        });
        
        $(this).addClass("my_account_over")
    });
    $(".my_account_wrap").bind("mouseout", function () {
        $(".account_con_wrap").hide();
        $('.con_headimg').removeClass('con_headimg').addClass("con_headimg1");
        $(".my_account").removeClass("my_account_over")
    });

    $('.example1').wmuSlider();

</script>
</html>