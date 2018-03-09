<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>${fns:getConst('SYSTEMTITLE')}--周边车源</title>

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

	<script type="text/javascript" name="baidu-tc-cerfication"
			data-appid="8010943" src="http://apps.bdimg.com/cloudaapi/lightapp.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

	<link href="static/css/weixin/base.css" rel="stylesheet" type="text/css">
	<link href="static/css/weixin/global.css" rel="stylesheet"
		  type="text/css">

	<style type="text/css">
		/*整体div -top布局*/
		.search_top,.data_bottom {
			width: 100%;
			display: block;
			z-index: 2;
			position: fixed;
			background-color: #FFF;
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
			width: 33.33%;
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
			margin-bottom: 50px;
		}

		.data_title {
			clear: both;
			font-size: 16px;
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
			height: 30px;
			margin-top: 10px;
			display: table;
		}

		.ct_lf div {
			float: left;
			margin-right: 5px;
			line-height: 30px;
			display: table-cell;
			vertical-align: middle;
			display: table-cell;
			font-size: 16px;
		}

		.ic_img {
			height: 25px;
			display: table;
			margin: 0px;
		}

		.ic_img img {
			width: 25px;
			display: table-cell;
			vertical-align: middle;
			display: table-cell;
		}

		.cb_tle {
			width: 15%;
			text-align: right;
			float: left;
		}

		.cb_val {
			width: 80%;
			float: left;
			display: block;
			word-wrap: break-word;
		}

		.cb_val div {
			float: left;
			word-wrap: break-word;
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
			text-align: center;
			background: rgba(241, 234, 234, 0.67);
		}

		.timeline-content {
			width: 95%;
			padding-bottom: 0px;
		}

		.timeline-content p {
			width: 100%;
			border-top: 1 solid #CCC;
			padding-top: 5px;
		}

		.search_top {
			width: 97%;
			display: block;
			height: 36px;
			/*  border-bottom: 1px dashed #999; */
			z-index: 2;
			background-color: #EBEBEB;
			margin: 0 auto;
		}

		.search_center {
			width: 100%;
			margin: 0px auto;
			background-color: #FFF;
		}

		.address_div {
			clear: both;
			width: 100%;
			margin: 0 auto
		}

		.search_ul {
			width: 100%;
			height: 35px;
			list-style: none;
			margin: 5 auto;
			background-color: #FFF;
		}

		.search_ul li {
			float: left;
			text-align: center;
			line-height: 35px;
			width: 50%;
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
			width: 100%;
			line-height: 36px;
			text-align: center;
			background-color: rgba(10, 94, 206, 0.71);
			color: #FFFFFF;
		}

		#search a {
			text-decoration: none;
		}
	</style>
</head>
<body>
<div class="data_box data_box1">
	<!-- <div class="data_title">运单运输轨迹</div> -->
	<div class="search_top">
		<div class="address_div">
			<div class="search_ul" style="width:70%;float:left;margin:0px;">

				<div>
					<input class="li_txt" type="text" id="fromAddress"
						   readonly="readonly" placeholder="请选择省市" /> <img
						style="float:left; margin-top:2px;width:30px;"
						src="${pageContext.request.contextPath}/static/images/commom/wlpt/imgs/switch_btn.png" /><input
						class="li_txt" type="text" id="toAddress" readonly="readonly"
						placeholder="请选择省市" />
				</div>
				<div
						style="border-bottom:1px dashed #000;width:100%;height:1px;float:left;"></div>
				<div>
					<input type="text" id="searchInfo" placeholder="车牌号/手机号码"
						   style="width:100%;" />
				</div>
			</div>
			<div style="width:29%;float:right">
				<div id="search"
					 style="height:70px;text-align:center;line-height:70px;">搜索</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="CID" value="${result.data.CID }" /> <input
		type="hidden" id="CKEY" value="${result.data.CKEY }" /> <input
		type="hidden" id="CORDERSTATU" value="${result.data.ORDERSTATUS}" />
	<div class="data_cent" style="height:100%;width:97%;margin:0 auto;"
		 id="locationmap"></div>
</div>
<div class="data_bottom">
	<div id="allCount" style="display:none">0</div>
	共<b id="totalCount">0</b>条结果,在线<b id="onlineCount"></b>辆,附近<b
		id="nearCount"></b>辆
</div>
</body>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
		src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/weixin/weiXinUpload.js"></script>
<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=YYnbCRSKd9CGoqfP6PcM5wNo"></script>
<script type="text/javascript"
		src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/include/changeMore.js"></script>
<script type="text/javascript">
	var searchConditions = {};//查询数据条件
	var zoom = 12;//当前缩放比例
	var curpoint;//当前经纬度
	var pointArray = [];
	var titleArray = [];
	var labeArray = [];
	var titleIndex = 0;
	var map = new BMap.Map("locationmap", {
		enableMapClick : false,
		minZoom : 5,
		maxZoom : 20
	}); // 创建Map实例
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r) {
		if (this.getStatus() == BMAP_STATUS_SUCCESS) {
			$("#loading").hide();
			var mk = new BMap.Marker(r.point);
			var label = new BMap.Label("当前位置", {
				offset : new BMap.Size(20, -10)
			});
			mk.setLabel(label);
			map.addOverlay(mk);
			map.panTo(r.point);
			curpoint = r.point;
			map.centerAndZoom(r.point, 12);
			searchConditions.MinLong = r.point.lng;
			searchConditions.MinLat = r.point.lat;
			searchConditions.RAIDUS = 10;
			zoom = map.getZoom();
			getData();
			map.addEventListener("zoomend", function() {
				getdistance();
			});
		} else {
			alert('failed' + this.getStatus());
		}
	}, {
		enableHighAccuracy : true
	});
	function getdistance() {
		var bs = map.getBounds(); //获取可视区域
		var bssw = bs.getSouthWest(); //可视区域左下角
		var bsne = bs.getNorthEast(); //可视区域右上角
		var pointA = new BMap.Point(bssw.lng, bssw.lat);
		var pointB = new BMap.Point(bsne.lng, bsne.lat);
		var distance = (map.getDistance(pointA, pointB)).toFixed(2) / 2000;
		if (distance > searchConditions.RAIDUS) {
			searchConditions.RAIDUS = distance;
			if (map.getZoom() == 12 || map.getZoom() == 8 || map.getZoom() == 5) {
				pointArray = [];
				titleArray = [];
				labeArray = [];
				titleIndex = 0;
				getData();
			}
		}
	}
	$("#search").click(function() {
		map.clearOverlays();
		pointArray = [];
		titleArray = [];
		labeArray = [];
		titleIndex = 0;
		getData();
	});
	function getData() {
		searchConditions.currentPage = 1;
		searchConditions.showCount = 100;
		searchConditions.isShowMap = true;
		searchConditions.carNumberOrMobile = $("#searchInfo").val();
		$
				.ajax({
					url : "${pageContext.request.contextPath}/wlpt/cssearch/getcarsource",
					type : "POST",
					data : searchConditions,
					dataType : 'json',
					success : function(data) {
						//获取权限onlineCount
						$("#totalCount").html(data.carCount);
						$("#nearCount").html(data.nearCount);
						$("#onlineCount").html(data.onlineCount);
						if (data.dataRes.length > 0
								&& data.dataRes.length != null) {
							map.clearOverlays();
							for (var i = 0; i < data.dataRes.length; i++) {
								var point = new BMap.Point(data.dataRes[i].LNG,
										data.dataRes[i].LAT);
								var currentdataRes = data.dataRes[i];
								var carNumber = currentdataRes.CARNUMBER;
								var name = currentdataRes.NAME != null ? currentdataRes.NAME
								+ "|"
										: "";
								var titleval = "<div>车牌号:"
										+ carNumber
										+ "<br>"
										+ currentdataRes.CARTYPE
										+ " | "
										+ currentdataRes.CARLENGTH
										+ "米 | "
										+ currentdataRes.LOADWEIGHT
										+ "吨<br><a style='color:blue;' href='tel:"+currentdataRes.PHONE+"'>"
										+ name + currentdataRes.PHONE
										+ "</a><br>" + currentdataRes.INFO
										+ "<br>" + currentdataRes.GPSTIME
										+ "</div>";
								labeArray.push(carNumber);
								titleArray.push(titleval);
								pointArray.push(point);
							}
							AddPoints();
							var mk = new BMap.Marker(curpoint);
							var label = new BMap.Label("当前位置", {
								offset : new BMap.Size(20, -10)
							});
							mk.setLabel(label);
							map.addOverlay(mk);
							map.panTo(r.point);
							map.centerAndZoom(curpoint, 12);
						} else {
							var centerPoint = new BMap.Point(
									searchConditions.MinLong,
									searchConditions.MinLat);
							map.centerAndZoom(centerPoint, 12);
						}
					}
				});
	}
	function AddPoints() {
		BMap.Convertor.transMore(pointArray, 2, callback);
	}
	function callback(xyResult) {
		var myIcon = new BMap.Icon(
				"${pageContext.request.contextPath}/static/images/commom/wlpt/menuicon/img_car.png",
				new BMap.Size(50, 50));
		var optsInfo = {
			width : 200, // 信息窗口宽度
			height : 120, // 信息窗口高度
			title : "车辆信息", // 信息窗口标题
			enableMessage : true,//设置允许信息窗发送短息
			offset : new BMap.Size(0, -10),
			message : ""
		};
		var Labeopts = {
			position : point, // 指定文本标注所在的地理位置
			offset : new BMap.Size(20, -20)
		};
		if (xyResult.error != 0) {
			return;
		}//出错就直接返回;
		var point = new BMap.Point(xyResult.x, xyResult.y);
		var marker = new BMap.Marker(point, {
			icon : myIcon
		});
		var label = new BMap.Label(labeArray[titleIndex], Labeopts); // 创建文本标注对象
		label.setStyle({
			color : "blue",
			fontSize : "12px",
			height : "20px",
			lineHeight : "20px",
			fontFamily : "微软雅黑"
		});
		marker.setLabel(label);
		map.addOverlay(marker);
		marker.setTitle(labeArray[titleIndex]);
		var infoWindow = new BMap.InfoWindow(titleArray[titleIndex], optsInfo);
		marker.addEventListener("click", function() {
			map.openInfoWindow(infoWindow, point);
		});
		titleIndex++;
	}
	$("#fromAddress").PCC({
		hasCounty : false,
		width : 360,
		height : 220,
		ismiddle : true,
		url : "${pageContext.request.contextPath}/wlpt/area/getarea",
		closeIcon : "static/images/pic12.gif",
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				searchConditions.fromProvince = data.province.NAME;
			}
			if (data.city) {
				if (data.city.NAME != data.province.NAME) {
					str += data.city.NAME;
				}
				searchConditions.fromCity = data.city.NAME;
			}
			if (str != null && str != " ") {
				$("#fromAddress").val(str);
			} else {
				$("#fromAddress").val("");
			}
		}
	});

	$("#toAddress").PCC({
		hasCounty : false,
		width : 360,
		height : 220,
		ismiddle : true,
		url : "${pageContext.request.contextPath}/wlpt/area/getarea",
		closeIcon : "static/images/pic12.gif",
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				searchConditions.toProvince = data.province.NAME;
			}
			if (data.city) {
				if (data.city.NAME != data.province.NAME) {
					str += data.city.NAME;
				}
				searchConditions.toCity = data.city.NAME;
			}
			if (str != null && str != " ") {
				$("#toAddress").val(str);
			} else {
				$("#toAddress").val("");
			}
		}
	});
</script>
</html>
