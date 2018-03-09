<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>--油气明细</title>

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
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<link href="static/css/weixin/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div -top布局*/
.data_top,.result_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
}

.dt_top,.data_tab {
	clear: both;
	width: 100%;
}

.dt_top {
	height: 40px;
	line-height: 40px;
}

.dt_top div {
	
}

.data_tab div {
	width: 50%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}

.bord_rt {
	border-right: 1px solid #CCC;
}

/* 数据中部信息 */
.data_box {
	width: 97%;
	margin: 0 auto;
	padding-top: 50px;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 14px;
	background: #EBEBEB;
	height: 40px;
	line-height: 40px;
	width: 100%;
	text-indent: 10px;
}

.data_cent {
	width: 96%;
	padding: 5px 0px;
	padding-left: 4%;
}

.ct_lf {
	width: 100%;
	height: 35px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 45px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell
}

.ic_img {
	height: 35px;
	display: table;
}

.ic_img img {
	width: 30px;
	margin-top: 7px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_tle {
	width: 25%;
	text-align: right;
	float: left;
}

.cb_val {
	width: 70%;
	float: left;
}

.val_info {
	width: 30%;
}

.disnone {
	display: none;
}

.img_text {
	font-size: 1em;
	width: 60px;
	text-align: center;
	background-image: url(./static/images/weixin/pic_bg_normal.png);
	height: 60px;
	background-repeat: no-repeat;
	line-height: 35px;
	background-size: 60px;
	margin: 5%;
	float: left;
	cursor: pointer;
	position: relative;
	clear: both;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 60px;
	height: 35px;
}

.upimg {
	width: 60px;
	height: 60px;
}

#imgCredit {
	margin-top: 15px;
}

.up_ct {
	clear: both;
	width: 100%;
	margin-top: 10px;
	height: 50px;
}

.data_bottom {
	bottom: 0px;
	height: 40px;
	line-height: 40px;
	text-align: right;
	background: rgba(241, 234, 234, 0.67);
}

input[type='text'] {
	border-bottom: 1px solid #ccc;
	font-size: 18px;
	line-height: 25px;
	height: 30px;
}

.data_div {
margin-left:2%;
	width: 96%;
	/* background-color: #EBEBEB; */
	clear: both;
	height: 62px;
	margin: 0 auto;
	margin-bottom: 5px;
	/* border-bottom: 5px solid #EBEBEB; */
	padding-top:5px;
	border-radius:10px;
	background-color:white;
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
	width: 43%;
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
	/* border-bottom: 1px solid #EBEBEB; */
	clear: both;
	height: 40px;
}

.data_row div {
	font-size: 16px;
}

.mag_right {
	margin-right: 4%;
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
	width: 98%;
	padding-left: 6px;
	height: 25px;
	padding-top: 5px;
}

.data_btm div {
	float: left;
	margin-right: 3%;
	line-height: 25px;
}
.data_box1{
background-color: #EBEBEB;
}
</style>
</head>

<body>
	<!-- 	<div class="data_top data_tab" style="width:100%;padding:0px;">
			<div class="selected data_tab_left">申请提现</div>
			<div class="data_tab_right">提现记录</div>
	</div> -->
	<div class="data_box data_box1" style="padding-top:1px;">
		<div id="data_box" style="padding-top:5px;">
			<!-- <div id="data_div" class="data_div" >
				<div class="data_row data_btm">
					<div class="flt">交易单号:{{ORDERNO}}</div>
					<div class="frt" style="float:right;"><span class="authened">处理中</span></div>
				</div>
				<div class="data_row data_btm" style="border:none">
					<div>交易金额：￥{{FREIGHT}}元</div>
					<div class="frt" style="float:right;">
						2013-12-12
					</div>
				</div>
			</div> -->
		</div>
		<div id="pages" style="display:none;">
			<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
			<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
			<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
				id="pageCount">1</b><span>页</span> </span>
		</div>
		<div class="search_top result_bottom bottom">
			共<b id="totalCount">0</b>条信息
		</div>
	</div>
</body>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript">
	$(function() {
		$("#loading").hide();
		window.altmesg = function() {
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};

		var searchConditions = {};
		searchConditions.SHOWCOUNT = 10;
		searchConditions.CURRENTPAGE = 1;
		searchData(1);
		var nowpage = 1; ///当前页数
		var nowcount = 1;
		$(window).scroll(
				function() {
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
		//查询数据ajax
		function searchData(currentPage) {
			$("#loading").show();
			$("#page").hide();
			//$("#data_box").html("");
			searchConditions.CURRENTPAGE = currentPage;
			$
					.ajax({
						type : "POST",
						url : '${pageContext.request.contextPath}/weixin/petrol/getPetrolList',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.state == "1") {
								if (data.data.varList.length <= 0) {
									$("#data_box")
											.show()
											.append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} else {
									$("#page").show();
									nowcount = data.data.TOTALCOUNT;
									$("#pageCount").html(data.data.PAGECOUNT);
									//$("#allCount").html(data.ALLCOUNT);
									$("#curPage").html(
											searchConditions.CURRENTPAGE);
									$("#totalCount").html(nowcount);
									var fillDatas = "";
									for ( var i = 0; i < data.data.varList.length; i++) {
										if (data.isPetrol == "false") {
											if (data.listdata[i].TYPE == "1") {
												continue;
											}
										}
										fillDatas += fillDataOne(
												data.data.varList[i],
												data.data.isPetrol);
									}
									/* $("#data_box").html(""); */
									$("#data_box").append(fillDatas);
								}
							} else {
								$("#data_box").html("");
								$("#data_box")
										.show()
										.append(
												'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								$("#loading").hide();
							}
							$("#loading").css('display', 'none');
							$("#loading").hide();
						}
					});
		}
		function fillDataOne(data, isPetrol) {
			var names = data.NOWNAME != null ? data.NOWNAME : "";
			if (isPetrol == "true") {
				names = data.COMPANYNAME != null ? data.COMPANYNAME : "";
			}
			if(names.length > 5){
				names = names.substring(0, 4) + "…";
			}
			var html = '<div id="data_div" class="data_div" >'
					+ '<div class="data_row data_btm">'
					+ '<div class="flt">交易单号:' + data.ORDERNO + '</div>'
					+ '<div class="frt" style="float:right;"><span class="">'
					+ names + '</span></div>' + '</div>'
					+ '<div class="data_row data_btm" style="border:none">'
					+ '<div>交易金额：<span style="color:#FFBB66;">' + data.MONEY
					+ '</span>元</div>'
					+ '<div class="frt" style="float:right;color:#AAAAAA;">'
					+ data.PCREATETIME + '</div>' + '</div></div>';
			return html;
		}
	});
</script>

</html>
