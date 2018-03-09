<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>车源管理</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑";
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .goods-manage td, .goods-manage th {
            text-align: center;
        }

        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        .car_search {
            height: 35px;
            width: 15%;
        }

        .goods-manage td .last a {
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
        }

        .loading_lock {
            display: none;
            width: 100%;
            height: 100%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading_lock img {
            margin-top: 25%;
        }
        .datainit{
            display: none;
        }
    </style>
</head>
<body style="height: 1100px;" ng-app="dataHall" ng-controller="dataHallCtrl">
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">车源</span><span
        class="title_orange">管理</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
</p>
<div class="select_title">
    <form action="" method="get" class="search-bar" style="text-align: center">
        <input id="searchinfo" ng-model="searchData.searchinfo" type="text" class="car_search car_phone_search"
               placeholder="车牌号/手机号"/>
        <input id="cartype" type="text" ng-model="searchData.cartype" class="car_search car_phone_search"
               placeholder="车型"/>

        <input id="carlength" type="text" ng-model="searchData.carlength" class="car_search car_phone_search"
               placeholder="车长"/>
        <select id="status" ng-model="searchData.status" class="car_search car_phone_search" placeholder="状态">
        <option value=''>全部</option>
        <option value='1'>已发布</option>
        <option value='2'>已过期</option>
        <option value='3'>已取消</option>
        </select>
        <button type="button" name="search-btn" id="search-btn"
                style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;border-color:#FFC52F;margin-left:15px;background-color:#FFC52F;margin-right:30px;"
                class="btn btn-warning" ng-click="onSelectPage(1)">
            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
        </button>
        
    </form>

</div>
<table class="goods-manage">
    <thead>
    <tr class="goods_col_1" style="border:none;">
        <td style="width:30%">车牌号</td>
        <td style="width:30%">车辆信息</td>
        <td style="width:20%">车源信息</td>
        <td style="width:20%">操作</td>
    </tr>
    </thead>
    <tbody class="datainit">
    <tr ng-repeat="x in data">
        <td>
            <p class="car_number ">{{x.carnumber}}</p>
            <p class="">联系电话：{{x.user.phone != null ? x.user.phone:"保密"}}</p>
        </td>
        <td>
            <p>{{x.car.issocialcar}}|{{x.car.status}}</p>
            <p>{{x.car.cartype}}|车长{{x.car.carlength}}米|载重{{x.car.loadweight}}吨</p>
        </td>
        <td>
        	<p>{{x.mainroad}}</p>
            <p>车源状态：{{x.status}}</p>
            <p>发车时间：{{x.departuretime}}</p>
        </td>
        <td>
            <p class="last"><a href="${wlpt}/wlpt/carsource/toSave?type=1&id={{x.id}}" target="content"
                               class="btn btn-warning">一键重发</a></p>
            <p class="last"><a href="${wlpt}/wlpt/carsource/toSave?type=2&id={{x.id}}" target="content"
                               class="btn btn-warning">返程发布</a></p>
            <p class="last"><a  href="${wlpt}/wlpt/carsource/getCarSourceInfo?id={{x.id}}" target="content"
                               class="btn btn-warning">查看</a></p>                      
            <p class="last"><a href="javascript:;" ng-click="isDelete(x.id)" target="content"
                               class="btn btn-warning">删除</a></p>
            <%-- <p class="last"><a href="${wlpt}/wlpt/trade/trade_list?searchinfo={{x.carnumber}}" target="content"
                               class="btn btn-warning">运单</a></p> --%>
        </td>
    </tr>
    </tbody>
</table>
<div class="loading"><img src="/static/images/loading.gif">
    <p>加载中</p></div>
<div class="loading_lock"><img src="${ctxStatic }/images/loading.gif">
    <p>等待中</p></div>
<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>
<div class="paging" id="paging">
    <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">第一页</a></li>
        <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></li>
        <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
            <a ng-click="selectPage(page)">{{page}}</a>
        </li>
        <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">最后一页</a></li>
    </ul>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>

    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            searchinfo: '', cartype: '', carlength: '', issocialcar: ''
        };
        $scope.isDelete = function (id) {

            if (id == null || id == "") {
                return;
            }
           // $(".loading_lock").show();
            $.MsgBox.Confirm("删除提示","是否删除该车源?", function () {
            	$.ajax({
                    url: "${wlpt}/wlpt/carsource/deleteCarSource",
                    data: {
                        id: id,
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("删除提示",data.value);
                        $scope.onSelectPage(1);
                    }
                });
            }, function () {
                $(".loading_lock").hide();
            });
        };
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $(".loading").show();
                $("#noneData").hide();
            } else if (isloading == 2) {
                $(".loading").hide();
                $("#noneData").show();
            } else {
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/carsource/getCarSourceList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if (!$scope.data) {
                $scope.isloading(2);
            } else {
                $scope.isloading(3);
            }
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/carsource/getCarSourceList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'searchinfo': $("#searchinfo").val(),
                    'cartype': $("#cartype").val(),
                    'carlength': $("#carlength").val(),
                    'status': $("#status").val()
                }
            }).success(function (response) {
                $scope.data = response.value.list;
                $scope.pages = [];
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);
                }
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
                if ($scope.numPages == 0) {
                    $scope.numPages = 1;
                }
                $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
                for (var i = 0; i < $scope.newPages; i++) {
                    var num = $scope.currentPage - 3;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1);
                }
            });
        };
    });

    app.directive('paging', function () {
        return {
            restrict: 'AEC',
            //scope: {
            //    numPages: '=',
            //    currentPage: '=',
            //    onSelectPage: '&'
            //},
            template: '',
            replace: true,
            link: function (scope, element, attrs) {
                scope.$watch('numPages', function (value) {

                    if (scope.currentPage > value) {
                        scope.selectPage(value);
                    }
                });
                scope.isActive = function (page) {
                    return scope.currentPage === page;
                };
                scope.selectPage = function (page) {
                    //不能小于1大于最大
                    if (page < 1 || page > scope.numPages) return;
                    //最多显示分页数5
                    if (page > 2) {
                        //因为只显示5个页数，大于2页开始分页转换
                        var newpageList = [];
                        for (var i = (page - 3); i < ((page + 2) > scope.numPages ? scope.numPages : (page + 2)); i++) {
                            newpageList.push(i + 1);
                        }
                        scope.pages = newpageList;
                    }
                    if (page == 1) {
                        scope.pages = [];
                        for (var k = 0; k < scope.newPages; k++) {
                            scope.pages.push(k + 1);
                        }
                    }


                    if (!scope.isActive(page)) {
                        scope.currentPage = page;
                        scope.onSelectPage(page);
                    }
                };
                scope.selectPrevious = function () {
                    if (!scope.noPrevious()) {
                        scope.selectPage(scope.currentPage - 1);
                    }
                };
                scope.selectNext = function () {
                    if (!scope.noNext()) {
                        scope.selectPage(scope.currentPage + 1);
                    }
                };
                scope.noPrevious = function () {
                    return scope.currentPage == 1;
                };
                scope.noNext = function () {
                    return scope.currentPage == scope.numPages;
                };

            }
        };


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
    function check() {
        var status = "${user.userinfo.status}";
        if (status != '2') {
            $("#fabu").tips({
                side: 3,
                msg: '您还未认证！',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        return true;
    }
</script>
</body>
</html>
