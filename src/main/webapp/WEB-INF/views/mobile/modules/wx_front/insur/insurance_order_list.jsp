﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>保单详情</title>
	<meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    <script src="${ctxStatic}/ionic/js/ionic.bundle.min.js"></script>
    
    <style type="text/css">
	body{
		background-color:#dddddd;
	}
    .bar-bottom{
    	height: 60px;
	    bottom: 0px;
	    position: fixed;
	   
    }
    .title-font{
    	font-size: 18px;
    	font-weight: 500;
    }
    </style>
</head>
<body ng-app="insurlist" ng-controller="insurlistCtrl">
	
	<ion-content>
	   <ion-refresher pulling-text="下拉刷新" on-refresh="doRefresh()"></ion-refresher>
		<div ng-repeat="x in data">
			<div class="list">
				<div class="item item-header" style="height:45px;">
					<span>{{x.insurancetype}}</span>
					<span class="pull-right balanced" style="font-weight:700;">{{x.status}}</span>
				</div>
	
				<a class="item item-avatar" href="${wx}/weixin/insur/input?id={{x.id}}">
					<img src="{{x.insurlist.insurLogo}}" >
					<h2 ng-if="x.insurlist.ismeasure==0" >{{x.shipAddress.info}}-{{x.consignAddress.info}}</h2>
					<p>被保人:{{x.user.name}}&nbsp;车牌:{{x.carnumber}}</p>
					<p>{{x.createDate}}</p>
				</a>
					
				<div class="item" style="height:50px;">
					<div class="pull-right">
						<span ng-if="x.statusInt==0 && x.insurlist.ismeasure==0" style="color: #07c3f9;"><a  href="${wx}/weixin/insur/toinsurpay?id={{x.id}}" >立即支付</a></span>
						<span ng-if="x.statusInt==0 && x.insurlist.ismeasure==1 && x.measurestatus==1" style="color: #07c3f9;"><a  href="${wx}/weixin/insur/toinsurpay?id={{x.id}}" >立即支付</a></span>
						<span ng-if="x.statusInt==0 && x.insurlist.ismeasure==1 && x.measurestatus!=1" style="color: #dd5600;">保单测算中</span>
						<span style="margin-left: 20px;">实付款:&nbsp;<i class="icon ion-social-yen"></i></span>
						<span style="font-weight:700;">{{x.insurancefeel!=null?x.insurancefeel:"?"}}</span>
					</div>
				</div>
				<br/>
			</div>
		</div>	
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
    		url:'${wx}/weixin/insur/list',
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
            	url:'${wx}/weixin/insur/list',
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
        		url:'${wx}/weixin/insur/list',
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