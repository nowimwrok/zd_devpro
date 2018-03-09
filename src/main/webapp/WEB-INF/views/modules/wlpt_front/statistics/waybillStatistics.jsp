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
	href="${ctxStatic}/modules/wlpt/front/css/analysis/global.css" />
<title>运单统计</title>
<style type="text/css">
.search_btn {
	width: 80px;
	background-color: #073190;
	color: white;
	border: 1px solid #073190;
}
.form-control {
            border-bottom: 1px solid #ccc !important;
        }
</style>
</head>
<body>
	<div>

		

		<div class="col-lg-12 data-model waybill-modal">
			
			<div class="col-sm-2 col-md-2 col-lg-2 clearfix">
				<div class="col-lg-12 data-class bg_blue clearfix">
					<p class="data-title text-left">待确认</p> 
					<h2 class="data-num text-center">${empty tradetype.nieordermoney ?'0.00':tradetype.nieordermoney}</h2>
				</div>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 clearfix">
				<div class="col-lg-12 data-class bg_light_green  clearfix">
					<p class="text-left data-title">待提货</p> 
					<h2 class="text-center data-num">${empty tradetype.newordermoney ?'0.00':tradetype.newordermoney}</h2>
				</div>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 clearfix">
				<div class="col-lg-12 data-class bg_orange clearfix">
					<p class="text-left data-title">待卸货</p> 
					<h2 class="text-center data-num" >${empty tradetype.getgdordermoney ?'0.00':tradetype.getgdordermoney}</h2>
				</div>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 clearfix">
				<div class="col-lg-12 data-class bg_red clearfix">
					<p class="text-left data-title">待结算</p> 
					<h2 class="text-center data-num">${empty tradetype.upordermoney ?'0.00':tradetype.upordermoney}</h2>
				</div>
			</div>
			<div class="col-sm-2 col-md-2 col-lg-2 clearfix">
				<div class="col-lg-12 data-class bg_yellow clearfix">
					<p class="text-left data-title">累计运量(吨)</p> 
					<h2 class="text-center data-num" id="allweight">${empty tradetype.allweight ?'0.000':tradetype.allweight}</h2>
				</div>
			</div>
			
		</div>
		
		
		<div class="portlet">
					   <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-line-chart"></i>平台运单统计表
                            </div>
                            <div class="actions">
                                <div class="btn-group" data-toggle="buttons">
                                    <label class="btn btn-default btn-sm active" onclick="changeType(1)">
                                        <input type="radio" name="options" class="toggle">货源统计 </label>
                                    <label class="btn btn-default btn-sm" onclick="changeType(2)">
                                        <input type="radio" name="options" class="toggle">运单统计 
                                        </label>
                               
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
							<div class="clearfix" style="height: 450px;">
								<div style="width: 100%; height: 100%;">
									<div id="moduleTypediv" class="echart-content" style=""></div>
								</div>
							</div>
                        </div>
         </div>
		
		
		
		

		

	</div>
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctxStatic}/echarts/echarts.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/echarts/echarts-all.js"></script>
	<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
	<script
		src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>

	<script type="text/javascript">
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
		allweightset()
		function allweightset(){
			var allweight = fomatPrice('${tradetype.allweight}');
			$("#allweight").html(allweight*1);
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
			
			//运单
			var nieorderVar = [];
			var neworderVar = [];
			var cancelorderVar = [];
			var getgdorderVar = [];
			var uporderVar = [];
			var payorderVar = [];
			
			//货源
			var singleVar = [];
			var quoteVar = [];
			var invalidVar = [];
			//hyuan
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
					title = ['已	建单','已报价','已失效'];
				}else if(type*1==2){
					title = ['新建单','待提货','取消','已提货','待支付','已支付'];
				}
				$.ajax({
	                type: "POST",
	                url: '${wlpt}/wlpt/statistics/getOrderCount',
	                dataType: 'json',
	                data: {type: type,beginDate:$("#beginCreateDate").val(),endDate:$("#endCreateDate").val()},
	                cache: false,
	                success: function (data) {
	                	datetitle = [];
	                	//运单
	        			nieorderVar = [];
	        			neworderVar = [];
	        			cancelorderVar = [];
	        			getgdorderVar = [];
	        			uporderVar = [];
	        			payorderVar = [];
	        			
	        			//货源
	        			singleVar = [];
	        			quoteVar = [];
	        			invalidVar = [];
	                	for (var i = 0; i < data.data.varList.length; i++) {
	                		
	                        var nowdata = data.data.varList[i];//当钱数据对象
	                        datetitle.push(nowdata.cretime);
	                        if(type*1==1){
	                        	singleVar.push(nowdata.singleweight);//已经建单
	                        	quoteVar.push(nowdata.quoteweight); //已经报价吨数
	                        	invalidVar.push(nowdata.invalidweight);//失效吨数
	                        }else{
	                        	nieorderVar.push(nowdata.nieordermoney);//新建单
	    	        			neworderVar.push(nowdata.newordermoney);//待提货
	    	        			cancelorderVar.push(nowdata.cancelordermoney);//取消运单
	    	        			getgdorderVar.push(nowdata.getgdordermoney);//已提货
	    	        			uporderVar.push(nowdata.upordermoney);//待支付
	    	        			payorderVar.push(nowdata.payordermoney);//已支付
	                        }
                        }
	                	if(type*1==1){
	                		setgoodsoption();
	                	}else{
	                		setorderoption();
	                	}
                	}
                })
				
			}

			function setgoodsoption() {
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
                        x : 'left'
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : {
						type : 'value'
					},
					yAxis : {
						type : 'category',
						data : datetitle
					},
					series : [ {
						name : title[0],
						type : 'bar',
						data : singleVar
					}, {
						name : title[1],
						type : 'bar',
						data : quoteVar
					}, {
						name : title[2],
						type : 'bar',
						data : invalidVar
					} ]
				};
				myChart.setOption(option);
			}
			
			function setorderoption() {
				myChart.clear();
				option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					legend : {
						data : title
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : {
						type : 'value'
					},
					yAxis : {
						type : 'category',
						data : datetitle
					},
					series : [ {
						name : title[0],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : nieorderVar
					},{
						name : title[1],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : neworderVar
					}, {
						name : title[2],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : cancelorderVar
					}, {
						name : title[3],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : getgdorderVar
					},{
						name : title[4],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : uporderVar
					},{
						name : title[5],
						type : 'bar',
						stack : '运量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : payorderVar
					} ]
				};
				myChart.setOption(option);
			}

		});
	</script>
</body>
</html>
