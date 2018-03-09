<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>司机管理</title>
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

        .motorcadeDatainit {
            display: none;
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
                    <h4 class="panel-heading ">司机管理</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-2 team_list">
                        <ul class="list-group">
                            <li class="list-group-item" ng-cloak>
                                车队列表<a style="font-size: 11px;margin-left: 10px;" class="pointerMouse"
                                       data-target="#modalMotorcadeList"
                                       data-toggle="modal">管理</a>
                                <span class="pull-right glyphicon-plus pointerMouse" data-toggle="modal"
                                      data-target="#modal" ng-click="clearMotorcade()"></span>
                            </li>
                            <li class="list-group-item pointerMouse"
                                ng-class="{teamSeclected:searchData.motorcadeId==''}" ng-cloak
                                ng-click="selectTeam('')">
                                <span>全部</span>
                                <span class="badge othercolor">{{totalDriverNum}}</span>
                            </li>
                            <li class="list-group-item pointerMouse" ng-cloak ng-repeat="x in motorcadeData"
                                ng-click="selectTeam(x.id)" ng-class="{teamSeclected:searchData.motorcadeId==x.id}">
                                <span class="name" title="{{x.fromCity}}--{{x.toCity}}">{{x.name}}</span>
                                <span class="badge othercolor">{{x.driverNum}}</span>
                                <a class="tdFir route"></a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-lg-10 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-2">
                                <input id="drivername" type="text" class="form-control" ng-model="searchData.drivername"
                                       placeholder="司机姓名"/>
                            </div>
                            <div class="col-sm-2">
                                <input id="driverphone" type="text" class="form-control"
                                       ng-model="searchData.driverphone" placeholder="手机号码"/>
                            </div>
                            <div class="col-sm-2">
                                <select id="isagree" class="form-control" ng-model="searchData.isagree">
                                    <option value=''>申请状态</option>
                                    <option value='0'>申请中</option>
                                    <option value='1'>同意</option>
                                    <option value='2'>不同意</option>
                                </select>
                            </div>

                            <div class="col-sm-4 text-left">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i>
                                    查询
                                </button>
                                <a class="btn btn-success" id="fabu"
                                   ng-click="check('${wlpt}/wlpt/driver/toSave');">
                                    <i class="fa fa-plus-square white"> </i> 添加绑定</a>
                            </div>
                        </form>
                    </div>
                    <div class="col-lg-10" style="overflow: auto;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>登录名</th>
                                <th>真实姓名</th>
                                <th>手机号码</th>
                                <th>是否同意</th>
                                <th>所属车队</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    <span ng-if="x.flag ==0">{{x.reuser.loginName}}</span>
                                    <span ng-if="x.flag ==1">{{x.user.loginName}}</span>
                                </td>
                                <td ng-cloak>
                                    <span ng-if="x.flag ==0">{{x.reuser.name}}</span>
                                    <span ng-if="x.flag ==1">{{x.user.name}}</span>
                                </td>
                                <td>
                                    <span ng-if="x.flag ==0" ng-cloak>{{x.reuser.phone}}</span>
                                    <span ng-if="x.flag ==1" ng-cloak>{{x.user.phone}}</span>
                                </td>
                                <td>
                                    <span ng-if="x.isagree == 0" class="yellow">申请中</span>
                                    <span ng-if="x.isagree == 1" class="green">同意</span>
                                    <span ng-if="x.isagree == 2" class="red">不同意</span>
                                </td>
                                <td>
                                    <span ng-if="x.flag ==1">{{x.motorcade.name}}</span>
                                    <span ng-if="x.flag ==0">{{x.remotorcade.name}}</span>
                                </td>
                                <td>
                                    <a href="javascript:" ng-if="x.flag ==0" ng-click="find(x.reuser.id)"
                                       target="content"
                                       class="see oprate">查看用户</a>
                                    <a href="javascript:" ng-if="x.flag ==1" ng-click="find(x.user.id)" target="content"
                                       class="see oprate">查看用户</a>
                                    <a href="${wlpt}/wlpt/driver/isAgree?id={{x.id}}&isagree=1" target="content"
                                       ng-if="x.flag ==1&&x.isagree == 0" class="green oprate">同意</a>
                                    <a href="${wlpt}/wlpt/driver/isAgree?id={{x.id}}&isagree=2" target="content"
                                       ng-if="x.flag ==1&&x.isagree == 0" class="green oprate">不同意</a>
                                    <a href="javascript:" ng-click="isDelete(x.id)" target="content"
                                       ng-if="x.isagree == 1 && x.user.id != x.reuser.id"
                                       class="orange oprate">解除</a>
                                    <a href="javascript:" ng-if="x.flag ==1" data-target="#modalSelectMotorcade"
                                       data-toggle="modal"
                                       ng-click="showSelectMotorcade(x.user.id)"
                                       target="content"
                                       class="orange oprate">选择车队</a>
                                    <a href="javascript:" ng-if="x.flag ==0" data-target="#modalSelectMotorcade"
                                       data-toggle="modal"
                                       ng-click="showSelectMotorcade(x.reuser.id)"
                                       target="content"
                                       class="orange oprate">选择车队</a>
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
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modalSelectMotorcade"
         class="modal"
         style="margin:auto;overflow-y:hidden;height: 240px;width: 850px">
        <div>
            <div class="modal-content" style="height: 240px;width: 850px">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">选择车队</h4>
                </div>
                <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;height: 240px;width: 850px">
                    <div style="height: 156px;overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>车队名称</th>
                                <th>路线</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in motorcadeData">
                                <td ng-cloak>
                                    <span>{{x.name}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.fromCity}} -- {{x.toCity}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.createDate}}</span>
                                </td>
                                <td>
                                    <a href="javascript:" ng-click="selectMotorcade(x.id)"
                                       target="content"
                                       class="orange oprate">选择车队</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="motorcadeNoneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal"
         style="margin:auto;overflow-y:hidden;height: 340px;width: 850px;z-index: 9999">
        <div>
            <div class="modal-content" style="height: 340px;width: 850px">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title" ng-if="motorcade.id==''">添加车队</h4>
                    <h4 class="modal-title" ng-if="motorcade.id!=''">修改车队</h4>
                </div>
                <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;height: 340px;width: 850px">
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            车队编号：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.no" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            车队名称：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.name" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            主营路线：
                        </div>
                        <div class="col-sm-4 text-left">
                            <input type="text" ng-model="motorcade.fromCity" class="form-control">
                        </div>
                        <div class="col-sm-1" style="text-align: center;line-height: 34px">
                            到
                        </div>
                        <div class="col-sm-4 text-left">
                            <input type="text" ng-model="motorcade.toCity" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            备注：
                        </div>
                        <div class="col-sm-10 text-left">
                            <textarea ng-model="motorcade.remark" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-primary col-lg-12"
                                    ng-click="saveMotorcade()">提交
                            </button>
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-warning col-lg-12" data-dismiss="modal">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modalMotorcadeList"
         class="modal"
         style="margin:auto;overflow-y:hidden;height: 240px;width: 850px">
        <div>
            <div class="modal-content" style="height: 240px;width: 850px">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">选择车队</h4>
                </div>
                <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;height: 240px;width: 850px">
                    <div style="height: 156px;overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>车队编号</th>
                                <th>车队名称</th>
                                <th>路线</th>
                                <th>创建时间</th>
                                <th>备注</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="motorcadeDatainit">
                            <tr ng-repeat="x in motorcadeData">
                                <td ng-cloak>
                                    <span>{{x.no}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.name}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.fromCity}} -- {{x.toCity}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.createDate}}</span>
                                </td>
                                <td ng-cloak>
                                    <span>{{x.remark}}</span>
                                </td>
                                <td>
                                    <a href="javascript:" ng-click="editMotorcade(x.id)"
                                       data-toggle="modal"
                                       data-target="#modal"
                                       target="content"
                                       class="orange oprate">编辑</a>
                                    <a href="javascript:" ng-click="deleteMotorcade(x.id)"
                                       target="content"
                                       class="orange oprate">删除</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="motorcadeNoneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
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
        $scope.isloadingMotorcade = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#motorcadeNoneData").hide();
                $(".motorcadeDatainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#motorcadeNoneData").show();
                $(".motorcadeDatainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#motorcadeNoneData").hide();
                $(".motorcadeDatainit").show();
            }
        };

        $scope.searchInfo = function () {
            $("#maskloading", parent.document).show();
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };

        $scope.searchData = {motorcadeId: ""};
        var GetMotorcadeDriverPage = function () {
            var postData = {
                'motorcadeId': $scope.searchData.motorcadeId,
                'namesearch': $("#drivername").val(),
                'phonesearch': $("#driverphone").val(),
                'isagree': $("#isagree").val(),
                pageNo:
                $scope.paginationConf.currentPage,
                pageSize:
                $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/driver/getDriverList',
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
        $scope.selectTeam = function (id) {
            $scope.searchData.motorcadeId = id;
            GetMotorcadeDriverPage();
        }
        var GetMotorcadeList = function () {
            $http.get("${wlpt}/wlpt/motorcade/getMotorcadeList").success(function (response) {
                $scope.motorcadeData = response.data.motorcades;
                if (!$scope.motorcadeData) {
                    $scope.isloadingMotorcade(2);
                } else {
                    $scope.isloadingMotorcade(3);
                }
            });
        };
        GetMotorcadeList();

        $scope.saveMotorcade = function () {
            if ($scope.motorcade.no == "") {
                $.MsgBox.Alert("提示", "前填写车队编号");
                return false;
            } else if ($scope.motorcade.name == "") {
                $.MsgBox.Alert("提示", "请填写车队名称");
                return false;
            } else if ($scope.motorcade.name.length > 16) {
                $.MsgBox.Alert("提示", "车队名称不能超过8个字");
                return false;
            } else if ($scope.motorcade.fromCity == "") {
                $.MsgBox.Alert("提示", "请填写主营路线的出发城市");
                return false;
            } else if ($scope.motorcade.toCity == "") {
                $.MsgBox.Alert("提示", "请填写主营路线的到达城市");
                return false;
            }
            var postData = {
                'id': $scope.motorcade.id,
                'no': $scope.motorcade.no,
                'name': $scope.motorcade.name,
                'fromCity': $scope.motorcade.fromCity,
                'toCity': $scope.motorcade.toCity,
                'remark': $scope.motorcade.remark
            };
            $http({
                url: '${wlpt}/wlpt/motorcade/saveMotorcade',
                method: 'post',
                params: postData
            }).success(function (response) {
                if (response.value.state == 1) {
                    $.MsgBox.Alert("提示", "保存成功");
                    closeAllModal();
                    GetMotorcadeList();
                    GetMotorcadeDriverPage();
                } else {
                    $.MsgBox.Alert("提示", response.value.message);
                }
            }).error(function (response) {
                $.MsgBox.Alert("提示", "保存失败，请重试！");
            });
        }

        $scope.currentSelectDriverId = "";
        $scope.showSelectMotorcade = function (id) {
            $scope.currentSelectDriverId = id;
        };
        $scope.selectMotorcade = function (id) {
            $http({
                url: '${wlpt}/wlpt/motorcade/bindingDriver',
                method: 'post',
                params: {'motorcadeId': id, 'driverId': $scope.currentSelectDriverId}
            }).success(function (response) {
                if (response.value.state == 1) {
                    $.MsgBox.Alert("提示", "添加成功");
                    GetMotorcadeList();
                    GetMotorcadeDriverPage();
                } else {
                    $.MsgBox.Alert("提示", response.value.message);
                }
            }).error(function (response) {
                $.MsgBox.Alert("提示", "添加失败，请重试！");
            });
        };

        $scope.deleteMotorcade = function (id) {
            $.MsgBox.Confirm("删除提示", "是否删除该卡?", function () {
                $http({
                    url: '${wlpt}/wlpt/motorcade/deleteMotorcade',
                    method: 'post',
                    params: {'motorcadeId': id}
                }).success(function (response) {
                    if (response.value.state == 1) {
                        $.MsgBox.Alert("提示", "删除成功");
                        GetMotorcadeList();
                        GetMotorcadeDriverPage();
                    } else {
                        $.MsgBox.Alert("提示", response.value.message);
                    }
                }).error(function (response) {
                    $.MsgBox.Alert("提示", "删除失败，请重试！");
                });
            }, function () {
            });
        }
        $scope.editMotorcade = function (id) {
            $http({
                url: '${wlpt}/wlpt/motorcade/getMotorcade',
                method: 'post',
                params: {'motorcadeId': id}
            }).success(function (response) {
                if (response.state == 1) {
                    $scope.motorcade = response.data.motorcade;
                } else {
                    $.MsgBox.Alert("提示", response.message);
                }
            }).error(function () {
                $.MsgBox.Alert("提示", "获取车队失败，请重试！");
            });
        }
        $scope.clearMotorcade = function () {
            $scope.motorcade.id = "";
            $scope.motorcade.no = "";
            $scope.motorcade.name = "";
            $scope.motorcade.fromCity = "";
            $scope.motorcade.toCity = "";
            $scope.motorcade.remark = "";
        }

        var GetTotalDriverNum = function () {
            $http.get("${wlpt}/wlpt/driver/getUserDriverNum").success(function (response) {
                $scope.totalDriverNum = response.data.totalDriverNum;
            });
        };
        GetTotalDriverNum();

        var closeAllModal = function () {
            $(".modal").modal("hide");
        }


        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetMotorcadeDriverPage);

        $scope.isDelete = function (id) {
            if (id == null || id == "") {
                return;
            }
            //  $(".loading_lock").show();
            $.MsgBox.Confirm("解绑提示", "是否解除该绑定?", function () {
                $.ajax({
                    url: "${wlpt}/wlpt/driver/deleteAttach",
                    data: {
                        id: id,
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("删除提示", data.value);
                        GetMotorcadeDriverPage();
                    }
                });
            }, function () {
                $("#maskloading", parent.document).hide();
            });
        };
        $scope.find = function (id) {
            if (id == null || id == "") {
                return;
            }
            $.ajax({
                url: "${wlpt}/wlpt/credit/getCredit",
                data: {
                    id: id,
                },
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data == 1) {
                        top.location.href = "${wlpt}/wlpt/credit/CompanyCredit?id=" + id;
                    }
                    if (data == 2) {
                        top.location.href = "${wlpt}/wlpt/credit/carCredit?id=" + id;
                    }
                    if (data == 0) {
                        $.alert("用户不存在");
                    }
                }
            });

        };
        $scope.check = function (url) {
            var status = "${user.userinfo.status}";
            if (status != '2') {
                $.MsgBox.Alert("温馨提示", "您还未认证");
            } else {
                window.location.href = url;
            }
        };
    }]);


</script>
</body>
</html>
