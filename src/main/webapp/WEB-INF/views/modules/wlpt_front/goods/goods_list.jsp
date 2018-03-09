<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>货源管理</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

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
<body ng-app="dataHall" ng-controller="dataHallCtrl">
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货源</span><span
        class="title_orange">管理</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
</p>
<div class="select_title">
    <form action="" method="get" class="search-bar" style="text-align: center">

        <input id="fromprovince" type="hidden" class="search-in" ng-model="searchData.fromprovince" name="search-in"/>
        <input id="fromcity" type="hidden" class="search-in" ng-model="searchData.fromcity" name="search-in"/>
        <input id="fromdistrict" type="hidden" class="search-in" ng-model="searchData.fromdistrict" name="search-in"/>
        <input type="text" readonly="readonly" style="height: 88%;" id="addressStart" placeholder="出发地">
        <span class="glyphicon glyphicon-transfer icon_blue"></span>


        <input id="toprovince" type="hidden" class="search-in" ng-model="searchData.toprovince" name="search-in"/>
        <input id="tocity" type="hidden" class="search-in" ng-model="searchData.tocity" name="search-in"/>
        <input id="todistrict" type="hidden" class="search-in" ng-model="searchData.todistrict" name="search-in"/>
        <input type="text" readonly="readonly" id="addressEnd" style="height: 88%;" placeholder="目的地">
        <select id="tradestatus" class="select_3 select" style="width: 10%;" ng-model="searchData.tradestatus">
            <option value=""></option>
            <option value="0">未报价</option>
            <option value="1">已报价</option>
            <option value="2">报价完成</option>
        </select>
        <button type="button" name="search-btn" id="search-btn"
                style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;border-color:#FFC52F;margin-left:15px;background-color:#FFC52F;margin-right:30px;"
                class="btn btn-warning" ng-click="onSelectPage(1)">
            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
        </button>
        <a class="icon_blue fabu" style="margin: 0px;" id="fabu" href="${wlpt}/wlpt/goods/toSave"
           onclick="return check();" target="content">
            <span class="btn btn-warning"
                  style="border-radius:0px;background-color:#FFC52F;border-color:#FFC52F;width:80px;height:36px;">发布</span></a>
    </form>
</div>
<table class="goods-manage">
    <thead>
    <tr class="goods_col_1" style="border:none;">
        <td style="width:30%">始发地-目的地</td>
        <td style="width:15%">货物名称</td>
        <td style="width:20%">重量/体积</td>
        <td style="width:15%">发货日期</td>
        <td style="width:20%">操作</td>
    </tr>
    </thead>
    <tbody class="datainit">
        <tr ng-repeat="x in data">
            <td>
                {{x.shipAddress.city}}{{x.shipAddress.district}}→{{x.consignAddress.city}}{{x.consignAddress.district}}
            </td>
            <td>
                <p>{{x.goodsname}}</p>
                <p ng-show="x.isinsur == 1" style="color: red;">货物需投保</p>
            </td>
            <td>
                <p>{{x.freightvolume | number:3}}{{x.freightunit}}</p>
                <p>剩余:{{x.residualvolume | number:3}}{{x.freightunit}}</p>
            </td>
            <td>
                <p>{{x.ymdDate}}</p>
                <p>{{x.quotecount}}人报价</p>
            </td>
            <td>
                <p class="last"><a href="${wlpt}/wlpt/goods/goodsInfo?id={{x.id}}" target="content"
                                   class="btn btn-warning">查看</a></p>
                <p class="last"><a ng-show="x.tradestatus == 0" href="${wlpt}/wlpt/goods/toSave?id={{x.id}}"
                                   class="btn btn-warning">编辑</a></p>
                <p class="last"><a ng-show="x.tradestatus == 0 && x.datasource == 0" href="javascript:;" ng-click="isDelete(x.id)"
                                   class="btn btn-warning">删除</a></p>
                <p class="last"><a ng-show="x.tradestatus != 0" href="${wlpt}/wlpt/goods/toQuoteInfo?id={{x.id}}"
                                   target="content" class="btn btn-warning">查看报价</a></p>
                <p class="last"><a ng-show="x.residualvolume>0" href="${wlpt}/wlpt/goods/toAddQuote?id={{x.id}}"
                                   class="btn btn-warning">添加报价</a></p>            
            </td>
            <%--
            <td><input id=gsid value="{{x.id}}" type="hidden"/>
                <button id="finishQuote" class="btn btn-warning" ng-if="x.tradestatus!=2">结束报价</button>
                <button class="btn btn-warning" ng-if="x.tradestatus==2">报价结束</button>
            </td>
            --%>
        </tr>
    </tbody>
    <%--<tr>
        <td>陕西省太原市→陕西省太原市</td>
        <td>000000</td>
        <td>
            <p>38676吨</p>
            <p>剩余:38676吨</p>
        </td>
        <td>
            <p>2016-8-11</p>
            <p>1人报价</p>
        </td>
        <td><a href="个人中心二级菜单内容/货源查看.html" target="content" class="chakan">查看</a><a href="个人中心二级菜单内容/货源发布.html"
                                                                                    target="content"
                                                                                    class="baojia">报价</a></td>
        <td>
            <button class="btn btn-warning" id="goods_btn_warning">结束报价</button>
        </td>
    </tr>

    <tr>
        <td>陕西省太原市→陕西省太原市</td>
        <td>000000</td>
        <td>
            <p>38676吨</p>
            <p>剩余:38676吨</p>
        </td>
        <td>
            <p>2016-8-11</p>
            <p>1人报价</p>
        </td>
        <td><a href="个人中心二级菜单内容/货源查看.html" target="content" class="chakan">查看</a><a href="个人中心二级菜单内容/货源发布.html"
                                                                                    target="content"
                                                                                    class="baojia">报价</a></td>
        <td>
            <button class="btn btn-warning" id="goods_btn_warning">结束报价</button>
        </td>
    </tr>

    <tr style="border:none;">
        <td>陕西省太原市→陕西省太原市</td>
        <td>000000</td>
        <td>
            <p>38676吨</p>
            <p>剩余:38676吨</p>
        </td>
        <td>
            <p>2016-8-11</p>
            <p>1人报价</p>
        </td>
        <td>
            <a href="个人中心二级菜单内容/货源查看.html" target="content" class="chakan">查看</a>
            <a href="#" class="bianji">编辑</a>
            <a href="#" class="baojia">删除</a>
        </td>
        <td>
            <button class="btn btn-default" id="chongfa">一键重发</button>
        </td>
    </tr>--%>

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
<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic}/common/jeesite.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
if('${isRedrect}' == 'true'){
	 $("#fromprovince").val($.cookie("goods_fromprovince"));
     $("#fromcity").val($.cookie("goods_fromcity"));
	 $("#fromdistrict").val($.cookie("goods_fromdistrict"));
     $("#toprovince").val($.cookie("goods_toprovince"));
     $("#tocity").val($.cookie("goods_tocity"));
     $("#todistrict").val($.cookie("goods_todistrict"));
     $("#tradestatus").val($.cookie("goods_tradestatus")); 	
}


    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            fromprovince: '',
            fromcity: '',
            fromdistrict: '',
            toprovince: '',
            tocity: '',
            todistrict: '',
            tradestatus: ''

        };
        $scope.isDelete = function (id) {

            if (id == null || id == "") {
                return;
            }
           // $(".loading_lock").show();
            $.MsgBox.Confirm("删除提示","是否删除该货源?", function () {
            	$.ajax({
                    url: "${wlpt}/wlpt/goods/deleteGoods",
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
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
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
            url: '${wlpt}/wlpt/goods/getGoodsList',
            method: 'post',
            params: {             
                'shipAddress.province': $("#fromprovince").val(),
                'shipAddress.city': $("#fromcity").val(),
                'shipAddress.district': $("#fromdistrict").val(),
                'consignAddress.province': $("#toprovince").val(),
                'consignAddress.city': $("#tocity").val(),
                'consignAddress.district': $("#todistrict").val(),
                'tradestatus': $("#tradestatus").val(),  
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
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
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
                url: '${wlpt}/wlpt/goods/getGoodsList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'shipAddress.province': $("#fromprovince").val(),
                    'shipAddress.city': $("#fromcity").val(),
                    'shipAddress.district': $("#fromdistrict").val(),
                    'consignAddress.province': $("#toprovince").val(),
                    'consignAddress.city': $("#tocity").val(),
                    'consignAddress.district': $("#todistrict").val(),
                    'tradestatus': $("#tradestatus").val()
                }
            }).success(function (response) {
            	$.cookie("goods_tradestatus",$("#tradestatus").val());
            	$.cookie("goods_fromprovince",$("#fromprovince").val());
            	$.cookie("goods_fromcity",$("#fromcity").val());
            	$.cookie("goods_fromdistrict",$("#fromdistrict").val());
            	$.cookie("goods_toprovince",$("#toprovince").val());
            	$.cookie("goods_tocity",$("#tocity").val());
            	$.cookie("goods_todistrict",$("#todistrict").val());
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
                	$scope.pages.push(i + 1);
                    /* var num = $scope.currentPage - 3;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1); */
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
    $("#addressStart").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
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
            $("#addressStart").val(str);
        }
    });

    $("#addressEnd").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
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
            $("#addressEnd").val(str);
        }
    });

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
