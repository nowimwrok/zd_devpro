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
            margin-top: 15px;
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
            background-color: transparent;
        }

        .sort-first, .sort-second {
            display: inline-block;
            *display: inline;
            *zoom: 1;
            width: 30%;
        }

        .warehouse-list {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

        .warehouse-list > div {
            float: left;
            flex: auto;
        }

        .cloud-img {
            float: left;
            margin-left: 15px;
            margin-right: 15px;
            width: 5%;
            height: 70px;
        }

        .warehouse-detail {
            margin-top: -5px;
            float: left;
            text-align: left;
            width: 10%;
            text-indent: 5%;
        }

        .lcol {
            line-height: 70px;
        }

        .btn-warning {
            width: 100%;
        }

        #btn-grab {
            display: block;
            text-align: center;
            margin-right: 20px;
            display: block;
            width: 25px;
            line-height: 70px;
        }

        .warehouse-price {
            float: left;
            text-align: center;
            color: #84817D;
            line-height: 35px;
        }

        .cloud-img img {
            width: 50%;
            height: 100%;
            border: 1px solid #CCC;
            border-radius: 50%;
        }

        #lhead {
            background-color: #eee;
            color: #FFFFFF;
            height: 35px;
            margin-bottom: 10px;
        }

        #lhead > div {
            text-align: center;
            float: left;
            line-height: 7px;
            color: #080808;
        }

        #search-btn {
            background-color: #00A2E9;
            border: none;
            width: 80px;
            height: 30px;
            text-align: center;
            margin-top: -2px;
        }
        .active {
            background-color: #01a1ea;
            color: #fff;
        }
    </style>
</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">

    <div class="list-l">
        <div class="all-css left-css sort" id="ogorder">
            <div class="line-wrap sort-first">
                <span class="genre-title">排序方式：</span>
                <ul class="sort_style all-ul" ng-model="searchData.orderBy">
                    <li class="active" ng-click="searchData.orderBy='';onSelectPage(1)">默认</li>
                    <li ng-click="searchData.orderBy='a.successtrade desc';onSelectPage(1)">成交量</li>
                    <li ng-click="searchData.orderBy='a.biddingcount desc';onSelectPage(1)">竞标量</li>
                    <li ng-click="searchData.orderBy='a.addcarcount desc';onSelectPage(1)">车辆量</li>

                </ul>
            </div>
            <div class="line-wrap sort-second">
                <span class="genre-title">用户类型：</span>
                <ul class="car_nature all-ul" ng-model="searchData.enname">
                    <li class="active" ng-click="searchData.enname='';onSelectPage(1)">不限</li>
                    <li ng-click="searchData.enname='enterprise';onSelectPage(1)">物流企业</li>
                    <li ng-click="searchData.enname='carowner';onSelectPage(1)">车主</li>
                    <li ng-click="searchData.enname='goodsowner';onSelectPage(1)">货主</li>

                </ul>
            </div>
            <div class="line-wrap sort-second">
                <span class="genre-title">用户：</span>
                <input style=" padding: 0px; margin-top: -2px; width: 60%;" type="text" ng-model="searchData.searchinfo"
                       placeholder="用户名/企业公司/手机"/>
            </div>
            <div>
                <button style="margin-left: 0px;" type="button" name="search-btn" id="search-btn" ng-click="onSelectPage(1)"><a>搜索</a></button>
            </div>
        </div>
        <div class="all-css left-css sort" id="lhead">
            <div style="width: 5%; margin: 0 20px;">
                头像
            </div>
            <div class="warehouse-detail" style="margin: 0px;width: 15%;;">
                用户信息
            </div>
            <div style="width: 20%;">
                排名
            </div>
            <div style="width: 3%;">
                手机
            </div>
            <div style="margin: 0px;width: 25%;">
                诚信信息
            </div>
            <div style="width: 15%;float: right;">
                操作
            </div>
        </div>
        <div id="data_list" hidden="hidden">
            <div class="all-css left-css warehouse-list" ng-repeat="x in data">
                <div class="cloud-img">
                    <img onerror="this.onerror=null;this.src='/static/images/weixin/icon_personal.png'"
                         src="{{x.user.photo !=null ? x.user.photo:'/static/images/weixin/icon_personal.png'}}">
                    <p><span style="font-size: 11px;padding: 2px;background: #4975ef;color: #ffffff;margin-left: 15px;" ng-show="x.userinfo.status==2">已认证</span></p>
                </div>
                <div class="warehouse-detail" style="margin: 0px;">
                    <h4 title="{{x.user.loginName}}" style="margin:5px 0px 20px 0px;"><a target="_blank"
                                                            href="${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}">{{x.user.loginName.length>10?x.user.loginName.substr(0,10)+'……':x.user.loginName}}</a>
                        
                    </h4>
                    <p>
                    诚信等级:&nbsp;<img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_{{x.userinfo.pointlevle!=null?x.userinfo.pointlevle:0}}.gif">
                    </p>
                    <p ng-show="x.role.enname=='enterprise'">

                        企业:&nbsp;<a href='${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}'>{{x.userinfo.companyname.length>6?x.userinfo.companyname.substr(0,6)+'……':x.userinfo.companyname}}</a>
                    </p>
                    <p ng-show="x.role.enname!='enterprise'">

                        姓名:&nbsp;<a href='${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}'>{{x.user.name}}</a>
                    </p>
                </div>
                <div class="lcol">
                    <p ng-if="$index+1<10">
                        <span>{{(currentPage-1)}}{{$index+1}}</span>
                    </p>
                    <p ng-if="$index+1==10">
                        <span>{{currentPage}}0</span>
                    </p>
                </div>
                <div class="lcol">{{x.user.phone}}
                </div>
                <div ng-show="x.role.enname=='carowner'" class="warehouse-price"
                     style="margin: 0px;line-height: 17px;text-align: left;">
                    <!--司机-->
                    <p>报价：{{x.quotecount}}次</p>
                    <p>成交：{{x.successtrade}}单</p>
                    <p>共：{{x.addcarcount}}辆车</p>
                </div>
                <!--货主-->
                <div ng-show="x.role.enname=='goodsowner'" class="warehouse-price"
                     style="margin: 0px;line-height: 17px;text-align: left;">
                    <p>招标：{{x.pubbidcount}}标</p>
                    <p>发布：{{x.pubgodscount}}条货源</p>
                    <p>成交：{{x.successtrade}}单</p>
                </div>
                <!--物流企业-->
                <div ng-show="x.role.enname=='enterprise'" class="warehouse-price"
                     style="margin: 0px;line-height: 17px;text-align: left;">
                    <p>成功竞标：{{x.biddingcount}}标</p>
                    <p>发布：{{x.pubgodscount}}条货源</p>
                    <p>成交：{{x.successtrade}}单</p>
                </div>
                <div class="btn-grab all_button" id="btn-grab">
                    <a class="btn btn-warning"
                       style="margin-top:-2px;margin-bottom:0px;border-color:#FFC52F;background-color:#FFC52F;"
                       href="${wlpt}/wlpt/credit/getCreditByUser?id={{x.user.id}}">查看</a>

                </div>
            </div>
        </div>
    </div>
    <div class="loading"><img src="/static/images/loading.gif">
        <p>加载中</p></div>
    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>

    <div class="paging" id="paging">
        <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
            <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">首页</a></li>
            <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">《</a></li>
            <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
                <a ng-click="selectPage(page)">{{page}}</a>
            </li>
            <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">》</a></li>
            <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">尾页</a></li>
        </ul>
    </div>
</div>
<script>
    $(function () {
        $(".menu li").removeClass("active-menu");
        $(".menu li").eq("${param.index}").addClass("active-menu");
        $(".car_nature li").click(function () {
            $(".car_nature li").removeClass("active");
            $(this).addClass("active");
        });
        $(".sort_style li").click(function () {
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
            enname: '',
            orderBy: 'a.successtrade desc',
            searchinfo: ''
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
        //get first page
        $http({
            url: '${wlpt}/wlpt/hall/getIntegrityList',
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

            $http({
                url: '${wlpt}/wlpt/hall/getIntegrityList',
                method: 'post',
                params: {
                    'searchinfo': $scope.searchData.searchinfo,
                    'orderBy': $scope.searchData.orderBy,
                    'role.enname': $scope.searchData.enname,
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
        closeIcon: "/static/images/close_hover.png",
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
        closeIcon: "/static/images/close_hover.png",
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
