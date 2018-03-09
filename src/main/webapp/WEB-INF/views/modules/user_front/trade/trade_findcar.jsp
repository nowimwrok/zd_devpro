<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	    <title>信息服务</title>
	    <link href="${ctxStatic}/front/css/bootstrap.min.css" rel="stylesheet">
	    <link href="${ctxStatic}/front/css/bootstrap-table.min.css" rel="stylesheet">
	    <link href="${ctxStatic}/front/css/bootstrap-table-fixed-columns.css" rel="stylesheet">
	    <link href="${ctxStatic}/front/css/per_global.css" rel="stylesheet">
	    <link href="${ctxStatic}/front/css/personal.css" rel="stylesheet">
	    <link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
	    <script
        src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
        <script
        src="${ctxStatic}/common/global.js"></script>
		<style>
			.back_look{margin-top:20px;cursor:default;border-radius:0;-webkit-border-radius:0;letter-spacing:1px;height:34px;}
		</style>
	</head>
	<body>
		<div class="col-sm-12 msgService">
			<h4>信息查询服务<!--<span class="red">请先填入车牌号进行查询</span>--></h4>
			<!--查询按钮 条件-->
			<form action="">
				<div class="location clearfix">
					<input type="text" class="form-control pull-left carNumber" placeholder="请输入车牌号" id="carnumber"/>
					<button class="btn btn-primary pull-left carLocation"  >定位</button>
					<div class="otherBtn pull-left timeSelect">
						<button class="btn carTrail">车辆轨迹查询</button>
					</div>
					<div class="otherBtn pull-left" style="margin:0;">
						<a href="javascript:;" class="btn msgJudge" data-toggle="modal" data-target="">信息校验</a>
					</div>
					<div class="textEx pull-left">
						<i class="red">*</i>信息校验服务包括<span>车辆真实性查询</span>、<span>车辆入网验证</span>、<span>车主真实性验证</span>等。
					</div>
				</div>
			</form>
			<!--轨迹查询-->
			<div class="sideLive sideLiveT clearfix">
				<span class="close">x</span>
				<div class="timeGt text-center">
					<input type="text" readonly="readonly" class="text-center form-control" placeholder="请选择开始时间" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="beginCreateDate"/>
					<span>~</span>
					<input type="text" readonly="readonly" class="text-center form-control" placeholder="请选择结束时间" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" id="endCreateDate"/>
				</div>
				<div class="clearfix">
					<div class="sideOne pull-left findRail">
						<p class="text-center"><i class="glyphicon glyphicon-screenshot" ></i></p>
						<div class="text-center">查询轨迹</div>
					</div>
					<div class="sideOne pull-left" id="btn-start">
						<p class="text-center"><i class="glyphicon glyphicon-play-circle"></i></p>
						<div class="text-center">播放</div>
					</div>
					<div class="sideOne pull-left" id="stop">
						<p class="text-center"><i class="glyphicon glyphicon-record"></i></p>
						<div class="text-center">暂停</div>
					</div>
				</div>
			</div>
			<!--百度地图-->
			<div id="dituContent" style="z-index:0;background-color:red;width:100%;border:1px solid #a6b4be"></div>
		</div>
		<!--信息校验-->
		<div aria-hidden="false"  aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal_check" class="modal" style="margin:auto;overflow-y:hidden;">
            <div class="modal-content checkBox">
            	<div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">信息校验</h4>
                </div>
                <div class="modal-body form-horizontal">
                    <!--司机信息-->
                    <div class="col-sm-12 clearfix driver_msg">
                        <div class="col-sm-4 form-group clearfix pull-left">
                         <div class="pull-left control-label">车牌：</div>
                            <div class="pull-left control-label carNum_text">
                            	
                            </div>
                        </div>
                         <div class="col-sm-4 form-group clearfix pull-left" id="phonediv">
                            <div class="pull-left control-label">手机号：</div>
							<div class="pull-left control-label">
                            	<input type="text" class="phoneNum" id="phone"/>
                            </div>
                        </div> 
                        <div class="col-sm-4 form-group pull-right" id="driverdiv">
                            <div class="pull-left control-label">司机：</div>
                            <div class="pull-left control-label" id="msgDriver">
                            	<input type="text" autofocus="autofocus" id="driver" class="msgDriver"/>
                            </div>
                        </div>
                    </div>
                    <!--校验服务-->
                    <div class="col-sm-12 check_box">
                        <div class="check_service col-sm-12 check_before">
                            <h5 class="service_title text-center">校验服务</h5>
                            <div class=" col-sm-12 clearfix">
                            	<div class="col-sm-12 clearfix" id="maxcheckbox">
	                            	<div class="col-sm-4 pull-left form-group">
	                            		<label for="car_net">
	                                        <input name="car_net" class="pricebox" id="car_net" type="checkbox" value="1">车辆入网验证<span class="red">${fns:getMsgLabel("zjxl001","zjxl_port","")}元</span>
	                                    </label>
	                            	</div>
	                            	<div class="col-sm-4 pull-left form-group">
	                            		<label for="user_check">
	                                        <input name="user_check" class="pricebox" id="user_check" type="checkbox" value="1">车主真实性验证<span class="red">${fns:getMsgLabel("zjxl004","zjxl_port","")}元</span>
	                                    </label>
	                            	</div>
	                            	<div class="col-sm-4 pull-right form-group">
	                            		<label for="deck_check">
	                                        <input name="deck_check" class="pricebox" id="deck_check" type="checkbox" value="1.25">套牌验证<span class="red">${fns:getMsgLabel("zjxl005","zjxl_port","")}元</span>
	                                    </label>
	                            	</div>
	                            	<div class="col-sm-4 pull-left form-group">
	                            		<label for="road_check">
	                                        <input name="road_check" class="pricebox" id="road_check" type="checkbox" value="1">道路许可证验证<span class="red">${fns:getMsgLabel("zjxl003","zjxl_port","")}元</span>
	                                    </label>
	                            	</div>
	                            	<div class="col-sm-4 pull-left form-group">
	                            		<label for="license_check">
	                                        <input name="license_check" class="pricebox" id="license_check" type="checkbox" value="1">车辆行驶证信息查询<span class="red">${fns:getMsgLabel("zjxl002","zjxl_port","")}元</span>
	                                    </label>
	                            	</div>
                            		<!--服务费用-->
	                            	<div class="col-sm-12 fee_box" style="margin-left: 25px;">
	                            		服务费：￥<span class="fee" id="price" style="font-weight: bold; font-size: 30px">0.00</span><span
												class="fee" style="font-weight: bold font-size: 30px"></span>元
	                            	</div>
	                            	<!--平台收费协议-->
	                            	<div class="col-sm-12 agree_box text-center">
	                            		<label>
	                                        <input name="agree" id="agree" type="checkbox"/><a onclick="openagreement('	LocationService');">《平台增值服务收费协议》</a>
	                                    </label>
	                            	</div>
	                            	<div class="col-sm-12 submit_box text-center">
	                            		<button class="btn" id="refer">提交</button>
	                            	</div>
                            	</div>
                            </div>
                        </div>
                        <!--点提交后显示的信息-->
                        <div class="check_service check_after col-sm-12">
                            <div class="col-sm-12">
                            	<h5 class="service_title text-center pull-left">校验结果</h5>
                            	<button class="btn btn-warning pull-right back_look">返回查询</button>
                            </div>	
                            <div class="col-sm-12 clearfix driver_msg">
			                    <div class="col-sm-4 form-group clearfix pull-left" id="div1">
			                        <div class="pull-left control-label">入网验证：</div>
			                        <div class="pull-left control-label" id="truckstatus">
			                        </div>
			                    </div>
			                    <div class="col-sm-4 form-group clearfix pull-left" id="div2">
			                        <div class="pull-left control-label">车主真实性：</div>
			                        <div class="pull-left control-label" id="ownerstatus">
			                        </div>
			                    </div>
			                    <div class="col-sm-4 form-group pull-right" id="div3">
			                        <div class="pull-left control-label">是否套牌：</div>
			                        <div class="pull-left control-label" id="areastatus">
			                        </div>
			                    </div>
                            </div>
	                        <div class="col-sm-12 clearfix driver_msg " id="div4">
			                    <div class="form-group clearfix pull-left driver_msg_road">
			                        <div class="pull-left control-label">道路运输经营许可证：</div>
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
	                            <div class="col-sm-12 license_title">行驶证信息：
	                            <span style="color: #F00" id="title"></span></div>
	                            <div class="col-sm-12">
		                            <table class="table table-bordered table-striped" id="tableid">
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
		<script src="${ctxStatic}/front/js/jquery.min.js"></script>
		<script src="${ctxStatic}/front/js/bootstrap.min.js"></script>
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
		<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
		<script>
			var brower_h=$(window).height();
			var brower_w=$(window).width();
			$('.msgService').height(brower_h+'px');
			//地图的高度
			if(brower_w>=1315){
				$('#dituContent').height(brower_h-133+'px');
			}
			else if(915<brower_w&&brower_w<1315){$('#dituContent').height(brower_h-166+'px')}
			else{
				$('#dituContent').height(brower_h-133+'px');
			}
			if(brower_w<900){
				$('#modal_check').css('width','96%');
			}
		   //创建和初始化地图函数：
		    function initMap(){
		        createMap();//创建地图
		        setMapEvent();//设置地图事件
		        addMapControl();//向地图添加控件
		    } 
		    //创建地图函数：
		    function createMap(){
		        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
		        var point = new BMap.Point(116.791187,39.770453);//定义一个中心点坐标
		        map.centerAndZoom(point,9);//设定地图的中心点和坐标并将地图显示在地图容器中
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
		    //信息验证弹框
		    $('#modal_check td').css('width','50%');
		    //点击提交后 上滑
		    var after_h=$('.check_after').height();
		    $('.back_look').click(function(){
		    	$('.check_before').animate({top:'0px'},1000);
		    	//$('.check_after').animate({top:after_h+'px'},1000);
		    	$('.check_after').animate({top:'0px'},1000);
		    	$('.check_after').hide();
		    });
		    //服务费金额数字化
		    /* $('#modal_check .fee_bold').each(function(){
				var s=$(this).text();
				n=2;  
				s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
				var l=s.split(".")[0].split("").reverse(),   
				r=s.split(".")[1];   
				t="";   
				for(i=0;i<l.length;i ++ )   
				{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
			    var num=t.split("").reverse().join("") + "." + r;//整个数字
			    var new_num=t.split("").reverse().join("");
			    var num_s=num.slice(-3);
			    $(this).text(new_num);
			    $(this).next().text(num_s);
			}); */
			$('.sideLiveT .close').click(function(){
				$('.sideLiveT').hide(500);
			});
			$('.carTrail').click(function(e){
				e.preventDefault();
				$('.sideLiveT').show(500);
			});
			//点击信息验证
			$('.msgJudge').click(function(){
				var express =/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
				var numText=$('.carNumber').val();
				//if(numText==''){$.MsgBox.Alert('系统信息','请输入车牌号！');$(this).attr('data-target','');}
				//if(numText!=''&&!express.test(numText)){$.MsgBox.Alert('系统信息','请输入正确的车牌号！');$(this).attr('data-target','');}
				
				//if(numText!=''&&express.test(numText)){
					if($("#user_check").is(":checked")){
					//$("#phonediv").show();
					$("#driverdiv").show();
					}else{
			        $('#driverdiv').hide();
					} 
					$(this).attr('data-target','#modal_check');
					$('.carNum_text').html(numText);
				//}
			});
			//点击定位按钮
			$('.carLocation').click(function(e){
				e.preventDefault();
				var express =/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
				var numText=$('.carNumber').val();
				if(numText==''){$.MsgBox.Alert('系统信息','请输入车牌号！');}
				if(numText!=''&&!express.test(numText)){$.MsgBox.Alert('系统信息','请输入正确的车牌号！');}
				if(numText!=''&&express.test(numText)){
					//非空车牌号正确执行代码
					findgpscar();
				}
			});
			//点击轨迹按钮
			$('.findRail').click(function(e){
				e.preventDefault();
				var express =/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
				var numText=$('.carNumber').val();
				if(numText==''){$.MsgBox.Alert('系统信息','请输入车牌号！');}
				if(numText!=''&&!express.test(numText)){$.MsgBox.Alert('系统信息','请输入正确的车牌号！');}
				if(numText!=''&&express.test(numText)){
					//非空车牌号正确执行代码
					getCarGpsinfo();
				}
			});
			
			function priceCheck(){

				var priceAll=$('.pricebox');
				var num=0;
				for(var i=0;i<=priceAll.length-1;i++){
					var priceOne=priceAll[i];
					var price=priceAll[i].value;
					if(priceOne.checked){
						num++;
						price++;
					}	
				}	
				var phoneExg=/^[1][3,4,5,7,8][0-9]{9}$/;
				//电话号码的验证
				if(phoneText==''&&num!=0&&$('#agree').is(':checked')&&driverName!=''&&driverName=='ww'){$.MsgBox.Alert('系统信息','请输入电话号码');}
				if(phoneText!=''&&!phoneExg.test(phoneText)&&num!=0&&$('#agree').is(':checked')&&driverName!=''&&driverName=='ww'){$.MsgBox.Alert('系统信息','请输入正确的手机号！');}
				//司机名字的验证
				//if(driverName==''&&num!=0&&$('#agree').is(':checked')){$.MsgBox.Alert('系统信息','请输入司机名称！');}
				//if(driverName!='ww'&&driverName!=''&&num!=0&&$('#agree').is(':checked')){$.MsgBox.Alert('系统信息','请输入正确的司机名字！');}
				//是否选中服务项目与同意
				//if(num==0 && $('#agree').is(':checked')){$.MsgBox.Alert('系统信息','请选中服务的项目');}
				var express =/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/;
				var numText=$('.carNumber').val();
				if(numText==''){$.MsgBox.Alert('系统信息','请输入车牌号！');}
				if(numText!=''&&!express.test(numText)){$.MsgBox.Alert('系统信息','请输入正确的车牌号！');}
				if(num==0 && !$('#agree').is(':checked')){$.MsgBox.Alert('系统信息','请选中服务的项目');}
				if(num!=0&&!$('#agree').is(':checked')){$.MsgBox.Alert('系统信息','只有同意平台增值服务收费协议才可以进行查询！');}
				//if(!phoneExg.test(phoneText)){$.MsgBox.Alert('系统信息','请输入正确的手机号')}

				var phoneText=$('.phoneNum').val();
				var driverName=$('.msgDriver').val();
				if(num!=0&&$('#agree').is(':checked')&&!$("#user_check").is(":checked")){
					subinfo();
				}
				if(num!=0&&$('#agree').is(':checked')&&$("#user_check").is(":checked")&&phoneText!=''&&phoneExg.test(phoneText) && driverName!=''){
					subinfo();
				}else{
					$.MsgBox.Alert('系统信息','请选择查询内容');
				}
			}
			function checkAni(){
				$('.check_before').animate({top:'-284px'},1000);
				$('.check_after').animate({top:'-284px'},1000);
				$('.check_after').show();
			}
			$('#refer').click(function(){
				priceCheck();
			});
/* 			var numMoney=0;
			$('.pricebox').bind('change', function() {  
			    if($(this).is(':checked')){
			    	var numSelf=$(this).val();
			    	numMoney=numMoney+parseFloat(numSelf);
			    	numM(numMoney);
			    }
			    if(!$(this).is(':checked')){
			    	var numSelf=$(this).val();
			    	numMoney=numMoney-parseFloat(numSelf);
			    	numM(numMoney);
			    }
			}); */
			//动态改变金额的大小
			/* function numM(s){
				n=2;  
				s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
				var l=s.split(".")[0].split("").reverse(),   
				r=s.split(".")[1];   
				t="";   
				for(i=0;i<l.length;i ++ )   
				{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
				var num=t.split("").reverse().join("") + "." + r;//整个数字
				var new_num=t.split("").reverse().join("");
				var num_s=num.slice(-3);
				$('.fee_bold').text(new_num);
				$('.fee_bold').next().text(num_s);
			} */
		</script>
		<script type="text/javascript">
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
	        map.setCenter(point);
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
	    
	    
		   function loadMap(data,type,carnumber) {
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
		        			console.log(2);
			        		var point = new BMap.Point(item.carLocs.lng*1, item.carLocs.lat*1), marker = new BMap.Marker(point,{icon:myIcon});
			        		map.setCenter(point);
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
				                var content = '<p style="width:280px;margin:0;line-height:20px;">车牌号码:'+carnumber+'<br/> 联系方式：' + phone + ' <br/> 车辆状态：' + item.carLocs.state + ' <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes + '<br/>  </p>';
				
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
			        		map.setCenter(point);
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
				                var content = '<p style="width:280px;margin:0;line-height:20px;">车牌号码：'+carnumber+ ' <br/> 车辆状态：' + item.spd + 'km/小时 <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes.toLocaleString() + '<br/>  </p>';
								
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
		    
		    
		    function renderMaplist(date,carnumber){
		    	 map.clearOverlays();
				
		    	var state= date.state;
		    	var data=date.data;
		    	console.log(data);
		    	console.log(state);
				//////////////////////////////////////////// 状态码1 就调用 zjxl的解析轨迹方法
		 		if( state==1 && data.TrackVcl.length>0){
		 		var datazjxl=data.TrackVcl;
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
		                     defaultContent:carnumber,
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
		       
		         $("btn-start").onclick = function () {
	
		             lushu.start();
		         };
		         $("stop").onclick = function () {
		             lushu.stop();
		         };
/* 		         $("pause").onclick = function () {
		             lushu.pause();
		         };
		         $("pause").hide();
		         $("hide").onclick = function () {
		             lushu.hideInfoWindow();
		         };
		         $("show").onclick = function () {
		             lushu.showInfoWindow();
		         };
		         $("show").hide(); */
		         function $(element) {
		             return document.getElementById(element);
		         }
		     
		 	}
		    	 ///////////////////////////////////////状态码为2就调用LBS解析轨迹方法
		    	 if (state==2 && data.mapListJson.length>0) {
		    		databd = data.mapListJson;
		             //设置地图中心点
		             var lng = databd[0].REAL_X;
		             var lat = databd[0].REAL_Y;

		             var arrPois = [];
		    		console.log(arrPois);
		             for (var i = 0; i < databd.length; i++) {
		                 var x = databd[i].REAL_X;
		                 var y = databd[i].REAL_Y;
		                 arrPois[i] = new BMap.Point(x, y);
		             }
		    		console.log(arrPois);

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
		                         defaultContent:carnumber,
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
		             
		             $("btn-start").onclick = function () {
		           
		                 lushu.start();
		             };
		             $("stop").onclick = function () {
		                 lushu.stop();
		             };
/* 		             $("pause").onclick = function () {
		                 lushu.pause();
		             };
		             $("pause").hide();
		             $("hide").onclick = function () {
		                 lushu.hideInfoWindow();
		             };
		             $("show").onclick = function () {
		                 lushu.showInfoWindow();
		             };
		             $("show").hide(); */
		             function $(element) {
		                 return document.getElementById(element);
		             }
		         }
		    }


		    $(document).ready(function(){
		        $('#carnumber').val($('#ordno', parent.document).val());
		        $('#driverdiv').hide();
		        $('#phonediv').hide();

		    });
		    
			//车辆定位
		    function findgpscar() {
		    		$('#baidumap').show();
		        	$('.map_r').hide();
		          	var carnumber = $('#carnumber').val();
					var newtime = new Date().getHours();
					if(carnumber!=""&&carnumber!=null&&carnumber!=undefined){
						$.MsgBox.Confirm("提示信息", "平台运输轨迹定位包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl006','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {          
						 $.ajax({
			                  url: "${wlpt}/wlpt/zjxl/interfaces",
			                  type:"post",
			                  data: {
			                	  vclN : carnumber,
			                	  timeNearby : newtime,
			                	  authentication : 1
			                  },
			                  dataType: 'json',
			                  success: function (data) {
							  console.log(data);
		    	                	  	
		    	                	  	if(data.data.hasOwnProperty('mapListJson')){                                 //调用永奎
		    		                  		var datalist = data.data.mapListJson[0];
		    	                	  		  renderMap(datalist);
		    	    	                	  $("#datetext").html((" "+datalist.RECEIVE_TIME).substring(0, 11));                        //lbs
		    	    	                	  //$("#timetext").html((datalist.RECEIVE_TIME).substring(10, 19));
		    	    	                	  $("#carnumbertext").html(datalist.LICENSE_PLATE);
		    	    	                	  //$("#drivingstatetext").html(datalist.DRIVING_STATE);
		    	    	                	  $("#speedtext").html("<b >"+datalist.SPEED+"公里/</b>小时");
		    	    	                	  map_click(datalist.REAL_X, datalist.REAL_Y);
		    	    	                	  lng = datalist.REAL_X;
		    	    	                	  lat = datalist.REAL_Y;
		    	    	                	  speed = datalist.SPEED;
		    		                  		
		    		                  	}else if(data.data.hasOwnProperty('LocationVcln')){
		    		                  			//调用北斗
			    	                  			var LocationVcln=data.data.LocationVcln;
		    		                  			loadMap(data.data,1,carnumber);
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
		    		                  		}else{
		    		                  				$.MsgBox.Alert("系统提示", "该车辆无定位信息");
		    		                  		}
		    		                  		
		    	                	
		                      
		                  }
		              });
						}, function () {
				        }, "是", "否");

		    }else{
		    	$.MsgBox.Alert("系统提示", "请输入正确车辆信息");
		    }
		    };
		    //轨迹回放
		    function getCarGpsinfo() {                            
	          	var btime=$("#beginCreateDate").val();
	          	var etime=$("#endCreateDate").val();


	          	if(btime<etime){
		    		$.MsgBox.Confirm("提示信息", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl009','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {
		          	$("#maskloading" , parent.document).show();
		    		var newDate1 = new Date();
		    		var timestamp2 = Date.parse(new Date(btime));
		    		var sixtime=newDate1-timestamp2
		    		var timestamp3=6*30*24*60*60*1000;
		    		if(sixtime<timestamp3){
		        	var carnumber= $('#carnumber').val();
		              $.ajax({
		                  url: "${wlpt}/wlpt/trade/getCarGpsInfo",
		                  data: {
		                	  
		                	  carnumber:carnumber,
		                      beginTime:btime,
		                      endTime: etime 
		                	 
		                  },
		                  dataType: 'json',
		                  cache: false,
		                  success: function (date) {
		                	var data=date.value.data;
		                	var state=date.value.state;
		                	console.log(data);
		                	console.log(state);
		                	  if(state!=5){               
			                                       //状态码5是余额不足  1是中兴的数据  2 是永奎数据
			                	  $("#maskloading" , parent.document).hide();
		                		 if(data!=""&&data!=null){
		                			 renderMaplist(date.value,carnumber);
		                		 }else{
		                			 $.MsgBox.Alert("系统提示", "该车辆暂无轨迹信息");
		                		 }
		                	  }else{
		                    	$("#maskloading" , parent.document).hide();
		                      	$.MsgBox.Alert("系统提示", date.value.message);
		                      }
		                  }
		              });
		    	}else{
		    		 $("#maskloading" , parent.document).hide();
		    		$.MsgBox.Alert("系统提示","轨迹信息为半年以内数据，此轨迹信息已失效");
		    	}
			}, function () {
		     }, null, null, "是", "否");  
	       }else{
	    	   $.MsgBox.Alert("系统提示", "您选择的开始时间大于结束时间，请重新选择！");
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
	    
	    
		//点击提交事件
	    function subinfo(){
	    	var SelectFalse = false; //用于判断是否被选择条件
	    	var CheckBox = $('#agree').is(':checked');//得到所的复选框
	    		if($('#agree').is(':checked')){
	    						    	 //jquery1.6以上可以if(CheckBox[i].prop('checked') == true)去判断checkbox是否被选中
		    	       	//如果有1个被选中时
		    		SelectFalse = true;
		    	
		    }
	    	var checkbox = document.getElementById("agree");//选中checkbox的id；
            if( SelectFalse && checkbox.checked==true){//按钮已选中
		    	$.MsgBox.Confirm("提示信息", "平台信息查询包含收费服务，使用将收取服务费用，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {
		    	var name = $('#driver').val();
		    	var phone = $('#phone').val();
		    	var carnumber = $('#carnumber').val();
		    	console.log(carnumber);
		    	
		    	var s1="";
		    	var s2="";
		    	var s3="";
		    	var s4="";
		    	var s5="";
		    	var s6="";
		    	if($("#car_net").is(":checked")){//选中  车辆入网验证
		    		var s1 = "zjxl001";
		    		$('#div1').show();
		    	}else{
		    		$('#div1').hide();
		    	};
		    	if($("#user_check").is(":checked")){//选中  车主真实性验证
			    	var s2 = "zjxl004";
			    	$('#div2').show();
		    	}else{
		    		$('#div2').hide();
		    	};
			    if($("#deck_check").is(":checked")){//选中  套牌验证
			    	var s3 = "zjxl005";
			    	$('#div3').show();
			    }else{
		    		$('#div3').hide();
		    	};
				if($("#road_check").is(":checked")){//选中  道路许可证验证
					var s4 = "zjxl003";
					$('#div4').show();
				}else{
		    		$('#div4').hide();
		    	};
				if($("#license_check").is(":checked")){//选中 车辆行驶证信息查询
					var s5 = "zjxl002";
					$('#div5').show();
				}else{
		    		$('#div5').hide();
		    	};
				
				s6 = s1+","+s2+","+s3+","+s4+","+s5;
				console.log(s6);
						var jsonstr = {
						"name"  : name,             //
						"phone" : phone,
						"vclN"  : carnumber,
						 "vco"  : "2",
						 //"area" :"110108",         //
						                            //
						"regist": s6 ,
						"authentication":"1"
				};
						
				

 			    	$.ajax({
			    		url :"${wlpt}/wlpt/totalvalida/totalValis",
			    		data : jsonstr,
			    		dataType : 'json',
			    		contentType:'charset=UTF-8',
						success : function(result) {

							console.log(result);
							var payinfo=result.data.paymentinfo;
							if(payinfo==2){
								$.MsgBox.Alert("系统提示","用户信息缺失");
								$('#div1').hide();
								$('#div2').hide();
								$('#div3').hide();
								$('#div4').hide();
								$('#div5').hide();
								
							};
							if(payinfo==5){
								$.MsgBox.Alert("系统提示","账户可用余额不足");
								$('#div1').hide();
								$('#div2').hide();
								$('#div3').hide();
								$('#div4').hide();
								$('#div5').hide();
							};
							if(s6.indexOf("zjxl005") > -1){
								//套牌车验证状态：0未校验，1已入网，-1未查询到
								//var sa=result.data.AreaByVclNo.checkareastatus;
								$('#areastatus').html("不是套牌车");
								if(sa=="1"){
									$('#areastatus').html("不是");							
								};
								if(sa=="2"){
									$('#areastatus').html("是");	
								};
								if(sa=="-1"){
									$('#areastatus').html("未查询到");							
								}; 
							};
							if(s6.indexOf("zjxl001") > -1){
							    //车辆入网验证
								if(result.data.hasOwnProperty('TruckExist')){
									$('#truckstatus').html(result.data.TruckExist.checktruckstatus);
								}else {
									$('#truckstatus').html("未查询到信息");
								}
							};
							if(s6.indexOf("zjxl002") > -1){
								//车辆行驶证信息
								if(undefined==result.data.vQueryLicense){
									$('#title').html("未查询到信息");
									$('#tableid').hide();
								}else{
									$('#vclWnrNm').html(result.data.vQueryLicense.vclWnrNm);
									$('#vclWnrPhn').html(result.data.vQueryLicense.vclWnrPhn);
									$('#areaName').html(result.data.vQueryLicense.areaName);
									$('#vclTpNm').html(result.data.vQueryLicense.vclTpNm);
									$('#vbrndCdNm').html(result.data.vQueryLicense.vbrndCdNm);
									$('#prdCdNm').html(result.data.vQueryLicense.prdCdNm);
									$('#cmpNm').html(result.data.vQueryLicense.cmpNm);
									$('#vin').html(result.data.vQueryLicense.vin);
									$('#serviceName').html(result.data.vQueryLicense.serviceName);
									$('#vclTn').html(result.data.vQueryLicense.vclTn);
									$('#ldTn').html(result.data.vQueryLicense.ldTn);
									$('#vclDrwTn').html(result.data.vQueryLicense.vclDrwTn);
									$('#vclLng').html(result.data.vQueryLicense.vclLng);
									$('#vclWdt').html(result.data.vQueryLicense.vclWdt);
									$('#vclHgt').html(result.data.vQueryLicense.vclHgt);
									
								}
								
							};
							if(s6.indexOf("zjxl003") > -1){
							    //道路许可证信息
							    $('#portcard').html("未查询到信息");
							    $('#dityterm').html("未查询到信息");
							    if(undefined!=result.data.RTCNo.transportcard){
							    	
									$('#portcard').html(result.data.RTCNo.transportcard);
							    }
							    if(undefined!=result.data.RTCNo.validityterm){
							    	
									$('#dityterm').html(result.data.RTCNo.validityterm);
							    }
							};
							if(s6.indexOf("zjxl004") > -1){
								//判断车主真实性验证状态：0未校验，1真实，2姓名不匹配，3手机号码不匹配，-1未查询到
								var sa=result.data.OwnerByVclNo.checkownerstatus;
								$('#ownerstatus').html("未查询到信息");
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
									$('#ownerstatus').html("未查询到信息");
								};
							};
							
							checkAni();
						},
						error : function(message){
							$.MsgBox.Alert("系统提示","未知错误");
						}
				
		    		
		    	}); 
                
			    }, function () {
			          $("#maskloading", parent.document).hide();
			    },null,null, "是", "否");
            }else{
            	$.MsgBox.Alert("系统提示","必须选中协议,并且选中一项服务");
            }
	    	
	    }
	  //服务价格显示
		$('#maxcheckbox').click(function(){
			var price=0;
			if(document.getElementById("car_net").checked==true){
				price=price+${fns:getMsgLabel("zjxl001","zjxl_port","")};
			};
			if(document.getElementById("user_check").checked==true){
				price=price+${fns:getMsgLabel("zjxl004","zjxl_port","")};
				$('#driverdiv').show();
				$('#phonediv').show();
			}else{
				$('#driverdiv').hide();
				$('#phonediv').hide();
			}
			if(document.getElementById("deck_check").checked==true){
				price=price+${fns:getMsgLabel("zjxl005","zjxl_port","")};
			};
			if(document.getElementById("road_check").checked==true){
				price=price+${fns:getMsgLabel("zjxl003","zjxl_port","")};
			};
			if(document.getElementById("license_check").checked==true){
				price=price+${fns:getMsgLabel("zjxl002","zjxl_port","")};
			};
			var s=price;
			n=2;  
			s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
			var l=s.split(".")[0].split("").reverse(),   
			r=s.split(".")[1];   
			t="";   
			for(i=0;i<l.length;i ++ )   
			{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
		    var num=t.split("").reverse().join("") + "." + r;//整个数字
		    var new_num=t.split("").reverse().join("");
		    var num_s=num.slice(-3);
		    $('#price').text(new_num);
		    $('#price').next().text(num_s);
			
		});
		</script>
	</body>
</html>
