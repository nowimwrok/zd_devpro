<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<title>抢单</title>
<style>
	.transit_tab .close{position:absolute;top:10px;right:10px;}
	.goods_quote_input{
		height: 100%;
		padding: 5px;
		line-height: 30px;
		border-width: 1px;
		border-style: solid;
		border-color: rgb(221, 221, 221) rgb(221, 221, 221) rgb(155, 155, 155);
		border-image: initial;
		border-radius: 2px;
		width: 100px;
		text-indent: 10px;
		box-shadow: none;
	}
</style>
</head>
<body style="background: #f5f5f5;">
	<div class="row" style="background-color:#fff;">
        <div class="col-lg-12" style="background-color:#fff;">
        	<div class="col-sm-12 clearfix offer">
        		<ul class="list-group clearfix flow">
        			<li class="list-group-item pull-left text-center">
        				<div class="flow_content">
        					<p><img src="${ctxStatic}/front/img/offer_bid_sure.png" alt="" /></p>
        					<div class="text active">报价</div>
        					<div class="flow_line"></div>
        				</div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_jd.png" alt="" /></p>
        				<div class="text">接单</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_th.png" alt="" /></p>
        				<div class="text">提货</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_xh.png" alt="" /></p>
        				<div class="text">卸货</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_account.png" alt="" /></p>
        				<div class="text">结算</div>
        			</li>
        		</ul>
        	</div>
        	<div class="col-sm-12 offer_detail" style="padding:0;">
        		<div class="form_container">
                	<!--第三个面板-->
                	<div class="col-sm-6 offer_detail_l" style="padding-left:0;">
                		<div class="panel clearfix">
	                		<h4 class="panel-heading">
	                			报价信息
	                		</h4>
	                		<div class="col-sm-10 form-horizontal form-addr">
	                		<form:form id="inputForm"  method="post">
	                			<input id="gsid" value="${goods.id}" type="hidden"/>
	                			<div class="form-group col-sm-12 has-unit">
	                				<div class="col-sm-5 control-label text-right">
	                					运输信息：
	                				</div>
	                				<div class="col-sm-7 text-left" style="position:relative;">
	                					<input type="hidden" id= "driverid" name= "driverid">
	                					<input type="hidden" id= "carid" name= "carid">
	                					<input type="hidden" id= "drivername">
	                					<input type="hidden" id= "carname">
	                					<input type="text" id ="nametext" class="form-control" min="0" placeholder="司机/车辆" readonly="readonly"/>
	                					<i class="arrow_msg  unit glyphicon glyphicon-chevron-down"></i>
	                					<!--车队司机车辆选项卡-->
	                					
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12 has-unit">
	                				<div class="col-sm-5 control-label text-right">
	                					我的报价：
	                				</div>
	                				<div class="col-sm-6 text-left">
	                					<input type="text" min="1" class="form-control" id="ooferprice" name="ooferprice" placeholder="请输入报价" value="${goods.expectedprice}"/>
	                					<i class="unit">元/${goods.freightunit}</i>
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12 has-unit">
	                				<div class="col-sm-5 control-label text-right">
	                					我要运：
	                				</div>
	                				<div class="col-sm-6 text-left">
	                					<input id=residualvolume value="${goods.residualvolume}" type="hidden"/>
	                					<input type="text" min="0.001" class="form-control" id="oddloadweight" name="oddloadweight" placeholder="请输入运输量" value="${goods.residualvolume}" />
	                					<i class="unit">${goods.freightunit}</i>
	                				</div>
	                			</div>
	                			<!-- <div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					运费：
	                				</div>
	                				<div class="col-sm-6 text-left text-primary" style="padding-top:7px;">
	                					12.00
	                				</div>
	                			</div> -->
	                			<!-- <div class="col-sm-12 checkbox text-center">
									<label for="checkbox1">
										<input type="checkbox" id="checkbox1" checked="checked"/>请仔细阅读
										<span class="text text-primary" style="font-size:15px;" onclick="openagreement('biddings');" >《竞价协议》</span>
									</label>
								</div> -->
	                			<div class="col-sm-3"></div>
	                			<div class="col-sm-7">
	                				<button class="btn btn-block btn-primary" style="letter-spacing: 1px;margin-top:20px" id="btnSubmit">提交报价</button>
	                			</div>
	                			</form:form>
	                			<div class="col-sm-7 transit_tab" ng-app="dataHall" ng-controller="dataHallCtrl">
	                				<button class="btn btn-primary text-center">确定</button>
	                				
	                				<ul class="nav nav-tabs">
								        <li class="active"><a href="#e1" data-toggle="tab">车队</a></li>
								        <li><a href="#e2" data-toggle="tab"  ng-click="selecttypetab(1)">司机</a></li>
								        <li><a href="#e3" data-toggle="tab" ng-click="selecttypetab(2)">车辆</a></li>
								        <li><input type="text" placeholder="关键字" class="goods_quote_input" name="searchinfo" id="searchinfo"><i class="glyphicon glyphicon-search" style="right: 25px;cursor:pointer;" ng-click="selectdata()" ></i></li>
								    </ul>
								    <div class="tab-content">
								        <div class="tab-pane active  col_1" id="e1">
								        	<ul class="list-group" >
								        		<li class="active" ng-click="selectTeam('')" style="margin-bottom:5px;">
								        		<a href="">全部</a>
								        		</li>
								        		<li ng-cloak ng-repeat="x in motorcadeData" style="margin-bottom:5px;" ng-click="selectTeam(x.id)" ng-class="{teamSeclected:searchData.motorcadeId==x.id}">
								        		<a href="">{{x.name}}</a>
								        		</li>
								        	</ul>
								        </div>
								        <div class="tab-pane fade clearfix col_2" id="e2">
								        	<ul class="col-sm-12 list-group clearfix">
								        		<li class="col-sm-6 pull-left active" style="margin-bottom:5px;" ng-repeat="x in datadriver" ng-click="getdriverinfo(x.reuser.id,x.reuser.name)">
								        			<a href="" class="pull-left" title="{{x.reuser.name}} {{x.reuser.phone}}">{{x.reuser.name.substr(0,3)}}</a>
								        			<a href="" class="pull-right" title="{{x.reuser.name}} {{x.reuser.phone}}">{{x.reuser.phone}}</a>
								        		</li>
								        		
								        	</ul>
								        </div>
								        <div class="tab-pane fade clearfix col_3" id="e3">
								        	<ul class="col-sm-12 list-group clearfix">
								        		<li class="col-sm-6 pull-left active" style="margin-bottom:5px;" ng-repeat="x in data" ng-click="getcarinfo(x.id,x.carnumber)">
								        			<a href="" class="pull-left" title="{{x.carnumber}} {{x.loadweight}}吨">{{x.carnumber}}</a>
								        			<a href="" class="pull-right" title="{{x.carnumber}} {{x.loadweight}}吨">{{x.loadweight}}吨</a>
								        		</li>
								        		
								        	</ul>
								        </div>
	                				</div>
	                			</div>
	                		
	                		</div>
                		</div>
                	</div>
                	<!--第四个面板-->
                	<div class="col-sm-6 offer_detail_r" style="padding-right:0;">
                		<div class="panel clearfix">
	                		<h4 class="panel-heading">
	                			货源信息
	                		</h4>
	                		<div class="col-sm-10 form-horizontal form-addr">
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					货物名称：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${goods.goodsname}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					货运量：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${goods.freightvolume }${goods.freightunit}--剩余${goods.residualvolume }${goods.freightunit}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					货物类型：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					<c:if test="${goods.goodstype == '0'}">轻货</c:if>
	                					<c:if test="${goods.goodstype == '1'}">重货</c:if>
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					<i class="offer_addr offer_addr_b"></i>
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${goods.shipAddress.city} ${goods.shipAddress.district}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					<i class="offer_addr offer_addr_r"></i>
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${goods.consignAddress.city } ${goods.consignAddress.district }
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					装车时间：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${sendtime}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					运输要求：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					车型-${goods.cartype }、车长-${not empty goods.carlength?goods.carlength:"不限"}${not empty goods.carlength?"米":""}、运输方式-${goods.transportway }
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12 tuoyun">
	                				<div class="col-sm-5 control-label text-right">
	                					托运方：
	                				</div>
	                				<div class="col-sm-7 control-label per_intro" style="text-align:left;">
	                					${goods.user.loginName }
	                					<img src="${ctxStatic}/front/img/level_0${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.png" class="level">
	                					<img alt="" style="top:0px;" class="per_phone phone_hover" src="${ctxStatic}/front/img/per_phone.png">
		        						<div class="per_warning" style="width:160px;">
		        							<span>联系号码：${goods.user.phone}</span>
		        						</div>
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					备注：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					卓大物流平台${goods.remarks }
	                				</div>
	                			</div>
	                		</div>
                		</div>
                	</div>
                </div>
        	</div>
        </div>
	</div>
<script>
	var w = document.documentElement.clientWidth;
    if(w<1010){
    	$('.row').css('width','1010px').css('background-color','#fff').css('overflow-x','hidden').css('overflow-y','hidden');
    	$('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }
  //绑定手机号 
    $('.phone_hover').hover(function(){
    	$(this).siblings('.per_warning').toggle();
    });
/*     $('#contact_table').bootstrapTable({
        pagination:true,//设置为 true 会在表格底部显示分页条
        paginationLoop:true,//设置为 true 启用分页条无限循环的功能。
        search:true,
        showColumns:10
   }); */
    
    //去掉 input 聚焦时 有阴影
    $('input').focus(function(){
    	$(this).css('box-shadow','none').css('border-bottom-color','#9b9b9b');
    });
    //报价信息和货源信息高度
    var r_h=$('.offer_detail_r').height();
    $('.offer_detail_l .panel').height(r_h+'px');

  //点击箭头 出现tab切换
	$('.arrow_msg').click(function(){
		$('.transit_tab').show(500);
	});
	//点击确定按钮 隐藏
	$('.transit_tab .btn').click(function(){
		$(this).parent().hide(500);
	});
  
  
  
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
    		ishow: true,
            pagesLength: 3,
            currentPage: 1,
            itemsPerPage: 10
        };
        $scope.typetab = 0;
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

        $scope.isloadingMotorcade = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#motorcadeNoneData").hide();
                $(".motorcadeDatainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#motorcadeNoneData").show();
                $(".motorcadeDatainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#motorcadeNoneData").hide();
                $(".motorcadeDatainit").show();
            }
        };
        $scope.searchInfo = function () {
            $("#maskloading", parent.document).show();
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };

        $scope.searchData = {carType: "", isSocialCar: "", searchInfo: "", motorcadeId: ""};
        var GetMotorcadeCarPage = function () {
            var postData = {
            	'status':'2',
                'motorcadeId': $scope.searchData.motorcadeId,
                pageNo: $scope.paginationConf.currentPage,
                pageSize: 10000,
                searchinfo:$("#searchinfo").val()
            };
            $http({
                url: '${wlpt}/wlpt/car/getCarList',
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

        $scope.searchData = {motorcadeId: ""};
        var GetMotorcadeDriverPage = function () {
            var postData = {
            	'isagree':'1',
                'motorcadeId': $scope.searchData.motorcadeId,
                pageNo:
                $scope.paginationConf.currentPage,
                pageSize:10000,
                searchinfo:$("#searchinfo").val()
            };
            $http({
                url: '${wlpt}/wlpt/driver/getDriverDataList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.datadriver = response.value;
                if (!$scope.datadriver) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);
                }
            });
        };
        
        $scope.selectTeam = function (id) {
            $scope.searchData.motorcadeId = id;
            GetMotorcadeCarPage();
            GetMotorcadeDriverPage();
        }

        $scope.selecttypetab = function (type) {
            $scope.typetab = type;
            $("#searchinfo").val("");
            if($scope.typetab==1){
                GetMotorcadeDriverPage();
            }else if($scope.typetab==2){
                GetMotorcadeCarPage();
            }
        }
        $scope.selectdata = function () {
           	if($scope.typetab==1){
                GetMotorcadeDriverPage();
			}else if($scope.typetab==2){
                GetMotorcadeCarPage();
			}

        }


        var GetMotorcadeList = function () {
            $http.get("${wlpt}/wlpt/motorcade/getMotorcadeList").success(function (response) {
                $scope.motorcadeData = response.data.motorcades;
                if (!$scope.motorcadeData) {
                    $scope.isloadingMotorcade(2);
                } else {
                    $scope.isloadingMotorcade(3);
                }
            });
        };
        GetMotorcadeList();
		
        $scope.getcarinfo=function(id,carnumber){
        	$("#carid").val(id);
        	$("#carname").val(carnumber);
        	var username = $("#drivername").val();
        	if(username==''||username==""||username==undefined){
        		username="司机";
        	}
        	$("#nametext").val(username+"/"+carnumber);
        	
        }
		$scope.getdriverinfo=function(id,name){
			$("#driverid").val(id);
        	$("#drivername").val(name);
        	var carnumber = $("#carname").val();
        	if(carnumber==''||carnumber==""||carnumber==undefined){
        		carnumber="车辆";
        	}
        	$("#nametext").val(name+"/"+carnumber);
        }

        $scope.currentSelectCarId = "";
        $scope.showSelectMotorcade = function (id) {
            $scope.currentSelectCarId = id;
        };

        var closeAllModal = function () {
            $(".modal").modal("hide");
        }
        
        $scope.closetab = function () {
        	$('.transit_tab').hide();
        }

        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetMotorcadeCarPage);
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetMotorcadeDriverPage);

    }]);
  
    $('#inputForm').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	ooferprice: {
                message: '报价无效',
                validators: {
                    notEmpty: {
                        message: '报价不能为空'
                    },decimalTwo: {
                        message: '请输入正确的报价'
                    }
                }
            },oddloadweight: {
                message: '报价吨位无效',
                validators: {
                    notEmpty: {
                        message: '报价吨位不能为空'
                    },decimalFour: {
                        message: '报价吨位只能为小数或数字'
                    }, lessThan: {
                        value: ($("#residualvolume").val() * 1),
                        message: '报价吨位不能大于货物剩余吨位！'
                    }
                }
            }
        }
    });

  
  
    if ($("#residualvolume").val() == 0) {
        $("#btnSubmit").val("报价已结束");
        $("#btnSubmit").attr('disabled', 'disabled');
    } else {
    	
        $("#btnSubmit").val("报价");
        /* if ($("#driverid").val() == null || $("#driverid").val() == "") {
            self_fun("#nametext",'您没有可以选择的司机！',true);
            $("#btnSubmit").attr('disabled', 'disabled');
        }
        else if ($("#carid").val() == null || $("#carid").val() == "") {
            self_fun("#nametext",'您没有可以选择的车辆！',true);
            $("#btnSubmit").attr('disabled', 'disabled');
        } */
		
        $("#btnSubmit").click(function () {
            var isnul = true;
            var did =  $("#driverid").val();
            if ($("#driverid").val() == null || $("#driverid").val() == "") {
                self_fun("#nametext",'请选择司机！',true);
                return false;
            }else{
            	self_fun("#nametext",'',false);
            }
            if ($("#carid").val() == null || $("#carid").val() == "") {
                self_fun("#nametext",'请选择车辆！',true);
                return false;
            }else{
            	self_fun("#nametext",'',false);
            }
            /* isnul = isnul && $("input[name=ooferprice]").valid({
                        methods: "required|decimalTwo"
                    });
            isnul = isnul && $("input[name=oddloadweight]").valid({
                        methods: "required|decimal"
                    }); */
            if (($("#ooferprice").val() * 1) <= 0) {
                self_fun("#ooferprice",'报价不能小于0',true);
                return false;
            }else{
            	self_fun("#ooferprice",'',false);
            }
            if (($("#oddloadweight").val() * 1) < 0) {
                self_fun("#oddloadweight",'报价吨位不能小于0',true);
                return false;
            }else{
            	self_fun("#oddloadweight",'',false);
            }
            if (($("#residualvolume").val() * 1) < ($("#oddloadweight").val() * 1)) {
                self_fun("#oddloadweight",'报价吨位不能大于货物剩余吨位！',true);
                return false;
            }else{
            	self_fun("#oddloadweight",'',false);
            }
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                var gdsid = $("#gsid").val();
                var driverid = $("#driverid").val();
                var carid = $("#carid").val();
                var ooferprice = $("#ooferprice").val() * 1;
                var oddloadweight = $("#oddloadweight").val() * 1;
                var title = "";
                if('${goods.isinsur}'=="1"){
                	if('${goods.paypeople}'=="1"){
                		title = "该运单需购买货运保险，付款方为：承运方，";
                    }else{
                    	title = "该运单需购买货运保险，付款方为：发货方，";
                    }
                }
                $.MsgBox.Confirm("抢单提示", title+"确定报价?", function () {
                $(".loading_lock").show();
                $.ajax({
                    type: "POST",
                    url: '${wlpt}/wlpt/goods/saveQuote',
                    dataType: 'json',
                    data: {
                        'goods.id': gdsid,
                        'driver.id': driverid,
                        'car.id': carid,
                        'ooferprice': ooferprice,
                        'oddloadweight': oddloadweight

                    },
                    cache: false,
                    success: function (data) {
                        if (data.value == "请先登录系统") {
                            window.location.href = "${wlpt}/login?login=login";
                        }
                        else if (data.value == "报价成功") {
                            window.location.href = "${wlpt}/wlpt/personal/home_index";
                        } else {
                            $(".loading_lock").hide();
                            $.MsgBox.Alert("报价提示", data.value);
                        }
                    }
                });
                }, function () {
                	 $(".loading_lock").hide();
                });
            }
        });
    }
    
    function self_fun(id,msg,status){
		//input 绑定监听
			var length=$(id).parent().find('span').length;
			if(status==true){
				$(id).next().find('span').remove();
				var error_span='<span style="color:#a94442;font-size:12px;display:inline-block;margin-top:10px;">'+msg+'</span>';
				var icon_remove='';
				
				if(length==0){
					$(id).parent().append(icon_remove);
					$(id).parent().append(error_span);
				}
				$(id).css('border-color','#e94c3c').css('box-shadow','0 0 10px rgba(233,76,60,.3)').css('-webkit-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-moz-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-o-box-shadow','0 0 10px rgba(233,76,60,.3)');
				//删除ie自带删除图标
				$(id).addClass('error');
			}
			else if(status==false){
				$(id).parent().find('span').remove();
				//删除ie自带删除图标
				$(id).addClass('error');
				if(length==0){
					var icon_ok='';
					$(id).parent().append(icon_ok);
				}
			}
	}
</script>
</body>
</html>