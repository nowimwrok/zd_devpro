<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="${ctxStatic }/modules/wlpt/front/css/analysis/global.css" />
<style type="text/css">
#carTypediv, #monthdiv {
	float: left;
	height: 450px;
}

.contentdiv {
	width: 100%;
	height: 100%;
}

.bodydiv {
	width: 100%;
	height: 400px;
}

.bodyLeftdiv {
	width: 50%;
	float: left;
	height: 400px;
}

.bodyLeftdivtop {
	width: 100%;
	height: 100px;
}

.bodyLeftdivtopc {
	width: 100%;
	height: 30px;
	padding: 35px 0px;
}

.bodyLeftdivtop1 {
	float: left;
	width: 32%;
}

.bodyLeftdivtop2 {
	float: left;
	width: 6%;
}

.bodyLeftdivtop3 {
	float: left;
	width: 18%;
	font-size: 18px;
}

.bodyLeftdivtop4 {
	float: left;
	width: 6%;
}

.bodyLeftdivtop5 {
	float: left;
	width: 32%;
}

.bodyLeftdivtopborder {
	width: 60%;
	border-bottom: 1px dashed #EBEBEB;
	padding-top: 11px;
}

.bodyLeftdivbtm {
	height: 300px;
	width: 100%;
	font-family: "微软雅黑" !important;
	font-size:14px;
}

.bodyLeftdivbtmc {
	height: 250px;
	width: 100%
}

.bodyLeftdivbtm1 {
	height: 75px;
	width: 100%;
}

.bodyLeftdivbtm2 {
	height: 50px;
	width: 100%
}

.bodyLeftdivbtm3 {
	height: 100px;
	width: 100%
}

.bodyLeftdivbtmdiv {
	height: 75px;
	width: 50%;
	float: left;
}

.bodyLeftdivbtmdivLeft {
	width: 20%;
	float: left;
}

.bodyLeftdivbtmdivRight {
	width: 80%;
	float: left;
}

.bodyLeftdivbtmdivRightTop {
	width: 40%;
	float: left;
}

.bodyLeftdivbtmdivRightBtm {
	width: 60%;
	float: left;
	height: 75px;
	line-height: 75px;
	font-size: 18px;
	color: blue;
}

.bodyLeftdivbtmdivRightBtmDiv {
	width: 100%;
	height: 33%;
}

.bodyLeftdivbtmdivRightTopLeft {
	width: 100%;
	height: 80%;
}

.bodyLeftdivbtmdivRightTopRight {
	width: 100%;
	height: 25px;
}

.bodyLeftdivbtmdivRightTopImg {
	width: 50px;
	height: 56px;
}

.bodyLeftdivbtmdivRightTopFont {
	padding-left: 5px;
	font-size: 14px;
}
.bodyRightdiv{
width: 50%; float: left; height: 400px;
}
.bodyRightdivTop{
width: 100%; height: 10%; float: left;
}
.bodyRightdivCen{
width: 100%; height: 80%; float: left;
}
.bodyRightdivBtm{
width: 100%; height: 10%; float: left;
color: rgb(51, 187, 255); font-size: 15px;cursor: pointer;
text-align: center;
font-family: "微软雅黑" !important;
}

</style>
</head>
<body>

	<div class="contentdiv">
		<div class="bodydiv">
			<div class="bodyLeftdiv">
				<div class="bodyLeftdivtop">
					<div class="bodyLeftdivtopc">
						<div class="bodyLeftdivtop1">
							<div class="bodyLeftdivtopborder" style="margin-left: 40%;"></div>
						</div>
						<div class="bodyLeftdivtop2">
							<img style="width: 25px;" class="" alt=""
								src="${ctxStatic}/images/wlptfront/img_location_start_point.png" />
						</div>
						<div class="bodyLeftdivtop3">财务概览</div>
						<div class="bodyLeftdivtop4">
							<img style="width: 25px;" class="" alt=""
								src="${ctxStatic}/images/wlptfront/img_location_end_point.png" />
						</div>
						<div class="bodyLeftdivtop5">
							<div class="bodyLeftdivtopborder"></div>
						</div>
					</div>
				</div>
				<div class="bodyLeftdivbtm">
					<div class="bodyLeftdivbtmc">
						<div class="bodyLeftdivbtm1">
							<div class="bodyLeftdivbtmdiv">
								<div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
								<div class="bodyLeftdivbtmdivRight">
									<div class="bodyLeftdivbtmdivRightTop">
										<div class="bodyLeftdivbtmdivRightTopLeft">
											<img class="bodyLeftdivbtmdivRightTopImg" alt=""
												src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo8.png" />
										</div>
										<div class="bodyLeftdivbtmdivRightTopRight">
											<span class="bodyLeftdivbtmdivRightTopFont">已入账</span>
										</div>
									</div>
									<div class="bodyLeftdivbtmdivRightBtm">
										<div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="ENDTOTALCOST" title=""><fmt:parseNumber
													type="number" value="0"></fmt:parseNumber></span>元
										</div>
									</div>
								</div>
							</div>
							<div class="bodyLeftdivbtmdiv">
								<div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
								<div class="bodyLeftdivbtmdivRight">
									<div class="bodyLeftdivbtmdivRightTop">
										<div class="bodyLeftdivbtmdivRightTopLeft">
											<img class="bodyLeftdivbtmdivRightTopImg" alt=""
												src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo6.png" />
										</div>
										<div class="bodyLeftdivbtmdivRightTopRight">
											<span class="bodyLeftdivbtmdivRightTopFont">应&nbsp;收</span>
										</div>
									</div>
									<div class="bodyLeftdivbtmdivRightBtm">
										<div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="CREATETOTALCOST" title=""><fmt:parseNumber
													type="number" value="0"></fmt:parseNumber></span>元
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="bodyLeftdivbtm2"></div>
						<div class="bodyLeftdivbtm1">
							<div class="bodyLeftdivbtmdiv">
								<div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
								<div class="bodyLeftdivbtmdivRight">
									<div class="bodyLeftdivbtmdivRightTop">
										<div class="bodyLeftdivbtmdivRightTopLeft">
											<img class="bodyLeftdivbtmdivRightTopImg" alt=""
												src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo2.png" />
										</div>
										<div class="bodyLeftdivbtmdivRightTopRight">
											<span class="bodyLeftdivbtmdivRightTopFont">已结算</span>
										</div>
									</div>
									<div class="bodyLeftdivbtmdivRightBtm">
										<div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="OUTLAYTOTALCOST" title=""><fmt:parseNumber
													type="number" value="0"></fmt:parseNumber></span>元
										</div>
									</div>
								</div>
							</div>
							<div class="bodyLeftdivbtmdiv">
								<div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
								<div class="bodyLeftdivbtmdivRight">
									<div class="bodyLeftdivbtmdivRightTop">
										<div class="bodyLeftdivbtmdivRightTopLeft">
											<img class="bodyLeftdivbtmdivRightTopImg" alt=""
												src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo5.png" />
										</div>
										<div class="bodyLeftdivbtmdivRightTopRight">
											<span class="bodyLeftdivbtmdivRightTopFont">待结算</span>
										</div>
									</div>
									<div class="bodyLeftdivbtmdivRightBtm">
										<div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="STAYPAYTOTALCOST" title=""><fmt:parseNumber
													type="number" value="0"></fmt:parseNumber></span>元
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="bodyLeftdivbtm3"></div>
					</div>
				</div>

			</div>
			<div class="bodyRightdiv">
				<div class="bodyRightdivTop"></div>
				<%-- <div style="width:100%;height:20%;float:left;">
                <img style="" class="" alt=""
                     src="${pageContext.request.contextPath}/static/images/wlpt/images/persionlogo/persiontop.png" />
            </div>
            <div style="width:100%;height:10%;float:left;text-align:center;">
							<span>您的业务在平台排在<span style="color:orange;">22.25%</span>的人之前,加油哦!
							</span>
            </div> --%>
				<div class="bodyRightdivCen">
					<div id="orderAnalysis" style="width: 100%; height: 320px;"></div>
				</div>
				<div class="bodyRightdivBtm">
					<span title="点击查看详细的财务报表"><a
						onclick="showrecord()">查看详细财务报表</a></span>
				</div>
			</div>
		</div>
	</div>

	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<%--<script type="text/javascript" src="/static/echart/echarts.min.js"></script>--%>
	<script type="text/javascript"
		src="${ctxStatic }/echarts/echarts-all.js"></script>
	<script type="text/javascript">
		$(function() {

			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/getOrderinfoSum',
				dataType : 'json',
				data : {},
				cache : false,
				success : function(data) {
					if (data.state == 1) {
						$("#OUTLAYTOTALCOST").html(data.endOrder.sumtotalcost);
						$("#STAYPAYTOTALCOST").html(
								data.nopaymentOrder.sumtotalcost);
						fomatNum();
					}
				}
			});

			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/getBidOrderinfoSum',
				dataType : 'json',
				data : {},
				cache : false,
				success : function(data) {
					if (data.state == 1) {
						$("#ENDTOTALCOST").html(
								data.bidOrderEnd.sumcontracttotal);
						$("#CREATETOTALCOST").html(
								data.bidOrderNo.sumcontracttotal);
						fomatNum();
					}
				}
			});

			var orderdom = document.getElementById("orderAnalysis");
			var myChart = echarts.init(orderdom);
			var date = [];
			var everCount = [];
			var neworder = [];///待支出
			var allneworder = 0;
			var trading = [];///已支出
			var alltrading = 0;
			var waitingpay = [];///应收入
			var allwaitingpay = 0;
			var payorder = [];//
			var allpayorder = 0;//已入账
			var timeTicket = new Object();
			var timeflag = "%Y-%m-%d";
			var showtime = "%Y-%m-%d";
			var title = [ '待支出', '已支出', '应收入', '已入账' ];
			getOrderCount(timeflag);
			function getOrderCount(timeflag) {
				date = [];
				neworder = [];///新运单
				trading = [];///运输中
				waitingpay = [];///待支付
				payorder = [];//已支付
				$.ajax({
					type : "POST",
					url : '${wlpt}/wlpt/trade/getEverData',
					dataType : 'json',
					data : {
						"timeflag": timeflag,
						"showtime": showtime
					},
					cache : false,
					success : function(data) {
						var tradeingval = 0;///运输中的值
						for ( var i = 0; i < data.data.length; i++) {
							var nowdata = data.data[i].orderInfoVo;//当钱数据对象
							if (timeflag == 'everyWeek') {
								date.push(nowdata.showtime + '第'
										+ nowdata.timeflag + '周');
							} else {
								date.push(nowdata.showtime);
							}

							neworder.push({
								name: "运单" + nowdata.newodfreight,
								value: xround(
										nowdata.newodfreight * 1, 2)
							});///运输中
							trading.push({
								name: "运单" + nowdata.tradingodfreight,
								value: xround(nowdata.tradingodfreight * 1, 2)
							});

							waitingpay.push({
								name: "运单" + nowdata.waitpayodfreight,
								value: xround(
										nowdata.waitpayodfreight * 1, 2)
							}); //待支付
							payorder.push({
								name: "运单" + nowdata.endodfreight,
								value: xround(
										nowdata.endodfreight * 1, 2)
							});//已支付
						}
						optionFun(neworder, trading, waitingpay, payorder);
					}
				});
			}
			function xround(x, num) {
				return Math.round(x * Math.pow(10, num)) / Math.pow(10, num);
			}
			function optionFun(neworder, trading, waitingpay, payorder) {
				option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : {
							type : 'shadow'
						}
					},
					legend : {
						data : title,
						selectedMode : 'single',
						selected : {
							'已支出' : false,
							'应收入' : false,
							'已入账' : false
						}
					},
					toolbox : {
						show : false,
						y : 'center',
						feature : {
							mark : {
								show : true
							},
							magicType : {
								show : true,
								type : [ 'line', 'bar', 'stack', 'tiled' ]
							},
							restore : {
								show : true
							},
							saveAsImage : {
								show : true
							}
						}
					},
					calculable : true,
					xAxis : [ {
						type : 'category',
						boundaryGap : false,
						data : date
					} ],
					yAxis : [ {
						name : "单位:千元",
						type : 'value',
						splitNumber : 5,
						scale : false
					} ],
					dataZoom : {
						show : false,
						realtime : true,
						start : 0,
						end : 100
					},
					grid : {
						x2 : 40
					},
					series : [ {
						name : title[0],
						type : 'line',
						data : neworder
					}, {
						name : title[1],
						type : 'line',
						data : trading
					}, {
						name : title[2],
						type : 'line',
						data : waitingpay
					}, {
						name : title[3],
						type : 'line',
						data : payorder
					} ]
				};
				myChart.clear();
				var lastIndex = 0;
				var len = option.series[0].data.length;
				clearInterval(timeTicket);
				timeTicket = setInterval(function() {
					// 动态数据接口 addData
					lastIndex += 1;
					myChart.addData([ [ 0, // 系列索引
					option.series[0].data[lastIndex % len], // 新增数据
					false, // 新增数据是否从队列头部插入
					false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					option.xAxis[0].data[lastIndex % len] ], [ 1, // 系列索引
					option.series[1].data[lastIndex % len], // 新增数据
					false, // 新增数据是否从队列头部插入
					false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					option.xAxis[0].data[lastIndex % len] ], [ 2, // 系列索引
					option.series[2].data[lastIndex % len], // 新增数据
					false, // 新增数据是否从队列头部插入
					false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					option.xAxis[0].data[lastIndex % len] ], [ 3, // 系列索引
					option.series[3].data[lastIndex % len], // 新增数据
					false, // 新增数据是否从队列头部插入
					false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
					option.xAxis[0].data[lastIndex % len] ] ]);
				}, 2000);
				myChart.setOption(option);
				setTimeout(function() {
					window.onresize = function() {
						myChart.resize();
					};
				}, 200);
			}

			window.showrecord = function() {
				$("#financial_info", window.parent.document).show();
				if ($("#financialrval", window.parent.document).val() == "0") {
					$("#mainFrame", window.parent.parent.document).height(
							$("#mainFrame", window.parent.parent.document)
									.height() + 650);
					$("#financialrval", window.parent.document).val(1);
				}

			};

			function fomatFloat(src, pos) {
				return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);

			}
			function fomatPrice(price) {
				if (price * 1 >= 100000) {
					var p = price / 10000;
					p = p.toString();
					var index = p.indexOf(".", 0);
					index = index >= 0 ? index : p.length;
					index += 2;
					index = index < p.length ? index : p.length;
					price = "" + p.substring(0, index) + "万";
				} else {
					price = fomatFloat(price, 4);
				}
				return price;
			}

			function fomatNum(){
				var ENDTOTALCOST = $("#ENDTOTALCOST").html();
				var CREATETOTALCOST = $("#CREATETOTALCOST").html();
				var OUTLAYTOTALCOST = $("#OUTLAYTOTALCOST").html();
				var STAYPAYTOTALCOST = $("#STAYPAYTOTALCOST").html();
				$("#ENDTOTALCOST").html(
						fomatPrice(ENDTOTALCOST > 0 ? ENDTOTALCOST : 0));
				$("#CREATETOTALCOST").html(
						fomatPrice(CREATETOTALCOST > 0 ? CREATETOTALCOST : 0));
				$("#OUTLAYTOTALCOST").html(
						fomatPrice(OUTLAYTOTALCOST > 0 ? OUTLAYTOTALCOST : 0));
				$("#STAYPAYTOTALCOST").html(
						fomatPrice(STAYPAYTOTALCOST > 0 ? STAYPAYTOTALCOST : 0));
			}
			
		});
	</script>
</body>
</html>

