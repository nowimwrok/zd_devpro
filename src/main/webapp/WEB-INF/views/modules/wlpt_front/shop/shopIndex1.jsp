<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>商城首页</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<style>

/*商城首页---注释*/
.per_shop_info_wrap{
    width: 100%;
    background: #ebeef0;
    height: 120px;
}
.per_shop_info{
    margin: 0 auto;
    overflow: hidden;
}
.per_head img{
    width: 80px;
    height: 80px;
    box-shadow: -7px 7px 5px #ccc;
    margin-left: 7px;
    border-radius: 50%;
}
.per_head span{
    font-size: 18px;
    padding-left: 5px;
}
.per_head{
    float: left;
    line-height: 120px;
    width:35%;
}
li .accoumt{
    font-size: 22px;
    color: #fad14b;
}
.shop_info ul li span{
    display: block;
}
.shop_info ul li{
    display: inline-block;
    *display:inline;
    *zoom:1;
    display: inline-block;
    padding: 0 10px;
    text-align: center;
    width: 31%;
}
.shop_info ul{
    float: right;
    line-height: 60px;
    width: 66%;
}
.shop_info{
    overflow: hidden;
    width: 65%;
    height: 100%;
    float: right;
}
.purchase_list{
    margin-bottom: 40px;
    display: none;
}
.bg_blue a{
    display: block;
    color: #fff;
    line-height: 48px;
    height: 100%;
}
.bg_blue a:focus,.bg_blue a:hover,.bg_blue a:visited,.bg_blue a:active{
    color: #fff;
}
.ImView_details .zhuobi{
    position: absolute;
    top:61%;
    font-size: 28px;
    font-family: "微软雅黑";
    font-weight: bold;
}
.ImView_details{
    background-image: url("/static/images/wlptfront/shop_img/IM_bg.png");
    background-repeat: no-repeat;
    background-size: 99%;
    height: 264px;
    position: relative;
}
.ImView_list button{
    width: 100%;
    height: 68px;
    background-image: url("/static/images/wlptfront/shop_img/IM_bg_btn.png");
    background-repeat: no-repeat;
    background-size: 100%;
    border: none;
}
.ImView_details p{
    width: 100%;
    text-align: center;
}
.ImView_details img{
    width: 51%;
    position: absolute;
    left: 26%;
    top: 16%;
}
.detail_p{
    position: absolute;
    top: 86%;
}
.immediately_view .ImView_list{
    width: 33%;
    float: left;
}
.immediately_view{
    width: 76%;
    margin: 20px auto;
    overflow: hidden;
}
.discount_wrap{
    position: absolute;
    top: 22%;
    left: 52%;
    text-align: right;
    line-height: 50px;
}
.purchase_detail{
    position: relative;
    margin-bottom: 10px;
}
.purchase_detail h4{
    font-weight: bold;
}
.discount_wrap .btn-warning{
    background: #fcd23a;
    border:#fcd23a;
    width: 60%;
}
.discount_wrap .btn-warning a{
    color: #fff;
}
.discount_wrap .btn-warning:hover,.discount_wrap .btn-warning:focus,.discount_wrap .btn-warning:visited{
    background: #fcd23a;
    border:#fcd23a;
    width: 40%;
}
.discount_wrap .btn-warning a:hover,.discount_wrap .btn-warning a:focus,.discount_wrap .btn-warning a:visited,.discount_wrap .btn-warning a:active{
    color: #fff;
}
.purchase_detail{
    width: 100%;
    margin-bottom: 10px;
}
</style>
</head>
<body>
 
<!--个人头像  我的卓币 我的订单  卓币余额-->
    <div class="per_shop_info_wrap" <c:if test="${flag=='flag'}">hidden='hidden'</c:if>>
        <div class="per_shop_info clearfix">
            <div class="per_head" style="padding-left: 100px;">
            <img width="120px" height="120px;" onerror="this.onerror=null;this.src='/static/images/weixin/icon_personal.png'" src="${fns:getUser().photo}" />
                
                <span>${not empty user.name?user.name:user.loginName}</span>
            </div>
            <div class="shop_info" style="padding-right: 85px;padding-top: 30px;">
                <ul>
                    <li>
                        <span class="accoumt" style="line-height: 20px;">${not empty user.userPurse.availablecoin?user.userPurse.availablecoin:'0.00'}</span>
                        <span class="acc_type">我的卓币</span>
                    </li>
                    <li>
                        <span class="accoumt" style="line-height: 20px;">￥${not empty user.userPurse.availablebalance?user.userPurse.availablebalance:'0.00'}</span>
                        <span class="acc_type">账户余额</span>
                    </li>
                    <li>
                        <span class="accoumt" style="line-height: 20px;">￥${not empty user.userPurse.petrolbalance?user.userPurse.petrolbalance:'0.00'}</span>
                        <span class="acc_type">油汽余额</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
<!--End--个人头像  我的卓币 我的订单  卓币余额-->

<!--立即查看  保险  卓币   油汽-->
    <div class="immediately_view">
        <div class="ImView_list">
            <div class="ImView_one ImView_details">
                <p class="ImView_details"><img src="/static/images/wlptfront/shop_img/Logo-one.png"></p>
                <p class="detail_p">要投就投，中国人寿</p>
            </div>
            <button class="bg_blue"><a href="${wlpt}/wlpt/toshop" style="color: #fff;line-height: 50px;">立即查看</a></button>
        </div>
        <div class="ImView_list">
            <div class="ImView_one ImView_details">
                <p class="ImView_details"><img src="/static/images/wlptfront/shop_img/Logo-two.png" style="width: 36%;left: 30%;"></p>
                <p class="zhuobi">油汽</p>
                <p class="detail_p">天天优惠，全国通用</p>
            </div>
            <button class="bg_blue"><a href="${wlpt}/wlpt/toshop" style="color: #fff;line-height: 50px;">立即查看</a></button>
        </div>
        <div class="ImView_list">
            <div class="ImView_one ImView_details">
                <p class="ImView_details"><img src="/static/images/wlptfront/shop_img/Logo-three.png" style="top:30%;"></p>
                <p class="zhuobi">卓币</p>
                <p class="detail_p">卓币在手，货运畅通</p>
            </div>
            <button class="bg_blue"><a href="${wlpt}/wlpt/toshop" style="color: #fff;line-height: 50px;">立即查看</a></button>
        </div>

    </div>
<!--End--立即查看  保险  卓币   油汽-->
<iframe  width="100%" height="730px" src="${wlpt}/wlpt/shop/detail" suzcrolling="no" scrolling="no"  frameborder="0" name="content"></iframe>
    <!--End--立即购买  保险  卓币   油汽-->
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script>
    $(".purchase_list").eq(0).css("display", "block");
</script>
</body>
</html>