<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="">
<title>--价格指数</title>

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

	<link href="static/css/weixin/carsource.css" rel="stylesheet"
	type="text/css">
<link href="static/css/weixin/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
.search_top,.result_bottom {
	width: 100%;
	display: block;
	border-bottom: 1px dashed #999;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}

.search_top {
	height: 35px;
	width: 100%;
	line-height: 35px;
	border-bottom: 1px solid #EBEBEB;
	background-color: #FFF;
	margin: 0px auto;
	margin-top: 2px;
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

#data_box,#data_add {
	width: 98%;
	margin: 0 auto;
	margin-top: 37px;
	margin-bottom: 30px;
}

#search {
	cursor: pointer;
	width: 100%;
	line-height: 35px;
	text-align: center;
	background-color: rgba(10, 94, 206, 0.71);
	color: #FFFFFF;
}

#search a {
	text-decoration: none;
}

.hedImg {
	width: 40px;
	height: 40px;
	margin: 2px auto;
	border-radius: 40px;
	border: 1px solid #CCC;
}

.hededImg {
	width: 40px;
	height: 40px;
	margin: 2px auto;
	border-radius: 40px;
	border: 1px solid #CCC;
}

.hedImg img {
	width: 40px;
	height: 40px;
	border-radius: 40px;
}

.data_tab_left {
	width: 49%;
}

.data_tab_right {
	width: 50%;
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

.li_txt {
	width: 42%;
	text-align: left;
	float: left;
	padding-left: 10px;
	height: 35px;
}

.div_tb table tr td {
	text-align: center;
}
</style>
</head>

<body>
	<div class="search_top top">
		<div class="data_top data_tab">
			<div class="address_div">
				<div class="search_ul" style="width:70%;float:left;margin:0px;">
					<input class="li_txt" type="text" id="fromAddress"
						readonly="readonly" placeholder="请选择省市" /> <img
						style="float:left; margin-top:2px;width:30px;height:28px;"
						src="${pageContext.request.contextPath}/static/images/commom/wlpt/imgs/switch_btn.png" /><input
						class="li_txt" type="text" id="toAddress" readonly="readonly"
						placeholder="请选择省市" />
				</div>
				<div style="width:28%;float:right">
					<div id="search">搜索</div>
					<input id="Fpro" type="hidden" value="" /><input id="FCity"
						type="hidden" value="" /> <input id="Tpro" type="hidden" value="" /><input
						id="TCity" type="hidden" value="" />
				</div>
			</div>
		</div>
	</div>
	<div id="data_box">
		<div style="text-indent: 30px;">卓大物流平台内物流企业近千家，每天进出大型货车超过3000台，
			货运量每年约3000万吨，安置就业人数10000多名。 价格表是在近千家物流企业中，选择36家代表性企业，每周按照
			运营线路实际发生的平均价格，再加上卓大信息交易中心交易得 到的周平均价格，经过卓大管理中心审核后，实时上传，该价格
			具真实性、代表性、权威性</div>
		<div class="div_tb">
			<table width="100%" border="1" cellspacing="0" cellpadding="0">
				<tbody>
					<tr style="font-size: 16px;color: blue; font-weight: bolder;">
						<th width="25%" scope="col">路线</th>
						<th width="25%" scope="col">运输方式</th>
						<th width="25%" scope="col">均价</th>
						<th width="25%" scope="col">时间</th>
					</tr>

					<tr>
						<td>青岛-长沙</td>
						<td>零担轻货运输</td>
						<td>365.0</td>
						<td>2016-03-23</td>
					</tr>

					<tr>
						<td>青岛-长春</td>
						<td>零担轻货运输</td>
						<td>356.0</td>
						<td>2016-03-23</td>
					</tr>

					<tr>
						<td>青岛-银川</td>
						<td>零担轻货运输</td>
						<td>553.0</td>
						<td>2016-03-23</td>
					</tr>

					<tr>
						<td>青岛-重庆</td>
						<td>零担轻货运输</td>
						<td>418.0</td>
						<td>2016-03-23</td>
					</tr>

					<tr>
						<td>青岛-郑州</td>
						<td>零担轻货运输</td>
						<td>271.0</td>
						<td>2016-03-23</td>
					</tr>

					<tr>
						<td>青岛-贵阳</td>
						<td>零担轻货运输</td>
						<td>443.0</td>
						<td>2016-03-23</td>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
	<div id="data_add"
		style="display:none;margin-top:50px;background:#FFF;">
		<%-- <jsp:include page="goodsSource_add.jsp"  flush="true"></jsp:include> --%>
	</div>
	<div id='loading'
		style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
		<div>
			<img src='static/images/loading-30x30.gif'>
		</div>
		<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中……</div>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/weixin/config.js"></script>
	<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="static/js/weixin/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript">
		$("#loading").hide();
		$(function() {
			$("#fromAddress").PCC({
				hasCounty : false,
				width : "94%",
				height : 320,
				url : "${pageContext.request.contextPath}/wlpt/area/getarea",
				closeIcon : "static/images/pic12.gif",
				complete : function(data) {
					var str = "";
					searchConditions.FROMADDRESS = '';
					searchConditions.fromCity = '';
					searchConditions.fromProvince = '';
					if (data.province) {
						str += data.province.NAME + " ";
						searchConditions.fromProvince = data.province.NAME;
						$("#Fpro").val(data.province.NAME);
					}
					if (data.city) {
						if (data.city.NAME != data.province.NAME) {
							str += data.city.NAME;
							searchConditions.fromCity = data.city.NAME;
							$("#FCity").val(data.city.NAME);
						}
					}
					if (str != " ") {
						$("#fromAddress").val(str);
					} else {
						$("#fromAddress").val("");
					}
				}
			});

			$("#toAddress").PCC({
				hasCounty : false,
				width : "94%",
				height : 320,
				url : "${pageContext.request.contextPath}/wlpt/area/getarea",
				closeIcon : "static/images/pic12.gif",
				location : "left",
				ismiddle : true,
				complete : function(data) {
					var str = "";
					searchConditions.TOADDRESS = '';
					searchConditions.toCity = '';
					searchConditions.toProvince = '';
					if (data.province) {
						str += data.province.NAME + " ";
						searchConditions.toProvince = data.province.NAME;
						$("#Tpro").val(data.province.NAME);
					}
					if (data.city) {

						if (data.city.NAME != data.province.NAME) {
							str += data.city.NAME;
							searchConditions.toCity = data.city.NAME;
							$("#TCity").val(data.city.NAME);
						}
					}
					if (str != " ") {
						$("#toAddress").val(str);
					} else {
						$("#toAddress").val("");
					}
					/* searchGoods(1); */
				}
			});
		});
	</script>
</body>
</html>
