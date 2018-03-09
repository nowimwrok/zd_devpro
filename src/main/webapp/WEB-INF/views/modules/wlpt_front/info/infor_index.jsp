<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>资讯首页</title>
    
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">
    <link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/2.3.1/css_cerulean/bootstrap.css">
    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff;
            font-family: "微软雅黑";
        }

        @media screen and (max-width: 900px) {
            body {
                font-size: 1rem;
            }
        }

        .footer {
            clear: both;
        }

        .news-menu li {
            float: left;
            margin-right: 2%;
            font-size: 1.8rem;
            margin-bottom: 0px;
            position: relative;
        }

        .secon_menu_wrap {
            position: relative;
        }

        .new_secon_menu {
            position: absolute;
            left: 0;
            top: 100%;
            margin-left: auto;
            width: 100%;
            display: none;
            border: 1px solid #ccc;
            filter: Alpha(opcity=50);
            background-color: rgba(255, 255, 255, 0.8);
        }

        .new_secon_menu li {
            display: block;
            text-align: center;
            float: none;
            width: 100%;
            line-height: 30px;
            font-size: 1.5rem;
            height: 30px;
            color: #333;
            font-family: "微软雅黑";
        }

        .new_secon_menu li:hover, .new_secon_menu li:active {
            background: #F5F5F5;
        }

        .news-left > ul {
            margin-bottom: 0px;
            overflow: visible;
            position: relative;
            width: 100%;
        }

        .news-menu > li {
            width: 10%;
            text-align: center;
            height: 34px;
            cursor: pointer;
        }

        #glyphicon-play {
            position: absolute;
            top: 23px;
            left: 32px;
            z-index: -1;
            display: none;
            height: 12px;
        }

        .carousel-indicators {
            position: absolute;
            right: 15px;
            z-index: 5;
            margin: 0;
            list-style: none;
            bottom: 10px;
        }

    </style>

</head>
<body>

<%-- <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/banner.jsp" %> --%>

<!-- 新闻列表 -->
<div class="news-list" style="width: 100%">
    <div class="news-left">
        <input type="hidden" id="newstype" value="1"/>
        <input type="hidden" id="category"/>
        <ul class="news-menu">
            <li data-newstype="1"><a>最新文章</a><img src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play"
                                                  style="height: 12px;"></li>
            <li data-newstype="2"><a>物流头条</a><img src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play"
                                                  style="height: 12px;"></li>
            <li data-newstype="3" class="secon_menu_wrap" id="active-menu"><a>资讯新闻</a><img
                    src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play" style="height: 12px;">
                <ol class="new_secon_menu">
                    <c:forEach items="${baseCategories}" var="category">
                        <li data-category="${category.id}"><a>${category.name}</a></li>
                    </c:forEach>
                </ol>
            </li>
            <li data-newstype="4"><a href="${wlpt}/wlpt/info/policy/index">政策公告</a><img src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play"></li>
            <li data-newstype="5"><a href="${wlpt}/wlpt/hall/integrity">诚信排名</a><img src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play"></li>

        </ul>
        <div class="media-wrap">

            <div id="media-wrap">

            </div>

            <!-- <button class="btn btn-default" type="button">查看更多</button> -->
            <div class="pagination" style="width: 100%;margin-top: 25px;text-align: center"></div>
        </div>
    </div>


    <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/infor_right.jsp" %>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script>
    $(".menu li").removeClass("active-menu");
    $(".menu li").eq("${param.index}").addClass("active-menu");
    // 最新文章 物流头条 导航效果
    $(".news-menu>li").eq(0).find("img").css("display", "block");
    $(".news-menu>li").on("click", function () {
        $(".news-menu li img").css("display", "none");
        $(this).find('img').toggle();
        var newstype = $(this).attr("data-newstype");
        $("#newstype").val(newstype);


        page(1);
    });

    //鼠标悬停出现二级菜单
    $(".secon_menu_wrap").mouseover(function () {
        $(this).find(".new_secon_menu").css("display", "block")

    }).mouseout(function () {
        $(this).find(".new_secon_menu").css("display", "none")
    });
    $(".new_secon_menu>li").on("click", function () {
        var category = $(this).attr("data-category");
        $("#category").val(category);
        page(1);
    })


</script>


<script type="text/javascript">

    //第一次调用
    page(1);

    //获取新闻数据
    function page(currentPage, showCount) {
        var newstype = $("#newstype").val();
        var categoryId = $("#category").val();
        var url = '${wlpt}/wlpt/info/getnewslist';
        if (newstype * 1 == 2) {
            url = '${wlpt}/wlpt/info/gethotnewslist';
        }
        if (newstype * 1 != 3) {
            $("#category").val("");
        }
        var infornewslist = $("#media-wrap");
        showCount = 4;
        $.ajax({
            type: "POST",
            url: url,
            data: {
                pageNo: currentPage,
                pageSize: showCount,
                categoryId: categoryId
            },
            dataType: 'json',
            cache: false,
            //dataFilter:function(data){alert(data)},
            success: function (data) {
                /* $("#loading").hide(); */
                $("#media-wrap").html("");//清空页面
                if (data.value.list) {

                    $(".pagination").html(data.value.html);//加载翻页数据

                    var list = "";
                    for (var i = 0; i < data.value.list.length; i++) {
                    	var img = '<img class="media-object" src="${ctxStatic }/images/wlptfront/red-car.png" style="width: 210px;height: 150px;">'
       						var picture = data.value.list[i].picture;
       						if(picture!=undefined &&picture!=null &&picture != '' ){
	       						if(picture.indexOf("|")!=-1){
	       							picture = picture.replace('|','');
		       					}
       							img = '<img class="media-object" src="'+picture+'" style="width: 210px;height: 150px;">'
       						}
						
                        list += '<div class="media">' +
                                '<a class="pull-left" href="#">'+img+'</a>' +
                                '<div class="media-body">' +
                                '<h4 class="media-heading">' + data.value.list[i].baseCategories.name + '：' + data.value.list[i].title + '</h4>' +
                                '<div style="margin-top: 8px;">' +
                                '<p style="line-height: 25px;"> ' + data.value.list[i].content + ' <a href="${wlpt}/wlpt/info/getinfornewsddetail?id=' + data.value.list[i].id + '" target="_blank">[阅读更多]</a></p>' +
                                '<p style="line-height: 35px;">' + data.value.list[i].releaseTime + '</p>' +
                                '</div>' +
                                '</div>' +
                                '</div>';
                    }

                    infornewslist.append(list);
                }
            }
        });
    }
</script>
</body>
</html>