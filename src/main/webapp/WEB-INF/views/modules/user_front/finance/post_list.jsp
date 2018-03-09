<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>一卡通消费记录</title>
    <style type="text/css">
        .user_box {
            padding: 15px 0px;
        }

        .user_box, .user_box .form-control {
            text-align: 23px !important;
            background-color: green;
            color: #FFF;
            border-radius: 3px;
        }

        .user_box .noborder-form-control {
            background-color: green;
            color: #FFF;
        }
    </style>
    <script type="text/javascript">
        /*$(function () {
         $("#btnExport").click(function () {
         //$("#searchForm").attr("action", "${wlpt}/wlpt/consume/petrolexport");
         $("#beginOperateDate").val($("#beginCreateDate_card").val());
         $("#endOperateDate").val($("#endCreateDate_card").val());
         $("#searchForm").submit();
         //$("#searchForm").attr("action", "${wlpt}/wlpt/consume/getPetrolconsumeList");

         });
         });*/
    </script>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="dataHall"
     ng-controller="dataHallCtrl">

    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel" style="border:0;margin-bottom:40px;">
                <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
                    <ul class="nav nav-tabs tab-nav-tabs">
                        <li class="active"><a href="#oneCard_recode" ng-click="searchInfo('card');tab_info='card'"
                                              data-toggle="tab">一卡通消费记录</a></li>
                        <c:if test="${user.isposuser eq '1' }">
                            <li><a href="#my_pos" data-toggle="tab"
                                   ng-click="searchInfo('metro');tab_info='metro'">我的POS机</a></li>
                        </c:if>
                    </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="oneCard_recode">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">消费记录</h4>
                                </div>
                                <div class="panel-body">

                                    <div class="col-lg-12 search_wrap">
                                        <form:form id="searchForm" modelAttribute="consumerecod"
                                                   action="${wlpt}/wlpt/consume/petrolexport" method="post">
                                            <input type="hidden" name="beginOperateDate" id="beginOperateDate">
                                            <input type="hidden" name="endOperateDate" id="endOperateDate">

                                            <div class="col-sm-2">
                                                <input class="form-control" placeholder="请选择开始时间"
                                                       name="beginCreateDate_card"
                                                       id="beginCreateDate_card"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                            </div>
                                            <div class="col-sm-2">
                                                <input class="form-control" placeholder="请选择结束时间"
                                                       name="endCreateDate_card"
                                                       id="endCreateDate_card"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                            </div>
                                            <div class="col-sm-6 text-left">
                                                <button class="btn btn-primary" type="button"
                                                        ng-click="searchInfo('card')">
                                                    <i class="fa fa-search white"></i> 查询
                                                </button>
                                                <button class="btn btn-success" id="btnExport" ng-click="exportExcel()">
                                                    <i class="fa fa-upload white"> </i> 导出
                                                </button>
                                                <a class="btn btn-success" id="fabu"
                                                   href="${wlpt}/wlpt/personal/toApplyCard"
                                                   onclick="return check();">
                                                    <i class="fa fa-plus-square white"> </i> 我的一卡通
                                                </a>
                                            </div>
                                        </form:form>
                                    </div>
                                    <div style="overflow: auto;width: 100%;">
                                        <table class="table" id="account_list">
                                            <thead>
                                            <tr>
                                                <th>项目名称</th>
                                                <th>消费金额</th>
                                                <th>消费量</th>
                                                <th>单价</th>
                                                <th>交易描述</th>
                                                <th>店铺信息</th>
                                                <th>交易时间</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="x in data">
                                                <td ng-cloak>{{x.recorditem.gooditemname}}</td>
                                                <td ng-cloak>{{x.recorditem.paidmoney}}</td>
                                                <td ng-cloak>
                                                    {{x.recorditem.number}}
                                                </td>

                                                <td ng-cloak>{{x.recorditem.oldprice}}</td>
                                                <td ng-cloak>{{x.meno}}单据号:{{x.billnumber}}</td>
                                                <td ng-cloak> {{x.storename}}</td>
                                                <td ng-cloak>{{x.operatetime}}</td>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div id="noneData"
                                         style="display:none;text-align: center;width: 100%;line-height: 25px;">
                                        <img src="${ctxStatic }/front/img/nodata.png"
                                             style="width: 100px;height: 100px;">
                                    </div>
                                    <!-- <div class="loading" style="text-align: center;">
                                        <img src="/static/images/loading.gif">
                                        <p>加载中</p>
                                    </div> -->
                                    <tm-pagination conf="paginationConf"></tm-pagination>
                                    <%--<div class="fixed-table-pagination">
                                        <div class="pull-left pagination-detail">
                                            <span class="pagination-info" ng-cloak>显示第 {{mincount}} 到第 {{maxcount}} 条记录，总共 {{totalcount}} 条记录</span>
                                        </div>
                                        <div class="pull-right paging" id="paging">
                                            <ul class="pagination" id="pagination" on-select-page="selectPage(page,'card')">
                                                <li ng-class="{active: isActive(page)}"><a
                                                        ng-click="selectPage(1,'card')">第一页</a></li>
                                                <li ng-class="{disabled: noPrevious()}"><a
                                                        ng-click="selectPrevious('card')">‹</a></li>
                                                <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
                                                    <a ng-click="selectPage(page,'card')" ng-cloak>{{page}}</a>
                                                </li>
                                                <li ng-class="{disabled: noNext('card')}"><a ng-click="selectNext('card')">›</a>
                                                </li>
                                                <li ng-class="{active: isActive(page)}"><a
                                                        ng-click="selectPage(numPages,'card')">最后一页</a></li>
                                            </ul>
                                        </div>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="my_pos">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">资金信息</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-6 form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">可用余额</div>
                                            <div class="col-sm-4 text-left" style="padding-left: 0">
                                                <span class="form-control noborder-form-control strong_blue"><fmt:formatNumber
                                                        value="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}"
                                                        pattern="#.##" minFractionDigits="2"></fmt:formatNumber>元</span>
                                            </div>
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">油气余额</div>
                                            <div class="col-sm-4 text-left" style="padding-left: 0">
                                                <span class="form-control noborder-form-control strong_blue">${not empty user.userPurse.petrolbalance ? user.userPurse.petrolbalance:'0.00'}元</span>
                                            </div>
                                            <div class="col-sm-12 text-center" style="margin-top:10px;">
                                                <div class="col-lg-2"></div>
                                                <button class="btn btn-primary btn-mini col-lg-5"
                                                        ng-click="getexchange();">
                                                    油气兑换余额
                                                </button>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;padding-top:15px;line-height: 30px;">
                                        <p>1、为了保护你的账户余额安全，请认真阅读<a target="_blank"
                                                                  onclick="openagreement('prepaidAgreement')"
                                                                  style="line-height: 30px;text-decoration: none;">《卓大物流平台充值服务协议》</a>，如需提现，请致电客服进行申请和审核。
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">我的POS机</h4>
                                </div>
                                <div class="panel-body">

                                    <div class="col-lg-12 search_wrap">
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择开始时间"
                                                   name="beginCreateDate_metro"
                                                   id="beginCreateDate_metro"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                        </div>
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择结束时间" name="endCreateDate_metro"
                                                   id="endCreateDate_metro"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                        </div>

                                        <div class="col-sm-2 btn-search-wrap">
                                            <button class="btn btn-primary" type="button" ng-click="searchInfo('metro')"
                                                    style="width: 128px;"><i
                                                    class="fa fa-search white"></i> 查询
                                            </button>
                                        </div>

                                    </div>
                                    <table class="table" id="metro_list">
                                        <thead>
                                        <tr>
                                            <th>店铺名称</th>
                                            <th>POS机工号</th>
                                            <th>会员姓名</th>
                                            <th>备注</th>
                                            <th>绑定时间</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr ng-repeat="x2 in data2">
                                            <td ng-cloak>{{x2.storeName}}</td>
                                            <td ng-cloak>{{x2.useraccount}}</td>
                                            <td ng-cloak>
                                                {{x2.memberName}}
                                            </td>

                                            <td ng-cloak>{{x2.remarks}}</td>
                                            <td ng-cloak>{{x2.createDate}}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div id="noneData"
                                         style="display:none;text-align: center;width: 100%;line-height: 25px;">
                                        <img src="${ctxStatic }/front/img/nodata.png"
                                             style="width: 100px;height: 100px;">
                                    </div>
                                    <!-- <div class="loading" style="text-align: center;">
                                        <img src="/static/images/loading.gif">
                                        <p>加载中</p>
                                    </div> -->
                                    <tm-pagination conf="paginationConf2"></tm-pagination>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>


    </div>
</div>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script
        src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>

<script>
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10,
            totalItems: 0
        };
        ///第二个分页
        $scope.paginationConf2 = {
            currentPage: 1,
            itemsPerPage: 10,
            totalItems: 0
        };

        ///查询参数初始化
        $scope.postData = {
            beginOperateDate: $("#beginCreateDate_card").val(),
            endOperateDate: $("#endCreateDate_card").val(),
            pageNo: $scope.paginationConf.currentPage,
            pageSize: $scope.paginationConf.itemsPerPage
        };
        ///切换类型   $scope.tab_info:"card",默认加载
        $scope.tab_info = "card";
        //参数请求路径
        $scope.post_url = '${wlpt}/wlpt/consume/getPetrolconsumeList';
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

        $scope.searchInfo = function (tab) {
            $scope.isloading(1);
            $scope.tab_info = tab;
            $scope.post_url = '${wlpt}/wlpt/consume/getPetrolconsumeList';
            $scope.postData.beginOperateDate = $("#beginCreateDate_" + tab).val();
            $scope.postData.endOperateDate = $("#endCreateDate_" + tab).val();
            ///更改当前页码，进行触发分页查询事件
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
            $scope.paginationConf.itemsPerPage = 10;
            if (tab == "metro") {
                $scope.post_url = '${wlpt}/wlpt/consume/getMetroPosList';
                $scope.paginationConf2.currentPage = 1;
                $scope.paginationConf2.itemsPerPage = 10;
            } else {
                $scope.post_url = '${wlpt}/wlpt/consume/getPetrolconsumeList';
            }
        };
        var GetAllEmployee = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
            if ($scope.tab_info == "card") {
                $scope.postData.pageNo = $scope.paginationConf.currentPage;
                $scope.postData.pageSize = $scope.paginationConf.itemsPerPage;
            } else {
                $scope.postData.pageNo = $scope.paginationConf2.currentPage;
                $scope.postData.pageSize = $scope.paginationConf2.itemsPerPage;
            }
            $http({
                url: $scope.post_url,
                method: 'post',
                params: $scope.postData
            }).success(function (response) {
                $scope.isloading(2);
                if ($scope.tab_info == "card") {
                    $scope.data = response.value.list;
                    $scope.paginationConf.totalItems = response.value.count;

                } else {
                    $scope.data2 = response.value.list;
                    $scope.paginationConf2.totalItems = response.value.count;
                }
                if (!response.value.list) {
                    //$scope.$apply(function(){});
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
        $scope.$watch('paginationConf2.currentPage + paginationConf2.itemsPerPage', GetAllEmployee);

        $scope.exportExcel = function () {
            $("#beginOperateDate").val($("#beginCreateDate_card").val());
            $("#endOperateDate").val($("#endCreateDate_card").val());
            $("#searchForm").submit();
        };
        $scope.getexchange = function () {
            location.href = "${wlpt}/wlpt/petrolexchange/myPetrolExchangeList";
        };
    }]);

    /* var app = angular.module("dataHall", []);
     app.controller('dataHallCtrl', function ($scope, $http) {
     $scope.currentPage = 1;
     $scope.pageSize = 5;
     $scope.pages = [];
     ////isloading ==1:加载数据2:查询不到数据3:查询到数据
     $scope.isloading = function (isloading) {
     if (isloading == 1) {
     $(".loading").show();
     $("#noneData").hide();
     } else if (isloading == 2) {
     $(".loading").hide();
     $("#noneData").show();
     $("#btnExport").hide().attr("disabled", "true");
     } else {
     $(".loading").hide();
     $("#noneData").hide();
     $(".datainit").show();
     }
     };
     $scope.exportExcel = function () {
     $http({
     url: '${wlpt}/wlpt/consume/export',
     method: 'post',
     params: {
     'beginOperateDate': $("#beginOperateDate_").val(),
     'endOperateDate': $("#endOperateDate").val(),
     'pageNo': $scope.currentPage,
     'pageSize': $scope.pageSize
     }
     }).success(function (response) {

     });
     };
     //get first page
     $http({
     url: '${wlpt}/wlpt/consume/getPetrolconsumeList',
     method: 'post',
     params: {
     'beginOperateDate': $("#beginOperateDate").val(),
     'endOperateDate': $("#endOperateDate").val(),
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
     //记录数条数
     $scope.totalcount = response.value.count;
     $scope.mincount = Math.ceil($scope.currentPage * $scope.pageSize) - $scope.pageSize + 1;
     if (response.value.count * 1 == 0) {
     $scope.mincount = 0;
     }
     $scope.maxcount = Math.ceil($scope.currentPage * $scope.pageSize);
     if ($scope.maxcount * 1 > response.value.count * 1) {
     $scope.maxcount = response.value.count;
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
     var curtab="card";
     $scope.onSelectPage = function (page ,tab) {
     $scope.isloading(1);
     if (curtab!=tab){
     curtab=tab;
     $scope.totalcount=0;
     $scope.currentPage=1;
     $scope.pageSize=5;
     $scope.totalcount=0;
     $scope.numPages=0;
     $scope.data={};
     }
     //replace your real data
     var posturl='${wlpt}/wlpt/consume/getPetrolconsumeList';
     if (tab=="metro"){
     posturl='${wlpt}/wlpt/consume/getMetroPosList';
     }else{
     posturl='${wlpt}/wlpt/consume/getPetrolconsumeList';
     }
     $http({
     url: posturl,
     method: 'post',
     params: {
     'beginOperateDate': $("#beginOperateDate_"+tab).val(),
     'endOperateDate': $("#endOperateDate_"+tab).val(),
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
     //记录数条数
     $scope.totalcount = response.value.count;
     $scope.mincount = Math.ceil($scope.currentPage * $scope.pageSize) - $scope.pageSize + 1;
     if (response.value.count * 1 == 0) {
     $scope.mincount = 0;
     }
     $scope.maxcount = Math.ceil($scope.currentPage * $scope.pageSize);
     if ($scope.maxcount * 1 > response.value.count * 1) {
     $scope.maxcount = response.value.count;
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
     scope.selectPage = function (page,tab) {
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


     if (!scope.isActive(page) || page == 1) {
     scope.currentPage = page;
     scope.onSelectPage(page,tab);
     }
     };
     scope.selectPrevious = function (tab) {
     if (!scope.noPrevious()) {
     scope.selectPage(scope.currentPage - 1,tab);
     }
     };
     scope.selectNext = function (tab) {
     if (!scope.noNext()) {
     scope.selectPage(scope.currentPage + 1,tab);
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
     app.directive('metro_paging', function () {
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
     scope.selectPage = function (page,tab) {
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


     if (!scope.isActive(page) || page == 1) {
     scope.currentPage = page;
     scope.onSelectPage(page,tab);
     }
     };
     scope.selectPrevious = function (tab) {
     if (!scope.noPrevious()) {
     scope.selectPage(scope.currentPage - 1,tab);
     }
     };
     scope.selectNext = function (tab) {
     if (!scope.noNext()) {
     scope.selectPage(scope.currentPage + 1,tab);
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


     });*/
</script>
</body>
</html>
