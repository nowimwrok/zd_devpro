<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>招标大厅</title>

    <style type="text/css" >
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

        .car-details p {
            text-align: center;
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

        .sort-first, .sort-second {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            width: 30%;
        }
        .logistics {
		    font-size: 14px;
		    color: #333;
		    margin-right: 8px;
		}
    </style>
</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <input id="status" value="${user.userinfo.status}" type="hidden"/>
    <div class="search-bg">
        <form action="" method="get" class="search-bar" style="text-align: center">
            <input id="fromprovince" type="hidden" class="search-in" ng-model="searchData.fromprovince"
                   name="search-in"/>
            <input id="fromcity" type="hidden" class="search-in" ng-model="searchData.fromcity" name="search-in"/>
            <input id="fromdistrict" type="hidden" class="search-in" ng-model="searchData.fromdistrict"
                   name="search-in"/>
            <input type="text" readonly="readonly" class="search-in" id="addressStart" placeholder="出发地">
            <img src="${ctxStatic }/images/wlptfront/qiehuan.png">
            <input type="text" class="search-in" readonly="readonly" id="addressEnd" placeholder="目的地">
            <input id="toprovince" type="hidden" class="search-in" ng-model="searchData.toprovince" name="search-in"/>
            <input id="tocity" type="hidden" class="search-in" ng-model="searchData.tocity" name="search-in"/>
            <input id="todistrict" type="hidden" class="search-in" ng-model="searchData.todistrict" name="search-in"/>
            <button type="button" name="search-btn" id="search-btn" ng-click="onSelectPage(1)"><a>搜索</a></button>
            <span id="gjcx_span"  style="padding-left: 30px;cursor:pointer;">高级查询<img style="width:17px;position: relative;top: -1px;left: 3px;" src="${ctxStatic}/images/wlptfront/triangle.png"></span>
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
            <div class="line-wrap sort-first">
                <span class="genre-title">排序方式：</span>
                <ul class="sort_style all-ul" ng-model="searchData.orderBy">
                    <li class="active" ng-click="searchData.orderBy='';onSelectPage(1)">默认</li>
                    <li ng-click="searchData.orderBy='a.endtime desc';onSelectPage(1)">截标时间</li>
                    <li ng-click="searchData.orderBy='gds.freightvolume desc';onSelectPage(1)">运量</li>
                </ul>
            </div>
        </div>

        
      </div>
        <div id="data_list" class="datainit">
            <div class="all-css left-css list-wrap" ng-repeat="x in data">
                <div class="list-left">
                    <p class="logi-tim">
                        <span class="logistics clearfix" style="display:block;">
	                        <a target="_blank" class="hall-user" href="${wlpt}/wlpt/credit/getCreditByUser?id={{x.biduser.id}}">{{x.biduser.loginName}}</a>
	                        <img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_{{x.biduser.pointlevle!=null?x.biduser.pointlevle:0}}.gif">
                        </span>
                    </p>
                    <p class="logi-tim">
                        电话：
                        <c:if test="${user.userinfo.status!=null}">
                            <span class="logistics">{{x.biduser.phone }}</span>

                        </c:if>
                        <c:if test="${user.userinfo.status==null}">
                            <span class="logistics">{{x.biduser.phone.substr(0,6)+"****" }}</span>
                        </c:if>
                        <%--<span class="fabu-time">09:45</span>
                        发布--%>
                    </p>
                    <%--<p class="busi-attes"><span class="business">电话</span><span class="attestation">未认证</span></p>--%>
                </div>

                <div class="list-change">
                    
                    <p>
                        <span class="city-blue">{{x.goods.shipAddress.city}}</span>
                        <%-- <img src="/static/images/wlptfront/left-right.png">--%>
                        <img src="${ctxStatic}/images/wlptfront/left-right.png">
                        <span class="city-blue">{{x.goods.consignAddress.city}}</span>
                    </p>
                </div>

                <div class="car-details">
                    <p>
                    	<span style="line-height: 20px;margin: 0">{{x.goods.goodsname}}</span>
                    	<span class="vertical-line">|</span>
                        <span class="car-weight"
                              style="padding: 0px;">{{x.goods.freightvolume+' '+x.goods.freightunit}}</span>
                    </p>
                </div>
                <div class="car-details" style="width:24%;">
                    <p>
                       	<span class="fabu-time" style="color:#ff8e00;">{{x.bidstatus!='发布'?x.bidstatus:'竞标中'}}</span>
                       	<span class="vertical-line">|</span>
                       	 截止时间:<span class="fabu-time endtime" id="showEndtime{{$index}}">{{x.endtime.substr(0,20)}}</span>
                    </p>
                </div>
                <div class="btn-grab all_button" ng-if="x.bidstatus=='发布'"  style="text-align: right;">
	                <span ng-if="x.biddingList.length > 0" style="color:red;font-size:25px;padding-left:25px;padding-right: 25px;float: right;">已投标</span>	
                			<a ng-if="x.biddingList==null" style="margin-right: 35px;"
	                       			href="javascript:void(0)" ng-click="check(x.id)" target="_blank" class="btn btn-warning">竞&nbsp;&nbsp;标</a>
                		
                </div>
            </div>
        </div>
        <div class="loading"><img src="${ctxStatic}/images/loading.gif">
            <p>加载中</p></div>

        <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>

    </div>
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
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>

<script>
	$("#gjcx_span").toggle(
		  function(){
			  
			  	  $("#gjcx").slideDown(1000);
			  },
		  function(){
				  $("#gjcx").slideUp(1000);
			  }
		);
		
		
    $(".sort_style li").click(function () {
        $(".sort_style li").removeClass("active");
        $(this).addClass("active");
    });
    //var shotime = new Object();
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {

        $scope.check = function (id) {
            var status = $("#status").val();
            if (!status) {
                $.alert("登录后才能竞标");
                return false;
            } else if (status != '2') {
                $.alert("认证后才能竞标");
                return false;
            } else {
                window.location.href = "${wlpt}/wlpt/bid/toBidding?bidinfoId=" + id;
                return true;
            }
        };


        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            cartype: '', carlength: '', loadweight: '', addressEnd: '', addressStart: '', fromprovince: '',
            fromcity: '', fromdistrict: '', toprovince: '', tocity: '', todistrict: '',
            beginCarlength: '', endCarlength: '', beginLoadWeight: '', endLoadWeight: '',
            orderBy: '', issocialcar: ''
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
                $(".datainit").removeClass("datainit");
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
            url: '${wlpt}/wlpt/hall/getbidsList',
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
            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }

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
                url: '${wlpt}/wlpt/hall/getbidsList',
                method: 'post',
                params: {
                    'goods.shipAddress.province': $("#fromprovince").val(),
                    'goods.shipAddress.city': $("#fromcity").val(),
                    'goods.shipAddress.district': $("#fromdistrict").val(),
                    'goods.consignAddress.province': $("#toprovince").val(),
                    'goods.consignAddress.city': $("#tocity").val(),
                    'goods.consignAddress.district': $("#todistrict").val(),
                    'goods.cartype': $scope.searchData.cartype,
                    'goods.carlength': $scope.searchData.carlength,
                    'goods.freightvolume': $scope.searchData.loadweight,
                    'goods.beginCarlength': $scope.searchData.beginCarlength,
                    'goods.endCarlength': $scope.searchData.endCarlength,
                    'goods.beginFreightvolume': $scope.searchData.beginLoadWeight,
                    'goods.endFreightvolume': $scope.searchData.endLoadWeight,
                    'goods.gsoddtype': $scope.searchData.gsoddtype,
                    'goods.searchinfo': $scope.searchData.searchinfo,
                    'orderBy': $scope.searchData.orderBy,
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {
               // window.clearInterval(shotime);
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
    /*window.setTimeout("czEndtimes()",2000);
    window.setInterval("czEndtimes()", 1000);
    function czEndtimes() {
        var endtime=$(".endtime");
        if (endtime.length > 0) {
            for (var o = 0; o < endtime.length; o++) {
                var end = $("#showEndtime" + o).html();
                var obj = $("#showEndtime" + o);
                var now = new Date();
                if (now > end) {
                    $(obj).html("已到截止时间");
                } else {
                    showTime(obj, end);
                }
            }
        }
    }
    ;*/
    function showTime(o, oo) {
        var now = new Date();
        var s1 = now.getTime();
        var s2 = oo.getTime();
        var total = (s2 - s1) / 1000;
        var day = parseInt(total / (24 * 60 * 60));
        var afterDay = total - day * 24 * 60 * 60;
        var hour = parseInt(afterDay / (60 * 60));
        var afterHour = total - day * 24 * 60 * 60 - hour * 60 * 60;
        var min = parseInt(afterHour / 60);
        var afterMin = total - day * 24 * 60 * 60 - hour * 60 * 60 - min
                * 60;
        $(o).html(
                "截止时间还有<br>" + (day == 0 ? "" : (day + "天"))
                + (hour == 0 ? "" : (hour + "时"))
                + (min == 0 ? "" : (min + "分"))
                + Math.round(afterMin) + "秒");
    }
    $("#addressStart").PCC({
        hasCounty: false, //设置为false不显示县区
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
        hasCounty: false,//设置为false不显示县区
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
