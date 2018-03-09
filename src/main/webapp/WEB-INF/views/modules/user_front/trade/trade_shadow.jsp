<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <title>运单跟踪</title>
<link href="/static/front/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/per_global.css" type="text/css" rel="stylesheet"/>

    <style type="text/css">
       
    </style>
</head>
<body  ng-app="dataHall" ng-controller="dataHallCtrl">
<div class="tab-pane fade in active" id="waybill_track" >
     <div class="timeline">
         <div class="timeline-item">
             <div class="timeline-desk">
                 <div class="panel">
                     <div class="panel-body">
                         <span class="arrow"></span>
                         <span class="timeline-icon red"></span>
                         <span class="timeline-date"><fmt:formatDate value="${orderinfo.quoteinfo.goods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                         <h1 class="red">发布货源</h1>
                         <p>

                             <i class="fa fa-cube"></i>${orderinfo.quoteinfo.goods.goodsname } <span class="vertical-line">|</span>${orderinfo.quoteinfo.goods.freightvolume }${orderinfo.quoteinfo.goods.freightunit}
                             <br>
                             <i class="fa fa-map-marker"></i>
                             ${orderinfo.quoteinfo.goods.shipAddress.province}
	                         ${orderinfo.quoteinfo.goods.shipAddress.city}
	                         ${orderinfo.quoteinfo.goods.shipAddress.district}
                             <br>
                             <i class="fa fa-map-marker"></i>
                             ${orderinfo.quoteinfo.goods.consignAddress.province}
	                         ${orderinfo.quoteinfo.goods.consignAddress.city}
	                         ${orderinfo.quoteinfo.goods.consignAddress.district}
                         </p>
                     </div>
                 </div>
             </div>
         </div>
         <div class="timeline-item alt">
             <div class="timeline-desk">
                 <div class="panel">
                     <div class="panel-body">
                         <span class="arrow-alt"></span>
                         <span class="timeline-icon green"></span>
                         <span class="timeline-date"><fmt:formatDate value="${orderinfo.quoteinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                         <h1 class="green">车主抢单</h1>
                         <p>

                             <i class="fa fa-truck"></i>${orderinfo.quoteinfo.car.carnumber} 
                             <span class="vertical-line">|</span>${orderinfo.quoteinfo.car.carlength}米
                             
                             <span class="vertical-line">|</span>报吨:${orderinfo.quoteinfo.oddloadweight}吨
                             <c:if test="${orderinfo.quoteinfo.isreload==1 }">
                             	<span class="vertical-line">|</span>实配:${orderinfo.quoteinfo.actload}吨
                             </c:if>
                             <span class="vertical-line">|</span>报价:${orderinfo.quoteinfo.ooferprice}元/吨
                             <span class="vertical-line">|</span>总运价:${orderinfo.totalcost}元
                             <br/>

                             <!-- <i class="fa fa-user"></i>广东省广州市天河区天河区元岗横路310号智慧PARk创意园B座505 -->

                         </p>
                     </div>
                 </div>
             </div>
         </div>
         
         <div ng-repeat="x in data"  class="timeline-item {{$index%2==0? '':'alt'}}" >
	         
	             <div class="timeline-desk">
	                 <div class="panel">
	                     <div class="panel-body">
	                         <span class="{{$index%2==0? 'arrow':'arrow-alt'}}"></span>
	                         <span class="timeline-icon {{$index==0? 'blue':$index==1? 'purple':$index==2? 'light-green':$index==3? 'light-yellow':$index==4? 'orange':'blue'}}"></span>
	                         <span class="timeline-date" ng-clock>{{x.createDate}}</span>
	                         <h1 class="{{$index==0? 'blue':$index==1? 'purple':$index==2? 'light-green':$index==3? 'light-yellow':$index==4? 'orange':'blue'}}" ng-clock>{{x.status}}</h1>
	                         <p ng-clock>
	                             <i class="fa  fa-users"></i>{{x.content}}
	                         </p>
	
	                     </div>
	                 </div>
	             </div>
	         
         </div>
        
         
     </div>
 </div>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script>
var isReturn = false;
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];
        $scope.id = '${orderinfo.id}';
        //get first page
        $http({
            url: '${wlpt}/wlpt/trade/getTraceList',
            method: 'post',
            params: {
                'id': $scope.id,
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.data;
            isReturn = true;
        });
        
    });
    function loads(height){
   	 
    	
    	var myFrameheight = height +10;
    	top.$("#myFrame").height(0); //清空父级iframe高度
        $("#myFrame",parent.document).height( myFrameheight < 500 ? 500 : myFrameheight);//重新设置父级iframe高度
        $("#waybill_track").height( myFrameheight < 500 ? 500 : myFrameheight );//重新设置container高度
        //
  		top.top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
        var heights =  height + 210;
        top.top.$("#rightFrame").height( heights < 500 ? 500 : heights );//重新设置父级的父级iframe高度
        
    }
    $(function(){
        var t = setInterval(function(){
            
      	  if(isReturn == true){
      	   	//重置页面高度
       		loads($("#waybill_track").height());
       		clearInterval(t);
      	}
      	},500)
    })


</script>
</body>
</html>
