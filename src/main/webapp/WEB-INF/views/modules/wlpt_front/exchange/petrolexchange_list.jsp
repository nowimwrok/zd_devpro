<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head> 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>油气兑换余额申请列表</title>
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
.goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        .goods-manage td .last a {
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
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
<ul class="qiye_menu">
		<li data-type="1"><a href="${wlpt}/wlpt/consume/toPetrolconsumeList" target="content" style="color: #000;">一卡通消费记录</a></li>
		<li data-type="2"><a href="${wlpt}/wlpt/consume/myMetroPosList" target="content" style="color: #000;">我的POS机</a></li>
		<li data-type="3" class="qiye_menu_1"><a href="${wlpt}/wlpt/petrolexchange/myPetrolExchangeList" target="content" style="color: #000;">油气兑换</a></li>
	</ul>
	
	<p class="user_data">
		<img src="/static/images/wlptfront/line-left.png"><span
			class="title_blue">余额兑换</span><span class="title_orange">列表</span><img
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
			<button type="button" style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;border-color:#FFC52F;margin-left:15px;background-color:#FFC52F;margin-right:30px;"
                class="btn btn-warning"
				ng-click="selectPage(1)">
				<span class="glyphicon glyphicon-search"></span><span
					class="goods_search_btn">搜索</span>
			</button>
			<a class="icon_blue fabu" id="fabu" style="margin: 0px;" href="${wlpt}/wlpt/petrolexchange/toApplyPetrolExchange"
            target="content"><span class="btn btn-warning"
                                                            style="border-radius:0px;background-color:#FFC52F;border-color:#FFC52F;width:80px;height:36px;">申请兑换</span></a>
		</div>
	</form:form>

	<table class="goods-manage">
		<thead>
			<tr class="goods_col_1" style="border: none;">
				<td style="width: 20%">兑换号</td>
				<td style="width: 20%">兑换金额</td>
				<td style="width: 15%;" >兑换条数</td>
				<td style="width: 18%;">状态</td>
				<td style="width: 18%">申请时间</td>
				<td style="width:20%">操作</td>
			</tr>
		</thead>
		<tbody class="datainit">
			<tr ng-repeat="x in data">
				<td>{{x.exchangeNo}}</td>
				<td>{{x.totalcost}}</td>
				<td>
					{{x.exchangeCount}}
				</td>
				<td>{{x.statusName}}<span ng-if="(x.status==4) && x.invoiceStatusName != ''">&nbsp;|&nbsp;{{x.invoiceStatusName}}</span></td>
				<td>{{x.createDate}}</td>
				<td>
                <p class="last"><a href="${wlpt}/wlpt/petrolexchange/toPetrolExchangeInfo?id={{x.id}}" target="content"
                                   class="btn btn-warning">查看</a>
                </p>
                <p class="last" ng-if="(x.status==4) && (x.invoiceStatus !=2 && x.invoiceStatus!=1 )">
                    <a href="javascript:;" ng-click="editInvoiceStatus(x.id)" class="btn btn-warning">已开发票</a>
                </p>
                </td>
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
        $scope.editInvoiceStatus = function (id) {
            $(".loading").show();
            if (id == null || id == "") {
                return;
            }
            $.MsgBox.Confirm("开票提示","确定已开发票,是否继续操作?",function(){
                $.ajax({
                    url: "${wlpt}/wlpt/petrolexchange/editInvoiceStatus",
                    method: 'post',
                    data: {
                        id: id,
                        invoiceStatus:1
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                    	if(data.value==1){
                    		$.MsgBox.Alert("开票提示","操作成功");
                    	}else{
                    		$.MsgBox.Alert("开票提示","操作失败");
                    	}
                        
                        $(".loading").hide();
                        $scope.selectPage (1);
                    }
                });
            },function(){
                $(".loading").hide();
            },null,null,"是","否");

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
            url: '${wlpt}/wlpt/petrolexchange/getPetrolExchangeList',
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
                url: '${wlpt}/wlpt/petrolexchange/getPetrolExchangeList',
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
