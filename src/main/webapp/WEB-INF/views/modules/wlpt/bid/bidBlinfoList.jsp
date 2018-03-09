<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提货单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

	</script>
</head>
<body ng-app="bidblApp" ng-controller="bidblCtrl">

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
                            ngf-pattern="application/msexcel" accept="application/msexcel" ngf-max-size="20MB"
                            ngf-min-height="100">选 择
                    </button>
                    <button class="btn btn-defalut btn-warning btn-sm" ng-click="uploadBl()" type="button">上 传</button>
                    <button id="refreshButton" type="button" class="btn btn-defalut btn-warning btn-sm"
                            style="text-align: right;margin: 5px;" ng-click="refreshData()">查 询
                    </button>
                    <button type='btn btn-defalut btn-warning btn-sm' class="btn btn-defalut btn-warning" id="btn-warning" ng-click="submit()">发布货源</button>

                    <a class="btn btn-defalut btn-warning btn-sm" href="${ctxStatic }/template/上传模板.xls">下载模板</a>
                </p>
            </form>
            <div class="loading"><img src="/static/images/loading.gif">
                <p>加载中</p>
            </div>
            <div id="grid1" ui-grid="gridOptions" ui-grid-cellNav ui-grid-edit ui-grid-resize-columns ui-grid-pinning ui-grid-selection ui-grid-move-columns ui-grid-importer ui-grid-grouping class="grid"></div>
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


    <script type="text/javascript">
        $(".loading").hide();

        var app = angular.module('bidblApp', ['ngFileUpload', 'ui.grid', 'ui.grid.cellNav', 'ui.grid.selection', 'ui.grid.edit', 'ui.grid.resizeColumns', 'ui.grid.pinning', 'ui.grid.selection', 'ui.grid.moveColumns', 'ui.grid.importer', 'ui.grid.grouping']);
        app.controller('bidblCtrl', ['$scope', 'Upload', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
            function ($scope, Upload, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {

                // 国际化；
                i18nService.setCurrentLang("zh-cn");
                $scope.myData = [];
                $scope.gridOptions = {};
                $scope.gridOptions.data = 'myData';
                $scope.freightvolume= 0 ;
                $scope.imporDate=[];


                $scope.uploadBl = function () {
                    if ($(".loading").is(':hidden')) {
                        $(".loading").show();
                    } else {
                        return false;
                    }
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
                            var b=true;
                            $scope.imporDate.forEach(function (r) {
                                if(r.entity==row.entity){
                                    b=false
                                }
                            });
                            if(b){
                                row.registered = new Date(row.registered);
                                $scope.myData.push(row);
                            }
                        });

                        $scope.imporDate=data.value;
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
                    $scope.bgrid.selection.on.rowSelectionChanged($scope,function(row,event){

                        if($scope.bgrid.selection.getSelectedCount()==0){
                            document.getElementById('freightvolume').readOnly=false;
                        }

                        if(row.isSelected){
                            if($scope.bgrid.selection.getSelectedCount()==1){
                                $scope.freightvolume= 0 ;
                                document.getElementById('freightvolume').readOnly=true;
                            }
                            $scope.freightvolume= accAdd($scope.freightvolume,Number(row.entity.quantity)) ;
                        }else{
                            $scope.freightvolume = accSub($scope.freightvolume,Number(row.entity.quantity)) ;
                        }

                    });
                    $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function(row){

                        if(!$scope.bgrid.selection.getSelectAllState()){
                            row.forEach(function (r) {
                                $scope.freightvolume= accAdd($scope.freightvolume,Number(r.entity.quantity)) ;
                            });
                        }else{
                            $scope.freightvolume= 0 ;
                            document.getElementById('freightvolume').readOnly=false;
                        }
                    });

                };

                $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                    {name: 'contractno', displayName: '提货单号', width: 100, enableCellEdit: false},
                    {name: 'namematerials', displayName: '品名材质', width: 150, enableCellEdit: false},
                    {name: 'standard', displayName: '规格', width: 80, enableCellEdit: false},
                    {name: 'width', displayName: '定尺\\板宽', width: 100, enableCellEdit: false},
                    {
                        name: 'quantity',
                        displayName: '数量\\吨',
                        width: 100,
                        enableCellEdit: true,
                        aggregationType: uiGridConstants.aggregationTypes.sum,
                        treeAggregationType: uiGridGroupingConstants.aggregation.SUM
                    },
                    {name: 'batch', displayName: '批次号', width: 120, enableCellEdit: false},
                    {name: 'address', displayName: '卸货地址', width: 200, enableCellEdit: false},
                    {name: 'remarks', displayName: '备注', width: 100, enableCellEdit: false},
                    {
                        name: 'edit',
                        displayName: '操作',
                        width: 50,
                        enableCellEdit: false,
                        enableColumnResizing: false,
                        enableFiltering: false,
                        enableGridMenu: false,
                        showGridFooter: false,
                        showColumnFooter: false,
                        fastWatch: false
                    }
                ];

                $scope.callsPending = 0;
                var i = 0;

                $scope.submit = function () {
                    if ($(".loading").is(':hidden')) {
                        $(".loading").show();
                    } else {
                        return false;
                    }
                    $http({
                        url: '${wlpt}/wlpt/goods/toSave',
                        method: 'post',
                        params: {
                            'blinfoList': new Array($scope.bgrid.selection.getSelectedRows())
                        }
                    }).success(function (response) {
                        $(".loading").hide();
                        $(document.body).html(response);
                    });
                };

                $scope.refreshData = function () {
                    if ($(".loading").is(':hidden')) {
                        $(".loading").show();
                    } else {
                        return false;
                    }
                    $scope.myData = [];
                    $scope.imporDate=[];
                    var start = new Date();
                    var sec = $interval(function () {
                        $scope.callsPending++;
                        $http({
                            url: '${wlpt}/wlpt/bid/getblList',
                            method: 'post',
                            params:{
                                blstatus: 1
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

            }]);
    </script>


</body>
</html>