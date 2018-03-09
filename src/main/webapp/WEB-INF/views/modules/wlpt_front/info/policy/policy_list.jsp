<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>政策公告</title>
    <link rel="stylesheet" type="text/css" href="/static/bootstrap/2.3.1/css_cerulean/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">
    <link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet"/>

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
            height: 31px;
        }
        .carousel-indicators {
            position: absolute;
            right: 15px;
            z-index: 5;
            margin: 0;
            list-style: none;
            bottom: 10px;
        }
        #glyphicon-play {
            position: absolute;
            top: 22px;
            left: 32px;
            z-index: -1;
        }
    </style>

</head>
<body>
<%-- <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/banner.jsp" %> --%>


<!-- 政策公告列表 -->
<div class="news-list">
    <div class="news-left">
        <input type="hidden" id="category"/>
        <ul class="news-menu">
            <c:forEach items="${baseCategories}" var="category">
                <li data-category="${category.id}"><a>${category.name}</a><img
                        src="${ctxStatic }/images/wlptfront/menu_up.png" id="glyphicon-play"
                        style="height: 12px;"></span></li>

            </c:forEach>


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
    // 最新文章 物流头条 导航效果
    $(".news-menu>li").eq(0).find("img").css("display", "block");

    $(".news-menu>li").on("click", function () {
        $(".news-menu li img").css("display", "none");
        $(this).find('img').toggle();
        var category = $(this).attr("data-category");
        $("#category").val(category);
        page(1);
    });
    $("#category").val($(".news-menu>li").eq(0).attr("data-category"));


</script>


<script type="text/javascript">


    //第一次调用
    page(1);
    //获取新闻数据
    function page(currentPage, showCount) {
        var categoryId = $("#category").val();
        var url = '${wlpt}/wlpt/info/policy/getpolicylist';

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
                $("#media-wrap").html("");//清空页面
                /* $("#loading").hide(); */
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
                        list += '<div class="media" >' +
                       	 		'<a class="pull-left" href="#">'+img+'</a>' +
                                '<div class="media-body" style="margin-top: 8px;height: 140px;">' +
                                '<h4 class="media-heading">' + data.value.list[i].title + '</h4>' +
                                '<div style="margin-top: 8px;">' +
                                '<p style="line-height: 25px;"> ' + data.value.list[i].content + ' <a href="${wlpt}/wlpt/info/getinfornewsddetail?id=' + data.value.list[i].id + '" target="_blank" style="color: #428bca;">[阅读更多]</a></p>' +
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