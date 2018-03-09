<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的招标</title>
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

        .datainit {
            display: none;
        }

        .loading{
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

    </style>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
</head>
<body ng-app="bid" ng-controller="bidCtrl" >

<div>

    <input type="hidden" id="loginUser" value="${loginUser.id}">

    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png">
        <span class="title_blue">我的</span><span class="title_orange">招标</span>
        <img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div class="zhapbiao_search">
        <input type="text" placeholder="招标文号" class="tender_search search_text" ng-model="bidcode" id="bidcode">
        <input type="text" placeholder="货物名称" class="tender_search search_text" ng-model="goodsName" id="goodsName">
        <%--<div class="start_end_time">--%>
        <%--<input type="text" placeholder="开始时间" class="tender_search" ng-model="publishtime"><br/>--%>
        <%--<input type="text" placeholder="结束时间" class="tender_search" ng-model="endtime">--%>
        <%--</div>--%>


        <input id="fromprovince" type="hidden" class="tender_search" ng-model="fromprovince"/>
        <input id="fromcity" type="hidden" class="tender_search" ng-model="fromcity"/>
        <input type="text" readonly="readonly" class="tender_search search_text" id="addressStart" placeholder="始发地">

        <input id="toprovince" type="hidden" class="tender_search" ng-model="toprovince"/>
        <input id="tocity" type="hidden" class="tender_search" ng-model="tocity"/>
        <input type="text" readonly="readonly" id="addressEnd" class="tender_search search_text" placeholder="目的地">


        <button class="btn btn-warning" id="btn-warning"
                style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;"
                ng-click="onSelectPage(1)">
            <span class="glyphicon glyphicon-search"></span>
            <span class="goods_search_btn" ng-click="onSelectPage(1)">搜索</span>
        </button>

        <a href="${wlpt}/wlpt/bid/publshBid" id="fabu" onclick="return check();">
            <button class="btn btn-warning" id="btn-warning"
                    style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;">
                <span class="goods_search_btn">发布</span>
            </button>
        </a>
    </div>

    <table class="goods-manage tender_table">
        <tr class="goods_col_1" style="border:none;">
            <td style="width:30%">货品名称</td>
            <td style="width:30%">运输信息</td>
            <td style="width:20%">状态</td>
            <td style="width:20%">操作</td>
        </tr>
    </table>
    <div class="datainit">
        <table class="white_grey_table" ng-repeat="x in data">

            <tr class="bg_grey">
                <td style="width:28.5%;">招标文号：{{x.bidcode}}</td>
                <td style="width:33%;">{{x.biduser.loginName}}</td>
                <td style="width:18.5%;">
                    {{x.bidstatus=='发布'?'竞标中':x.bidstatus}}
                </td>
                <td></td>
            </tr>

            <tr>
                <td>
                    <h5>{{x.goods.goodsname}}</h5>
                    <p>{{x.goods.freightvolume| number : 3}}{{x.goods.freightunit}}</p>
                </td>

                <td>
                    <p>始发地：{{x.goods.shipAddress.city}}</p>
                    <p>目的地：{{x.goods.consignAddress.city}}</p>
                </td>

                <td style="width:20%;" class="whi-grey-last">
                    <p> 应标&nbsp;&nbsp;<span style="color: red;font-size:18px; font-weight:bold; ">{{x.biddingcount}}</span>&nbsp;&nbsp;次</p>
                    <p>发布时间：{{x.publishtime.substr(0,16)}}</p>
                </td>

                <td class="">
                    <p>
                        <a class="btn btn-warning btn-sm" style="color: white;background-color: #FFC52F"
                           href="${wlpt}/wlpt/bid/bidDetails?bidinfoId={{x.id}}"> 详&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;情</a>
                    </p>
                    <p>
                        <a class="btn  btn-warning btn-sm" style="color: white;background-color: #FFC52F"
                           ng-if="x.bidstatus=='已截标'"
                           href="javascript:void(0)" ng-click="repealBid(x.id)" >废&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标</a>
                    </p>
                    <p>
                        <a class="btn  btn-warning btn-sm" style="color: white;background-color: #FFC52F"
                           href="${wlpt}/wlpt/bid/goSelectBid?bidinfoId={{x.id}}" ng-if="x.bidstatus=='发布'|| x.bidstatus=='已截标'">选标结果</a>
                    </p>
                </td>
            </tr>
        </table>
    </div>
    <div class="loading">
        <img src="/static/images/loading.gif">
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
</div>
</body>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>

<script>
if('${isRedrect}'== 'true'){
	$("#fromprovince").val($.cookie("bid_fromprovince"));
	$("#fromcity").val($.cookie("bid_fromcity"));
	$("#addressStart").val($.cookie("bid_addressStart"));
	$("#toprovince").val($.cookie("bid_toprovince"));
	$("#tocity").val($.cookie("bid_tocity"));
	$("#addressEnd").val($.cookie("bid_addressEnd"));
	$("#bidcode").val($.cookie("bid_bidcode"));
	$("#goodsName").val($.cookie("bid_goodsName"));
}
    $(".white_grey_table>tr td").eq(3).addClass("whi-grey-last");

    var app = angular.module("bid", []);
    app.controller('bidCtrl', function ($scope, $http) {


        $scope.currentPage = 1;
        var pageno1 = $.cookie("bid_pageno");
        if(pageno1!=undefined && pageno1*1>1){
        	$scope.currentPage = pageno1*1;
        }
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
            url: '${wlpt}/wlpt/bid/getbidsList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize,
                'bidcode': $scope.bidcode,
                'goods.goodsname': $scope.goodsName,
                'goods.shipAddress.province': $scope.fromprovince,
                'goods.shipAddress.city': $scope.fromcity,
                'goods.consignAddress.province': $scope.toprovince,
                'goods.consignAddress.city': $scope.tocity,
                'biduser.id': $("#loginUser").val()
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if (!$scope.data) {
                $scope.isloading(2);
            } else {
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
                url: '${wlpt}/wlpt/bid/getbidsList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'bidcode': $scope.bidcode,
                    'goods.goodsname': $scope.goodsName,
                    'goods.shipAddress.province': $scope.fromprovince,
                    'goods.shipAddress.city': $scope.fromcity,
                    'goods.consignAddress.province': $scope.toprovince,
                    'goods.consignAddress.city': $scope.tocity,
                    'biduser.id': $("#loginUser").val()
                }
            }).success(function (response) {
            	$.cookie("bid_fromprovince",$("#fromprovince").val());
            	$.cookie("bid_fromcity",$("#fromcity").val());
            	$.cookie("bid_addressStart",$("#addressStart").val());
            	$.cookie("bid_toprovince",$("#toprovince").val());
            	$.cookie("bid_tocity",$("#tocity").val());
            	$.cookie("bid_addressEnd",$("#addressEnd").val());
            	$.cookie("bid_bidcode",$("#bidcode").val());
            	$.cookie("bid_goodsName",$("#goodsName").val());
            	$.cookie("bid_pageno",$scope.currentPage);
                $scope.data = response.value.list;
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);
                }
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
            });
        };


        $scope.repealBid= function (id) {
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/bid/repealBid',
                method: 'post',
                params: {
                    'id':id
                }
            }).success(function (data) {
                $scope.isloading(3);
                $.MsgBox.Alert("保存提示", data.message);
                $scope.onSelectPage($scope.currentPage);
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
    function check() {
        var status = "${loginUser.userinfo.status}";
        if (status != '2') {
            $("#fabu").tips({
                side: 3,
                msg: '您还未认证！',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        return true;
    }
</script>
</html>

