<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>车辆管理</title>
<meta name="decorator" content="default" />


<%@include
	file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<style type="text/css">
#modal_check .modal-backdrop {
	display: none;
}

#modal_check .check_service input[type=checkbox] {
	top: -3px;
}

#modal_check .form-group .control-label {
	text-align: left;
}

#modal_check {
	padding-right: -10px !important;
}
</style>
<style type="text/css">
#modal_check .modal-backdrop {
	display: none;
}

#modal_check .check_service input[type=checkbox] {
	top: -3px;
}

#modal_check .form-group .control-label {
	text-align: left;
}

#modal_check {
	padding-right: -10px !important;
}
.check_after{
display:block;
}
</style>
<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=80f73f31cfbb40be26acda67af03da43"></script>
		<!-- 加载百度地图样式信息窗口 -->
	<script type="text/javascript"
		src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>

	<link rel="stylesheet"
		href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />
	<script type="text/javascript"
		src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
	<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnExport").click(function() {
			top.$.jBox.confirm("确认要导出车辆数据吗？", "系统提示", function(v, h, f) {
				if (v == "ok") {
					$("#searchForm").attr("action", "${ctx}/wlpt/car/export");
					$("#searchForm").submit();
				}
			}, {
				buttonsFocus : 1
			});
			top.$('.jbox-body .jbox-icon').css('top', '55px');
		});
		$("#btnSubmit").click(function() {
			$("#searchForm").attr("action", "${ctx}/wlpt/car/list");
			$("#searchForm").submit();
		});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/wlpt/car/list");
		$("#searchForm").submit();
		return false;
	}
	function checkinfo(phone,loginname,carNumber,carid) {
		$("#btnCheck").show();
		var jsonstr = {
				"name"  : loginname,             //
				"phone" : phone,
				"vclN"  : carNumber,
				 "vco"  : "2",
				 //"area" :"110108",         //
				                            //
				"regist": "zjxl001,zjxl004,zjxl005,zjxl003,zjxl002" ,
				"carid" :carid,
				"authentication":"0"
		};
		$.ajax({
    		url :"${wlpt}/wlpt/totalvalida/showMsg",
    		data : jsonstr,
    		dataType : 'json',
    		contentType:'charset=UTF-8',
			success : function(result) {
			console.log(result);
		    //车辆入网验证
			if(result.TruckExist.checktruckstatus == "0"){
				$('#truckstatus').html("该信息未校验");		
			}else{
			$('#truckstatus').html(result.TruckExist.checktruckstatus);		
			}
			//车辆行驶证
			$('#vclWnrNm').html(result.vQueryLicense.vclWnrNm);
			$('#vclWnrPhn').html(result.vQueryLicense.vclWnrPhn);
			$('#areaName').html(result.vQueryLicense.areaName);
			$('#vclTpNm').html(result.vQueryLicense.vclTpNm);
			$('#vbrndCdNm').html(result.vQueryLicense.vbrndCdNm);
			$('#prdCdNm').html(result.vQueryLicense.prdCdNm);
			$('#cmpNm').html(result.vQueryLicense.cmpNm);
			$('#vin').html(result.vQueryLicense.vin);
			$('#serviceName').html(result.vQueryLicense.serviceName);
			$('#vclTn').html(result.vQueryLicense.vclTn);
			$('#ldTn').html(result.vQueryLicense.ldTn);
			$('#vclDrwTn').html(result.vQueryLicense.vclDrwTn);
			$('#vclLng').html(result.vQueryLicense.vclLng);
			$('#vclWdt').html(result.vQueryLicense.vclWdt);
			$('#vclHgt').html(result.vQueryLicense.vclHgt);
			 //道路许可证信息
		    $('#portcard').html("未查询到信息");
		    $('#dityterm').html("未查询到信息");
	    if(undefined!=result.RTCNo.transportcard){
	    	if(result.RTCNo.transportcard == "0"){
	    		$('#portcard').html("该信息未校验");
	    	}else{
			$('#portcard').html(result.RTCNo.transportcard);
	    	}
	    }
	    if(undefined!=result.RTCNo.validityterm){
	    	if(result.RTCNo.validityterm == "0"){
	    		$('#dityterm').html("该信息未校验");
	    	}else{
			$('#dityterm').html(result.RTCNo.validityterm);
	    	}
	    }
	  	//判断车主真实性验证状态：0未校验，1真实，2姓名不匹配，3手机号码不匹配，-1未查询到
		var sa=result.OwnerByVclNo.checkownerstatus;
	  	if(sa=="0"){
	  		$('#ownerstatus').html("该信息未校验");
	  	}
		if(sa=="1"){
			$('#ownerstatus').html("真实");
		};
		if(sa=="2"){
			$('#ownerstatus').html("姓名不匹配");
		};
		if(sa=="3"){
			$('#ownerstatus').html("手机号码不匹配");
		};
		if(sa=="-1"){
			$('#ownerstatus').html("未查询到");
		};
	},
    		error : function(message){
			alert("失败");
	}
		

});
	}

</script>

<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<style>
th, td {
	text-align: center !important;
}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/car/list">车辆列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="car"
		action="${ctx}/wlpt/car/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>用户名：</label> <form:input path="user.loginName"
					htmlEscape="false" maxlength="11" class="input-medium" /></li>
			<li><label>车牌号：</label> <form:input path="carnumber" id="carnumber"
					htmlEscape="false" maxlength="20" class="input-medium" /></li>
			<li><label>车型：</label> <form:input path="cartype"
					htmlEscape="false" maxlength="10" class="input-medium" /></li>
			<li><label>车长：</label> <form:input path="carlength"
					htmlEscape="false" class="input-medium" /></li>
			<li><label>认证状态：</label> <form:select path="status"
					class="input-xlarge ">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('authenStatus')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li class="btns" style="float: right;">
			<input id="findzjxl"
				class="btn btn-primary" type="button" value="定位查询" onclick="findlocation();"/>
			<input id="btnSubmit"
				class="btn btn-primary" type="button" value="查询" /> <a
				class="btn btn-primary" href="${ctx}/wlpt/car/list">重置</a> <input
				id="btnExport" class="btn btn-primary" type="button" value="导出" />
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<div id="baidumap" style="width: 730px; height:70px" class="control-group">
	<input type="button" value="隐藏" style="float:right;" class="btn btn-primary" onclick="hidemap();">
		<div id="dituContent"
			style="position: absolute; margin-top: 30px; width: 730px; height: 590px; top: 50; border: 1px solid gray; overflow: hidden;">
			</div>
	</div>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width: 10%">用户登录名</th>
				<th style="width: 10%">车辆信息</th>
				<th style="width: 6%">订单数</th>
				<th style="width: 10%">主营路线</th>
				<th style="width: 6%">认证状态</th>
				<th style="width: 6%">定位手机</th>
				<th style="width: 10%">更新时间</th>
				<shiro:hasPermission name="wlpt:car:edit">
					<th style="width: 6%">操作</th>
				</shiro:hasPermission>
				<th style="width: 7%">北斗接口</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="car">
				<tr>
					<td>${car.user.loginName}</td>
					<td>${car.carnumber}|${fns:getDictLabel(car.issocialcar, 'issocialcar', '')}<br>
						${car.cartype}&nbsp;${car.carlength}${car.lengthunit}&nbsp;${car.loadweight}${car.weightunit}
					</td>
					<td>${car.tradecount}</td>
					<td>${car.mainroad}</td>
					<td>${fns:getDictLabel(car.status, 'authenStatus', '')}</td>
					<td>${car.locationmobile}</td>
					<td><fmt:formatDate value="${car.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<shiro:hasPermission name="wlpt:car:edit">
						<td><a href="${ctx}/wlpt/car/form?id=${car.id}">修改</a></td>
					</shiro:hasPermission>
					<td>
						<input class="btn btn-primary" type="button" id="msg_regist" data-toggle="modal" data-target="#modal_check" onclick="checkinfo('${car.locationmobile}','${car.user.loginName}','${car.carnumber}','${car.id}');" value="北斗信息校验"/>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
	<div class="pagination">${page}</div>

                            		<!--点提交后显示的信息-->
	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal_check" class="modal" style="margin:auto;overflow-y:hidden;">
            		<div>
            			<div class="modal-content">
            				<div class="modal-header">
                                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                                <h4 class="modal-title">北斗信息展示</h4>
                            </div>
                            <div class="modal-body form-horizontal">
                            	<!--校验服务-->
                            	<div class="col-sm-12 check_box">
                            		<!--点提交后显示的信息-->
                            		<div class="check_service check_after col-sm-12">
                            			<div class="col-sm-12">
                            				<h5 class="service_title text-center pull-left ">展示结果</h5>
                            			</div>
                            			
                            			<div class="col-sm-12 clearfix driver_msg">
			                            	<div class="col-sm-4 form-group clearfix pull-left" id="div1">
			                            		<div class="pull-left control-label" >入网验证：</div>
			                            		<div class="pull-left control-label" id="truckstatus">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="col-sm-4 form-group clearfix pull-left" id="div2">
			                            		<div class="pull-left control-label" >车主真实性：</div>
			                            		<div class="pull-left control-label" id="ownerstatus">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="col-sm-4 form-group pull-right" id="div3">
			                            		<div class="pull-left control-label" >是否套牌：</div>
			                            		<div class="pull-left control-label" id="areastatus">
			                            			
			                            		</div>
			                            	</div>
                            			</div>
	                            		<div class="col-sm-12 clearfix driver_msg " id="div4">
			                            	<div class="form-group clearfix pull-left driver_msg_road">
			                            		<div class="pull-left control-label">道路许可证：</div>
			                            		<div class="pull-left control-label" id="portcard">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="form-group clearfix pull-left">
			                            		<div class="pull-left control-label">有效期：</div>
			                            		<div class="pull-left control-label" id="dityterm">
			                            			
			                            		</div>
			                            	</div>
	                            		</div>
	                            		<div class="col-sm-12 license_msg" id="div5">
	                            			<div class="col-sm-12 license_title" style="margin-left:30px;">行驶证信息：</div>
	                            			<div class="col-sm-12">
		                            			<table class="table table-bordered table-striped">
		                            				<tr class="table_title"><th>名称</th><th>数据</th></tr>
		                            				<tr><td>联系人</td><td id="vclWnrNm"></td></tr>
		                            				<tr><td>联系人手机</td><td id="vclWnrPhn"></td></tr>
		                            				<tr><td>车籍地</td><td id="areaName"></td></tr>
		                            				<tr><td>车辆类型</td><td id="vclTpNm"></td></tr>
		                            				<tr><td>车辆品牌</td><td id="vbrndCdNm"></td></tr>
		                            				<tr><td>车辆型号</td><td id="prdCdNm"></td></tr>
		                            				<tr><td>车主/业主</td><td id="cmpNm"></td></tr>
		                            				<tr><td>车辆识别代码/车架号</td><td id="vin"></td></tr>
		                            				<tr><td>服务商名</td><td id="serviceName"></td></tr>
		                            				<tr><td>总质量</td><td id="vclTn"></td></tr>
		                            				<tr><td>核定载重量(Kg)</td><td id="ldTn"></td></tr>
		                            				<tr><td>准牵引总重量(Kg)</td><td id="vclDrwTn"></td></tr>
		                            				<tr><td>外廓尺寸长(mm)</td><td id="vclLng"></td></tr>
		                            				<tr><td>外廓尺寸宽(mm)</td><td id="vclWdt"></td></tr>
		                            				<tr><td>外廓尺寸高(mm)</td><td id="vclHgt"></td></tr>
		                            			</table>
	                            			</div>
	                            		</div>
                            		</div>
                            	</div>
                            </div>
            			</div>
            		</div>
            	</div>


				</div>
			<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
				<script>
var btime = "";
var etime = "";
var dcarnumber="";
var address="";
var Whetheopen="";
var newtime="";

$("#maskloading" , parent.document).hide();
	var w = document.documentElement.clientWidth;
    if(w<1200){
    	$('.row').css('width','1010px').css('background-color','#fff').css('overflow-x','hidden').css('overflow-y','hidden');
    	$('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }
    //获取父元素中的某个元素
    var mask=$(".mask" , parent.document);
    $('#btn').click(function(){
    	$("#mask" , parent.document).css('display','block');
    });
    /*map的高度*/
    var bheight = document.documentElement.clientHeight;
    $('.map').height('100%');
    $('#dituContent').height('100%')
    //地图下面的内容
    $('.map_r').width($('.map').width()-300+'px');
	//显示隐藏底下内容
	$('.map_r .close').click(function(){
    	$('.map_r').hide(500);
    	$('.toggle_msg').show(500);
    });
    $('.toggle_msg').click(function(){
    	$('.map_r').show(500);
    	$('.toggle_msg').hide(500);
    });

    
    
    
   //地图
   //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
    } 
    //创建地图函数：
    function createMap(){
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
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }
    
    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
		var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
		map.addControl(ctrl_nav);
	        //向地图中添加缩略图控件
		var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:1});
		map.addControl(ctrl_ove);
	        //向地图中添加比例尺控件
		var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
		map.addControl(ctrl_sca);
    }
    initMap();//创建和初始化地图
    
    
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
        		console.log(item);
        		if(item.carLocs!=null){
        			console.log(2);
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
        			console.log(data);
        			
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
    
    
    function renderMaplist(date){
    	 map.clearOverlays();
		
    	var state= date.state;
    	var data=date.data;
    	console.log(state);
		//////////////////////////////////////////// 状态码1 就调用 zjxl的解析轨迹方法
 		if( state==1 && data.length>0){
 		var datazjxl=data;
 		 //设置地图中心点
         var lng = datazjxl[0].lon/600000;
         var lat = datazjxl[0].lat/600000;
			
         var arrPois = [];
         for (var i = 0; i < datazjxl.length; i++) {
             var x = datazjxl[i].lon/600000;
             var y = datazjxl[i].lat/600000;
             arrPois[i] = new BMap.Point(x, y);
             console.log(arrPois);
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
    	 ///////////////////////////////////////状态码为2就调用LBS解析轨迹方法
    	 if (state==2 && data.length>0) {
    		
             //设置地图中心点
             var lng = data[0].REAL_X;
             var lat = data[0].REAL_Y;

             var arrPois = [];
             for (var i = 0; i < data.length; i++) {
                 var x = data[i].REAL_X;
                 var y = data[i].REAL_Y;
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
        console.log("222");
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
	
    
    function findlocation() {
    		$('#baidumap').show();
        	$('.map_r').hide();
          	$("#maskloading" , parent.document).show();
          	var carnumber = $('#carnumber').val();
			var newtime = new Date().getHours();
			if(carnumber!=""&&carnumber!=null&&carnumber!=undefined){
				 $.ajax({
	                  url: "${wlpt}/wlpt/zjxl/interfaces",
	                  type:"post",
	                  data: {
	                	  vclN : carnumber,
	                	  timeNearby : newtime,
	                	  authentication : 0
	                  },
	                  dataType: 'json',
	                  success: function (data) {
                	  $("#maskloading" , parent.document).show();
					  console.log(data);
    	                	  	
              	  		if(data.data.hasOwnProperty('mapListJson')){                                 //调用永奎
                  			var datalist = data.data.mapListJson[0];
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
	    	                  			var LocationVcln=data.data.LocationVcln;
    		                  			loadMap(data.data,1);
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
              });
    	

    }
    };
    
    
    
    
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
    
    //点击运单 出现详情
    /*  $('.map_l tr td:first-child').find('a').click(function(e){
    	e.preventDefault();
    	$('.map_r').toggle(); 
    });*/
</script>
<script type="text/javascript">
	$(document).ready(
		function() {
			$('#baidumap').hide();
		});
	function hidemap(){
			$('#baidumap').hide();
		
	}
</script>
</body>

</html>