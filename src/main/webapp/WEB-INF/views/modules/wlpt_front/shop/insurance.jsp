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

    </style>
</head>
<body>
<!--内容-->
<div class="content insure_buy" style="margin-top: 50px;" ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="container">
        <div class="col-sm-12 clearfix insure_box">
            <!--产品-->
            <div class="pull-left insure_left">
                <div class="col-sm-4 insure_product" ng-repeat="x in data">
                    <a href="${wlpt}/wlpt/shop/insur_detail?id={{x.id}}&index=4" class="col-sm-12 col-xs-12">
                        <h4 class="" ng-cloak>{{x.insurName}}</h4>
                        <p ng-cloak>{{x.productFeatures}}</p>
                        <div class="col-sm-12 col-xs-12 insure_detail">
                            <div class="pull-left insure_price2">
                                <div ng-cloak>￥{{x.insurAmount}}</div>
                                <div>
                                    <object><a href="${wlpt}/wlpt/shop/insur_detail?id={{x.id}}&index=4">查看详情</a></object>
                                </div>
                            </div>
                        </div>
                        <img class="pull-right" onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur_logo.jpg'" src="{{x.insurLogo}}" alt=""/>
                    </a>
                </div>

                <!--页码-->
                <div class="col-sm-12 text-center">
                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>
            <!--我的保单-->
            <div class="insureList pull-right">
                <h4>我的保单</h4>
                <ul class="list-group">
                    <c:forEach items="${insurancelist}" var="insurancelist"
                               varStatus="status_list" end="3">
                        <li class="list-group-item">
                            <div class="clearfix">
                                <h5 class="pull-left">${insurancelist.insurancetype }</h5>
                                <p class="pull-right list_time"><fmt:formatDate value="${insurancelist.createDate }" pattern="yyyy-MM-dd"/></p>
                            </div>
                            <div class="clearfix">
                                <p class="pull-left">
                                    <span>保费：￥${insurancelist.insurancefeel }</span>
                                    <span>承保人：${insurancelist.applicant }</span>
                                </p>
                                <div class="pull-right">${insurancelist.status }</div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    //wow 动画
    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
        new WOW().init();
    }
    ;
    var p_h = $('.insure_box').width();

    var insure_w = $(window).width();
    if (insure_w < 500) {
        $('.insure_left').css('width', '100%');
    } else {
        $('.insure_left').width($('.insure_box').width() - 270 + 'px');
    }
    //手机端导航点击 出现蒙版
    $('.navbar-toggle').click(function () {
        if (insure_w < 768) {
            $('.mask').toggle();
        }
    });
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
            $("#maskloading", parent.document).show();
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/shop/getInsuranceList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.data = response.value.list;
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);
    }]);
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