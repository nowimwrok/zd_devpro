<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
<title>油气兑换余额申请列表</title>
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
    </style>

<script type="text/javascript">
        $(function () {
            $("#btnExport").click(function () {

                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/export");
                $("#searchForm").submit();
                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/toPurse");

                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });
        });
    </script>

</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">余额兑换</h4>
                </div>	
                <div class="panel-body">
                	<div class="col-lg-12 search_wrap">
	                	<form:form id="searchForm" modelAttribute="consumerecod"
							action="${wlpt}/wlpt/consume/getMetroPosList" method="post">
							<div class="col-sm-2">
								<input type="text" readonly="readonly" class="form-control"
								 name="beginCreateDate" id="beginCreateDate"
								placeholder="选择开始时间"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							</div>
							<div class="col-sm-2">	
								<input type="text" readonly="readonly" class="form-control"
								 name="endCreateDate" id="endCreateDate"
								placeholder="选择结束时间"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> 
                                 
                             </div>
                             <div class="col-sm-6 text-left">
                                  <button class="btn btn-primary" type="button" ng-click="searchInfo()">
                                      <i class="fa fa-search white"></i> 查询
                                  </button>
                                  <a class="btn btn-success" id="fabu" href="${wlpt}/wlpt/petrolexchange/toApplyPetrolExchange"
                                      >
                                      <i class="fa fa-plus-square white"> </i> 申请兑换
                                  </a>
                              </div>
						</form:form>
					</div>
					<div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>兑换号</th>
                                <th>兑换金额</th>
                                <th>兑换条数</th>
                                <th>状态</th>
                                <th>申请时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>{{x.exchangeNo}}</td>
								<td ng-cloak>{{x.totalcost}}</td>
								<td ng-cloak>
									{{x.exchangeCount}}
								</td>
								<td ng-cloak>{{x.statusName}}<span ng-if="(x.status==4) && x.invoiceStatusName != ''">&nbsp;|&nbsp;{{x.invoiceStatusName}}</span></td>
								<td ng-cloak>{{x.createDate}}</td>
                                <td ng-cloak>
                                    <a href="${wlpt}/wlpt/petrolexchange/toPetrolExchangeInfo?id={{x.id}}" target="content"
                                   class="see oprate">查看</a>
                
                    				<a ng-if="(x.status==4) && (x.invoiceStatus !=2 && x.invoiceStatus!=1 )" href="javascript:;" ng-click="editInvoiceStatus(x.id)" class="green oprate">已开发票</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
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
</div>

	<script type="text/javascript" src="/static/jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
	<script type="text/javascript"
		src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
	<script
		src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
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
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
            		'beginOperateDate': $("#beginCreateDate").val(),
                    'endOperateDate': $("#endCreateDate").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/petrolexchange/getPetrolExchangeList',
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
        
        
        $scope.editInvoiceStatus = function (id) {
        	
            if (id == null || id == "") {
                return;
            }
            $.MsgBox.Confirm("开票提示","确定已开发票,是否继续操作?",function(){
            	$("#maskloading" , parent.document).show();
                $.ajax({
                    url: "${wlpt}/wlpt/petrolexchange/editInvoiceStatus",
                    method: 'post',
                    data: {
                        id: id,
                        invoiceStatus:1
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                    	if(data.value==1){
                    		$.MsgBox.Alert("开票提示","操作成功");
                    		
                    	}else{
                    		$.MsgBox.Alert("开票提示","操作失败");
                    		
                    	}
                        
                    	$("#maskloading" , parent.document).hide();
                        GetAllEmployee();
                    }
                });
            },function(){
            	$("#maskloading" , parent.document).hide();
            },null,null,"是","否");

        };
       
	}]);

</script>
</body>
</html>
