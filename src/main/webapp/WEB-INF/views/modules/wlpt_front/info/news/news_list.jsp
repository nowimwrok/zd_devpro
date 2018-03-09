<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
<title>资讯新闻</title>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">

	<style type="text/css">
	 *{
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
       .secon_menu_wrap{
            position:relative;
        }
        .new_secon_menu{
            position: absolute;
            left: 0;
            top: 100%;
            margin-left: auto;
            width: 100%;
            display: none;
            border: 1px solid #ccc;
            filter: Alpha(opcity=50);
            background-color: rgba(255,255,255,0.8);
        }
        .new_secon_menu li{
            display: block;
            text-align: center;
            float: none;
            width: 100%;
            line-height: 30px;
            font-size: 1.5rem;
            height:30px;
            color: #333;
            font-family: "微软雅黑";
        }
        .new_secon_menu li:hover,.new_secon_menu li:active{
        background:#F5F5F5;
        }

        .news-left>ul{
        margin-bottom: 0px;
	    overflow: visible;
	    position: relative;
	    width:100%;
        }
        .news-menu>li{
        width:10%;
        text-align:center;
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
   <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/banner.jsp"%>


    <!-- 新闻列表 -->
   <div class="news-list">
        <div class="news-left">

            <ul class="news-menu new-menu-" >
                <li class="secon_menu_wrap" id="active-menu"><a href="#">资讯新闻</a>
                <input type="hidden" id="newstype"/>
                	<ul class="new_secon_menu">
                	<c:forEach items="${baseCategories}" var="category">
		                <li data-newstype="${category.id}"><a>${category.name}</a></li>
		            </c:forEach>
		            </ul>
                </li>
                <span class="glyphicon glyphicon-play" id="glyphicon-play"></span>
            </ul>
            <div class="media-wrap">
                <div id="media-wrap">

                </div>
                <div class="pagination" ></div>
            </div>
        </div>


        <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/infor_right.jsp"%>
    </div>
   <script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
   <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
   <script >
       $(".menu li").removeClass("active-menu");
       $(".menu li").eq("${param.index}").addClass("active-menu");
 //鼠标悬停出现二级菜单
   $(".secon_menu_wrap").mouseover(function() {
           $(this).find(".new_secon_menu").css("display","block")

       }).mouseout(function() {
           $(this).find(".new_secon_menu").css("display","none")
       });
   $(".secon_menu_wrap li").on("click",function(){
	   var newstype= $(this).attr("data-newstype");
	   $("#newstype").val(newstype);
	   page(1);
   })


   </script>


	<script type="text/javascript">

	//第一次调用
	page(1);

	//获取新闻数据
	function page(currentPage,showCount){
		var categoryId = $("#newstype").val();
		var infornewslist = $("#media-wrap");
		showCount=4;
		$.ajax({
				type: "POST",
				url: '${wlpt}/wlpt/info/getnewslist',
				data : {
					pageNo:currentPage,
					pageSize:showCount,
					categoryId:categoryId
				},
				dataType : 'json',
				cache : false,
			//dataFilter:function(data){alert(data)},
				success : function(data) {
					/* $("#loading").hide(); */
					 if(data.value.list){
						 $("#media-wrap").html("");//清空页面
						 $(".pagination").html(data.value.html);//加载翻页数据

					var list ="";
					for (var i = 0; i < data.value.list.length; i++) {
						 var dates = "";

						list+='<div class="media">'+
				                    '<a class="pull-left" href="#">'+
				                        '<img class="media-object" src="${ctxStatic }/images/wlptfront/red-car.png" style="width: 210px;height: 150px;">'+
				                    '</a>'+
				                    '<div class="media-body" style="margin-top: 8px;">'+
				                        '<h4 class="media-heading">'+data.value.list[i].baseCategories.name+'：'+data.value.list[i].title+'</h4>'+
				                        '<div style="margin-top: 8px;">'+
				                            '<p style="line-height: 25px;">'+data.value.list[i].content+'</p>'+
				                            '<p style="line-height: 35px;">'+data.value.list[i].releaseTime+'</p>'+
				                        '</div>'+
				                    '</div>'+
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