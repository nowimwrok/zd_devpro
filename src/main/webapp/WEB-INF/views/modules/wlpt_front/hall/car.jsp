<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>车源大厅</title>
    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff;
            font-family: "微软雅黑";
        }

        @media screen and (max-width: 900px) {
            body {
                font-size: 1rem;
            }
        }

        .cloud-img img {
            width: 100%;
            height: 100%;
        }



        .loading {
            text-align: center;
            height: 45px;
            width: 100%;
        }

        .search-in {
            width: 28%;
            height: 45px;
            border: 2px solid #00A2E9;
        }

        .search-btn a {
            color: #fff;
            padding-top: 15px;
            padding-bottom: 15px;
        }

        .line-wrap li:hover {
            background-color: #01a1ea;
            color: #fff;
        }

        .active {
            background-color: #01a1ea;
            color: #fff;
        }

        .warehouse-detail h4 {
            color: #00A2E9;
            margin-bottom: 15px;
            font-weight: bold;
            background: none;
            border: none;
        }
        input[type="text"] {
            background-color: white;
        }
        .sort-first, .sort-second{
            display: inline-block;
            *display:inline;
            *zoom:1;
            width:30%;
        }
		#gjcx_span:hover{
			color: #333;
		}
    </style>
</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">

    <div class="search-bg">
        <form action="" method="get" class="search-bar" style="text-align: center">
            <input type="text" value="" class="search-in" readonly="readonly" ng-model="searchData.addressStart"
                   name="search-in" id="addressStart"
                   placeholder="出发地">
            <img src="${ctxStatic }/images/wlptfront/qiehuan.png">
            <input type="text" value="" class="search-in" readonly="readonly" ng-model="searchData.addressEnd"
                   name="search-in" id="addressEnd"
                   placeholder="目的地">
            <button type="button" name="search-btn" id="search-btn" ng-click="onSelectPage(1)"><a>搜索</a></button>
            <span id="gjcx_span"  style="padding-left: 30px;cursor: pointer;">高级查询
            <img style="width:17px;position: relative;top: -1px;left: 3px;" src="${ctxStatic}/images/wlptfront/triangle.png">
            </span>
        </form>
    </div>

    <div class="list-l">
    <div id="gjcx" style="display: none;">
        <div class="genre all-css left-css">
            <div class="line-wrap line-wrap-first" style="clear:both;">
                <span class="genre-title">车型要求：</span>
                <ul class="car_require all-ul" ng-model="searchData.cartype;active">
                    <li ng-repeat="t in carType" ng-click="searchData.cartype=t.value;clickType(t.id);onSelectPage(1)"
                        ng-class="{active: type_id == t.id}">{{t.label}}
                    </li>
                </ul>
            </div>
            <br>

            <div class="line-wrap" style="clear:both;">
                <span class="genre-title">车长要求：</span>
                <ul class="carLength_req all-ul"
                    ng-model="searchData.carlength;searchData.beginCarlength;sarchData.endCarlength">
                    <li ng-repeat="l in carLength"
                        ng-click="searchData.carlength=l.value;clickLength(l.id);onSelectPage(1);"
                        ng-class="{active: length_id == l.id}">{{l.label}}
                    </li>

                </ul>
            </div>

            <div class="line-wrap" style="clear:both;">
                <span class="genre-title">货物重量：</span>
                <ul class="goods_weight all-ul"
                    ng-model="searchData.loadweight;searchData.beginLoadWeight;searchData.endLoadWeight;">

                    <li ng-repeat="wt in load_weight"
                        ng-click="searchData.loadweight=wt.value;clickWeight(wt.id);onSelectPage(1)"
                        ng-class="{active: weight_id == wt.id}">
                        {{wt.label}}
                    </li>

                </ul>
            </div>
            
            <div class="line-wrap sort-first" style="width:100%;">
                <span class="genre-title">排序方式：</span>
                <ul class="sort_style all-ul pull-left" ng-model="searchData.orderBy">
                    <li class="active" ng-click="searchData.orderBy='';onSelectPage(1)">默认</li>
                    <li ng-click="searchData.orderBy='cs.UPDATE_DATE desc ,a.Update_Date desc';onSelectPage(1)">最新</li>
                    <li ng-click="searchData.orderBy='a.loadweight desc';onSelectPage(1)">载重</li>
                </ul>
                
            </div>
            <div class="line-wrap">
	            <span class="genre-title">平台车辆：</span>
	            <ul class="sort_style all-ul pull-left">
	            	<li class="choose_car">
	            		<a target="_blank" style="padding: 5px 10px;" class="btn btn-default btn-mini" href="${wlpt}/wlpt/hall/towlptCar" 
			            style="">平台车辆</a>
	            	</li>
	            </ul>
            </div>
            
        </div>

        </div>
        <div id="data_list" hidden="hidden">
            <div class="all-css left-css warehouse-list" ng-repeat="x in data">
                <div class="warehouse-detail" style="width:15%;padding-left: 10px;">
                    <h4 class="clearfix">
                    	<a target="_blank" class="hall-user" href="${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}">{{x.user.loginName!=null?x.user.loginName:"保密"}}</a>
                    	<img class="hall-user-level" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_{{x.user.pointlevle!=null?x.user.pointlevle:0}}.gif">
                    </h4>
                    <p>车牌号码:&nbsp;{{x.carnumber}}</p>
                    <!-- <p>联系方式：{{x.user.phone != null ? x.user.phone:"保密"}}</p> -->
                </div>
                <div class="warehouse-price" style="margin-top: 26px;">
                	<p>{{x.cartype}}<span class="vertical-line">|</span>{{x.carlength}}米<span
                            class="vertical-line">|</span>{{x.loadweight}}吨</p>
                </div>
                <div class="warehouse-price" style="width:24%;margin-top: 26px;">
                    <p>{{x.mainroad.split('-')[0]!=null?x.mainroad.split('-')[0]:"全国"}}
                       <img src="${ctxStatic}/images/wlptfront/left-right.png">
                       {{x.mainroad.split('-')[1]!=null?x.mainroad.split('-')[1]:"全国"}}</p>
                </div>
                <div class="warehouse-price" style="margin-top: 16px;width: 20%;" >
                    <p title="{{x.gpsloc.info!=null?x.gpsloc.info:'暂无定位信息'}}">当前位置：{{x.gpsloc.info!=null?x.gpsloc.info.substr(0,11)+'...':"暂无定位信息"}}</p>
                    <!-- <p>定位时间：{{x.gpsloc.gpstime!=null?x.gpsloc.formatgpstime:"暂无定位信息"}}</p> -->
                	<!-- <p ng-if="x.carsourceid!='' && x.carsourceid!=null">车源状态：{{x.carsourcestatus}}</p> -->
                	<p ng-if="x.carsourceid!='' && x.carsourceid!=null">发车时间：{{x.departuretime}}</p>
                </div>
                <div  id="btn-grab" style="float: right;width: 13%;line-height:70px;">
                    <a href="${wlpt}/wlpt/hall/getCarInfo?id={{x.id}}&carsourceid={{x.carsourceid}}" class="btn btn-warning" style="width: 70px;">查&nbsp;&nbsp;看</a>
                </div>
            </div>
        </div>
    </div>
    <div class="loading" style="height: 70px;"><img src="${ctxStatic}/images/loading.gif">
        <p>加载中</p>
    </div>
    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>

    <div class="paging" id="paging">
        <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
            <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">首页</a></li>
            <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></li>
            <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
                <a ng-click="selectPage(page)">{{page}}</a>
            </li>
            <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
            <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">尾页</a></li>
        </ul>
    </div>


</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    $(function(){
    	$("#gjcx_span").toggle(
 			  function(){
 				  
 				  	  $("#gjcx").slideDown(1000);
 				  },
 			  function(){
 					  $("#gjcx").slideUp(1000);
 				  }
 			);
    			
    			
        $(".car_nature li").click(function(){
            $(".car_nature li").removeClass("active");
            $(this).addClass("active");
        });
        $(".sort_style li").click(function(){
            $(".sort_style li").removeClass("active");
            $(this).addClass("active");
        });
        $('.cloud-img img').jqthumb({
            width: $(".cloud-img").width(),
            height: 125,
            after: function (imgObj) {
                imgObj.css('opacity', 0).animate({
                    opacity: 1
                }, 1000);
            }
        });
    });
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {

        $scope.currentPage = 1;  ///当前分页
        $scope.pageSize = 10;    ///页面显示条数
        $scope.pages = [];       ///显示分页数
        ///初始化搜索条件
        $scope.searchData = {
            cartype: '', carlength: '', loadweight: '', addressEnd: '', addressStart: '',
            beginCarlength: '', endCarlength: '', beginLoadWeight: '', endLoadWeight: '',
            orderBy: ''
        };
        $scope.clickType = function (id) {
            $scope.type_id = id;
        };
        $scope.clickLength = function (id) {
            $scope.length_id = id;
        };

        $scope.clickWeight = function (id) {
            $scope.weight_id = id;
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
            }
        };

        ///加载车辆类型
        $http.get("${wlpt}/getDictListJson?type=car_type").success(function (response) {
            $scope.carType = response;
        });
        ///车辆 长度
        $http.get("${wlpt}/getDictListJson?type=car_length").success(function (response) {
            $scope.carLength = response;
        });
        $http.get("${wlpt}/getDictListJson?type=load_weight").success(function (response) {
            $scope.load_weight = response;
        });

        //get first page
        $http({
            url: '${wlpt}/wlpt/hall/getCarList',
            method: 'post',
            params: {
                'orderBy': $scope.searchData.orderBy,
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
            ///当数据为空的时候
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
            //分页要repeat的数组  pages---显示的分页页码
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
            $("#data_list").show();
        });


        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            if ($scope.searchData.carlength.indexOf('-') >= 0) {
                $scope.searchData.beginCarlength = $scope.searchData.carlength.substr(0, $scope.searchData.carlength.indexOf('-'));
                $scope.searchData.endCarlength = $scope.searchData.carlength.substr($scope.searchData.carlength.indexOf('-') + 1, $scope.searchData.carlength.length);
                $scope.searchData.carlength = '';
            } else {
                $scope.searchData.beginCarlength = "";
                $scope.searchData.endCarlength = "";
            }
            if ($scope.searchData.loadweight.indexOf('-') >= 0) {
                $scope.searchData.beginLoadWeight = $scope.searchData.loadweight.substr(0, $scope.searchData.loadweight.indexOf('-'));
                $scope.searchData.endLoadWeight = $scope.searchData.loadweight.substr($scope.searchData.loadweight.indexOf('-') + 1, $scope.searchData.loadweight.length);
                $scope.searchData.loadweight = '';
            } else {
                $scope.searchData.beginLoadWeight = '';
                $scope.searchData.endLoadWeight = '';
            }
            $http({
                url: '${wlpt}/wlpt/hall/getCarList',
                method: 'post',
                params: {
                    'addressStart': $("#addressStart").val(),
                    'addressEnd': $("#addressEnd").val(),
                    'cartype': $scope.searchData.cartype,
                    'carlength': $scope.searchData.carlength,
                    'loadweight': $scope.searchData.loadweight,
                    'beginCarlength': $scope.searchData.beginCarlength,
                    'endCarlength': $scope.searchData.endCarlength,
                    'beginLoadWeight': $scope.searchData.beginLoadWeight,
                    'endLoadWeight': $scope.searchData.endLoadWeight,
                    'issocialcar': $scope.searchData.issocialcar,
                    'orderBy': $scope.searchData.orderBy,
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
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
                //分页要repeat的数组
                $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
                for (var i = 0; i < $scope.newPages; i++) {
                    var num = $scope.currentPage - 3;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1);
                }
                $("#data_list").show();
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
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME + "";
                $("#startProvince").val(data.province.NAME);
                $("#addressStart").val(str);
            }
            if (data.city) {
                str += data.city.NAME + "";
                $("#startCity").val(data.city.NAME);
                $("#addressStart").val(str);
            }
            if (data.county) {
                str += data.county.NAME;
                $("#startDistrict").val(data.county.NAME);
                $("#addressStart").val(str);
            }
            if (str != "") {
                $("#addressStart").val(str);
            } else {
                $("#addressStart").val("");
            }

        }
    });
    $("#addressEnd").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME + "";
                $("#endProvince").val(data.province.NAME);
                $("#addressEnd").val(str);
            }
            if (data.city) {
                str += data.city.NAME + "";
                $("#endCity").val(data.city.NAME);
                $("#addressEnd").val(str);
            }
            if (data.county) {
                str += data.county.NAME;
                $("#endDistrict").val(data.county.NAME);
                $("#addressEnd").val(str);
            }
            if (str != "") {
                $("#addressEnd").val(str);
            } else {
                $("#addressEnd").val("");
            }

        }
    });

</script>
</body>
</html>
