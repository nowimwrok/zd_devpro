 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <style type="text/css">
        body, input {
            font-family: "微软雅黑";
        }
        ul,ul li{
            list-style: none;
        }
        .zhuobi_introduce{
            display: block;
        }
        .shop_introduce{
            width: 58%;
            margin: 15px auto;
        }
        .Buynow_left img{
            width: 100%;
        }
        .Buynow_left{
            float: left;
            width: 33%;
            position: relative;
        }
        /* .Buynow_left a{
            position: absolute;
            left: 30.5%;
            top: 59%;
            width: 39%;
            height: 35px;
            line-height: 35px;
            color: #00a2ee;
            background: #fff;
            text-align: center;
            font-weight: bold;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            -o-border-radius: 3px;
            border-radius: 3px;
        } */

        .Buynow_right{
            width: 67%;
            float: left;
            /*width: 64%;*/
            font-size: 1rem;
            font-weight: bold;
            margin-top: 10px;
        }
        .Buynow_right .line{
            height: 100px;
            line-height: 100px;
            /*font-size: 0.8rem;*/
        }
        .Buynow_right .line>div.div_right{
            margin-left: 20%;
        }
        .Buynow_right .line>div{
            float: left;
            height: 100px;
            line-height: 100px;
            margin-left: 40px;
        }
        .Buynow_right .line strong{
            padding-right: 8px;
        }
        .Buynow_right .line strong i{
            color: #48bbef;
        }
        .Buynow_right .line>div img{
            float: left;
            padding-right: 10px;
            width: 35%;
            margin-top: 25px;
        }




        .section>.zhuobiIs{
            text-indent: 1.5rem;
            margin:55px auto;
        }
        .equal_money{
            width: 100%;
            background:#dae8fd;
        }
        .equal_money>h2{
            font-size: 28px;
            font-weight: bold;
            height: 55px;
            line-height: 55px;
            text-align: center;
        }
        .equal_money>ul{
            width: 98%;
            margin: 0 auto;
            padding:20px 0;
        }
        .equal_money>ul>li{
            width: 27%;
            height: 275px;
            background: #fff;
            padding: 0 10px;
        }
        .equal_money>ul>li h4{
            text-align: center;
            height: 50px;
            line-height: 50px;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .equal_money>ul>li p{
            text-indent: 2em;
        }
        .equal_money>ul>.zhifu{
            float: left;
        }
        .equal_money>ul>.xiaofei{
            float: right;
        }
        .equal_money>ul>.zhuan{
            margin-left: 36.5%;
            margin-right: 36.5%;
        }


        .howget{
            width:82%;
            margin: 55px auto;
        }
        .howget .howget_zhuobi,.howget .effct_date{
            width: 52%;
            position: relative;
        }
        .howget .howget_zhuobi{
            float: left;
        }
        .howget .effct_date{
            width: 30%;
            float: right;
        }
        .howget .howget_zhuobi h4,.howget .effct_date h4{
            font-weight: bold;
            height: 50px;
            line-height: 26px;
        }
        .howget .howget_zhuobi span,.howget .effct_date span{
            display: block;
            color: #fff;
            position: absolute;
            background: #60b0fe;
            padding: 3px 8px;
            border-radius: 50%;
            -moz-border-radius:50%;
            -webkit-border-radius:50%;
            font-size: 10px;
            left: -4em;
        }
        h4{
            margin-top: 0px;
        }
    </style>
</head>
<body>
<!--商品介绍--卓币介绍-->
<div class="shop_introduce">
    <div class="zhuobi_introduce">
        <ul>
            <li class="clearfix">
                <div class="Buynow_left">
                    <a href="${wlpt }/wlpt/shop/toBuy?shotName=zd_coin"><img src="${ctxStatic}/images/wlptfront/shop_img/bot_left_16.png" alt="卓币"/>
                   </a>
                </div>
                <div class="Buynow_right">
                    <div class="line clearfix" style="margin-top:25px;">
                        <div>
                            <img src="${ctxStatic}/images/wlptfront/shop_img/icon_18.png"/>
                            <span>安全保障</span>
                        </div>
                        <div class="div_right">
                            <img src="${ctxStatic}/images/wlptfront/shop_img/icon_21.png"/>
                            <span>永不过期</span>
                        </div>
                    </div>

                    <div class="line clearfix">
                        <div>
                            <img src="${ctxStatic}/images/wlptfront/shop_img/icon_25.png"/>
                            <span>抵现使用</span>
                        </div>
                        <div class="div_right">
                            <img src="${ctxStatic}/images/wlptfront/shop_img/icon_26.png"/>
                            <span>支付无忧</span>
                        </div>
                    </div>
                </div>
            </li>
        </ul>


        <div class="section">
            <p class="zhuobiIs">
                “卓币”是卓大物流平台推出的一款在平台上使用的虚拟货币，用户可以通过“卓币”在平台上进行支付、转账、
                消费等操作。“卓币”可以在平台的商城通过账户余额进行购买，通常它的兑价是1卓币=1人民币。
            </p>
        </div>

        <div class="section equal_money">
            <h2>卓币当钱花</h2>
            <ul class="clearfix">
                <li class="zhifu">
                    <h4>支付</h4>

                    <p>用户在平台支付运费往常都是使用余额支付，当推出卓币后，在支付运费这里，我们还可以选择使用卓币进行支付，
                        卓币支付运费同样可以选择是否预付和设置预付的比例，使得用户的选择性更多，支付的方式更加的多样性</p>
                </li>
                <li class="xiaofei">
                    <h4>消费</h4>

                    <p>平台上的用户可以在卓大商城购买自己需要的商品，在商城上购买商品是使用卓币进行消费的，当选好需要的商品和相应的数量后
                        点击支付即可使用卓币进行消费。</p>
                </li>
                <li class="zhuan">
                    <h4>转账</h4>

                    <p>卓币作为卓大物流平台的虚拟货币，除了可以进行支付运费外，还可以进行转账的操作，平台上的用户可以在账户中心输入转账账号进行用户
                        与用户之间的卓币转账，使我们的转账方式更加的灵活。</p>
                </li>
            </ul>
        </div>

        <div class="howget clearfix">
            <div class="howget_zhuobi">
                <span>1</span>
                <h4>
                    如果获得卓币？
                </h4>
                <p>用户可以在卓大物流商城使用余额购买卓币，一元可以购买一卓币，以此类推，用户可以根据不同需求购买不同数量的卓币，
                    当购买成功后可以在平台的个人中心看到购买后的卓币余额。同时，用户还可以通过积分进行兑换卓币。在日后，卓币将会有更多优惠，
                    请敬请关注平台的动态！</p>
            </div>
            <div class="effct_date">
                <span>2</span>
                <h4>
                    卓币的有效期？
                </h4>
                <p>卓币不限有效期。</p>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script>
    /* top.$("#shopFrame").height(1170);
    $(".shop_a").click(function () {
        top.$("#shopFrame").height(630);
    }) */
    $(".purchase_list").eq(0).css("display", "block");
</script>
</body>
</html>