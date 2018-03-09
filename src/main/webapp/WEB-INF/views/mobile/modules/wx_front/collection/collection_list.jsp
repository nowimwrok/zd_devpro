﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>${fns:getConst('SYSTEMTITLE')}--我的关注</title>
	<meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    <script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
    <script src="${ctxStatic}/ionic/js/ionic.bundle.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
    
    <style type="text/css">
	body{
		background-color:#dddddd;
	}
	
	.search_top {
		width: 100%;
		display: block;
		border-bottom: 1px dashed #999;
		z-index: 2;
		position: fixed;
		background-color: #EBEBEB;
	}
	
	.search_top {
		height: 50px;
		width: 100%;
		line-height: 50px;
		border-bottom: 1px solid #EBEBEB;
		background-color: #FFF;
		margin: 0px auto;
	}
	
    .bar-bottom{
    	height: 60px;
	    bottom: 0px;
	    position: fixed;
	   
    }
    .top {
		top: 0px;
	}
	.data_tab div {
		float: left;
		text-align: center;
		width: 33.3%;
		font-size: 16px;
	}
	
	.data_tab {
		width: 100%;
		margin: 0px auto;
	}
	
	/* .selected {
		color: #F74000;
	} */
	.selected {
	    /* background-color: rgb(255,247,244); */
	    /* color: rgb(27, 216, 244); */
	    color:#FFBB66;
	    border-bottom: 2px solid #FFBB66;
	    background-color:rgba(32, 162, 226, 1);
	}
    .title-font{
    	font-size: 18px;
    	font-weight: 500;
    }
    #data_box {
		width: 98%;
		margin: 0 auto;
		margin-top: 55px;
		margin-bottom: 30px;
	}
    </style>
</head>
<body ng-app="collection" ng-controller="collectionCtrl">
	<div class="search_top top" style="background-color:rgba(32, 162, 226, 1);color:white;">
		<div class="data_top data_tab" >
			<div class="selected" ng-click="searchcollection(1)" >车源(<span id="car">${carcount }</span>)</div>
			<div ng-click="searchcollection(2)">货源(<span id="goods">${goodscount }</span>)</div>
			<div ng-click="searchcollection(3)" style="float:right">招标(<span id="bid">${bidcount }</span>)</div>
			<!-- <div>待评价</div> -->
		</div>
	</div>
	<ion-content id="data_box">
	   <ion-refresher pulling-text="下拉刷新" on-refresh="doRefresh()"></ion-refresher>
		<div ng-repeat="x in data" >
			<div class="list">
				<!-- <div class="item item-header" style="height:45px;">
					<span>{{x.insurancetype}}</span>
					<span class="pull-right balanced" style="font-weight:700;">{{x.typename}}</span>
				</div> -->
	
				<a class="item" >
					<h2>{{x.fromprovince}} {{x.fromcity}}-{{x.toprovince}} {{x.tocity}}</h2>
					<p>{{x.createDate}}</p>
				</a>
					
				<div class="item" style="height:50px;">
					<div class="pull-left">
						{{x.typename}}
					</div>
					<div class="pull-right">
						<span style="color: #07c3f9;"><a href="javascript:;" ng-click="deletecollection(x.id,'{{x.typename}}')" >取消关注</a></span>
					</div>
				</div>
				<br/>
			</div>
		</div>	
		<div id="loading"
			style="width:100%;margin-top:100px;vertical-align: middle;text-align:center;height:45px">
			<div>
				<img src='${ctxStatic}/images/weixin/loading.gif' style="width:70px">
			</div>
			<div style=''>正在努力加载中，请稍等!</div>
		</div>
			<input class = "item" ng-model="pageNo" type="hidden">
			<input class = "item" ng-model="pageSize" type="hidden">  
			<input class = "item" ng-model="pagecount" type="hidden"> 
 		<ion-infinite-scroll ng-if="hasNext()" on-infinite="loadMore()" distance="10%" ></ion-infinite-scroll>
	</ion-content>
	<ion-footer-bar align-title="center"  class="bar-calm">
		<h1 class="title" ng-click="addcollection()">添加关注线路</h1>
	</ion-footer-bar>
<script>
    angular.module("collection", ['ionic'])
   	.controller('collectionCtrl',['$scope','$timeout','$http', function ($scope,$timeout, $http) {
   		var run = false;
   		$("#loading").hide();
   		$scope.hasMore = true;
 		$scope.count = 0;
		$scope.pageNo= 0;
		$scope.pageSize= 4;
		$scope.targettype = 1;
		$scope.data = [];
		
		$scope.iscount = function (number) {
            if ($scope.targettype ==1 ){
                $("#car").html(number);
            }else if ($scope.targettype==2){
            	$("#goods").html(number);
            }else{
            	$("#bid").html(number);
            }
        };
        $scope.addcollection = function () {
        	window.location.href = '${wx}/weixin/collection/toCollectionAdd?targettype='+$scope.targettype;
        }
        var targettype1 = '${type}';
        if(targettype1!=''){
        	$(".data_tab div").removeClass("selected");
			$(".data_tab div").eq((targettype1*1)-1).addClass("selected");
			
			$scope.targettype = targettype1;
			$("#loading").show();
        }
		$scope.searchcollection = function (type) {
			$(".data_tab div").removeClass("selected");
			$(".data_tab div").eq((type*1)-1).addClass("selected");
			
			$scope.targettype = type;
			$("#loading").show();
			$scope.doRefresh();
			
		};
		$scope.deletecollection = function (id,type) {
			$("#loading").show();
            if (id == null || id == "") {
                return;
            }
            $.MsgBox.Confirm("删除提示","确定取消关注该"+type+"线路信息?",function(){
            	
                $.ajax({
                    url: "${wx}/weixin/collection/deleteCollection",
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                    	$.MsgBox.Alert("删除提示",data.value);
                        $("#loading").hide();
                        $scope.doRefresh();
                    }
                });
            },function(){
            	$("#loading").hide();
               // $(".loading_lock").hide();
            },"是","否");

        };
		
     	$http({
    		url:'${wx}/weixin/collection/list',
    		method:'get',
      		params:{
      			'targettype':$scope.targettype,
    			'pageSize':$scope.pageSize
    		}
    	}).success(function(res){
    		 $("#loading").hide();
    		$scope.data = res.list;
    		$scope.count = res.count;
    		$scope.pageNo= res.pageNo;
    		$scope.pageSize= res.pageSize;
    		$scope.iscount(res.count);
    	});
    	
     	
        $scope.doRefresh = function() {            
            $http({
            	url:'${wx}/weixin/collection/list',
            	method:'get',
           		params:{
           			'targettype':$scope.targettype,
        			'pageSize':$scope.pageSize
        		}
            }).success(function(res){
            	 $("#loading").hide();
            	$scope.data = res.list;
        		$scope.count = res.count;
        		$scope.pageNo= res.pageNo;
        		$scope.pageSize= res.pageSize;
        		$scope.iscount(res.count);
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
        		url:'${wx}/weixin/collection/list',
        		method:'get',
        		params:{
        			'targettype':$scope.targettype,
        			'pageNo':$scope.pageNo,
        			'pageSize':$scope.pageSize
        			
        		}
        	}).success(function(res){
        		 $("#loading").hide();
        		run = false;
        		$scope.data = $scope.data.concat(res.list);
        		$scope.iscount(res.count);
        	}).finally(function(){
    			$scope.$broadcast('scroll.infiniteScrollComplete');
        	});
        }
       }  
    }]);
</script>
</body>
</html>