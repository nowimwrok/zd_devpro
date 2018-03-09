<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn" ng-app="publishApp" ng-controller="publishCtrl">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>发布招标</title>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
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
            width: 23%;
        }

        .fabu_infor_right {
            width: 30%;
        }
    </style>
</head>
<body>

<form:form id="inputForm" modelAttribute="bidinfo" action="${wlpt}/wlpt/bid/bidSave" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>

    <div class="tab_fir tab-all">
        <p class="user_data">
            <img src="${ctxStatic}/images/wlptfront/line-left.png">
            <span class="title_blue">招标</span>
            <span class="title_orange">发布</span>
            <img src="${ctxStatic}/images/wlptfront/line-right.png">
        </p>
        <table class="user-infor">
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>货物名称：</td>
                <td class="fabu_infor_right" colspan=3>
                    <input id="gdsname" type="text" value="" style="width:68%;" name="goods.goodsname">
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">货物类别：</td>
                <td class="fabu_infor_right" colspan=3>
                	<input type="hidden" value="${goods.goodstype}" name="goodstype" id="goodstype">
                	<form:select id="gsoddtype" name="gsoddtype" path="goods.gsoddtype" onchange="change();">
                        <form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                   <%--  <form:radiobuttons path="goods.goodstype" id="goodstype" items="${fns:getDictList('goodstype')}"
                                       itemLabel="label" itemValue="value" delimiter="&nbsp;"/> --%>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">是否开发票：</td>
                <td class="fabu_infor_right" colspan=3>
                    <form:radiobuttons path="isbill" items="${fns:getDictList('yesorno')}" itemLabel="label"
                                       itemValue="value" delimiter="&nbsp;" accesskey=""/>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span><span id="danwei">重量：</span></td>
                <td class="fabu_infor_right">
                	<input id="freightunit" name="goods.freightunit" value="${goods.freightunit}" type="hidden"  />
                    <input id="freightvolume" type="text" name="goods.freightvolume" ng-model="freightvolume" onchange="setprice();">  <span id="a">吨</span>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>拦标价：</td>
                <td class="fabu_infor_right"><input id="expectedprice" type="text" name="expectedprice" onchange="setprice();"  /> <span id="b">元/吨</span></td>
            </tr>
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>整标价：</td>
                <td class="fabu_infor_right"><input id="price" type="text" readonly="readonly" > <span id="c">元</span></td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>始发地：</td>
                <td class="fabu_infor_right">
                    <input name="goods.shipAddress.type" value="0" type="hidden">
                    <input id="fromprovince" name="goods.shipAddress.province" type="hidden">
                    <input id="fromcity" name="goods.shipAddress.city" type="hidden">
                    <input id="fromdistrict" name="goods.shipAddress.district" type="hidden">
                    <input type="text" name="fromAddress" id="fromAddress" readonly="readonly" placeholder="请选择出发地"/>
                </td>
                <td class="col2_left">详细地址：</td>
                <td class="cols_right">
                    <input id="shipAdd" name="goods.shipAddress.address" type="text" placeholder="详细地址">
                </td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>目的地：</td>
                <td class="fabu_infor_right">
                    <input name="goods.consignAddress.type" value="1" type="hidden">
                    <input id="toprovince" name="goods.consignAddress.province" type="hidden">
                    <input id="tocity" name="goods.consignAddress.city" type="hidden">
                    <input id="todistrict" name="goods.consignAddress.district" type="hidden">
                    <input type="text" name="toAddress" id="toAddress" readonly="readonly" placeholder="请选择出发地"/>
                </td>
                <td class="col2_left">详细地址：</td>
                <td class="cols_right">
                    <input id="consignAdd" name="goods.consignAddress.address" type="text" placeholder="详细地址">
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">车型要求：</td>
                <td class="fabu_infor_right">
                    <input id="cartype" name="goods.cartype" readonly="readonly" type="text"/>
                </td>
                <td class="col2_left">车长要求：</td>
                <td class="cols_right"><input id="carlength" type="text" maxlenght="2" name="goods.carlength"> 米</td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>截止时间：</td>
                <td class="fabu_infor_right">
                    <input type="text" name="endtime"
                           id="endtime" readonly="readonly"
                           class="Wdate"
                           style="height: 28px;"
                           value="<fmt:formatDate value="${result.data.DEPARTURETIME }" pattern="yyyy-MM-dd HH:mm"/>"
                           onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate: '%y-%M-%d %H:%m' })">
                </td>
                <td class="col2_left"></td>
                <td class="cols_right"></td>
            </tr>

            <tr>
                <td class="user_infor_left">结算计时：</td>
                <td class="fabu_infor_right">
                    <form:select path="settlementtype" class="input-xlarge ">
                        <form:options items="${fns:getDictList('settlement_type')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </td>
                <td class="col2_left"><span class="star_red">*</span>结算周期：</td>
                <td class="cols_right">
                    <input id="settlementperiod" name="settlementperiod" type="text"> 天
                </td>
            </tr>

            <tr>
                <td class="user_infor_left" style="vertical-align:top;">备注：</td>
                <td colspan="3" class="textarea_left">
                    <textarea class="textarea_in" name="remarks" placeholder="在这里填入需要补充的内容"></textarea>
                </td>
            </tr>

            <tr>
                <td colspan=5>
                    <button type='button' class="btn btn-defalut btn-warning" id="btn-warning" value="保 存"
                            ng-click="upload()">保 存
                    </button>
                </td>
            </tr>
        </table>
    </div>
</form:form>

<div class="tab-thre tab-all">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png">
        <span class="title_blue">提货单</span>
        <span class="title_orange">列表</span>
        <img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div>
        <form action="${wlpt}/wlpt/bid/import" method="post">
            <p>
                <label>请选择提货单文件： {{fileInfo.name}} </label>
                <button class="btn btn-defalut btn-warning btn-sm" ngf-select ng-model="file" name="file"
                        ngf-pattern="application/msexcel" accept="application/msexcel"
                        ngf-min-height="100">选 择
                </button>
                <button class="btn btn-defalut btn-warning btn-sm" ng-click="uploadBl()" type="button">上 传</button>
                <button id="refreshButton" type="button" class="btn btn-defalut btn-warning btn-sm"
                        style="text-align: right;margin: 5px;" ng-click="refreshData()">查 询
                </button>
                <a class="btn btn-defalut btn-warning btn-sm" href="${ctxStatic }/template/上传模板.xls">下载模板</a>
            </p>
        </form>
        <div class="loading"><img src="/static/images/loading.gif">
            <p>加载中</p></div>
        <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns
             class="grid"></div>
    </div>
</div>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>


<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/global.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload-shim.min.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload.min.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">
    $(".loading").hide();
    change();
    function change() {
        var gsoddtype = $("#gsoddtype").val();
        var result1;
        var result2;
        var result3;
        if (gsoddtype == '0') {
            result1 = '方';
            result2 = '元/方';
            result3 = '体积：';
            $("#goodstype").val("0");
        } else {
            result1 = '吨';
            result2 = '元/吨';
            result3= '重量：';
            $("#goodstype").val("1");
        }
        $("#a").html(result1);
        $("#b").html(result2);
        $("#danwei").html(result3);
        $("#freightunit").val(result1);
    }
    ///线上支付
    function setprice() {
    	var freightvolume = $("#freightvolume").val()*1;
    	var expectedprice = $("#expectedprice").val()*1;
    	///线下支付总金额
        var lineAmount = freightvolume * expectedprice;
        lineAmount = xround(lineAmount, 2);
        $("#price").val(lineAmount);
    }
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

    var app = angular.module('publishApp', ['ngFileUpload', 'ui.grid', 'ui.grid.selection', 'ui.grid.grouping', 'ui.grid.pagination', 'ui.grid.resizeColumns', 'ui.grid.autoResize']);
    app.controller('publishCtrl', ['$scope', 'Upload', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
        function ($scope, Upload, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {
            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.freightvolume = 0;
            $scope.imporDate = [];
            $scope.bgrid={};

            $scope.uploadBl = function () {
                $(".loading").show();

                $scope.fileInfo = $scope.file;
                Upload.upload({
                    //服务端接收
                    url: '${wlpt}/wlpt/bid/import',
                    //上传的同时带的参数
                    file: $scope.file
                }).progress(function (evt) {
                    //进度条
                    var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                    console.log('progess:' + progressPercentage + '%' + evt.config.file.name);
                }).success(function (data, status, headers, config) {
                    $(".loading").hide();
                    $scope.callsPending--;
                    data.value.forEach(function (row) {
                        var b = true;
                        $scope.imporDate.forEach(function (r) {
                            if (r.entity == row.entity) {
                                b = false
                            }
                        });
                        if (b) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        }
                    });

                    $scope.imporDate = data.value;
                    //上传成功
                    console.log('file ' + config.file.name + 'uploaded. Response: ' + data);
                }).error(function (data, status, headers, config) {
                    //上传失败
                    console.log('error status: ' + status);
                });
            };

            $scope.gridOptions.rowIdentity = function (row) {
                return row.id;
            };

            $scope.gridOptions.getRowIdentity = function (row) {
                return row.id;
            };

            $scope.gridOptions.onRegisterApi = function (grid, newObjects) {
                $scope.bgrid = grid;
                if (newObjects) {
                    $scope.callsPending--;
                    newObjects.forEach(function (row) {
                        row.registered = new Date(row.registered);
                        $scope.myData.push(row);
                    });
                }

                //行选中事件
                $scope.bgrid.selection.on.rowSelectionChanged($scope, function (row, event) {

                    if ($scope.bgrid.selection.getSelectedCount() == 0) {
                        document.getElementById('freightvolume').readOnly = false;
                    }

                    if (row.isSelected) {
                        if ($scope.bgrid.selection.getSelectedCount() >= 1) {
                            /* $scope.freightvolume = 0; */
                            document.getElementById('freightvolume').readOnly = true;
                        }
                        $scope.freightvolume = accAdd($scope.freightvolume, Number(row.entity.quantity));
                    } else {
                        $scope.freightvolume = accSub($scope.freightvolume, Number(row.entity.quantity));
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {

                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                        	document.getElementById('freightvolume').readOnly = true;
                            $scope.freightvolume = accAdd($scope.freightvolume, Number(r.entity.quantity));
                        });
                    } else {
                        $scope.freightvolume = 0;
                        document.getElementById('freightvolume').readOnly = false;
                    }
                });

            };

            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'contractno', displayName: '提货单号'},
                {name: 'batch', displayName: '批次号'},
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
            var i = 0;

            $scope.upload = function () {
                var isnul = true;
                isnul = isnul && $("#gdsname").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#freightvolume").valid({
                            methods: "required|isdecimal"
                        });
                isnul = isnul && $("#settlementperiod").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#expectedprice").valid({
                            methods: "required|isdecimal"
                        });
                isnul = isnul && $("#fromAddress").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#shipAdd").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#toAddress").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#endtime").valid({
                            methods: "required"
                        });
                isnul = isnul && $("#settlementperiod").valid({
                            methods: "required|isNum"
                        });
                isnul = isnul && $("#consignAdd").valid({
                            methods: "required"
                        });
                if ($("#fromcity").val() == "" || $("#fromcity").val() == null) {
                    $("#fromAddress").tips({
                        side: 3,
                        msg: '请选择城市',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if ($("#tocity").val() == "" || $("#tocity").val() == null) {
                    $("#toAddress").tips({
                        side: 3,
                        msg: '请选择城市',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if ($("#freightvolume").val() <= 0) {
                    $("#freightvolume").tips({
                        side: 3,
                        msg: '重量不能小于等于0',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if ($("#expectedprice").val() <= 0) {
                    $("#expectedprice").tips({
                        side: 3,
                        msg: '拦标价不能小于等于0',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if ($("#carlength").val() != "" && $("#carlength").val() != null) {
                    isnul = isnul && $("#carlength").valid({
                                methods: "isdecimal"
                            });
                }

                if ($(".loading").is(':hidden') && isnul) {
                    $(".loading").show();
                } else {
                    return false;
                }

                var inputForm = $("#inputForm").serializeObject();
                inputForm.blinfoList=angular.toJson($scope.bgrid.selection.getSelectedRows());
                $.ajax({
                    url: '${wlpt}/wlpt/bid/bidSave',
                    method: 'post',
                    data: inputForm
                }).success(function (data) {
                    if (data = 1) {
                        window.location.href = '${wlpt}/wlpt/bid/myBid';
                    } else {
                        window.location.href = "${wlpt}/login";
                    }
                });
            };

            $scope.refreshData = function () {
                $scope.freightvolume = 0;
                $scope.myData = [];
                $scope.imporDate = [];
                var start = new Date();
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: {
                            blstatus: 1
                        }
                    }).success(function (data) {
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
        }]);

    $("#fromAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            $("#fromAddress").val(str);
        }
    });

    $("#toAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#toprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            $("#toAddress").val(str);
        }
    });
    getCarType();
    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }


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


    ///单选按钮第一个值选择
    $('#goodstype1').attr('checked', 'checked');
    $('#isbill1').attr('checked', 'checked');

</script>
</body>
</html>
