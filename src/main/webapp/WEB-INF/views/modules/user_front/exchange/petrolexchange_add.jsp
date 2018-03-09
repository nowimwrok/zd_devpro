<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>油气兑换申请</title>
	<link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
    <style type="text/css">
    .form-control{
			border: 1px solid #ccc !important;
		}
	.loading{
			text-align: center;
		}
        .bg_red:HOVER{
        	color: #fff;
        }
        .bg_red{
        	color: #fff;
        }
        .ui-grid-header-cell-wrapper {
		    position: relative;
		    display: table;
		    box-sizing: border-box;
		    height: 60px;;
		}
		.ui-grid-icon-ok:before {
	        content: '\c362';
	        color: #ffffff!important;
	        background-color: rgba(17, 222, 33, 0.82)!important;
	    }	
    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="oPublishApp" ng-controller="oPublishCtrl">
	<div class="row">
        <div class="col-lg-12" style="padding-bottom:20px;">
        	<div class="form_container">
        	<form id="inputForm">
        		<!--第一个面板-->
        		<div class="panel clearfix">
        			<h4 class="panel-heading">
        				油气兑换申请
        			</h4>
        			<div class="panel-body">
        			
	        			<div class="col-sm-12 form-horizontal">
	        				<div class="col-sm-12">
               					<div class="col-sm-3"></div>
                				<div class="col-sm-6 form-group">
                					<div class="col-sm-3 text-left">
                						<input type="text" readonly="readonly" class="form-control" 
										 name="beginCreateDate" id="beginCreateDate"
										placeholder="选择开始时间"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                					</div>
                					<div class="col-sm-1" style="height:1px;background-color:#999;position:relative;top:16px">
                						
                					</div>
                					<div class="col-sm-3 text-left">
                						<input type="text" readonly="readonly" class="form-control"
										 name="endCreateDate" id="endCreateDate"
										placeholder="选择结束时间"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> 
                					</div>
                					<div class="col-sm-3">
                						<button class="btn col-sm-12 btn-primary" ng-click="refreshData()">查询</button>
                					</div>
                				</div>
               				</div>
               				<div class="col-sm-12" style="margin-top:10px;">
               					<div class="col-sm-3"></div>
               					<div class="col-sm-6 form-group">
               						<div class="col-sm-2 control-label text-right" style="">
               							兑换金额
               						</div>
               						<div class="col-sm-3 text-left">
               							<input type="text" class="form-control" ng-model="totalcost" id="contotalcost"  readonly="readonly"/>
               							<input type="hidden" class="form-control"  name="totalcost" id="totalcost" readonly="readonly"/>
               						</div>
               						<div class="col-sm-2 control-label text-right">
               							总条数
               						</div>
               						<div class="col-sm-3 text-left">
               							<input type="text" class="form-control" id="exchangeCount" ng-model="exchangeCount" name="exchangeCount" readonly="readonly"/>
               						</div>
               					</div>
               				</div>
	        			</div>
	        			<!-- <div class="loading"><img src="/static/images/loading.gif">
				            <p>加载中</p>
				        </div> -->
	        			<div class="col-sm-12 form-horizontal">
             				<div id="grid1" style="height: 500px" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns class="grid"></div>
	        			</div>
	        		
	        		</div>
        		</div>
        		<div class="col-sm-12" style="margin-bottom:80px;margin-top:20px;">
                	<div class="col-sm-2"></div>
                	<div class="col-sm-4">
                		<button class="btn btn-primary col-sm-12" type="button" id="btn-warning" ng-click="submit()">立即兑换</button>
                	</div>
                	<div class="col-sm-4">
                		<button class="btn btn-warning col-sm-12" type="button" onclick="history.go(-1)">返  回</button>
                	</div>
                </div>
                <div class="col-lg-12">
                <c:if test="${addvaluecardRecordList!=null && addvaluecardRecordList.size()>0}">
                    <div class="panel clearfix">
                        <div class="form_container">
                            <h4 class="panel-heading">
                                线下充值记录(共<span style="color: red;">${addValueTotalpaid }</span>元)
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <table class="table" id="delivery_order">
                                    <thead>
                                    <tr>
                                        <th>单据号</th>
                                        <th>会员姓名</th>
                                        <th>实付金额</th>
                                        <th>操作店面</th>
                                        <th>工号</th>
                                        <th>备注</th>
                                        <th>操作时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${addvaluecardRecordList}" varStatus="status">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].billnumber"
                                               value="${item.billnumber}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].truename"
                                               value="${item.truename}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].totalpaid"
                                               value="${item.totalpaid}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].storename"
                                               value="${item.storename}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].useraccount"
                                               value="${item.useraccount}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].meno"
                                               value="${item.meno}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].operatetime"
                                               value="${item.operatetime}">
                                        <input type="hidden" name="addvaluecardRecordList[${status.index}].id" value="${item.id}">
                                        <tr>
                                            <td>${item.billnumber}</td>
                                            <td>${item.truename}</td>
                                            <td>${item.totalpaid}</td>
                                            <td>${item.storename}</td>
                                            <td>${item.useraccount}</td>
                                            <td>${item.meno}</td>
                                            <td><fmt:formatDate value="${item.operatetime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
                </form>
        	</div>
        </div>
    </div>
</div>




<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>
<script src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>


<script>

    /* $(".loading").hide(); */


    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    var app = angular.module('oPublishApp', ['ui.grid', 'ui.grid.selection', 'ui.grid.grouping', 'ui.grid.pagination', 'ui.grid.resizeColumns', 'ui.grid.autoResize']);
    app.controller('oPublishCtrl', ['$scope', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
        function ($scope, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {

            
            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.totalcost = 0;
            $scope.exchangeCount = 0;


            $scope.gridOptions.onRegisterApi = function (grid, newObjects) {
                $scope.bgrid = grid;
                //行选中事件
                $scope.bgrid.selection.on.rowSelectionChanged($scope, function (row, event) {
                    if (row.isSelected) {
                        $scope.totalcost = accAdd($scope.totalcost, Number(row.entity.totalpaid));
                        $scope.exchangeCount = accAdd($scope.exchangeCount, Number(1));
                    } else {
                        $scope.totalcost = accSub($scope.totalcost, Number(row.entity.totalpaid));
                        $scope.exchangeCount = accSub($scope.exchangeCount, Number(1));
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {
                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                            $scope.totalcost = accAdd($scope.totalcost, Number(r.entity.totalpaid));
                            $scope.exchangeCount = accAdd($scope.exchangeCount, Number(1));
                        });
                    } else {
                        $scope.totalcost = 0;
                        $scope.exchangeCount = 0;
                    }
                });
            };

            $scope.gridOptions.rowIdentity = function (row) {
                return row.id;
            };

            $scope.gridOptions.getRowIdentity = function (row) {
                return row.id;
            };




            $scope.gridOptions.importerDataAddCallback = function (grid, newObjects) {
                if (newObjects) {
                    $scope.callsPending--;
                    newObjects.forEach(function (row) {
                        row.registered = new Date(row.registered);
                        $scope.myData.push(row);
                        
                    });
                }
            };


            $scope.submit = function () {

				
                if ($scope.bgrid.selection.getSelectedRows().length <=0) {
                    $.MsgBox.Alert("提示", "请现在消费记录");
                    return false;
                }
                
                var contotalcost = $("#contotalcost").val()*1;
                var addValueTotalpaid = '${addValueTotalpaid}'*1;
                var totalcost = contotalcost*1 - addValueTotalpaid*1;
                var titletext = "本次兑换总金额为"+totalcost+"元!确定兑换吗"
                if(addValueTotalpaid>0){
                	titletext = "消费金额为"+contotalcost+"元,减去线下充值金额为"+addValueTotalpaid+"元,本次兑换总金额为"+totalcost+"元!确定兑换吗"
                }
                $.MsgBox.Confirm("系统提示", ""+titletext+"", function () {
                	$("#maskloading" , parent.document).show();
                	$("#totalcost").val(totalcost);
	                var inputForm = $("#inputForm").serializeObject();
	                inputForm.cardRecordList=angular.toJson($scope.bgrid.selection.getSelectedRows());
	                
	                $.ajax({
	                    url: '${wlpt}/wlpt/petrolexchange/petrolexchangeSave',
	                    method: 'post',
	                    data: inputForm
	                }).success(function (response) {
	                	$("#maskloading" , parent.document).hide();
	                	window.location.href = '${wlpt}/wlpt/petrolexchange/myPetrolExchangeList';
	                });
                }, null, null, null, "是", "否");
            };

            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'billnumber', displayName: '单据号'},
                {name: 'truename', displayName: '会员姓名'},
                {name: 'recorditem.barcode', displayName: '商品编号'},
                {name: 'recorditem.gooditemname', displayName: '商品名称'},
                {name: 'recorditem.number', displayName: '商品数量'},
                {name: 'recorditem.oldprice', displayName: '商品单价'},
                {name: 'totalpaid', displayName: '实付金额'},
                
                {name: 'storename', displayName: '操作店面'},
                {name: 'useraccount', displayName: '工号'},
                {name: 'meno', displayName: '备注'},
                {name: 'operatetime', displayName: '操作时间'},
            ];

            $scope.callsPending = 0;

            $scope.refreshData = function () {
            	$scope.totalcost = 0;
                $scope.exchangeCount = 0;
                $("#maskloading" , parent.document).show();
                $scope.myData = [];
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/petrolexchange/getmcrList',
                        method: 'post',
                        params: {'beginOperateDate': $("#beginCreateDate").val(),
                            'endOperateDate': $("#endCreateDate").val()}
                    }).success(function (data) {
                        $scope.callsPending--;
                        $("#maskloading" , parent.document).hide();
                        data.value.forEach(function (row) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        });
                    });
                }, 200, 1);

                var timeout = $timeout(function () {
                    $interval.cancel(sec);
                    $scope.left = '';
                }, 2000);

                $scope.$on('$destroy', function () {
                    $timeout.cancel(timeout);
                    $interval.cancel(sec);
                });
            };
            $scope.refreshData();
        }]);

</script>


<script>


    //加法函数，用来得到精确的加法结果
    //说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
    //调用：accAdd(arg1,arg2)
    //返回值：arg1加上arg2的精确结果
    function accAdd(arg1, arg2) {
        var r1, r2, m, n;
        try {
            r1 = arg1.toString().split(".")[1].length
        } catch (e) {
            r1 = 0
        }
        try {
            r2 = arg2.toString().split(".")[1].length
        } catch (e) {
            r2 = 0
        }
        m = Math.pow(10, Math.max(r1, r2));
        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m + arg2 * m) / m).toFixed(n);
    }


    function accSub(arg1, arg2) {
        var r1, r2, m, n;
        try {
            r1 = arg1.toString().split(".")[1].length
        } catch (e) {
            r1 = 0
        }
        try {
            r2 = arg2.toString().split(".")[1].length
        } catch (e) {
            r2 = 0
        }
        m = Math.pow(10, Math.max(r1, r2));
//last modify by deeka
//动态控制精度长度
        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m - arg2 * m) / m).toFixed(n);
    }


</script>
</body>
</html>

