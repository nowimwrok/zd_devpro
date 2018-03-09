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
	<link rel="stylesheet" href="${ctxStatic}/front/css/daterangepicker.css" />
<title>运单统计</title>
<style type="text/css">
	.refort_guide_select{
		background-color: #666 !important;
		color: #fff !important;
	}
</style>
</head>
<body>
<div class="row" style="background-color:#fff;">
	<div class="col-lg-12" style="background-color:#fff;">
		<div class="col-sm-12 clearfix data_fx data_bid data_waybill">
			<!--招标分析-->
			<div class="col-sm-6 finance parent_line">
				<div class="col-sm-12" style="padding:0;">
					<div class="col-sm-12 clearfix" style="padding:0;">
						<div class="pull-left">
							<h4 class="title">运单分析</h4>
							<h5>支出业务报表分析</h5>
						</div>
						<div class="pull-right form-group data_time data_time_left" style="margin-top:18px;">
							<input type="text" class="data_input">
							<input type="hidden" id="left_str">
							<input type="hidden" id="left_end">
							<span class="caret"></span>
						</div>
					</div>

					<div class="col-sm-12 income_line"></div>
					<!--统计-->
					<div class="col-sm-12 count" style="height:96px;">
						<div class="col-sm-4 text-center" >
							<h3 id="ysz_count">0</h3>
							<h5>运输中</h5>
						</div>
						<div class="col-sm-4 count_detail">
							<div class="col-sm-12" style="border-bottom:1px solid #dbdbdb;"  id="order_status_1">
								<h2 class="pull-left text-success">0</h2>
								<h4 class="pull-right">已提货</h4>
							</div>
							<div class="col-sm-12" id="order_status_2">
								<h2 class="pull-left text-danger">0</h2>
								<h4 class="pull-right">已卸货</h4>
							</div>
						</div>
						<div class="col-sm-4 count_detail" style="padding-left:0;">
							<div class="col-sm-12" style="border-bottom:1px solid #dbdbdb;"  id="order_status_3">
								<h2 class="pull-left text-primary">0</h2>
								<h4 class="pull-right">新运单</h4>
							</div>
							<div class="col-sm-12"  id="order_status_4">
								<h2 class="pull-left text-warning">0</h2>
								<h4 class="pull-right">争议中</h4>
							</div>
						</div>
						<div class="data_bid_line"></div>
					</div>
					<!--线-->
					<div class="col-sm-10 col-lg-offset-1" style="margin-top:15px;">
						<div class="col-sm-12 income_line"></div>
					</div>
					<!--环形图-->
					<div class="col-sm-12 data_finance" style="">
						<div class="col-sm-7" style="padding:0;height:288px;" id="waybill_column"></div>
						<div class="col-sm-5" style="padding:0;">
							<ul class="col-sm-12 clearfix finance_list" id="data_ul">
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>0单;0.00吨</p>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>0单;0.00吨</p>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>0单;0.00吨</p>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>0单;0.00吨</p>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>0单;0.00吨</p>
								</li>
							</ul>
						</div>
					</div>

				</div>
			</div>
			<!--招标运输分析-->
			<div class="col-sm-6">
				<div class="col-sm-12">
					<div class="col-sm-12 clearfix" style="padding:0;">
						<div class="pull-left">
							<h4 class="title">业务分析</h4>
							<h5>共计运费收入:<span style="color:#FF0000;" id="financial_status_1">￥0.00</span></h5>
						</div>
						<div class="pull-right form-group data_time data_time_right" style="margin-top:18px;">
							<input type="text" class="data_input"/>
							<input type="hidden" id="right_str">
							<input type="hidden" id="right_end">
							<span class="caret"></span>
						</div>
					</div>
					<!--折线图-->
					<div class="col-sm-12 data_pay" style="">
						<div class="col-sm-12" id="waybill_line" style="height:300px;padding:0;"></div>
					</div>
					<!--统计-->
					<div class="col-sm-12 count">
						<div class="col-sm-4 text-center">
							<h3 id="financial_status_2">0.00</h3>
							<h5>共支出</h5>
						</div>
						<div class="col-sm-7">
							<div class="col-sm-12 clearfix count_r">
								<h2 class="text-left pull-left" id="financial_status_3">0</h2>
								<div class="pull-right">
									<h4 style="margin-top:15px;">共运输</h4>
									<h5 class="text-right">（单）</h5>
								</div>
							</div>
							<div class="col-sm-12 clearfix count_r">
								<h2 class="text-left pull-left" id="financial_status_4">0.000</h2>
								<div class="pull-right">
									<h4>运量</h4>
									<h5 class="text-right">（吨）</h5>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--应收 应付列表-->
		<div class="col-sm-12 clearfix refort_form" ng-app="dataHall" ng-controller="dataHallCtrl">
			<!--两大板块-->
			<div class="col-sm-12 refort_guide clearfix tab-panel-heading">
				<ul class="list-group clearfix nav nav-tabs tab-nav-tabs" id="type-tabs">
					<li class="list-group-item pull-left" id="type-tabs1"  ng-click="selectType('1')"><a href=""  class="refort_guide_select">应收</a></li>
					<li class="list-group-item pull-left" id="type-tabs2" ng-click="selectType('2')"><a href="">应付</a></li>
				</ul>
			</div>
			<form:form id="searchForm" modelAttribute="OrderinfoExcelVO"
		   action="${wlpt}/wlpt/statistics/orderExport" method="post">
			<div class="tab-content clearfix">
				<!--应收模块-->
				<div class="tab-pane fade in active" id="index_1">
					<!--列表-->
					<div class="col-sm-12 ">
						<div class="col-sm-12 clearfix refort_list">
							<!--查询条件-->
							<div class="col-sm-12 clearfix refort_look">
								<div class="pull-left form-group data_time data_time_list">
									<label class="">查询条件</label>
									<input type="text" class="data_input"/>
									<input type="hidden" id="list_str">
									<input type="hidden" id="list_end">
									<span class="caret"></span>
								</div>
								<ul class="pull-left list-group list-group-l">
									<li class="list-group-item pull-left look_active" ng-click="selectInfo()">查询</li>
								</ul>
								<!--刷新  打印 导出-->
								<ul class="list-group list-group-r pull-right">
									<li class="list-group-item pull-left"  ng-click="selectInfo()">
										<span class="glyphicon glyphicon-refresh"></span>
										刷新
									</li>
									<li class="list-group-item pull-left" ng-click="printInfo()">
										<span class="glyphicon glyphicon-print"></span>
										打印
									</li>
									<li class="list-group-item pull-left" ng-click="exportExcel()">
										<input type="hidden" name="type" id="type">
										<input type="hidden" name="orderstatus" id="orderstatus">
										<input type="hidden" name="beginUpdateDate" id="beginUpdateDate">
										<input type="hidden" name="endUpdateDate" id="endUpdateDate">
										<span class="glyphicon glyphicon-log-out"></span>
										导出
									</li>
								</ul>
							</div>

							<!--账单状态-->
							<div class="col-sm-12 refort_detail clearfix">
								<div class="tab-panel-heading">
									<ul class="list-group clearfix nav nav-tabs tab-nav-tabs">
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('1','未完成运输')">未完成运输({{orderMony1!=null?orderMony1:0 | number : 2}})</a></li>
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('2','待结算')">待结算({{orderMony2!=null?orderMony2:0 | number : 2}})</a></li>
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('3','已结算')">已结算({{orderMony3!=null?orderMony3:0 | number : 2}})</a></li>
										<li class="list-group-item pull-left"><a href="" ng-cloak >总运费({{totaltradmy!=null?totaltradmy:0 | number : 2}},线上结算运费：{{orderMony4!=null?orderMony4:0 | number : 2}})</a></li>
									</ul>
								</div>
								<div class="tab-content">
									<!--1-->
									<div class="tab-pane fade in active" id="n_apply">
										<div id="printhtml" >
										<h3 class="text-center"  id="statusname">未完成运输账单报表</h3>
										<p class="repert_time" id="repert_time_test"></p>
										<div class="col-sm-12">
											<table class="table table-bordered table-hover">
												<thead>
												<tr>
													<th></th>
													<th>运单号</th>
													<th><span class="typename" style="font-size: 13px;">付</span>款方</th>
													<th><span class="typename" style="font-size: 13px;">付</span>款方联系电话</th>
													<th>运单运量(吨)</th>
													<th>运单金额(元)</th>
													<th>线上结算运费(元)</th>
													<th>操作时间</th>
												</tr>
												</thead>
												<tbody>
												<tr ng-repeat="x in data">
													<td></td>
													<td ng-cloak >{{x.orderno}}</td>
													<td ng-cloak ><span ng-cloak ng-if="x.isBuyer">{{x.seller.loginName}}</span><span ng-if="x.isBuyer==false">{{x.buyer.loginName}}</span></td>
													<td ng-cloak ><span ng-cloak ng-if="x.isBuyer">{{x.seller.phone}}</span><span ng-if="x.isBuyer==false">{{x.buyer.phone}}</span></td>
													<td ng-cloak >
														{{x.quoteinfo.actload | number : 3}}
													</td>
													<td ng-cloak >{{x.payinfo.actualamount | number : 2}}</td>
													<td ng-cloak >{{x.statusStr}}</td>
													<td ng-cloak >{{x.updateDate}}</td>
												</tr>

												</tbody>
												<tfoot id="foot_data">
												<tr>
													<td class="" colspan="8">
														合计：<span ng-cloak>{{orderWeight!=null?orderWeight:0 | number : 3}}元</span>
														共运输：<span ng-cloak>{{orderMony !=null?orderMony :0| number : 2}}吨</span>
													</td>
												</tr>
												</tfoot>
											</table>
										</div>
										</div>
										<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
											<img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
										</div>

										<tm-pagination conf="paginationConf"></tm-pagination>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			</form:form>
		</div>
	</div>
</div>

	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctxStatic}/echarts/echarts-all.js"></script>
<script src="${ctxStatic}/front/js/moment.js"></script>
<script src="${ctxStatic}/front/js/daterangepicker.js"></script>
<script type="text/javascript" src="${ctxStatic }/jquery/jquery.PrintArea.js"></script>
<script>
    //时间段选择
    $('.data_time_left .data_input').daterangepicker(
        {
            // startDate: moment().startOf('day'),
            //endDate: moment(),
            //minDate: '01/01/2012', //最小时间
            maxDate : moment(), //最大时间
            dateLimit : {
                days : 30
            }, //起止时间的最大间隔
            showDropdowns : true,
            showWeekNumbers : false, //是否显示第几周
            timePicker : true, //是否显示小时和分钟
            timePickerIncrement : 60, //时间的增量，单位为分钟
            timePicker12Hour : false, //是否使用12小时制来显示时间
            ranges : {
                //'最近1小时': [moment().subtract('hours',1), moment()],
                '今日': [moment().startOf('day'), moment()],
                '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                '最近7日': [moment().subtract('days', 6), moment()],
                '最近30日': [moment().subtract('days', 29), moment()]
            },
            opens : 'right', //日期选择框的弹出位置
            buttonClasses : [ 'btn btn-default' ],
            applyClass : 'btn-small btn-primary blue',
            cancelClass : 'btn-small',
            format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
            separator : ' to ',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        }, function(start, end, label) {//格式化日期显示框

            $('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
            $("#left_str").val(start.format('YYYY-MM-DD HH:mm:ss'));
            $("#left_end").val(end.format('YYYY-MM-DD HH:mm:ss'));
            geroleCount2();
        });

    //时间段选择
    $('.data_time_right .data_input').daterangepicker(
        {
            // startDate: moment().startOf('day'),
            //endDate: moment(),
            //minDate: '01/01/2012', //最小时间
            maxDate : moment(), //最大时间
            dateLimit : {
                days : 30
            }, //起止时间的最大间隔
            showDropdowns : true,
            showWeekNumbers : false, //是否显示第几周
            timePicker : true, //是否显示小时和分钟
            timePickerIncrement : 60, //时间的增量，单位为分钟
            timePicker12Hour : false, //是否使用12小时制来显示时间
            ranges : {
                //'最近1小时': [moment().subtract('hours',1), moment()],
                '今日': [moment().startOf('day'), moment()],
                '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                '最近7日': [moment().subtract('days', 6), moment()],
                '最近30日': [moment().subtract('days', 29), moment()]
            },
            opens : 'right', //日期选择框的弹出位置
            buttonClasses : [ 'btn btn-default' ],
            applyClass : 'btn-small btn-primary blue',
            cancelClass : 'btn-small',
            format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
            separator : ' to ',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        }, function(start, end, label) {//格式化日期显示框

            $('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
            $("#right_str").val(start.format('YYYY-MM-DD HH:mm:ss'));
            $("#right_end").val(end.format('YYYY-MM-DD HH:mm:ss'));
            geroleCount1();
        });

    //时间段选择
    $('.data_time_list .data_input').daterangepicker(
        {
            // startDate: moment().startOf('day'),
            //endDate: moment(),
            //minDate: '01/01/2012', //最小时间
            maxDate : moment(), //最大时间
            dateLimit : {
                days : 90
            }, //起止时间的最大间隔
            showDropdowns : true,
            showWeekNumbers : false, //是否显示第几周
            timePicker : true, //是否显示小时和分钟
            timePickerIncrement : 60, //时间的增量，单位为分钟
            timePicker12Hour : false, //是否使用12小时制来显示时间
            ranges : {
                //'最近1小时': [moment().subtract('hours',1), moment()],
                '今日': [moment().startOf('day'), moment()],
                '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                '最近7日': [moment().subtract('days', 6), moment()],
                '最近30日': [moment().subtract('days', 29), moment()]
            },
            opens : 'right', //日期选择框的弹出位置
            buttonClasses : [ 'btn btn-default' ],
            applyClass : 'btn-small btn-primary blue',
            cancelClass : 'btn-small',
            format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
            separator : ' to ',
            locale : {
                applyLabel : '确定',
                cancelLabel : '取消',
                fromLabel : '起始时间',
                toLabel : '结束时间',
                customRangeLabel : '自定义',
                daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                    '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                firstDay : 1
            }
        }, function(start, end, label) {//格式化日期显示框

            $('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
			$("#list_str").val(start.format('YYYY-MM-DD HH:mm:ss'));
            $("#list_end").val(end.format('YYYY-MM-DD HH:mm:ss'));
            $("#beginUpdateDate").val(start.format('YYYY-MM-DD HH:mm:ss'));
            $("#endUpdateDate").val(end.format('YYYY-MM-DD HH:mm:ss'));
            $("#repert_time_test").html("日期："+start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
        });

    function indexShow(id){
        var len=$(id).find('tr').length;
        for(var i = 1;i<len-1;i++){
            $(id).find('tr:eq('+i+') td:first').text(i);
        }
    }
    indexShow('#n_apply');


    var w = document.documentElement.clientWidth;
    if(w<1010){
        $('.row').css('width','1010px').css('background-color','#fff').css('overflow-x','hidden').css('overflow-y','hidden');
        $('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }


    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            ishow: true,
            currentPage: 1,
            itemsPerPage: 10
        };

        $scope.orderWeight = 0;
        $scope.orderMony = 0;
        $scope.searchType=1;
        $scope.searchStatus=1;
        $scope.orderMony1 =0;
        $scope.orderMony2 = 0;
        $scope.orderMony3 = 0;
        $scope.orderMony4 = 0;
        $scope.totaltradmy = 0;

        ///查询参数初始化
        $scope.postData = {
            type:$scope.searchType,
            pageNo: $scope.paginationConf.currentPage,
            pageSize: $scope.paginationConf.itemsPerPage
        };


        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
                $("#foot_data").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
                $("#foot_data").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
                $("#foot_data").show();
            }
        };

        var GetAllEmployee = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
            $scope.postData = {
                pageNo:  $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage,
                "type":$scope.searchType,
                "orderstatus":$scope.searchStatus,
				"beginUpdateDate":$("#list_str").val(),
				"endUpdateDate":$("#list_end").val()
            };

            $http({
                url: '${wlpt}/wlpt/statistics/findFinancialOrderList',
                method: 'post',
                params: $scope.postData
            }).success(function (response) {

                $scope.data = response.value.list;
                $scope.paginationConf.totalItems = response.value.count;
                if (!response.value.count) {
                    $scope.$apply(function () {
                    });
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });

        };

        $scope.selectType = function (type) {
            $("#type-tabs>li>a").removeClass("refort_guide_select");
            $("#type-tabs"+type).children("a").addClass("refort_guide_select");
            $scope.searchType=type;
            if(type==1){
				$(".typename").html("付");
			}else {
                $(".typename").html("收");
			}
            GetAllEmployee();
            GetStatusList();
            GetStatusData();
        }
        $scope.selectStatus = function (status,name) {
            $("#statusname").html(name+"账单报表");
            $scope.searchStatus=status;
            GetAllEmployee();
            GetStatusList();
        }
        $scope.selectInfo = function () {

            GetAllEmployee();
            GetStatusList();
            GetStatusData();
        }
        $scope.printInfo = function () {
            $("#printhtml").printArea();
        }


        var GetStatusList = function () {
            $scope.postData = {
                "beginDate":$("#list_str").val(),
                "endDate":$("#list_end").val(),
                "type":$scope.searchType,
                "orderstatus":$scope.searchStatus
            };
            $http({url:"${wlpt}/wlpt/statistics/getOrdeCountInfo",method: 'post',params: $scope.postData}).success(function (response) {
                var orderCount = response.orderCount;
                $scope.orderWeight = orderCount.allweight;
                $scope.orderMony = orderCount.alltradmy;


            });
        }
        GetStatusList();
        var GetStatusData = function () {
            $scope.postData = {
                "beginDate":$("#list_str").val(),
                "endDate":$("#list_end").val(),
                "type":$scope.searchType
            };
            $http({url:"${wlpt}/wlpt/statistics/getOrdeCountData",method: 'post',params: $scope.postData}).success(function (response) {
                var orderCount1 = response.orderCount1;
                var orderCount2 = response.orderCount2;
                var orderCount3 = response.orderCount3;
                var orderCount4 = response.orderCount4;
                $scope.orderMony1 = orderCount1.alltradmy;
                $scope.orderMony2 = orderCount2.alltradmy;
                $scope.orderMony3 = orderCount3.alltradmy;
                $scope.orderMony4 = orderCount4.alltradmy;
                $scope.totaltradmy = orderCount4.totaltradmy;

            });
        }
        GetStatusData();


        $scope.exportExcel = function () {
            $("#type").val($scope.searchType);
            $("#orderstatus").val($scope.searchStatus);
            $("#searchForm").submit();
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

    }]);



    var title = [];
    var dataVar = [];
    var optiondata = [];

    //支出分析  混合图
    var waybill_line = echarts.init(document.getElementById('waybill_line'));

    //财务概览  环形图
    var waybill_column = echarts.init(document.getElementById('waybill_column'));

    geroleCount1();
    function geroleCount1() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getOrderBusinessData?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                "beginDate":$("#right_str").val(),
                "endDate":$("#right_end").val(),
                'gsType': 1
            },
            success: function (data) {
                title = [];
                dataVar = [];
                var Business_data = data.Business_data;
                if (Business_data != null
                    && Business_data.length > 0) {
                    for (var i = 0; i < Business_data.length; i++) {
                        var nowdata = Business_data[i];
                        var cretime = nowdata.cretime;
                        title[i] = cretime;
                        var value_data = "运输："+ nowdata.sellercount*1+"单="+(nowdata.allweight*1).toFixed(2)+"吨";
                        //dataVar[i] = (nowdata.allweight*1).toFixed(2);
                        dataVar[i] = {
                            value: (nowdata.allweight*1).toFixed(2),
                            name: nowdata.sellercount*1
                        };
                    }
                    setoption1();
                }

            }
        });
    }
    geroleCount2();
    function geroleCount2() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getOrderStatusCountInfoData?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                "beginCreateDate":$("#left_str").val(),
                "endCreateDate":$("#left_end").val(),
                'searchType': "1"
            },
            success: function (data) {
                var statusCount_data = data.statusCount_data.data.varList;
				var data_div = $("#order_status_1");

                if (statusCount_data != null
                    && statusCount_data.length > 0) {
                    var totalmoney = '';

                    for (var j = 0; j < statusCount_data.length; j++) {
                        var nowdata = statusCount_data[j];
                        totalmoney = totalmoney * 1 + nowdata.mony * 1;

                    }

                    $("#data_ul").html('');
                    var ysz_count=0;
                    for (var i = 0; i < statusCount_data.length; i++) {

                        var nowdata = statusCount_data[i];
                        var name = nowdata.name;
                        var count_data = nowdata.count*1;
                        var weight_data = (nowdata.weight*1).toFixed(2);
                        var value_data = (nowdata.mony*1).toFixed(2);
                        optiondata[i] = {
                            value: value_data,
                            name: name
                        };

                        var html = '<li class="clearfix data_list">'
                            +'<p class="pull-left"><span></span>'+name+'</p>'
                            +'<div class="pull-right">'+count_data*1+'单;'+weight_data*1+'吨</div>'
                            +'</li>';
                        $("#data_ul").append(html);

						var number1=0;
                        if(name=="已提货"){
                            number1=1;
                            data_div = $("#order_status_1");
                            ysz_count = (ysz_count*1)+count_data;
                        }else if(name=="已回单"){
                            number1=1;
                            data_div = $("#order_status_2");
                            ysz_count = (ysz_count*1)+count_data;
                        }else if(name=="发起争议"){
                            number1=1;
                            data_div = $("#order_status_3");
                        }else if(name=="新运单"){
                            number1=1;
                            data_div = $("#order_status_4");
                        }
						if(number1==1){
                            data_div.find(".pull-left").html(count_data);
						}

                    }
                    $("#ysz_count").html(ysz_count);
                    getoption2();
                    //小方块的各个颜色
                    var colorList=['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940'];
                    var length=$('.finance_list li').length;
                    for(var i=0;i<length;i++){
                        $('.finance_list li').eq(i).find('span').css('background-color',colorList[i]);
                    }
                }
            }
        });
    }
    geroleCount3();
    function geroleCount3() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getFinancialDataInfo?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                'searchType': 1
            },
            success: function (data) {
                var financial_data = data.financial_data.data.varList;
                var order_data = data.order_data;
                var data_div = $("#order_status_1");
                if (financial_data != null
                    && financial_data.length > 0) {

                    for (var i = 0; i < financial_data.length; i++) {

                        var nowdata = financial_data[i];
                        var name = nowdata.name;
                        var value_data = (nowdata.mony * 1).toFixed(2);
                        if(name=="运费收入"){
                            data_div = $("#financial_status_1");
                        }else if(name=="运费支出"){
                            data_div = $("#financial_status_2");
                        }
                        data_div.html("￥"+value_data);
                    }

                }
                if (financial_data != null
                    && financial_data.length > 0) {
                    $("#financial_status_3").html(order_data.count * 1);
                    $("#financial_status_4").html((order_data.weight * 1).toFixed(3));

                }
            }
        });
    }
function setoption1() {
    waybill_line.clear();
    var option_1 = {
        grid: {
            x: 90,
            y: 40,
            x2: 70,
            y2: 65,
        },
        tooltip : {trigger: 'item',formatter: function(params){
            var value_data = "运输："+params.data.name+"单="+ params.value+"吨";
            return value_data;
        } },
        toolbox: {
            show: true,
            feature: {
                //mark : {show: true},
                //dataView : {show: true, readOnly: false},
                magicType: {show: false, type: ['line', 'bar']},
                //restore : {show: true},
                //saveAsImage : {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                type: 'category',
                position: 'bottom',
                boundaryGap: false,
                axisLine: {//x轴线的样式
                    show: false,
                    lineStyle: {
                        color: '#56a3e5',
                        type: 'solid',
                        width: '2'
                    },
                },
                axisTick: {//x轴的多出来的消失
                    show: true,
                    length: 0,
                    lineStyle: {
                        color: '#000',
                        type: 'solid',
                        width: '0'
                    }
                },
                axisLabel: {
                    show: true,
                    rotate: 0,
                    textStyle: {
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: 'bold'
                    },
                },
                splitLine: {//网格样式
                    show: true,
                    lineStyle: {
                        color: '#76b2e5',
                        type: 'solid',
                        width: 1
                    },
                },
                splitArea: {
                    show: true,
                    areaStyle: {
                        color: "#53a3e8"
                    },
                },
                data: title
            },
        ],
        yAxis: [
            {
                type: 'value',
                splitLine: {//网格样式
                    show: true,
                    lineStyle: {
                        color: '#76b2e5',
                        type: 'solid',
                        width: 1
                    },
                },
                axisLine: {//x轴线的样式
                    show: false,
                    lineStyle: {
                        color: '#56a3e5',
                        type: 'solid',
                        width: '0'
                    },
                },
                axisLabel: {
                    formatter: '{value}',
                    show: true,
                    textStyle: {
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: 'bold'
                    },
                }
            }
        ],
        series: [
            {
                name: '运输',
                type: 'line',
                symbolSize: 4,
                itemStyle: {
                    normal: {
                        color: '#fff',
                        lineStyle: {
                            color: '#fff'
                        },
                        areaStyle: {
                            type: 'default',
                            color: 'rgba(255,255,255,.1)'
                        },
                    }
                },
                data: dataVar
            }
        ]
    };
    waybill_line.setOption(option_1);
}


function getoption2() {
    waybill_column.clear();
    var option = {
        tooltip: { //提示框组件
            trigger: 'item', //触发类型(饼状图片就是用这个)
            formatter: "{a} <br/>{b} : {c} ({d}%)" //提示框浮层内容格式器
        },
        color: ['#5693f3', '#18b799', '#dd4444', '#fd9d34', '#ffc940'],  //手动设置每个图例的颜色
        /*legend: {  //图例组件
            //right:100,  //图例组件离右边的距离
            orient : 'vertical',  //布局  纵向布局 图例标记居文字的左边 vertical则反之
            width:40,      //图行例组件的宽度,默认自适应
            x : '80%',   //图例显示在右边
            y: '20%',   //图例在垂直方向上面显示居中
            itemWidth:20,  //图例标记的图形宽度
            itemHeight:20, //图例标记的图形高度
            //icon:'force',
            data:['运输完成','运输中','未运输'],
            textStyle:{    //图例文字的样式
                color:'#c3c3c3',  //文字颜色
                fontSize:14,//文字大小
                fontWeight:100,
            }
        },*/
        series: [ //系列列表
            {
                name: '运输标数',  //系列名称
                type: 'pie',   //类型 pie表示饼图
                center: ['47%', '50%'], //设置饼的原心坐标 不设置就会默认在中心的位置
                radius: ['40%', '60%'],  //饼图的半径,第一项是内半径,第二项是外半径,内半径为0就是真的饼,不是环形
                funnelAlign: 'left',
                itemStyle: {  //图形样式
                    normal: { //normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
                        label: {  //饼图图形上的文本标签
                            show: true //平常不显示
                        },
                        labelLine: {     //标签的视觉引导线样式
                            show: true  //平常不显示
                        }
                    },
                    emphasis: {   //normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
                        label: {  //饼图图形上的文本标签
                            show: true,
                            position: 'center',
                            textStyle: {
                                fontSize: '16',
                                fontWeight: 'bold'
                            }
                        }
                    }
                },
                data: optiondata
            }
        ]
    }
    waybill_column.setOption(option);
}

    //
    var hh=518-100;
    $('.list_parent_all').height(hh+'px');
    $('.total_num').width($('.list_parent').width()+'px');
/*    //小方块的各个颜色
    var colorList=['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940'];
    var length=$('.finance_list li').length;
    for(var i=0;i<length;i++){
        $('.finance_list li').eq(i).find('span').css('background-color',colorList[i]);
    }*/



</script>
</body>
</html>
