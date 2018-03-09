<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>货源列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
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

	<link href="static/css/weixin/goodssource.css" rel="stylesheet" type="text/css">
<style type="text/css">
.search_div {
	width: 80%;
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
</style>
</head>

<body>
	<div>
		<%-- <%@ include file="../pagetitle.jsp"%> --%>
		<div style="width:100%;display:block;height:35px;border-bottom:1px solid #CCC;">
			<div class="search_div">
				<ul class="search_ul">
					<li>
						<img class="icon" style="margin-top:2px;" src="${pageContext.request.contextPath}/static/images/weixin/local.png" />
					</li>
					<li class="li_txt"><input type="text" id="fromAddress" placeholder="请选择省市"/></li>
					<li class="li_icon"><img src="${pageContext.request.contextPath}/static/images/weixin/arrow_right.png" class="arrow" /></li>
					<li class="li_icon"><img class="imgFlag flag" src="${pageContext.request.contextPath}/static/images/weixin/flag.png" /></li>
					<li class="li_txt"><input type="text" id="toAddress" placeholder="请选择省市"/></li>
				</ul>
			</div>
			<div class="add_div">
				<a href="${pageContext.request.contextPath}/weixin/goodsSource/goodsSource_add">发布</a>
			</div>
		</div>
		<div id="goodsSource"></div>
		<div id="loading" style="width:100%;margin-top:100px;vertical-align: middle;text-align:center;height:45px">
			<div><img src='static/images/weixin/loading.gif' style="width:70px"></div><div style=''>正在努力加载中，请稍等!</div>
		</div>
		<div id="page" style="display:none">
			<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span> <span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span> <span
				id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b id="pageCount"></b><span>页</span>
			</span>
		</div>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript">
		var searchConditions = {};
		searchConditions.SHOWCOUNT=10;
		/* window.onload = function() {
			searchGoods(1);
		}; */
		searchGoods(1);
	  function searchGoods (currentPage) {
		  searchConditions.CURRENTPAGE=currentPage;
			$.ajax({
				type : "POST",
				url : '${pageContext.request.contextPath}/weixin/goodsSource/getGoodsSource',
				data : searchConditions,
				dataType : 'json',
				cache : false,
				success : function(data) {
					if(data.state="1"){
						if(data.data.LIST.length <= 0){
							$("#goodsSource").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
						} else{
							$("#page").show();
							$("#pageCount").html(data.data.PAGECOUNT);
							var fillDatas = "";
							for (var i = 0; i < data.data.LIST.length; i++) {
								fillDatas += fillDataOne(data.data.LIST[i]);
							}
							$("#goodsSource").html("");
							$("#goodsSource").append(fillDatas);
						}
					}else{
						$("#goodsSource").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
					}
					$("#loading").css('display', 'none'); 
				}
			});
		}
		
		/*********************日期格式化*********************/
		Date.prototype.format = function (format) {
			var o = {
				"M+" : this.getMonth()+1, //month
				"d+" : this.getDate(), //day
				"h+" : this.getHours(), //hour
				"m+" : this.getMinutes(), //minute
				"s+" : this.getSeconds(), //second
				"q+" : Math.floor((this.getMonth()+3)/3), //quarter
				"S" : this.getMilliseconds() //millisecond
			};
			if(/(y+)/.test(format)) format=format.replace(RegExp.$1, (this.getFullYear()+"").substr(4- RegExp.$1.length));
			for(var k in o) {
				if(new RegExp("("+ k +")").test(format)) {
					format = format.replace(RegExp.$1, RegExp.$1.length==1? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
				}
			}
			return format;
		}
		
		/********************填充数据展示列********************/
		function fillDataOne(data) {
			var fromProvince = undefined == data.FROMPROVINCE ? "":data.FROMPROVINCE;
			var fromCity = undefined == data.FROMCITY ? "":data.FROMCITY;
			var toProvince = undefined == data.TOPROVINCE ? "":data.TOPROVINCE;
			var toCity = undefined == data.TOCITY ? "":data.TOCITY;
			var carType = undefined == data.CARTYPE ? "无":data.CARTYPE;
			var carLength = undefined == data.CARLENGTH ? "":data.CARLENGTH;
			var lengthUnit = undefined == data.LENGTHUNIT ? "":data.LENGTHUNIT;
			var loadWeigth = undefined == data.LOADWEIGHT ? "":data.LOADWEIGHT;
			var weightUnit = undefined == data.WEIGHTUNIT ? "":data.WEIGHTUNIT;
			var goodsName = undefined == data.GOODSNAME ? "":data.GOODSNAME;
			var sendTime = undefined == data.SENDTIME ? "":data.SENDTIME;
			var effectDays = undefined == data.EFFECTDAYS ? "":data.EFFECTDAYS + "天";
			
			sendTime = new Date(sendTime).format('yyyy年MM月dd日');
			/* var phoneLink = '<a class="phonelink" href="tel:'+ data.LINKMOBILE +'"><img class="imgCall" src="${pageContext.request.contextPath}/static/images/weixin/call.png" /></a>'; */
			/* if ("1" != flag) {
				phoneLink = "";
			} */
			var html = '<div class="goodsinfo">'
							+ '<div class="site">'
								+ '<img src="${pageContext.request.contextPath}/static/images/weixin/local.png" />'
							+ '</div>'
							+ '<div class="content">'
								+ '<div class="address" onclick="goodsSourceDetail(\'' + data.GOODSID + '\')">'
									+ '<span class="startaddr"><span class="addrSpan">' + fromProvince + '</span><span>' + fromCity + '</span></span><img src="${pageContext.request.contextPath}/static/images/weixin/arrow_right.png" class="arrow" />'
									+ '<img class="imgFlag flag" src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />'
									+ '<span class="endaddr"><span class="addrSpan">' + toProvince + '</span><span>' + toCity + '</span></span>'
								+ '</div>'
								+ '<div class="infos">'
									+ '<div class="toinfos" onclick="goodsSourceDetail(\'' + data.GOODSID + '\')">'
										+ '<p class="carintro"><span class="cartype">车型:</span><span>' + carType + '</span>'
										+ '<span class="carlength">车长:</span><span>' + carLength + lengthUnit + '</span>'
										+ '<span class="quality">重量:</span><span>' + loadWeigth + weightUnit + '</span>'
										+ '<span class="goodstype">' + goodsName + '</span></p>'
										+ '<p class="times"><span class="datetime">' + sendTime + '</span><span>信息有效期:</span><span>'+ effectDays +'</span></p>'
									+ '</div>'
								/* 	+ '<div class="phone">' + phoneLink + '</div>' */
								+ '</div>'
							+ '</div>'
						+ '</div>'
			return html;
		}
		
		/*******通过车源ID查询车源详细信息********/
		function goodsSourceDetail(id) {			
			window.location.href="weixin/goodsSource/goodsSource_detail?GOODSID=" + id;
		}
		
		$("#fromAddress").focus(function() {
			searchConditions.fromCity = '';
			searchConditions.fromProvince = '';
		});
		$("#toAddress").focus(function() {
			searchConditions.toCity = '';
			searchConditions.toProvince = '';
		});
		$("#fromAddress").PCC({
			hasCounty : false,
			width : "94%",
			height : 220,
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon: "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				searchConditions.fromCity = '';
				searchConditions.fromProvince = '';
				if (data.province) {
					str += data.province.NAME + " ";
					searchConditions.fromProvince = data.province.NAME;
				}
				if (data.city) {
					if (data.city.NAME != data.province.NAME) {
						str += data.city.NAME;
					searchConditions.fromCity = data.city.NAME;
					}
				}
				$("#fromAddress").val(str);
				searchGoods(1);
			}
		});

		$("#toAddress").PCC({
			hasCounty : false,
			width : "94%",
			height : 220,
			url : "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon: "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				searchConditions.toCity = '';
				searchConditions.toProvince = '';
				if (data.province) {
					str += data.province.NAME + " ";
					searchConditions.toProvince = data.province.NAME;
				}
				if (data.city) {

					if (data.city.NAME != data.province.NAME) {
						str += data.city.NAME;
						searchConditions.toCity = data.city.NAME;
					}
				}
				$("#toAddress").val(str);
				searchGoods(1);
			}
		});
		$("#firstPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (curPageNo != 1) {
				$("#curPage").html(1);
				alert($("#curPage").html());
				searchGoods(1);
			}
		});

		$("#previewPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (parseInt(curPageNo) > 1) {
				curPageNo--;
			}
			$("#curPage").html(curPageNo);
			alert($("#curPage").html());
			searchGoods(curPageNo);
		});

		$("#nextPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (parseInt(curPageNo) < parseInt(pageCount)) {
				curPageNo++;
			}
			$("#curPage").html(curPageNo);
			alert($("#curPage").html());
			searchGoods(curPageNo);
		});

		$("#lastPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (curPageNo != pageCount) {
				$("#curPage").html(pageCount);
				alert($("#curPage").html());
				searchGoods(pageCount);
			}
		});
	</script>
</body>
</html>
