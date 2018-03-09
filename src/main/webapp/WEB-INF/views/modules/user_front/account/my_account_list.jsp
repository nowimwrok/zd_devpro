<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>子账户管理</title>
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

    <!--table-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">子账户管理</h4>
                </div>
                <div class="panel-body" style="padding-bottom:30px;">
                    <div class="col-lg-12 search_wrap">
                        <div class="col-sm-2">
                            <input placeholder="用户名/电话" id="searchinfo" value="" class="form-control">
                        </div>
                        <div class="col-sm-2">
                            <input class="form-control" name="beginCreateDate" id="beginCreateDate"
                                   placeholder="选择开始时间"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                        </div>
                        <div class="col-sm-2">
                            <input class="form-control" name="endCreateDate" id="endCreateDate"
                                   placeholder="选择结束时间"
                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                        </div>
                        <div class="col-sm-4 text-left">
                            <button class="btn btn-primary" ng-click="searchInfo()"><i
                                    class="fa fa-search white"></i> 查询
                            </button>
                            <button class="btn btn-success" id="btnAdd">
                                <i class="fa fa-plus-square white"> </i> 添加
                            </button>
                        </div>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table" id="sonAccount_list">
                            <thead>
                            <tr>
                                <th>登录名</th>
                                <th>姓名</th>
                                <th>部门</th>
                                <th>手机号码</th>
                                <th>上次登录</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr ng-repeat="x in data">
                                <td ng-cloak>{{x.loginName}}</td>
                                <td ng-cloak>{{x.name}}</td>
                                <td ng-cloak>{{x.office.name}}</td>
                                <td ng-cloak>{{x.phone}}</td>
                                <td ng-cloak>{{x.loginDate}}</td>
                                <td ng-cloak>{{x.createDate}}</td>
                                <td><a href="#" class="see oprate" ng-click="deleteUser(x.id)">删除</a></td>
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
<script src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script>
    $(function () {
        $("#btnAdd").click(function () {
            var status = '${user.userinfo.status}';
            if (status == null || status == '' || status == undefined || status != '2') {
            	$.MsgBox.Alert("温馨提示!", "请先完成认证,才可添加");
            }else{
            	 window.location.href = "${wlpt}/wlpt/account/toAddAccount";
            }
           
        });
    });


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
            if( $scope.paginationConf.currentPage ==1){
                $scope.paginationConf.currentPage = 0;
            }else{
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'beginCreateDate': $("#beginCreateDate").val(),
                'endCreateDate': $("#endCreateDate").val(),
                'searchinfo': $("#searchinfo").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/account/myAccountList',
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
        $scope.deleteUser = function (id) {

            $.MsgBox.Confirm("温馨提示", "您确定删除该子账户信息吗?", function () {
                $.ajax({
                    url: "${wlpt}/wlpt/account/deleteMyuser",
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("温馨提示", data.message);
                        GetAllEmployee();
                    }
                });
            }, null, null, null, "确定", "取消");
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
