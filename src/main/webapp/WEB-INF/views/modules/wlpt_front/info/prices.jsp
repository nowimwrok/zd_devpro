<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <title>价格指数</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <style>
        body {
            font-size: 12px;
        }

        .search_box {
            margin-top: 35px;
            width: 100%;
            margin-bottom: 20px;
        }

        .search_nav {
            width: 550px;
        }

        .search_cent {
            height: 40px;
            float: none;
        }

        .search_input {
            width: 215px;
        }

        .one-data td {
            border-bottom: 1px dashed #ccc;
            line-height: 20px;
            padding-left: 5px;
        }

        .select {
            color: #F74000;
        }

        .switch_l {
            float: left
        }

        .switch_l li {
            width: 130px;
            height: 70px;
            line-height: 70px;
            border: 1px solid #ccc;
            font-size: 20px;
            list-style: none;
            text-align: center;
            cursor: pointer;
            background-color: #fff;
            color: #494949;

        }

        .switch_l li.active {
            color: #fff;
            background: #E16633;
        }

        .bluea li.active {
            color: #fff;
            background: #3675B4;
        }

        .switch_t {
            position: relative;
            z-index: 999;
        }

        .switch_t li {
            width: 190px;
            height: 30px;
            line-height: 30px;
            border-right: 1px solid #ccc;
            color: #9C9C9C;
            list-style: none;
            cursor: pointer;
            text-align: center;
            float: left;
            background-color: #fff;
        }

        .switch_t li.active {
            background: #F8E4DD;
            color: #FE7445;
        }

        .charts {
            position: static;
            width: 1000px;
            height: 450px;
        }

        .one-data span {
            line-height: 25px;
        }

        .data-list td {
            height: 60px;
            text-align: left;
            line-height: 60px;
            padding-left: 15px;
        }

        thead th {
            font-size: 15px;
            color: #555;
        }

        .text-right-td input {
            border-top: 0;
            border-left: 0;
            border-right: 0;
        }

        .white_content table {
            font-size: 15px;
        }

        nav {
            position: relative;
            width: 100%;
            height: 50px;
        }

        .pagination {
            right: 0px;
            position: absolute;
            top: -30px;
        }

        nav li {
            cursor: pointer;
        }

        .search-in {
            width: 28%;
            height: 45px;
            border: 2px solid #00A2E9;
        }

        .search-btn {
            background-color: #00A2E9;
            border: none;
            margin-left: 35px;
            width: 100px;
            height: 45px;
            text-align: center;
        }

        .search-btn a {
            color: #fff;
            padding-top: 15px;
            padding-bottom: 15px;
        }
    </style>
        <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
</head>
<body>

<div ng-app="pricesApp" ng-controller="pricesCtrl" style="width: 1000px;margin: 0 auto;">
        <div style="margin-top:35px; width: 100%;margin-bottom: 20px;float: left;">
        <div style="width: 550px;height: 30px;margin-left: 12%;">
            <ul id="goodsUl" style="margin-top: 0;margin-bottom: 10px;list-style: none;display: block; margin: 0px;">
                <li ng-click="GOODSTPYECLICK('2')" style="list-style: none;width: 30px;height: 30px;font-size: 15px;font-weight: bold;text-align: center;line-height: 30px;float: left;margin-right: 5px;
                        cursor: pointer;">成品</li>
                <li style="border-right:solid 2px #F74000;height:15px;width:2px;margin-top:8px;list-style: none;font-size: 15px;font-weight: bold;text-align: center;
                        line-height: 30px; float: left;margin-right: 5px;cursor: pointer;"></li>
                <li style="width: 55px;list-style: none;height: 30px;font-size: 15px;font-weight: bold;text-align: center;line-height: 30px;float: left;margin-right: 5px;
                        cursor: pointer;" ng-click="GOODSTPYECLICK('1')">原材料</li>
            </ul>
        </div>
        <!---search_nav end-->
        <div class="search-bg">
        <form action="" method="get" class="search-bar" style="text-align: center;padding-top:35px;">
            <input class="search-in" id="fromAddress" placeholder="始发地" ng-model="STARTADDRESS">
            <img src="${ctxStatic }/images/wlptfront/qiehuan.png">
            <input class="search-in" id="toAddress" placeholder="目的地" ng-model="ENDADDRESS">
          <button type="button" name="search-btn" class="search-btn" id="speedfinding" ng-click="SEARCHCLICK()"><a>搜索</a></button>
         </form>
        </div>
        </div>
        <!---search_cent end-->
    

 <%--   <ul class="nav nav-tabs nav-pills">
        <li role="presentation" class="active"><a href="#">周指数</a></li>
        <li role="presentation" ><a href="#">月指数</a></li>
        <li role="presentation" ><a href="#">年指数</a></li>

    </ul>--%>

    <div style="width: 1000px;">
        <highchart id="chart1" style="width: 1000px;" series="chart.series" title="chart.title" options="chart.options"  ></highchart>
    </div>

    <table ng-table="tableParams" class="table table-condensed table-bordered text-center" style="width: 100%">
        <tr>
            <th class="text-center">序号</th>
            <th class="text-center">始发地</th>
            <th class="text-center">目的地</th>
            <th class="text-center">指导价(元/吨)</th>
            <th class="text-center">发布日期</th>
        </tr>
        <tr ng-repeat="x in items" >
            <td>{{ $index + 1 }}</td>
            <td>{{STARTADDRESS!=null && STARTADDRESS!='' && x.startaremarks!=null  && x.startaremarks!=''?x.startaremarks: x.startaddress }}</td>
            <td>{{ENDADDRESS!=null && ENDADDRESS!='' && x.endremarks!=null &&  x.endremarks!='' ?x.endremarks: x.endaddress }}</td>
            <td>{{ x.priceinfo.newprice | number:2}}</td>
            <td>{{ x.updatetime }}</td>
        </tr>
        <tr  ng-show="!items">
            <td colspan="5" class="text-center"><h4>暂无数据....</h4></td>
        </tr>
    </table>

    <nav class="paging" id="paging" style="margin-left: -6%;">
        <ul class="pagination pager" id="pagination">
            <li>
                <a ng-click="Previous()">
                    <span>上一页</span>
                </a>
            </li>
            <li ng-repeat="page in pageList" ng-class="{active: isActivePage(page)}">
                <a ng-click="selectPage(page)">{{ page }}</a>
            </li>
            <li>
                <a ng-click="Next()">
                    <span>下一页</span>
                </a>
            </li>
        </ul>
    </nav>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script  type="text/javascript" src="http://cdn.hcharts.cn/highcharts/highcharts.js" ></script>
<script  type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/highcharts-ng.js" ></script>
<script  type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/msgbox.js" ></script>
<script type="text/javascript">

    var app = angular.module('pricesApp',["highcharts-ng"]);

    app.controller('pricesCtrl', function ($scope, $http) {
        $scope.GOODSTYPE = 2;
		$("#goodsUl li:first").addClass("select");
        $http({
            url: '${wlpt}/wlpt/info/price/getPrices',
            method: 'GET',
            params: {
                'priceinfo.goodstype': $scope.GOODSTYPE,
                'startaddress': $scope.STARTADDRESS,
                'endaddress': $scope.ENDADDRESS
            }
        }).success(function (response) {
            $scope.datas = response.value.datas;
            $scope.chart = {
                options: {
                    chart: {
                        type: 'line'
                    },
                    tooltip: {
                        xDateFormat: '%Y-%m-%d %H:%M:%S'
                    },
                    xAxis: {
                        type: 'datetime',
                        categories: response.value.date
                    },
                    yAxis:{
                        title:{
                            text:'线路价格'
                        }
                    },
                    credits: {
                        enabled: false
                    }
                },
                series: [{
                    data: response.value.avgPrices,
                    name:'平均价'
                }],
                title: {
                    text: null
                }
            };
            pages();
        });



        $scope.GOODSTPYECLICK = function (code) {
            $("#goodsUl li").eq(code==2?0:2).addClass("select").siblings().removeClass("select");

            $scope.GOODSTYPE = code;
            $http({
                url: '${wlpt}/wlpt/info/price/getPrices',
                method: 'GET',
                params: {
                	'priceinfo.goodstype': $scope.GOODSTYPE,
                    'startaddress': $scope.STARTADDRESS,
                    'endaddress': $scope.ENDADDRESS
                }
            }).success(function (response) {
                $scope.datas = response.value.datas;
                $scope.chart = {
                    options: {
                        chart: {
                            type: 'line'
                        },
                        tooltip: {
                            xDateFormat: '%Y-%m-%d %H:%M:%S'
                        },
                        xAxis: {
                            type: 'datetime',
                            categories: response.value.date
                        },
                        yAxis:{
                            title:{
                                text:'线路价格'
                            }
                        },
                        credits: {
                            enabled: false
                        }
                    },
                    series: [{
                        data: response.value.avgPrices,
                        name:'平均价'
                    }],
                    title: {
                        text: null
                    }
                };
                pages();
            });
        };

        $scope.SEARCHCLICK =  function () {
        	var startaddress = $scope.STARTADDRESS;
        	var endaddress = $scope.ENDADDRESS;
        	if(startaddress == null || startaddress.length < 1){
        		$.MsgBox.Alert("搜索提示","请输入始发地");
        		return;
        	}else if(endaddress == null || endaddress.length <1){
        		$.MsgBox.Alert("搜索提示","请输入目的地");
        		return;
        	}
            $http({
                url: '${wlpt}/wlpt/info/price/getPrices',
                method: 'GET',
                params: {
                	'priceinfo.goodstype': $scope.GOODSTYPE,
                    'startaddress': startaddress,
                    'endaddress': endaddress
                }
            }).success(function (response) {
                $scope.datas = response.value.datas;
                $scope.chart = {
                    options: {
                        chart: {
                            type: 'line'
                        },
                        tooltip: {
                            xDateFormat: '%Y-%m-%d %H:%M:%S'
                        },
                        xAxis: {
                            type: 'datetime',
                            categories: response.value.date
                        },
                        yAxis:{
                            title:{
                                text:'线路价格'
                            }
                        },
                        credits: {
                            enabled: false
                        }
                    },
                    series: [{
                        data: response.value.avgPrices,
                        name:'平均价'
                    }],
                    title: {
                        text: null
                    }
                };
                pages();
            });
        };


        function pages() {
            //分页总数
            $scope.pageSize = 15;
            $scope.pages = Math.ceil($scope.datas.length / $scope.pageSize); //分页数
            $scope.newPages = $scope.pages > 5 ? 5 : $scope.pages;
            $scope.pageList = [];
            $scope.selPage = 1;
//设置表格数据源(分页)
            $scope.setData = function () {
                $scope.items = $scope.datas.slice(($scope.pageSize * ($scope.selPage - 1)), ($scope.selPage * $scope.pageSize));//通过当前页数筛选出表格当前显示数据
            };
            $scope.items = $scope.datas.slice(0, $scope.pageSize);
//分页要repeat的数组
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pageList.push(i + 1);
            }
//打印当前选中页索引
            $scope.selectPage = function (page) {
//不能小于1大于最大
                if (page < 1 || page > $scope.pages) return;
//最多显示分页数5
                if (page > 2) {
//因为只显示5个页数，大于2页开始分页转换
                    var newpageList = [];
                    for (var i = (page - 3); i < ((page + 2) > $scope.pages ? $scope.pages : (page + 2)); i++) {
                        newpageList.push(i + 1);
                    }
                    $scope.pageList = newpageList;
                }
                $scope.selPage = page;
                $scope.setData();
                $scope.isActivePage(page);
            };
//设置当前选中页样式
            $scope.isActivePage = function (page) {
                return $scope.selPage == page;
            };
//上一页
            $scope.Previous = function () {
                $scope.selectPage($scope.selPage - 1);
            };
//下一页
            $scope.Next = function () {
                $scope.selectPage($scope.selPage + 1);
            };
        }
    });

    $(function () {
        $(".nav_selected").removeClass("nav_selected");
        $("#prices").addClass("nav_selected");
    });

</script>



</body>
</html>
