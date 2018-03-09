<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>卓大物流平台</title>
    <link
            href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"
            rel="stylesheet">
    <style type="text/css">
        /*.loading {
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }*/
        .loading {
            text-align: center;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall"
     ng-controller="dataHallCtrl">
    <div class="col-lg-12 data-model">
        <div class="col-sm-2 bg_blue clearfix">
            <img src="${ctxStatic}/front/img/tender01.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">招标</span> <span
                class="pull-right data-num">${statistics.pubbidcount}</span>
        </div>
        <div class="col-sm-2 bg_light_green clearfix">
            <img src="${ctxStatic}/front/img/bid.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">竞标</span> <span
                class="pull-right data-num">${statistics.biddingcount}</span>
        </div>
        <div class="col-sm-2 bg_deep_greeen clearfix">
            <img src="${ctxStatic}/front/img/has_bid.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">报价</span> <span
                class="pull-right data-num">${statistics.quotecount}</span>
        </div>
        <div class="col-sm-2 bg_yellow clearfix">
            <img src="${ctxStatic}/front/img/waybill.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">运单</span> <span
                class="pull-right data-num">${statistics.tradeordercount}</span>
        </div>
        <div class="col-sm-2 bg_orange clearfix">
            <img src="${ctxStatic}/front/img/box.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">货源</span> <span
                class="pull-right data-num">${statistics.pubgodscount}</span>
        </div>
        <div class="col-sm-2 bg_red clearfix" style="margin-right: 0;">
            <img src="${ctxStatic}/front/img/car.png"
                 class="pull-left data-icon"> <span
                class="pull-left data-title">车辆</span> <span
                class="pull-right data-num">${statistics.addcarcount}</span>
        </div>
    </div>

    <div class="col-lg-12" style="margin: 20px 0;">

        <div class="btn-group pull-left tab_button">
            <div class="btn-group pull-left tab_button nav nav-tabs"
                 style="border: none;" id="tab_button_div">
                <input type="hidden" id="tab" value="trade"/>
                <button class="btn btn-default btn-nobg-radius btn-active"
                        data-toggle="tab" data-target="#latest_waybill"
                        id="trade_button" ng-click="searchInfo('trade');tab_info='trade'">最新运单
                </button>
                <button class="btn btn-nobg-radius btn-default" data-toggle="tab"
                        data-target="#latest_tender" id="bid_button" ng-click="searchInfo('bid');tab_info='bid'">最新招标
                </button>
                <button class="btn btn-nobg-radius btn-default" data-toggle="tab"
                        data-target="#latest_bid" id="bidding_button"
                        ng-click="searchInfo('bidding');tab_info='bidding'">最新竞标
                </button>
            </div>
        </div>
        <a class="pull-right see" href="${wlpt}/wlpt/trade/trade_list"> 查看全部运单 </a>
    </div>
    <div class="col-lg-12 tab-content" style="margin-bottom: 30px;">

        <div class="clearfix tab-pane fade in active" id="latest_waybill">
            <div style="overflow: auto;width: 100%;">
                <table class="table" id="latest_waybill_table">
                    <thead>
                    <tr>
                        <th>运单编号</th>
                        <th>操作</th>
                        <th>货物信息</th>
                        <th>路线</th>
                        <th>司机</th>
                        <th>车辆</th>
                        <th>运费（元）</th>
                        <th>时间</th>
                        <th>交易状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="x in data">
                        <td><a href="#" class="tdFir">{{x.orderno}}</a></td>
                        <td><a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_shadow&id={{x.id}}"
                               class="see oprate">详情</a></td>
                        <td
                                title="{{x.quoteinfo.goods.goodsname}}/整车/{{x.quoteinfo.oddloadweight}}{{x.quoteinfo.goods.freightunit}}">
                            {{x.quoteinfo.goods.goodsname}}<span
                                class="vertical-line">|</span>整车<span class="vertical-line">|</span>{{x.quoteinfo.oddloadweight}}{{x.quoteinfo.goods.freightunit}}
                        </td>
                        <td>
                            {{x.quoteinfo.goods.shipAddress.city}}{{x.quoteinfo.goods.shipAddress.district.substr(0,4)+'...'}}
                            -
                            {{x.quoteinfo.goods.consignAddress.city}}{{x.quoteinfo.goods.consignAddress.district.substr(0,4)+'...'}}
                        </td>
                        <td>{{x.quoteinfo.driver.loginName}}{{x.quoteinfo.driver.phone}}</td>
                        <td>{{x.quoteinfo.car.carnumber}}</td>
                        <td>{{x.totalcost}}</td>
                        <td>{{x.updateDate}}</td>
                        <td class="green">{{x.statusStr}}</td>

                    </tr>

                    </tbody>
                    <%--<tfoot>

                    <tr>
                    <tr>
                        <div class="loading">
                            <img src="/static/images/loading.gif"/>
                            <p>加载中</p>
                        </div>
                        <div id="noneData" style="display: none; text-align: center; width: 100%; line-height: 25px;">
                            <img src="${ctxStatic }/front/img/nodata.png"
                                 style="width: 100px; height: 100px;">
                        </div>
                    </tr>
                    </tfoot>--%>
                </table>
            </div>
            <!-- <div class="loading" style="text-align: center">
                <img src="/static/images/loading.gif">
                <p>加载中</p>
            </div> -->
            <!--分页-->
            <tm-pagination conf="paginationConf"></tm-pagination>
        </div>


        <div class="clearfix tab-pane fade" id="latest_tender">
            <div style="overflow: auto;width: 100%;">
                <table class="table" id="latest_tender_table">
                    <input type="hidden" id="loginUser" value="${statistics.user.id}">
                    <thead>
                    <tr>
                        <th>招标文号</th>
                        <th>操作</th>
                        <th>货物信息</th>
                        <th>路线</th>
                        <th>状态</th>
                        <th>招标时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="x2 in data2">
                        <td><a href="" class="tdFir">{{x2.bidcode}}</a></td>
                        <td><a class="orange oprate" href="${wlpt}/wlpt/bid/goSelectBid?bidinfoId={{x2.id}}"
                        >查看({{x2.biddingcount}})
                        </a></td>
                        <td title="{{x2.goods.goodsname}}/{{x2.goods.freightvolume| number :
                            3}}{{x2.goods.freightunit}}">{{x2.goods.goodsname}}<span
                                class="vertical-line">|</span> {{x2.goods.freightvolume| number :
                            3}}{{x2.goods.freightunit}}
                        </td>
                        <td title="{{x2.goods.shipAddress.city}} -
                            {{x2.goods.consignAddress.city}}">{{x2.goods.shipAddress.city}} -
                            {{x2.goods.consignAddress.city}}
                        </td>
                        <td><span class="green">{{x2.bidstatus=='发布'?'竞标中':x2.bidstatus}}</span></td>
                        <td>{{x2.publishtime.substr(0,16)}}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- <div class="loading" style="text-align: center">
                <img src="/static/images/loading.gif">
                <p>加载中</p>
            </div> -->
            <!--分页-->
            <tm-pagination conf="paginationConf2"></tm-pagination>
        </div>
        <div class="clearfix tab-pane fade" id="latest_bid">
            <div style="overflow: auto;width: 100%;">
                <table class="table" id="latest_bid_table">
                    <thead>
                    <tr>
                        <th>招标文号</th>
                        <!-- <th>操作</th> -->
                        <th>货物名称</th>
                        <th>货物重量/体积</th>
                        <th>路线</th>
                        <th>状态</th>
                        <th>竞标时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-repeat="x3 in data3">
                        <td><a href="" class="tdFir">{{x3.bidinfo.bidcode}}</a></td>
                        <%-- <td><a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId={{x3.bidinfo.id}}&biddingprice={{x3.biddingprice}}" class="see oprate">详情</a></td> --%>
                        <td>{{x3.bidinfo.goods.goodsname}}
                        </td>
                        <td>{{x3.bidinfo.goods.freightvolume|
                            number : 2}}{{x3.bidinfo.goods.freightunit}}
                        </td>
                        <td>{{x3.bidinfo.goods.shipAddress.city}}
                            - {{x3.bidinfo.goods.consignAddress.city}}
                        </td>
                        <td><span class="green">{{x3.biddingstatus}}</span></td>
                        <td>{{x3.createDate.substr(0,10)}}</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <!-- <div class="loading" style="text-align: center">
                <img src="/static/images/loading.gif">
                <p>加载中</p>
            </div> -->
            <!--分页-->
            <tm-pagination conf="paginationConf3"></tm-pagination>
        </div>


    </div>

</div>

<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>

<script>
    //    头部数据
    $(".data-model .col-sm-2").mouseover(function () {
        $(this).find(".data-icon").addClass("img_rotate");
    }).mouseleave(function () {
        $(this).find(".data-icon").removeClass("img_rotate");
    });

</script>
<script>
    $("#maskloading", parent.document).show();
    var type = 1;
    window.change = function (args) {
        type = args;
        execute();
    };

    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        //配置分页基本参数
        $scope.paginationConf2 = {
            currentPage: 1,
            itemsPerPage: 10
        };
        //配置分页基本参数
        $scope.paginationConf3 = {
            currentPage: 1,
            itemsPerPage: 10
        };
        $scope.tab_info = 'trade';
        $scope.post_url = "${wlpt}/wlpt/trade/getTradeList";
        ///查询参数初始化
        $scope.postData = {
            pageNo: $scope.paginationConf.currentPage,
            pageSize: $scope.paginationConf.itemsPerPage
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData").hide();
                $(".no-items").html('');
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".no-items").html('');
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function (tab) {
            $("#maskloading", parent.document).show();
            $("#tab_button_div button").removeClass("btn-active")
            $("#" + tab + "_button").addClass("btn-active");


            $scope.post_url = "${wlpt}/wlpt/trade/getTradeList";
            $scope.tab_info = tab;
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
            if ($scope.tab_info == 'trade') {
                $scope.post_url = "${wlpt}/wlpt/trade/getTradeList";
            } else if ($scope.tab_info == 'bid') {
                $scope.post_url = "${wlpt}/wlpt/bid/getbidsList";
                $scope.paginationConf2.currentPage = 1;
                $scope.paginationConf2.itemsPerPage = 10;
            } else {
                $scope.post_url = "${wlpt}/wlpt/bid/getbiddingList";
                $scope.paginationConf3.currentPage = 1;
                $scope.paginationConf3.itemsPerPage = 10;
            }
            $("#tab").val(tab);
            //alert($scope.tab_info+"====="+$scope.post_url);

        };
        var GetAllEmployee = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
            if ($scope.tab_info == 'trade') {
                $scope.postData.pageNo = $scope.paginationConf.currentPage;
                $scope.postData.pageSize = $scope.paginationConf.itemsPerPage;
            } else if ($scope.tab_info == 'bid') {
                $scope.postData.pageNo = $scope.paginationConf2.currentPage;
                $scope.postData.pageSize = $scope.paginationConf2.itemsPerPage;
            } else {
                $scope.postData.pageNo = $scope.paginationConf3.currentPage;
                $scope.postData.pageSize = $scope.paginationConf3.itemsPerPage;
            }

            $http({
                url: $scope.post_url,
                method: 'post',
                params: $scope.postData
            }).success(function (response) {
                $scope.tab_info = $("#tab").val();
                $scope.paginationConf.totalItems = response.value.count;
                if ($scope.tab_info == 'trade') {
                    $scope.paginationConf.totalItems = response.value.count;
                    $scope.data = response.value.list;
                } else if ($scope.tab_info == 'bid') {
                    $scope.data2 = response.value.list;
                    $scope.paginationConf2.totalItems = response.value.count;
                } else if ($scope.tab_info == 'bidding') {
                    $scope.data3 = response.value.list;
                    $scope.paginationConf3.totalItems = response.value.count;
                }

                if (!response.value.count) {
                    $scope.$apply(function () {
                    });
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };

</script>


</body>
</html>
