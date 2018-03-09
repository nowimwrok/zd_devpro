<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>选择中标</title>
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
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body ng-app="selectBid" ng-controller="selectBidCtrl">

<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">我的</span><span
        class="title_orange">招标</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
</p>

<div class="zhapbiao_search">
    <input type="text" placeholder="招标文号" class="tender_search search_text">
    <input type="text" placeholder="货物名称" class="tender_search search_text" style="margin-right: 5px;"><span
        class="">--</span>
    <input type="text" placeholder="体积/重量" class="tender_search search_text">

    <button class="btn btn-warning" id="btn-warning"
            style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;">
        <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
    </button>
</div>

<table class="goods-manage tender_table">
    <tr class="goods_col_1" style="border:none;">
        <td style="width:20%">竞标人</td>
        <td style="width:20%">竞标信息</td>
        <td style="width:20%">竞标时间</td>
        <td style="width:15%">诚信</td>
        <td style="width:10%">状态</td>
        <td style="width:15%">操作</td>
    </tr>
</table>
<div class="loading"><img src="/static/images/loading.gif">
    <p>加载中</p></div>

<div class="">
    <table class="white_grey_table">
        <tr ng-repeat="x in data">
            <td style="width:20%">{{x.biddinguser.loginName}}</td>
            <td style="width:20%">{{x.bidinfo.goods.freightvolume| number : 2}}{{x.bidinfo.goods.freightunit}}|出价:{{x.biddingprice}}</td>
            <td style="width:20%">{{x.createDate}}</td>
            <td style="width:15%">中标：&nbsp;<span style="color: red;font-size:18px; font-weight:bold; ">{{x.userStatistics.biddingcount}}</span>&nbsp;次 </td>
            <td style="width:10%">{{x.biddingstatus}}</td>
            <td style="width:15%" ng-if="x.biddingstatus=='竞标' ">
                <a href="javascript:void(0)" ng-click="check(x.id)">选择中标</a></td>
            <td style="width:20%" ng-if="x.biddingstatus=='中标' ">
                <a href="${wlpt}/wlpt/bid/notifys?biddingId={{x.id}}">查看中标通知</a>
            </td>
        </tr>
        <p ng-show="!data">
            抱歉！没有找到与您条件匹配的招标信息， 请重新搜索
        </p>
    </table>
</div>


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


<div class="content-2 shiming-list">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">招标</span><span
            class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <p class="list_two" style="text-align:center">

    </p>
</div>

<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>


    $(".loading").hide();

    var app = angular.module("selectBid", []);
    app.controller('selectBidCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];


        $scope.check = function (id) {
            if ($(".loading").is(':hidden')) {
                $(".loading").show();
                $.MsgBox.Confirm("中标提示", "是否选择中标?", function () {
                    window.location.href = "${wlpt}/wlpt/bid/bidNotifys?biddingId=" + id;
                }, function () {
                    $(".loading").hide();
                });
                return true;
            } else {
                return false;
            }

        };


        //get first page
        $http({
            url: '${wlpt}/wlpt/bid/getbiddingListbyBid',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize,
                'bidinfo.id': '${bidinfo.id}'
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $http({
                url: '${wlpt}/wlpt/bid/getbiddingListbyBid',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'bidinfo.id': '${bidinfo.id}'
                }
            }).success(function (response) {
                $scope.data = response.value.list;
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
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
