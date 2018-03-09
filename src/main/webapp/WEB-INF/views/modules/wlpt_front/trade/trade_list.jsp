<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>运单管理</title>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal.css">
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

        .white_grey_table td {
            text-align: center;
        }

        .white_grey_table td .whi-grey-btn a {
            padding: 3px 12px;
            display: block;
            width: 60%;
            margin: 0 auto;
        }
        .loading_lock{
            display: none;
            width: 100%;
            height: 100%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .loading_lock img{
            margin-top: 25%;
        }
        .loading_hide{
            display: none;
        }
        .datainit{
            display: none;
        }
    </style>
</head>
<body style="height: 100%" ng-app="dataHall" ng-controller="dataHallCtrl">
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">运单</span><span
        class="title_orange">管理</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
</p>
<div class="zhapbiao_search">
    <input type="text" id="searchinfo" name="searchinfo" value="${orderinfo.searchinfo }" placeholder="运单号/运输方/托运方/车牌号/货物名称" class="transport_search">
    <select id="orderstatus" name="orderstatus" style="width: 10%;" class="transport_search" placeholder="运单状态"">
        <option value=''>全部</option>
        <option value='0'>新运单</option>
        <option value='1'>已确认</option>
        <option value='2'>已取消</option>
        <option value='3'>已提货</option>
        <option value='4'>已回单</option>
        <option value='5'>已支付</option>
        <option value='6'>发起争议</option>
        <option value='7'>争议完毕</option>
    </select>
    <select id="gsoddtype" name="gsoddtype" style="width: 10%;" class="transport_search" placeholder="货物类别"">
        <option value=''>全部</option>
        <option value='1'>成品</option>
        <option value='2'>原材料</option>
    </select>
    <button class="btn btn-warning" id="btn-warning" ng-click="selectPage(1)"
            style="width:80px;margin-top:-2px;margin-bottom:0px;border-radius:0px;margin-left:15px;margin-right:30px;">
        <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
    </button>
</div>

<table class="goods-manage tender_table">
    <tr class="goods_col_1" style="border:none;">
        <td style="width:30%">货物信息</td>
        <td style="width:30%">运输信息</td>
        <td style="width:20%">状态</td>
        <td style="width:20%">操作</td>
    </tr>

</table>

<div class="datainit">
    <sys:message content="${message}"/>
    <table class="white_grey_table" ng-repeat="x in data">
        <tr></tr>
        <tr class="bg_grey">
            <td style="width:28.5%;text-indent: 10px;">运单：{{x.orderno}}</td>
            <td style="width:33%;">
                <!--判断当前用户是否是买家-->
                <span ng-if="x.isBuyer">托运方:{{x.seller.loginName}}</span>
                <span ng-if="x.isBuyer==false">运输方:{{x.buyer.loginName}}</span>
            </td>
            <td style="width:18.5%;text-align: center">{{x.totalcost}}元</td>
            <td style="width:20%;text-indent: 10px;" class="whi-grey-last">{{x.updateDate}}</td>
        </tr>
        <tr>
            <td><h5>{{x.quoteinfo.goods.goodsname}}</h5>
                <p><span ng-if="x.quoteinfo.isreload==1">
                	{{x.quoteinfo.actload}}
                	</span>
                	<span ng-if="x.quoteinfo.isreload!=1">
                	{{x.quoteinfo.oddloadweight}}
                	</span>
                	{{x.quoteinfo.goods.freightunit}}<span ng-if="x.quoteinfo.car.carnumber !='' && x.quoteinfo.car.carnumber !=null">|</span>{{x.quoteinfo.car.carnumber}}</p></td>
            <td>
                <p>{{x.quoteinfo.goods.shipAddress.city}}{{x.quoteinfo.goods.shipAddress.district.substr(0,4)+'...'}}
                    <span class="glyphicon glyphicon-transfer icon_blue"></span>
                    {{x.quoteinfo.goods.consignAddress.city}}{{x.quoteinfo.goods.consignAddress.district.substr(0,4)+'...'}}
                </p>
                <p>{{x.quoteinfo.driver.loginName}}<span ng-if="x.quoteinfo.driver.phone !='' && x.quoteinfo.driver.phone !=null">|</span>{{x.quoteinfo.driver.phone}}</p>
            </td>
            <td>
               <p>{{x.quoteinfo.goods.gsoddtype}}</p>
               <p>{{x.statusStr}}</p>
                <p ng-show="x.quoteinfo.goods.isinsur == 1" style="color: red;">货物需投保</p>
            </td>
            <td class="whi-grey-last">
                <!--ng-if 判断状态是否为新运单状态-->
                <p class="whi-grey-btn">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_shadow&id={{x.id}}" class="btn btn-warning">查看运单</a>
                </p>
                <p class="whi-grey-btn">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=toPayInfo&id={{x.id}}" class="btn btn-warning">支付信息</a>
                </p>
                <p class="whi-grey-btn" ng-if="x.orderstatus==0 && x.isBuyer">
                    <a href="javascript:;" ng-click="confrimOrder(x.id,x.quoteinfo.goods.isinsur,x.orderno,x.quoteinfo.isassign)" class="btn btn-warning">确认交易</a>
                </p>
                <p class="whi-grey-btn"  ng-if="x.orderstatus==0">
                    <a href="javascript:;" ng-click="editOrder(x.id,'cancelOrder','取消')" class="btn btn-warning">取消运单</a>
                </p>
                <p class="whi-grey-btn"  ng-if="x.orderstatus==1 && x.isBuyer">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}" class="btn btn-warning">上传提货</a>
                </p>
                <p class="whi-grey-btn"  ng-if="x.orderstatus==3 && x.isBuyer">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}" class="btn btn-warning">上传回单</a>
                </p>
                <!--如果运输状态为4:已上传回单,并且支付状态不是支付中的状态 则可以确认完成交易,或者发起争议-->
                <p class="whi-grey-btn" ng-if="x.orderstatus==4 && x.isBuyer==false  && x.orderispay!=2">
                    <a href="${wlpt}/wlpt/trade/toOrderPay?id={{x.id}}" class="btn btn-warning">完成交易</a>
                </p>
                <p class="whi-grey-btn" ng-if="x.orderstatus==4 && x.isBuyer==false  && x.orderispay==2">
                    <a  class="btn btn-warning">银行处理中</a>
                </p>
                <p class="whi-grey-btn"  ng-if="x.orderstatus==4 && x.isdispute==0 && x.isBuyer == false && x.isonlinepay == 1">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}" class="btn btn-warning">发起争议</a>
                </p><!--卖家发起争议-->
                <p class="whi-grey-btn"  ng-if="x.orderstatus==6 && x.isdispute==1"><a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_receipt&id={{x.id}}" class="btn btn-warning">争议中</a></p>
                <p class="whi-grey-btn" ng-if="x.orderstatus==7 && x.isBuyer==false && x.isdispute==1 && x.orderispay!=2">
                    <a href="${wlpt}/wlpt/trade/toOrderPay?id={{x.id}}" class="btn btn-warning">完成交易</a>
                </p>
                <p class="whi-grey-btn" ng-if="x.isGps">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_track&id={{x.id}}" class="btn btn-warning">运输轨迹</a>
                </p>
                <p class="whi-grey-btn" ng-if="x.orderstatus==5 && x.iscomment==0 && x.flag">
                    <a href="${wlpt}/wlpt/trade/to_ordercomment?id={{x.id}}" class="btn btn-warning">评价</a>
                </p>
                <p class="whi-grey-btn" ng-if="(x.orderstatus==1||x.orderstatus==3) && x.islocated ==0 && x.isBuyer==false">
                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_lbs&id={{x.id}}" class="btn btn-warning">开启LBS定位</a>
                </p>
                <p class="whi-grey-btn" ng-if="x.quoteinfo.goods.isinsur==1">
                    <a href="${wlpt}/wlpt/insur/todetailByOrderNo?orderno={{x.orderno}}" class="btn btn-warning">查看保单</a>
                </p>
                <%--
                <p class="whi-grey-btn" ng-if="x.orderstatus==5 && x.iscomment==1">
                    <a href="javascript:;" class="btn btn-warning">已评价</a>
                </p> --%>
            </td>
        </tr>
    </table>
</div>
<div class="loading"><img src="${ctxStatic }/images/loading.gif"><p>加载中</p></div>
<div class="loading_lock"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
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
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="/static/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
if('${isRedrect}'== 'true'){
	$("#searchinfo").val($.cookie("trade_searchinfo"));
	$("#orderstatus").val($.cookie("trade_orderstatus"));
	$("#gsoddtype").val($.cookie("trade_gsoddtype"));
}
    ///定义module
    var app = angular.module("dataHall", []);
    ///控制方法
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        var pageno1 = $.cookie("trade_pageno");
        if(pageno1!=undefined && pageno1*1>1){
        	$scope.currentPage = pageno1*1;
        }
        $scope.pageSize = 5;
        $scope.pages = [];
        $scope.editOrder = function (id, url,masg) {
            $(".loading_lock").show();
            if (id == null || id == "") {
                return;
            }
            $.MsgBox.Confirm("交易提示","您将"+masg+"此交易,是否继续操作?",function(){
                $.ajax({
                    url: "${wlpt}/wlpt/trade/" + url,
                    data: {
                        id: id
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("交易提示",data.message);
                        $(".loading_lock").hide();
                        $scope.selectPage (1);
                    }
                });
            },function(){
                $(".loading_lock").hide();
            },null,null,"是","否");

        };
        
        $scope.confrimOrder = function (id, isinsur,orderno,isassign) {
            $(".loading_lock").show();
            if (id == null || id == "") {
                return;
            }
            if(isinsur*1==1){
            	$.MsgBox.Confirm("交易提示","该运单需填写保单信息,是否继续操作?",function(){
            		window.location.href = '${wlpt}/wlpt/trade/toinsur?orderno='+orderno;
            	},function(){
                    $(".loading_lock").hide();
                },"是","否");
            }else if(isassign*1==1){
            	$.MsgBox.Confirm("交易提示","该运单需填写运输信息,是否继续操作?",function(){
            		window.location.href = '${wlpt}/wlpt/trade/toassign?orderno='+orderno;
            	},function(){
                    $(".loading_lock").hide();
                },"是","否");
            } else{
            
             $.MsgBox.Confirm("交易提示","您将确认此交易,是否继续操作?",function(){
            	 /* $.MsgBox.Confirm("交易提示","是否修改运输信息?",function(){
             		window.location.href = '${wlpt}/wlpt/trade/toassign?orderno='+orderno;
             	},function(){
             		$.ajax({
                        url: "${wlpt}/wlpt/trade/confrimOrder",
                        data: {
                            id: id
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $.MsgBox.Alert("交易提示",data.message);
                            $(".loading_lock").hide();
                            $scope.selectPage (1);
                        }
                    });
                 },"是","否"); */
            	 $.ajax({
                     url: "${wlpt}/wlpt/trade/confrimOrder",
                     data: {
                         id: id
                     },
                     dataType: 'json',
                     cache: false,
                     success: function (data) {
                         $.MsgBox.Alert("交易提示",data.message);
                         $(".loading_lock").hide();
                         $scope.selectPage (1);
                     }
                 });
            },function(){
                $(".loading_lock").hide();
            },"是","否");
            } 
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading ==1 ){
                $(".loading").show();
                $("#noneData").hide();
            }else if (isloading==2){
                $(".loading").hide();
                $("#noneData").show();
            }else{
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").removeClass("datainit");
            }
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/trade/getTradeList',
            method: 'post',
            params: {
                'searchinfo': $("#searchinfo").val(),
                'orderstatus':$("#orderstatus").val(),
                'quoteinfo.goods.gsoddtype':$("#gsoddtype").val(),
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if(!$scope.data){
                $scope.isloading(2);
            }else{
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
        ////分页查询
        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/trade/getTradeList',
                method: 'post',
                params: {
                    'searchinfo': $("#searchinfo").val(),
                    'orderstatus':$("#orderstatus").val(),
                    'quoteinfo.goods.gsoddtype':$("#gsoddtype").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {
				$.cookie("trade_searchinfo",$("#searchinfo").val());
				$.cookie("trade_orderstatus",$("#orderstatus").val());
				$.cookie("trade_pageno",$scope.currentPage);
				$.cookie("trade_gsoddtype",$("#gsoddtype").val());

                $scope.data = response.value.list;
                $scope.pages=[];
                if(!$scope.data){
                    $scope.isloading(2);
                }else{
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
    ///分页
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


                    if (!scope.isActive(page) || page == 1) {
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
</body>
</html>
