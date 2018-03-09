<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

    <title>我的中奖</title>

    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    <script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
    <script src="${ctxStatic}/ionic/js/ionic.bundle.min.js"></script>


    <link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
    <style type="text/css">

        .bar-bottom{
            height: 60px;
            bottom: 0px;
            position: fixed;

        }
        .title-font{
            font-size: 18px;
            font-weight: 500;
        }
        *{box-sizing:border-box;margin:0;padding:0;font-family:"Microsoft YaHei",Times New Roman,Georgia,Serif;font-size: 14px;}
        ul,ol{list-style: none;}
        a,a:hover,a:active,a:focus{text-decoration: none;}

        *{box-sizing:border-box;}
        .ticket i{font-style: normal;font-size:1em;}
        .text_center{text-align:center}
        .ticket{width:100%;margin-top:10px;}
        .ticket li{position:relative;width:90%;margin:0 auto;margin-bottom:20px;height:6em;background:url(${ctxStatic}/front/img/bg_quan3.png) no-repeat;background-size:100% 100%;}
        .ticket li.over{background:url(${ctxStatic}/front/img/quan_over.png) no-repeat;background-size:100% 100%;}
        .ticket li.over span,.ticket li.over h2,.ticket li.over p,.ticket li.over b{color:#f0f0f0;}
        .ticket li.over span{border-color:#f0f0f0;}
        .ticket li span,.ticket li h2,.ticket li p,.ticket li b,.ticket h3{color:#fff;letter-spacing: 2px;}
        .ticket li b{font-size:2em;}
        .quan_text{margin-top:1.5em}
        .ticket li h2{margin-top:0em;padding-left:0.8em;letter-spacing: 0px;}
        .ticket h3{font-size:1em;font-weight:200; margin-bottom: 5px;}
        .ticket li p{font-size:1em;}
        .ticket li span{position:absolute;top:7px;left:11px;width:24px;height:24px;line-height:24px;font-size:1.1em;text-align:center;border-radius:100%;border:1px solid #fff;}
        .ticket .h3_m{}
        .have{width:60px;height:20px;position:absolute;top:30px;right:6px;color: #dd1010;}
        .lt{float:left;}
    </style>
</head>

<body ng-app="insurlist" ng-controller="insurlistCtrl">
<ion-content>
    <ion-refresher pulling-text="下拉刷新" on-refresh="doRefresh()"></ion-refresher>
    <div class="ticket">
        <ul ng-repeat="x in data">
                <li >
                   <i class="have">【{{x.issuename}}】</i>
                    <span class="text_center quan">券</span>
                    <h2 class="text_center h3_m lt"><i>￥</i><b>{{x.wxgift.giftworth | number : 0 }} </b></h2>
                    <div class="lt quan_text">
                        <h3>优惠券</h3>
                        <p class="text_center">{{x.gifttypename }}</p>
                    </div>
                </li>
        </ul>
    </div>
    <%--<div id="data_box" style="padding-top:5px;" ng-repeat="x in data">

        <div id="data_div" class="data_div" >
            <div class="data_row data_btm">
                <div class="flt">活动名称:{{}}' + data.ACTIVITY_NAME + '</div>
                <div class="frt" style="float:right;"><span class="">' + issue + '</span></div>
                </div>
            <div class="data_row data_btm">
                <div class="flt">奖品名称:' + data.GIFTNAME + '</div>
                <div class="frt" style="float:right;">' + data.CREATETIME + '</div>
            </div>
            <div class="data_row data_btm" style="border:none">
                <div>奖品描述：' + data.GIFTCONTENT + '</div>
            </div>
        </div>

    </div>--%>
    <input class = "item" ng-model="pageNo" type="hidden">
    <input class = "item" ng-model="pageSize" type="hidden">
    <input class = "item" ng-model="pagecount" type="hidden">
    <ion-infinite-scroll ng-if="hasNext()" on-infinite="loadMore()" distance="10%" ></ion-infinite-scroll>
</ion-content>
<ion-footer-bar align-title="center"  class="bar-calm">
    <h1 class="title">共有{{count}}条</h1>
</ion-footer-bar>

<script>
    angular.module("insurlist", ['ionic'])
        .controller('insurlistCtrl',['$scope','$timeout','$http', function ($scope,$timeout, $http) {
            var run = false;

            $scope.hasMore = true;
            $scope.count = 0;
            $scope.pageNo= 0;
            $scope.pageSize= 4;
            $scope.data = [];


            $http({
                url:'${wx}/weixin/activitylottery/getOwnerAward',
                method:'get',
                params:{
                    'pageSize':$scope.pageSize
                }
            }).success(function(res){
                $scope.data = res.list;
                $scope.count = res.count;
                $scope.pageNo= res.pageNo;
                $scope.pageSize= res.pageSize;
            });


            $scope.doRefresh = function() {
                $http({
                    url:'${wx}/weixin/activitylottery/getOwnerAward',
                    method:'get',
                    params:{
                        'pageSize':$scope.pageSize
                    }
                }).success(function(res){
                    $scope.data = res.list;
                    $scope.count = res.count;
                    $scope.pageNo= res.pageNo;
                    $scope.pageSize= res.pageSize;
                }).finally(function(){
                    $scope.$broadcast('scroll.refreshComplete');

                });
            }

            $scope.hasNext = function(){
                $scope.pagecount = $scope.count / $scope.pageSize ;
                /* console.log($scope.pagecount); */
                if($scope.pageNo < $scope.pagecount){

                    return true;
                }
                else{
                    return false;
                }

            }


            $scope.loadMore = function(){

                if($scope.pageNo == 0){
                    $scope.$broadcast('scroll.infiniteScrollComplete');
                    return null;
                }


                if(!run){
                    run = true
                    $scope.pageNo++;
                    $http({
                        url:'${wx}/weixin/activitylottery/getOwnerAward',
                        method:'get',
                        params:{
                            'pageNo':$scope.pageNo,
                            'pageSize':$scope.pageSize
                        }
                    }).success(function(res){
                        run = false;
                        $scope.data = $scope.data.concat(res.list);
                    }).finally(function(){
                        $scope.$broadcast('scroll.infiniteScrollComplete');
                    });
                }



            }
        }]);
</script>
</body>
</html>
