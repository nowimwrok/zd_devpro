<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
    <!-- <meta name="decorator" content="site_personal_basic"/> -->
    <title>发布招标</title>

    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
    <style type="text/css">
        .form-control {
            border: 1px solid #ccc !important;
        }

        .loading {
            text-align: center;
        }

        .loadings {
            text-align: center;
        }

        .loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .row{width:90%;margin:0 auto;margin-top:20px;padding-top:15px;box-shadow:0 0 15px rgba(0,0,0,.3);
        -webkit-box-shadow:0 0 15px rgba(0,0,0,.3);-moz-box-shadow:0 0 15px rgba(0,0,0,.3);-o-box-shadow:0 0 15px rgba(0,0,0,.3);}
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
    	.thingList{width:10%;}
    	@media (max-width:1300px){
    		.row{width:99%;}
    		.form-group .control-label{padding:7px 2px;}
    		.form-group .col-sm-7{padding:0 3px;}
    		.form-group .col-sm-7 .form-control{padding:6px 5px;}
    		.has-js .col-sm-7{padding:0 10px;}
    		.thingList{width:16%;}
    	}
    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="publishApp" ng-controller="publishCtrl">
    <!--两列-->
    <div class="row">
        <div class="col-sm-12" style="padding-bottom:20px;">
            <!--详细内容-->
            <form:form id="inputForm" name="inputForm" modelAttribute="bidinfo" action="${wlpt}/wlpt/bid/bidSave"
                       method="post"
                       class="form-horizontal">
                <form:hidden path="id"/>
                <div class="form_container">
                    <!--第一个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">
                            货物信息(<span class="red">*</span>为必填项)
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>货物名称
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="gdsname" type="text" value="" name="goods.goodsname"
                                           placeholder="请输入货物名称" class="form-control">
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>货物<span id="danwei">重量</span>
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="freightunit" name="goods.freightunit" value="${goods.freightunit}"
                                           type="hidden"/>
                                    <input id="freightvolume" type="text" name="goods.freightvolume"
                                           ng-model="freightvolume" onchange="setprice();" class="form-control">
                                    <span class="unit" id="a">吨</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">
                                    货物类别
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="hidden" value="${goods.goodstype}" name="goodstype" id="goodstype">
                                    <form:select id="gsoddtype" name="gsoddtype" path="goods.gsoddtype"
                                                 onchange="change();" class="form-control">
                                        <form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label"
                                                      itemValue="value"
                                                      htmlEscape="false"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第二个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">
                            招标信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>截止时间
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" name="endtime"
                                           id="endtime" readonly="readonly"
                                           class="form-control Wdate"
                                           style="height: 28px;"
                                           value="<fmt:formatDate value="${result.data.DEPARTURETIME }" pattern="yyyy-MM-dd HH:mm"/>"
                                           onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate: '%y-%M-%d %H:%m' })"
                                           placeholder="请选择截止时间">
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>拦标价
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="expectedprice" type="text" name="expectedprice" onchange="setprice();"
                                           class="form-control num_unit"/>
                                    <span class="unit" id="b">元/吨</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>整标价
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="price" type="text" readonly="readonly" class="form-control">
                                    <span class="unit" id="c">元</span>
                                </div>
                            </div>
                        </div>
						<div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4 has-unit" style="margin-top:10px">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>结算周期
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="settlementperiod" name="settlementperiod" type="text"
                                           class="form-control">
                                    <span class="unit">天</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit" style="margin-top:10px">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>结算计时
                                </div>
                                <div class="col-sm-7 text-left">
                                    <form:select path="settlementtype" class="form-control">
                                        <form:options items="${fns:getDictList('settlement_type')}" itemLabel="label"
                                                      itemValue="value"
                                                      htmlEscape="false"/>
                                    </form:select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--第三个面板-->
                    <div class="col-sm-6" style="padding-left:0;">
                        <div class="panel clearfix">
                            <h4 class="panel-heading">
                                始发地址
                            </h4>
                            <div class="col-sm-12 form-horizontal form-addr">
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>提货地址
                                    </div>
                                    <div class="col-sm-7 text-left">
                                        <input name="goods.shipAddress.type" value="0" type="hidden">
                                        <input id="fromprovince" name="goods.shipAddress.province" type="hidden">
                                        <input id="fromcity" name="goods.shipAddress.city" type="hidden">
                                        <input id="fromdistrict" name="goods.shipAddress.district" type="hidden">
                                        <input type="text" name="fromAddress" id="fromAddress" readonly="readonly"
                                               class="form-control" placeholder="请选择出发地"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-3 control-label text-right">

                                    </div>
                                    <div class="col-sm-7 text-left">
                                        <input id="shipAdd" name="goods.shipAddress.address" class="form-control"
                                               type="text" placeholder="详细地址">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第四个面板-->
                    <div class="col-sm-6" style="padding-right:0;">
                        <div class="panel clearfix">
                            <h4 class="panel-heading">
                                卸货地址
                            </h4>
                            <div class="col-sm-12 form-horizontal form-addr">
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>卸货地址
                                    </div>
                                    <div class="col-sm-7 text-left">
                                        <input name="goods.consignAddress.type" value="1" type="hidden">
                                        <input id="toprovince" name="goods.consignAddress.province" type="hidden">
                                        <input id="tocity" name="goods.consignAddress.city" type="hidden">
                                        <input id="todistrict" name="goods.consignAddress.district" type="hidden">
                                        <input type="text" name="toAddress" id="toAddress" readonly="readonly"
                                               class="form-control" placeholder="请选择卸货地址"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-3 control-label text-right">

                                    </div>
                                    <div class="col-sm-7 text-left">
                                        <input id="consignAdd" name="goods.consignAddress.address" class="form-control"
                                               type="text" placeholder="详细地址">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第5个面板-->
                    <div class="panel clearfix col-sm-12" style="padding:0;">
                        <h4 class="panel-heading">其他信息</h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4 has-js">
                                <div class="col-sm-5 control-label text-right">
                                    是否开发票
                                </div>
                                <div class="col-sm-7">
                                    <div class="radios" style="position: relative;top:6px;">
                                        <form:radiobuttons path="isbill" items="${fns:getDictList('yesorno')}"
                                                           itemLabel="label"
                                                           itemValue="value" delimiter="&nbsp;" accesskey=""/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 form-group">
                                <div class="col-sm-5 control-label text-right">
                                    车型要求
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="cartype" name="goods.cartype" readonly="readonly" class="form-control"
                                           type="text"/>
                                </div>
                            </div>
                            <div class="col-sm-4 form-group has-unit">
                                <div class="col-sm-5 control-label text-right">
                                    车长要求
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="carlength" type="text" maxlenght="2" class="form-control"
                                           name="goods.carlength">
                                    <span class="unit">米</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第6个面板--备注-->
                    <div class="panel clearfix col-sm-12" style="padding:0;">
                        <h4 class="panel-heading">备注</h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="col-sm-12 form-group">
                                <textarea name="remarks" rows="5" maxlength="100" cols="" class="form-control"
                                          placeholder="在这里输入要补充的内容"></textarea>
                            </div>
                        </div>
                    </div>
                    <!--保存 按钮-->
                    <div class="col-sm-12">
                        <div class="form-group" style="margin-bottom: 80px;">
                            <div class="col-sm-2 control-label text-left"></div>
                            <div class="col-sm-4">
                                <input type="button" ng-click="upload()" id="btn-warning" class="btn btn-primary col-sm-12" value="保 存">
                                
                            </div>
                            <div class="col-sm-4">

                                <button class="btn btn-warning col-sm-12" onclick="history.go(-1)">返  回</button>

                            </div>
                        </div>
                        <!-- <div class="loading">
                            <img src="/static/images/loading.gif">
                            <p>加载中</p>
                        </div> -->
                    </div>

                    <!-- <button class="btn col-sm-6 col-sm-offset-3 btn-danger" ng-click="upload()" id="btn-warning">保存</button> -->
                </div>
            </form:form>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12" style="padding-bottom:20px;">
            <div class="form_container">
                <!--第一个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">
                        提货单列表
                    </h4>
                    <div class="panel-body">
                        <div class="col-sm-12 form-horizontal">
                            <form action="${wlpt}/wlpt/bid/import" method="post">
                                <div class="col-sm-3">
                                    <span>请选择提货单文件：{{file.name?file.name:"无上传文件"}} </span>
                                </div>
                                <div class="col-sm-1 thingList">
                                    <button class="btn btn-orange" ngf-select ng-model="file" name="file"
                                            ngf-pattern="application/msexcel" accept="application/msexcel"
                                            ngf-min-height="100"><i class="fa fa-folder-open white"> </i>选 择
                                    </button>
                                </div>
                                <div class="col-sm-1 thingList">
                                    <button class="btn btn-success" ng-click="uploadBl()" type="button"><i
                                            class="fa fa-cloud-upload"></i>上 传
                                    </button>
                                </div>
                                <div class="col-sm-1 thingList">
                                    <button id="refreshButton" type="button" class="btn btn-warning "
                                            ng-click="refreshData()"><i class="fa fa-search white"></i>查 询
                                    </button>
                                </div>
                                <div class="col-sm-1 thingList">
                                    <button id="removeButton" type="button" class="btn btn-danger "
                                            ng-click="removeData()"><i class="fa fa-trash-o white"></i>清除
                                    </button>
                                </div>
                                <div class="col-sm-1 thingList">
                                    <a class="btn btn-primary" href="${ctxStatic }/template/上传模板.xls"><i
                                            class="fa fa-cloud-download"></i>下载模板</a>
                                </div>
                            </form>
                        </div>
                        <!-- <div class="loadings"><img src="/static/images/loading.gif">
                            <p>加载中</p>
                        </div> -->
                        <div class="col-sm-12 form-horizontal">
                            <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection
                                 ui-grid-resize-columns
                                 class="grid">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>


<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>


<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/global.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload-shim.min.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload.min.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">
    /* $(".loading").hide(); */

    change();
    function change() {
        var gsoddtype = $("#gsoddtype").val();
        var result1;
        var result2;
        var result3;
        if (gsoddtype == '0') {
            result1 = '方';
            result2 = '元/方';
            result3 = '体积';
            $("#goodstype").val("0");
        } else {
            result1 = '吨';
            result2 = '元/吨';
            result3 = '重量';
            $("#goodstype").val("1");
        }
        $("#a").html(result1);
        $("#b").html(result2);
        $("#danwei").html(result3);
        $("#freightunit").val(result1);
    }
    ///线上支付
    function setprice() {
        var freightvolume = $("#freightvolume").val() * 1;
        var expectedprice = $("#expectedprice").val() * 1;
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

    $('#inputForm').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            "goods.goodsname": {
                message: '货物名称无效',
                validators: {
                    notEmpty: {
                        message: '货物名称不能为空'
                    }
                }
            },
            "goods.freightvolume": {
                message: '货物重量无效',
                validators: {
                    notEmpty: {
                        message: '货物重量不能为空'
                    }, decimalFour: {
                        message: '只能为小数或数字且小数点后不能超过4位'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '货物重量不能小于等于0'
                    }
                }
            },
            endtime: {
            	trigger: "focus blur keyup change",
                validators: {
                    notEmpty: {
                        message: '截止时间不能为空'
                    }
                }
            },
            expectedprice: {
                message: '拦标价无效',
                validators: {
                    notEmpty: {
                        message: '拦标价不能为空'
                    }, decimalTwo: {
                        message: '只能为小数或数字且小数点后不能超过2位'
                    },
                    between: {
                        min: 0.01,
                        max:100000000,
                        message: '拦标价不能小于等于0'
                    }
                }
            },
            settlementperiod: {
                message: '结算周期无效',
                validators: {
                    notEmpty: {
                        message: '结算周期不能为空'
                    }, numeric: {
                        message: '结算周期只能为整数'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '结算周期不能小于等于0'
                    }
                }
            },
            fromAddress: {
                message: '请选择出发地',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '出发地不能为空'
                    }
                }
            },
            "goods.shipAddress.address": {
                message: '请填写详细地址',
                validators: {
                    notEmpty: {
                        message: '请填写详细地址'
                    }
                }
            },
            toAddress: {
                message: '请选择卸货地址',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '卸货地址不能为空'
                    }
                }
            }, "goods.consignAddress.address": {
                message: '请填写详细地址',
                validators: {
                    notEmpty: {
                        message: '请填写详细地址'
                    }
                }
            },"goods.carlength":{
                message: '车长无效',
                validators: {
                     decimalTwo: {
                        message: '车长只能为小数或数字'
                    }
                }
            }
        }

    });

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
            $scope.bgrid = {};
            $scope.type = 1;

            $scope.uploadBl = function () {
            	$("#maskloading" , parent.document).show();

                $scope.fileInfo = $scope.file;
                Upload.upload({
                    //服务端接收
                    url: '${wlpt}/wlpt/bid/import',
                    //上传的同时带的参数
                    file: $scope.file,
                    params: {
                        'type':$scope.type
                    }
                }).progress(function (evt) {
                    //进度条
                    var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                    console.log('progess:' + progressPercentage + '%' + evt.config.file.name);
                }).success(function (data, status, headers, config) {
                	$("#maskloading" , parent.document).hide();
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
                    $scope.fileInfo.name;
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
                        if ($scope.bgrid.selection.getSelectedCount() == 1) {
                            $scope.freightvolume = 0;
                        }
                        $scope.freightvolume = accAdd($scope.freightvolume, Number(row.entity.quantity));
                    } else {
                        $scope.freightvolume = accSub($scope.freightvolume, Number(row.entity.quantity));
                    }
                    setprice();
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
                    setprice();
                });

            };

            $scope.refreshData = function () {
                $scope.type = 0;
                //$("#maskloading", parent.document).show();
                $scope.myData = [];
                var start = new Date();
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: {
                            'bltype':'1',
                            'blstatus':'1',
                            'biduser.id':'${loginUser.id}',
                            'biddinguser.id':'${loginUser.id}',
                            'tradestatus': '0'
                        }
                    }).success(function (data) {
                        $("#maskloading" , parent.document).hide();
                        $scope.callsPending--;
                        data.value.forEach(function (row) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        });
                    });
                }, 200, 1);
            };
            $scope.refreshData();

            $scope.removeData = function () {
                //$("#maskloading", parent.document).show();
                $scope.myData = [];
                $scope.type = 1;
            };

            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'warehousename', displayName: '仓库名称'},
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
                {name: 'remarks', displayName: '备注'},
                {name: 'ymdDate', displayName: '时间'}
            ];

            $scope.callsPending = 0;
            var i = 0;

            $scope.upload = function () {
               
                var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
                bootstrapValidator.validate();
                if (bootstrapValidator.isValid()) {
                    $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
                        $("#maskloading" , parent.document).show();
                        var inputForm = $("#inputForm").serializeObject();
                        inputForm.blinfoList = angular.toJson($scope.bgrid.selection.getSelectedRows());
                        $.ajax({
                            url: '${wlpt}/wlpt/bid/bidSave',
                            method: 'post',
                            data: inputForm
                        }).success(function (data) {
                            if (data = 1) {
                                $("#maskloading" , parent.document).hide();
                                window.location.href = '${wlpt}/wlpt/bid/myBid';
                            } else {
                                window.location.href = "${wlpt}/login";
                            }
                        });
                    }, function () {
                    	$("#maskloading" , parent.document).hide();
                    });
                }
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
            $("#fromAddress").val(str).change();
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
            $("#toAddress").val(str).change();
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
