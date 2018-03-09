<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运输合同</title>
    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 10px;
            line-height: 1.42857143;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
            vertical-align: bottom;
            white-space: nowrap;
            box-sizing: border-box;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div ng-app="bid" ng-controller="bidCtrl">
    <input type="hidden" id="loginUser" value="${loginUser.id}">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">运输合同</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-4">
                                <input type="text" placeholder="合同号/招标文号"
                                       class="form-control" ng-model="bidcode">
                            </div>

                            <div class="col-sm-2 text-left">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i> 查询
                                </button>
                            </div>

                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table" id="bidorder_list_table">
                            <thead>
                            <tr>
                                <th>合同号</th>
                                <th>招标文号</th>
                                <th>招标方</th>
                                <th>竞标方</th>
                                <th>货物信息</th>
                                <th>总量</th>
                                <th>已运</th>
                                <th>未运</th>
                                <th>路线信息</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td>
                                    {{x.contractno}}

                                </td>
                                <td>
                                    {{x.bidinfo.bidcode}}

                                </td>
                                <td>
                                    {{x.biduser.loginName}}
                                </td>
                                <td>
                                    {{x.biddinguser.loginName}}
                                </td>
                                <td>
                                    {{x.bidinfo.goods.goodsname}}<span class="vertical-line">|</span>{{x.bidinfo.goods.gsoddtype}}
                                </td>
                                <td>
                                    {{x.bidinfo.goods.freightvolume | number : 3}}{{x.bidinfo.goods.freightunit}}
                                </td>
                                <td>
                                    {{x.bidinfo.goods.freightvolume-x.bidinfo.goods.residualvolume | number
                                    :3}}{{x.bidinfo.goods.freightunit}}
                                </td>
                                <td>
                                    {{x.bidinfo.goods.residualvolume | number : 3}}{{x.bidinfo.goods.freightunit}}
                                </td>
                                <td>
                                    {{x.bidinfo.goods.shipAddress.city}}→{{x.bidinfo.goods.consignAddress.city}}
                                </td>
                                <td>
                                    <span ng-if="(x.contractstatus==1 || x.contractstatus==3)" class="blue">{{x.contractStr}}</span>
                                    <span ng-if="(x.contractstatus==2)" class="green">{{x.contractStr}}</span>
                                    <span ng-if="(x.contractstatus==4)" class="red">{{x.contractStr}}</span>
                                    <span ng-if="(x.contractstatus==0)" class="yellow">{{x.contractStr}}</span>
                                </td>
                                <td>
                                    <!-- 0新建合同，1运输中，2.申请运输完成3.运输完成申请驳回4.运输完成-->
                                    <%--<p class="whi-grey-btn">
                                        <a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId={{x.id}}" class="btn btn-warning">提货单</a>
                                    </p>--%>
                                    <!--竞标用户获得合同显示状态:竞标用户发货-->

                                    <a ng-if="x.bidinfo.goods.residualvolume>0 && x.isBidUser ==false"
                                       href="${wlpt}/wlpt/bid/orderPubilshGoods?id={{x.id}}"
                                       class="green oprate">发布货源</a>


                                    <!--运输状态结束后不显示按钮-->
                                    <span ng-if="x.contractstatus!=0 && x.contractstatus!=4">
					                    <!--竞标用户获得合同显示状态:竞标用户申请-->
					                    <a ng-if="(x.contractstatus==1 || x.contractstatus==3) && x.isBidUser==false "
                                           ng-click="editStatus(x.id,0,2)" class="green oprate blue">申请核单</a>
                                        <!--竞标用户申请后显示状态:招标用户审核-->
					                    <a ng-if="x.contractstatus==2 && x.isBidUser" ng-click="editStatus(x.id,0,4)"
                                           class="green oprate green">核单通过</a>
                                        <!--竞标用户申请后显示状态:竞标用户显示审核中-->
					                    <a ng-if="x.contractstatus==2 && x.isBidUser ==false" class="see oprate yellow">核单中</a>
                                        <!--审核通过后运输完成-->
					                    <a ng-if="x.contractstatus==4" class="red oprate ">运输结束</a>
					                </span>


                                    <a ng-if="x.contractstatus==2 && x.isBidUser" ng-click="editStatus(x.id,0,3)"
                                       class="green oprate">核单驳回</a>


                                    <!--0:未申请，1申请结算，2.申请失败驳回3，申请通过4.支付完成，5确认-->
                                    <span ng-if="x.contractstatus==4">
					                    <!--用户运输完成,竞标用户申请结算-->
					                    <a ng-if="( x.settlestatus==0 || x.settlestatus==2 )&& x.isBidUser==false"
                                           ng-click="editStatus(x.id,1,1)" class="green oprate">申请结算</a>
                                        <!--用户发起申请,招标用户同意结算-->
					                    <a ng-if="x.settlestatus==1 && x.isBidUser" ng-click="editStatus(x.id,1,3)"
                                           class="green oprate">结算通过</a>
                                        <!--用户发起申请,竞标用户显示结算中-->
					                    <a ng-if="(x.settlestatus==1 || x.settlestatus==3 ) && x.isBidUser==false"
                                           class="see oprate">结算中</a>
                                        <!--用户发起申请,招标用户同意结算后去结算-->
					                    <a ng-if="x.settlestatus==3 && x.isBidUser "
                                           href="${wlpt}/wlpt/bid/toPay?id={{x.id}}"
                                           class="green oprate">去支付</a>
                                        <!--用户发起申请,结算完成后,招标用户显示为已结算-->
					                    <a ng-if="x.settlestatus==4 && x.isBidUser  && x.bidinfo.bidstatus ==3"
                                           class="see oprate">已结算</a>
					                    <a ng-if="x.settlestatus==4 && x.isBidUser && x.bidinfo.bidstatus !=3"
                                           class="see oprate">待银行处理</a>
                                        <!--用户发起申请,招标结算后竞标用户确认结算-->
					                    <a ng-if="x.settlestatus==4 && x.isBidUser==false && x.bidinfo.bidstatus ==3"
                                           ng-click="editStatus(x.id,1,5)"
                                           class="green oprate">确认结算</a>
					                    <a ng-if="x.settlestatus==5" class="see oprate">交易完成</a>
					                </span>

                                    <!--驳回申请-->

                                    <a ng-if="x.contractstatus==4 && x.settlestatus==1 && x.isBidUser "
                                       ng-click="editStatus(x.id,1,2)" class="green oprate">结算驳回</a>


                                    <a ng-if="x.contractstatus!=0" href="${wlpt}/wlpt/bid/bidtrack?id={{x.id}}"
                                       class="see oprate">车辆监控</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                    <!-- <div class="loading">
                        <img src="/static/images/loading.gif">
                        <p>加载中</p>
                    </div> -->
                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>

        </div>
    </div>
</div>


<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
$("#maskloading" , parent.document).show();
    var app = angular.module('bid', ['tm.pagination']);
    app.controller('bidCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
            	$("#maskloading" , parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
        	$("#maskloading" , parent.document).show();
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'searchinfo': $scope.bidcode,
                'biduser.id': $("#loginuser").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/bid/getBidOrderList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.data = response.value.list;
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };

        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

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
                        $scope.paginationConf.currentPage = 0;
                        $.MsgBox.Alert("交易提示", data.message);
                        GetAllEmployee();
                    }
                });
            });

        };


    }]);

</script>
</body>
</html>

