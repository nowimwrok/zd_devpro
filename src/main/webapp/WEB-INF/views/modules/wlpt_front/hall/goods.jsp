<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>

<html>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>

    <title>货源大厅</title>
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

       /* #btn-grab {
            margin-top: 5%;
        }
*/
        .warehouse-price {
            margin-top: 25px;
            width:25%;
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

        .line-wrap li:hover {
            background-color: #01a1ea;
            color: #fff;
        }

        .active {
            background-color: #01a1ea;
            color: #fff;
        }

        #ogorder > div {
            float: left;
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
            width:25%;
        }
		input.serch_con_input{
		    height: 30px;
		    line-height: 30px;
		    border-radius: 2px;
		    box-shadow: none;
		    border: 1px solid #ccc;
		    position:relative;
		    top:-2px;
		}
    </style>
</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="search-bg">
        <form action="" method="get" class="search-bar" style="text-align: center">
            <input id="fromprovince"  type="hidden" class="search-in" ng-model="searchData.fromprovince" name="search-in"/>
            <input id="fromcity" type="hidden" class="search-in" ng-model="searchData.fromcity" name="search-in"/>
            <input id="fromdistrict"  type="hidden" class="search-in" ng-model="searchData.fromdistrict" name="search-in"/>
            <input type="text" readonly="readonly" class="search-in" id="addressStart" placeholder="出发地">
            <img src="${ctxStatic }/images/wlptfront/qiehuan.png">
            <input type="text" class="search-in" readonly="readonly" id="addressEnd" placeholder="目的地">
            <input id="toprovince" type="hidden" class="search-in" ng-model="searchData.toprovince" name="search-in"/>
            <input id="tocity" type="hidden" class="search-in" ng-model="searchData.tocity" name="search-in"/>
            <input id="todistrict" type="hidden" class="search-in" ng-model="searchData.todistrict" name="search-in"/>
            <button type="button" name="search-btn" id="search-btn" ng-click="onSelectPage(1)"><a>搜索</a></button>
            <span id="gjcx_span" style="padding-left: 30px;cursor:pointer;">高级查询<img style="width:17px;position: relative;top: -1px;left: 3px;" src="${ctxStatic}/images/wlptfront/triangle.png"></span>
        </form>
    </div>

    <div class="list-l">
    <div id="gjcx" style="display: none;">
        <div class="genre all-css left-css">
            <div class="line-wrap line-wrap-first" style="clear:both;">
                <span class="genre-title">车型要求：</span>
                <ul class="car_require all-ul" ng-model="searchData.cartype;active">
                    <%--
                                    <li ng-click="searchData.cartype='' clickme(0)"  ng-class="{active: currentId == '0' || $index==0}">不限</li>
                    --%>
                    <li ng-repeat="t in carType" ng-click="searchData.cartype=t.value;clickType(t.id);onSelectPage(1)"
                        ng-class="{active: type_id == t.id}">{{t.label}}
                    </li>
                </ul>
            </div>
            <br>

            <div class="line-wrap" style="clear:both;">
                <span class="genre-title">车长要求：</span>
                <ul class="carLength_req all-ul"
                    ng-model="searchData.carlength;searchData.beginCarlength;searchData.endCarlength">
                    <%--
                                    <li class="active" ng-click="searchData.carlength=''">不限</li>
                    --%>
                    <li ng-repeat="l in carLength"
                        ng-click="searchData.carlength=l.value;clickLength(l.id);onSelectPage(1)"
                        ng-class="{active: length_id == l.id}">{{l.label}}
                    </li>

                </ul>
            </div>

            <div class="line-wrap" style="clear:both;">
                <span class="genre-title">货物重量：</span>
                <ul class="goods_weight all-ul"
                    ng-model="searchData.loadweight;searchData.beginLoadWeight;searchData.endLoadWeight">
                    <%--
                                    <li class="active" ng-click="searchData.loadweight=''">不限</li>
                    --%>
                    <li ng-repeat="wt in load_weight"
                        ng-click="searchData.loadweight=wt.value;clickWeight(wt.id);onSelectPage(1)"
                        ng-class="{active: weight_id == wt.id}">
                        {{wt.label}}
                    </li>

                </ul>
            </div>
            <div class="clearfix">
	            <div class="line-wrap sort-first pull-left">
	                <span class="genre-title">排序方式：</span>
	                <ul class="sort_style all-ul" ng-model="searchData.orderBy">
	                    <li class="active" ng-click="searchData.orderBy='';onSelectPage(1)">默认</li>
	                    <li ng-click="searchData.orderBy='';onSelectPage(1)">最新</li>
	                    <li ng-click="searchData.orderBy='a.freightvolume desc';onSelectPage(1)">运输量</li>
	                </ul>
	            </div>
	            <div class="line-wrap sort-second pull-left">
	                <span class="genre-title">货源类型：</span>
	                <ul class="car_nature all-ul" ng-model="searchData.gsoddtype">
	                    <li class="active" ng-click="searchData.gsoddtype='';onSelectPage(1)">不限</li>
	                    <li ng-click="searchData.gsoddtype='1';onSelectPage(1)">成品</li>
	                    <li ng-click="searchData.gsoddtype='2';onSelectPage(1)">原材料</li>
	                </ul>
	            </div>
	            <div class="line-wrap sort-second pull-left">
	                <span class="genre-title">发货人：</span>
	                <input type="text" ng-model="searchData.searchinfo" class="serch_con_input"
	                       placeholder="发货人/手机号码" ng-change="onSelectPage(1)"/>
	            </div>
	          </div>
        </div>
      </div>
        <!-- 用户未通过车主验证提示 -->
        <%-- <div class="header">
			<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
				<label id="loginError" class="error">${message}</label>
			</div>
		</div> --%>
        <div id="data_list" hidden="hidden">
            <div class="all-css left-css war warehouse-list ehouse-list" ng-repeat="x in data">
               
                <div class="warehouse-detail" style="width:18%;margin: 0px;padding-left: 10px;margin-top: 18px;">
                    <h4 style="margin:5px 0px 20px 0px;" class="clearfix">
	                    <a target="_blank" class="hall-user" href="${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}">{{x.user.loginName!=null?x.user.loginName:"保密"}}</a> 
	                    <img class="hall-user-level" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_{{x.user.pointlevle!=null?x.user.pointlevle:0}}.gif">
                     </h4>
                     <p>电话:{{x.user.phone != null ? x.user.phone:"保密"}}</p>
                   
                </div>
                <div class="warehouse-detail" style="width: 24%;margin-top: 28px;">     
                    <p>
                    	<a href='${wlpt}/wlpt/hall/getGoodsInfo?id={{x.id}}' title="货物名称">{{x.goodsname}}</a>
                    	<span class="vertical-line">|</span>
                    	<span title="货物类型">{{x.gsoddtype}}</span>
                       	 <span class="vertical-line">|</span>
                       	 <span title="货源价格">{{x.expectedprice}}元/吨</span>
                    </p>
                    <p>
                       	 <span  title="运量">运量：{{x.freightvolume | number:3}}{{x.freightunit}}</span>
                       	 <span class="vertical-line">|</span>
                       	 <span title="剩余">剩余：{{x.residualvolume | number:3}}{{x.freightunit}}</span>
                    </p>
                </div>
                <div class="warehouse-price" style="width: 19%;margin-top: 28px;">
                	<p ng-show="x.status != 3 && x.status != 4 " style="color: #3a3;">{{x.tradestatus}}</p>
                    <p ng-show="x.status == 3">已报价</p>
                    <p ng-show="x.status == 4" style="color: #ff8e00;">报价结束</p>
                	<p>装车时间:{{x.sendtime}}</p>
                </div>
                <div class="warehouse-price">
                     <p ng-show="x.isinsur == 1">
                     	<span ng-show="x.isinsur == 1" style="color: red;">货物需投保</span>
                     	<span class="vertical-line">|</span> 保单支付方:{{x.paypeople}}</p>
                    <p style="margin-top: 8px;">
                    {{x.shipAddress.city}}{{x.shipAddress.district}}
                    <img src="${ctxStatic}/images/wlptfront/left-right.png">
                    {{x.consignAddress.city}}{{x.consignAddress.district}}
                    </p>
                    
                    
                </div>
                <div class="btn-grab all_button" id="btn-grab">
                    <a class="btn btn-warning" ng-show="x.status == 1" style="margin-top:20px;margin-bottom:0px;width: 7%;" href='${wlpt}/wlpt/goods/goodsQuote?id={{x.id}}'>抢&nbsp;&nbsp;单</a>
                    <label class="btn btn-warning" ng-show="x.status == 3" style="margin-top:20px;margin-bottom:0px;width: 7%;">已报价</label>
                    <label class="btn btn-warning" ng-show="x.status == 4" style="margin-top:20px;margin-bottom:0px;width: 7%;">报价结束</label>
                    <a class="btn btn-warning" ng-show="x.status == 0" style="margin-top:20px;margin-bottom:0px;width: 7%;" href='${wlpt}/login?login=login'>抢&nbsp;&nbsp;单</a>
                </div>
            </div>
        </div>
    </div>
    <div class="loading"><img src="${ctxStatic}/images/loading.gif">
        <p>加载中</p></div>
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
        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];

        ///初始化搜索条件
        $scope.searchData = {
            cartype: '', carlength: '', loadweight: '', fromprovince: '', fromcity: '',fromdistrict: '', toprovince: '', tocity: '',todistrict: '',
            beginCarlength: '', endCarlength: '', beginLoadWeight: '', endLoadWeight: '',
            orderBy: '', gsoddtype: '', searchinfo: ''
        };
        ////li筛选条件的点击
        $scope.clickType = function (id) {
            $scope.type_id = id;
        };
        $scope.clickLength = function (id) {
            $scope.length_id = id;
        };

        $scope.clickWeight = function (id) {
            $scope.weight_id = id;
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
        //get first page
        $http({
            url: '${wlpt}/wlpt/hall/getGoodsList',
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
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
            //分页要repeat的数组
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
                url: '${wlpt}/wlpt/hall/getGoodsList',
                method: 'post',
                params: {
                	'shipAddress.province': $("#fromprovince").val(),
                    'shipAddress.city':  $("#fromcity").val(),
                    'shipAddress.district': $("#fromdistrict").val(),
                    'consignAddress.province':  $("#toprovince").val(),
                    'consignAddress.city':  $("#tocity").val(),
                    'consignAddress.district': $("#todistrict").val(),
                    'cartype': $scope.searchData.cartype,
                    'carlength': $scope.searchData.carlength,
                    'freightvolume': $scope.searchData.loadweight,
                    'beginCarlength': $scope.searchData.beginCarlength,
                    'endCarlength': $scope.searchData.endCarlength,
                    'beginFreightvolume': $scope.searchData.beginLoadWeight,
                    'endFreightvolume': $scope.searchData.endLoadWeight,
                    'gsoddtype': $scope.searchData.gsoddtype,
                    'searchinfo': $scope.searchData.searchinfo,
                    'orderBy':$scope.searchData.orderBy,
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
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        /* closeIcon: "/static/images/close_hover.png", */
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME + "";
                $("#addressStart").val(str);
                $("#fromprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME + "";
                $("#addressStart").val(str);
                $("#fromcity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                $("#addressStart").val(str);
                $("#fromdistrict").val(data.county.NAME);
            }
            if (str != "") {
                $("#addressStart").val(str);
            } else {
                $("#addressStart").val("");
            }

        }
    });
    $("#addressEnd").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        /* closeIcon: "/static/images/close_hover.png", */
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME + "";
                $("#addressEnd").val(str);
                $("#toprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME + "";
                $("#addressEnd").val(str);
                $("#tocity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                $("#addressEnd").val(str);
                $("#todistrict").val(data.county.NAME);
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
