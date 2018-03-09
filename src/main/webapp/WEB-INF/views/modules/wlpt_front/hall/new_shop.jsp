<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <meta name="decorator" content="site_web_basic"/>
    <style type="text/css">

    </style>
</head>
<body>
<div style="width: 100%;">
    <!--banner-->
    <div class="er_banner carousel slide" id="about_banner"  data-ride="carousel" data-interval="3000">
        <div class="carousel-inner">
            <div class="item active text-center"><img src="${ctxStatic }/images/wlptfront/market/market_banner.jpg"/></div>
            <div class="item text-center"><img src="${ctxStatic }/images/wlptfront/solution/solve_banner.jpg"/></div>
        </div>
    </div>
    <!--3个导航-->
    <div class="main_guide">
        <div class="container">
            <div class="row">
                <div class="col-sm-4 col-xs-4 clearfix wow slideInRight">
                    <a href="#money">
                        <div class="pull-left main_img">
                            <img src="${ctxStatic }/images/wlptfront/market/title_one.png" alt="" />
                        </div>
                        <div class="pull-left main_text">
                            <h3>卓币</h3>
                            <div class="main_line"></div>
                            <p>卓币在手、天下我有</p>
                            <p>卓币当钱花</p>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4 col-xs-4 clearfix wow slideInRight" data-wow-delay=".2s">
                    <a href="#oil">
                        <div class="pull-left main_img">
                            <img src="${ctxStatic }/images/wlptfront/market/title_two.png" alt="" />
                        </div>
                        <div class="pull-left main_text">
                            <h3>油气</h3>
                            <div class="main_line"></div>
                            <p>天天优惠、全国通用</p>
                            <p>“e车有保，乐驾人生”</p>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4 col-xs-4 clearfix wow slideInRight" data-wow-delay=".4s">
                    <a href="#insure">
                        <div class="pull-left main_img">
                            <img src="${ctxStatic }/images/wlptfront/market/title_three.png" alt="" />
                        </div>
                        <div class="pull-left main_text">
                            <h3>保险</h3>
                            <div class="main_line"></div>
                            <p>会省钱的保险，全国通赔</p>
                            <p>任性加油、覆盖门店1299家</p>
                            <p>可跑800公里</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <!--content-->
    <div class="market_c">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-xs-12 wow fadeInUp" id="money" data-wow-duration="1.2s">
                    <div class="col-sm-12 market_col">
                        <div class="col_title clearfix">
                            <h4 class="pull-left">什么是卓币</h4>
                            <p class="pull-right">
                                <a href="${wlpt }/wlpt/shop/toBuy?shotName=zd_coin">立即购买&gt;&gt;</a>
                            </p>
                        </div>
                        <div class="col-sm-12 col_text">
                            <div class="text-center">
                                <img src="${ctxStatic }/images/wlptfront/market/insure.jpg" alt="" />
                            </div>
                            <p>“卓币”是卓大物流平台推出的一款在平台上使用的虚拟货币，用户可以通过“卓币”在平台上进行支付、转账、消费等操作。</p>
                            <p>“卓币”可以在平台的商城通过账户余额进行购买，通常它的兑价是1卓价=1人民币。</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12 wow fadeInUp" id="oil" data-wow-duration="1.2s">
                    <div class="col-sm-12 market_col">
                        <div class="col_title clearfix">
                            <h4 class="pull-left">什么是油气</h4>
                            <p class="pull-right">
                                <a href="${wlpt }/wlpt/shop/toBuy?shotName=you_qi">立即购买&gt;&gt;</a>
                            </p>
                        </div>
                        <div class="col-sm-12 col_text">
                            <div class="text-center">
                                <img src="${ctxStatic }/images/wlptfront/market/oil.jpg" alt="" />
                            </div>
                            <p>卓大油气是卓大物流平台与线下油气站合作方联合推出的加油加气商品。</p>
                            <p>卓大油气可以在卓大商城进行购买，当购买成功后可以在个人中心的油气账户看到购买后的油气余额。</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-xs-12 wow fadeInUp" id="insure" data-wow-delay=".2s" data-wow-duration="1.2s">
                    <div class="col-sm-12 market_col">
                        <div class="col_title clearfix">
                            <h4 class="pull-left">什么是保险</h4>
                            <p class="pull-right">
                                <a href="${wlpt}/wlpt/shop/insur_list?index=2">立即购买&gt;&gt;</a>
                            </p>
                        </div>
                        <div class="col-sm-12 col_text">
                            <div class="text-center">
                                <img src="${ctxStatic }/images/wlptfront/market/money.jpg" alt="" />
                            </div>
                            <p>承保由于火灾、台风、暴雨、泥石流等原因造成的货物损失；网上投保方便报捷，只需三步走帮你买到想要的保险。</p>
                            <p>提供7x24小时报案理赔电话，更可全国通赔。</p>
                        </div>
                    </div>
                </div>
                <div class="market_bg">
                    <img src="${ctxStatic }/images/wlptfront/market/bg.jpg" alt="" />
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //wow 动画
    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
        new WOW().init();
    };
    //
    $('.main_guide a').smoothScroll({
        offset:0,
        speed:1000,
        easing:'swing',
    });

    var brower_w=$(window).width();
    $('.navbar-toggle').click(function(){
        if(brower_w<768){
            $('.mask').toggle();
            $('.navbar-collapse').toggle();
        }
    });
</script>
</body>
</html>
