<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>提货单列表</title>
    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">
    <style type="text/css">
        .form-control {
            border: 1px solid #ccc !important;
        }

        .loading {
            text-align: center;
        }

        .bg_red:HOVER {
            color: #fff;
        }

        .bg_red {
            color: #fff;
        }

        .ui-grid-header-cell-wrapper {
            position: relative;
            display: table;
            box-sizing: border-box;
            height: 60px !important;
        }

        .ui-grid-icon-ok:before {
            content: '\c362';
            color: #ffffff !important;
            background-color: rgba(17, 222, 33, 0.82) !important;
        }


    </style>
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;" ng-app="bidblApp" ng-controller="bidblCtrl">
    <div class="row">
        <div class="col-lg-12" style="padding-bottom:20px;">
            <div class="form_container">
                <!--第一个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">
                        提货单列表
                    </h4>
                    <div class="panel-body">
                        <div class="col-sm-12 ">
                            <form action="${wlpt}/wlpt/bid/importSave" method="post" id="inputForm">

                                <input type="hidden" id="blinfoList" name="blinfoList"/>
                                <input type="hidden" name="freightvolume" value="{{freightvolume}}" >
                            </form>
                        </div>
                        <div class="col-sm-12">
                            <div class="col-sm-12 ">
                                <div style="border: 0.1px solid #e0e0e0;padding-left:20px;background-color: #f1f1f1;height: 50px">
                                    <span style="margin-bottom: 0px;line-height: 60px;">您已选中
                                        <span><font color="black" ng-cloak><b>{{bidNum}}</b></font></span>条提货单信息,总共
                                        <span><font color="black" ng-cloak><b>{{freightvolume}} </b></font></span>吨
                                        <%--<span><font color="black"><b>{{freightvolume}}</b></font></span>方--%>
                                    </span>
                                    <div style="float: right;margin-top: 10px;margin-right: 10px">
                                        <button type="button" class="btn btn-success searchBtn" ng-click="submit()"><i
                                                class="fa fa-plus-square"></i>发布货源
                                        </button>
                                        <button type="button" class="btn bg_red searchBtn"
                                                ng-click="deleteBl()"><i class="fa fa-trash white"></i>删 除
                                        </button>
                                        <button class="btn btn-orange searchBtn" type="button"
                                                data-target="#modalAddBid"
                                                data-toggle="modal">
                                            <i class="fa fa-folder-open white"> </i>导入提货单
                                        </button>
                                        <button class="btn btn-primary" type="button"
                                                data-target="#modalBidblAdd"
                                                data-toggle="modal">
                                            <i class="fa fa-plus white"> </i>添加提货单
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 ">
                                <div id="grid1" style="height: 500px" ui-grid="gridOptions" ui-grid-auto-resize
                                     ui-grid-selection ui-grid-resize-columns class="grid">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modalAddBid" class="modal"
         data-backdrop="static" style="margin:100px auto;overflow-y:hidden;width: 730px;z-index: 9999">
        <div class="modal-content" style="width: 730px">
            <div class="modal-header" style="margin-left: -1px">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h4 class="modal-title">导入提货单</h4>
            </div>
            <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;width: 730px">
                <div class="col-sm-12 form-group">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-10 ">
                        <span style="float: left;margin-left: 5px;line-height: 36px">提货单文件：</span>
                        <span style="float: left;margin-left: 5px;line-height: 36px"
                              ng-cloak>{{file.name?file.name:"无上传文件"}} </span>
                        <button class="btn btn-orange " ngf-select ng-model="file" name="file"
                                style="float: left;margin-left: 30px"
                                ngf-pattern="application/msexcel" accept="application/msexcel"
                                ngf-max-size="20MB"
                                ngf-min-height="100"><i class="fa fa-folder-open white"> </i>选 择
                        </button>
                        <a style="line-height: 36px;float: left;margin-left: 10px"
                           href="${ctxStatic }/template/上传模板.xls">下载模板</a>
                    </div>
                </div>
                <div class="col-sm-12 form-group">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-4">
                        <button class="btn btn-primary col-lg-12" ng-click="uploadBl()">提交</button>
                    </div>
                    <div class="col-sm-4">
                        <button class="btn btn-warning col-lg-12" data-dismiss="modal">返回</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modalBidblAdd" class="modal"
         style="margin:auto;overflow-y:hidden;height: 400px;width: 850px;z-index: 9999">
        <div>
            <div class="modal-content" style="height: 400px;width: 850px">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">添加提货单</h4>
                </div>
                <div class="modal-body  modal-body-h form-horizontal" style="overflow:auto;height: 240px;height: 400px;width: 850px">
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            仓库名称：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.warehousename" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            提货单号：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.contractno" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            批号：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.batch" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            品名材质：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.namematerials" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            规格：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.standard" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            定尺\板宽：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.width" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            数量\吨：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.quantity" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            卸货地址：
                        </div>
                        <div class="col-sm-10 text-left">
                            <input type="text" ng-model="motorcade.address" class="form-control">
                        </div>
                    </div>
                    <div class="col-sm-12 form-group">
                        <div class="col-sm-2 text-left">
                            备注：
                        </div>
                        <div class="col-sm-10 text-left">
                            <textarea ng-model="motorcade.remarks" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="col-sm-12 form-group" style="margin-bottom: 40px;">
                        <div class="col-sm-2">
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-primary col-lg-12" ng-click="saveMotorcade()">提交</button>
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-warning col-lg-12" data-dismiss="modal">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>

<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload-shim.min.js"></script>
<script src="${ctxStatic }/ui-grid/js/ng-file-upload.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>


<script type="text/javascript">
    //$(".loading").hide();


    $('#modalAddBid').on('shown.bs.modal',
            function () {
                $(".modal-backdrop").css("display", "block");
                $("#modalAddBid").find(".modal-backdrop.in").css("display", "none");
            }
    );

    $('#modalAddBid').on('hidden.bs.modal',
            function () {
                $(".modal-backdrop").css("display", "none");
            }
    );

    $('#modalBidblAdd').on('shown.bs.modal',
        function () {
            $(".modal-backdrop").css("display", "block");
            $("#modalBidblAdd").find(".modal-backdrop.in").css("display", "none");
        }
    );

    $('#modalBidblAdd').on('hidden.bs.modal',
        function () {
            $(".modal-backdrop").css("display", "none");
        }
    );


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

    var app = angular.module('bidblApp', ['ngFileUpload', 'ui.grid', 'ui.grid.cellNav', 'ui.grid.selection', 'ui.grid.edit', 'ui.grid.resizeColumns', 'ui.grid.pinning', 'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.importer', 'ui.grid.grouping']);
    app.controller('bidblCtrl', ['$scope', 'Upload', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
        function ($scope, Upload, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {
            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.freightvolume = 0;
            $scope.bidNum = 0;//提货单数量
            $scope.imporDate = [];

            $scope.uploadBl = function () {
                var status = '${loginUser.userinfo.status}';
                if (status == null || status == '' || status == undefined || status != '2') {
                    $.MsgBox.Alert("提示", "请先完成认证");
                    return false;
                }
                var filename = $scope.file;
                if (filename == "" || filename == undefined) {
                    $.MsgBox.Alert("提示", "请先选择要上传的数据表");
                    return false;
                }

                if ($("#maskloading", parent.document).is(':hidden')) {
                    $("#maskloading", parent.document).show();
                } else {
                    return false;
                }
                $scope.fileInfo = $scope.file;
                Upload.upload({
                    //服务端接收
                    url: '${wlpt}/wlpt/bid/importSave',
                    //上传的同时带的参数
                    file: $scope.file
                }).progress(function (evt) {
                    //进度条
                    var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
                    console.log('progess:' + progressPercentage + '%' + evt.config.file.name);
                }).success(function (data, status, headers, config) {
                    $("#maskloading", parent.document).hide();
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
                    $scope.fileInfo.name
                    //上传成功
                    $("#modalAddBid").modal("hide");
                }).error(function (data, status, headers, config) {
                    $("#maskloading", parent.document).hide();
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

            $scope.gridOptions.importerDataAddCallback = function (grid, newObjects) {
                if (newObjects) {
                    $scope.callsPending--;
                    newObjects.forEach(function (row) {
                        row.registered = new Date(row.registered);
                        $scope.myData.push(row);
                    });
                }
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
                    if (row.isSelected) {
                        $scope.freightvolume = accAdd($scope.freightvolume, Number(row.entity.quantity));
                        $scope.bidNum = $scope.bidNum + 1;
                    } else {
                        $scope.freightvolume = accSub($scope.freightvolume, Number(row.entity.quantity));
                        $scope.bidNum = $scope.bidNum - 1;
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {
                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                            $scope.freightvolume = accAdd($scope.freightvolume, Number(r.entity.quantity));
                            $scope.bidNum = $scope.bidNum + 1;
                        });
                    } else {
                        $scope.freightvolume = 0;
                        $scope.bidNum = 0;
                    }
                });
            };

            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'blcode', displayName: '货单所属'},
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
                /*{name: 'blstatus', displayName: '状态'},*/
                {name: 'bltype', displayName: '类型'},
                {name: 'ymdDate', displayName: '时间'}
            ];
            $scope.callsPending = 0;
            var i = 0;

            $scope.submit = function () {

                if ($("#freightvolume").val() <= 0) {
                    $.MsgBox.Alert("提示", "发布吨位不能小于等于0吨");
                    return false;
                }


                if ($("#freightvolume").val() > 200) {
                    $.MsgBox.Alert("提示", "发布吨位不能大于200吨");
                    return false;
                }

                if ($scope.bgrid.selection.getSelectedRows().length > 30) {
                    $.MsgBox.Alert("提示", "提货单条数不能大于30条");
                    return false;
                }
                if ($scope.bgrid.selection.getSelectedRows().length == 0) {
                    $.MsgBox.Alert("提示", "请选择提货单");
                    return false;
                }


                if ($("#maskloading", parent.document).is(':hidden')) {

                } else {
                    return false;
                }
                var numberbid = $scope.bgrid.selection.getSelectedRows().length;
                var volumebid = $scope.freightvolume;
                $.MsgBox.Confirm("温馨提示", "您已选择" + numberbid * 1 + "条货单信息,总计" + volumebid * 1 + "吨,确认发布吗？", function () {
                    $("#maskloading", parent.document).show();
                    $("#blinfoList").val(angular.toJson($scope.bgrid.selection.getSelectedRows()));

                    $("#inputForm").attr("action", "${wlpt}/wlpt/goods/toSave");
                    $("#inputForm").submit();
                }, function () {
                    $("#maskloading", parent.document).hide();
                });

            };

            $scope.deleteBl = function () {
                if ($scope.bgrid.selection.getSelectedRows().length == 0) {
                    $.MsgBox.Alert("提示", "请选择需要删除的提货单");
                    return false;
                }
                if ($("#maskloading", parent.document).is(':hidden')) {
                    $("#maskloading", parent.document).show();
                } else {
                    return false;
                }
                var inputForm = $("#inputForm").serializeObject();
                inputForm.blinfoList = angular.toJson($scope.bgrid.selection.getSelectedRows());
                $.ajax({
                    url: '${wlpt}/wlpt/bid/deleteBl',
                    method: 'post',
                    data: inputForm
                }).success(function (response) {
                    $("#maskloading", parent.document).hide();
                    $.MsgBox.Alert("提示", response.value);
                    $scope.refreshData();
                    $scope.freightvolume = 0;
                });
            };

            $scope.refreshData = function () {
                $("#maskloading", parent.document).show();
                $scope.myData = [];
                $scope.imporDate = [];
                var start = new Date();
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: {
                            'searchinfo': '${loginUser.id}',
                            'tradestatus': '0'
                        }
                    }).success(function (data) {
                        $("#maskloading", parent.document).hide();
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

            $scope.clearMotorcade = function () {
                $scope.motorcade = {warehousename: "", contractno: "", batch: "", namematerials: "", standard: "",width:"",
                    quantity:"",address:"", remarks: ""};
            }
            $scope.motorcade = {warehousename: "", contractno: "", batch: "", namematerials: "", standard: "",width:"",
                quantity:"",address:"", remarks: ""};
            $scope.saveMotorcade = function () {
                if ($scope.motorcade.contractno == "") {
                    $.MsgBox.Alert("提示", "请填写合同号");
                    return false;
                } else if ($scope.motorcade.batch == "") {
                    $.MsgBox.Alert("提示", "请填写批号");
                    return false;
                } else if ($scope.motorcade.namematerials == "") {
                    $.MsgBox.Alert("提示", "请填写品名材质");
                    return false;
                } else if ($scope.motorcade.standard == "") {
                    $.MsgBox.Alert("提示", "请填写规格");
                    return false;
                } else if ($scope.motorcade.width == "") {
                    $.MsgBox.Alert("提示", "请填写定尺\\板宽");
                    return false;
                }else if ($scope.motorcade.quantity == "") {
                    $.MsgBox.Alert("提示", "请填写数量\\吨");
                    return false;
                }else if ($scope.motorcade.address == "") {
                    $.MsgBox.Alert("提示", "请填写卸货地址");
                    return false;
                }
                var postData = {
                    "warehousename": $scope.motorcade.warehousename,
                    "contractno": $scope.motorcade.contractno,
                    "batch": $scope.motorcade.batch,
                    "namematerials": $scope.motorcade.namematerials,
                    "standard": $scope.motorcade.standard,
                    "width":$scope.motorcade.width,
                    "quantity":$scope.motorcade.quantity,
                    "address":$scope.motorcade.address,
                    "remarks": $scope.motorcade.remarks};
                $http({
                    url: '${wlpt}/wlpt/bid/bidBlinfoSave',
                    method: 'post',
                    params: postData
                }).success(function (response) {
                    if (response.value.state == 1) {
                        $.MsgBox.Alert("提示", "保存添加成功");
                        closeAllModal();
                        $scope.refreshData();
                    } else {
                        $.MsgBox.Alert("提示", response.value.message);
                    }
                }).error(function (response) {
                    $.MsgBox.Alert("提示", "保存失败，请重试！");
                });
            }
            var closeAllModal = function () {
                $("#modalBidblAdd").modal("hide");
            }
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