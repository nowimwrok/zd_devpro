<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>地址管理</title>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">


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

        .goods-manage td, .goods-manage th {
            text-align: center;
        }

        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        #noneData {
            text-align: center;
            width: 100%;
            line-height: 25px;
            display: none;
        }
    </style>
</head>
<body style="height: 900px;"  ng-app="dataHall" ng-controller="dataHallCtrl">
<p class="user_data">
    <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">地址</span><span
        class="title_orange">管理</span><img src="/static/images/wlptfront/line-right.png">
</p>
<div class="select_title">
    <input type="text" id="searchinfo" name="searchinfo" placeholder="城市/市区/联系人" class="transport_search">


    <button class="btn btn-warning" id="btn-warning" ng-click="selectPage(1)"
            style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;">
        <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
    </button>

    <shiro:hasPermission name="wlpt:user:address:view">
        <a class="icon_blue" style="margin: 0px;" id="fabu" href="${wlpt}/wlpt/address/from?isSave=true"
           target="content">
            <span class="glyphicon glyphicon-open " id="fubu"></span><span class="fabu">发布</span>
        </a>
    </shiro:hasPermission>
</div>

<table class="goods-manage">
    <tr class="goods_col_1" style="border:none;">
        <td style="width:30%">联系地址</td>
        <td style="width:12%">联系人</td>
        <td style="width:12%">联系电话</td>
        <td style="width:12%">地址类型</td>
        <td style="width:12%">操作</td>
    </tr>


    <tr ng-repeat="x in data">
        <td>{{x.province}}{{x.city}}{{x.district}}</td>
        <td>
            <p>{{x.linkman}}</p>
            <p>{{x.linkcompany}}</p>
        </td>
        <td>
            <p>{{x.linkmobile}}</p>
            <p>{{x.linktelphone}}</p>
        </td>
        <td>
            <p>{{x.type}}</p>
        </td>
        <shiro:hasPermission name="user">
            <td>
                <a href="${wlpt}/wlpt/address/from?id={{x.id}}&isSave=false" class="bianji">编辑</a>
                <a href="${wlpt}/wlpt/address/address_delet?id={{x.id}}" class="baojia">删除</a>
            </td>
        </shiro:hasPermission>
    </tr>


</table>
<div class="loading">
    <img src="/static/images/loading.gif">
    <p>加载中</p>
</div>
<div id="noneData">暂无数据</div>
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

<script type="text/javascript" src="/static/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>

<script>
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ////加载
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
            }
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/address/getAddresList',
            method: 'post',
            params: {
                'searchinfo': $("#searchinfo").val(),
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
            ///当数据为空的时候
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
                url: '${wlpt}/wlpt/address/getAddresList',
                method: 'post',
                params: {
                    'searchinfo': $("#searchinfo").val(),
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
