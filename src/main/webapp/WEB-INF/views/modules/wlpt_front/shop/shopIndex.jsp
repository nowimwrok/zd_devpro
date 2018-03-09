<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
<title>商城首页</title>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/banner.css">
<style type="text/css">
.container {
    width: 100%;
    padding-right: 0px;
    padding-left: 0px;
}
.wrap {
    width: 80%;
}
footer {
		    width: 100%;
		    /* margin-top: 80px; */
		    clear: both;
		    background-color: #363E41;
		    padding-bottom: 2%;
		}

/*商城首页*/
.shop_banner{
    background: url("${ctxStatic}/images/wlptfront/shop_img/shop_banner_bg.png") no-repeat;
    background-size: 100% auto;
}
.shop_banner .banner-con{
    width: 58%;
    margin: 0 auto;
    padding-top: 50px;
}
.banner-con .banner_excellent img{
    width: 100%;
}
.shop_list ul li a img{
    width: 95%;
    padding-bottom: 20px;
}
.shop_list ul li{
    width: 33.3333333333%;
    display: inline-block;
    cursor: pointer;
}
.shop_list ul{
    width: 100%;

}
    #shop_a{
        cursor: pointer;
    }
</style>
</head>
<body>

<!--商城banner-->
<div class="shop_banner">
    <div class="banner-con">
        <div id="shop_a" class="banner_excellent">
            <img src="${ctxStatic}/images/wlptfront/shop_img/shop_01.png" alt="banner">
        </div>
        <div class="shop_list">
            <ul>
                <li class="zhuobi" style="float: left;">
                    <a>
                        <img src="${ctxStatic}/images/wlptfront/shop_img/shop_03.png" alt="卓币">
                    </a>
                </li>
                <li class="baoxian" style="float: right;">
                    <a>
                        <img src="${ctxStatic}/images/wlptfront/shop_img/shop_02.png" alt="保险" style="float: right;">
                    </a>
                </li>
                <li class="youqi" style="text-align: center;">
                    <a>
                        <img src="${ctxStatic}/images/wlptfront/shop_img/shop_04.png" alt="油汽">
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<!--End--立即查看  保险  卓币   油汽-->
<iframe id="shopFrame" width="100%" src="${wlpt}/wlpt/shop/detail" suzcrolling="no" scrolling="no"  frameborder="0" name="content"></iframe>
    <!--End--立即购买  保险  卓币   油汽-->
<%-- <div class="buy_list">
    <img src="${ctxStatic }/images/wlptfront/shop_img/shopct.png" width="100%;">
    <button class="btn_one"><a href="${wlpt}/wlpt/showdetail" target="_blank">立即购买</a></button>
    <button class="btn_two"><a href="${wlpt }/wlpt/shop/toBuy?shotName=you_qi"  target="content">立即购买</a></button>
    <button class="btn_three"><a href="${wlpt }/wlpt/shop/toBuy?shotName=zd_coin" target="content">立即购买</a></button>
    
</div> --%>
<div class="main">
  <div class="clients">
        <div class="wrap">
            <h2 class="head">合作伙伴</h2>
            <ul id="flexiselDemo4">
                <li><a href="http://www.zhaogang.com" target="_blank"><img src="${ctxStatic }/images/wlptfront/c1.png"/></a>
                </li>
                <li><a href="http://www.hbistc.com" target="_blank"><img
                        src="${ctxStatic }/images/wlptfront/c2.png"/></a></li>
                <li><a href="http://www.ouyeel.cn" target="_blank"><img
                        src="${ctxStatic }/images/wlptfront/c3.png"/></a></li>
                <li><a href="http://www.money56.com" target="_blank"><img src="${ctxStatic }/images/wlptfront/c4.png"/></a>
                </li>
            </ul>

        </div>
    </div>
</div>
<!-- jQuery -->
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.hoverdir.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.flexisel.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.wmuSlider.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
 <script type="text/javascript">
$(function () {
    $("#shop_a").click(function () {
        $("#shopFrame").attr("src","${wlpt}/wlpt/shop/detail");

    });
    $(".zhuobi").click(function () {
        $("#shopFrame").attr("src","${wlpt}/wlpt/shop/coin_detail");

    });
    $(".youqi").click(function () {
        $("#shopFrame").attr("src","${wlpt}/wlpt/shop/petrol_detail");

    });
    $(".baoxian").click(function () {
        window.location.href="${wlpt}/wlpt/shop/insur_list?index=4";

    });

});

//     我的账户悬停出现详细内容
$(".my_account").bind("mouseover",function(){
    $(".account_con_wrap").show();
    $(this).addClass("my_account_over")
})
$(".my_account_wrap").bind("mouseout",function(){
    $(".account_con_wrap").hide();
    $(".my_account").removeClass("my_account_over")
})

$("#shopFrame").load(function () {
    var mainheight = $(this).contents().find("body").height();
    $(this).height(mainheight);
});

  </script>
</body>
</html>