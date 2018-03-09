<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head> 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>我的账单</title>
<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/personal/count.css">
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	width: 100%;
	margin: 0 auto;
	text-align: center;
	border: 1px solid #D6D3CE;
	font-family: "微软雅黑";
}

ul p span a input td {
	font-family: "微软雅黑";
}

table td {
	text-align: center;
}

table td p {
	line-height: 25px;
}

.icon_blue {
	font-size: 30px;
	font-weight: normal;
	color: #00A2E9;
	font-size: 23px;
	vertical-align: middle;
	display: inline-block;
	cursor: pointer;
	background-color: transparent;
	border: none;
}

.datainit {
	display: none;
}

.count_price {
	padding-left: 0px;
}
.regbt {
            width: 40%;
            height: 85%;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 12px;
        }
.div1_line1 {
    width: 75%;
    margin: 0 auto;
    text-align: center;
    overflow: hidden;
}

</style>

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${ctxStatic }/modules/wlpt/front/css/personal.css">
<script type="text/javascript">
        $(function () {
            $("#btnExport").click(function () {

                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/export");
                $("#searchForm").submit();
                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/toPurse");

                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });
        });
    </script>

</head>
<body style="height: 1000px;" ng-app="dataHall"
	ng-controller="dataHallCtrl">
	
	
	
	<p class="user_data" style="text-align: left;background-color: #f5f5f5;padding: 15px;margin: 0px;">
		我的账单
	</p>
	<form:form id="searchForm" modelAttribute="consumerecod"
		action="${wlpt}/wlpt/consume/export" method="post"
		class="breadcrumb form-search " cssStyle="padding: 20px 10px;border-bottom: 1px dashed #ccc;margin-bottom: 0px;">
		<div class="select_title" style="margin: 0px; padding: 0px;">
			<input type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="beginCreateDate" id="beginCreateDate"
				placeholder="选择开始时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> —— <input
				type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="endCreateDate" id="endCreateDate"
				placeholder="选择结束时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> <select
				id="trademodel" ng-model="trademodel" name="trademodel"
				class="input-medium car_search car_phone_search">
				<option value="" label="全部">全部</option>
				<option value="0">充值</option>
				<option value="1">运单交易</option>
				<option value="2">结算账户</option>
				<option value="3">竞标</option>
				<option value="4">提现</option>
				<option value="5">转账</option>
				<option value="6">卓币</option>
				<option value="7">油气</option>
				<option value="8">保证金</option>
				<option value="9">保险</option>
			</select>
			<button type="button" class="btn btn-primary btn-search"
				ng-click="selectPage(1)">
				<span class="glyphicon glyphicon-search"></span><span
					class="goods_search_btn">搜索</span>
			</button>
			<button class="icon_blue" style="margin: 0px;" id="btnExport">
				<span class="glyphicon glyphicon-open " id="fubu"></span><span
					class="fabu">导出</span>
			</button>
		</div>
	</form:form>

	<table class="goods-manage" style="margin-top: 0px;">
		<thead>
			<tr class="goods_col_1" style="border: none;">
				<td style="width: 20%;">交易时间</td>
				<!-- <td style="width: 11%">标题</td> -->
				
				<td style="width: 31%; text-align: left;">交易描述</td>
				<td style="width: 15%; text-align:center;">交易方式</td>
				<td style="width: 11%">金额</td>
				<td style="width: 11%">状态</td>
				
			</tr>
		</thead>
		<tbody class="datainit">
			<tr ng-repeat="x in data">
				<td>{{x.createDate}}</td>
				<!-- <td>{{x.consumetype}}</td> -->
				
				<td style="text-align: left">
					<p>流水:{{x.consumecode}}</p>
					<p>{{x.consumewaydesp}}</p>
				</td>
				<td style="text-align:center">{{x.consumeway}}</td>
				<td><span ng-if="x.aftermony-x.beforemony<0"
					style="color: red; font-weight: bold;">-</span> <span
					ng-if="x.aftermony-x.beforemony>0"
					style="color: green; font-weight: bold;">+</span> {{x.consumemony}}
				</td>
				<td>{{x.consumestatus}}</td>
				
			</tr>

		</tbody>
	</table>
	<div class="loading">
		<img src="/static/images/loading.gif">
		<p>加载中</p>
	</div>

	<div id="noneData"
		style="display: none; text-align: center; width: 100%; line-height: 25px;">暂无数据</div>

	<div class="paging" id="paging">
		<ul class="pagination pager" id="pagination"
			on-select-page="selectPage(page)">
			<li ng-class="{active: isActive(page)}"><a
				ng-click="selectPage(1)">第一页</a></li>
			<li ng-class="{disabled: noPrevious()}"><a
				ng-click="selectPrevious()">上一页</a></li>
			<li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
				<a ng-click="selectPage(page)">{{page}}</a>
			</li>
			<li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
			<li ng-class="{active: isActive(page)}"><a
				ng-click="selectPage(numPages)">最后一页</a></li>
		</ul>
	</div>
	</div>
	</div>

	<script type="text/javascript" src="/static/jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
	<script type="text/javascript"
		src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
	<script
		src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script>

    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $(".loading").show();
                $("#noneData").hide();
            } else if (isloading == 2) {
                $(".loading").hide();
                $("#noneData").show();
                $("#btnExport").hide().attr("disabled","true");
            } else {
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.exportExcel = function () {
            $http({
                url: '${wlpt}/wlpt/consume/export',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {

            });
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/consume/getRecodeList',
            method: 'post',
            params: {
                'beginCreateDate': $("#beginCreateDate").val(),
                'endCreateDate': $("#endCreateDate").val(),
                'trademodel': $("#trademodel").val(),
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if (!$scope.data) {
                $scope.isloading(2);
            } else {
                $scope.isloading(3);
            }
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;

            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
        });

        $scope.onSelectPage = function (page) {
            $scope.isloading(1);
            //replace your real data
            $http({
                url: '${wlpt}/wlpt/consume/getRecodeList',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {
                $scope.data = response.value.list;
                $scope.pages = [];
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);
                }
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

                if ($scope.numPages == 0) {
                    $scope.numPages = 1;
                }
                $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
                for (var i = 0; i < $scope.newPages; i++) {
                    var num = $scope.currentPage - 3;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1);
                }
            });
        };
    });

    app.directive('paging', function () {
        return {
            restrict: 'AEC',
            //scope: {
            //    numPages: '=',
            //    currentPage: '=',
            //    onSelectPage: '&'
            //},
            template: '',
            replace: true,
            link: function (scope, element, attrs) {
                scope.$watch('numPages', function (value) {
                    if (scope.currentPage > value) {
                        scope.selectPage(value);
                    }
                });
                scope.isActive = function (page) {
                    return scope.currentPage === page;
                };
                scope.selectPage = function (page) {
                    //不能小于1大于最大
                    if (page < 1 || page > scope.numPages) return;
                    //最多显示分页数5
                    if (page > 2) {
                        //因为只显示5个页数，大于2页开始分页转换
                        var newpageList = [];
                        for (var i = (page - 3); i < ((page + 2) > scope.numPages ? scope.numPages : (page + 2)); i++) {
                            newpageList.push(i + 1);
                        }
                        scope.pages = newpageList;
                    }
                    if (page == 1) {
                        scope.pages = [];
                        for (var k = 0; k < scope.newPages; k++) {
                            scope.pages.push(k + 1);
                        }
                    }


                    if (!scope.isActive(page) || page == 1) {
                        scope.currentPage = page;
                        scope.onSelectPage(page);
                    }
                };
                scope.selectPrevious = function () {
                    if (!scope.noPrevious()) {
                        scope.selectPage(scope.currentPage - 1);
                    }
                };
                scope.selectNext = function () {
                    if (!scope.noNext()) {
                        scope.selectPage(scope.currentPage + 1);
                    }
                };
                scope.noPrevious = function () {
                    return scope.currentPage == 1;
                };
                scope.noNext = function () {
                    return scope.currentPage == scope.numPages;
                };

            }
        };


    });
    
</script>
</body>
</html>
