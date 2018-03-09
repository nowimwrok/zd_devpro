<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>积分管理</title>

    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
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
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="clearfix" style="background-color:#fff;">
                <!--积分左边-->
                <div class="pull-left points_l text-center">
                    <h3 class="text-center">我的积分</h3>
                    <!--<div class="text-center">
                        <img src="img/points.png" alt="" />
                    </div>-->
                    <p class="text-center points">${iRecord.totalValue}</p>
                </div>
                <!--积分右边-->
                <div class="pull-right points_r">
                    <div class="clearfix pointsR_up">
                        <h4 class="pull-left">积分统计<span style="color:red">平台交易，积分多多&gt;&gt;&gt;积分兑换卓币：兑换比例100:1(必须是100的整数倍)</span></h4>
                        	
                        <p class="pull-right">
                            <i class="glyphicon glyphicon-question-sign"></i>
                            <a href="" class="text-primary">什么是积分</a>
                        </p>
                    </div>
                    <ul class="clearfix pointsR_down">
                        <li class="pull-left">
                            <div>运单交易获得</div>
                            <p class="numM">+${iRecord.tradeValue}</p>
                        </li>
                        <li class="pull-left">
                            <div>商城消费获得</div>
                            <p class="numM">+${iRecord.shopValue}</p>
                        </li>
                        <li class="pull-left">
                            <div>其他获得</div>
                            <p class="numM">+${iRecord.otherValue}</p>
                        </li>
                        <li class="pull-left">
                            <div>积分消费</div>
                            <p class="numP">-${iRecord.consumeValue}</p>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="panel" style="margin-bottom:40px;">

                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                        
                            <div class="col-sm-2">
                                <input type="text"  class="form-control" id="scoreitem"
                                       placeholder="得分项">
                            </div>
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="请选择开始时间" name="beginCreateDate"
                                       id="beginCreateDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                            </div>
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="请选择结束时间" name="endCreateDate"
                                       id="endCreateDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
                            </div>
                            
                            <div class="col-sm-2">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i>
                                    	查询
                                </button>
                            </div>
							<div class="col-sm-2">	
								<input  id="exchangeIntegral"  placeholder="请输入兑换积分"  class="form-control"  type="text">	<p   id="exchangespan"></p>
								
							</div>
							<div class="col-sm-2">	
                                <button type="button" name="exchange-btn" id="exchange-btn" onclick="exchange()"
                                        class="btn btn-primary"><i class=""></i>
                                    	积分兑换卓币
                                </button>
							</div>
                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>得分项</th>
                                <th>本次得分</th>
                                <th>描述</th>
                                <th>时间</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    {{x.standarditems.scoreitem}}
                                </td>
                                <td ng-cloak ng-show="x.standarditems.scoreitem!='积分兑换'">
                                    <strong style="color: green; font-weight: bold;">+</strong>
                                    {{x.pointvalue}}分
                                </td>
                                <td ng-cloak ng-show="x.standarditems.scoreitem=='积分兑换'">
                                    {{x.pointvalue}}分
                                </td>
                                <td ng-cloak ng-show="x.standarditems.scoreitem!='积分兑换'">
                                    {{x.standarditems.scoreitem}}获得{{x.pointvalue}}分
                                </td>
                                 <td ng-cloak ng-show="x.standarditems.scoreitem=='积分兑换'">
                                    {{x.standarditems.scoreitem}}扣除{{x.pointvalue}}分
                                </td>
                                <td ng-cloak>
                                    {{x.ymdDate}}
                                </td>

                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>

                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>

        </div>
    </div>

</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script
        src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    $("#maskloading" , parent.document).hide();
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
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
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
                "beginCreateDate":$("#beginCreateDate").val(),
                "endCreateDate":$("#endCreateDate").val(),
                'standarditems.scoreitem': $("#scoreitem").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/integrity/getIntegrityRecordList',
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
        /***************************************************************
		         当页码和页面记录数发生变化时监控后台查询
		         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);
    }]);

    
    var exchange=function(){
    	var integral=$("#exchangeIntegral").val();
    	var integrals=integral%100;
    	var jsonstr={integral:integral};
    	if(integral!=0 && integrals==0){
    		$.ajax({
    	          url: "${wlpt}/wlpt/integrity/exchangeIntegral",
    	          data: jsonstr,
    	          dataType: "json",
    	          contentType:'charset=UTF-8',
    	             success: function(data){
    	            	 alert(data);
    	             },
    				error:function(xhr){alert(xhr.responseText)}
    		});
    		
    	}else{
    		alert("请输入大于0且是100的整数倍的数字");
    	}
    };
    $(document).ready(function(){
	    $("#exchangeIntegral").mouseout(function(){
	    	  var integral=$("#exchangeIntegral").val();
	    	  if(integral%100==0){
		    	  $("#exchangespan").css("background-color","red");
		    	  $("#exchangespan").html("可获得"+integral/100+"卓币");
	    	  }else{
	    		  $("#exchangespan").html("可获得必须大于100的整数且是100的整数倍");
	    	  }
	    	});
    });
    
    
</script>
</body>
</html>
