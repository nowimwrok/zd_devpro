<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>选择中标</title>
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
<div ng-app="selectBid" ng-controller="selectBidCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">我的招标</h4>
                </div>
                <div class="panel-body">
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>竞标人</th>
                                <th>运量</th>
                                <th>竞标价</th>
                                <th>竞标时间</th>
                                <th>诚信</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    {{x.biddinguser.loginName}}
                                </td>
                                <td ng-cloak>
                                    {{x.bidinfo.goods.freightvolume| number : 2}}{{x.bidinfo.goods.freightunit}}
                                </td>
                                <td ng-cloak>
                                    {{x.biddingprice}}
                                </td>
                                <td ng-cloak>
                                    {{x.createDate}}
                                </td>
                                <td>
                                    中标：&nbsp;<span style="color: red;font-size:18px; font-weight:bold; " ng-cloak>{{x.userStatistics.biddingcount}}</span>&nbsp;次
                                </td>
                                <td>
                                    <a ng-if="x.biddingstatus=='竞标' " href="javascript:void(0)" ng-click="check(x.id)"
                                       class="green oprate">选择中标</a>
                                    <a ng-if="x.biddingstatus=='中标' " href="${wlpt}/wlpt/bid/notifys?biddingId={{x.id}}"
                                       class="see oprate">查看中标通知</a>
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


<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>

$("#maskloading" , parent.document).show();
    var app = angular.module('selectBid', ['tm.pagination']);
    app.controller('selectBidCtrl', ['$scope', '$http', function ($scope, $http) {
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
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'bidinfo.id': '${bidinfo.id}',
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/bid/getbiddingListbyBid',
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

        $scope.check = function (id) {
                $.MsgBox.Confirm("中标提示", "是否选择中标?", function () {
                	$("#maskloading" , parent.document).show();
                    window.location.href = "${wlpt}/wlpt/bid/bidNotifys?biddingId=" + id;
                }, function () {
                	$("#maskloading" , parent.document).hide();
                });
                return true;

        };

    }]);
</script>
</body>
</html>
