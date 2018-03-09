<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的竞标</title>
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

        table tr td {
            text-align: center;
        }

        .datainit {
            display: none;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body ng-app="bid" ng-controller="bidCtrl" style="height: 950px;">
<input type="hidden" id="loginUser" value="${loginUser.id}">
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png">
    <span class="title_blue">我的</span><span class="title_orange">竞标</span><img
        src="${ctxStatic }/images/wlptfront/line-right.png">
</p>
<div class="zhapbiao_search">
    <input type="text" placeholder="竞标文号/招标文号" style="width: 25%;" class="tender_search search_text" ng-model="bidcode">
    <%--<div class="start_end_time">--%>
    <%--<input type="text" placeholder="开始时间" class="tender_search" ng-model="publishtime"><br/>--%>
    <%--<input type="text" placeholder="结束时间" class="tender_search" ng-model="endtime">--%>
    <%--</div>--%>

    <input id="fromprovince" type="hidden" class="tender_search"/>
    <input id="fromcity" type="hidden" class="tender_search"/>
    <input type="text" readonly="readonly" class="tender_search" id="addressStart" placeholder="始发地">
    <input id="toprovince" type="hidden" class="tender_search"/>
    <input id="tocity" type="hidden" class="tender_search"/>
    <input type="text" readonly="readonly" id="addressEnd" class="tender_search" placeholder="目的地">

    <button class="btn btn-warning" id="btn-warning"
            style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;"
            ng-click="selectPage(1)">
        <span class="glyphicon glyphicon-search"></span>
        <span class="goods_search_btn" ng-click="selectPage(1)">搜索</span>
    </button>
</div>

<table class="goods-manage tender_table">
    <tr class="goods_col_1" style="border:none;">
        <td style="width:35%">货品名称</td>
        <td style="width:33%">运输信息</td>
        <td style="width:20%">状态</td>
        <td style="width:20%">操作</td>
    </tr>
</table>
<div class="datainit">
    <table class="white_grey_table" ng-repeat="x in data">
        <tr class="bg_grey">
            <td style="width:36%;">招标文号：{{x.bidinfo.bidcode}}</td>
            <td style="width:33%;"></td>
            <td style="width:18.5%;">{{x.biddingstatus}}</td>
            <td></td>
        </tr>
        <tr>
            <td>
                <h5>{{x.bidinfo.goods.goodsname}}</h5>
                <p>{{x.bidinfo.goods.freightvolume| number : 2}}{{x.bidinfo.goods.freightunit}}</p>
            </td>
            <td>
                <p>始发地：{{x.bidinfo.goods.shipAddress.city}}</p>
                <p>目的地：{{x.bidinfo.goods.consignAddress.city}}</p>
            </td>
            <td style="width:20%;padding-left:2%;" class="whi-grey-last">竞标时间：{{x.createDate.substr(0,10)}}</td>

            <td class="whi-grey-last">
                <a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId={{x.bidinfo.id}}&biddingprice={{x.biddingprice}}">详情</a>
            </td>
        </tr>
    </table>
</div>
<div class="loading"><img src="/static/images/loading.gif">
    <p>加载中</p>
</div>
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

</body>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script>
    $(".white_grey_table>tr td").eq(3).addClass("whi-grey-last");


    var app = angular.module("bid", []);
    app.controller('bidCtrl', function ($scope, $http) {
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
        //get first page
        $http({
            url: '${wlpt}/wlpt/bid/getbiddingList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize,
                'bidinfo.bidcode': $scope.bidcode,
                'bidinfo.goods.shipAddress.province': $("#fromprovince").val(),
                'bidinfo.goods.shipAddress.city': $("#fromcity").val(),
                'bidinfo.goods.consignAddress.province': $("#toprovince").val(),
                'bidinfo.goods.consignAddress.city': $("#tocity").val(),
                'biddinguser.id': $("#loginuser").val()
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if (!$scope.data) {
                $scope.isloading(2);
            } else {
                $scope.isloading(3);
            }
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
            ///当数据为空的时候
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
            //分页要repeat的数组  pages---显示的分页页码
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }

        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/bid/getbiddingList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'bidinfo.bidcode': $scope.bidcode,
                    'bidinfo.goods.shipAddress.province': $("#fromprovince").val(),
                    'bidinfo.goods.shipAddress.city': $("#fromcity").val(),
                    'bidinfo.goods.consignAddress.province': $("#toprovince").val(),
                    'bidinfo.goods.consignAddress.city': $("#tocity").val(),
                    'biddinguser.id': $("#loginuser").val()
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
                //分页要repeat的数组
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
    $("#addressStart").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }
            $("#addressStart").val(str);
        }
    });

    $("#addressEnd").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }

            $("#addressEnd").val(str);
        }
    });


</script>
</html>

