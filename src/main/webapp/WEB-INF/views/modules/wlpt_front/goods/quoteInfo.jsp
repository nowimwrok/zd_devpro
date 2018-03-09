<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>报价查看</title>
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
        height:1200px
    }
        ul p span a input td {
            font-family: "微软雅黑";
        }

        .goods-manage td, .goods-manage th {
            text-align: center;
        }
        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }
        .goods-manage td .last a{
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color:#FFC52F;
            border-color:#FFC52F;
            margin-bottom: 5px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="tab_fir tab-all" id="tab-first">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">司机</span><span class="title_orange">报价</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>

    
        <table class="goods-manage" style="margin-bottom: 0px;">
            <tr class="goods_col_1" style="border:none;">
                <td style="width:20%">司机</td>
                <td style="width:20%">车辆</td>
                <td style="width:13%">报价</td>
                <td style="width:10%">诚信</td>
                <td style="width:14%">发布日期</td>
                <td style="width:13%">操作</td>
            </tr>
            <tr ng-repeat="x in data" style="border:none;" class="col-line">
                <td>
                    <p>
                        <span class="per_car">{{x.user.loginName}}</span>
                    </p>
                    <p>
                        <span class="bg_light_blue">已认证</span>
                        <span class="bg_light_blue">担保金</span>
                    </p> 
                    <p>
                        <span>{{x.driver.name}}</span>
                        <span>{{x.driver.phone}}</span>
                    </p>
                </td>
                <td>
                    <span>{{x.car.carnumber}}</span><br>
                    <span ng-if="x.car.id!='' && x.car.id!=null">{{x.car.cartype}}|{{x.car.loadweight}}{{x.car.weightunit}}|{{x.car.carlength}}{{x.car.lengthunit}}</span>  
                </td>
                <td class="right_orange cols_orange"><span>{{x.ooferprice}}元/{{x.goods.freightunit}}</span><br><span>{{x.oddloadweight}}{{x.goods.freightunit}}</span></td>
                <td><img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_{{x.driver.credit != null ? x.driver.credit : 0}}.gif"></td>
                <td>
                	<span>{{x.createDate.substr(0,10)}}</span>
                	<span ng-if="x.quotestatus==2 && x.isreload==1">
                	<br>实际配载:{{x.actload}}{{x.goods.freightunit}}
                	</span>
                	
                </td>
                <td>
                    <p class="last" ng-switch on="{{x.quotestatus}}">
                       <a href="${wlpt}/wlpt/goods/quoteOrder?id={{x.id}}" ng-switch-when="1" class="btn btn-warning">生成运单</a>
                       <a href="javascript:;" ng-click="isAgree(x.id)" ng-switch-when="1" class="btn btn-warning" id="agree">拒绝报价</a>
                       <a href="${wlpt}/wlpt/trade/trade_list?searchinfo={{x.car.carnumber}}" ng-switch-when="2" class="btn btn-warning">查看运单</a>
                       <label ng-switch-when="3" class="btn btn-warning" style="padding: 3px 12px; width: 95px; border-radius: 0px;background-color:#FFC52F; border-color:#FFC52F;">未通过</label>
                       <a href="${wlpt}/wlpt/trade/trade_list?searchinfo={{x.car.carnumber}}" ng-switch-when="4" class="btn btn-warning">交易取消</a>
                    </p>
                </td>
            </tr>  
        </table>
        <div class="loading"><img src="/static/images/loading.gif"><p>加载中</p></div>
        <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>
        <div class="paging" id="paging">
        <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">第一页</a></li>
        <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></li>
        <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
            <a ng-click="selectPage(page)">{{page}}</a>
        </li>
        <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">最后一页</a></li>
    </ul>
</div>
    </div>  
    <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">运单</span><span class="title_orange">规则</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
            1.司机报价为运输单价。<br>
            2.当您生成了运单，系统将自动从您的账户上扣除运费。<br>
            3.运单结束后，运费从平台支付给司机。
        </p>
    </div>
    <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span class="title_orange">详情</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
        <input id="gsid" name="id"  value="${goods.id}" type="hidden"/>
            <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${goods.goodsname}</span></td>
            </tr>

            <tr>
                <td class="cols_1">始发地：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.city}${goods.shipAddress.district}
                </td>
            </tr>

            <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.address }
                </td>
            </tr>

            <tr>
                <td class="cols_1">目的地：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.city }${goods.consignAddress.district }
                </td>
            </tr>

             <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.address }</td>
            </tr>
            <tr>
                <td class="cols_1">货物重量：</td>
                <td class="cols_2" colspan=3>${goods.freightvolume }吨</td>

            </tr>
            <tr>
                <td class="cols_1">车型要求：</td>
                <td class="cols_2">${goods.cartype }</td>
                <td class="cols_3">车长要求：</td>
                <td class="cols_4">${goods.carlength }米</td>
            </tr>
            <tr>
                <td class="cols_1">用户名：</td>
                <td class="cols_2" colspan=3><span class="per_car">${goods.user.name }</span>
                <c:if test="${goods.user.userinfo.status == '2' }">
                <span class="list_one_2 bg_light_green">已认证</span></c:if>
                <c:if test="${goods.user.userinfo.status != '2' }">
                <span class="list_one_2 bg_light_green">未认证</span></c:if></td>
            </tr>

            <tr>
                <td class="cols_1">信誉等级：</td>
                <td class="cols_2"><img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif"></td>
                <td class="cols_3">担保金额:</td>
                <td class="cols_4"><span class="orange_bold">${goods.user.userPurse.guaranteemone}</span>元</td>
            </tr>
            <tr>
                <td class="cols_1">发货时间：</td>
                <td class="cols_2" colspan=3>${sendtime}</td>

            </tr>
            <tr>
                <td class="cols_1">补充说明：</td>
                <td class="cols_2" colspan=3>${goods.remarks }</td>

            </tr>
            </table>
        </p>
    </div>
   <script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
   <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
   <script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script>
    var id = $("#gsid").val();
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
    	$scope.gsid=id;
        $scope.currentPage = 1;
        $scope.pageSize = 2;
        $scope.pages = [];
        $scope.isAgree = function (id) {

            if (id == null || id == "") {
                return;
            }
            $.ajax({
                url: "${wlpt}/wlpt/goods/isAgree",
                data: {
                    id: id,
                },
                dataType: 'json',
                cache: false,
                success: function (data) {
                    $scope.onSelectPage(1);
                  //  alert(data.value);
                  //  $("#agree").html("未通过");
                }
            });
        };
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
            }
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/goods/getQuoteInfo',
            method: 'post',
            params: {
            	'id':$scope.gsid,
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {        	
            $scope.data = response.value.list;
            if($scope.data[0].driver){
            	console.log($scope.data[0].driver.credit);
            }
            if(!$scope.data){
                $scope.isloading(2);
            }else{
                $scope.isloading(3);
            }
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/goods/getQuoteInfo',
                method: 'post',
                params: {
                	'id':$scope.gsid,
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


                    if (!scope.isActive(page)) {
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
