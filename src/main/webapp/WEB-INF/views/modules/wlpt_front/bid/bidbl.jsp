<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn" ng-app="bidblApp" ng-controller="bidblCtrl">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>提货单列表</title>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet"
          type="text/css">
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

<div class="tab-thre tab-all">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png">
        <span class="title_blue">提货单</span>
        <span class="title_orange">列表</span>
        <img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div>
        <form action="${wlpt}/wlpt/bid/importSave" method="post" id="inputForm">
            <p>
                <label>请选择提货单文件： {{fileInfo.name?fileInfo.name:"无上传文件"}} </label>
                <button class="btn btn-defalut btn-warning btn-sm" ngf-select ng-model="file" name="file"
                        ngf-pattern="application/msexcel" accept="application/msexcel" ngf-max-size="20MB"
                        ngf-min-height="100">选 择
                </button>
                <button class="btn btn-defalut btn-warning btn-sm" ng-click="uploadBl()" type="button">上 传</button>
                <button class="btn btn-defalut btn-warning btn-sm" ng-click="deleteBl()" type="button">删除</button>
                <button type='button' class="btn btn-defalut btn-warning btn-sm" ng-click="submit()">发布货源</button>
                <a class="btn btn-defalut btn-warning btn-sm" href="${ctxStatic }/template/上传模板.xls">下载模板</a>
                <label style="margin-left: 20px">货源吨位： </label>
                <input type="text" style="margin: 5px;" ng-model="freightvolume" readonly name="freightvolume"/>
                <input type="hidden" id="blinfoList" name="blinfoList" />
            </p>
        </form>
        <div class="loading"><img src="/static/images/loading.gif">
            <p>加载中</p>
        </div>
        <div id="grid1" style="height: 500px" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection
             ui-grid-resize-columns class="grid"></div>
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
            $scope.imporDate = [];

            $scope.uploadBl = function () {
            	var status='${loginUser.userinfo.status}';
            	if(status==null||status==''||status==undefined||status!='2'){
            		$.MsgBox.Alert("提示", "请先完成认证");
                    return false;
            	}
                if ($(".loading").is(':hidden')) {
                    $(".loading").show();
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
                    $(".loading").hide();
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
                {name: 'blstatus', displayName: '状态'},
                {name: 'address', displayName: '卸货地址'},
                {name: 'remarks', displayName: '备注'}
            ];
            $scope.callsPending = 0;
            var i = 0;

            $scope.submit = function () {

                if ($("#freightvolume").val() <= 0) {
                    $("#freightvolume").tips({
                        side: 3,
                        msg: '发布吨位不能小于等于0吨',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }


                if ($("#freightvolume").val() > 200) {
                    $("#freightvolume").tips({
                        side: 3,
                        msg: '发布吨位不能大于200吨',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if ($scope.bgrid.selection.getSelectedRows().length > 15) {
                    $.MsgBox.Alert("提示", "提货单条数不能大于15条");
                    return false;
                }
                if($scope.bgrid.selection.getSelectedRows().length == 0){
                	$.MsgBox.Alert("提示", "请选择提货单");
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
				/*var inputForm = $("#inputForm").serializeObject();
				inputForm.blinfoList=angular.toJson($scope.bgrid.selection.getSelectedRows());
                 $.ajax({
                    url: '${wlpt}/wlpt/goods/toSave',
                    method: 'post',
                    data: inputForm
                }).success(function (response) {
                    $(".loading").hide();
                    $(document.body).html(response);

                }); */
            };

            $scope.deleteBl = function () {
            	if ($scope.bgrid.selection.getSelectedRows().length == 0) {
                    $.MsgBox.Alert("提示", "请选择需要删除的提货单");
                    return false;
                }
            	if ($(".loading").is(':hidden')) {
                    $(".loading").show();
                } else {
                    return false;
                }
            	var inputForm = $("#inputForm").serializeObject();
                inputForm.blinfoList=angular.toJson($scope.bgrid.selection.getSelectedRows());
                $.ajax({
                    url: '${wlpt}/wlpt/bid/deleteBl',
                    method: 'post',
                    data: inputForm
                }).success(function (response) {
                    $(".loading").hide();
                    $scope.refreshData();
                });
            };

            $scope.refreshData = function () {
                if ($(".loading").is(':hidden')) {
                    $(".loading").show();
                } else {
                    return false;
                }
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
                        $(".loading").hide();
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