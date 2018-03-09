<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>列表</title>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>

</head>

<body>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/shop_list.css">
<style>
    * {
        margin: 0px;
        padding: 0px;
        font-family: "微软雅黑";
        font-size: 1.5rem;
    }

</style>
<div class="search-bg">
    <form action="" method="get" class="search-bar" style="width: 86%;margin: 0px auto;">
        <input type="text" value="" name="search-in" id="search-in" placeholder="太平洋保险">
        <button type="button" name="search-btn" id="search-btn"><a>搜索</a></button>
    </form>
</div>


<div class="se-wr">
    <div class="list-l">
        <div class="genre all-css left-css">
            <div class="line-wrap">
                <span class="genre-title">品牌：</span>
                <ul class="brand">
                    <li class="active">不限</li>
                    <li>太平洋</li>
                    <li>平安</li>
                    <li>中国人寿</li>
                    <li>其它</li>
                </ul>
            </div>
            <br>
            <div>
                <span class="genre-title">产品：</span>
                <ul class="goods">
                    <li class="active">不限</li>
                    <li>汽车保险</li>
                    <li>人身保险</li>
                    <li>其它</li>
                </ul>
            </div>
        </div>

        <div class="all-css left-css sort">
            <span class="genre-title">排序方式：</span>
            <ul class="sort-style">
                <li class="active">默认</li>
                <li>人气</li>
                <li>销量</li>
            </ul>
        </div>

        <div class="all-css left-css left-img">
            <img src="${ctxStatic }/images/wlptfront/shop_img/1.jpg" class="cpic">
            <div class="safe-req">
                <h4 style="margin-bottom:5px;">商业险多省15%</h4>
                <p class="safe-age">投保年龄：<span class="age-term">1-70岁</span></p>
                <p class="safe-term">保险期限：<span class="age-term">1年</span></p>
            </div>
            <div class="insurance">
                <p>现场视频查勘，迅速定损</p>
                <p>全国通赔，当地理赔</p>
                <p>网上支付快捷方便</p>
            </div>
            <a href="${wlpt}/wlpt/showdetail" target="_black" class="see">查看</a>
        </div>


    </div>

    <!--right-->
    <div class="list-r">
        <div class="order">
            <span class="proces-ord ord active">已处理订单</span>
            <span class="unp-ord ord">未处理订单</span>
        </div>
        <!-- 下方注释内容为  id="insurance-list" 不为空时的显示内容 -->
        <!-- <div class="all-css right-css left-img">
                <img src="images/1.jpg" class="cpic-r">
                <div class="safe-req">
                    <h4 style="margin-bottom:5px;">机动车商业险</h4>
                    <p class="safe-age">投保状态：<span class="age-term">生效中</span></p>
                    <p class="safe-term">保险期限：<span class="term-tim">1年</span><a>（355天后到期）</a></p>
                    <p class="safe-term">服务专线：<span class="term-tim term-tim-co">020-8115456</span></p>
                </div>
            </div>

            <div class="all-css right-css left-img">
                <img src="images/1.jpg" class="cpic-r">
                <div class="safe-req">
                    <h4 style="margin-bottom:5px;">机动车商业险</h4>
                    <p class="safe-age">投保状态：<span class="age-term">生效中</span></p>
                    <p class="safe-term">保险期限：<span class="term-tim">1年</span><a>（355天后到期）</a></p>
                    <p class="safe-term">服务专线：<span class="term-tim term-tim-co">020-8115456</span></p>
                </div>
            </div>

            <div class="all-css right-css left-img">
                <img src="images/1.jpg" class="cpic-r">
                <div class="safe-req">
                    <h4 style="margin-bottom:5px;">机动车商业险</h4>
                    <p class="safe-age">投保状态：<span class="age-term">生效中</span></p>
                    <p class="safe-term">保险期限：<span class="term-tim">1年</span><a>（355天后到期）</a></p>
                    <p class="safe-term">服务专线：<span class="term-tim term-tim-co">020-8115456</span></p>
                </div>
            </div> -->
        <div id="insurance-list"></div>

    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    $(".ord").bind("click", function () {
        $(".ord").removeClass("active");
        $(this).addClass("active");
    })
    $(".brand li").bind("click", function () {
        $(".brand li").removeClass("active");
        $(this).addClass("active");
    })
    $(".goods li").bind("click", function () {
        $(".goods li").removeClass("active");
        $(this).addClass("active");
    })
    $(".sort-style li").bind("click", function () {
        $(".sort-style li").removeClass("active");
        $(this).addClass("active");
    })

    //没有订单信息就显示“暂无订单信息
    $(document).ready(function () {
        var insurList = $("#insurance-list").html();
        console.log(insurList);
        if (insurList == "") {
            $("#insurance-list").html('<div style="width:100%;margin-left:20px;margin-top:20px;"><p>暂无订单信息</p></div>');
        }
        ;
    })


</script>
</body>
</html>
