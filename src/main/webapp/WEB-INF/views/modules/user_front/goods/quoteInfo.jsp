<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<%@include
	file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
	

<!--  <meta name="decorator" content="site_personal_basic"/> -->
<title>报价查看</title>
<style type="text/css">
.loading {
	text-align: center;
}

.form-control {
	border: 1px solid #ccc !important;
}

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	padding: 10px;
	line-height: 1.42857143;
	border-bottom: 1px solid #ddd;
	font-size: 13px;
	vertical-align: bottom;
	white-space: nowrap;
	box-sizing: border-box;
}

.delivery_tr td {
	padding-left: 10px !important;
}

.text-left {
	text-align: left !important;
}

.col-sm-12 {
	padding: 0px;
}

#modal_check .modal-backdrop {
	display: none;
}
</style>
</head>
<body style="background: #f5f5f5;">

	<div ng-app="dataHall" ng-controller="dataHallCtrl">
		<div class="row">
			<div class="col-lg-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading ">货源管理</h4>

						<div class="panel-body">

							<table class="table">
								<thead>
									<tr>
										<th>司机信息</th>
										<th>车辆</th>
										<th>报价</th>
										<th>诚信</th>
										<th>报价日期</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody class="datainit">
									<tr ng-repeat="x in data">
										<td ng-cloak>{{x.driver.name}}{{x.driver.phone}} <span
											class="bg_blue_label">担保金</span><img
											src="${ctxStatic}/front/img/has_auth.png" class="auth_img">
										</td>
										<td id="carnumber" ng-cloak>{{x.car.carnumber}}<span
											class="vertical-line">|</span>{{x.car.cartype}}<span
											class="vertical-line">|</span>{{x.car.loadweight}}{{x.car.weightunit}}<span
											class="vertical-line">|</span>{{x.car.carlength}}{{x.car.lengthunit}}
										</td>
										<td ng-cloak>{{x.ooferprice}}元/{{x.goods.freightunit}} <span
											class="vertical-line">|</span>{{x.oddloadweight}}{{x.goods.freightunit}}
										</td>
										<td ng-cloak><img
											src="${ctxStatic}/front/img/level_0{{x.driver.credit != null ? x.driver.credit : 1}}.png"
											class="level"></td>
										<td ng-cloak>{{x.createDate.substr(0,10)}} <span
											ng-if="x.quotestatus==2 && x.isreload==1"> <br>实际配载:{{x.actload}}{{x.goods.freightunit}}
										</span>
										</td>
										<td ng-cloak ng-switch on="{{x.quotestatus}}"><a
											href="${wlpt}/wlpt/goods/quoteOrder?id={{x.id}}"
											ng-switch-when="1" class="green oprate">生成运单</a> <a
											href="javascript:;" ng-click="isAgree(x.id)"
											ng-switch-when="1" class="orange oprate">拒绝报价</a> <a
											href="${wlpt}/wlpt/goods/quoteinfo_track?id={{x.id}}&&carNumber={{x.car.carnumber}}"
											ng-switch-when="1" ng-show="x.driver.id!=null"
											ng-switch-when="1" class="see oprate">车辆位置</a> <a
											href="javascript:;" ng-switch-when="3" class="red oprate">未通过</a>
											<a
											href="${wlpt}/wlpt/trade/trade_list?searchinfo={{x.car.carnumber}}"
											ng-switch-when="4" class="see oprate">交易取消</a> <a
											data-toggle="modal" data-target="#modal_check"
											ng-click="checkinfo(x)" class="see oprate"
											ng-show="x.car.carnumber!=null" id="msg_regist">信息校验</a></td>
									</tr>
								</tbody>
							</table>
							<div id="noneData"
								style="display: none; text-align: center; width: 100%; line-height: 25px;">
								<img src="${ctxStatic }/front/img/nodata.png"
									style="width: 100px; height: 100px;">
							</div>

							<!--分页-->
							<tm-pagination conf="paginationConf"></tm-pagination>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="row">
			<div class="col-lg-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">运单规则</h4>
						<div class="col-lg-12 form-horizontal">
							<p>1.司机报价为运输单价。</p>
							<p>2.当您生成了运单，系统将自动从您的账户上扣除运费。</p>
							<p>3.运单结束后，运费从平台支付给司机。</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--信息校验弹框-->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="modal_check" class="modal"
			style="margin: auto; overflow-y: hidden;">
			<div>
				<div class="modal-content">
					<div class="modal-header">
						<button aria-hidden="true" data-dismiss="modal" class="close"
							type="button">×</button>
						<h4 class="modal-title">信息校验</h4>
					</div>
					<div class="modal-body form-horizontal">
						<!--司机信息-->
						<div class="col-sm-12 clearfix driver_msg">
							<div class="col-sm-4 form-group clearfix pull-left">
								<div class="pull-left control-label">司机：</div>
								<div class="pull-left control-label">
									<span id="driver"></span> <input type="hidden" id="carid" /> <input
										type="hidden" id="area" /> <input type="hidden" id="rtcNo" />

								</div>
							</div>
							<div class="col-sm-4 form-group clearfix pull-left">
								<div class="pull-left control-label">手机号：</div>
								<div class="pull-left control-label">
									<span id="phone"></span>
								</div>
							</div>
							<div class="col-sm-4 form-group pull-right">
								<div class="pull-left control-label">车牌：</div>
								<div class="pull-left control-label">
									<span id="vcln"></span>
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
											<label for="car_net"> <input name="check"
												id="car_net" type="checkbox" value="1">车辆入网验证 <span
												style="color: #F00">${fns:getMsgLabel("zjxl001","zjxl_port","")}元</span>
											</label>
										</div>
										<div class="col-sm-4 pull-left form-group">
											<label for="user_check"> <input name="check"
												id="user_check" type="checkbox" value="2">车主真实性验证 <span
												style="color: #F00">${fns:getMsgLabel("zjxl004","zjxl_port","")}元</span>
											</label>
										</div>
										<div class="col-sm-4 pull-right form-group">
											<label for="deck_check"> <input name="check"
												id="deck_check" type="checkbox" value="3">套牌验证 <span
												style="color: #F00">${fns:getMsgLabel("zjxl005","zjxl_port","")}元</span>
											</label>
										</div>
										<div class="col-sm-4 pull-left form-group">
											<label for="road_check"> <input name="check"
												id="road_check" type="checkbox" value="4">道路许可证验证 <span
												style="color: #F00">${fns:getMsgLabel("zjxl003","zjxl_port","")}元</span>
											</label>
										</div>
										<div class="col-sm-4 pull-left form-group">
											<label for="check"> <input name="check"
												id="license_check" type="checkbox" value="5">车辆行驶证信息查询
												<span style="color: #F00">${fns:getMsgLabel("zjxl002","zjxl_port","")}元</span>
											</label>
										</div>
										<!--服务费用-->
										<div class="col-sm-12 fee_box" style="margin-left: 25px;">
											服务费：￥<span class="fee fee_bold" id="price">0.00</span><span
												class="fee"></span>元
										</div>
										<!--平台收费协议-->
										<div class="col-sm-12 agree_box text-center">
											<label for="agree"> <input name="agree" id="agree"
												type="checkbox" checked='checked' onclick="checkagree()"
												value="88"><a target='_blank'
												onclick="openagreement('LocationService')"
												style="line-height: 30px; text-decoration: none;">《平台增值服务收费协议》</a>
											</label>
										</div>
										<div class="col-sm-12 submit_box text-center">
											<button class="btn" id="subButton" onclick="subinfo()">提交</button>
										</div>
									</div>
								</div>
							</div>
							<!--点提交后显示的信息-->
							<div class="check_service check_after col-sm-12">
								<div class="col-sm-12">
									<h5 class="service_title text-center pull-left ">校验结果</h5>
									<button class="btn btn-warning pull-right back_look">返回查询</button>
								</div>

								<div class="col-sm-12 clearfix driver_msg">
									<div class="col-sm-4 form-group clearfix pull-left" id="div1"
										style="display: none">
										<div class="pull-left control-label">入网验证：</div>
										<div class="pull-left control-label" style="color: #F00"
											id="truckstatus"></div>
									</div>
									<div class="col-sm-4 form-group clearfix pull-left" id="div2"
										style="display: none">
										<div class="pull-left control-label">车主真实性：</div>
										<div class="pull-left control-label" style="color: #F00"
											id="ownerstatus"></div>
									</div>
									<div class="col-sm-4 form-group pull-right" id="div3"
										style="display: none">
										<div class="pull-left control-label">是否套牌：</div>
										<div class="pull-left control-label" style="color: #F00"
											id="areastatus"></div>
									</div>
								</div>
								<div class="col-sm-12 clearfix driver_msg " id="div4"
									style="display: none">
									<div class="form-group clearfix pull-left driver_msg_road">
										<div class="pull-left control-label">道路许可证：</div>
										<div class="pull-left control-label" style="color: #F00"
											id="portcard"></div>
									</div>
									<div class="form-group clearfix pull-left">
										<div class="pull-left control-label">有效期：</div>
										<div class="pull-left control-label" style="color: #F00"
											id="dityterm"></div>
									</div>
								</div>
								<div class="col-sm-12 license_msg" id="div5"
									style="display: none" s>
									<div class="col-sm-12 license_title" style="margin-left: 30px;">
										行驶证信息：<span style="color: #F00" id="title"></span>
									</div>
									<div class="col-sm-12">
										<table class="table table-bordered table-striped" id="tableid">
											<tr class="table_title">
												<th>名称</th>
												<th>数据</th>
											</tr>
											<tr>
												<td>联系人</td>
												<td id="vclWnrNm"></td>
											</tr>
											<tr>
												<td>联系人手机</td>
												<td id="vclWnrPhn"></td>
											</tr>
											<tr>
												<td>车籍地</td>
												<td id="areaName"></td>
											</tr>
											<tr>
												<td>车辆类型</td>
												<td id="vclTpNm"></td>
											</tr>
											<tr>
												<td>车辆品牌</td>
												<td id="vbrndCdNm"></td>
											</tr>
											<tr>
												<td>车辆型号</td>
												<td id="prdCdNm"></td>
											</tr>
											<tr>
												<td>车主/业主</td>
												<td id="cmpNm"></td>
											</tr>
											<tr>
												<td>车辆识别代码/车架号</td>
												<td id="vin"></td>
											</tr>
											<tr>
												<td>服务商名</td>
												<td id="serviceName"></td>
											</tr>
											<tr>
												<td>总质量</td>
												<td id="vclTn"></td>
											</tr>
											<tr>
												<td>核定载重量(Kg)</td>
												<td id="ldTn"></td>
											</tr>
											<tr>
												<td>准牵引总重量(Kg)</td>
												<td id="vclDrwTn"></td>
											</tr>
											<tr>
												<td>外廓尺寸长(mm)</td>
												<td id="vclLng"></td>
											</tr>
											<tr>
												<td>外廓尺寸宽(mm)</td>
												<td id="vclWdt"></td>
											</tr>
											<tr>
												<td>外廓尺寸高(mm)</td>
												<td id="vclHgt"></td>
											</tr>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="row">
			<div class="col-sm-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">基本信息</h4>
						<div class="col-sm-12 form-horizontal">
							<input id="gsid" name="id" value="${goods.id}" type="hidden" />
							<div class="form-group col-sm-4">
								<div class="col-sm-5 control-label text-right">货物名称</div>
								<div class="col-sm-7 control-label text-left">
									${goods.goodsname}</div>
							</div>
							<div class="form-group col-sm-4 has-unit">
								<div class="col-sm-5 control-label text-right">货物重量</div>
								<div class="col-sm-7 control-label text-left">
									${goods.freightvolume }吨</div>
							</div>
							<!--下拉框-->
							<div class="form-group col-sm-4">
								<div class="col-lg-5 control-label text-right">货物类别</div>
								<div class="col-lg-7 control-label" style="text-align: left;">
									<c:if test="${goods.gsoddtype == '1'}">成品</c:if>
									<c:if test="${goods.gsoddtype == '2'}">原料</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-sm-12">
				<div class="col-sm-6" style="padding-left: 0;">
					<div class="panel clearfix">
						<div class="form_container">
							<h4 class="panel-heading">发货人</h4>
							<div class="col-sm-12 form-horizontal">
								<div class="form-group">
									<div class="col-sm-3 control-label text-right">提货地址</div>
									<div class="col-sm-9 control-label text-left">
										${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district}
										${goods.shipAddress.address}</div>
								</div>
								<div class="form-group">
									<div class="clearfix">
										<div class="col-sm-3 control-label text-right">姓名</div>
										<div class="col-sm-2 control-label text-left">
											${goods.shipAddress.linkman}</div>
										<div class="col-sm-2 control-label text-right">手机号</div>
										<div class="col-sm-5 control-label text-left">
											${goods.shipAddress.linkmobile}</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6" style="padding-right: 0;">
					<div class="panel clearfix">
						<div class="form_container">
							<h4 class="panel-heading">收货人</h4>
							<div class="col-sm-12 form-horizontal">
								<div class="form-group">
									<div class="col-sm-3 control-label text-right">卸货地址</div>
									<div class="col-sm-9 control-label text-left">
										${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district}
										${goods.consignAddress.address}</div>
								</div>
								<div class="form-group">
									<div class="clearfix">
										<div class="col-sm-3 control-label text-right">姓名</div>
										<div class="col-sm-2 control-label text-left">
											${goods.consignAddress.linkman}</div>
										<div class="col-sm-2 control-label text-right">手机号</div>
										<div class="col-sm-5 control-label text-left">
											${goods.consignAddress.linkmobile}</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="col-sm-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">货物信息</h4>
						<div class="col-sm-12 form-horizontal">
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">装车时间</div>
								<div class="col-sm-7 control-label text-left">
									<fmt:formatDate value="${goods.sendtime}"
										pattern="yyyy-MM-dd HH:mm" />
								</div>
							</div>
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">运输方式</div>
								<div class="col-sm-7 control-label text-left">
									${goods.transportway }</div>
							</div>
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">期望价格</div>
								<div class="col-sm-7 control-label text-left">
									${goods.expectedprice}元/吨</div>
							</div>
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">有效天数</div>
								<div class="col-sm-7 control-label text-left">
									${goods.effectdays}天</div>
							</div>
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">货物价值</div>
								<div class="col-sm-7 control-label text-left">
									${goods.worth}元</div>
							</div>

						</div>


					</div>
				</div>
			</div>


			<div class="col-sm-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">需求车型</h4>
						<div class="col-sm-12 form-horizontal">
							<div class="form-group col-sm-4">
								<div class="col-sm-5 control-label text-right">车型</div>
								<div class="col-sm-7 control-label text-left">
									${goods.cartype}</div>
							</div>
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">车长</div>
								<div class="col-sm-7 control-label text-left">${not empty goods.carlength?goods.carlength:"不限"}${not empty goods.carlength?"米":""}
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">派车方式</h4>
						<div class="col-sm-12 form-horizontal">
							<div class="form-group col-sm-4">
								<div class="col-sm-5 control-label text-right">是否指派</div>
								<div class="col-sm-7 control-label text-left">
									${fns:getDictLabel(not empty goods.issend?goods.issend:'0','yes_no','')}

								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12">
				<div class="panel clearfix">
					<div class="form_container">
						<h4 class="panel-heading">备注信息</h4>
						<div class="col-sm-12 form-horizontal">
							<div class="form-group has-unit col-sm-4">
								<div class="col-sm-5 control-label text-right">备注</div>
								<div class="col-sm-7 control-label text-left">
									${goods.remarks }</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<div class="row">
			<div class="col-lg-12" style="border-bottom: 50px solid #f5f5f5;">
				<c:if test="${blinfoList!=null && blinfoList.size()>0}">
					<div class="panel clearfix">
						<div class="form_container">
							<h4 class="panel-heading">提货单</h4>
							<div class="col-sm-12 form-horizontal">
								<table class="table" id="delivery_order">
									<thead>
										<tr>
											<th>提货单号</th>
											<th>品名材质</th>
											<th>规格</th>
											<th>定尺\板宽</th>
											<th>数量\吨</th>
											<th>批次号</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${blinfoList}" varStatus="status">
											<tr class="delivery_tr">
												<td>${item.contractno}</td>
												<td>${item.namematerials}</td>
												<td>${item.standard}</td>
												<td>${item.width}</td>
												<td>${item.quantity}</td>
												<td>${item.batch}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>

	</div>
	<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
	<%-- <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script> --%>
	<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
	<script
		src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

	<!-- <script
			src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script> -->
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
	<script>
			$(".learn_more_goods").click(function() {
				$('.goods_add_det').toggle();
			})

			var id = $("#gsid").val();

			var app = angular.module('dataHall', [ 'tm.pagination' ]);
			app
					.controller(
							'dataHallCtrl',
							[
									'$scope',
									'$http',
									function($scope, $http) {
										//配置分页基本参数
										$scope.paginationConf = {
											currentPage : 1,
											itemsPerPage : 2
										};
										$scope.gsid = id;
										////isloading ==1:加载数据2:查询不到数据3:查询到数据
										$scope.isloading = function(isloading) {
											if (isloading == 1) {
												$("#maskloading",
														parent.document).show();
												$("#noneData").hide();
												$(".datainit").show();
											} else if (isloading == 2) {
												$("#maskloading",
														parent.document).hide();
												$("#noneData").show();
												$(".datainit").hide();
											} else {
												$("#maskloading",
														parent.document).hide();
												$("#noneData").hide();
												$(".datainit").show();
											}
										};
/////////////////////////////////////////	ngchick绑定属性									//////////////////////////////////////
										$scope.checkinfo=function(x){
											
									    	$("#driver").html(x.driver.name);
									    	$("#phone").html(x.driver.phone);
									    	$("#vcln").html(x.car.carnumber);
									    	$("#carid").html(x.car.id);
									    
									    	$("#area").html(x.car);
										};
										
										$scope.searchInfo = function() {
											$("#maskloading", parent.document)
													.show();
											if ($scope.paginationConf.currentPage == 1) {
												$scope.paginationConf.currentPage = 0;
											} else {
												$scope.paginationConf.currentPage = 1;
											}
										};
										var GetAllEmployee = function() {
											var postData = {
												'id' : $scope.gsid,
												pageNo : $scope.paginationConf.currentPage,
												pageSize : $scope.paginationConf.itemsPerPage
											};
											$http(
													{
														url : '${wlpt}/wlpt/goods/getQuoteInfo',
														method : 'post',
														params : postData
													})
													.success(
															function(response) {
																$scope.paginationConf.totalItems = response.value.count;
																$scope.data = response.value.list;
																if (!$scope.data) {
																	$scope
																			.isloading(2);
																} else {
																	$scope
																			.isloading(3);

																}
															});
										};

										$scope.isAgree = function(id) {

											if (id == null || id == "") {
												return;
											}
											$
													.ajax({
														url : "${wlpt}/wlpt/goods/isAgree",
														data : {
															id : id,
														},
														dataType : 'json',
														cache : false,
														success : function(data) {
															GetAllEmployee();
															//  alert(data.value);
															//  $("#agree").html("未通过");
														}
													});
										};

										/***************************************************************
										当页码和页面记录数发生变化时监控后台查询
										如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
										 ***************************************************************/
										$scope
												.$watch(
														'paginationConf.currentPage + paginationConf.itemsPerPage',
														GetAllEmployee);

									} ]);
			
			//信息验证弹框
		    $('#modal_check td').css('width','50%');
		  //点击提交后 上滑
		    var after_h=$('.check_after').height();
		    $('.submit_box .btn').click(function(){
			    	var checkbox = document.getElementById("agree");//选中checkbox的id；
			    	var SelectFalse = false; //用于判断是否被选择条件
			    	var CheckBox = $('input[name = check]');//得到所的复选框
			    	for(var i = 0; i < CheckBox.length; i++){
			    								     //jquery1.6以上可以if(CheckBox[i].prop('checked') == true)去判断checkbox是否被选中
				    	if(CheckBox[i].checked){        //如果有1个被选中时
				    		SelectFalse = true;
				    	
				    	}
			    	}
		            if( SelectFalse && checkbox.checked==true){//按钮已选中
				    	$.MsgBox.Confirm("提示信息", "平台信息查询包含收费服务，使用将收取服务费用，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {
		            	$('.check_before').animate({top:'-284px'},1000);
				    	$('.check_after').animate({top:'-284px'},1000);
				    	$('.check_after').show();
				     }, function () {
				          $("#maskloading", parent.document).hide();
				    },null,null, "是", "否"); 
		            }
		    });
		    $('.back_look').click(function(){
		    	$('.check_before').animate({top:'0px'},1000);
		    	//$('.check_after').animate({top:after_h+'px'},1000);
		    	$('.check_after').animate({top:'0px'},1000);
		    	$('.check_after').hide();
		    });
		    //服务金额格式化
		    $('#modal_check .fee_bold').each(function(){
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
			});

		  
		    
			//服务价格显示
			$('#maxcheckbox').click(function(){
				var price=0;
				if(document.getElementById("car_net").checked==true){
					price=price+${fns:getMsgLabel("zjxl001","zjxl_port","")};
				};
				if(document.getElementById("user_check").checked==true){
					price=price+${fns:getMsgLabel("zjxl004","zjxl_port","")};
				};
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
				//点击提交事件
			    function subinfo(){
			    	var SelectFalse = false; //用于判断是否被选择条件
			    	var CheckBox = $('input[name = check]');//得到所的复选框
			    	for(var i = 0; i < CheckBox.length; i++){
			    								     //jquery1.6以上可以if(CheckBox[i].prop('checked') == true)去判断checkbox是否被选中
				    	if(CheckBox[i].checked){        //如果有1个被选中时
				    		SelectFalse = true;
				    	
				    	}
			    	}
			    	var checkbox = document.getElementById("agree");//选中checkbox的id；
		            if( SelectFalse && checkbox.checked==true){//按钮已选中
				    	$.MsgBox.Confirm("提示信息", "平台信息查询包含收费服务，使用将收取服务费用，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {
 
				    	var name = $('#driver').text().trim();
				    	var phone = $('#phone').text().trim();
				    	var vcln = $('#vcln').text().trim();
				    	var carid=$('#carid').text().trim();
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
						
						var jsonstr = {
								"name"  : name,             //
								"phone" : phone,
								"vclN"  : vcln,
								 "vco"  : "2",
								 //"area" :"110108",         //
								                            //
								"regist": s6 ,
								"carid" :carid,
								"authentication":"1"
						};
								
						
		
					    	$.ajax({
					    		url :"${wlpt}/wlpt/totalvalida/totalVali",
					    		data : jsonstr,
					    		dataType : 'json',
					    		contentType:'charset=UTF-8',
								success : function(result) {
		
									console.log(result);
									var payinfo=result.data.paymentinfo;
									if(payinfo==2){
										alert("用户信息缺失");
										$('#div1').hide();
										$('#div2').hide();
										$('#div3').hide();
										$('#div4').hide();
										$('#div5').hide();
										
									};
									if(payinfo==5){
										alert("账户可用余额不足");
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
										/* if(sa=="1"){
											$('#areastatus').html("不是");							
										};
										if(sa=="2"){
											$('#areastatus').html("是");	
										};
										if(sa=="-1"){
											$('#areastatus').html("未查询到");							
										}; */
									};
									if(s6.indexOf("zjxl001") > -1){
									    //车辆入网验证
									     $('#truckstatus').html("未查询到信息");
										$('#truckstatus').html(result.data.TruckExist.checktruckstatus);							
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
									
									
								},
								error : function(message){
									alert("失败");
								}
						
				    		
				    	});
		                
					    }, function () {
					          $("#maskloading", parent.document).hide();
					    },null,null, "是", "否");
		            }else{
		               alert("必须选中协议,并且选中一项服务");
		            }
			    	
			    }
		   		$('.modal-backdrop').click(function(){
		   			$('.modal').css('display','');
		   		});
		</script>
</body>
</html>
