<%@ page contentType="text/html;charset=UTF-8"%>
<%-- <%@ include file="/WEB-INF/views/modules/tms/include/taglib.jsp"%> --%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<meta http-equiv="Cache-Control" content="no-store">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<!-- <meta http-equiv="X-UA-Compatible" content="IE=7,IE=9,IE=10"> -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>物流金融展示页面</title>
	
	<!--分页插件样式-->
	<link href="${ctxStatic}/front/css/jquerypage.css" rel="stylesheet" type="text/css">
	<!--公共样式-->
	<link href="${ctxStatic}/front/css/global.css" rel="stylesheet" type="text/css">
	<!--一级页面样式-->
    <link href="${ctxStatic}/front/css/first_css.css" rel="stylesheet" type="text/css">
    <!--滚动样式-->
    <link href="${ctxStatic}/front/css/swiper.min.css" rel="stylesheet" type="text/css">
    
	<style>
	
	</style>
</head>
<div style="width: 100%;height: auto;text-align: center;">
    <a onclick="test()" target="_blank" style="color: #00a0e9">链接金融平台</a>
</div>
<div class="swiper-container swiper-container-horizontal" style="margin-top:10px;height:315px;">
    <div class="swiper-wrapper" style="transform: transition-duration: 0ms;">

        <div class="swiper-slide swiper-slide-prev" style="width: 100%; margin-right: 30px;"><img src="${ctxStatic }/front/img/financial/2.jpg" width="100%"> </div>
        <div class="swiper-slide swiper-slide-active" style="width: 100%; margin-right: 30px;"><img src="${ctxStatic }/front/img/financial/3.jpg" width="100%"> </div>
        <div class="swiper-slide swiper-slide-next" style="width: 100%; margin-right: 30px;"><img src="${ctxStatic }/front/img/financial/4.jpg" width="100%"> </div>
    </div>
    <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets">
    	<span class="swiper-pagination-bullet"></span>
    	<span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>
    	<span class="swiper-pagination-bullet"></span>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
</div>

<div class="content" style="margin-top: 55px;width: 100%;margin-bottom: 100px;">
    <div class="index_main_top">
        <h3 class="why_choose">为什么选择我们？</h3>

        <table cellspacing="0" cellpadding="0">
            <tbody><tr>
                <td>
                    <a class="clearfix">
                        <img src="${ctxStatic }/front/img/financial/icon1_03.png">
                        <h4>顶级物流专家</h4>
                    </a>
                </td>
                <td>
                    <a class="clearfix">
                        <img src="${ctxStatic }/front/img/financial/icon1_05.png">
                        <h4>专业金融方案定制</h4>
                    </a>

                </td>
                <td>
                    <a class="clearfix">
                        <img src="${ctxStatic }/front/img/financial/icon1_07.png">
                        <h4>大数据风控</h4>
                    </a>
                </td>
                <td>
                    <a class="clearfix">
                        <img src="${ctxStatic }/front/img/financial/icon1_09.png">
                        <h4>云信用</h4>
                    </a>
                </td>
            </tr>
        </tbody>
      </table>
    </div>
    <!--贷款产品精选推荐-->
    <table class="main_body_tab1" cellspacing="0" cellpadding="0">
        <tbody>
        <tr>
            <td rowspan="2" class="tab1_left_img" style="height: 400px;width: 285px;padding-left: 0px;">
                <a href="">
                    <img src="${ctxStatic }/front/img/financial/icon_02.png">
                </a>
            </td>

            <td>
                <a class="tab1_td tab1_line1" href="">
                    <h3>尊享贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon1_07.png">
                    <p class="simple_descrip">小金额审批快，还款灵活</p>
                    <p class="simple_descrip">大金额可定制，未来还可投贷联动</p>
                    <p class="bot_limit">50-1000万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line1" href="">
                    <h3>极速贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_09.png">
                    <p class="simple_descrip">凭营业执照+身份证即可授信</p>
                    <p class="simple_descrip">最高可增信至300W</p>
                    <p class="bot_limit">5-100万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line1" href="">
                    <h3>合同贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_09.png">
                    <p class="simple_descrip">小金额审批快，还款灵活</p>
                    <p class="simple_descrip">大金额可定制，未来还可投贷联动</p>
                    <p class="bot_limit">5-300万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line1" href="">
                    <h3>运营贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_11.png">
                    <p class="simple_descrip" style="line-height: 54px;height: 54px;">你发货，我垫资，回了款再还钱</p>
                    <p class="bot_limit">5-50万额度</p>
                </a>
            </td>
        </tr>

        <tr>
            <td>
                <a class="tab1_td tab1_line2" href="">
                    <h3>路费贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_24.png">
                    <p class="simple_descrip">高速路上先消费，再给钱</p>
                    <p class="simple_descrip">结运费给钱不如给高速通行卡</p>
                    <p class="bot_limit">5-100万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line2" href="">
                    <h3>免息加油贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_21.png">
                    <p class="simple_descrip">你加油，我付钱，不用利息还打折</p>
                    <p class="simple_descrip">还能开增值税专用发票哦</p>
                    <p class="bot_limit">10-100万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line2" href="">
                    <h3>购车首付贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_18.png">
                    <p class="simple_descrip">0首付免费提车</p>
                    <p class="simple_descrip">还款周期长，最长一年慢慢还</p>
                    <p class="bot_limit">10-100万额度</p>
                </a>
            </td>
            <td>
                <a class="tab1_td tab1_line2" href="">
                    <h3>物配贷</h3>
                    <img src="${ctxStatic }/front/img/financial/icon_26.png">
                    <p class="simple_descrip">购买万力轮胎、升力尿素</p>
                    <p class="simple_descrip">这些统统算我的</p>
                    <p class="bot_limit">5-50万额度</p>
                </a>
            </td>
        </tr>
        </tbody>
    </table>
    <div style="margin:0px auto;text-align: center;">
	    <!-- <img style="width: 100%" src="http://www.money56.com/img/page_fisrt/icon3_18.png"> -->
	    <img style="width: 84%" src="${ctxStatic }/front/img/financial/icon3_18.png">
    </div>
</div>
<script type="text/javascript" src="${ctxStatic}/front/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/front/js/swiper.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/front/js/jquery.flexisel.js"></script>
<script type="text/javascript" src="${ctxStatic}/front/js/main.js"></script>
<script type="text/javascript">
$(function() {
	//轮播
	var swiper = new Swiper('.swiper-container', {
	    pagination: '.swiper-pagination',
	    nextButton: '.swiper-button-next',
	    prevButton: '.swiper-button-prev',
	    paginationClickable: true,
	    spaceBetween: 30,
	    centeredSlides: true,
	    autoplay: 2500,
	    autoplayDisableOnInteraction: false
	});
});

var apppId = "";
var appMemberId = "";
getappMemberId();
function getappMemberId() {
    $.ajax({
        url: "${wlpt}/wlpt/financial/getappMemberId",
        data:{loginName:'${fns:getUser().loginName}'},
        type:"POST",
        dataType: 'json',
        cache: false,
        async:false,
        crossDomain: true,
        xhrFields: {
            withCredentials: true
        },
        success: function (data) {
            apppId = data.appId;
            appMemberId = data.appMemberId;
        }
    });
}

function test() {
    var newTab=window.open('about:blank');
    $.ajax({
        type: "POST",
        url: 'http://120.24.87.99:8080/saas/f/index/checkLogin',
        data:{appId:apppId,appMemberId:appMemberId},
        dataType: 'json',
        cache: false,
        async: false,
        xhrFields: {
            withCredentials: true
        },
        success: function (data) {
            if (data.isLogin) {
                newTab.location.href = "http://120.24.87.99:8080/saas/f/";
            }else{
                $.ajax({
                    url: "${wlpt}/wlpt/financial/acctclient",
                    data:{loginName:'${fns:getUser().loginName}'},
                    type:"POST",
                    dataType: 'json',
                    cache: false,
                    async:false,
                    crossDomain: true,
                    xhrFields: {
                        withCredentials: true
                    },
                    success: function (data) {
                        if(data.isCheck){
                            alert(apppId + "-" + appMemberId);
                            $.ajax({
                                type: "POST",
                                url: 'http://120.24.87.99:8080/saas/f/index/setCookie',
                                data:{appId:apppId,appMemberId:appMemberId},
                                dataType: 'json',
                                cache: false,
                                async: false,
                                xhrFields: {
                                    withCredentials: true
                                },
                                success: function () {
//                                    window.location.href="http://project.haitun56.com.cn:2017/f/";
                                    newTab.location.href = "http://120.24.87.99:8080/saas/f/";
                                },error:function (e) {
                                    newTab.close();
                                    alert("系统出错，请稍候重试");
                                }
                            });
                        }else {
                            newTab.close();
                            alert(data.message);
                        }
                    },error:function (e) {
                        newTab.close();
                        alert("系统出错，请稍候重试")
                    }
                });
            }
        },error:function (e) {
            newTab.close();
            alert("系统出错,请稍候重试");
        }
    });

}

function getCookie() {
    var aCookie = document.cookie.split(";");
    var re = '';
    for (var i = 0; i < aCookie.length; i++) {
        var aCrumb = aCookie[i].split("=");
        if(aCrumb[0].toString().Trim()=='order_list'){
            continue;
        }
        re += (aCrumb[0] + " = " + aCrumb[1] + '\n\n');
    }
    console.log(re);
    alert('cookie info:\n'+re);
//    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
//    if(arr=document.cookie.match(reg)){
//        console.log(unescape(arr[2]));
//        return unescape(arr[2]);
//    } else{
//        return null;
//    }
}


</script>