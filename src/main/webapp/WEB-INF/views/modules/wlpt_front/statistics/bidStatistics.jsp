<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
<link rel="stylesheet"
	href="/static/modules/wlpt/front/css/analysis/global.css" />
<style type="text/css">
	.form-control {
            border-bottom: 1px solid #ccc !important;
        }
</style>
<title>招投标统计</title>
</head>
<body>
	<div>

		<div class="col-lg-12 data-model">
			<div class="col-sm-4 col-lg-4 col-md-4 col-xs-12 clearfix">
				<div class="col-sm-12 col-lg-10 data-class col-md-12 col-xs-12 bg_red clearfix">
					<p class="data-title text-left">累计运输合同</p> 
					<h2 class="data-num text-center">${empty business.settlecount ?'0':business.settlecount*1}</h2>
				</div>
			</div>
			<div class="col-sm-4 col-lg-4 col-md-4 col-xs-12 clearfix">
				<div class="col-sm-12 col-lg-10 col-md-12 col-xs-12 data-class bg_orange clearfix">
					<p class="data-title text-left">累计金额(元)</p> 
					<h2 class="data-num text-center" id="settlemoney">${empty business.settlemoney ?'0.00':business.settlemoney*1}</h2>
				</div>
			</div>
			<div class="col-sm-4 col-lg-4 col-md-4 col-xs-12 clearfix">
				<div class="col-sm-12 col-lg-10 col-md-12 col-xs-12 data-class bg_deep_greeen clearfix">
					<p class="data-title text-left">累计重量(吨)</p> 
					<h2 class="data-num text-center" id="settleweight">${empty business.settleweight ?'0.000':business.settleweight*1}</h2>
				</div>
			</div>
		</div>
		
		<div class="portlet">
					  <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-line-chart"></i>平台招投标统计表
                            </div>
                            <div class="actions">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-default btn-sm active" onclick="changeType(1)">
                                        <input type="radio" name="options" class="toggle">招标统计 </label>
                                    <label class="btn btn-default btn-sm" onclick="changeType(2)">
                                        <input type="radio" name="options" class="toggle">竞标统计 </label>
                                    <label class="btn btn-default btn-sm" onclick="changeType(3)">
                                        <input type="radio" name="options" class="toggle">运输合同统计  </label>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body clearfix">
                        	<div class="col-lg-6 pull-right clearfix mt-10 mb-10">
								<div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
									<input type="text" readonly="readonly" class="border-bot form-control"
										name="beginCreateDate" id="beginCreateDate" style="border-bottom: 1px solid #5c5c5c"
										placeholder="选择开始时间"
										onclick="WdatePicker({dateFmt:'yyyy-MM'})">
								</div>
								<div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
									<input type="text" readonly="readonly" class="border-bot form-control"
										name="endCreateDate" id="endCreateDate" style="border-bottom: 1px solid #5c5c5c"
										placeholder="选择结束时间"
										onclick="WdatePicker({dateFmt:'yyyy-MM'})">
								</div>
								<div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
									<input type="button" class="btn btn-primary" value="搜 索"
										onclick="search()" />
								</div>
							</div>
							<div class="col-lg-12" style="height: 400px;">
								<div style="width: 100%; height: 100%;">
									<div id="moduleTypediv" class="echart-content" style=""></div>
								</div>
							</div>
                        </div>
		</div>
		
		
		
		<!-- <div class="col-lg-12" style="margin: 20px 0;">
			<div class="btn-group pull-left tab_button">
				<button class="btn btn-default btn-nobg-radius btn-active" onclick="changeType(1)">招标统计</button>
				<button class="btn btn-nobg-radius btn-default" onclick="changeType(2)">竞标统计</button>
				<button class="btn btn-nobg-radius btn-default" onclick="changeType(3)">运输合同统计</button>
				<input type="hidden" id = "type" value ="1" />
			</div>
			
		</div>
		<div class="col-lg-12"></div> -->

		

	</div>
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/echarts/echarts.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/echarts/echarts-all.js"></script>
	<script
		src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript">
		function fomatFloat(src, pos) {
			return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);

		}
		//weightset();
		function weightset(){
			var settleweight = fomatPrice('${business.settleweight}');
			var settlemoney = fomatPrice('${business.settlemoney}');
			$("#settleweight").html(settleweight*1);
			$("#settlemoney").html(settlemoney*1);
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

		function fomatNum() {
			var CREATETOTALCOST = $("#CREATETOTALCOST").html();
			var STAYPAYTOTALCOST = $("#STAYPAYTOTALCOST").html();
			$("#CREATETOTALCOST").html(
					fomatPrice(CREATETOTALCOST > 0 ? CREATETOTALCOST : "0"));
			$("#STAYPAYTOTALCOST").html(
					fomatPrice(STAYPAYTOTALCOST > 0 ? STAYPAYTOTALCOST : "0"));
			if (STAYPAYTOTALCOST == '0') {
				$("#CREATETOTALCOST").html("0.0");
			}
			if (STAYPAYTOTALCOST == '0') {
				$("#STAYPAYTOTALCOST").html("0.0");
			}
		}
	</script>

	<script type="text/javascript">
		$(function() {
			var dom = document.getElementById("moduleTypediv");
			var myChart = echarts.init(dom);
			var title = [];
			var datetitle = [];
			var dataVar1 = [];
			var dataVar2 = [];
			var dataVar3 = [];
			var TOTALCOUNT = 0;//
			var type = 1;
			window.changeType = function(thisType) {
				type = thisType;
				geroleCount();
			}

			window.search = function() {
				geroleCount();
			}

			geroleCount();
			function geroleCount() {
				if(type*1==1){
					title = ['招标数量','招标总金额','招标总吨位'];
				}else if(type*1==2){
					title = ['竞标数量','竞标总价','竞标总吨位'];
				}else if(type*1==3){
					title = ['合同单数','合同总金额','合同总吨位'];
				}
				$.ajax({
	                type: "POST",
	                url: '${wlpt}/wlpt/statistics/getbidCount',
	                dataType: 'json',
	                data: {type: type,beginDate:$("#beginCreateDate").val(),endDate:$("#endCreateDate").val()},
	                cache: false,
	                success: function (data) {
	                	datetitle = [];
            			dataVar1 = [];
            			dataVar2 = [];
            			dataVar3 = [];
	                	for (var i = 0; i < data.data.varList.length; i++) {
	                		
	                        var nowdata = data.data.varList[i];//当钱数据对象
	                        datetitle.push(nowdata.cretime);
	                        if(type*1==1){
	                        	dataVar1.push(nowdata.bidcount);// 招标数量
	                        	dataVar2.push(nowdata.bidprice);// 招标总金额
	                        	dataVar3.push(nowdata.bidweight);// 招标总吨位
	                        }else if(type*1==2){
	                        	dataVar1.push(nowdata.biddingpcount);// 竞标数量
	                        	dataVar2.push(nowdata.biddingprice);// 竞标总金额
	                        	dataVar3.push(nowdata.biddingweight);//竞标总吨位
	                        }else if(type*1==3){
	                        	dataVar1.push(nowdata.settlecount);// 合同单数
	                        	dataVar2.push(nowdata.settlemoney);// 合同总金额
	                        	dataVar3.push(nowdata.settleweight);// 合同总吨位
	                        }
	                	}
	                	setoption();
	                }
	            })
				
			}

			function setoption() {
				myChart.clear();
				option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					
					legend : {
						data : title,
						left:'0px',
                        x : 'left'
					},
					grid : {
						left : '0%',
						right : '0%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : [ {
						type : 'category',
						data : datetitle
					} ],
					yAxis : [ {
						type : 'value'
					} ],
					series : [ {
						name : title[0],
						type : 'bar',
						data : dataVar1
					}, {
						name : title[1],
						type : 'bar',
						data : dataVar2
					}, {
						name : title[2],
						type : 'bar',
						data : dataVar3
					}]
				};

				myChart.setOption(option);
			}

		})

	</script>
</body>
</html>
