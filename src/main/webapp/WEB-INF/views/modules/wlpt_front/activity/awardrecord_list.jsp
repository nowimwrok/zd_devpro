<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>微信活动中奖记录</title>
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
        .datainit{
            display: none;
        }
    </style>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">
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
<body style="height: 700px;" ng-app="dataHall" ng-controller="dataHallCtrl">

<p class="user_data">
    <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">中奖</span><span
        class="title_orange">记录</span><img src="/static/images/wlptfront/line-right.png">
</p>
<form:form id="searchForm" modelAttribute="consumerecod" action="${wlpt}/wlpt/consume/export" method="post"
           class="breadcrumb form-search " cssStyle="padding: 30px 15px">
    <div class="select_title" style="margin: 0px;padding: 0px;">
        <input type="text" readonly="readonly" class="car_phone_search" style="width: 23%" name="beginCreateDate"
               id="beginCreateDate"
               placeholder="选择开始时间" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
        ——
        <input type="text" readonly="readonly" class="car_phone_search" style="width: 23%" name="endCreateDate"
               id="endCreateDate"
               placeholder="选择结束时间" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">

        <select id="issuemodel" ng-model="issuemodel" name="issuemodel"
                class="input-medium car_search car_phone_search">
            <option value="" label="全部">全部</option>
            <option value="0">未发放</option>
            <option value="1">已发放</option>
            <option value="2">作废</option>
            <option value="3">已使用</option>
        </select>
        <button type="button" class="btn btn-warning btn-search" ng-click="selectPage(1)">
            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
        </button>
       
    </div>
</form:form>

<table class="goods-manage">
    <thead>
    <tr class="goods_col_1" style="border:none;">
        <td style="width:12%">活动名称</td>
        <td style="width:12%">奖品名称</td>
        <td style="width:20%;text-align: center">奖品类型</td>
        <td style="width:12%">奖品价值</td>
        <td style="width:20%;text-align: center">发放状态</td>
        <td style="width:20%">中奖时间</td>
    </tr>
    </thead>
    <tbody class="datainit">
    <tr ng-repeat="x in data">
        <td>{{x.wxinfo.activityName}}</td>
        <td>
            {{x.wxgift.giftname}}
        </td>
        <td>
        </td>
        	{{x.gifttypename}}
        <td>
            {{x.wxgift.giftworth}}
        </td>
        <td>
            {{x.issuename}}
        </td>
        <td>{{x.createtime}}</td>
    </tr>

    </tbody>
</table>
<div class="loading">
    <img src="/static/images/loading.gif">
    <p>
        加载中
    </p>
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
</div>
</div>

<script type="text/javascript" src="/static/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>

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
       
        //get first page
        $http({
            url: '${wlpt}/wlpt/activity/getAwardrecordList',
            method: 'post',
            params: {
                'timeStart': $("#beginCreateDate").val(),
                'timeEnd': $("#endCreateDate").val(),
                'issue': $("#issuemodel").val(),
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
                url: '${wlpt}/wlpt/activity/getAwardrecordList',
                method: 'post',
                params: {
                    'timeStart': $("#beginCreateDate").val(),
                    'timeEnd': $("#endCreateDate").val(),
                    'issue': $("#issuemodel").val(),
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
