<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>车辆列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
<link href="static/css/weixin/carsource.css" rel="stylesheet"
	type="text/css">
<link href="static/css/weixin/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
.search_div {
	width: 60%;
	float: left;
	border-right: 1px solid #CCC;
}

.search_ul {
	width: 100%;
	list-style: none;
}

.search_ul li {
	float: left;
	line-height: 35px;
}

.li_icon {
	width: 10%;
	text-align: left;
}

.li_txt {
	width: 35%;
	text-align: left;
}

.search_ul li input {
	line-height: 35px;
	height: 35px;
	width: 90%;
	border: none;
	background-color: rgb(235, 235, 235);
}

.icon {
	width: 25px;
	height: 25px;
}

.li_icon {
	padding-top: 5px;
}

.add_div {
	float: left;
	width: 18%;
	line-height: 35px;
	text-align: center;
}

.add_div a {
	color: #F74000;
	text-decoration: none;
	width: 100%;
}

.car_div {
	width: 92%;
	padding:5px;
	border:1px solid #CCC;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	height:120px;
	display:block;
	margin:0px auto;
	margin-top:10px;
}
.car_div_left {
	width: 80%;
	float:left;
}
.car_div_right {
	width: 20%;
	float:left;
	text-align:center;
	line-height:50px;
}
.car_div_right button{
	margin-top: 20px;
	width:50px;
	height:25px
}
.car_div_left div{
	height:25px;
	line-height:25px;
	margin:1px;
}
.span_left{
	width:68%;
	float:left;
}
.span_right{
	widht:28%;
	float:left;
	text-line:left;
}
#search{
	cursor: pointer;
}
</style>
	<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
</script>

</head>

<body>
	<div>
		<div
			style="width:100%;display:block;height:35px;border-bottom:1px solid #CCC;">
			<div class="search_div">
				<ul class="search_ul">
					<li style="padding-left:10px;">车牌号：</li>
					<li><input type="text" style="font-size:12px;width:120px;"  placeholder="请输入车牌号或手机" id="Search_car"/></li>
				</ul>
			</div>
			<div class="add_div" id="search">搜索
			</div>
			<c:if test="${sessionScope.USERPD.USER_ID ne 'a1' }">
				<div class="add_div">
					<a href="${pageContext.request.contextPath}/weixin/car/car_add">添加</a>
				</div>
			</c:if>
		</div>
		<div id="car_box">
		</div>
		<div id="loading"
			style="width:100%;margin-top:100px;vertical-align: middle;text-align:center;height:45px">
			<div>
				<img src='static/images/weixin/loading.gif' style="width:70px">
			</div>
			<div style=''>正在努力加载中，请稍等!</div>
		</div>
		<div id="page" style="display:none">
			<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
			<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
			<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
				id="pageCount"></b><span>页</span> </span>
		</div>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript">
		var searchConditions = {};
		searchConditions.SHOWCOUNT = 10;
		/* window.onload = function() {
			searchCar(1);Search_car
		}; */
		$("#search").click(function(){
			searchConditions.carNumberOrMobile=$("#Search_car").val();
			searchCar(1);
		});
		searchCar(1);
		function searchCar(currentPage) {
			searchConditions.CURRENTPAGE = currentPage;
			$.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath}/weixin/car/getcar',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.state == "1") {
								if (data.carList.length <= 0) {
									$("#car_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
								} else {
									$("#page").show();
									$("#pageCount").html(data.PAGECOUNT);
									var fillDatas = "";
									for (var i = 0; i < data.carList.length; i++) {
										fillDatas += fillDataOne(data.carList[i]);
									}
									$("#car_box").html("");
									$("#car_box").append(fillDatas);
								}
							} else {
								$("#car_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
							}
							$("#loading").css('display', 'none');
						}
					});
		}

		/***************填充到页面的数据***************/
		function fillDataOne(data) {
			var type="社会车辆";
			if(data.ISSOCIALCAR!="1"){
				type="自有车辆";
			}
			var mobile=data.OWNERMOBILE!=null?data.OWNERMOBILE:"";
			var html='<div class="car_div"><div class="car_div_left">'
			+'<div>车牌号：<span class="font-red">'+data.CARNUMBER+'</span></div>'
			+'<div><span class="span_left">车型：'+data.CARTYPE+'</span><span class="span_right">'+type+'</span></div>'
			+'<div><span class="span_left">手机：'+mobile+'</span><span class="span_right">车长：'+data.CARLENGTH+'米'+'</span></div>'
			+'<div><span class="span_left">完成订单：'+data.TRADECOUNT+'笔</span><span class="span_right">载重：'+data.LOADWEIGHT+'吨</span></div></div>';
			if(${sessionScope.USERPD.USER_ID != 'a1' }){
				html+='<div class="car_div_right"><button class="regbt smallbtn" onClick="carEdit('+"'"+data.CARID+"'"+')">编辑</button><br>';
				html+='<button class="regbt smallbtn" onClick="carDelt('+"'"+data.CARID+"'"+')">删除</button></div>'; 
			}
			html+='</div>';
			return html;
		}

		/*******通过车辆ID查询车辆详细信息********/
		window.carEdit=function(id) {
			window.location.href = "weixin/car/car_edit?CARID="
					+ id;
		};
		window.carDelt=function(id) {
			$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/weixin/car/deltCar',
				data : {CARID:id},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if (data.state == "1") {
						searchCar(1);
					}
				}
			});
		};

		$("#firstPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (curPageNo != 1) {
				$("#curPage").html(1);
				searchCar(1);
			}
		});

		$("#previewPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (parseInt(curPageNo) > 1) {
				curPageNo--;
			}
			$("#curPage").html(curPageNo);
			searchCar(curPageNo);
		});

		$("#nextPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (parseInt(curPageNo) < parseInt(pageCount)) {
				curPageNo++;
			}
			$("#curPage").html(curPageNo);
			searchCar(curPageNo);
		});

		$("#lastPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (curPageNo != pageCount) {
				$("#curPage").html(pageCount);
				searchCar(pageCount);
			}
		});
	</script>
</body>
</html>
