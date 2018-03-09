<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运单管理</title>

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

        .fixed {
            position: fixed;
            background: #069DD5 !important;
            width: 200px;
        }

        .team_list {
            padding: 0;
            position: relative;
            top: -25px;
            left: -15px;
        }

        .team_list ul {
            border: 1px solid #ddd;
            /*height: 100%;*/
        }

        .team_list li {
            border-left: 0;
            border-right: 0;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            position: relative;
        }

        .team_list li:first-child {
            border-top: 0;
        }

        .team_list li:last-child {
            border-bottom: 0;
        }

        .team_list li i {
            margin-right: 5px;
            width: 20px;
            height: 20px;
            display: inline-block;
            background: url(img/car_list.png) no-repeat;
            background-size: 100%;
            vertical-align: top;
        }

        .team_list .badge {
            min-width: 42px;
        }

        .team_list .green {
            top: -2px;
            background-color: #339900;
            font-size: 15px;
            padding: 5px 8px;
            border-radius: 3px;
        }

        .team_list .othercolor {
            top: -2px;
            background-color: #3598dc;
            font-size: 15px;
            padding: 5px 8px;
            border-radius: 3px;
        }

        .team_list .red {
            top: -2px;
            background-color: #dc4e27;
            font-size: 15px;
            padding: 5px 8px;
            border-radius: 3px;
        }

        .team_list .blue {
            position: absolute;
            top: -5px;
            left: 92%;
            width: auto !important;
            line-height: 20px;
            padding: 0 4px;
            border-radius: 0;
            -webkit-border-radius: 0;
            background-color: #2aafee;
            border: 1px solid #a7ddf1;
        }

        .team_list .name {
            color: #787878;
        }

        .team_list .title {
            background-color: #77d1f0;
            border-radius: 0;
            height: 32px;
            padding: 0;
        }

        .team_list .line_team {
            display: inline-block;
            width: 2px;
            height: 22px;
            background-color: #fff;
            position: relative;
            top: 5px
        }

        .team_list .glyphicon-plus {
            font-size: 20px;
            font-weight: bold;
            position: relative;
            top: -5px;
            cursor: pointer
        }

        .teamSeclected {
            box-shadow: inset 5px 0px 0 0 #3598dc;
            border-left: 1px solid rgba(90, 159, 255, 0.93) !important;
        }

        .pointerMouse {
            cursor: pointer;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">运单管理</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-2 team_list">
                        <ul class="list-group">
                            <li class="list-group-item" ng-cloak>
                                运单状态
                            </li>
                            <li class="list-group-item pointerMouse"
                                ng-class="{teamSeclected:searchData.tradeStatus==''&& searchData.isComment!='1'}"
                                ng-cloak
                                ng-click="selectStatus('')">
                                <span>全部</span>
                                <span class="badge othercolor">{{totalNum}}</span>
                            </li>
                            <li class="list-group-item pointerMouse" ng-cloak ng-repeat="x in statusData"
                                ng-click="selectStatus(x.statusValue)"
                                ng-class="{teamSeclected:searchData.tradeStatus==x.statusValue||(searchData.isComment=='1'&& x.statusValue=='7')}">
                                <img height="20px" width="20px"
                                     src="${ctxStatic }/images/orderCenterMenu/orderCenterMenu_{{x.statusValue}}.png">
                                <span class="name">{{x.statusName}}</span>
                                <span class="badge othercolor"
                                      ng-class="{red:x.statusName=='已取消'}">{{x.statusOrderNum}}</span>
                                <a class="tdFir route"></a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-lg-10 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-4">
                                <input type="text" id="searchinfo" name="searchinfo" value="${orderinfo.searchinfo }"
                                       placeholder="运单号/运输方/托运方/车牌号/货物名称" class="form-control">
                            </div>
                            <%--<div class="col-sm-2">--%>
                            <%--<select id="orderstatus" name="orderstatus" class="form-control" placeholder="运单状态"">--%>
                            <%--<option value=''>全部</option>--%>
                            <%--<option value='0'>新运单</option>--%>
                            <%--<option value='1'>已确认</option>--%>
                            <%--<option value='2'>已取消</option>--%>
                            <%--<option value='3'>已提货</option>--%>
                            <%--<option value='4'>已回单</option>--%>
                            <%--<option value='5'>已支付</option>--%>
                            <%--<option value='6'>发起争议</option>--%>
                            <%--<option value='7'>争议完毕</option>--%>
                            <%--</select>--%>
                            <%--</div>--%>
                            <div class="col-sm-2">
                                <select id="gsoddtype" name="gsoddtype" class="form-control" placeholder="货物类别">
                                    <option value=''>全部</option>
                                    <option value='1'>成品</option>
                                    <option value='2'>原材料</option>
                                </select>
                            </div>
                            <div class="col-sm-4 text-left">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i> 查询
                                </button>
                                <a class="btn btn-success" id="fabu" 
                                  href="${wlpt}/wlpt/trade/toTradeGpsInfo">
                                    <i class="fa fa-plus-square white"> </i> 运输监管
                                </a>
                            </div>

                        </form>
                    </div>
                    <div class="col-lg-10" style="overflow: auto;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>运单信息</th>
                                <th>操作</th>
                                <th>状态</th>
                                <th>托运/承运方</th>
                                <th>货物名称</th>
                                <th>运量</th>
                                <th>货物类型</th>
                                <th>地址信息</th>
                                <th>车牌</th>
                                <th>运费</th>
                                <th>更新时间</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data" style="position: relative;">
                                <td ng-cloak>
                                    {{x.orderno}}
                                </td>
                                <td>
                                    <!--ng-if 判断状态是否为新运单状态-->
                                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_shadow&id={{x.id}}"
                                       class="see oprate">查看运单</a>

                                    <a href="${wlpt}/wlpt/trade/toPayInfo?id={{x.id}}"
                                       class="see oprate">支付信息</a>

                                    <a ng-if="x.orderstatus==0 && x.isBuyer" href="javascript:"
                                       ng-click="confrimOrder(x.id,x.quoteinfo.goods.isinsur,x.orderno,x.quoteinfo.isassign)"
                                       class="green oprate">确认交易</a>

                                    <a ng-if="x.orderstatus==0" href="javascript:"
                                       ng-click="editOrder(x.id,'cancelOrder','取消')" class="orange oprate">取消运单</a>

                                    <a ng-if="x.orderstatus==1 && x.isBuyer"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}"
                                       class="green oprate">上传提货</a>

                                    <a ng-if="x.orderstatus==3 && x.isBuyer"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}"
                                       class="green oprate">上传回单</a>

                                    <!--如果运输状态为4:已上传回单,并且支付状态不是支付中的状态 则可以确认完成交易,或者发起争议-->
                                    <a ng-if="x.orderstatus==4 && x.isBuyer==false  && x.orderispay!=2"
                                       href="${wlpt}/wlpt/trade/toOrderPay?id={{x.id}}" class="green oprate">完成交易</a>

                                    <a ng-if="x.orderstatus==4 && x.isBuyer==false  && x.orderispay==2"
                                       class="see oprate">银行处理中</a>

                                    <a ng-if="x.orderstatus==4 && x.isdispute==0 && x.isBuyer == false && x.isonlinepay == 1"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}"
                                       class="green oprate">发起争议</a>

                                    <!--卖家发起争议-->
                                    <a ng-if="x.orderstatus==6 && x.isdispute==1"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}"
                                       class="see oprate">争议中</a>

                                    <a ng-if="x.orderstatus==7 && x.isBuyer==false && x.isdispute==1 && x.orderispay!=2"
                                       href="${wlpt}/wlpt/trade/toOrderPay?id={{x.id}}" class="green oprate">完成交易</a>

                                    <a ng-if="x.isGps"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_track&id={{x.id}}"
                                       class="see oprate">运输轨迹</a>

                                    <a ng-if="x.orderstatus==5 && x.iscomment==0 && x.flag"
                                       href="${wlpt}/wlpt/trade/to_ordercomment?id={{x.id}}" class="green oprate">评价</a>

                                    <a ng-if="(x.orderstatus==1||x.orderstatus==3) && x.islocated ==0 && x.isBuyer==false"
                                       href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_lbs&id={{x.id}}"
                                       class="green oprate">开启LBS定位</a>
                                       
                                   <!--  <a ng-if="(x.orderstatus==1||x.orderstatus==3) && x.locationFlag ==0 && x.isBuyer==false"
                                       ng-click="editOrder(x.id,'openGps','开通')"
                                       class="green oprate">开启GPS定位</a> -->

                                    <a ng-if="x.quoteinfo.goods.isinsur==1"
                                       href="${wlpt}/wlpt/insur/todetailByOrderNo?orderno={{x.orderno}}"
                                       class="see oprate">查看保单</a>

                                </td>
                                <td ng-cloak>
                                    <span ng-if="x.orderstatus==0 || x.orderstatus==2"
                                          class="red">{{x.statusStr}}</span>
                                    <span ng-if="x.orderstatus==3 || x.orderstatus==4"
                                          class="blue">{{x.statusStr}}</span>
                                    <span ng-if="x.orderstatus==5 || x.orderstatus==6"
                                          class="green">{{x.statusStr}}</span>
                                    <span ng-if="x.orderstatus==1 || x.orderstatus==7"
                                          class="yellow">{{x.statusStr}}</span>
                                </td>
                                <td>
                                    <span ng-if="x.isBuyer">{{x.seller.loginName}}</span><span ng-if="x.isBuyer==false">{{x.buyer.loginName}}</span>
                                </td>
                                <td ng-cloak>
                                    {{x.quoteinfo.goods.goodsname}}
                                </td>
                                <td ng-cloak>
                                    <span ng-if="x.quoteinfo.isreload==1">{{x.quoteinfo.actload}}</span>
                                    <span ng-if="x.quoteinfo.isreload!=1">{{x.quoteinfo.oddloadweight}}</span>{{x.quoteinfo.goods.freightunit}}
                                </td>
                                <td ng-cloak>
                                    {{x.quoteinfo.goods.gsoddtype}}
                                </td>
                                <td ng-cloak>
                                    {{x.quoteinfo.goods.shipAddress.city}}{{x.quoteinfo.goods.shipAddress.district.substr(0,4)+'...'}}→
                                    {{x.quoteinfo.goods.consignAddress.city}}{{x.quoteinfo.goods.consignAddress.district.substr(0,4)+'...'}}
                                </td>
                                <td ng-cloak>
                                    {{x.quoteinfo.car.carnumber}}
                                </td>
                                <td ng-cloak>
                                    {{x.totalcost}}元
                                    <span ng-show="x.quoteinfo.goods.isinsur == 1" style="color: red;">投保</span>
                                </td>

                                <td ng-cloak>
                                    {{x.updateDate}}
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
                    <div class="col-lg-2"></div>
                    <div class="col-lg-10">
                        <tm-pagination conf="paginationConf"></tm-pagination>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>


<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
            $("#maskloading", parent.document).show();
            $scope.paginationConf.currentPage = 0;
            GetAllEmployee();
        };
        $scope.searchData = {tradeStatus: "", isComment: ""};
        var GetAllEmployee = function () {
            var postData = {
                'iscomment': $scope.searchData.isComment,
                'searchinfo': $("#searchinfo").val(),
                'orderstatus': $scope.searchData.tradeStatus,
                'quoteinfo.goods.gsoddtype': $("#gsoddtype").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/trade/getTradeList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.data = response.value.list;
                $.cookie("trade_searchinfo", $("#searchinfo").val());
                $.cookie("trade_orderstatus", $("#orderstatus").val());
                $.cookie("trade_pageno", $scope.paginationConf.currentPage);
                $.cookie("trade_gsoddtype", $("#gsoddtype").val());
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };

        var GetStatusList = function () {
            $http.get("${wlpt}/wlpt/trade/getStatusList").success(function (response) {
                $scope.totalNum = response.data.totalNum;
                $scope.statusData = response.data.dataList;
            });
        }
        GetStatusList();

        $scope.selectStatus = function (status) {
            if (status == '7') {
                $scope.searchData.isComment = '1';
                $scope.searchData.tradeStatus = '';
            } else {
                $scope.searchData.tradeStatus = status;
                $scope.searchData.isComment = '';
            }
            GetAllEmployee();
        }

        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

        $scope.editOrder = function (id, url, masg) {
            if (id == null || id == "") {
                return;
            }
            $.MsgBox.Confirm("交易提示", "您将" + masg + "此交易,是否继续操作?", function () {
                $("#maskloading", parent.document).show();
                $.ajax({
                    url: "${wlpt}/wlpt/trade/" + url,
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("交易提示", data.message);
                        $("#maskloading", parent.document).hide();
                        GetAllEmployee();

                    }
                });
            }, function () {
                $("#maskloading", parent.document).hide();
            }, null, null, "是", "否");

        };

        $scope.confrimOrder = function (id, isinsur, orderno, isassign) {
            if (id == null || id == "") {
                return;
            }
            if (isinsur * 1 == 1) {
                $.MsgBox.Confirm("交易提示", "该运单需填写保单信息,是否继续操作?", function () {
                    $("#maskloading", parent.document).show();
                    window.location.href = '${wlpt}/wlpt/trade/toinsur?orderno=' + orderno;
                }, function () {
                    $("#maskloading", parent.document).hide();
                }, "是", "否");
            } else if (isassign * 1 == 1) {
                $.MsgBox.Confirm("交易提示", "该运单需填写运输信息,是否继续操作?", function () {
                    $("#maskloading", parent.document).show();
                    window.location.href = '${wlpt}/wlpt/trade/toassign?orderno=' + orderno;
                }, function () {
                    $("#maskloading", parent.document).hide();
                }, "是", "否");
            } else {

                $.MsgBox.Confirm("交易提示", "您将确认此交易,是否继续操作?", function () {
                    $("#maskloading", parent.document).show();
                    $.ajax({
                        url: "${wlpt}/wlpt/trade/confrimOrder",
                        data: {
                            id: id
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $.MsgBox.Alert("交易提示", data.message);
                            $("#maskloading", parent.document).hide();
                            GetAllEmployee();
                        }
                    });
                }, function () {
                    $("#maskloading", parent.document).hide();
                }, "是", "否");
            }
        };

    }]);

    if ('${isRedrect}' == 'true') {
        $("#searchinfo").val($.cookie("trade_searchinfo"));
        $("#orderstatus").val($.cookie("trade_orderstatus"));
        $("#gsoddtype").val($.cookie("trade_gsoddtype"));
    }
</script>
</body>
</html>
