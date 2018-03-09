<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

<title>司机列表</title>

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

.driver_div {
	width: 92%;
	padding: 5px;
	border: 1px solid #CCC;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	height: 80px;
	display: block;
	margin: 0px auto;
	margin-top: 10px;
}

.driver_div_left {
	width: 80%;
	float: left;
}

.driver_div_right {
	width: 20%;
	float: left;
	text-align: center;
	line-height: 50px;
}

.driver_div_right button {
	margin-top: 20px;
	width: 50px;
	height: 25px
}

.driver_div_left div {
	height: 25px;
	line-height: 25px;
	margin: 1px;
}

.span_left {
	width: 68%;
	float: left;
}

.span_right {
	widht: 28%;
	float: left;
	text-line: left;
}

#search {
	cursor: pointer;
}
.span_status{
	color: white;
	padding:2px;
	font-size: 0.8em;
	line-height:20px;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}
.span_statused{
	background:rgb(123,199,13);
}
.span_statusno {
	background: rgb(232, 173, 109);
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
		<%-- <%@ include file="../pagetitle.jsp"%> --%>
		<div style="width:100%;display:block;height:35px;margin:0 auto;border:1px solid #CCC;">
			<div class="search_div">
				<ul class="search_ul">
					<li style="padding-left:10px;">姓名：</li>
					<li><input type="text" style="font-size:14px;height:35px;width:120px;"  placeholder="请输入姓名" id="Search_driver"/></li>
				</ul>
			</div>
			<div class="add_div" id="search">搜索
			</div>
			<div class="add_div">
				<a href="${pageContext.request.contextPath}/weixin/driver/driver_add">添加</a>
			</div>
		</div>
		<div id="driver_box">
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
			searchDriver(1);Search_driver
		}; */
		$("#search").click(function(){
			searchConditions.driverName=$("#Search_driver").val();
			searchDriver(1);
		});
		searchDriver(1);
		function searchDriver(currentPage) {
			searchConditions.CURRENTPAGE = currentPage;
			$.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath}/weixin/driver/getDriver',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.state == "1") {
								if (data.driverList.length <= 0) {
									$("#driver_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
								} else {
									$("#page").show();
									$("#pageCount").html(data.PAGECOUNT);
									var fillDatas = "";
									for (var i = 0; i < data.driverList.length; i++) {
										fillDatas += fillDataOne(data.driverList[i]);
									}
									$("#driver_box").html("");
									$("#driver_box").append(fillDatas);
								}
							} else {
								$("#driver_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
							}
							$("#loading").css('display', 'none');
						}
					});
		}

		/***************填充到页面的数据***************/
		function fillDataOne(data) {
			if ("0" == data.STATUS) { 
				 licensePlate = '<span class="span_right span_status span_statusno" >未认证</span>'; 
			} else if ("1" == data.STATUS) {	
				licensePlate = '<span class="span_right span_status span_statusno" >待认证</span>';
			} else if ("2" == data.STATUS) {	
				licensePlate = '<span class="span_right span_status span_statused" >已认证</span>'; 
			} else if ("3" == data.STATUS) {
				licensePlate = '<span class="span_right span_status span_statusno" >认证失败</span>'; 
			} else {
				licensePlate = '<span class="span_right span_status span_statusno" >未认证</span>'; 
			}
			
			var html='<div class="driver_div"><div class="driver_div_left">'
			+'<div><span class="span_left" >司机姓名：<span class="font-red">'+data.DRIVERNAME+'</span></span>'
			+licensePlate
			+'</div>'
			+'<div>手机号码：'+data.DRIVERMOBILE+'</div>'
			+'<div>身份证号：'+data.IDCARDNUM+'</div></div>'
			+'<div class="driver_div_right">'
			+'<button class="regbt smallbtn" onclick="driverDlet('+"'"+data.DRIVERID+"'"+')">删除</button></div></div>';
			return html;
		}

		/*******通过司机ID查询司机信息********/
		function driverDlet(id) {
			$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/weixin/driver/deltDriver',
				data : {DRIVERID:id},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if (data.state == "1") {
						searchDriver(1);
					}
				}
			});
		}

		$("#firstPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (curPageNo != 1) {
				$("#curPage").html(1);
				searchDriver(1);
			}
		});

		$("#previewPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (parseInt(curPageNo) > 1) {
				curPageNo--;
			}
			$("#curPage").html(curPageNo);
			searchDriver(curPageNo);
		});

		$("#nextPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (parseInt(curPageNo) < parseInt(pageCount)) {
				curPageNo++;
			}
			$("#curPage").html(curPageNo);
			searchDriver(curPageNo);
		});

		$("#lastPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (curPageNo != pageCount) {
				$("#curPage").html(pageCount);
				searchDriver(pageCount);
			}
		});
	</script>
</body>
</html>
