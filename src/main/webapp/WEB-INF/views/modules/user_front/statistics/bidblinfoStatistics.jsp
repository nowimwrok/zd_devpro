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
<style type="text/css">
	.refort_guide_select{
		background-color: #666 !important;
		color: #fff !important;
	}
</style>
<title>提货单统计</title>
</head>
<body>
<div class="row" style="background-color:#fff;">
	<div class="col-lg-12" style="background-color:#fff;">
		<div class="col-sm-12 clearfix data_fx data_bid">
			<!--招标分析-->
			<div class="col-sm-6 finance parent_line">
				<div class="col-sm-12" style="padding:0;">
					<div class="pull-left">
						<h4 class="title">货单分析</h4>
						<h5>仓库管理货单分析</h5>
					</div>
					<div class="pull-right form-group data_time data_time_left" style="margin-top:18px;">
						<input type="text" class="data_input">
						<input type="hidden" id="left_str">
						<input type="hidden" id="left_end">
						<span class="caret"></span>
					</div>
					<div class="col-sm-12 income_line"></div>
					<!--统计-->
					<div class="col-sm-12 count">
						<div class="col-sm-4 text-center">
							<h3 id="jb_count"></h3>
							<h5>累计入库(单)</h5>
						</div>
						<div class="col-sm-5">
							<div class="col-sm-12 clearfix count_r">
								<h2 class="text-left pull-left" style="color:#3c763d" id="bid_status_1">0</h2>
								<h4 class="pull-right">待出库</h4>
							</div>
							<div class="col-sm-12 clearfix count_r">
								<h2 class="text-left pull-left" style="color:#a94442" id="bid_status_2">0</h2>
								<h4 class="pull-right">入库</h4>
							</div>
						</div>
						<%--<div class="col-sm-3">
							<div class="col-sm-12 text-left">
								<p class="text-center"><span class="text-primary" id="bid_status_3">0%</span>成功率</p>
							</div>
							<div class="col-sm-12 text-center">
								<img src="${ctxStatic }/front/img/column_blue.png" alt="" />
							</div>
						</div>--%>
					</div>
					<!--线-->
					<div class="col-sm-10 col-lg-offset-1" style="margin-top:15px;">
						<div class="col-sm-12 income_line"></div>
					</div>
					<!--环形图-->
					<div class="col-sm-12 data_finance" style="">
						<div class="col-sm-7" style="padding:0;height:288px;" id="bid_column"></div>
						<div class="col-sm-5" style="padding:0;">
							<ul class="col-sm-12 clearfix finance_list" id="data_ul" style="height: 180px;overflow: -webkit-paged-x;">
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>309库</p>
									<div class="pull-right">0单;0.00吨</div>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>万红库</p>
									<div class="pull-right">0单;0.00吨</div>
								</li>
								<li class="clearfix data_list">
									<p class="pull-left"><span></span>其他</p>
									<div class="pull-right">0单;0.00吨</div>
								</li>
							</ul>
						</div>
					</div>

				</div>
			</div>
			<!--招标运输分析-->
			<div class="col-sm-6">
				<div class="col-sm-12">
					<div class="pull-left">
						<h4 class="title">货单运输分析</h4>
						<h5>货单运输报表分析</h5>
					</div>
					<div class="pull-right form-group data_time data_time_right" style="margin-top:18px;">
						<input type="text" class="data_input"/>
						<input type="hidden" id="right_str">
						<input type="hidden" id="right_end">
						<span class="caret"></span>
					</div>
					<!--折线图-->
					<div class="col-sm-12 data_pay" style="">
						<div class="col-sm-12" id="bid_line" style="height:300px;padding:0;"></div>
					</div>
					<!--统计-->
					<div class="col-sm-12 count" style="height:117px;">
						<div class="col-sm-4 text-center">
							<h3 id="contrac_count">0</h3>
							<h5>运输中(单)</h5>
						</div>
						<div class="col-sm-4 count_detail">
							<div class="col-sm-12" style="border-bottom:1px solid #dbdbdb;">
								<h4>运输中</h4>
								<div class="clearfix ">
									<strong class="pull-left text-muted" id="contrac_status_2">0.000</strong>
									<span class="pull-right">（吨）</span>
								</div>
							</div>
							<div class="col-sm-12">
								<h4>已运输总量</h4>
								<div class="clearfix ">
									<strong class="pull-left text-success" id="contrac_status_3">0.000</strong>
									<span class="pull-right">（吨）</span>
								</div>
							</div>
						</div>
						<div class="col-sm-4 count_detail" style="padding-left:0;">
							<div class="col-sm-12" style="border-bottom:1px solid #dbdbdb;">
								<h4>未运输</h4>
								<div class="clearfix ">
									<strong class="pull-left text-danger" style="font-size:22px;" id="contrac_status_1">0.000</strong>
									<span class="pull-right">（吨）</span>
								</div>
							</div>
						</div>
						<div class="data_bid_line"></div>
					</div>
				</div>
			</div>
		</div>
		<!--应收 应付列表-->
		<div class="col-sm-12 clearfix refort_form"  ng-app="dataHall" ng-controller="dataHallCtrl">
			<!--两大板块-->
			<div class="col-sm-12 refort_guide clearfix tab-panel-heading">
				<ul class="list-group clearfix nav nav-tabs tab-nav-tabs" id="type-tabs">
					<li class="list-group-item pull-left " id="type-tabs1" ng-click="selectType('1')"><a href="" class="refort_guide_select">库管</a></li>
					<li class="list-group-item pull-left" id="type-tabs2" ng-click="selectType('2')"><a href="" >接单</a></li>
				</ul>
			</div>
			<form:form id="searchForm" modelAttribute="bidBlinfoVO"
					   action="${wlpt}/wlpt/statistics/bidBlinfoExport" method="post">
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
								<div class="pull-left form-group data_time" style="margin-right: 15px;">
									<input type="text" class="data_input" name="searchinfo" id="searchinfo" placeholder="仓库名称/货单所属"/>
								</div>
								<ul class="pull-left list-group list-group-l">
									<li class="list-group-item pull-left look_active" ng-click="selectInfo()">查询</li>
									<%--<li class="list-group-item pull-left">近7天</li>
									<li class="list-group-item pull-left">近1个月</li>
									<li class="list-group-item pull-left">近3个月</li>--%>
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
									<li class="list-group-item pull-left"  ng-click="exportExcel()">
										<input type="hidden" name="type" id="type">
										<input type="hidden" name="status" id="settlestatus">
										<input type="hidden" name="beginCreateDate" id="beginCreateDate">
										<input type="hidden" name="endCreateDate" id="endCreateDate">
										<span class="glyphicon glyphicon-log-out"></span>
										导出
									</li>
								</ul>

							</div>
							<!--账单状态-->
							<div class="col-sm-12 refort_detail clearfix">
								<div class="tab-panel-heading">
									<ul class="list-group clearfix nav nav-tabs tab-nav-tabs">
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('2','待出库')">待出库({{orderCount1 !=null?orderCount1 :0}}单;{{orderWeight1!=null?orderWeight1:0 | number : 3}})</a></li>
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('3','已出库')">已出库({{orderCount2 !=null?orderCount2 :0}}单;{{orderWeight2!=null?orderWeight2:0 | number : 3}})</a></li>
										<li class="list-group-item pull-left"><a href="" ng-cloak ng-click="selectStatus('','共入库')">共入库({{orderCount3 !=null?orderCount3 :0}}单;{{orderWeight3!=null?orderWeight3:0 | number : 3}})</a></li>
									</ul>
								</div>
								<div class="tab-content">
									<!--1-->
									<div class="tab-pane fade in active" id="n_apply">
										<div id="printhtml" >
										<h3 class="text-center" id="statusname">待出库货单报表</h3>
										<p class="repert_time" id="repert_time_test"></p>
										<div class="col-sm-12">
											<table class="table table-bordered table-hover">
												<thead>
												<tr>
													<th></th>
													<th>货单所属</th>
													<th>仓库名称</th>
													<th>提货单号</th>
													<th>批号</th>
													<th>品名材质</th>
													<th>数量吨位</th>
													<th>卸货地址</th>
													<th>仓库状态</th>
													<th>入库时间</th>
												</tr>
												</thead>
												<tbody>
												<tr ng-repeat="x in data">
													<td></td>
													<td ng-cloak>{{x.bidcode}}</td>
													<td ng-cloak>{{x.warehousename}}</td>
													<td ng-cloak>{{x.contractno}}</td>
													<td ng-cloak>{{x.batch}}</td>
													<td ng-cloak>{{x.namematerials}}</td>
													<td ng-cloak>{{x.quantity | number : 3}}</td>
													<td ng-cloak>{{x.address}}</td>
													<td ng-cloak>{{x.statusname}}</td>
													<td ng-cloak>{{x.ymdDate}}</td>
												</tr>

												</tbody>
												<tfoot id="foot_data">
												<tr>
													<td class="" colspan="10">
														合计：<span ng-cloak>{{orderCount !=null?orderCount :0}}单</span>
														共运输：<span ng-cloak>{{orderWeight!=null?orderWeight:0 | number : 3}}吨</span>
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
            $("#beginCreateDate").val(start.format('YYYY-MM-DD HH:mm:ss'));
            $("#endCreateDate").val(end.format('YYYY-MM-DD HH:mm:ss'));
            $("#repert_time_test").html("日期："+start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
        });

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
        $scope.orderCount = 0;
		$scope.searchType=1;
        $scope.searchStatus=2;
        $scope.orderWeight1 =0;
        $scope.orderWeight2 = 0;
        $scope.orderWeight3 = 0;
        $scope.orderCount1 =0;
        $scope.orderCount2 = 0;
        $scope.orderCount3 = 0;
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
                "status":$scope.searchStatus,
				"searchinfo":$("#searchinfo").val(),
                "beginCreateDate":$("#list_str").val(),
                "endCreateDate":$("#list_end").val()
            };

            $http({
                url: '${wlpt}/wlpt/statistics/findBlinfoList',
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
            /*if(type==1){
                $(".typename").html("付");
            }else {
                $(".typename").html("收");
            }*/
            GetAllEmployee();
            GetStatusList();
            GetStatusData();
        }
        $scope.selectStatus = function (status,name) {
            $("#statusname").html(name+"货单报表");
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
                "beginCreateDate":$("#list_str").val(),
                "endCreateDate":$("#list_end").val(),
                "searchinfo":$("#searchinfo").val(),
                "type":$scope.searchType,
                "status":$scope.searchStatus
            };
            $http({url:"${wlpt}/wlpt/statistics/getBidBlinfoCountInfo",method: 'post',params: $scope.postData}).success(function (response) {
                var orderCount = response.orderCount;
                $scope.orderWeight = orderCount.weight;
                $scope.orderCount = orderCount.count;


            });
        }
        GetStatusList();
        var GetStatusData = function () {
            $scope.postData = {
                "beginCreateDate":$("#list_str").val(),
                "endCreateDate":$("#list_end").val(),
                "searchinfo":$("#searchinfo").val(),
                "type":$scope.searchType
            };
            $http({url:"${wlpt}/wlpt/statistics/findBidBlinfoCountData",method: 'post',params: $scope.postData}).success(function (response) {
                var orderCount1 = response.orderCount1;
                var orderCount2 = response.orderCount2;
                var orderCount3 = response.orderCount3;
                $scope.orderWeight1 = orderCount1.weight;
                $scope.orderWeight2 = orderCount2.weight;
                $scope.orderWeight3 = orderCount3.weight;
                $scope.orderCount1 =orderCount1.count;
                $scope.orderCount2 = orderCount2.count;
                $scope.orderCount3 = orderCount3.count;


            });
        }
        GetStatusData();
        $scope.exportExcel = function () {
            $("#type").val($scope.searchType);
            $("#status").val($scope.searchStatus);
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
    var bid_line = echarts.init(document.getElementById('bid_line'));
    //财务概览  环形图
    var bid_column = echarts.init(document.getElementById('bid_column'));


    geroleCount1();
    function geroleCount1() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getBlinfoDayData?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                "beginCreateDate":$("#right_str").val(),
                "endCreateDate":$("#right_end").val()
            },
            success: function (data) {
                title = [];
                dataVar = [];
                var BlinfoDay_data = data.BlinfoDay_data;
                if (BlinfoDay_data != null
                    && BlinfoDay_data.length > 0) {
                    for (var i = 0; i < BlinfoDay_data.length; i++) {
                        var nowdata = BlinfoDay_data[i];
                        var cretime = nowdata.createtime;
                        title[i] = cretime;
                        //dataVar[i] = (nowdata.allweight*1).toFixed(2);
                        dataVar[i] = {
                            value: (nowdata.weight*1).toFixed(2),
                            name: nowdata.count*1
                        };
                    }
                    setoption1();
                }else{
                    setoption1();
				}

            }
        });
    }
    geroleCount2();
    function geroleCount2() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getBidBlinfoStatusCountData?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                "beginCreateDate":$("#left_str").val(),
                "endCreateDate":$("#left_end").val(),
                'searchType': 1
            },
            success: function (data) {
                var warehouse_data = data.warehouse_data;
                var bidStatus_data = data.bidStatus_data;
                var data_div = $("#order_status_1");

                $("#data_ul").html('');
                if (warehouse_data != null
                    && warehouse_data.length > 0) {


                    for (var i = 0; i < warehouse_data.length; i++) {

                        var nowdata = warehouse_data[i];
                        var count_data = nowdata.count*1;
                        var weight_data = (nowdata.weight*1).toFixed(2);
                        var name = nowdata.name;
						if(name==undefined||name ==''||name==""){
                            name="其他";
						}
                        optiondata[i] = {
                            value: weight_data,
                            name: name
                        };

                        var html = '<li class="clearfix data_list">'
                            +'<p class="pull-left"><span></span>'+name+'</p>'
                            +'<div class="pull-right">'+count_data*1+'单;'+weight_data*1+'吨</div>'
                            +'</li>';
                        $("#data_ul").append(html);
                    }

                }
                getoption2();
                //小方块的各个颜色
                var colorList=['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940','#2ec7ca','#5ab1f0','#b7a3df'];
                var length=$('.finance_list li').length;
                for(var i=0;i<length;i++){
                    $('.finance_list li').eq(i).find('span').css('background-color',colorList[i]);
                }
                if (bidStatus_data != null
                    && bidStatus_data.length > 0) {

                    var ysz_count=0;
                    var jbcg_value = 0;
                    for (var i = 0; i < bidStatus_data.length; i++) {

                        var nowdata = bidStatus_data[i];
                        var name = nowdata.name;
                        var count_data = nowdata.count*1;

                        var number1=0;
                        if(name=="待出库"){
                            data_div = $("#bid_status_1");
                            jbcg_value = count_data;
                            number1=1;
                        }else if(name=="已入库"){
                            data_div = $("#bid_status_2");
                            number1=1;
                        }
                        if(number1==1){
                            data_div.html(count_data);
						}


                        ysz_count = (ysz_count*1)+count_data;

                    }

                    $("#jb_count").html(ysz_count);

                }else{
                    $("#bid_status_1").html("0");
                    $("#bid_status_2").html("0");
                    $("#jb_count").html("0");
                }
            }
        });
    }


    geroleCount3();
    function geroleCount3() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getBlinfoTradeStatusCount?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data:{
                'type': 0
            },
            success: function (data) {
                var contracStatus_data = data.contracStatus_data;
                var data_div = $("#order_status_1");
                var totalweight=0;
                if (contracStatus_data != null
                    && contracStatus_data.length > 0) {

                    for (var i = 0; i < contracStatus_data.length; i++) {

                        var nowdata = contracStatus_data[i];
                        var name = nowdata.name;
                        var value_data = (nowdata.weight * 1).toFixed(3);
                        if(name=="未运输"){
                            data_div = $("#contrac_status_1");
                        }else if(name=="运输中"){
                            data_div = $("#contrac_status_2");
                            $("#contrac_count").html(nowdata.count * 1);
                        }else {
                            data_div = $("#contrac_status_3");
						}
                        data_div.html(value_data);
                    }

                }else {
                    $("#contrac_status_1").html("0");
                    $("#contrac_status_2").html("0");
                    $("#contrac_status_3").html("0");
                    $("#contrac_count").html("0");
				}
            }
        });
    }
function setoption1() {
    bid_line.clear();
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
                    rotate: -65,
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
                data:title
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

            /*{
                name:'蒸发量',
                type:'bar',
                barWidth:'30',
                data:[100,20,50,85,90,30,55],
                itemStyle:{
                    normal:{
                        color:function(params){
                            var colorList=['#c1232b','#b5c334','#fcce10','#e87c25','#27727b','#fe8463','#9bca63'];
                            return colorList[params.dataIndex]
                        }
                    },
                },
            },*/
            {
                name: '降水量',
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

    bid_line.setOption(option_1);
}
function getoption2() {
    bid_column.clear();
    var option = {
        tooltip: { //提示框组件
            trigger: 'item', //触发类型(饼状图片就是用这个)
            formatter: "{a} <br/>{b} : {c} ({d}%)" //提示框浮层内容格式器
        },
        color: ['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940','#2ec7ca','#5ab1f0','#b7a3df'],  //手动设置每个图例的颜色
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
                name: '运输',  //系列名称
                type: 'pie',   //类型 pie表示饼图
                center: ['45%', '45%'], //设置饼的原心坐标 不设置就会默认在中心的位置
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
    bid_column.setOption(option);
}
    //
    var hh=518-100;
    $('.list_parent_all').height(hh+'px');
    $('.total_num').width($('.list_parent').width()+'px');
    /*//小方块的各个颜色
    var colorList=['#2ec7ca','#5ab1f0','#b7a3df'];
    var length=$('.finance_list li').length;
    for(var i=0;i<length;i++){
        $('.finance_list li').eq(i).find('span').css('background-color',colorList[i]);
    }*/
</script>
</body>
</html>
