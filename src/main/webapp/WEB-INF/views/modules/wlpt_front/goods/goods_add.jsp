<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>

    <title>货源发布</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <style type="text/css">

        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
        }

        .user_infor_left {
            width: 22%;
        }

        .fabu_infor_right {
            width: 15%;
        }

        .cols_right {
            width: 30%;
        }

        .col2_left {
            width: 6%;
        }

        .tab-all {
            width: 100%;
            padding-top: 20px;
            border: none;
        }

        .loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }
    </style>

    <link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="${ctxStatic }/jquery-select2/3.4/select2.min.css" rel="stylesheet">
    <link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet"
          type="text/css">


</head>
<body>
<form:form method="post" name="Form" id="Form" modelAttribute="goods" action="${wlpt}/wlpt/goods/saveGoods">
    <div class="tab_fir tab-all">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png">
            <span class="title_blue">货源</span>
            <span class="title_orange">发布</span>
            <img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <table class="user-infor">
            <input type="hidden" value="${orderId}" name="orderId">
            <input type="hidden" value="${goods.datasource}" name="datasource">
            <input type="hidden" value="${goods.goodstype}" name="goodstype" id="goodstype">
            <tr>
                <input name="id" value="${goods.id}" type="hidden">
                <input id="freightunit" name="freightunit" value="${goods.freightunit}" type="hidden">
                <td class="user_infor_left">
                    <span class="star_red">*</span>货物名称:
                </td>
                <td class="fabu_infor_right" colspan=3>
                    <input id="goodsname" name="goodsname" value="${goods.goodsname}" style="width: 65.5%;"
                           type="text"/>
                </td>
            </tr>
            <tr>
                <td class="user_infor_left">货物类别:</td>
                <td class="fabu_infor_right" colspan=3>
                    <c:choose>
                        <c:when test="${goods.id != null && goods.datasource!='0' }">
                            ${fns:getDictLabel(goods.gsoddtype, 'gsoddtype', '')}
                            <form:hidden path="gsoddtype"/>
                        </c:when>
                        <c:when test="${goods.datasource=='1' || goods.datasource=='4'}">

                            ${fns:getDictLabel(goods.gsoddtype, 'gsoddtype', '')}
                            <form:hidden path="gsoddtype"/>
                        </c:when>
                        <c:otherwise>
                            <form:select id="gsoddtype" name="gsoddtype" path="gsoddtype" onchange="change();">
                                <form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label"
                                              itemValue="value"
                                              htmlEscape="false"/>
                            </form:select>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>货物重量:</td>
                <td class="fabu_infor_right">
                    <input name="freightvolume" value="${goods.freightvolume}"
                           <c:if test="${goods.id != null && goods.datasource!='0' }">readonly</c:if> type="text"
                           id="freightvolume" onblur="checkfreight()"/>
                    <span id="a">吨</span>
                </td>
                <td class="col2_left">期望价格:</td>
                <td class="cols_right">
                    <input id="expectedprice" name="expectedprice" value="${goods.expectedprice}" type="text"/>
                    <span id="b">元/吨</span></td>
            </tr>
                <%-- <tr>
                    <td class="user_infor_left">是否投保:</td>
                    <td class="fabu_infor_right">
                        <form:radiobuttons id="isinsur" path="isinsur" items="${fns:getDictList('yes_no')}"
                                       itemLabel="label" itemValue="value" htmlEscape="false" class="paytyperadio"/>
                    </td>
                    <td class="col2_left" colspan="2"></td>

                </tr>
                 <tr id="paydepositdiv">
                    <td class="user_infor_left">保单支付方：</td>
                    <td class="fabu_infor_right">
                        <form:radiobuttons id="paypeople" path="paypeople" items="${fns:getDictList('insur_paypeople')}"
                                       itemLabel="label" itemValue="value" htmlEscape="false" class="paytyperadio"/>
                    </td>
                    <td class="col2_left" colspan="2"></td>

                </tr> --%>
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>出发地址:</td>
                <td class="fabu_infor_right">

                    <input name="shipAddress.status" value="${goods.shipAddress.status}" type="hidden"/>
                    <input name="shipAddress.type" value="0" type="hidden">
                    <input name="shipAddress.id" value="${goods.shipAddress.id}" type="hidden">
                    <input id="fromprovince" name="shipAddress.province" value="${goods.shipAddress.province}"
                           type="hidden">
                    <input id="fromcity" name="shipAddress.city" value="${goods.shipAddress.city}" type="hidden">
                    <input id="fromdistrict" name="shipAddress.district" value="${goods.shipAddress.district}"
                           type="hidden">
                    <input type="text" name="fromAddress" id="fromAddress"
                           value="${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district}"
                           readonly="readonly" placeholder="请选择出发地"/>
                </td>
                <td class="col2_left"><span class="star_red">*</span>详细地址:</td>
                <td class="cols_right">
                    <input id="shipAdd" name="shipAddress.address" value="${goods.shipAddress.address}" type="text"
                           placeholder="详细地址"/>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>目的地址:</td>
                <td class="fabu_infor_right">

                    <input name="consignAddress.status" value="${goods.consignAddress.status}" type="hidden"/>
                    <input name="consignAddress.type" value="1" type="hidden">
                    <input name="consignAddress.id" value="${goods.consignAddress.id}" type="hidden">
                    <input id="toprovince" name="consignAddress.province" value="${goods.consignAddress.province}"
                           type="hidden">
                    <input id="tocity" name="consignAddress.city" value="${goods.consignAddress.city}" type="hidden">
                    <input id="todistrict" name="consignAddress.district" value="${goods.consignAddress.district}"
                           type="hidden">
                    <input type="text" id="toAddress" name="toAddress"
                           value="${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district}"
                           readonly="readonly" placeholder="请选择目的地"/>
                </td>
                <td class="col2_left"><span class="star_red">*</span>详细地址:</td>
                <td class="cols_right"><input type="text" id="consignAdd" name="consignAddress.address"
                                              value="${goods.consignAddress.address}" placeholder="详细地址"/></td>
            </tr>
            <tr>
                <td class="user_infor_left">车型要求:</td>
                <td class="fabu_infor_right">
                    <input id="cartype" name="cartype" value="${goods.cartype}" readonly="readonly" type="text"/>
                </td>
                <td class="col2_left">车长要求:</td>
                <td class="cols_right">
                    <input id="carlength" name="carlength" value="${goods.carlength}" type="text"/>米
                </td>
            </tr>

            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>装车时间:</td>
                <td class="fabu_infor_right" colspan=3>

                    <input name="sendtime" id="sendtime" type="text" readonly="readonly" maxlength="20"
                           style="height: 28px;" class="Wdate "
                           value="<fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">货物价值:</td>
                <td class="fabu_infor_right">
                    <input id="worth" name="worth" value="${goods.worth}" type="text"/>元
                </td>
                <td class="col2_left">运输方式:</td>
                <td class="cols_right">
                    <input id="transportway" name="transportway" value="${goods.transportway}" type="text"
                           readonly="readonly"/>
                </td>
            </tr>

            <tr>
                <td class="user_infor_left">有效天数:</td>
                <td class="fabu_infor_right" colspan=3>
                    <input id="effectdays" name="effectdays" value="${goods.effectdays}" maxlength="2" type="text"/>天
                </td>
            </tr>
            <tr>
                <td class="user_infor_left" style="padding-bottom: 98px;">补充说明:</td>
                <td class="textarea_left" colspan=3 style="padding-left: 8px;">
                    <form:textarea id="remarks" htmlEscape="false" path="remarks" rows="4" maxlength="100"
                                   class="input-xxlarge" style="width: 66%;"/>

                </td>
            </tr>
            <tr>
                <td class="user_infor_left">是否指派:</td>
                <td class="fabu_infor_right" colspan=3>
                    <form:radiobuttons id="issend" path="issend" items="${fns:getDictList('yes_no')}"
                                       itemLabel="label" itemValue="value" htmlEscape="false" class="paytyperadio"/>
                </td>
            </tr>
            <tr id="contactsdiv" style="display: none;">
                <td class="user_infor_left">运输用户:</td>
                <td class="fabu_infor_right" colspan=3>
                    <input name="quoteuserid" value="" type="hidden" id="userid"/>
                    <input name="searchinfo" value="" type="text" id="searchinfo" placeholder="用户名/电话"
                           onchange="search();"/>
                    <a href="javascript:;" onclick="search();" class="btn-warning" style="padding: 3px 5px;">搜 索</a>
                    <span onclick="showBg1();"><a href="#">常用联系人</a></span>
                </td>
            </tr>

        </table>
    </div>
    <div class="tab_fir tab-all">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">发货人</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <table class="user-infor">
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>联系人：</td>
                <td class="fabu_infor_right"><input id="shiplinkman" name="shipAddress.linkman"
                                                    value="${not empty goods.id?goods.shipAddress.linkman:user.name}"
                                                    type="text"/></td>
                <td class="col2_left"><span class="star_red">*</span>手机号码：</td>
                <td class="cols_right"><input id="shiplinkmobile" name="shipAddress.linkmobile"
                                              value="${not empty goods.id?goods.shipAddress.linkmobile:user.phone}"
                                              type="text"/></td>
            </tr>
            <tr style="height: 50px;">
                <td class="user_infor_left">固定电话：</td>
                <td class="fabu_infor_right"><input id="shiplinktelphone" name="shipAddress.linktelphone"
                                                    value="${not empty goods.id?goods.shipAddress.linktelphone:user.mobile}"
                                                    type="text"/></td>
                <td class="col2_left">公司名称：</td>
                <td class="cols_right"><input name="shipAddress.linkcompany"
                                              value="${not empty goods.id?goods.shipAddress.linkcompany:user.userinfo.companyname}"
                                              type="text"/></td>
            </tr>
        </table>
    </div>
    <div class="tab_fir tab-all">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">收货人</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <table class="user-infor">
            <tr>
                <td class="user_infor_left"><span class="star_red">*</span>联系人：</td>
                <td class="fabu_infor_right"><input id="consignlinkman" name="consignAddress.linkman"
                                                    value="${goods.consignAddress.linkman}" type="text"/></td>
                <td class="col2_left"><span class="star_red">*</span>手机号码：</td>
                <td class="cols_right"><input id="consignlinkmobile" name="consignAddress.linkmobile"
                                              value="${goods.consignAddress.linkmobile}" type="text"/></td>
            </tr>
            <tr style="height: 50px;">
                <td class="user_infor_left">固定电话：</td>
                <td class="fabu_infor_right"><input id="consignlinktelphone" name="consignAddress.linktelphone"
                                                    value="${goods.consignAddress.linktelphone}" type="text"/></td>
                <td class="col2_left">公司名称：</td>
                <td class="cols_right"><input name="consignAddress.linkcompany"
                                              value="${goods.consignAddress.linkcompany}" type="text"/></td>
            </tr>
        </table>
    </div>


    <c:if test="${blinfoList.size()>0}">
        <div class="tab-thre tab-all" style="margin: 0 auto">
            <p class="user_data">
                <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span
                    class="title_orange">详情</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
            </p>
            <center>
                <table class="table table-condensed table-bordered" style="width:80%">

                    <tbody>
                    <tr>
                        <th>提货单号</th>
                        <th>品名材质</th>
                        <th>规格</th>
                        <th>定尺\板宽</th>
                        <th>数量\吨</th>
                        <th>批次号</th>
                    </tr>
                    <tr id="content-mark" style="display:none"></tr>
                    <c:forEach var="item" items="${blinfoList}" varStatus="status">
                        <input type="hidden" name="blinfoList[${status.index}].blcode" value="${item.blcode}">
                        <input type="hidden" name="blinfoList[${status.index}].namematerials"
                               value="${item.namematerials}">
                        <input type="hidden" name="blinfoList[${status.index}].standard" value="${item.standard}">
                        <input type="hidden" name="blinfoList[${status.index}].width" value="${item.width}">
                        <input type="hidden" name="blinfoList[${status.index}].quantity" value="${item.quantity}">
                        <input type="hidden" name="blinfoList[${status.index}].batch" value="${item.batch}">
                        <input type="hidden" name="blinfoList[${status.index}].id" value="${item.id}">
                        <tr>
                            <td>${item.contractno}</td>
                            <td>${item.namematerials}</td>
                            <td>${item.standard}</td>
                            <td>${item.width}</td>
                            <td>${item.quantity}</td>
                            <td>${item.batch}</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </center>
        </div>
    </c:if>
    <div class="tab-thre tab-all">
        <input id="btnSubmit" type="button" class="btn btn-warning" value="保 存"/>
        &nbsp;
        <input class="btn btn-warning" type="button" value="返回" onclick="history.go(-1)"/>
    </div>
    <div class="loading">
        <img src="/static/images/loading.gif">
        <p>加载中</p>
    </div>

</form:form>
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <%-- <%@ include file="/WEB-INF/views/modules/wlpt_front/contacts/contacts_info.jsp" %>--%>
        <div class="select_title">
            <form action="" method="get" class="search-bar" style="text-align: center">
                <input id="searchinfoname" type="text" class="car_search car_phone_search"
                       style="width: 250px;height: 30px;" ng-model="searchData.searchinfoname"
                       placeholder="登录名/手机号码"/>

                <button type="button" name="search-btn" id="search-btn"
                        style="width:80px;border-radius:0px;border-color:#FFC52F;background-color:#FFC52F;padding: 3px 5px;"
                        class="btn btn-warning" ng-click="onSelectPage(1)">
                    <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
                </button>

            </form>
        </div>
    <table class="table" data-height="246">
        <thead>
        <tr>

            <th>登录名</th>
            <th>真是姓名</th>
            <th>手机号码</th>
            <th>创建时间</th>
            <th>选择</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="x in data" style="height: 40px;">
            <td style=" border: solid 1px #d1c5c5;">
                {{x.target.loginName}}
            </td>
            <td style=" border: solid 1px #d1c5c5;">
                {{x.target.name}}
            </td>
            <td style=" border: solid 1px #d1c5c5;">
                {{x.target.phone}}
            </td>
            <td style=" border: solid 1px #d1c5c5;">
                {{x.createDate}}
            </td>
            <td style=" border: solid 1px #d1c5c5;">

                <a href="javascript:;" ng-click="clickcontcts(x.id,x.target.loginName)"
                   style="background: #fff;">选择</a>
            </td>
        </tr>
        </tbody>
    </table>
        <div class="loadings"><img src="/static/images/loading.gif">
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

</div>

<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>

<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script>

    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            drivername: '', driverphone: '', isagree: ''
        };

        ////isloadings ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloadings = function (isloadings) {
            if (isloadings == 1) {
                $(".loadings").show();
                $("#noneData").hide();
            } else if (isloadings == 2) {
                $(".loadings").hide();
                $("#noneData").show();
            } else {
                $(".loadings").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };


        $scope.clickcontcts = function (id, username) {
            $("#userid").val(id);
            $("#searchinfo").val(username);
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            search();
        }
        //get first page
        $http({
            url: '${wlpt}/wlpt/contacts/getContactsList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            if (!response.value || !response.value.list) {
                $scope.isloadings(2);
            } else {
                $scope.isloadings(3);
            }
            $scope.data = response.value.list;

            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }

        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloadings(1);
            $http({
                url: '${wlpt}/wlpt/contacts/getContactsList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'searchinfo': $("#searchinfoname").val()
                }
            }).success(function (response) {
                if (!response.value.list || !response.value.list) {
                    $scope.isloadings(2);
                } else {
                    $scope.isloadings(3);
                }
                $scope.data = response.value.list;
                $scope.pages = [];

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
                $("#datainit").show();
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
<script type="text/javascript">
    $(".loading").hide();
    /* if('${goods.isinsur}'=="1"){
     $("#paydepositdiv").show();
     } */
    /* if('${goods.isinsur}'==""){
     $('#ispaydeposit2').trigger("click");
     } */
    /* $("input[name='isinsur']").click(function(){
     var key=$(this).val();
     if(key=="1"){
     $("#paydepositdiv").show();
     }else{
     $("#paydepositdiv").hide();
     }
     }); */

    $("input[name='issend']").click(function () {
        var key = $(this).val();
        if (key == "1") {
            $("#contactsdiv").show();
            $("#btnSubmit").val("下一步,生成运单");
        } else {
            $("#contactsdiv").hide();
            $("#btnSubmit").val("保存");
        }
    });
    function search() {
        var isnul = true;
        isnul = isnul && $("#searchinfo").valid({
                    methods: "required"
                });
        if (isnul) {
            $(".loading").show();
            var searchinfo = $("#searchinfo").val();
            $.ajax({
                url: "${wlpt}/wlpt/goods/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    $("#userid").val("");
                    $(".loading").hide();
                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $("#searchinfo").tips({
                                side: 3,
                                msg: '未查到指定用户!请确认用户是否已注册',
                                bg: '#00A2E9',
                                time: 4
                            });
                        } else if (data.value == '该用户无车辆信息') {
                            $("#searchinfo").tips({
                                side: 3,
                                msg: '该用户无车辆信息,不可指派',
                                bg: '#00A2E9',
                                time: 4
                            });
                        } else if (data.value == '该用户无司机信息') {
                            $("#searchinfo").tips({
                                side: 3,
                                msg: '该用户无司机信息,不可指派',
                                bg: '#00A2E9',
                                time: 4
                            });
                        } else {
                            if (data.value.role.enname != "carowner" && data.value.role.enname != "enterprise") {

                                $("#searchinfo").tips({
                                    side: 3,
                                    msg: '只能指派给物流企业或车主',
                                    bg: '#00A2E9',
                                    time: 4
                                });
                            } else {
                                if (data.value.user.id) {
                                    if (data.value.user.id == "${user.id}") {
                                        $("#searchinfo").tips({
                                            side: 3,
                                            msg: '不可指派给自己，请重新选择',
                                            bg: '#00A2E9',
                                            time: 4
                                        });
                                    } else {
                                        $("#searchinfo").tips({
                                            side: 3,
                                            msg: '可指派',
                                            bg: '#00A2E9',
                                            time: 4
                                        });
                                        $("#userid").val(data.value.user.id);
                                    }

                                }
                            }

                        }
                    }
                }
            });

        }
    }


    change();
    getCarType();
    getTransportWay();
    function change() {
        var gsoddtype = $("#gsoddtype").val();
        var result1;
        var result2;
        if (gsoddtype == '0') {
            result1 = '方';
            result2 = '元/方';
            $("#goodstype").val("0");
        } else {
            result1 = '吨';
            result2 = '元/吨';
            $("#goodstype").val("1");
        }
        $("#a").html(result1);
        $("#b").html(result2);
        $("#freightunit").val(result1);
    }
    function getTransportWay() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=transportway",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#transportway").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#transportway").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    $("#fromAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            var fromcounty = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                // $("#fromcity").val("");
                //$("#fromdistrict").val("");
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                //  $("#fromdistrict").val("");
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                fromcounty = data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            if (fromcounty == "") {
                str = "";
            }
            $("#fromAddress").val(str);
        }
    });

    $("#toAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            var tocounty = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#toprovince").val(data.province.NAME);
                //  $("#tocity").val("");
                //   $("#todistrict").val("");
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                //  $("#todistrict").val("");
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                tocounty = data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            if (tocounty == "") {
                str = "";
            }
            $("#toAddress").val(str);
        }
    });
    $("#btnSubmit").click(function () {
        var isnul = true;
        isnul = isnul && $("input[name=goodsname]").valid({
                    methods: "required|isName"
                });
        isnul = isnul && $("input[name=freightvolume]").valid({
                    methods: "required|decimal"
                });
        isnul = isnul && $("input[name=fromAddress]").valid({
                    methods: "required"
                });
        if ($("#fromcity").val() == "" || $("#fromcity").val() == null) {
            $("#fromAddress").tips({
                side: 3,
                msg: '请选择城市',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        isnul = isnul && $("#shipAdd").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=toAddress]").valid({
                    methods: "required"
                });
        if ($("#tocity").val() == "" || $("#tocity").val() == null) {
            $("#toAddress").tips({
                side: 3,
                msg: '请选择城市',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }

        if ($("#freightvolume").val() == 0 || $("#freightvolume").val() == null || $("#freightvolume").val() == "" || $("#freightvolume").val() == undefined) {
            $("#freightvolume").tips({
                side: 3,
                msg: '必须大于0',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }

        isnul = isnul && $("#consignAdd").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=sendtime]").valid({
                    methods: "required"
                });
        if (isnul) {
            if (diffDate($("input[name=sendtime]")) <= 0) {
                isnul = false;
            }
        }
        if ($("input[name=carlength]").val() != "" && $("input[name=carlength]").val() != null) {
            isnul = isnul && $("input[name=carlength]").valid({
                        methods: "isdecimal"
                    });
        }
        if ($("input[name=expectedprice]").val() != "" && $("input[name=expectedprice]").val() != null) {
            isnul = isnul && $("input[name=expectedprice]").valid({
                        methods: "isdecimal"
                    });
        }
        if ($("input[name=worth]").val() != "" && $("input[name=worth]").val() != null) {
            isnul = isnul && $("input[name=worth]").valid({
                        methods: "isdecimal"
                    });
        }
        if ($("input[name=effectdays]").val() != "" && $("input[name=effectdays]").val() != null) {
            isnul = isnul && $("input[name=effectdays]").valid({
                        methods: "isNum"
                    });
        }
        isnul = isnul && $("#shiplinkman").valid({
                    methods: "required|isName"
                });
        isnul = isnul && $("#shiplinkmobile").valid({
                    methods: "required|isPhone"
                });
        if ($("#shiplinktelphone").val() != "" && $("#shiplinktelphone").val() != null) {
            isnul = isnul && $("#shiplinktelphone").valid({
                        methods: "isTel"
                    });
        }
        isnul = isnul && $("#consignlinkman").valid({
                    methods: "required|isName"
                });
        isnul = isnul && $("#consignlinkmobile").valid({
                    methods: "required|isPhone"
                });
        if ($("#consignlinktelphone").val() != "" && $("#consignlinktelphone").val() != null) {
            isnul = isnul && $("#consignlinktelphone").valid({
                        methods: "isTel"
                    });
        }
        var issend = $("input[name=issend]:checked").val();
        if (issend == 1) {
            isnul = isnul && $("input[name=expectedprice]").valid({
                        methods: "required|isdecimal"
                    });


            var userid = $("#userid").val();
            if (userid == "" || userid == undefined) {
                $("#searchinfo").tips({
                    side: 3,
                    msg: '该用户不可指派，请重新选择',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            } else if (userid == "${user.id}") {
                $("#searchinfo").tips({
                    side: 3,
                    msg: '不可指派给自己，请重新选择',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            }

        }


        /* var isinsur = $("input[name=isinsur]:checked").val();
         if(isinsur==1){
         var paypeople = $("input[name=paypeople]:checked").val();
         if (paypeople == undefined) {
         $("#paypeople").tips({
         side: 3,
         msg: '请选择保单支付方',
         bg: '#00A2E9',
         time: 4
         });
         return false;
         }
         isnul = isnul && $("input[name=worth]").valid({
         methods: "required"
         });
         }
         */
        if ($(".loading").is(':hidden') && isnul) {
            $(".loading").show();
        } else {
            return false;
        }
        if (isnul) {
            $.ajax({
                url: "${wlpt}/wlpt/goods/save?" + $("#Form").serialize(),
                dataType: 'json',
                type: "post",
                success: function (data) {
                    $(".loading").hide();
                    if (data.value.state == 1) {
                        top.$("#rightFrame").parent().prev().children("#accordion").children().eq(1).children(".submenu").css("display", "none").children().removeClass("menuSelect");
                        top.$("#rightFrame").parent().prev().children("#accordion").children().removeClass("open").eq(3).addClass("open").children(".submenu").css("display", "block").children().eq(1).addClass("menuSelect");
                        top.$("#rightFrame").prev().children(".top_left").children("#tabmu").html("/物流信息/货源管理");
                        if (issend == 1 && data.value.data != null && data.value.data.id != "") {
                            window.location.href = '${wlpt}/wlpt/goods/quoteOrder?id=' + data.value.data.id;
                        } else {
                            window.location.href = '${wlpt}/wlpt/goods/goods_list?isRedrect=true';
                        }

                    } else {
                        $.MsgBox.Alert("保存提示", data.value.message);
                    }
                }
            });
        }
    });
    /* iframeAuto();
     function iframeAuto() {
     var bHeight = iframe.contentWindow.document.body.scrollHeight;
     var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
     var height = Math.max(bHeight, dHeight);
     iframe.height = height;
     }*/

    function checkfreight() {
        var freight = $("#freightvolume").val();
        if (freight == 0) {
            $("#freightvolume").tips({
                side: '3',
                msg: '必须大于0',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
    }
</script>
</body>
</html>
