<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

<title>平台概况</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-con trol" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<style type="text/css">
body {
	padding: 0px;
	margin: 0px;
}

.div_box {
	width: 100%;
}

.data_div {
	width: 90%;
	margin: 0 auto;
	text-align: center;
}

.data_title {
	height: 30px;
	line-height: 30px;
	margin-top: 10px;
}

.split {
	height: 20px;
	width: 100%;
	clear: both;
}
</style>
<script src="static/echart/echarts-all.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/weixin/Chart.js"
	language="javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"
	language="javascript"></script>
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
<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中……</div>
			</div>
	<div id="content" class="div_box">
		<div class="data_div">
			<div id="mainMember" style="height:300px;width:100%;margin:0 auto;margin-top:20px;"></div>
			<div class="split"></div>
			<!-- <div id="mainOrderInfo"
				style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div> -->
			<div id="mainWlptInfo"
				style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div>
			<div id="mainWlptDayInfo"
				style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div>
			<!-- <div id="mainBidInfo" style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div>
			<div id="mainGoodsInfo"
				style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div>
			<div id="mainCarInfo" style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div> -->
			
		</div>
	</div>
	<!-- content-end -->
	<script type="text/javascript">
		window.jQuery
				|| document
						.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");
	</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="static/js/jquery-ui-1.10.2.custom.min.js"></script>
	<script type="text/javascript"
		src="static/js/jquery.ui.touch-punch.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.slimscroll.min.js"></script>
	<script type="text/javascript"
		src="static/js/jquery.easy-pie-chart.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.sparkline.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.flot.min.js"></script>
	<script type="text/javascript" src="static/js/jquery.flot.pie.min.js"></script>
	<script type="text/javascript"
		src="static/js/jquery.flot.resize.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript">
		function initChart(chartDom, chartTitle, chartSubtext, legendData,
				seriesData) {
			// 基于准备好的dom，初始化echarts图表
			var myChart = echarts.init(document.getElementById(chartDom));
			option = {
				title : {
					text : chartTitle,
					subtext : chartSubtext,
					x : 'center'
				},
				tooltip : {
					trigger : 'item',
					formatter : "{a} <br/>{b}  ({d}%)"
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : legendData
				},
				toolbox : {
					show : false,
					feature : {
						mark : {
							show : false
						},
						dataView : {
							show : false,
							readOnly : false
						},
						magicType : {
							show : false,
							type : [ 'pie', 'funnel' ],
							option : {
								funnel : {
									x : '15%',
									width : '40%',
									funnelAlign : 'left',
									max : 100000
								}
							}
						},
						restore : {
							show : false
						},
						saveAsImage : {
							show : false
						}
					}
				},
				calculable : false,
				series : [ {
					name : chartTitle,
					type : 'pie',
					radius : '50%',
					center : [ '50%', '60%' ],
					data : seriesData
				} ]
			};

			// 为echarts对象加载数据 
			myChart.setOption(option);
		}
		$(function() {
			var userCount = 0, userGoods = 0, userCompany = 0,
			userCar = 0, carCount = 0, bidCount=0, orderCount=0,
			REGISTERMEMBERCOUNT=0, CERTIFIEDMEMBERCOUNT = 0, 
			CERTIFIEDCARCOUNT=0, CARCOUNT=0, ONLINECARCOUNT=0, 
			GOODSCOUNT=0,  BIDCOUNT=0,
			BIDFINISHCOUNT=0, ORDERCOUNT=0, ORDERFINISHCOUNT=0,goodsCount=0;

			$.ajax({
						url : "${pageContext.request.contextPath}/weixin/user/getOneDayInfo",
						type : 'post',
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.state == "1") {
								$("#loading").hide();
								userCount=data.data.userCount!=null?data.data.userCount:0;
								userGoods=data.data.userGoods!=null?data.data.userGoods:0;
								//-----
								userCompany=data.data.userCompany!=null?data.data.userCompany:0;
								userCar=data.data.userCar!=null?data.data.userCar:0;
								carCount=data.data.carCount!=null?data.data.carCount:0;
								bidCount=data.data.bidCount!=null?data.data.bidCount:0;
								orderCount=data.data.orderCount!=null?data.data.orderCount:0;
								///-------
								REGISTERMEMBERCOUNT=data.data.REGISTERMEMBERCOUNT!=null?data.data.REGISTERMEMBERCOUNT:0;
								CERTIFIEDMEMBERCOUNT=data.data.CERTIFIEDMEMBERCOUNT!=null?data.data.CERTIFIEDMEMBERCOUNT:0;
								CERTIFIEDCARCOUNT=data.data.CERTIFIEDCARCOUNT!=null?data.data.CERTIFIEDCARCOUNT:0;
								CARCOUNT=data.data.CARCOUNT!=null?data.data.CARCOUNT:0;
								ONLINECARCOUNT=data.data.ONLINECARCOUNT!=null?data.data.ONLINECARCOUNT:0;
								GOODSCOUNT=data.data.GOODSCOUNT!=null?data.data.GOODSCOUNT:0;
								LINESCOUNT=data.data.LINESCOUNT!=null?data.data.LINESCOUNT:0;
								BIDCOUNT=data.data.BIDCOUNT!=null?data.data.BIDCOUNT:0;
								BIDFINISHCOUNT=data.data.BIDFINISHCOUNT!=null?data.data.BIDFINISHCOUNT:0;
								ORDERCOUNT=data.data.ORDERCOUNT!=null?data.data.ORDERCOUNT:0;
								ORDERFINISHCOUNT=data.data.ORDERFINISHCOUNT!=null?data.data.ORDERFINISHCOUNT:0;
								goodsCount=data.data.goodsCount!=null?data.data.goodsCount:0;
								var legendData = [ '总会员数:' + userCount, '货主:'+userGoods,'车主:'+userCar,'企业:'+userCompany ];
											initChart('mainMember', '会员信息', '', legendData, 
													[ 
													  { value : legendData[1].split(':')[1], name : legendData[1]},
													  { value : legendData[2].split(':')[1], name : legendData[2]},
													  { value : legendData[3].split(':')[1], name : legendData[3]}
													  ]);
											/* var legendData = [ '总会员数:' + userCount,'注册会员:' + REGISTERMEMBERCOUNT,
																'认证册会员:' + CERTIFIEDMEMBERCOUNT,'总货主:'+userGoods,'总车主:'+userCar,'总企业:'+userCompany ];
														initChart('mainMember', '会员信息', '', legendData, 
																[ {	value : legendData[0].split(':')[1], name : legendData[0]}, 
																  { value : legendData[1].split(':')[1], name : legendData[1]},
																  { value : legendData[2].split(':')[1], name : legendData[2]},
																  { value : legendData[3].split(':')[1], name : legendData[3]},
																  { value : legendData[4].split(':')[1], name : legendData[4]},
																  { value : legendData[5].split(':')[1], name : legendData[5]}
																  ]); */
								var legendData = [ '订单数:' + orderCount,'招标数:'+bidCount,
													'车辆数:' + carCount,'货源数:'+goodsCount];
											initChart('mainWlptInfo', '平台概况', '', legendData, 
													[ {	value : legendData[0].split(':')[1], name : legendData[0]}, 
													  { value : legendData[1].split(':')[1], name : legendData[1]},
													  { value : legendData[2].split(':')[1], name : legendData[2]},
													  { value : legendData[3].split(':')[1], name : legendData[3]}
													  ]);
								var legendData = [ '注册会员数:' + REGISTERMEMBERCOUNT,'订单数:' + ORDERCOUNT,'招标数:'+BIDCOUNT,
													'车辆数:' + CARCOUNT,'货源数:'+GOODSCOUNT];
											initChart('mainWlptDayInfo', '每日概况', '', legendData, 
													[ {	value : legendData[0].split(':')[1], name : legendData[0]}, 
													  { value : legendData[1].split(':')[1], name : legendData[1]},
													  { value : legendData[2].split(':')[1], name : legendData[2]},
													  { value : legendData[3].split(':')[1], name : legendData[3]},
													  { value : legendData[4].split(':')[1], name : legendData[4]}
													  ]);
											/* var legendData = [ '招标总数:' + bidCount,
													'招标:' + BIDCOUNT,
													'竞价招标:' + BIDFINISHCOUNT ];
											initChart("mainBidInfo", "招标信息", '', legendData, [ {
												value : legendData[0].split(':')[1],
												name : legendData[0]
											}, {
												value : legendData[1].split(':')[1],
												name : legendData[1]
											}, {
												value : legendData[2].split(':')[1],
												name : legendData[2]
											} ]);
											var legendData = [ '货源总数:' +goodsCount,
													'货源:' + GOODSCOUNT ];
											initChart("mainGoodsInfo", "货源信息", '', legendData, [ {
												value : legendData[0].split(':')[1],
												name : legendData[0]
											}, {
												value : legendData[1].split(':')[1],
												name : legendData[1]
											} ]);
											var legendData = [ '车辆总数:' + carCount,
													'车辆:' + CARCOUNT,
													'认证车辆:' + CERTIFIEDCARCOUNT,
													'在线车辆:' + ONLINECARCOUNT ];
											initChart("mainCarInfo", "车源信息", '', legendData, [ {
												value : legendData[0].split(':')[1],
												name : legendData[0]
											}, {
												value : legendData[1].split(':')[1],
												name : legendData[1]
											}, {
												value : legendData[2].split(':')[1],
												name : legendData[2]
											}, {
												value : legendData[3].split(':')[1],
												name : legendData[3]
											}]);
											var legendData = [ '运单总数:' + orderCount,
													'运单:' + ORDERCOUNT,
													'交易完成:' + ORDERFINISHCOUNT ];
											initChart("mainOrderInfo", "订单信息", '', legendData, [ {
												value : legendData[0].split(':')[1],
												name : legendData[0]
											}, {
												value : legendData[1].split(':')[1],
												name : legendData[1]
											}, {
												value : legendData[2].split(':')[1],
												name : legendData[2]
											} ]); */
							}
							}
					});
			
		});
	</script>
</body>
</html>
