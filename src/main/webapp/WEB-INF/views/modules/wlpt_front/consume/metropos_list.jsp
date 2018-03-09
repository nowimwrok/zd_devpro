<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head> 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>我的POS机列表</title>
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
.div1_line1 {
    width: 75%;
    margin: 0 auto;
    text-align: center;
    overflow: hidden;
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
<body style="height: 1300px;" ng-app="dataHall"
	ng-controller="dataHallCtrl">
	<%--<ul class="count_menu">
    <li class="count_menu_1"><a href="账户充值.html">账户充值</a></li>
    <li><a href="#">担保金充值</a></li>
    <li><a href="授信额度.html">授信额度</a></li>
</ul>--%>
	<ul class="qiye_menu">
		<li data-type="1"><a href="${wlpt}/wlpt/consume/toPetrolconsumeList" target="content" style="color: #000;">一卡通消费记录</a></li>
		<li data-type="2" class="qiye_menu_1"><a href="${wlpt}/wlpt/consume/myMetroPosList" target="content" style="color: #000;">我的POS机</a></li>
	</ul>
	<p class="user_data">
		<img src="/static/images/wlptfront/line-left.png"><span
			class="title_blue">兑换</span><span class="title_orange">余额</span><img
			src="/static/images/wlptfront/line-right.png">
	</p>


	<div class="count_div1">
		<div class="div1_line1">
			<p>
				<span class="now_count">当前账户可用余额：</span><span class="count_price">￥${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}</span>元
			</p>

			<p>
            <span class="count_state">油气余额：</span><span class="count_price">${not empty user.userPurse.petrolbalance ? user.userPurse.petrolbalance:'0.00'}</span>元
        </p>
		</div>
		<!-- <p class="div1_line2">
			为了保护你的账户余额安全，请认真阅读《<a target="_blank"
				onclick="openagreement('prepaidAgreement');" class="agreement">卓大物流平台充值服务协议</a>》，如需提现，请致电客服进行申请和审核
		</p> -->
		<%-- <p class="div1_line3">
			<a href="${wlpt}/wlpt/consume/toExchangePetro"
				class="btn btn-warning bg_blue">油气兑换余额</a>
		</p> --%>
		<p class="div1_line3">
			<a href="${wlpt}/wlpt/petrolexchange/myPetrolExchangeList"
				class="btn btn-warning bg_blue">油气兑换余额</a>
		</p>
	</div>
	<p class="user_data">
		<img src="/static/images/wlptfront/line-left.png"><span
			class="title_blue">我的</span><span class="title_orange">POS机</span><img
			src="/static/images/wlptfront/line-right.png">
	</p>
	<form:form id="searchForm" modelAttribute="consumerecod"
		action="${wlpt}/wlpt/consume/getMetroPosList" method="post"
		class="breadcrumb form-search " cssStyle="padding: 30px 15px">
		<div class="select_title" style="margin: 0px; padding: 0px;">
			<input type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="beginCreateDate" id="beginCreateDate"
				placeholder="选择开始时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> —— <input
				type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="endCreateDate" id="endCreateDate"
				placeholder="选择结束时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> 
			<button type="button" class="btn btn-warning btn-search"
				ng-click="selectPage(1)">
				<span class="glyphicon glyphicon-search"></span><span
					class="goods_search_btn">搜索</span>
			</button>
			
		</div>
	</form:form>

	<table class="goods-manage">
		<thead>
			<tr class="goods_col_1" style="border: none;">
				<td style="width: 12%">店铺名称</td>
				<td style="width: 20%">POS机工号</td>
				<td style="width: 12%;" >会员姓名</td>
				<td style="width: 30%;text-align: center" >备注</td>
				<td style="width: 18%">绑定时间</td>
			</tr>
		</thead>
		<tbody class="datainit">
			<tr ng-repeat="x in data">
				<td>{{x.storeName}}</td>
				<td>{{x.useraccount}}</td>
				<td>
					{{x.memberName}}
				</td>
				<td>{{x.remarks}}</td>
				<td>{{x.createDate}}</td>
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
            } else {
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        /* $scope.exportExcel = function () {
            $http({
                url: '${wlpt}/wlpt/consume/export',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endOperateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {

            });
        }; */
        //get first page
        $http({
            url: '${wlpt}/wlpt/consume/getMetroPosList',
            method: 'post',
            params: {
                'beginOperateDate': $("#beginCreateDate").val(),
                'endOperateDate': $("#endCreateDate").val(),
                /* 'trademodel': $("#trademodel").val(), */
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
        	if (!response.value) {
                $scope.isloading(2);
            } else {
                $scope.isloading(3);
            }
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
                url: '${wlpt}/wlpt/consume/getMetroPosList',
                method: 'post',
                params: {
                    'beginOperateDate': $("#beginCreateDate").val(),
                    'endOperateDate': $("#endCreateDate").val(),
                    /* 'trademodel': $("#trademodel").val(), */
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
