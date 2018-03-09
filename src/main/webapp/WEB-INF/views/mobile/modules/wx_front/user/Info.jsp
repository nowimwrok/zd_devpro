<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>统计</title>

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
.split{
	height:20px;width:100%;
	clear:both;
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
	<div id="content" class="div_box">
		<div class="data_div">
			<div class="data_title">每日情况</div>
			<div id="mainMember" style="height:300px;width:100%;margin:0 auto;"></div>
			<div class="split"></div>
			<div id="mainLogisticsInfo"  style="height:300px;width:100%;margin:0 auto;"></div> 
			<div id="mainOrderInfo"  style="height:300px;width:100%;margin:0 auto;"></div> 
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
			var legendData=['总会员数:','本周注册会员数:']; 
	    	initChart('mainMember','会员信息','',legendData,[
	    	                                         	                {value:legendData[0].split(':')[1], name:legendData[0]},
	    	                                        	                {value:legendData[1].split(':')[1], name:legendData[1]}
	    	                                         	                                                      	            ]);
	    var	legendData=['车辆数:','货源数:']; 
	    	initChart("mainLogisticsInfo","物流信息",'',legendData,[
	    	                                         	                {value:legendData[0].split(':')[1], name:legendData[0]},
	    	                                        	                {value:legendData[1].split(':')[1], name:legendData[1]}	    	                                        	              
	    	                                        	            ]);
	    	 var	legendData=['运单总数:'+100,'今日交易:'+20]; 
		    	initChart("mainOrderInfo","订单信息",'',legendData,[
		    	                                         	                {value:legendData[0].split(':')[1], name:legendData[0]},
		    	                                        	                {value:legendData[1].split(':')[1], name:legendData[1]}	    	                                        	              
		    	                                        	            ]);
		});
	</script>
</body>
</html>
