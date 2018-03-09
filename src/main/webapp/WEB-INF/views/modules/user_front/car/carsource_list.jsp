<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>车源管理</title>
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
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">车源管理</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-2">
                                <input id="searchinfo" ng-model="searchData.searchinfo" type="text" class="form-control"
                                       placeholder="车牌号/手机号"/>
                            </div>
                            <div class="col-sm-2">
                                <input id="cartype" type="text" class="form-control" ng-model="searchData.cartype"
                                       placeholder="车型"/>
                            </div>
                            <div class="col-sm-2">
                                <select id="status" ng-model="searchData.status" class="form-control" placeholder="状态">
                                    <option value=''>全部</option>
                                    <option value='1'>已发布</option>
                                    <option value='2'>已过期</option>
                                    <option value='3'>已取消</option>
                                </select>
                            </div>
                            <div class="col-sm-2 btn-search-wrap">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary" style="width: 128px;"><i class="fa fa-search white"></i>
                                    查询
                                </button>
                            </div>

                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>车牌号</th>
                                <th>路线</th>
                                <th>状态</th>
                                <th>发车时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    {{x.carnumber}}<%--<span class="vertical-line">|</span>联系电话：{{x.user.phone != null ? x.user.phone:"保密"}}--%>

                                </td>
                                <td ng-cloak>
                                    {{x.mainroad}}
                                    <!-- <p>{{x.car.issocialcar}}<span class="vertical-line">|</span>{{x.car.status}}</p> -->
                                    <!-- <p>{{x.car.cartype}}<span class="vertical-line">|</span>车长{{x.car.carlength}}米<span class="vertical-line">|</span>载重{{x.car.loadweight}}吨</p> -->
                                </td>
                                <td ng-cloak>
                                    {{x.status}}
                                <td ng-cloak>
                                    {{x.departuretime}}
                                </td>
                                <td ng-cloak>
                                    <a href="${wlpt}/wlpt/carsource/getCarSourceInfo?id={{x.id}}"
                                       class="see oprate">查看</a>
                                    <a href="javascript:" ng-click="isDelete(x.id)"
                                       class="orange oprate">删除</a>
                                    <a href="${wlpt}/wlpt/carsource/toSave?type=1&id={{x.id}}"
                                       class="green oprate">一键重发</a>
                                    <a href="${wlpt}/wlpt/carsource/toSave?type=2&id={{x.id}}"
                                       class="green oprate">返程发布</a>
                                    

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


<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
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
                'searchinfo': $("#searchinfo").val(),
                'cartype': $("#cartype").val(),
                'carlength': $("#carlength").val(),
                'status': $("#status").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/carsource/getCarSourceList',
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
        $scope.isDelete = function (id) {

            if (id == null || id == "") {
                return;
            }
            // $(".loading_lock").show();
            $.MsgBox.Confirm("删除提示", "是否删除该车源?", function () {
                $.ajax({
                    url: "${wlpt}/wlpt/carsource/deleteCarSource",
                    data: {
                        id: id,
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("删除提示", data.value);
                        GetAllEmployee();
                    }
                });
            }, function () {
            	$("#maskloading" , parent.document).hide();
            });
        };
    }]);
    getCarType();

    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    function check() {
        var status = "${user.userinfo.status}";
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
</body>
</html>
