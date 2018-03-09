<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

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

</head>

<body>
	<div id="content">
		<%-- <%@ include file="./pagetitle.jsp"%> --%>  
		<div id="carsource"></div>
		<div id="loading" style="width:100%;margin-top:100px;vertical-align: middle;text-align:center;height:45px">
			<div><img src='static/images/weixin/loading.gif' style="width:70px"></div><div style=''>正在努力加载中，请稍等!</div>
		</div>
		<div id="page" style="display:none;">
			<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span> <span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span> <span
				id="pageInfo">第<b id="curPage">${pd.pagenow}</b>页/共<b id="pageCount"></b>页
			</span>
		</div>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript">
		var showCount = 10;
		var flag = ${pd.flag}
		var fromProvince = '${pd.fromProvince}';
		var fromCity = '${pd.fromCity}';
		var fromDistrict = '${pd.fromDistrict}';
		var toProvince = '${pd.toProvince}';
		var toCity = '${pd.toCity}';
		var toDistrict = '${pd.toDistrict}';
		var carType = '${pd.carType}';
		var carLengthMin = '${pd.carLengthMin}';
		var carLengthMax = '${pd.carLengthMax}';
		var loadWeightMin = '${pd.loadWeightMin}';
		var loadWeightMax = '${pd.loadWeightMax}';
		var forlink = "weixin/carsource?flag="+ flag +"&fromProvince=" + fromProvince + "&fromCity=" + fromCity + "&fromDistrict=" + fromDistrict + "&toProvince=" + toProvince +"&toCity=" + toCity + "&toDistrict=" + toDistrict + "&carType=" + carType + "&carLengthMin=" + carLengthMin + "&carLengthMax=" + carLengthMax + "&loadWeightMin=" + loadWeightMin + "&loadWeightMax=" + loadWeightMax + "&pagenow=";
		window.onload = function() {
			searchCar(${pd.pagenow});
		}
		function searchCar(currentPage) {			
			$.ajax({
				type : "POST",
				url : 'weixin/findcarsource', 
				data : {
					Flag : flag, 
					FromProvince : fromProvince,
					FromCity : fromCity,
					FromDistrict : fromDistrict,
					ToProvince : toProvince,
					ToCity : toCity,
					ToDistrict : toDistrict,
					CarType : carType,
					CarLengthMin : carLengthMin,
					CarLengthMax : carLengthMax,
					LoadWeightMin : loadWeightMin,
					LoadWeightMax : loadWeightMax,
					ShowCount : showCount,
					CurrentPage : currentPage
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					$("#pageCount").html(data.pageCount); 
					var fillDatas = "";
					for (var i = 0; i < data.carSourcelist.length; i++) {
						fillDatas += fillDataOne(data.carSourcelist[i]);
					}
					$("#carsource").append(fillDatas);
					
					if(data.carSourcelist.length <= 0){
						$("#carsource").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">没有查询到数据，请更改查询条件...</p>');
					} else{
						$("#page").show();
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
			var imgCall = '<a class="phonenumber" href="tel:'+ data.CONTACTMOBILE +'"><img id="imgCall" src="${pageContext.request.contextPath}/static/images/weixin/call.png" /></a>';
			if ("1" != flag) {
				$("#imgCall").css({display:"none"});
				imgCall = '<div class="phoneNumber" />';
			}
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
									+ imgCall
								+ '</td>'
							+ '</tr>'
						+ '</table>'
					+ '</div>';		
			return html;
		}
		
		/*******通过车源ID查询车源详细信息********/
		function carSourceDetail(id) {
			window.location.href="weixin/cardetail?CARSOURCEID="+ id +"&flag=" + flag;
		}
		
		/****************首页*****************/
		$("#firstPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (curPageNo != 1) {
				window.location.href = forlink + 1;
			}
		});
		
		/****************上一页*****************/
		$("#previewPage").click(function() {
			var curPageNo = $("#curPage").html();
			if (curPageNo > 1) {
				curPageNo--;
			window.location.href = forlink + curPageNo;
			}
		});
		
		/****************下一页*****************/
		$("#nextPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (parseInt(curPageNo) < parseInt(pageCount)) {
				curPageNo++;
				window.location.href = forlink + curPageNo;
			}
		});
		
		/****************尾页*****************/
		$("#lastPage").click(function() {
			var curPageNo = $("#curPage").html();
			var pageCount = $("#pageCount").html();
			if (curPageNo != pageCount) {
				window.location.href = forlink + pageCount;
			}
		});
	</script>
</body>
</html>
