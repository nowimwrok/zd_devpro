<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@include
	file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<title>运输监管</title>
<link rel="stylesheet" href="${ctxStatic}/front/css/add.css?id=2" />

<style type="text/css">
label.BMapLabel {
	border-radius: 22px !important;
	background-color: rgba(22, 22, 22, 0.75) !important;
	border: 1px solid rgb(250, 255, 22) !important;
	padding: 5px !important;
	min-width: 100px;
	font-size: 14px !important;
	color: rgba(251, 234, 46, 0.99) !important;
}

.BMapLib_SearchInfoWindow {
	background-color: rgba(55, 55, 55, 0.85);
	color: #ffee23;
	line-height: 24px;
	border-radius: 5px;
}

.BMapLib_bubble_content {
	background-color: rgba(55, 55, 55, 0.85);
}

.BMapLib_bubble_top {
	border-bottom: 1px solid #ccc;
	height: 31px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	border: 1px solid #FFF;
	color: #b51720;
}

.BMapLib_bubble_title {
	font-size: 15px !important;
	font-weight: bold;
}

.esriPopup .titlePane {
	background-color: #DDDDDD;
	color: #000000;
	line-height: 24px;
	font-weight: 900;
	border-radius: initial;
}

.car_check .pull-left {
	margin-right: 50px;
}

.toggle_msg {
	width: 76px;
	display: block;
	position: absolute;
	top: 80%;
	left: 300px;
	border-radius: 5px;
	line-height: 24px;
	color: #fff;
	border: 0;
	padding: 5px 10px;
	opacity: .8;
	display: none;
}
</style>
</head>
<body style="background: #f5f5f5;">
	<div class="row" id="main_con" ng-app="dataHall"
		ng-controller="dataHallCtrl">
		<!--相当于iframe-->
		<div class="col-lg-12" style="">
			<div class="col-sm-12 clearfix map">
				<div id="dituContent"
					style="z-index: 0; background-color: red; position: absolute; top: 0; left: 0; width: 100%;"></div>
				<div class="car_detail">
					<div>
						<a class="tdFir detail_text" id="ordernotext"></a>
					</div>
					<div>
						<a class="tdFir detail_text" id="speedtext"></a>
					</div>
					<div>

						<a class="tdFir detail_text"><b id="timetext"></b><span
							id="datetext"></span></a>
					</div>
					<div>
						<a class="detail_text"><b id="carnumbertext"></b></a>
					</div>
					<div>
						<a class="detail_text"><b id="drivingstatetext"></b></a>
					</div>
				</div>
				<!--左边内容-->
				<div class="map_l">
					<!--搜索框-->
					<div class="col-sm-12 map_search" style="padding: 0;">
						<div class="col-sm-9" style="padding: 0;">
							<input type="text" id="searchinfo" name="searchinfo" value=""
								placeholder="请输入车牌号码或运单号" class="form-control"> <i
								class="glyphicon glyphicon-search"></i>
						</div>
						<button class="col-sm-3 btn btn-primary" ng-click="searchInfo()"
							style="margin-top: 0;">查询</button>
					</div>
					<!--table内容-->
					<div class="col-sm-12" style="padding: 0;">
						<table class="table table-hover table-bordered" id="track_table">
							<thead>
								<tr>
									<th class="text-center">运单编号</th>
									<th class="text-center">车辆</th>
								</tr>
							</thead>
							<tbody class="datainit">
								<tr ng-repeat="x in data">
									<td class="text-center" ng-cloak><a href="" class="tdFir"
										ng-click="getOrderinfo(x.orderno,x.quoteinfo.car.carnumber)">{{x.orderno!=null
											?x.orderno:"无相关运单"}}</a></td>
									<td class="text-center" ng-cloak><a href="" class="tdFir"
										ng-click="getOrderinfobycar(x.orderno,x.quoteinfo.car.carnumber)">{{x.quoteinfo.car.carnumber}}</a>
									</td>
								</tr>

							</tbody>
						</table>
					</div>
					<div id="noneData"
						style="display: none; text-align: center; width: 100%; line-height: 25px;">
						<img src="${ctxStatic }/front/img/nodata.png"
							style="width: 100px; height: 100px;">
					</div>
					<!--分页-->
					<tm-pagination conf="paginationConf"></tm-pagination>
				</div>
				<!--底下内容-->
				<button class="toggle_msg bg-primary">详细信息</button>
				<div class="map_r pull-right">
					<button class="close closeAll" style="opacity: .8;">&times;</button>
					<div class="col-sm-6">
						<div class="car_msg clearfix">
							<p class="pull-left">
								<b id="x_carnumber"></b> <a class="tdFir" id="x_name"></a>
							</p>
							<p class="pull-right">
								<span class="green" id="x_status"></span>
							</p>
						</div>
						<div class="col-sm-12">
							<p id="x_address"></p>

						</div>
						<div class="car_data col-sm-12">
							<h4 style="margin-top: 0;">行车数据</h4>
							<div class="col-sm-12">
								<p>
									<span>司机姓名：</span> <span id="drivername"></span>

								</p>
								<p>
									<span>司机手机号：</span> <span id=driverphone></span>
								</p>
								<p>
									<span>追踪次数：</span> <span id=locCount></span> <span>&nbsp;&nbsp;回放次数：</span>
									<span id=trailCount></span>
								</p>
							</div>

						</div>
					</div>
					<i class="line_track"></i>
					<div class="col-sm-6" style="position:relative;">
						<div class="car_msg clearfix">
							<p class="pull-left">
								<b>运单</b> <a class="tdFir" id="x_orderno"></a>
							</p>
							<p class="pull-right">
								<span class="green" id="x_tradestatus"></span>
							</p>
						</div>
						<div class="car_data col-sm-12">
							<div class="col-sm-12">
								<p>
									<span style="margin-right: 15px;" id="x_goodsname"></span> <span
										id="x_freightvolume"></span>
								</p>
								<p id="x_consignaddress"></p>
							</div>
						</div>
						<div class="col-sm-12  car_check">
							<div class="col-sm-12 clearfix">
								<div class="pull-left">
									<p class="text-center" >
										<i class="glyphicon glyphicon-screenshot"></i>
										<!-- <span class="badge">0</span> -->
									</p>
									<div>
										<a class="tdFir" onclick="getOrderinfobycars()">追踪</a>
									</div>
								</div>
								<div class="pull-left playShow">
									<p class="text-center">
										<i class="glyphicon glyphicon-search"
											 title="查询轨迹"></i>
									</p>
									<div>
										<a class="tdFir">查询轨迹</a>
									</div>
								</div>
								<div class="pull-left" id="btn-start">
									<p class="text-center">
										<i class="glyphicon glyphicon-play-circle" title="开始播放"></i>
									</p>
									<div>
										<a class="tdFir">开始播放</a>
									</div>
								</div>
								<div class="pull-left" id="stop">
									<p class="text-center">
										<i class="glyphicon glyphicon-record" title="停止播放"></i>
									</p>
									<div>
										<a class="tdFir">停止播放</a>
									</div>
								</div>
							</div>
						</div>
						<div class="car_track_play">
                			<button class="close text-center">x</button>
                			<div class="col-sm-12 clearfix play_time">
				                    <input type="text" readonly="readonly" class="form-control pull-left"
				                           name="beginCreateDate" id="beginCreateDate" 
				                           placeholder="选择开始时间"
				                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				                    <input type="text" readonly="readonly" class="form-control pull-right"
				                           name="endCreateDate" id="endCreateDate" 
				                           placeholder="选择结束时间"
				                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                				<!-- <input type="text" placeholder="请选择开始时间" class="form-control pull-left"/>
                				<input type="text" placeholder="请选择结束时间" class="form-control pull-right"/> -->
                				<span class="play_btn text-center" ng-click="getCarGpsinfo()"><i class="glyphicon glyphicon-play"></i></span>
                			</div>
                		</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=80f73f31cfbb40be26acda67af03da43"></script>
	<script src="${ctxStatic}/front/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/front/js/bootstrap-table.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/front/js/bootstrap-table-fixed-columns.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/front/js/bootstrap-table-zh-CN.min.js"></script>
	<!-- 加载百度地图样式信息窗口 -->
	<script type="text/javascript"
		src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>

	<link rel="stylesheet"
		href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<script type="text/javascript"
		src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script
        src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>	
	<script>
    var btime = "";
    var etime = "";
    var dcarnumber = "";
    var address="";
    var newtime="";
    var ordernos="";
	var carnumbers="";
    newtime=new Date().getHours();
    $("#maskloading", parent.document).hide();
    var w = document.documentElement.clientWidth;
    if (w < 1200) {
        $('.row').css('width', '1010px').css('background-color', '#fff').css('overflow-x', 'hidden').css('overflow-y', 'hidden');
        $('.data-model').css('height', '55px').find('.col-sm-2').css('margin-right', '1%');
    }
    //获取父元素中的某个元素
    var mask = $(".mask", parent.document);
    $('#btn').click(function () {
        $("#mask", parent.document).css('display', 'block');
    });
    /*map的高度*/
    var bheight = document.documentElement.clientHeight;
    $('.map').height(bheight - 35 + 'px');
    $('#dituContent').height(bheight - 35 + 'px')
    //地图下面的内容
    $('.map_r').width($('.map').width() - 300 + 'px');
  //显示隐藏底下内容
	$('.map_r .closeAll').click(function(){
    	$('.map_r').hide(500);
    	$('.toggle_msg').show(500);
    });
    $('.toggle_msg').click(function(){
    	$('.map_r').show(500);
    	$('.toggle_msg').hide(500);
    });
	$('.playShow').click(function(){
			$('#beginCreateDate').val(btime);
			$('#endCreateDate').val(etime);
		   $('.car_track_play').show(500);
		})
	$('.car_track_play .close').click(function(){
		   $('.car_track_play').hide(500);
		   
		})

    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            ishow: true,
            pagesLength: 3,
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
            $scope.paginationConf.currentPage = 0;
            GetAllEmployee();
        };
        var GetAllEmployee = function () {
            var postData = {
                'searchinfo': $("#searchinfo").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/trade/getCarAndTradeList',
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
        
        $scope.getOrderinfobycar = function (orderno, carnumber) {
        	
        	$.MsgBox.Confirm("系统提示", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl006','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {	
            if (carnumber != "" && carnumber != '' && carnumber != undefined) {
                $('.map_r').hide();
            } else {
                carnumber = carnumbers;
            }
            
            $("#maskloading", parent.document).show();
            $.ajax({
                url: "${wlpt}/wlpt/trade/carAndTradeInfo",
                data: {
                    orderNos: orderno,
                    carNumber: carnumber,
                    newtime:newtime
                },
                dataType: 'json',
                cache: false,
                success: function (date) {
                		var lng;
                    	var lat;
                    	var speed;
                        $("#maskloading", parent.document).hide();
                        var state=date.value.state;
                   	 	var data=date.value.data;
                        var orderdata = data[1];
                   	 	if(state==2){
                   	  		var datalist = data[0][0]; 
                   	 	}
                        if (orderno != "" && orderno != '' && orderno != undefined) {
                            $("#ordernotext").html("<b>运单号：</b>"+orderno);
                        } else {
                            $("#ordernotext").html("无相关运单");
                        }
                	if(state!=5){
                        if (datalist != null) {
                        	  renderMap(datalist);
                        	  $("#datetext").html((" "+datalist.RECEIVE_TIME).substring(0, 11));
    	                  	  $("#timetext").html((datalist.RECEIVE_TIME).substring(10, 19));
    	                  	  $("#carnumbertext").html(datalist.LICENSE_PLATE);
    	                  	  //$("#drivingstatetext").html(datalist.DRIVING_STATE);
    	                  	  $("#speedtext").html("<b >"+datalist.SPEED+"公里/</b>小时");
    	                  	  map_click(datalist.REAL_X, datalist.REAL_Y);
    	                  	  lng = datalist.REAL_X;
    	                	  lat = datalist.REAL_Y;
    	                	  speed = datalist.SPEED;
                        }else{
                        	if(data[2] != null && data[2][0] != null){
                        		loadMap(data[2],1);
                        		$("#carnumbertext").html(carnumber);
                        		if(data[2][0].carLocs != null){
    	                    		$("#datetext").html((" "+data[2][0].carLocs.formatgpstime).substring(0, 11));
    	  	                  	    $("#timetext").html((data[2][0].carLocs.formatgpstime).substring(10, 19));
    	  	                  	    
    	  	                  	    //$("#drivingstatetext").html(data.value[2][0].carLocs.state);
    	  	                  	    $("#speedtext").html("<b >"+data[2][0].carLocs.speed+"公里/</b>小时");
    	  	                  	    map_click(data[2][0].carLocs.lng*1, data[2][0].carLocs.lat*1);
    	                        	lng = data[2][0].carLocs.lng*1;
    	    	                	lat = data[2][0].carLocs.lat*1;
    	    	                	speed = data[2][0].carLocs.speed;	
                        		}else{
                        			$.MsgBox.Alert("系统提示", "该车辆无定位信息");
                        		}
                        	}else{
                        		loadMap(data[3].LocationVcln,1);
                        		var LocationVcln=data[3].LocationVcln.LocationVcln;
    	                  			if( LocationVcln!=null && LocationVcln.hasOwnProperty('utc')){
    	                  				var timestr=parseInt(LocationVcln.utc);
    	                  				var newDate1 = new Date();
    	                  				newDate1.setTime(timestr);
    	                  				$("#carnumbertext").html(carnumber);
    	                  				$("#datetext").html(newDate1.toLocaleString());
    	                  				$("#speedtext").html("<b >"+LocationVcln.spd+"km/</b>小时");
    	                  				lat=LocationVcln.lat/600000;
    	                  				lng=LocationVcln.lon/600000;
    	                  				speed=LocationVcln.spd;
    	                  				map_click(lng,lat);
    	                  			}else{
                          				$.MsgBox.Alert("系统提示", "该车辆无定位信息");
                          			}
                      			
                        	}
                        	
                        }
                        $("#maskloading" , parent.document).hide();
                        /* $('.map_r').show(); */

                        //画出路线
                        var startPoint = new BMap.Point(lng, lat);
                        if (orderdata.orderstatus == 0||orderdata.orderstatus == 1) {
                            var endAddress = orderdata.quoteinfo.goods.shipAddress.province + orderdata.quoteinfo.goods.shipAddress.city +
                                orderdata.quoteinfo.goods.shipAddress.district + orderdata.quoteinfo.goods.shipAddress.address;
                            var endAddressCity = orderdata.quoteinfo.goods.shipAddress.city;
                            getDrivingRoute(startPoint, endAddress, endAddressCity, 1,speed ,carnumber);//1为提货
                        } else if (orderdata.orderstatus == 3 || orderdata.orderstatus == 6 || orderdata.orderstatus == 7) {
                            var endAddress = orderdata.quoteinfo.goods.consignAddress.province + orderdata.quoteinfo.goods.consignAddress.city +
                                orderdata.quoteinfo.goods.consignAddress.district + orderdata.quoteinfo.goods.consignAddress.address;
                            var endAddressCity = orderdata.quoteinfo.goods.consignAddress.city;
                            getDrivingRoute(startPoint, endAddress, endAddressCity, 0,speed ,carnumber);//0为卸货
                        }
                    }else{
                    	$("#maskloading" , parent.document).hide();
                    	$.MsgBox.Alert("系统提示", "余额不足请充值");
                    }
                
                }
            });
        }, function () {
        	 $("#maskloading", parent.document).hide();
         }, "是", "否");    

        };
        
        $scope.getOrderinfo = function (orderno, carnumber) {
        		ordernos=orderno;
        		carnumbers=carnumber;
            	$.MsgBox.Confirm("提示信息", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl006','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {            $("#maskloading", parent.document).show();
                    dcarnumber = carnumber;
                	newtime=new Date().getHours();
                	$('.map_r').hide();
                  	$("#maskloading" , parent.document).show();
                      $.ajax({
                          url: "${wlpt}/wlpt/trade/carAndTradeInfo",
                          data: {
                        	  orderNos:orderno,
                        	  carNumber:carnumber,
                        	  newtime:newtime
                          },
                          dataType: 'json',
                          cache: false,
                          success: function (date) {
                        	  $("#maskloading" , parent.document).show();
                        	 var state=date.value.state;
                        	 var data=date.value.data;
                             var orderdata = data[1];
                        	 if(state==2){
                        		 
                        	  var datalist = data[0][0]; 
                        	 }
                              if(orderno!=""&&orderno!=''&&orderno!=undefined){
                            	  $("#ordernotext").html("<b>运单号：</b>"+orderno);
                              }else{
                            	  $("#ordernotext").html("");
                              }
                        	  if(state!=5){//判断是否扣费成功
                              if(carnumber==""||carnumber==''||carnumber==undefined){
                            	  $.MsgBox.Alert("系统提示", "未绑定车辆信息");
                              }else{
                            	  if(data[2] != null && data[2][0] != null){
            	                	  $("#carnumbertext").html(carnumber);
        		                  		if(data[2][0].carLocs != null){
        		                  			loadMap(data[2],1);
        			                    		$("#datetext").html((" "+data[2][0].carLocs.formatgpstime).substring(0, 11));
        			  	                  	    $("#timetext").html((data[2][0].carLocs.formatgpstime).substring(10, 19));
        			  	                  	    //$("#drivingstatetext").html(data.value[2][0].carLocs.state);
        			  	                  	    $("#speedtext").html("<b >"+data[2][0].carLocs.speed+"km/</b>小时");
        			  	                  	    map_click(data[2][0].carLocs.lng*1, data[2][0].carLocs.lat*1);
        			                        	lng = data[2][0].carLocs.lng*1;
        			    	                	lat = data[2][0].carLocs.lat*1;
        			    	                	speed = data[2][0].carLocs.speed;
        		                  		}else{
        		                  			$.MsgBox.Alert("系统提示", "该车辆无定位信息");
        		                  		}
            	                	  
            	                  }else{
            	                	  	
            	                	  	if(datalist!=null){                                 //调用永奎
            		                  		
            	                	  		  renderMap(datalist);
            	    	                	  $("#datetext").html((" "+datalist.RECEIVE_TIME).substring(0, 11));                        //lbs
            	    	                	  $("#timetext").html((datalist.RECEIVE_TIME).substring(10, 19));
            	    	                	  $("#carnumbertext").html(datalist.LICENSE_PLATE);
            	    	                	  //$("#drivingstatetext").html(datalist.DRIVING_STATE);
            	    	                	  $("#speedtext").html("<b >"+datalist.SPEED+"公里/</b>小时");
            	    	                	  map_click(datalist.REAL_X, datalist.REAL_Y);
            	    	                	  lng = datalist.REAL_X;
            	    	                	  lat = datalist.REAL_Y;
            	    	                	  speed = datalist.SPEED;
            		                  		
            		                  	}else{
            		                  			//调用北斗
        	    	                  			var LocationVcln=data[3].LocationVcln.LocationVcln;
            		                  			loadMap(data[3].LocationVcln,1);
            		                  			if( LocationVcln!=null && LocationVcln.hasOwnProperty('utc')){
            		                  				
            		                  				var timestr=parseInt(LocationVcln.utc);
            		                  				var newDate1 = new Date();
            		                  				newDate1.setTime(timestr);
                	                  				$("#carnumbertext").html(carnumber);
                	                  				$("#datetext").html(newDate1.toLocaleString());
                	                  				console.log(newDate1);
                	                  				$("#speedtext").html("<b >"+LocationVcln.spd+"km/</b>小时");
                	                  				lat=LocationVcln.lat/600000;                                          //北斗接口返回的经纬度需要除以600000 才能使用
                	                  				lng=LocationVcln.lon/600000;
                	                  				map_click(lng,lat);
                	                  				speed=LocationVcln.spd;
            		                  			}else{
            		                  				$.MsgBox.Alert("系统提示", "该车辆无定位信息");
            		                  			}
            		                  			
            		                  		}
            		                  		
            		                  	}
            	                	
                              		}
                              
                              if(orderdata!=null){
                            	  if(orderdata.quoteinfo.driver!=null){
                            		  $("#drivername").html(orderdata.quoteinfo.driver.name);
                                      $("#driverphone").html(orderdata.quoteinfo.driver.phone);
                                      $("#x_name").html(orderdata.quoteinfo.driver.loginName);
                            	  }
                           		  $("#locCount").html(orderdata.locCount);
                           		  $("#trailCount").html(orderdata.trailCount);
                            	  $("#x_tradestatus").html(orderdata.statusStr);
                            	  $("#x_carnumber").html(carnumber);
                            	  
                            	  $("#x_orderno").html(orderdata.orderNo);
                            	  $("#x_goodsname").html("货物："+orderdata.quoteinfo.goods.goodsname);
                            	  $("#x_freightvolume").html("运量："+orderdata.quoteinfo.actload+"吨");
                            	  $("#x_consignaddress").html("卸货地址："+orderdata.quoteinfo.goods.consignAddress.province+orderdata.quoteinfo.goods.consignAddress.city+orderdata.quoteinfo.goods.consignAddress.district);
                            	  btime = orderdata.createDate;
                              	  if (orderdata.orderstatus == 4 || orderdata.orderstatus == 5) {
                              	     etime = orderdata.updateDate;
                              	  }else if(orderdata.orderstatus == 3 || orderdata.orderstatus == 6 || orderdata.orderstatus == 7){
                              		 etime = new Date().toLocaleDateString(); 
                              	  }else{
                              		etime = orderdata.createDate;
                              	  }
                              }
                              $('.map_r').show();
                         	 $("#maskloading" , parent.document).hide();
                        	  }else{
                              	$("#maskloading" , parent.document).hide();
                              	$.MsgBox.Alert("系统提示", "余额不足请充值");
                              }	
                          }
                      });
                }, function () {
                }, "是", "否");
            	

            };


        $scope.getCarGpsinfo = function () {
        	btime=$("#beginCreateDate").val();
            etime=$("#endCreateDate").val();
            if(btime<etime){
            	
        	 $.MsgBox.Confirm("系统提示", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl009','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {	
        		$("#maskloading", parent.document).show();
	            var newDate1 = new Date();
	    		var timestamp2 = Date.parse(new Date(btime));
	    		var sixtime=newDate1-timestamp2
	    		var timestamp3=6*30*24*60*60*1000;
	    		if(sixtime<timestamp3){
	            $.ajax({
	                url: "${wlpt}/wlpt/trade/getCarGpsInfo",
	                data: {
	                    carnumber: dcarnumber,
	                    beginTime: btime,
	                    endTime: etime
	                },
	                dataType: 'json',
	                cache: false,
	                success: function (date) {
	                	var data=date.value.data;
	                	var state=date.value.state;
	                	  if(state!=5){               
		                    // if(state==1)                    //状态码5是余额不足  1是中兴的数据  2 是永奎数据
			                	 $("#maskloading" , parent.document).hide();
		                		 if(data!=""&&data!=null){
		                			 renderMaplist(date.value);
		                		 }else{
		                			 $.MsgBox.Alert("系统提示", "该车辆暂无轨迹信息");
		                		 }
	                	  }else{
	                    	$("#maskloading" , parent.document).hide();
	                      	$.MsgBox.Alert("系统提示", "账号余额不足请充值");
	                      }
	                }	  
	            });
	    		}else{
	          		 $("#maskloading" , parent.document).hide();
	          		$.MsgBox.Alert("系统提示","轨迹信息为半年以内数据，此轨迹信息已失效");
	          	}
        	 }, function () {
            	$("#maskloading", parent.document).hide();
      		 }, "是", "否");  
            }else{
	        	$.MsgBox.Alert("系统提示", "您选择的开始时间大于结束时间，请重新选择！");
            	
            }
        };


        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);
    }]);


    //地图
    //创建和初始化地图函数：
    function initMap() {
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    }

    //创建地图函数：
    function createMap() {
        var map = new BMap.Map("dituContent", {
            minZoom: 4,
            maxZoom: 20
        }); // 创建Map实例
        map.setCurrentCity("邯郸"); // 设置地图显示的城市 此项是必须设置的
        map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
        //map.centerAndZoom("邯郸",13);         ///当前地方与等级
        map.centerAndZoom("邯郸", 10);


        var myIcon = new BMap.Icon(
            "http://cdn-img.easyicon.net/png/11298/1129853.gif",
            new BMap.Size(25, 25));
        map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级

        window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1});
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT});
        map.addControl(ctrl_sca);
    }

    initMap();//创建和初始化地图
    getTradeTrackList();
    function getTradeTrackList() {
        $("#maskloading", parent.document).show();
        $.ajax({
            url: "${wlpt}/wlpt/trade/getTradeTrackList",
            data: {},
            dataType: 'json',
            cache: false,
            success: function (data) {
                $("#maskloading", parent.document).hide();
                var datalist = data.value;
                loadMap(datalist);
            }
        });

    };
    
    function getOrderinfobycars() {
    	
    	
    	$.MsgBox.Confirm("系统提示", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl006','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {	
        
        $("#maskloading", parent.document).show();
        $.ajax({
            url: "${wlpt}/wlpt/trade/carAndTradeInfo",
            data: {
                orderNos: ordernos,
                carNumber: carnumbers,
                newtime:newtime
            },
            dataType: 'json',
            cache: false,
            success: function (date) {
            		var lng;
                	var lat;
                	var speed;
                    $("#maskloading", parent.document).hide();
                    var state=date.value.state;
               	 	var data=date.value.data;
                    var orderdata = data[1];
               	 	if(state==2){
               	  		var datalist = data[0][0]; 
               	 	}
                    if (ordernos != "" && ordernos != '' && ordernos != undefined) {
                        $("#ordernotext").html("<b>运单号：</b>"+ordernos);
                    } else {
                        $("#ordernotext").html("无相关运单");
                    }
            	if(state!=5){
                    if (datalist != null) {
                    	  renderMap(datalist);
                    	  $("#datetext").html((" "+datalist.RECEIVE_TIME).substring(0, 11));
	                  	  $("#timetext").html((datalist.RECEIVE_TIME).substring(10, 19));
	                  	  $("#carnumbertext").html(datalist.LICENSE_PLATE);
	                  	  //$("#drivingstatetext").html(datalist.DRIVING_STATE);
	                  	  $("#speedtext").html("<b >"+datalist.SPEED+"公里/</b>小时");
	                  	  map_click(datalist.REAL_X, datalist.REAL_Y);
	                  	  lng = datalist.REAL_X;
	                	  lat = datalist.REAL_Y;
	                	  speed = datalist.SPEED;
                    }else{
                    	if(data[2] != null && data[2][0] != null){
                    		loadMap(data[2],1);
                    		$("#carnumbertext").html(carnumbers);
                    		if(data[2][0].carLocs != null){
	                    		$("#datetext").html((" "+data[2][0].carLocs.formatgpstime).substring(0, 11));
	  	                  	    $("#timetext").html((data[2][0].carLocs.formatgpstime).substring(10, 19));
	  	                  	    
	  	                  	    //$("#drivingstatetext").html(data.value[2][0].carLocs.state);
	  	                  	    $("#speedtext").html("<b >"+data[2][0].carLocs.speed+"公里/</b>小时");
	  	                  	    map_click(data[2][0].carLocs.lng*1, data[2][0].carLocs.lat*1);
	                        	lng = data[2][0].carLocs.lng*1;
	    	                	lat = data[2][0].carLocs.lat*1;
	    	                	speed = data[2][0].carLocs.speed;	
                    		}else{
                    			$.MsgBox.Alert("系统提示", "该车辆无定位信息");
                    		}
                    	}else{
                    		loadMap(data[3].LocationVcln,1);
                    		var LocationVcln=data[3].LocationVcln.LocationVcln;
	                  			if(LocationVcln.hasOwnProperty('utc')){
	                  				var timestr=parseInt(LocationVcln.utc);
	                  				var newDate1 = new Date();
	                  				newDate1.setTime(timestr);
	                  				$("#carnumbertext").html(carnumbers);
	                  				$("#datetext").html(newDate1.toLocaleString());
	                  				$("#speedtext").html("<b >"+LocationVcln.spd+"km/</b>小时");
	                  				lat=LocationVcln.lat/600000;
	                  				lng=LocationVcln.lon/600000;
	                  				speed=LocationVcln.spd;
	                  				map_click(lng,lat);
	                  			}else{
                      				$.MsgBox.Alert("系统提示", "该车辆无定位信息");
                      			}
                  			
                    	}
                    	
                    }
                    $("#maskloading" , parent.document).hide();
                    /* $('.map_r').show(); */

                    //画出路线
                    var startPoint = new BMap.Point(lng, lat);
                    if (orderdata.orderstatus == 0||orderdata.orderstatus == 1) {
                        var endAddress = orderdata.quoteinfo.goods.shipAddress.province + orderdata.quoteinfo.goods.shipAddress.city +
                            orderdata.quoteinfo.goods.shipAddress.district + orderdata.quoteinfo.goods.shipAddress.address;
                        var endAddressCity = orderdata.quoteinfo.goods.shipAddress.city;
                        getDrivingRoute(startPoint, endAddress, endAddressCity, 1,speed ,carnumber);//1为提货
                    } else if (orderdata.orderstatus == 3 || orderdata.orderstatus == 6 || orderdata.orderstatus == 7) {
                        var endAddress = orderdata.quoteinfo.goods.consignAddress.province + orderdata.quoteinfo.goods.consignAddress.city +
                            orderdata.quoteinfo.goods.consignAddress.district + orderdata.quoteinfo.goods.consignAddress.address;
                        var endAddressCity = orderdata.quoteinfo.goods.consignAddress.city;
                        getDrivingRoute(startPoint, endAddress, endAddressCity, 0,speed ,carnumbers);//0为卸货
                    }
                }else{
                	$("#maskloading" , parent.document).hide();
                	$.MsgBox.Alert("系统提示", "余额不足请充值");
                }
            
            }
        });
    }, function () {
    	 $("#maskloading", parent.document).hide();
     }, "是", "否");    

    };
    
    function loadMap(data,type) {
    	map.clearOverlays();
    	var myIcon = new BMap.Icon(
                "${ctxStatic }/images/cc.png",
                new BMap.Size(50, 55));
    	if(type==1){
    		myIcon = new BMap.Icon("${ctxStatic}/front/img/carwz.png", new BMap.Size(30, 50));
    	}

        if (data ) {
    		
        	$.each(data, function (i, item) {
        		
        		if(item.carLocs!=null){
        			
	        		var point = new BMap.Point(item.carLocs.lng*1, item.carLocs.lat*1), marker = new BMap.Marker(point,{icon:myIcon});
	        		
		            marker.addEventListener('click', showInfos);
		           
		            function showInfos() {
		                var gpstimes;
		                var addressinfo;
		                var phone;
		                if(item.carLocs.formatgpstime){
		                    gpstimes=item.carLocs.formatgpstime;
		                }else {
		                    gpstimes='无定位时间';
		                }
		                if(item.carLocs.info){
		                	addressinfo=item.carLocs.info;
		                }else {
		                	addressinfo='当前无定位';
		                }
		                if(item.carLocs.mobile){
		                	phone=item.carLocs.mobile;
		                }else{
		                	phone="无联系方式";
		                }
							//最后定位时间：' + gpstimes + '
		                var content = '<p style="width:280px;margin:0;line-height:20px;">联系方式：' + phone + ' <br/> 车辆状态：' + item.carLocs.state + ' <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes + '<br/>  </p>';
		
		                //创建检索信息窗口对象
		                var searchInfoWindows = new BMapLib.SearchInfoWindow(map, content, {
		                    title: item.carLocs.name, //标题
		                    width: 300, //宽度
		                    height: 120, //高度
		                    panel: "panel", //检索结果面板
		                    enableAutoPan: false, //自动平移
		                    enableSendToPhone: false, //是否显示发送到手机按钮
		                    searchTypes: []
		                });
		                searchInfoWindows.open(marker);
		            }
		            map.addOverlay(marker);

        		}
        		////////////////////////北斗显示
        		if(item.adr!=null){
        			
	        		var point = new BMap.Point(item.lon/600000, item.lat/600000), marker = new BMap.Marker(point,{icon:myIcon});
	        		
		            marker.addEventListener('click', showInfos);
		            function showInfos() {
		            	
		                var gpstimes;
		                var addressinfo;
		                var phone;
		                if(item.utc!=null){
		                    
		                    var timestr=item.utc;
              				gpstimes = new Date();
              				gpstimes.setTime(timestr);
		                }else {
		                    gpstimes='无定位时间';
		                }
		                if(item.adr!=null){
		                	addressinfo=item.adr;
		                	
		                }else {
		                	addressinfo='当前无定位';
		                }
							//最后定位时间：' + gpstimes + '
		                var content = '<p style="width:280px;margin:0;line-height:20px;">'  + ' <br/> 车辆状态：' + item.spd + 'km/小时 <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes.toLocaleString() + '<br/>  </p>';
						
		                //创建检索信息窗口对象
		                var searchInfoWindows = new BMapLib.SearchInfoWindow(map, content, {
		                    title: "北斗定位位置", //标题
		                    width: 300, //宽度
		                    height: 120, //高度
		                    panel: "panel", //检索结果面板
		                    enableAutoPan: false, //自动平移
		                    enableSendToPhone: false, //是否显示发送到手机按钮
		                    searchTypes: []
		                });
		                searchInfoWindows.open(marker);
		            }
		            map.addOverlay(marker);
		            

        		}
        	});
        }
    }
    

    /**
     * 渲染地图模式
     * @param result
     * @param page
     */
    function renderMap(res) {
        map.clearOverlays();

        if (res.length == 0) {
            alert("未找到查找的车辆");
            return;
        }
        var myIcon = new BMap.Icon("${ctxStatic}/front/img/carwz.png", new BMap.Size(30, 50));

        var point = new BMap.Point(res.REAL_X, res.REAL_Y), marker = new BMap.Marker(point, {icon: myIcon});
        map.centerAndZoom(point, 10); // 初始化地图,设置中心点坐标和地图级
        marker.addEventListener('click', showInfo);

        function showInfo() {
            var gpstime;
            if (res.RECEIVE_TIME) {
                gpstime = res.RECEIVE_TIME;
            } else {
                gpstime = '无定位时间';
            }
            

            var content = '<p style="width:280px;margin:0;line-height:20px;"> 车辆状态：' + res.DRIVING_STATE + ' <br/>速度：' + res.SPEED + '公里/小时 <br/>地址：' + address + ' <br/> 最后定位时间：' + gpstime + ' </p>';

            //创建检索信息窗口对象
            var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
                title: res.LICENSE_PLATE, //标题
                width: 300, //宽度
                height: 120, //高度
                panel: "panel", //检索结果面板
                enableAutoPan: false, //自动平移
                enableSendToPhone: false, //是否显示发送到手机按钮
                searchTypes: []
            });
            searchInfoWindow.open(marker);
        }

        map.addOverlay(marker);

    };

  //轨迹回放地图展示回放动画
    function renderMaplist(date){
   	 map.clearOverlays();
		
	 	var state= date.state;
	   	var data=date.data; 
	   	console.log(date);
		//////////////////////////////////////////// 状态码1 就调用 zjxl的解析轨迹方法
		if( state==1 || data.length>0){
		var datazjxl=data.TrackVcl;
		 //设置地图中心点
        var lng = datazjxl[0].lon/600000;
        var lat = datazjxl[0].lat/600000;
		console.log(lng,lat);	
        var arrPois = [];
        for (var i = 0; i < datazjxl.length; i++) {
            var x = datazjxl[i].lon/600000;
            var y = datazjxl[i].lat/600000;
            arrPois[i] = new BMap.Point(x, y);
        }

        map.addOverlay(new BMap.Polyline(arrPois, {
            strokeColor: '#111'
        }));
        var arrStartEnd = [];
        arrStartEnd[0] = arrPois[0];
        arrStartEnd[1] = arrPois[1];
        //map.setViewport(arrStartEnd);
        map.centerAndZoom(new BMap.Point(lng, lat),
                14);
        var lushu = new BMapLib.LuShu(
                map,
                arrPois,
                {
                    defaultContent: "",
                    autoView: true,
                    icon: new BMap.Icon(
                            '${ctxStatic }/images/car.png',
                            new BMap.Size(50, 55),
                            {
                                /* anchor: new BMap.Size(
                                        27, 13) */
                            }),
                    speed: 4500,
                    enableRotation: true,//是否设置marker随着道路的走向进行旋转
                    landmarkPois: []
                });
        lushu.start();
        $("btn-start").onclick = function () {
            lushu.start();
        };
        $("stop").onclick = function () {
            lushu.stop();
        };
        $("pause").onclick = function () {
            lushu.pause();
        };
        $("pause").hide();
        $("hide").onclick = function () {
            lushu.hideInfoWindow();
        };
        $("show").onclick = function () {
            lushu.showInfoWindow();
        };
        $("show").hide();
        function $(element) {
            return document.getElementById(element);
        }
       
	}
   	 ///////////////////////////////////////状态码为2就调用永奎解析轨迹方法
   	 if (state==2 || data.length>0) {
   			var maplist=data.mapListJson;
            //设置地图中心点
            var lng = maplist[0].REAL_X;
            var lat = maplist[0].REAL_Y;

            var arrPois = [];
            for (var i = 0; i < maplist.length; i++) {
                var x = maplist[i].REAL_X;
                var y = maplist[i].REAL_Y;
                arrPois[i] = new BMap.Point(x, y);
            }

            map.addOverlay(new BMap.Polyline(arrPois, {
                strokeColor: '#111'
            }));
            var arrStartEnd = [];
            arrStartEnd[0] = arrPois[0];
            arrStartEnd[1] = arrPois[1];
            //map.setViewport(arrStartEnd);
            map.centerAndZoom(new BMap.Point(lng, lat),
                    14);
            var lushu = new BMapLib.LuShu(
                    map,
                    arrPois,
                    {
                        defaultContent: "",
                        autoView: true,
                        icon: new BMap.Icon(
                                '${ctxStatic }/images/car.png',
                                new BMap.Size(50, 55),
                                {
                                    /* anchor: new BMap.Size(
                                            27, 13) */
                                }),
                        speed: 4500,
                        enableRotation: true,//是否设置marker随着道路的走向进行旋转
                        landmarkPois: []
                    });
            lushu.start();
            $("btn-start").onclick = function () {
                lushu.start();
            };
            $("stop").onclick = function () {
                lushu.stop();
            };
            $("pause").onclick = function () {
                lushu.pause();
            };
            $("pause").hide();
            $("hide").onclick = function () {
                lushu.hideInfoWindow();
            };
            $("show").onclick = function () {
                lushu.showInfoWindow();
            };
            $("show").hide();
            function $(element) {
                return document.getElementById(element);
            }
        }
   }

    function getDrivingRoute(startPoint, endAddresss, endAddresssCity, type,speed,license_plate) {
        var spHtml = "";
        var epHtml = "";
        map.clearOverlays();
        var myGeo = new BMap.Geocoder();
        myGeo.getPoint(endAddresss, function (point) {
            if (point) {
            	var myIcon1 = new BMap.Icon("${ctxStatic}/front/img/iconth.png", new BMap.Size(30, 50));
                var myIcon2 = new BMap.Icon("${ctxStatic}/front/img/iconxh.png", new BMap.Size(30, -10));

                var driving = new BMap.DrivingRoute(map, {
                    renderOptions: {map: map, autoViewport: true},
                    policy: BMAP_DRIVING_POLICY_LEAST_DISTANCE,
                    onSearchComplete: function (results) {
                        var distance = driving.getResults().getPlan(0).getRoute(0).getDistance();
                        var distanceNum = distance.substring(0, distance.length - 2);
                        var time;
                        if (speed != 0) {
                        	time = Math.round((distanceNum*1) / Number(speed*1));
                            
                        } else {
                            time = 0;
                        }
                        if (type == 1) {
                            epHtml = "<div style='width: 100%; height: 100%; display: block; background-color: #000; border-radius: 5px; padding: 5px; color: #000;'>\n" +
                                "<a><b>距离提货点：</b> <span>" + distance + "</span></a></br>\n" +
                                "<a style='color: #fce331;;'><b>预计到达时间：</b> <span>" + time + "小时</span></a>\n" +
                                "</div>";
                        } else {
                            epHtml = "<div  style='width: 100%; height: 100%; display: block; background-color: #000; border-radius: 5px; padding: 5px; color: #000;'>\n" +
                                "<a><b>距离卸货点：</b> <span>" + distance + "</span></a></br>\n" +
                                "<a style='color: #fce331;;'><b>预计到达时间：</b> <span>" + time + "小时</span></a>\n" +
                                "</div>";
                        }
                    },
                    onMarkersSet: function (routes) {
                    	
                        map.removeOverlay(routes[0].marker); //删除起点
                        map.removeOverlay(routes[1].marker);//删除终点
                        var startPointMarker = new BMap.Marker(startPoint,{icon:myIcon1});
                        var endPointMarker = new BMap.Marker(point,{icon:myIcon2});
                        map.addOverlay(startPointMarker);
                        map.addOverlay(endPointMarker);
                        var label = new BMap.Label(license_plate, {offset: new BMap.Size(20, -10)});
                        startPointMarker.setLabel(label);
                        var epInfoWindow = new BMap.InfoWindow(epHtml, {width: 0, height: 0,backgroundColor:"#000"});
                        endPointMarker.openInfoWindow(epInfoWindow);
                    }
                });
                driving.search(startPoint, point);
            } else {
                alert("您选择地址没有解析到结果!");
            }
        }, endAddresssCity);
    }
	
  //将经纬度转为地址
    function map_click(lng,lat){ 
    	address = "";
		var point = new BMap.Point(lng,lat); 
		var geoc = new BMap.Geocoder(); 
		geoc.getLocation(point,function(rs){ 
		var addComp = rs.addressComponents; 
		address = addComp.province + " " + addComp.city + " "+ addComp.district + " "+ addComp.street + " " + addComp.streetNumber; 
		$("#x_address").html("位置："+address);
		}); 
	}
    function fomatFloat(src, pos) {
		return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);

	}
    //点击运单 出现详情
    /* $('.map_l tr td:first-child').find('a').click(function(e){
    	e.preventDefault();
    	$('.map_r').toggle();
    }); */
</script>

</body>
</html>