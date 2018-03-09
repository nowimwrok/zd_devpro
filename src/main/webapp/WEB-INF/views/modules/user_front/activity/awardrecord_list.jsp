<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
    <!-- <meta name="decorator" content="site_personal_basic"/> -->
    <title>中奖记录</title>
    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th,
        .table > thead > tr > td, .table > thead > tr > th {
            padding: 10px;
            line-height: 1.42857143;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
            vertical-align: bottom;
            white-space: nowrap;
            box-sizing: border-box;
        }
        .table-bordered > tbody > tr > td {
            border: 1px solid #000;
            color: #000;
        }

        #modal td {
            line-height: 40px;
            padding: 0;
        }
        #modal .td_br{
            border: none!important;
            border-right: 1px solid #000000!important;
        }
        #modal .td_br_none{
            border-right: none!important;
        }
        #modal .col-sm-4, #modal .col-sm-2, #modal .col-sm-3, #modal .col-sm-6 {
            border-right: 1px solid #000;
        }
        .delivery_tr td{
            padding-left: 10px !important;
        }
    </style>

</head>
<body style="background: #f5f5f5;">
<div ng-app="bid" ng-controller="bidCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">中奖记录</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar"
                              style="text-align: center">
                            <div class="col-sm-3">
                                <input class="form-control" placeholder="兑换号" ng-model="awardno" name="awardno" id ="awardno">
                            </div>
                            <div class="col-sm-2">
                                <select id="issuemodel" ng-model="issuemodel" name="issuemodel"
                                        class="form-control" >
                                    <option value="" label="全部">全部</option>
                                    <option value="0">未发放</option>
                                    <option value="1">可用</option>
                                    <option value="2">作废</option>
                                    <option value="3">已使用</option>
                                </select>
                            </div>

                            <div class="col-sm-2 text-left">
                                <button type="button" name="search-btn" id="search-btn"
                                        ng-click="searchInfo()" class="btn btn-primary">
                                    <i class="fa fa-search white"></i> 查询
                                </button>
                            </div>
                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>兑换号</th>
                                <th>活动名称</th>
                                <th>奖品名称</th>
                                <th>奖品类型</th>
                                <th>奖品价值</th>
                                <th>发放状态</th>
                                <th>中奖时间</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>{{x.awardno}}</td>
                                <td ng-cloak>{{x.wxinfo.activityName}}</td>
                                <td ng-cloak>
                                    {{x.wxgift.giftname}}
                                </td>
                                <td ng-cloak>{{x.gifttypename}}
                                </td>

                                <td ng-cloak>
                                    {{x.wxgift.giftworth}}
                                </td>
                                <td ng-cloak>
                                    {{x.issuename}}
                                </td>
                                <td ng-cloak>{{x.createtime}}</td>


                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData"
                         style="display: none; text-align: center; width: 100%; line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png"
                             style="width: 100px; height: 100px;">
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

<script>

    $(".white_grey_table>tr td").eq(3).addClass("whi-grey-last");

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
                'awardno': $("#awardno").val(),
                'issue': $("#issuemodel").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/activity/getAwardrecordList',
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


    }]);

</script>
</body>
</html>
