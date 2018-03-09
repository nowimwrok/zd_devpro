<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn" ng-app="oPublishApp" ng-controller="oPublishCtrl">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>油气兑换申请</title>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
    <style type="text/css">

        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
        }

        .user_infor_left {
            width: 25%;
        }

        .fabu_infor_right {
            width: 30%;
        }

    </style>
</head>
<body>

<div class="tab-sec tab-all">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">油气</span><span
            class="title_orange">兑换</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <form id="inputForm">
    	<div class="select_title" style="margin: 0px; padding: 0px;">
			<input type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="beginCreateDate" id="beginCreateDate"
				placeholder="选择开始时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> —— <input
				type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="endCreateDate" id="endCreateDate"
				placeholder="选择结束时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> 
			<button type="button" style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;border-color:#FFC52F;margin-left:15px;background-color:#FFC52F;margin-right:30px;"
                class="btn btn-warning"
				ng-click="refreshData()">
				<span class="glyphicon glyphicon-search"></span><span
					class="goods_search_btn">搜索</span>
			</button>
			
		</div>
        <label>兑换金额 </label>

            <input type="text" style="margin: 5px;" id="totalcost" ng-model="totalcost" name="totalcost" readonly="readonly"/>
         <label>总条数 </label>

            <input type="text" style="margin: 5px;" id="exchangeCount" ng-model="exchangeCount" name="exchangeCount" readonly="readonly"/>
       
        <div class="loading"><img src="/static/images/loading.gif">
            <p>加载中</p></div>
        <div >

            <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns
                 class="grid"></div>
        </div>
        <table class="user-infor">
        
            <tr>
                <td colspan=5>
                    <button type='button' style="width:150px;" class="btn btn-defalut btn-warning" id="btn-warning" ng-click="submit()">
                        立即兑换
                    </button>
                    &nbsp;
                    <button type='button' style="width:150px;" class="btn btn-defalut btn-warning" id="btn-warning" onclick="history.go(-1)">
                        返回
                    </button>
                    
                </td>
            </tr>
        </table>

    </form>
</div>

<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>
<script src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>


<script>

    $(".loading").hide();


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

                if ($(".loading").is(':hidden')) {
                    $(".loading").show();
                } else {
                    return false;
                }
                var inputForm = $("#inputForm").serializeObject();
                inputForm.cardRecordList=angular.toJson($scope.bgrid.selection.getSelectedRows());
                $.ajax({
                    url: '${wlpt}/wlpt/petrolexchange/petrolexchangeSave',
                    method: 'post',
                    data: inputForm
                }).success(function (response) {
                	window.location.href = '${wlpt}/wlpt/petrolexchange/myPetrolExchangeList';
                });
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
                $(".loading").show();
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
                        data.value.list.forEach(function (row) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        });
                        $(".loading").hide();
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

