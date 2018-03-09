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
<title>交易明细</title>
<style type="text/css">
.search_btn {
	width: 80px;
	background-color: #073190;
	color: white;
	border: 1px solid #073190;
}

.excel_btn {
	width: 80px;
	background-color: #17ab8d;
	color: white;
	border: 1px solid #17ab8d;
}
 .loading{
			text-align: center;
		}
		.form-control{
			border: 1px solid #ccc !important;
		}
		.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
		    padding: 10px;
		    line-height: 1.42857143;
		    border-bottom: 1px solid #ddd;
		    font-size: 13px;
		    vertical-align: bottom;
		    white-space: nowrap;
		    box-sizing: border-box;
		}
</style>
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
<body style="background: #f5f5f5;">
	<div ng-app="dataHall" ng-controller="dataHallCtrl" style="background: #f5f5f5;">
		<form:form id="searchForm" modelAttribute="consumerecod"
			action="${wlpt}/wlpt/consume/export" method="post">
			<div class="col-lg-12 " style="margin-top: 20px;">
				<div class="col-sm-2  clearfix">
					<input type="text" readonly="readonly" class="form-control"
						 name="beginCreateDate" id="beginCreateDate"
						placeholder="选择开始时间"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				</div>
				<div class="col-sm-2 clearfix">
					<input type="text" readonly="readonly" class="form-control"
						 name="endCreateDate" id="endCreateDate"
						placeholder="选择结束时间"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				</div>
				<div class="col-sm-2 clearfix">
					<select id="trademodel" ng-model="trademodel" name="trademodel"
						class="form-control">
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
				</div>
				<div class="col-sm-2 btn-search-wrap">
                    <button type="button" name="search-btn" id="search-btn" ng-click="selectPage(1)"
                     class="btn btn-primary" style="width: 128px;"><i class="fa fa-search white"></i> 查询
                    </button>
                </div>
                <div class="col-sm-2">
                    <button type="button" class="btn btn-success" id="btnExport" >
                        <i class="fa fa-download white"> </i> 导出</button>
                </div>
			</div>
		</form:form>
		<div class="col-lg-12" style="margin: 20px 0;">
			<div class="btn-group pull-left tab_button">
				<button class="btn btn-default btn-nobg-radius btn-active"
					ng-click="consumeway('')">全部</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(0)">余额记录</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(6)">油气记录</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(1)">卓币记录</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(4)">保证金记录</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(5)">保险记录</button>
				<button class="btn btn-nobg-radius btn-default"
					ng-click="consumeway(10)">账户系统记录</button>
			</div>
			<!--         <a class="pull-right see" href="#">
            查看全部运单
        </a> -->
		</div>
		<div class="col-lg-12">
			<table class="table">
				<thead>
					<tr>
						<th>消费项目</th>
						<th>金额</th>
						<th>消费方式</th>
						<th>状态</th>
						<th>消费时间</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="x in data">
						<td>{{x.consumetype}}</td>
						<td title=""><span ng-if="x.aftermony-x.beforemony<0"
							style="color: red; font-weight: bold;">-</span> <span
							ng-if="x.aftermony-x.beforemony>0"
							style="color: green; font-weight: bold;">+</span>
							{{x.consumemony}}</td>
						<td>{{x.consumeway}}</td>
						<td>{{x.consumestatus}}</td>
						<td>{{x.createDate}}</td>
						<td><a href="" class="see">详情</a></td>
					</tr>


				</tbody>
			</table>
			<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                		<img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                	</div>
                	<div class="loading">
	                	<img src="/static/images/loading.gif">
					    <p>加载中</p>
				    </div>
					<div class="fixed-table-pagination">
						<div class="pull-left pagination-detail">
							<span class="pagination-info">显示第 {{mincount}} 到第 {{maxcount}} 条记录，总共 {{totalcount}} 条记录</span>
						</div>
						<div class="pull-right paging"  id="paging">
							<ul class="pagination" id="pagination" on-select-page="selectPage(page)">
								<li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">第一页</a></li>
								<li  ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">‹</a></li>
								<li  ng-repeat="page in pages" ng-class="{active: isActive(page)}">
									<a ng-click="selectPage(page)" >{{page}}</a>
								</li>
								<li  ng-class="{disabled: noNext()}"><a ng-click="selectNext()">›</a></li>
								<li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">最后一页</a></li>
							</ul>
						</div>
					</div>
		</div>
		<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
			type="text/javascript"></script>
		<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
		<script
			src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
		<script
			src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
	var consumeway='';

///定义module
var app = angular.module("dataHall", []);
///控制方法
app.controller('dataHallCtrl', function ($scope, $http) {
    $scope.currentPage = 1;
    $scope.pageSize = 5;
    $scope.pages = [];
	$scope.trademodel='';
	$scope.totalcount = 0;
    $scope.mincount = 0;
    $scope.maxcount = 0;
    ////isloading ==1:加载数据2:查询不到数据3:查询到数据
    $scope.isloading = function (isloading) {
        if (isloading ==1 ){
            $(".loading").show();
            $("#noneData").hide();
        }else if (isloading==2){
            $(".loading").hide();
            $("#noneData").show();
        }else{
            $(".loading").hide();
            $("#noneData").hide();
            $(".datainit").removeClass("datainit");
            $("#page").css("display","block");

        }
    };
    //get first page
    $http({
        url: '${wlpt}/wlpt/consume/getRecodeList',
        method: 'post',
        params: {
        	 'searchinfo': $("#searchinfo").val(),
             'beginCreateDate': $("#beginCreateDate").val(),
             'endCreateDate': $("#endCreateDate").val(),
             'trademodel': $("#trademodel").val(),
             'consumeway':consumeway,
             'pageNo': $scope.currentPage,
             'pageSize': $scope.pageSize
        }
    }).success(function (response) {
        $scope.data = response.value.list;
        if(!$scope.data){
            $scope.isloading(2);
        }else{
            $scope.isloading(3);
        }
      	//记录数条数
        $scope.totalcount=response.value.count;
        $scope.mincount = Math.ceil($scope.currentPage * $scope.pageSize)-$scope.pageSize+1;
        if(response.value.count*1==0){
        	$scope.mincount = 0;
        }
        $scope.maxcount = Math.ceil($scope.currentPage * $scope.pageSize);
        if($scope.maxcount*1>response.value.count*1){
        	$scope.maxcount = response.value.count;
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
    ////分页查询
    $scope.onSelectPage = function (page) {
        //replace your real data
        $scope.isloading(1);
        $http({
            url: '${wlpt}/wlpt/consume/getRecodeList',
            method: 'post',
            params: {
                'searchinfo': $("#searchinfo").val(),
                'beginCreateDate': $("#beginCreateDate").val(),
                'endCreateDate': $("#endCreateDate").val(),
                'trademodel': $("#trademodel").val(),
                'consumeway':consumeway,
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {

            $scope.data = response.value.list;
            $scope.pages=[];
            if(!$scope.data){
                $scope.isloading(2);
            }else{
                $scope.isloading(3);
            }
            
          	//记录数条数
            $scope.totalcount=response.value.count;
            $scope.mincount = Math.ceil($scope.currentPage * $scope.pageSize)-$scope.pageSize+1;
            if(response.value.count*1==0){
            	$scope.mincount = 0;
            }
            $scope.maxcount = Math.ceil($scope.currentPage * $scope.pageSize);
            if($scope.maxcount*1>response.value.count*1){
            	$scope.maxcount = response.value.count;
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
    
    $scope.consumeway=function(val){
    	consumeway=val;
		$scope.onSelectPage(1);
	}
});
///分页
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
