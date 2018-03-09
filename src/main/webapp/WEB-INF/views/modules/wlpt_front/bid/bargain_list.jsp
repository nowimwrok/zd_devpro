<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>运输合同</title>
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

        .white_grey_table td {
            padding: 0px;
        }

        .white_grey_table td p {
            margin: 5px 0px;
        }

        .whi-grey-btn {
            margin: 5px 0px;
        }

        .whi-grey-btn a {
            padding: 0px;
            display: block;
        }

        .datainit {
            display: none;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body ng-app="bid" ng-controller="bidCtrl">
<input type="hidden" id="loginUser" value="${loginUser.id}">
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png">
    <span class="title_blue">运输</span><span class="title_orange">合同</span>
    <img src="${ctxStatic }/images/wlptfront/line-right.png">
</p>
<div class="zhapbiao_search">
    <span>招标文号:</span>
    <input type="text" style="width:230px;height:35px;line-height:35px;" placeholder="招标文号"
           class="tender_search search_text" ng-model="bidcode">

    <button class="btn btn-warning" id="btn-warning"
            style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;"
            ng-click="onSelectPage(1)">
        <span class="glyphicon glyphicon-search"></span>
        <span class="goods_search_btn" ng-click="onSelectPage(1)">搜索</span>
    </button>
</div>


<table class="goods-manage tender_table">
    <tr class="goods_col_1" style="border:none;">
        <td style="width:37%">招标文号</td>
        <td style="width:30%">货物信息</td>
        <td style="width:20%">状态</td>
        <td style="width:20%">操作</td>
    </tr>
</table>
<div class="datainit">
    <table class="white_grey_table" ng-repeat="x in data">
        <tr class="bg_grey">
            <td style="width:35%;">招标文号：{{x.bidinfo.bidcode}}</td>
            <td style="width:33%;">
                <span ng-if="x.isBidUser==false">招标方:{{x.biduser.loginName}}</span>
                <span ng-if="x.isBidUser">竞标方:{{x.biddinguser.loginName}}</span>
            </td>
            <td style="width:18.5%;">{{x.contractStr}}</td>
            <td></td>
        </tr>
        <tr>

            <td>
                <p>始发地：{{x.bidinfo.goods.shipAddress.city}}{{x.bidinfo.goods.shipAddress.district}}</p>
                <p>目的地：{{x.bidinfo.goods.consignAddress.city}}{{x.bidinfo.goods.consignAddress.district}}</p>
            </td>

            <td>
                <h5>{{x.bidinfo.goods.goodsname}}</h5>
                <p>{{x.bidinfo.goods.gsoddtype}}</p>
            </td>

            <td style="width:20%;" class="whi-grey-last">
                <p>总量:{{x.bidinfo.goods.freightvolume | number : 3}}{{x.bidinfo.goods.freightunit}}</p>
                <p>
                    已运输:{{x.bidinfo.goods.freightvolume-x.bidinfo.goods.residualvolume | number :
                    3}}{{x.bidinfo.goods.freightunit}}</p>
                <p>未运输:{{x.bidinfo.goods.residualvolume | number : 3}}{{x.bidinfo.goods.freightunit}}</p>
            </td>

            <td class="whi-grey-last">
                <!-- 0新建合同，1运输中，2.申请运输完成3.运输完成申请驳回4.运输完成-->
                <%--<p class="whi-grey-btn">
                    <a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId={{x.id}}" class="btn btn-warning">提货单</a>
                </p>--%>
                <!--竞标用户获得合同显示状态:竞标用户发货-->
                <p class="whi-grey-btn" ng-if="x.bidinfo.goods.residualvolume>0 && x.isBidUser ==false">
                    <a href="${wlpt}/wlpt/bid/orderPubilshGoods?id={{x.id}}" class="btn btn-warning">发布货源</a>
                </p>

                <!--运输状态结束后不显示按钮-->
                <p class="whi-grey-btn" ng-if="x.contractstatus!=0 && x.contractstatus!=4">
                    <!--竞标用户获得合同显示状态:竞标用户申请-->
                    <a ng-if="(x.contractstatus==1 || x.contractstatus==3) && x.isBidUser==false "
                       ng-click="editStatus(x.id,0,2)" class="btn btn-warning">申请核单</a>
                    <!--竞标用户申请后显示状态:招标用户审核-->
                    <a ng-if="x.contractstatus==2 && x.isBidUser" ng-click="editStatus(x.id,0,4)"
                       class="btn btn-warning">核单通过</a>
                    <!--竞标用户申请后显示状态:竞标用户显示审核中-->
                    <a ng-if="x.contractstatus==2 && x.isBidUser ==false" class="btn btn-warning">核单中</a>
                    <!--审核通过后运输完成-->
                    <a ng-if="x.contractstatus==4" class="btn btn-warning">运输结束</a>
                </p>

                <p class="whi-grey-btn" ng-if="x.contractstatus==2 && x.isBidUser">
                    <a ng-click="editStatus(x.id,0,3)" class="btn btn-warning">核单驳回</a>
                </p>

                <!--0:未申请，1申请结算，2.申请失败驳回3，申请通过4.支付完成，5确认-->
                <p class="whi-grey-btn" ng-if="x.contractstatus==4">
                    <!--用户运输完成,竞标用户申请结算-->
                    <a ng-if="( x.settlestatus==0 || x.settlestatus==2 )&& x.isBidUser==false"
                       ng-click="editStatus(x.id,1,1)" class="btn btn-warning">申请结算</a>
                    <!--用户发起申请,招标用户同意结算-->
                    <a ng-if="x.settlestatus==1 && x.isBidUser" ng-click="editStatus(x.id,1,3)" class="btn btn-warning">结算通过</a>
                    <!--用户发起申请,竞标用户显示结算中-->
                    <a ng-if="(x.settlestatus==1 || x.settlestatus==3 ) && x.isBidUser==false" class="btn btn-warning">结算中</a>
                    <!--用户发起申请,招标用户同意结算后去结算-->
                    <a ng-if="x.settlestatus==3 && x.isBidUser " href="${wlpt}/wlpt/bid/toPay?id={{x.id}}"
                       class="btn btn-warning">去支付</a>
                    <!--用户发起申请,结算完成后,招标用户显示为已结算-->
                    <a ng-if="x.settlestatus==4 && x.isBidUser  && x.bidinfo.bidstatus ==3" class="btn btn-warning">已结算</a>
                    <a ng-if="x.settlestatus==4 && x.isBidUser && x.bidinfo.bidstatus !=3" class="btn btn-warning">待银行处理</a>
                    <!--用户发起申请,招标结算后竞标用户确认结算-->
                    <a ng-if="x.settlestatus==4 && x.isBidUser==false && x.bidinfo.bidstatus ==3" ng-click="editStatus(x.id,1,5)"
                       class="btn btn-warning">确认结算</a>
                    <a ng-if="x.settlestatus==5" class="btn btn-warning">交易完成</a>
                </p>

                <!--驳回申请-->
                <p class="whi-grey-btn" ng-if="x.contractstatus==4 && x.settlestatus==1 && x.isBidUser ">
                    <a ng-click="editStatus(x.id,1,2)" class="btn btn-warning">结算驳回</a>
                </p>

                <p class="whi-grey-btn" ng-if="x.contractstatus!=0">
                    <a href="${wlpt}/wlpt/bid/bidtrack?id={{x.id}}" class="btn btn-warning">车辆监控</a>
                </p>

            </td>
        </tr>
    </table>
</div>
<div class="loading"><img src="${ctxStatic }/images/loading.gif">
    <p>加载中</p></div>
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
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script>
    $(".white_grey_table>tr td").eq(3).addClass("whi-grey-last");

    var app = angular.module("bid", []);
    app.controller('bidCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 4;
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
        $scope.editStatus = function (id, type, status) {
            var editData = {};
            editData.id = id;
            var url = "editBidOrderStatus";
            if (type == 1) {
                editData.settlestatus = status;
                url = "editBidOrderSettle";
            } else {
                editData.contractstatus = status;
                url = "editBidOrderStatus";
            }
            $.MsgBox.Confirm("交易提示", "是否继续操作", function () {
                $.ajax({
                    url: "${wlpt}/wlpt/bid/" + url,
                    data: editData,
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("交易提示", data.message);
                        $scope.selectPage(1);
                    }
                });
            });

        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/bid/getBidOrderList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize,
                'bidinfo.bidcode': $scope.bidcode,
                'biduser.id': $("#loginuser").val()
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
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/bid/getBidOrderList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'bidinfo.bidcode': $scope.bidcode,
                    'biduser.id': $("#loginuser").val()
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
</html>

