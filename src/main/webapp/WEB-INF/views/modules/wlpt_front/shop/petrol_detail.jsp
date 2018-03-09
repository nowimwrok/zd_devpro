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
        }
 */
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
            list-style: none;

        }
        .equal_money>ul>li{
            width: 27%;
            height: 275px;
            background: #fff;
            padding: 0 10px;
            list-style: none;
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

        ul,ul li{
            list-style: none;
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
    </style>
</head>
<body>
<!--商品介绍--卓币介绍-->
<div class="shop_introduce">
    <!--商品介绍--油汽介绍-->
    <div class="zhuobi_introduce youqi_introduce">
        <ul>
            <li class="clearfix">
                <div class="Buynow_left">
                    <a href="${wlpt }/wlpt/shop/toBuy?shotName=you_qi"><img src="${ctxStatic}/images/wlptfront/shop_img/bot_left_17.png" alt="卓币"/>
                    </a>
                </div>
                <div class="Buynow_right">
                    <div class="line clearfix" style="margin-top:25px;">
                        <div>
                            任性加油、覆盖门店1299家、可跑800公里
                        </div>
                    </div>
                </div>
            </li>
        </ul>


        <div class="section">
            <p class="zhuobiIs">
                卓大油气是卓大物流平台与线下油气站合作方联合推出的加油加气商品。卓大油气可以在卓大商城进行购买，
                当购买成功后可以在个人中心的油气账户看到购买后的油气余额。
                同时，卓大油气通过一卡通○1在线下的油气站合作方进行加油加气消费。
            </p>
        </div>

        <div class="section equal_money">
            <h2>卓大油气包</h2>
            <ul class="clearfix">
                <li class="zhifu" style="width:46%;">
                    <h4>油气</h4>

                    <p>卓大油气在卓大商城进行购买，当进入卓大商城点击油气输入需要购买的数量后支付即可。当购买成功后，可以在个人中心的油气账户中查看购买后的油气余额。当用户需要消费油气的时候，
                        只需要带着一卡通在线下的油气站合作方刷卡消费。
                    </p>
                </li>
                <li class="xiaofei" style="width:46%;">
                    <h4>一卡通</h4>
                    <p>用户需要通过平台的个人中心进行一卡通的申请，每个一卡通绑定一个用户账号，一卡通的余额目前与个人中心的油气账户同步，
                        线下刷卡消费多少油气将会扣除相对的油气金额。同时，用户需要输入一卡通消费密码才能进行消费。</p>
                </li>
            </ul>
        </div>
    </div><!--End--商品介绍--油汽介绍-->
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