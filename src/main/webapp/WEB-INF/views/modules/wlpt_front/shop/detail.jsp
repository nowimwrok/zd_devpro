<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<!-- 
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
    height: 279px;
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
    top: 33%;
    left: 70%;
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
</style> -->
<style type="text/css">
body,input{
  font-family: "微软雅黑";
}
.container {
    width: 100%;
    padding-right: 0px;
    padding-left: 0px;
}
.shop_banner{
	width: 60%;
	margin: 0 auto;
	height: 66%;
	position: relative;
	border: 0px;
}
.buy_list{
    width: 100%;
    margin: 0 auto;
    position: relative;
}
.buy_list button a{
    color: #0e76d9;
    font-weight: bold;
    font-size: 16px;
}

.buy_list button{
    position: absolute;
    left: 24.3%;
    background: #fff;
    width: 8.4%;
    height: 40px;
    line-height: 40px;
    -moz-border-radius: 5px; /* Firefox */
    -webkit-border-radius: 5px; /* Safari 和 Chrome */
    border-radius: 5px; /* Opera 10.5+, 以及使用了IE-CSS3的IE浏览器 */
    border: 1px solid #fff;
}
.buy_list .btn_one{
    top: 21%;
}
.buy_list .btn_two{
    top: 53.75%;
}
.buy_list .btn_three{
    top: 86.22%;
}

</style>
</head>
<body>
<div class="buy_list">
    <img src="${ctxStatic }/images/wlptfront/shop_img/shopct.png" width="100%;">
	<button class="btn_one"><a  href="${wlpt}/wlpt/shop/insur_list?index=4" target="_blank">立即购买</a></button>
    <button class="btn_two"><a class="shop_a" href="${wlpt }/wlpt/shop/toBuy?shotName=zd_coin"  target="content">立即购买</a></button>
    <button class="btn_three"><a class="shop_a" href="${wlpt }/wlpt/shop/toBuy?shotName=you_qi" target="content">立即购买</a></button>
    
</div>
<%-- <div class="purchase_list" data-target="one">
        <div class="purchase_insurance purchase_detail">
              <img src="/static/images/wlptfront/shop_img/bot_one.png" width="100%;" height="auto;">
              <div class="discount_wrap">
                  <h4>保险优惠，天天有</h4>
       
                  <a class="btn btn-warning" style="width:60%" href="${wlpt}/wlpt/showdetail" target="_blank">立即购买</a>
              </div>
        </div>
        <div class="purchase_ZhuoCoin purchase_detail">
             <img src="/static/images/wlptfront/shop_img/bot_two.png" width="100%;" height="auto;">
             <div class="discount_wrap">
                 <h4>油汽优惠，天天有</h4>
   
                 <a class="btn btn-warning" style="width:60%" href="${wlpt }/wlpt/shop/toBuy?shotName=you_qi"  target="content">立即购买</a>
             </div>
        </div>

        <div class="purchase_Oil purchase_detail">
             <img src="/static/images/wlptfront/shop_img/bot_three.png" width="100%;" height="auto;">
             <div class="discount_wrap">
                 <h4>卓币优惠，天天有</h4>
 
                 <a class="btn btn-warning" style="width:60%" href="${wlpt }/wlpt/shop/toBuy?shotName=zd_coin" target="content">立即购买</a>
             </div>
        </div>

    </div>
    </div> --%>
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script>
/* top.$("#shopFrame").height(1170);
$(".shop_a").click(function () {
	top.$("#shopFrame").height(700);
}) */
    $(".purchase_list").eq(0).css("display", "block");
</script>
</body>
</html>