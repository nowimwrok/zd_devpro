<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>全部保险</title>

    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #f6f6f6;
            font-family: "微软雅黑";
        }

        ul, ol {
            margin: 0;
            /* margin-bottom: 10px; */
        }

        .content {
            background-color: #fff;
            margin: 50px 0;
        }

        .pan-alilist {
            color: #666;
        }

        .tm-clear:after {
            content: '\20';
            display: block;
            height: 0;
            clear: both;
        }

        .detail-tab {
            width: 850px;
            float: left;

        }

        .ui-tab {
            border: 1px solid #e2e2e2;
            background-color: #fff;
        }

        .ui-tab-nav {
            display: inline-block;
        }

        /*  .ui-tab-nav:hover{
             background-color: #02a0e9;
         } */
        .ui-tab-nav a {
            display: inline-block;
            height: 44px;
            line-height: 44px;
            font-size: 16px;
            color: gray;
            border: 0;
            border-top: 2px solid #fcfcfc;
            background-color: #fcfcfc;
            border-radius: 0;
            padding: 0px 15px;
            border-right: 1px dotted #d2d2d2;
            cursor: pointer;
        }

        /*  .ui-tab-nav a:hover{
             color:#02a0e9;
         } */
        /*click*/
        .onclick {
            background-color: #02a0e9;
        }

        .onclick a {
            color: #02a0e9;
        }

        /*click*/
        .ui-tab-items {
            box-shadow: 1px 1px 3px #ddd;
        }

        .all-list {
            margin-top: 10px;

        }

        .list-tip {
            width: 400px;
            height: 400px;
            float: left;
            position: relative;
            border: 1px solid #e2e2e2;
            background-color: #fff;
            position: relative;
            margin-right: 12px;
            margin-left: 12px;
            margin-bottom: 12px;
        }

        .list-tip:hover {
            border: 1px solid #02a0e9;
        }

        .default_box_Img {
            height: 265px;
        }

        .default_box_Img h3 {
            position: absolute;
            top: 0;
            left: 10%;
        }

        .default_box_Img img {
            width: 100%;
            height: 100%;
        }

        .default_box_mes {
            margin-left: 15px;
            line-height: 35px;
        }

        .resident_box {
            border-top: 1px solid #e2e2e2;
        }

        .resident_box ul {
            width: 200px;
            margin-left: 35px;
            padding: 18px 0;
            float: left;
        }

        .resident_box li {
            float: left;
            margin-right: 10px;
            padding-left: 24px;
            background: url(${ctxStatic }/images/wlptfront/shop_img/prolist_Icon.png) no-repeat;
        }

        .resident_box_price {
            margin-top: 10px;
        }

        .resident_box_price_num {
            font-size: 36px;
            color: #f63;
            font-family: arial;
        }

        .go-look {
            color: #fff;
            font-size: 18px;
            padding: 10px 32px;
            position: absolute;
            top: 45%;
            left: 50%;
            margin-left: -58px;
            background-color: #02a0e9;
            display: none;
        }

        .go-look:hover {
            color: #fff;
            background-color: #0288c5;
        }

        .block {
            display: block;
        }

        #chebx .nothing {
            width: 100%;
            height: 400px;
            margin-top: 10px;
            background-color: #fff;
            border: 1px solid #e2e2e2;
        }

        /*我的保单*/
        .my-tab {
            width: 300px;
            float: right;
            border: 1px solid #e2e2e2;
            background-color: #fff;
        }

        .my-tab .title {
            height: 45px;
            line-height: 45px;
            font-size: 18px;
            padding-left: 30px;
            box-shadow: 1px 1px 3px #ddd;
        }

        .my-tab .title a {
            padding-left: 100px;
            font-size: 16px;
            color: #02a0e9;
        }

        .my-tab .title a:hover {
            text-decoration: underline;
        }

        .my-tab .my-tips {
            height: 85px;
            padding: 10px;
            border-bottom: 1px dotted #d2d2d2;
            cursor: pointer;
        }

        .my-tab .my-tips:hover {
            background-color: #d2d2d2;
        }

        .my-tab .my-tips .left {
            float: left;
        }

        .my-tab .my-tips .right {
            padding: 4px 11px 0 0;
            float: right;
        }

        .my-tab .my-tips .right h5 {
            color: red;
            font-size: 16px;
            line-height: 30px;
        }

        .my-tab .my-tips a {
            color: #666;
        }

        .my-tab .my-tips a:hover {
            color: #666;
        }

        .datainit {
            display: none;
        }
    </style>
</head>
<body>
<div class="pan-alilist" ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="detail-tab">
        <div class="ui-tab">
            <ul class="ui-tab-items" id="sku_tabs">
                <li class="ui-tab-nav "><a href="#allbx">卓大保险</a></li>
                <!-- <li class="ui-tab-nav "><a href="#huobx">货险(1)</a></li>
                <li class="ui-tab-nav "><a href="#chebx">车险(0)</a></li> -->

            </ul>

        </div>
        <div class="detail-tab datainit">
            <div id="allbx" class="all-list" ng-repeat="x in data">
                <div class="list-tip">
                    <a class="go-look" href="${wlpt}/wlpt/shop/insur_detail?id={{x.id}}&index=2">去看看</a>
                    <a href="${wlpt}/wlpt/shop/insur_detail?id={{x.id}}&index=2">
                        <div class="default_box_Img">
                            <h3 style="color:#666;">{{x.insurName}}</h3>
                            <img src="{{x.insurLogo}}">
                        </div>

                        <span class="default_box_mes">{{x.productFeatures}}</span>
                        <div class="resident_box ">
                            <ul>
                                <!-- <li>全国索赔</li>
                                <li>提供发票</li>
                                <li>电子保单</li>
                                <li>官方直投</li> -->
                            </ul>
                            <div class="resident_box_price">
                                <p><span class="resident_box_price_num">￥{{x.insurAmount}}</span></p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <div class="loading"><img src="${ctxStatic }/images/loading.gif">
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

        <!--
        <div id="huobx" class="all-list"></div>
        <div id="chebx" class="all-list">
            <div class="nothing">
                暂无此类产品，敬请期待！
            </div>
        </div> -->

    </div>
    <div class="my-tab">
        <div class="title">我的保单 <!-- <a href="">更多...</a> --></div>
        <c:forEach items="${insurancelist}" var="insurancelist"
                   varStatus="status_list" end="3">
            <div class="my-tips">
                <a href="">
                    <div class="left">
                        <h4>${insurancelist.insurancetype }</h4>
                        <span>保费:￥${insurancelist.insurancefeel }</span>
                        <span>承保人:${insurancelist.applicant }</span>
                    </div>
                    <div class="right">
                        <span><fmt:formatDate value="${insurancelist.createDate }" pattern="yyyy-MM-dd"/></span>
                        <h5>${insurancelist.status }</h5>
                    </div>

                </a>
            </div>
        </c:forEach>
    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>

    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 2;
        $scope.pages = [];

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
            url: '${wlpt}/wlpt/shop/getInsuranceList',
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
                url: '${wlpt}/wlpt/shop/getInsuranceList',
                method: 'post',
                params: {
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

</script>
<script>
    $(document).ready(function () {
        //$('.ui-tab-items li:first').addClass('onclick');
        $('#allbx').show();

        //On Click Event
        $(".ui-tab-items li").click(function () {
            $(".ui-tab-items li").removeClass('onclick');
            $('.all-list').hide();
            $(this).addClass('onclick');
            var activeTab = $(this).find("a").attr("href");
            $(activeTab).show();
            return false;
        });

        //onfocus

        $(".list-tip").mouseover(function () {
            $(this).find('.go-look').show();
        });
        $(".list-tip").mouseleave(function () {
            $(this).find('.go-look').hide();
        });
    });
</script>
</body>
</html>