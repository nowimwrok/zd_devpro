<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>车辆管理</title>
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

        .hsimg img {
            width: 50px;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">车辆管理</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-2">
                                <input id="searchinfo" ng-model="searchData.searchinfo" type="text" class="form-control"
                                       placeholder="车牌号/手机号"/>
                            </div>
                            <div class="col-sm-2">
                                <input id="cartype" type="text" ng-model="searchData.cartype" class="form-control"
                                       placeholder="车型"/>
                            </div>
                            <div class="col-sm-2">
                                <select id="issocialcar" ng-model="searchData.issocialcar" class="form-control"
                                        placeholder="归属">
                                    <option value=''>车辆类型</option>
                                    <option value='0'>自有车辆</option>
                                    <option value='1'>社会车辆</option>
                                </select>
                            </div>
                            <div class="col-sm-6 text-left">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i> 查询
                                </button>
                                <a class="btn btn-success"
                                   ng-click="check('${wlpt}/wlpt/driver/attach_list')">
                                    <i class="fa fa-ls white"> </i> 司机绑定</a>
                                <a class="btn btn-success" id="fabu"
                                   ng-click="check('${wlpt}/wlpt/car/toSave')">
                                    <i class="fa fa-plus-square white"> </i> 添加车辆
                                </a>
                            </div>
                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table" id="carlist_table">
                            <thead>
                            <tr>
                                <th>车牌号</th>
                                <th>车辆类型</th>
                                <th>车型</th>
                                <th>车长</th>
                                <th>载重</th>
                                <th>状态</th>
                                <th>交易信息</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    {{x.carnumber}}
                                    <%--<span class="vertical-line">|</span>联系电话：{{x.user.phone != null ? x.user.phone:"保密"}}--%>

                                </td>
                                <td ng-cloak>
                                    {{x.issocialcar}}
                                </td>
                                <td ng-cloak>
                                    {{x.cartype}}
                                </td>
                                <td ng-cloak>
                                    {{x.carlength}}米
                                </td>
                                <td ng-cloak>
                                    {{x.loadweight}}吨
                                </td>
                                <td ng-cloak>

                                    <span ng-if="x.status=='未认证'" class="red">{{x.status}}</span>
                                    <span ng-if="x.status=='已申请'" class="yellow">{{x.status}}</span>
                                    <span ng-if="x.status=='已认证'" class="green">{{x.status}}</span>

                                </td>
                                <td ng-cloak>
                                    <!-- <p>{{x.gpsloc.info!=null?x.gpsloc.info.substr(0,20)+'...':"暂无定位信息"}}</p>
                                    <p>{{x.gpsloc.gpstime!=null?x.gpsloc.formatgpstime:"暂无定位信息"}}</p> -->
                                    共成交{{x.tradecount}}笔交易

                                </td>
                                <td ng-cloak>
                                    <a ng-click="getObjDetail(x.id)" class="see oprate" data-toggle="modal"
                                       data-target="#modal">查看</a>
                                    <a ng-if="x.status=='未认证'" href="${wlpt}/wlpt/car/toSave?id={{x.id}}"
                                       class="green oprate">编辑</a>
                                    <a ng-if="x.status=='未认证'" href="${wlpt}/wlpt/car/getCarInfo?id={{x.id}}"
                                       class="green oprate">申请认证</a>

                                    <a ng-if="x.status=='已认证'"
                                       href="${wlpt}/wlpt/carsource/toSave?type=0&carid={{x.id}} "
                                       class="green oprate">发布车源</a>

                                    <a href="javascript:" ng-click="isDelete(x.id)"
                                       class="orange oprate">删除</a>
                                    <a href="${wlpt}/wlpt/trade/trade_list?searchinfo={{x.carnumber}}" target="content"
                                       class="see oprate">运单</a>
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
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal"
         style="margin:auto;overflow-y:hidden;">
        <div>
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">车辆详情</h4>
                </div>
                <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;">
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            车辆号码：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.carnumber}}
                        </div>
                    </div>
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            车辆性质：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.issocialcar}}
                        </div>
                    </div>
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            车辆类型：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.cartype}}
                        </div>
                    </div>
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            车辆长度：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.carlength}}米
                        </div>
                    </div>
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            车辆载重：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.loadweight}}吨
                        </div>
                    </div>
                    <div class="col-sm-6 form-group">
                        <div class="col-sm-5 text-right">
                            主营路线：
                        </div>
                        <div class="col-sm-7 text-left">
                            {{detal.entity.mainroad}}
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-3 text-right" style="width:20%">
                            行驶证照片：
                        </div>
                        <div class="col-sm-9 hsimg">
                            <img ng-repeat="xs in detal.travelList" src="{{xs}}" alt=""
                                 onerror="this.onerror=null;this.src='${ctxStatic}/images/wlptfront/photo.png'"/>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-3 text-right" style="width:20%">
                            车辆外观照片：
                        </div>
                        <div class="col-sm-9 hsimg">
                            <img ng-repeat="sf in detal.surfaceList" src="{{sf}}" alt=""
                                 onerror="this.onerror=null;this.src='${ctxStatic}/images/wlptfront/photo.png'"/>
                        </div>
                    </div>
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
                'issocialcar': $("#issocialcar").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/car/getCarList',
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

        $scope.getObjDetail = function (id) {
            $http.get("${wlpt}/wlpt/car/getDetail?id=" + id).success(function (response) {
                $scope.detal = response.data;/// 招标详情
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
            $.MsgBox.Confirm("删除提示", "是否删除该车辆?", function () {
                $.ajax({
                    url: "${wlpt}/wlpt/car/deleteCar",
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
                $("#maskloading", parent.document).hide();
            });
        };
        $scope.check = function (url) {
            var status = "${user.userinfo.status}";
            if (status != '2') {
                $.MsgBox.Alert("温馨提示", "您还未认证");
            } else {
                window.location.href = url;
            }
        }

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

    var bheight = document.documentElement.clientHeight;
    var bwidth = document.documentElement.clientWidth;
    //弹框
    $('#modal').css('width', bwidth * .76 + 'px').css('height', bheight * .8 + 'px');
    $('.modal-body-h').css('height', bheight * .8 + 'px');
</script>
</body>
</html>
