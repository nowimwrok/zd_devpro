<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/per_global.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/personal.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic }/front/css/add.css"/>
</head>
<body>
<div class="insurance" ng-app="dataHall" ng-controller="dataHallCtrl">
    <!--图片-->
    <div class="increase_ad">
        <img src="${ctxStatic }/images/wlptfront/img/increase/insurance.jpg" alt=""/>
    </div>
    <!--购买列表-->
    <div class="insurance_list" style="margin-bottom:50px;">
        <table style="width:100%;">
            <tr class="list_title">
                <th class="text-center"><b>币种</b></th>
                <th class="text-center"><b>保险类型</b></th>
                <th class="text-center"><b>保障类型</b></th>
                <th class="text-center"><b>最高保额</b></th>
                <th class="text-center"><b>操作</b></th>
            </tr>

            <tr ng-repeat="x in data">

                <td class="text-center">
                    <img src="{{x.insurLogo}}" alt=""/>
                </td>
                <td class="text-center">{{x.insurName}}</td>
                <td class="text-center">{{x.validityTerm}}</td>
                <td class="text-center"><span class="red">{{x.maxAmount}}</span></td>
                <td class="text-center"><a href="${wlpt}/wlpt/shop/buyInsurDetail?id={{x.id}}">
                    <button class="btn btn-primary" id="buySubmit">购买</button>
                </a></td>

            </tr>

        </table>

        <!--分页-->
        <div style="padding:0 10px;">
            <tm-pagination conf="paginationConf"></tm-pagination>
        </div>

        <div id="noneData"
             style="display: none; text-align: center; width: 100%; line-height: 25px;">
            <img src="${ctxStatic }/front/img/nodata.png"
                 style="width: 100px; height: 100px;">
        </div>


    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>


<script>
    var app = angular.module("dataHall", ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };

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

        var GetAllEmployee = function () {
            var postData = {
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/shop/getInsuranceList',
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


        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);


    }]);


</script>
</body>
</html>

