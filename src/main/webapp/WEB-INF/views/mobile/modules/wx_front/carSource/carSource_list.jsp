<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>车源列表</title>

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

	<link href="static/css/weixin/carsource.css" rel="stylesheet" type="text/css">
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
.li_icon{
	padding-top:5px;
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
					<li class="li_icon">
						<img class="icon" style="margin-top:2px;" src="${pageContext.request.contextPath}/static/images/weixin/local.png" />
					</li>
					<li class="li_txt"><input type="text" id="fromAddress" placeholder="请选择省市"/></li>
					<li class="li_icon"><img style="width:20px;height:20px;" class="arrow" src="${pageContext.request.contextPath}/static/images/weixin/arrow_right.png" /></li>
					<li class="li_icon"><img class="icon" src="${pageContext.request.contextPath}/static/images/weixin/flag.png" /></li>
					<li class="li_txt"><input type="text" id="toAddress" placeholder="请选择省市"/></li>
				</ul>
			</div>
			<div class="add_div">
				<a href="${pageContext.request.contextPath}/weixin/carSource/carSource_add">发布</a>
			</div>
		</div>
		<div id="carsource"></div>
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
			searchCar(1);
		}; */
		searchCar(1);
		function searchCar(currentPage) {	
			searchConditions.CURRENTPAGE=currentPage;
			$.ajax({
				type : "POST",
				url : 'weixin/carSource/getcarSource', 
				data : searchConditions,
				dataType : 'json',
				cache : false,
				success : function(data) {
					if(data.state=="1"){
						if(data.data.LIST.length <= 0){
							$("#carsource").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
						} else{
							$("#page").show();
							$("#pageCount").html(data.data.PAGECOUNT); 
							var fillDatas = "";
							for (var i = 0; i < data.data.LIST.length; i++) {
								fillDatas += fillDataOne(data.data.LIST[i]);
							}
							$("#carsource").html("");
							$("#carsource").append(fillDatas);
						}
					}else{
						$("#carsource").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
					}
					$("#loading").css('display', 'none');
				}
			});
		}
		
		/***************填充到页面的数据***************/
		function fillDataOne(data) {
			var fromProvince = undefined == data.FROMPROVINCE ? "":data.FROMPROVINCE;
			var fromCity = undefined == data.FROMCITY ? "":data.FROMCITY;
			var toProvince = undefined == data.TOPROVINCE ? "":data.TOPROVINCE;
			var toCity = undefined == data.TOCITY ? "":data.TOCITY;
			var carNumber = undefined == data.CARNUMBER ? "":data.CARNUMBER;
			var carType = undefined == data.CARTYPE ? "":data.CARTYPE;
			var carLength = undefined == data.CARLENGTH ? "":data.CARLENGTH;
			var lengthUnit = undefined == data.LENGTHUNIT ? "":data.LENGTHUNIT;
			var loadWeight = undefined == data.LOADWEIGHT ? "":data.LOADWEIGHT;
			var weightUnit = undefined == data.WEIGHTUNIT ? "":data.WEIGHTUNIT;
			var contactName = undefined == data.CONTACTNAME ? "":data.CONTACTNAME;
			var contactMobile = undefined == data.CONTACTMOBILE ? "":data.CONTACTMOBILE;
			var state = undefined == data.USER_STATUS ? "":data.USER_STATUS;
			var pointLevel = undefined == data.POINTLEVEL ? "":data.POINTLEVEL;
			
			var licensePlate = "";	
			if ("0" == state) { 
				 licensePlate = '<span style="color:white;margin-left:5px;background:rgb(232,173,109);font-size: 0.8em;vertical-align: text-top;" >未认证</span>'; 
			} else if ("1" == state) {	
				licensePlate = '<span style="color:white;margin-left:5px;background:rgb(232,173,109);font-size: 0.8em;vertical-align: text-top;" >待认证</span>';
			} else if ("2" == state) {	
				licensePlate = '<span style="color:white;margin-left:5px;background:rgb(123,199,13);font-size: 0.8em;vertical-align: text-top;" >已认证</span>'; 
			} else if ("3" == state) {
				licensePlate = '<span style="color:white;margin-left:5px;background:rgb(232,173,109);font-size: 0.8em;vertical-align: text-top;" >认证失败</span>'; 
			} else {
				licensePlate = '<span style="color:white;margin-left:5px;background:rgb(232,173,109);font-size: 0.8em;vertical-align: text-top;" >未认证</span>'; 
			}
			
			var userCredit = "";
			if (undefined != pointLevel) {
				userCredit = '<img id="imgCredit" src="${pageContext.request.contextPath}/static/images/commom/wlpt/pointlevel/point_level_'+ pointLevel +'.gif" />';
			}
			/* var imgCall = '<a class="phonenumber" href="tel:'+ data.CONTACTMOBILE +'"><img id="imgCall" src="${pageContext.request.contextPath}/static/images/weixin/call.png" /></a>'; */
			/* if ("1" != flag) {
				$("#imgCall").css({display:"none"});
				imgCall = '<div class="phoneNumber" />';
			} */
			var html = '<div id="carInfo">'
						+ '<table>'
							+ '<tr id="carInfoList">'
								+ '<td class="left" onclick="carSourceDetail(\''+ data.CARSOURCEID +'\')">'
									+ '<div class="leftWidth"><div class="startAddress">'
										+ '<img id="imgStartCity" src="${pageContext.request.contextPath}/static/images/weixin/local.png" />'
										+ '<span id="startCity"><span class="addSpan">' + fromProvince + '</span><span>' + fromCity + '</span></span>'
									+ '</div>'
									+ '<div>'
										+ '<img id="imgArrow" src="${pageContext.request.contextPath}/static/images/weixin/arrow_down.png" /></div>'
										+ '<div class="endAddress">'
											+ '<img id="imgEndCity" src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />'
											+ '<span id="endCity"><span class="addSpan">' + toProvince + '</span><span>' + toCity + '</span></span>'
										+ '</div>'
									+ '</div>'
								+ '</td>'
								+ '<td class="center" onclick="carSourceDetail(\'' + data.CARSOURCEID + '\')">'
									+ '<div id="center">'
										+ '<strong id="carNumber">' + carNumber + '</strong>' + licensePlate 
										+ '<p><span id="carType" class="typeSpan">' + carType + '</span><span class="carLength">' + carLength + lengthUnit + '</span><span>' + loadWeight + weightUnit + '</span></p>'
										+ '<p class="elli"><span class="nameSpan">' + contactName + '</span><span id="phone">' + contactMobile + '</span></p>'
										+ '<p class="visable"><span id="credit"><span>信誉:</span>' + userCredit + '</span></p>'
									+ '</div>'
								+ '<td class="right">'
									/* + imgCall */
								+ '</td>'
							+ '</tr>'
						+ '</table>'
					+ '</div>';		
			return html;
		}
		
		/*******通过车源ID查询车源详细信息********/
		function carSourceDetail(id) {			
			window.location.href="weixin/carSource/carSource_detail?CARSOURCEID=" + id;
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
				searchCar(1);
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
				searchCar(1);
			}
		});
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
