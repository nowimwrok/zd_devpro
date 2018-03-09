<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn" ng-app="oPublishApp" ng-controller="oPublishCtrl">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>合同发布货源</title>

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

<div class="tab_fir tab-all">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">招标</span><span
            class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>

    <div class="tender_details" style="border:1px solid #ccc;padding-top: 20px;">
        <table class="user-infor">
            <tr>
                <td class="user_infor_left">招标文号：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.bidcode}
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">发布人：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.biduser.loginName}
                </td>
                <td class="col2_left">招标状态：</td>
                <td class="cols_right">
                    <strong class="red_num">${fns:getDictLabel(bidinfo.bidstatus, 'bid_status', '')}</strong>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">招标货物：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.goods.goodsname}
                </td>
                <td class="col2_left">货物数量：</td>
                <td class="cols_right">${bidinfo.goods.freightvolume} ${bidinfo.goods.freightunit}</td>
            </tr>

            <tr>
                <td class="user_infor_left">发布时间：</td>

                <td class="fabu_infor_right">
                    ${bidinfo.publishtimeFM}
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">需求车型：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.goods.cartype}
                </td>
                <td class="col2_left">车长要求：</td>
                <td class="cols_right">${bidinfo.goods.carlength} ${bidinfo.goods.lengthunit}</td>
            </tr>

            <tr>
                <td class="user_infor_left">始发地：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.goods.shipAddress.province} ${bidinfo.goods.shipAddress.city} ${bidinfo.goods.shipAddress.district}
                </td>
                <td class="col2_left"></td>
                <td class="cols_right"></td>
            </tr>

            <tr>
                <td class="user_infor_left">目的地：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.goods.consignAddress.province} ${bidinfo.goods.consignAddress.city} ${bidinfo.goods.consignAddress.district}
                </td>
                <td class="col2_left"></td>
                <td class="cols_right"></td>
            </tr>

            <tr>
                <td class="user_infor_left">备注：</td>
                <td class="fabu_infor_right">
                    ${bidinfo.remarks}
                </td>
                <td class="col2_left"></td>
                <td class="cols_right"></td>
            </tr>

        </table>
    </div>
</div>


<div class="tab-sec tab-all">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货源</span><span
            class="title_orange">发布</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <form id="inputForm">
        <label>货源吨位 </label>
        <input type="hidden" name="bidOrder.id" value="${bidOrder.id}">
        <input type="hidden" name="orderId" value="${bidOrder.id}">
        <input type="hidden" name="id" value="${bidinfo.goods.id}">
        <input type="hidden" name="tradestatus" value="${blTradeStatus}">
		<input type="hidden" id="blinfoList" name="blinfoList" />
        <c:if test="${bidinfo.isupbl==0}">
            <input type="text" style="margin: 5px;" id="freightvolume" ng-model="freightvolume" name="freightvolume"/>
        </c:if>
        <c:if test="${bidinfo.isupbl==1}">
            <input type="text" style="margin: 5px;" id="freightvolume" ng-model="freightvolume" readonly
                   name="freightvolume"/>
        </c:if>
        <div class="loading"><img src="/static/images/loading.gif">
            <p>加载中</p></div>
        <div ng-if="${bidinfo.isupbl==1}">

            <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns
                 class="grid"></div>
        </div>
        <table class="user-infor">
            <tr>
                <td colspan=5>
                    <button type='button' class="btn btn-defalut btn-warning" id="btn-warning" ng-click="submit()">
                        发布货源
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

            <c:if test="${bidinfo.isupbl==0}">
            $scope.submit = function () {
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

                if ($("#freightvolume").val() >${bidinfo.goods.residualvolume}) {
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
                $("#inputForm").attr("action","${wlpt}/wlpt/goods/toSave");
				$("#inputForm").submit();
                /* $http({
                    url: '${wlpt}/wlpt/goods/toSave',
                    method: 'post',
                    params: $("#inputForm").serializeObject()
                }).success(function (response) {
                    $(document.body).html(response);
                }); */
            };
            </c:if>

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
                }

                if ($(".loading").is(':hidden')) {
                    $(".loading").show();
                } else {
                    return false;
                }
				$("#blinfoList").val(angular.toJson($scope.bgrid.selection.getSelectedRows()));
                $("#inputForm").attr("action","${wlpt}/wlpt/goods/toSave");
				$("#inputForm").submit();
                /* var inputForm = $("#inputForm").serializeObject();
                inputForm.blinfoList=angular.toJson($scope.bgrid.selection.getSelectedRows());
                $.ajax({
                    url: '${wlpt}/wlpt/goods/toSave',
                    method: 'post',
                    data: inputForm
                }).success(function (response) {
                    $(document.body).html(response);
                }); */
            };

            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'contractno', displayName: '提货单号'},
                {name: 'namematerials', displayName: '品名材质'},
                {name: 'standard', displayName: '规格'},
                {name: 'width', displayName: '定尺\\板宽'},
                {
                    name: 'quantity',
                    displayName: '数量\\吨'
                },
                {name: 'batch', displayName: '批次号'},
                {name: 'address', displayName: '卸货地址'},
                {name: 'remarks', displayName: '备注'}
            ];

            $scope.callsPending = 0;

            $scope.refreshData = function () {
                $(".loading").show();
                $scope.myData = [];
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: $("#inputForm").serializeObject()
                    }).success(function (data) {
                        $scope.callsPending--;
                        data.value.forEach(function (row) {
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
            </c:if>
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

