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
    <div class="about_banner" id="about_banner">
        <img src="${ctxStatic }/images/wlptfront/index/about_banner.jpg"/>
    </div>
    <!--内容-->
    <!--1-->
    <div class="about_box service">
        <div class="container">
            <div class="row">
                <div class="pull-left about_img wow slideInLeft">
                    <img src="${ctxStatic }/images/wlptfront/index/about_title.jpg" alt="" />
                </div>
                <div class="pull-left about_text wow slideInRight">
                    <h4>众翔科技有限公司</h4>
                    <p>卓大物流平台于2012年完成研发测试并上线运行，定位为以货带车，实现资源共享的综合物流服务平台。以钢材大宗货物为主，零担物流为辅。</p>
                    <p>平台主要业务功能包括：招标大厅、货源、车源、用户认证、运输路覆盖图、物流节点可视化操作、业务后台管理等。</p>
                    <p>卓大商城为用户提供增值服务，主要包括：卓币、油气、保险、维修、住宿、金融、真正实现全方位一站服务。</p>
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
