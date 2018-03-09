<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
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
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet">
    <link href="${ctxStatic}/weixin/css/shop.css" rel="stylesheet">
    <title>商城首页</title>
    <style>
        *{
            padding:0px;
            margin: 0px;
        }
        .shop_menu .menu li p {
            height: 30px;
            line-height: 30px;
            text-align: center;
            font-size: 0.8rem;
        }
        .shop_menu .menu {
            width: 67%;
            float: left;
            padding: 0px;
            padding: 10px 0;
        }
        .shop_menu .header-info {
            /* height: 132px; */
            line-height: 80px;
            float: left;
            width: 31%;
            margin: auto 0px;
        }
       .shop_introduce ul{
            width: 100%;
            margin: 0px;
            padding: 0px;
        }
        .shop_menu .header-info .header img {
		    margin-top: 15px;
		    width: 50px;
		    padding-top: 0px;
		    height: 50px;
		    border-radius: 50%;
		}
		input {
		    font-size: 0.9em;
		    line-height: 35px;
		    text-align: center;
		}
    </style>
</head>
<body>
<%--<header class="top">
    <div>
        <a class="top_left left" href="javascript :;" onClick="javascript :history.back(-1);">
            <img src="${ctxStatic}/images/weixin/shop_img/payFinish_01.png" border="0" title="返回上一页">
        </a>
                <span class="top_center center">
                     卓大商城
                </span>
    </div>

</header>--%>


<!--主体内容-->
<section class="allr_wrap">
<c:if test="${isShowAt eq true}">
    <div class="shop_menu clearfix">

        <div class="header-info">
            <div class="header">
            <c:choose>
            	<c:when test="${empty user.photo }">
            		<img src="${ctxStatic }/images/weixin/user_head.png">
            	</c:when>
            	<c:otherwise>
            		<img onerror="this.onerror=null;this.src='/static/images/weixin/user_head.png'" src="${user.photo }">
            	</c:otherwise>
            </c:choose>

            </div>
           	<span id="usernameval">
           		<c:choose>
                     <c:when test="${empty user.loginName}">
                         ${user.name!=null?fns:getUser().name:user.userinfo.companyname }
                     </c:when>
                     <c:otherwise>
                         ${user.loginName }
                     </c:otherwise>
                 </c:choose>
            </span>

        </div>

        <ul class="menu">
            <li>
                <p>我的钱包</p>

                <div class="total_num">
                <c:if test="${user.userPurse.availablebalance==null or user.userPurse.availablebalance eq ''}">
                     0.00
                 </c:if>
                 <c:if test="${user.userPurse.availablebalance!=null and user.userPurse.availablebalance ne ''}">
                     ${user.userPurse.availablebalance}
                 </c:if>

                </div>
            </li>
            <li>
                <p>我的卓币</p>
                <div class="total_num">
                	<c:if test="${user.userPurse.availablecoin==null or user.userPurse.availablecoin eq ''}">
                        0
                    </c:if>
                    <c:if test="${user.userPurse.availablecoin!=null and user.userPurse.availablecoin ne ''}">
                        ${user.userPurse.availablecoin}
                    </c:if>
                 </div>
            </li>
            <li>
                <p>油汽余额</p>
                <div class="total_num">
                	<c:if test="${user.userPurse.petrolbalance==null or user.userPurse.petrolbalance eq ''}">
                        0.00
                    </c:if>
                    <c:if test="${user.userPurse.petrolbalance!=null and user.userPurse.petrolbalance ne ''}">
                        ${user.userPurse.petrolbalance}
                    </c:if>
                </div>
            </li>
        </ul>
    </div>
</c:if>
    <div class="shop_banner">
        <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_02.gif" alt="banner"/>
    </div>

    <div class="shop_introduce">
        <ul>

            <li class="clearfix">
                <div class="Buynow_left">
                    <a class="shop_a" href="${wx }/weixin/shop/toBuy?shotName=zd_coin" onclick="return check();">
                        <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_05.gif"/>
                    </a>
                </div>
                <div class="Buynow_right">

                    <div class="line clearfix">
                        <div>
                            <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_08.gif"/>
                            <span>安全保障</span>
                        </div>
                        <div>
                            <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_08.gif"/>
                            <span>永不过期</span>
                        </div>
                    </div>

                    <div class="line clearfix">
                        <div>
                            <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_08.gif"/>
                            <span>安全保障</span>
                        </div>
                        <div>
                            <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_08.gif"/>
                            <span>用不过期</span>
                        </div>
                    </div>
                </div>
            </li>

            <li class="clearfix">
                <div class="Buynow_left">
                    <a class="shop_a" href="${wx }/weixin/shop/toBuy?shotName=you_qi" onclick="return check();">
                        <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_19.gif"/>
                    </a>
                </div>
                <div class="Buynow_right">
                    <div class="line">
                        <p>任性加油，覆盖门店1299家，可跑800公里</p>
                    </div>
                </div>
            </li>

            <li class="clearfix">
                <div class="Buynow_left">
                    <a class="shop_a" href="${wx }/weixin/shop/insur_list" onclick="return check();">
                        <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_21.gif"/>
                    </a>
                </div>
                <div class="Buynow_right">
                    <div class="line">
                        <strong>
                            <i class="">"</i>e车有保
                            <i class="">"</i>
                        </strong>
                        <span>>驾驶员意外伤害险</span>
                    </div>
                    <div class="line">
                        <strong>
                            <i class="">"</i>e车有保
                            <i class="">"</i>
                        </strong>
                        <span>>驾驶员意外伤害险</span>
                    </div>
                </div>
            </li>

        </ul>
    </div>
</section>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        var usernameval = $.trim($("#usernameval").html());
        if (usernameval != null && usernameval != ''
                && usernameval.length > 8) {
            usernameval = usernameval.substring(0, 3) + "…";
            $("#usernameval").html(usernameval);
        }
    });
    function check() {
        var isShowAt = "${isShowAt}";
        if (isShowAt != 'true') {
        	$.MsgBox.Alert("温馨提示","该商品只有登录后才可购买，请先登录！");
            return false;
        }
        return true;
    }
</script>
</body>
</html>