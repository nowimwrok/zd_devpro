<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${fns:getConst('SYSTEMTITLE')}-- 竞标列表</title>

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

<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<link href="${ctxStatic}/weixin/css/carsource.css" rel="stylesheet"
	type="text/css">
<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
#title {
	width: 100%;
	height: 50px;
	background-color: rgb(9, 106, 235);
	display: table;
	display: none;
}

.logo_icon {
	width: 35px;
	height: 35px;
	margin-left: 20px;
}

.logo_div {
	width: 35%;
}

.search_top, .result_bottom {
	width: 100%;
	display: block;
	height: 35px;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}

.search_center {
	width: 100%;
	margin: 0px auto;
	/* background-color:#FFF; */
	background-color: rgba(32, 162, 226, 1);
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.top {
	top: 0px;
}

.bottom {
	bottom: 0px;
}

.line_middle {
	vertical-align: middle;
	display: table-cell;
}

.font-title {
	color: white;
	font-size: 1.6em;
	width: 60%;
}

.search_ul {
	width: 100%;
	height: 35px;
	list-style: none;
	margin: 0 auto;
	color: white;
	/* background-color: #FFF; */
	background-color: rgba(32, 162, 226, 1);
}

.address_div {
	clear: both;
	width: 100%;
	margin: 0 auto
}

.search_ul li {
	float: left;
	text-align: center;
	line-height: 35px;
	width: 100%;
}

.short_li {
	width: 5%;
}

.long_li {
	width: 100%;
}

.li_icon {
	width: 10%;
	text-align: left;
}

.li_txt {
	width: 42%;
	text-align: left;
	float: left;
	padding-left: 10px;
}

#search {
	cursor: pointer;
	width: 85%;
	line-height: 32px;
	text-align: center;
	/* background-color: rgb(27, 216, 244); */
	background-color: rgba(32, 162, 226, 1);
	color: #FFFFFF;
	margin-top: 4px;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 6px;
}

#search a {
	text-decoration: none;
}

#data_box {
	width: 100%;
	margin-top: 45px;
	margin-bottom: 30px;
}

.data_div {
	width: 98%;
	background-color: #FFF;
	clear: both;
	height: 95px;
	margin: 0 auto;
	margin-bottom: 5px;
	border-radius: 10px;
}

.data_content {
	vertical-align: middle;
	display: table-cell;
}

.top_icon {
	width: 20px;
	height: 35px;
}

.top_text {
	width: 72%;
	height: 40px;
	line-height: 40px;
}

.top_icon img {
	width: 20px;
	margin-top: 5px;
}

.icon {
	width: 25px;
}

.ic_img {
	width: 30px;
}

.data_row {
	width: 100%;
	clear: both;
}

.data_row div {
	font-size: 16px;
}

.mag_right {
	margin-right: 5%;
}

.flt {
	float: left;
	text-align: left;
}

.frt {
	float: right;
	text-align: right;
}

.data_btm {
	padding-left: 7px;
}

.data_btm div {
	float: left;
	margin-right: 6%;
	line-height: 25px;
}

.selected {
	/* background-color: rgb(255,247,244);
    color: rgb(27, 216, 244);
    border-bottom: 2px solid rgb(27, 216, 244); */
	color: #FFBB66;
	border-bottom: 2px solid #FFBB66;
	background-color: rgba(32, 162, 226, 1);
}
#mb_con{
	top:200px !important;
}
#mb_btn_ok,#mb_btn_no{
	text-align: center !important;
}
</style>
</head>

<body>
	<div class="search_top top">
		<div class="search_center">
			<ul class="search_ul contype_per">
				<li class="long_li selected">竞标列表</li>
			</ul>
			
		</div>
		<!-- search_center end  -->
	</div>
	<div id="data_box">
		<%-- <div class="data_div">
				<div class="data_row data_btm">
					<div class="flt" style="marign-right:0px;">文号:20139728327287</div><div class="frt" style="float:right;marign:0;">截止:2015-10-12</div>
				</div>
				<div class="data_row">
					<div class="top_icon flt" style="padding-left:10px;"><img alt="出发地" src="${pageContext.request.contextPath}/static/images/weixin/ic_start.png"></div>
					<div class="top_text flt">广东省广州市天河区</div>
					<div class="top_icon flt"><img alt="目的地" src="${pageContext.request.contextPath}/static/images/weixin/ic_end.png"></div>
					<div class="top_text flt">广东省广州市天河区</div>
				</div>
				<div class="data_row data_btm">
					<div class="ic_img" style="margin:0px;"><img class="icon" style="margin:0px;"alt="货物" src="${pageContext.request.contextPath}/static/images/weixin/ic_goods.png"></div>
					<div>鞍钢</div><div>100吨</div><div>￥10元</div>
					<div class="frt"><span class="authened">详情</span></div>
					<div class="ic_img" style="margin:0px;"><img class="icon" style="margin:0px;"alt="货物" src="${pageContext.request.contextPath}/static/images/weixin/remind.png"></div>
				<!-- 	<div class="frt"><span class="authened">中标通知</span></div> -->
				</div>
			</div> --%>
	</div>
	<div id='loading'
		style='width: 100%; display: none; vertical-align: middle; text-align: center; height: 45px'>
		<div>
			<img src='${ctxStatic}/images/loading-30x30.gif'>
		</div>
		<div style="font-size: 14px; font-weight: bold;" id="loadtext">加载中……</div>
	</div>
	<div id="pages" style="display: none;">
		<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
		<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
		<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
			id="pageCount">1</b><span>页</span> </span>
	</div>
	<div class="search_top result_bottom bottom">
		共<b id="totalCount">0</b>条信息
	</div>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
	<script type="text/javascript">
		$("#loading").show();
		$(function() {
			//条件
			var searchConditions = {};
			searchConditions.pageSize = 10;
			searchConditions.pageNo = 1;
			searchData(1);
			var nowpage = 1; ///当前页数
			var nowcount = 1;
			//按地址条件查询
			$("#search").click(function() {
				$("#data_box").html("");
				searchData(1);
			});
			$(window).scroll(
					function() {
						var curPageNo = $("#curPage").html();
						var pageCount = $("#pageCount").html();
						//下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8  
						var htmlHeight = document.body.scrollHeight
								|| document.documentElement.scrollHeight;
						//clientHeight是网页在浏览器中的可视高度，  
						var clientHeight = document.body.clientHeight
								|| document.documentElement.clientHeight;
						//scrollTop是浏览器滚动条的top位置，  
						var scrollTop = document.body.scrollTop
								|| document.documentElement.scrollTop;
						//通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；  
						if (scrollTop + clientHeight == htmlHeight) {
							nowpage += 1;
							if (nowpage <= parseInt(pageCount)) {
								searchData(nowpage);
							}

						}
					});
			//类型查询
			$(".contype_per li").click(function() {
				$(this).addClass("selected");
				var type = $(this).index();
				searchConditions.biddingstatus = type;
				if (type <= 0) {
					searchConditions = {};
					searchConditions.pageSize = 10;
					searchConditions.pageNo = 1;
				}
				$(".contype_per li").not(this).removeClass("selected");
				$("#data_box").html("");
				searchData(1);
			});
			//查询数据ajax
			function searchData(currentPage) {
				$("#loading").show();
				$("#page").hide();
				searchConditions.pageNo = currentPage;
				
				$.ajax({
							type : "POST",
							url : '${wx}/weixin/bid/getbiddingListbyBid',
							data : {
								pageNo : searchConditions.pageNo,
								pageSize : searchConditions.pageSize,
								'bidinfo.id': '${bidinfo.id}'

							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list != null) {
									if (data.value.list.length <= 0) {
										$("#data_box")
												.show()
												.append(
														'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									} else {
										nowcount = data.value.count;
										$("#pageCount").html(
												Math.ceil(data.value.count
														/ data.value.pageSize));
										$("#curPage").html(
												searchConditions.pageNo);
										$("#totalCount").html(nowcount);
										var fillDatas = "";
										for (var i = 0; i < data.value.list.length; i++) {
											fillDatas += fillDataOne(data.value.list[i]);
										}
										$("#data_box").append(fillDatas);
									}
								} else {
									$("#totalCount").html(0);
									$("#data_box").html("");
									$("#data_box")
											.show()
											.append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								}
								$("#loading").css('display', 'none');
							}
						});
			}

			/***************填充到页面的数据***************/
			function fillDataOne(data) {
				var biddingcount = "";
				var weight = "";
				if (data.userStatistics.biddingcount * 1 > 0) {
					biddingcount = data.userStatistics.biddingcount * 1;
				} else {
					biddingcount = '0';
				}
				var loginame=data.biddinguser.loginName;
				if (loginame.length > 6) {
					loginame = loginame.substring(0, 6) + "…";
				}
				if (data.bidinfo.goods.freightvolume * 1 > 999) {
					var p = data.bidinfo.goods.freightvolume / 1000;
					p = p.toString();
					var index = p.indexOf(".", 0);
					index = index >= 0 ? index : p.length;
					index += 2;
					index = index < p.length ? index : p.length;
					weight = p.substring(0, index) + "千";
				} else {
					weight = data.bidinfo.goods.freightvolume;
				}
				var biddingprice = data.biddingprice;
				if (biddingprice.length > 6) {
					biddingprice = biddingprice.substring(0, 6) + "…";
				}
				if (data.bidinfo.goods.freightunit == null) {
					data.bidinfo.goods.freightunit = '吨';
				}
				

				
				var bidlogo = '';
				if (data.biddingstatus=="竞标") {
					bidlogo = '<div  style="width:75%;height:27px;line-height:29px;font-size: 14px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px; margin:0 auto;padding-bottom:0px;background-color:rgba(20, 181, 47, 0.83); text-align: center;"><span style="font-weight: bold;color:white;" onclick="bidNotifys(' + "'"+data.id+ "'"+')">选择中标</span></div>';
				}else if (data.biddingstatus=="中标"){
					bidlogo = '<div  style="width:75%;height:27px;line-height:29px;font-size: 14px;-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px; margin:0 auto;padding-bottom:0px;background-color:rgba(20, 181, 47, 0.83); text-align: center;"><span style="font-weight: bold;color:white;" onclick="findNotifys(' + "'"+data.id+ "'"+')">中标通知</span></div>';
				}
				
	
				var html = '<div class="data_div" >'
						+ '<div class="data_row data_btm" >'
						+ '<div class="flt" style="marign-right:0px;color:#AAAAAA;">'
						+ loginame
						+ '</div><div class="frt" style="float:right;marign:0;color:#AAAAAA;">'
						+ ((data.createDate).substring(0, 10))
						+ '</div>'
						+ '</div>' 
						+ '<div class="data_row">' + ''
						+ '<div class="top_text flt"style="text-indent:5px;">'
						+ '竞标状态:'+data.biddingstatus+'</div>'
						+ '<div class="top_text"  style="width:28%;height:30%;float:right;">'
						+ bidlogo 
						+ '</div>'
						+ '</div>'
						
						+ '<div class="data_row data_btm">'
						+ '<div class="ic_img" style="margin:0px;"></div>'
						+ '<div style="color:#AAAAAA;">出价:' + biddingprice
						+ '</div><div style="color:#FFBB66;">' + weight
						+ data.bidinfo.goods.freightunit
						+ '</div><div style="color:#AAAAAA;">' + '中标<span style="color:red;">' + biddingcount
						+ '</span>次</div>'
						+ '</div>';
						
				html = html + '</div>';
				return html;
			}

			/*******通过ID查询详细信息********/
			
			window.findNotifys = function(id) {
				window.location.href = "${wx}/weixin/bid/notifys?id="
						+ id;
			};

			window.bidNotifys= function (id) {
				$("#loading").show();
				$.MsgBox.Confirm("中标提示", "是否选择中标?",function(){
					window.location.href = "${wx}/weixin/bid/bidNotifys?biddingId=" + id;
				},function(){
					$("#loading").hide();
	            },null,null,"是","否");
	        };
		});
	</script>
</body>
</html>
