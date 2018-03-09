<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
   <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
    <title>合同招标明细</title>
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
        .ui-grid-header-cell-wrapper {
		    position: relative;
		    display: table;
		    box-sizing: border-box;
		    height: 60px!important;
		}
		.ui-grid-icon-ok:before {
	        content: '\c362';
	        color: #ffffff!important;
	        background-color: rgba(17, 222, 33, 0.82)!important;
	    }
	    .tabale_div .col-sm-2 {
		    text-align: center;
		    color: #838080;
		    width: 100%;
		}
    	.tabale_div .col-sm-3 {
		    border-right: 1px solid #ccc;
		}
		.tabale_div .col-sm-3, .tabale_div .col-sm-9 {
		    height: 45px;
		    line-height: 45px;
		}
		.tabale_div td {
	        padding-top: 0px !important;
		    padding-bottom: 0px !important;
		    height: 45px;
		    border: 1px solid #ccc !important;
		}	
		.td_width_40{
			width:40%;
		}
		.td_width_20{
			width:20%;
		}
    </style>
    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
</head>
<body style="background: #f5f5f5;">

<div ng-app="oPublishApp" ng-controller="oPublishCtrl">
    <div class="row">
        <div class="col-lg-12">
            <input id="gsid" name="id" value="${goods.id}" type="hidden"/>
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        招标信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                    	<table class="table table-bordered tabale_div">
                        <tr>
                           	<td class="text-center td_width_20" rowspan="2" style="vertical-align: middle;">
                            <div class="col-sm-2 text-right"><strong>招标信息</strong></div>
                            </td>
                            <td class="td_width_40">
                                
                                 <div class="col-sm-3 text-right detList_tt">招标文号</div>
                                 <div class="col-sm-9 text-left detList_con"
                                      style=" font-size: 18px; font-weight: bolder ; color: red;"> ${bidinfo.bidcode}</div>
                                 
                                
                             </td>
                             <td class="td_width_40">
                                <div class="col-sm-3 text-right detList_tt">发布方</div>
                                <div class="col-sm-9 text-left detList_con"> ${bidinfo.biduser.loginName}</div>
                             </td>
                         </tr>
                         <tr>
                         	<td>
                                <div class="col-sm-3 text-right detList_tt">联系方式</div>
                                <div class="col-sm-9 text-left detList_con"> ${bidinfo.biduser.phone}</div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">招标状态</div>
                                <div class="col-sm-9 text-left detList_con"
                                     style="color: darkgreen;">${fns:getDictLabel(bidinfo.bidstatus, 'bid_status', '')}</div>
                            </td>
                        </tr>

                        <tr>
                           	<td class="text-center td_width_20" rowspan="2" style="vertical-align: middle;">
                            	<div class="col-sm-2 text-right"><strong>货物信息</strong></div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">招标货物</div>
                                <div class="col-sm-9 text-left detList_con">${bidinfo.goods.goodsname}</div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">货物数量</div>
                                <div class="col-sm-9 text-left detList_con">${bidinfo.goods.freightvolume} ${bidinfo.goods.freightunit}</div>
                            </td>
                         </tr>
                         <tr>
                         	<td>
                                <div class="col-sm-3 text-right detList_tt">发布时间</div>
                                <div class="col-sm-9 text-left detList_con">
                                    ${bidinfo.publishtimeFM}<%--
                                 <c:if test="${goods.goodstype == '0'}">轻货</c:if>
                                 <c:if test="${goods.goodstype == '1'}">重货</c:if>--%>
                                </div>
                            
                        	</td>
                        	<td>
                                <div class="col-sm-3 text-right detList_tt"></div>
                                <div class="col-sm-9 text-left detList_con"></div>
                        	</td>
                        </tr>

                        <tr>
                           	<td class="text-center td_width_20"  style="vertical-align: middle;">
                            	<div class="col-sm-2 text-right"><strong>地址信息</strong></div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">始发地</div>
                                <div class="col-sm-9 text-left detList_con">${bidinfo.goods.shipAddress.province} ${bidinfo.goods.shipAddress.city} ${bidinfo.goods.shipAddress.district}</div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">目的地</div>
                                <div class="col-sm-9 text-left detList_con">${bidinfo.goods.consignAddress.province} ${bidinfo.goods.consignAddress.city} ${bidinfo.goods.consignAddress.district}</div>
                            </td>
                        </tr>
                        <tr>
                           	<td class="text-center td_width_20" style="vertical-align: middle;">
                            	<div class="col-sm-2 text-right"><strong>车辆要求</strong></div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">车型要求</div>
                                <div class="col-sm-9 text-left detList_con">${bidinfo.goods.cartype}</div>
                            </td>
                            <td>
                                <div class="col-sm-3 text-right detList_tt">车长要求</div>
                                <div class="col-sm-9 text-left detList_con">${not emptybidinfo.goods.carlength?bidinfo.goods.carlength:"不限"}${not empty bidinfo.goods.carlength?"米":""}</div>
                            </td>
                        </tr>
                        <tr>
                           	<td class="text-center td_width_20" style="vertical-align: middle;">
                            	<div class="col-sm-2 text-right"><strong>补充说明</strong></div>
                            </td>
                            <td >
	                            <div class="col-sm-10  goods_details">
	                                ${bidinfo.goods.remarks }
	                            </div>
                            </td>
                            <td>
	                            <div class="col-sm-10  goods_details">
	                            </div>
                            </td>
                        </tr>
                    </table>
                    </div>
                </div>
            </div>

            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        选择提货单
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <form id="inputForm" name="inputForm"  method="post">

                            <input type="hidden" name="bidOrder.id" value="${bidOrder.id}">
                            <input type="hidden" name="orderId" value="${bidOrder.id}">
                            <input type="hidden" name="id" value="${bidinfo.goods.id}">
                            <input type="hidden" name="tradestatus" value="${blTradeStatus}">
                            <input type="hidden" id="blinfoList" name="blinfoList"/>

                            <!-- <div class="loading"><img src="/static/images/loading.gif">
                                <p>加载中</p></div> -->
                            <table class="user-infor">
                                <tr>
                                    <td colspan="6"><label style=" float: left;margin-right: 20px;line-height: 40px;">货源吨位 </label>
                                        <div class="form-group" style="float:left;margin-right: 20px;"><c:if
                                                test="${bidinfo.isupbl==0}">
                                            <input type="text" style="margin: 5px;" class="form-control"
                                                   id="freightvolume"
                                                   ng-model="freightvolume"
                                                   name="freightvolume"/>

                                        </c:if>
                                            <c:if test="${bidinfo.isupbl==1}">
                                                <input type="text" style="margin: 5px;" class="form-control"
                                                       id="freightvolume" ng-model="freightvolume"
                                                       readonly
                                                       name="freightvolume"/>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td colspan="3" style="text-align: right;">
                                        <button type='button' style="margin-bottom: 5px;" class="btn btn-primary"
                                                id="btn-warning"
                                                ng-click="submit()">
                                            发布货源
                                        </button>
                                    </td>
                                </tr>
                            </table>
                            <div ng-if="${bidinfo.isupbl==1}">

                                <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection
                                     ui-grid-resize-columns
                                     class="grid"></div>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>


<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>
<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    $(function () {
        var ischekd = false;
        if ("${bidinfo.isupbl}"*1==0) {
            $('#inputForm').bootstrapValidator({
                message: 'This value is not valid',
                fields: {
                    freightvolume: {
                        message: '发布吨位不能为空',
                        trigger:"change",
                        validators: {
                            notEmpty: {
                                message: '发布吨位不能为空'
                            },
                            decimalTwo: {
                                message: '发布吨位不能小于等于0'
                            },
                            between: {
                                min:0.001,
                                max: '${bidinfo.goods.residualvolume}' * 1,
                                message: "发布吨位必须大于0小于${bidinfo.goods.residualvolume}"
                            }
                        }
                    }
                }

            });
            $("#btn-warning").on("click", function () {

                var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
                bootstrapValidator.validate();
                if (bootstrapValidator.isValid()) {
                	$("#maskloading" , parent.document).show();
                	window.location.href = "${wlpt}/wlpt/goods/toSave?" + $("#inputForm").serialize()
                   /*  $("#inputForm").attr("action", "${wlpt}/wlpt/goods/toSave");
                    $("#inputForm").submit(); */
                }

            });
        }
    });

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


            /*$scope.submit = function () {
             var isnul = true;
             isnul = isnul && $("#freightvolume").valid({
             methods: "required|isdecimal"
             });
             if ($("#freightvolume").val() <= 0) {
             $("#freightvolume").tips({
             side: 3,
             msg: '发布吨位不能小于等于0',
             bg: '#00A2E9',
             time: 4
             });
             isnul = false;
             }

             if ($("#freightvolume").val() >
            ${bidinfo.goods.residualvolume}) {
             $("#freightvolume").tips({
             side: 3,
             msg: '剩余吨位不足',
             bg: '#00A2E9',
             time: 4
             });
             isnul = false;
             }

             if ($(".loading").is(':hidden') && isnul) {
             $(".loading").show();
             } else {
             return false;
             }
             $("#inputForm").attr("action", "
            ${wlpt}/wlpt/goods/toSave");
             $("#inputForm").submit();
             };
             */

            <c:if test="${bidinfo.isupbl==1}">

            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.freightvolume = 0;


            $scope.gridOptions.onRegisterApi = function (grid, newObjects) {
                $scope.bgrid = grid;
                //行选中事件
                $scope.bgrid.selection.on.rowSelectionChanged($scope, function (row, event) {
                    if (row.isSelected) {
                        $scope.freightvolume = accAdd($scope.freightvolume, Number(row.entity.quantity));
                    } else {
                        $scope.freightvolume = accSub($scope.freightvolume, Number(row.entity.quantity));
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {
                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                            $scope.freightvolume = accAdd($scope.freightvolume, Number(r.entity.quantity));
                        });
                    } else {
                        $scope.freightvolume = 0;
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


                if ($scope.bgrid.selection.getSelectedRows().length > 15) {
                    $.MsgBox.Alert("提示", "提货单条数不能大于15条");
                    return false;
                }else if ($scope.bgrid.selection.getSelectedRows().length <=0){
                    $.MsgBox.Alert("提示", "请选择提货单");
                    return false;
                }


                if ($("#maskloading" , parent.document).is(':hidden')) {
                	$("#maskloading" , parent.document).show();
                } else {
                    return false;
                }
                $("#blinfoList").val(angular.toJson($scope.bgrid.selection.getSelectedRows()));
                $("#inputForm").attr("action", "${wlpt}/wlpt/goods/toSave");
                $("#inputForm").submit();

            };

            $scope.gridOptions.columnDefs = [
                {name: 'contractno', displayName: '提货单号'},
                {name: 'batch', displayName: '批号'},
                {name: 'namematerials', displayName: '品名材质'},
                {name: 'standard', displayName: '规格'},
                {name: 'width', displayName: '定尺\\板宽'},
                {
                    name: 'quantity',
                    displayName: '数量\\吨'
                },
                
                {name: 'address', displayName: '卸货地址'},
                {name: 'remarks', displayName: '备注'}
            ];

            $scope.callsPending = 0;

            $scope.refreshData = function () {
            	$("#maskloading" , parent.document).show();
                $scope.myData = [];
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: $("#inputForm").serializeObject()
                    }).success(function (data) {
                    	$("#maskloading" , parent.document).hide();
                        $scope.callsPending--;
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
            </c:if>
        }]);


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
