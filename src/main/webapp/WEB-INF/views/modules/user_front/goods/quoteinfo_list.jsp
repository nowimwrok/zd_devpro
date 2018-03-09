<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>报价管理</title>
    <style type="text/css">
        .loading{
			text-align: center;
		}
		.form-control{
			border: 1px solid #ccc !important;
		}
		.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
		    padding: 10px;
		    line-height: 1.42857143;
		    border-bottom: 1px solid #ddd;
		    font-size: 13px;
		    vertical-align: bottom;
		    white-space: nowrap;
		    box-sizing: border-box;
		}
		.table-bordered > tbody > tr > td {
			border: 1px solid #000;
			color: #000;
		}

		#modal td {
			line-height: 40px;
			padding: 0;
		}
		#modal .td_br{
			border: none!important;
			border-right: 1px solid #000000!important;
		}
		#modal .td_br_none{
			border-right: none!important;
		}

		#modal .col-sm-4, #modal .col-sm-2, #modal .col-sm-3, #modal .col-sm-6 {
			border-right: 1px solid #000;
		}
    </style>
</head>
<body style="background: #f5f5f5;">

<div  ng-app="dataHall" ng-controller="dataHallCtrl" >
    <div class="row">
    	<div class="col-lg-12" >
            <div class="panel">
            	<div class="form_container">
                    <h4 class="panel-heading ">报价管理</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px">
                	<div class="col-lg-12 search_wrap" >
                		<form action="" method="get" class="search-bar" style="text-align: center">
	                		<div class="col-sm-3">
	                			<input type="text"  id="searchinfo" ng-model="searchData.searchinfo" class="form-control" placeholder="货物名称或司机名称">
	                        </div>
	                        <div class="col-sm-2">
	                            <select id="quotestatus" class="form-control" ng-model="searchData.quotestatus">
							        <option value="">全部</option>
							        <option value="1">已报价</option>
							        <option value="2">报价通过</option>
							        <option value="3">不通过</option>
							    </select>
                        	</div>
                        	<div class="col-sm-2 text-left">
	                            <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
	                             class="btn btn-primary" ><i class="fa fa-search white"></i> 查询
	                            </button>
	                        </div>
                        </form>
                	</div>
                	<table class="table">
                		<thead>
					    <tr>
					        <th>用户</th>
					        <th>车牌号</th>
					        <th>车型</th>
					        <th>货物</th>
					        <th>运量</th>
					        <th>报价运量</th>
					        <th>单价(元/吨)</th>
					        <th>状态</th>
					        <th>时间</th>
					        <th>操作</th>
					    </tr>
					    </thead>
					    <tbody class="datainit" >
        					<tr ng-repeat="x in data">
	                            <td ng-cloak>
						        	{{x.driver.name}}
						        </td>
								<td ng-cloak>
						        	{{x.car.carnumber}}
						        </td>
								<td ng-cloak>
						        	{{x.car.cartype}}
						        </td>
						        <td ng-cloak>
									{{x.goods.goodsname}}
						        </td>
								<td ng-cloak>
									{{x.goods.freightvolume | number:3 }}吨
						        </td>
								<td ng-cloak>
									<span ng-if="x.isreload !=1" ng-cloak>{{x.oddloadweight | number:3}}</span><span ng-if="x.isreload ==1">{{x.actload | number:3}}</span>
									{{x.goods.freightunit}}
								</td>
						        <td ng-cloak>
						            {{x.ooferprice}}元/吨
						        </td>
								<td ng-cloak>
									<span class="green">{{x.statusStr}}</span>
						        </td>
						        <td ng-cloak>
						            {{x.beginCreateDate}}
						        </td>
						        <td ng-cloak>
						            <a ng-click="getObjDetail(x.id)" class="see oprate" data-toggle="modal"
									   data-target="#modal">查看</a>
						        </td>
	                        </tr>
                        </tbody>
                	</table>
                	<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                		<img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                	</div>
                	<!-- <div class="loading">
	                	<img src="/static/images/loading.gif">
					    <p>加载中</p>
				    </div> -->
					<!--分页-->
					<tm-pagination conf="paginationConf"></tm-pagination>
                </div>
			</div>
			
		</div>
	</div>
	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal"
		 style="margin:auto;overflow-y:hidden;">
		<div>
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">报价详情</h4>
				</div>
				<div class="modal-body modal-body-h" style="overflow:scroll;">
					<div class="col-sm-12">
						<table class="table table-bordered">
							<div class="form_container">
								<h4 class="panel-heading">
									报价信息
								</h4>
							</div>
							<tr>
								<td class="text-center" rowspan="3" style="vertical-align: middle;">
									<div class="col-sm-12 control-label">报价信息</div>
								</td>
								<td>
									<div class="col-sm-4">
										手机号码
									</div>
									<div class="col-sm-8" ng-cloak>
										{{detal.quoteinfo.driver.phone}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										报价吨位
									</div>
									<div class="col-sm-8" ng-cloak>
										{{detal.quoteinfo.oddloadweight}}
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="col-sm-4">
										本次报价
									</div>
									<div class="col-sm-8" ng-cloak>
										{{detal.quoteinfo.ooferprice}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										状态
									</div>
									<div class="col-sm-8" ng-cloak>
										<span class="green">{{detal.quoteinfo.statusStr}}</span>
									</div>
								</td>
							</tr>
							<tr>
								<td class="td_br_none">
									<div class="col-sm-4">
										报价时间
									</div>
									<div class="col-sm-8">
										{{detal.quoteinfo.beginCreateDate}}
									</div>
								</td>
								<td class="td_br"></td>
							</tr>
							<tr>
								<td class="text-center" rowspan="2" style="vertical-align: middle;">
									<div class="col-sm-12 control-label">车辆信息</div>
								</td>
								<td>
									<div class="col-sm-4">
										车牌号码
									</div>
									<div class="col-sm-8" ng-cloak>
										{{detal.quoteinfo.car.carnumber}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										车型
									</div>
									<div class="col-sm-8">
										{{detal.quoteinfo.car.cartype}}
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="col-sm-4">
										车长
									</div>
									<div class="col-sm-8">
										{{detal.quoteinfo.car.carlength}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										载重
									</div>
									<div class="col-sm-8">
										{{detal.quoteinfo.car.loadweight}}{{detal.quoteinfo.car.weightunit!=null?detal.quoteinfo.car.weightunit:"吨"}}
									</div>
								</td>
							</tr>
							<tr>
								<td class="text-center" rowspan="3" style="vertical-align: middle;">
									<div class="col-sm-12 control-label">货物信息</div>
								</td>
								<td>
									<div class="col-sm-4">
										货物名称
									</div>
									<div class="col-sm-8" ng-cloak>
										{{detal.goods.goodsname}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										货物数量
									</div>
									<div class="col-sm-8">
										{{detal.goods.freightvolume}} {{detal.goods.freightunit}}
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="col-sm-4">
										货物类别
									</div>
									<div class="col-sm-8">
										{{detal.goods.gsoddtype}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										货物类型
									</div>
									<div class="col-sm-8">
										{{detal.goods.goodstype}}
									</div>
								</td>
							</tr>
							<tr>
								<td class="td_br_none">
									<div class="col-sm-4">
										装车时间
									</div>
									<div class="col-sm-8">
										{{detal.sendtime}}
									</div>
								</td>
								<td class="td_br"></td>
							</tr>
							<tr>
								<td class="text-center" rowspan="4" style="vertical-align: middle;">
									<div class="col-sm-12 control-label">运输信息</div>
								</td>
								<td>
									<div class="col-sm-4">
										始发地
									</div>
									<div class="col-sm-8">
										{{detal.goods.shipAddress.province}}
										{{detal.goods.shipAddress.city}}
										{{d.goods.shipAddress.district}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										详细地址
									</div>
									<div class="col-sm-8">
										{{detal.goods.shipAddress.address}}
									</div>
								</td>
							</tr>
							<tr>
								<td class="td_br_none">
									<div class="col-sm-4">
										发货人
									</div>
									<div class="col-sm-8">
										{{detal.goods.shipAddress.linkman}}\
										{{detal.goods.shipAddress.linkmobile}}
									</div>
								</td>
								<td class="td_br"></td>
							</tr>
							<tr>
								<td>
									<div class="col-sm-4">
										目的地
									</div>
									<div class="col-sm-8">
										{{detal.goods.consignAddress.province}}
										{{detal.goods.consignAddress.city}}
										{{detal.goods.consignAddress.district}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										详细地址
									</div>
									<div class="col-sm-8">
										{{detal.goods.consignAddress.address}}
									</div>
								</td>
							</tr>
							<tr>
								<td class="td_br_none">
									<div class="col-sm-4">
										收货人
									</div>
									<div class="col-sm-8">
										{{detal.goods.consignAddress.linkman}}\
										{{detal.goods.consignAddress.linkmobile}}
									</div>
								</td>
								<td class="td_br"></td>
							</tr>
							<tr>
								<td class="text-center" rowspan="4" style="vertical-align: middle;">
									<div class="col-sm-12 control-label">其他信息</div>
								</td>
								<td>
									<div class="col-sm-4">
										车型要求
									</div>
									<div class="col-sm-8">
										{{detal.bidinfo.goods.cartype}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										车长要求
									</div>
									<div class="col-sm-8">
										{{detal.bidinfo.goods.cartype}}米
									</div>
								</td>
							</tr>
							<tr>
								<td class="td_br_none">
									<div class="col-sm-4">
										运输方式
									</div>
									<div class="col-sm-8">
										{{detal.goods.transportway}}
									</div>
								</td>
								<td class="td_br"></td>
							</tr>
							<tr>
								<td>
									<div class="col-sm-4">
										货物价值
									</div>
									<div class="col-sm-8">
										{{detal.goods.worth}}
									</div>
								</td>
								<td>
									<div class="col-sm-4">
										期望价格
									</div>
									<div class="col-sm-8">
										{{detal.goods.expectedprice}}
									</div>
								</td>
							</tr>

							<tr>
								<td colspan='2'>

									<div class="col-sm-8">
										备注： {{detal.goods.remarks}}
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
 <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script>


    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
            	$("#maskloading" , parent.document).show();
                $("#noneData").hide();
                $(".no-items").html('');
            } else if (isloading == 2) {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".no-items").html('');
            } else {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
        	$("#maskloading" , parent.document).show();
            if( $scope.paginationConf.currentPage ==1){
                $scope.paginationConf.currentPage = 0;
            }else{
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'searchinfo':$("#searchinfo").val(),
                'searchinfo':  $("#quotestatus").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/goods/getQuoteInfoList',
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
        $scope.getObjDetail = function (id) {
            $http.get("${wlpt}/wlpt/goods/getQuoteDetail?id=" + id).success(function (response) {
                $scope.detal = response.data;/// 招标详情
            });
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

    }]);

    function check(){
    	var status=$("#status").val();
    	if(status!='2'){
    		$("#fabu").tips({
				side:3,
	            msg:'您还未认证！',
	            bg:'#00A2E9',
	            time:4
	        });
    		return false;
    	}
    	return true;
    }
    var bheight = document.documentElement.clientHeight;
	var bwidth = document.documentElement.clientWidth;
  //弹框
    $('#modal').css('width', bwidth*.76+'px').css('height',bheight*.8+ 'px');
    $('.modal-body-h').css('height', bheight*.8+ 'px');
</script>
</body>
</html>
