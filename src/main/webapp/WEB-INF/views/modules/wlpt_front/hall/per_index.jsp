<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <title>首页</title>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        .form-control {
            border: 1px solid #ccc !important;
        }

        .msg_four .list-group-item.active, .list-group-item.active:focus, .list-group-item.active:hover {
            background-color: transparent;
        }

        .points_link {
            position: relative;
        }

        .per_intro .per_points {
            cursor: pointer;
            display: inline-block;
            width: 26px;
            height: auto;
            line-height: 41px;
            background-size: 100% 100%;
            top: 13px;
        }

    </style>
</head>
<body style="background: #f5f5f5;">
<div class="row per_show" style="background-color:#fff;">
    <input id="status" value="${user.userinfo.status}" type="hidden"/>
    <div class="col-lg-12" style="background-color:#fff;">
        <div class="col-sm-12 clearfix per_detail">
            <!--用户头像部分-->
            <div class="col-sm-4 clearfix" style="padding:15px 0;border-right:1px solid #ddd;">
                <div class="col-sm-3 pull-left">

                    <c:choose>
                        <c:when test="${empty user.photo}">
                            <img src="${ctxStatic}/front/img/headPic.jpg" alt="" class="img-circle per_head"/>
                        </c:when>
                        <c:otherwise>
                            <img style="width:90px;" class="img-circle per_head" src="${user.photo}"
                                 onerror="this.onerror=null;this.src='${ctxStatic}/front/img/headPic.jpg'"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-sm-9 pull-left">
                    <div class="col-sm-12 clearfix" style="border-bottom:1px solid #ddd;">
                        <p class="text-left per_intro pull-left">
                            <span>上午好，${user.name==null?user.phone:fns:abbr(user.name,16)}</span>
                            <img src="${ctxStatic}/front/img/level_0${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.png"
                                 class="level">
                        </p>

                        <div class="pull-left phone_hover per_intro">
                            <img alt="" class="per_phone" src="${ctxStatic}/front/img/per_phone.png">
                            <div class="per_warning">
                                <span>您已绑定${user.phone}</span>
                            </div>
                        </div>
                        <div class="pull-left per_intro points_link ">
                            <a href="${wlpt}/wlpt/integrity/toIntegrityRecordInfo">
                                <img class="per_points" src="${ctxStatic}/front/img/coins.png" alt=""/>
                            </a>
                            <div class="per_warning">
                                <span>我的积分：<strong>${user.userinfo.point!=null?user.userinfo.point:0}</strong></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <p class="text-left per_intro per_info2">

                            <span title="${user.loginName}">${fns:abbr(user.loginName,16)} &nbsp;|&nbsp;</span>
                            <span style="color: red;">${user.role.name }</span>
                            <c:choose>
                                <c:when test="${user.userinfo.status==0 or user.userinfo.status==3}">
                                    <img src="${ctxStatic}/front/img/has_auth_0.png" class="has_auth">
                                </c:when>
                                <c:when test="${user.userinfo.status==1}">
                                    <img src="${ctxStatic}/front/img/has_auth_1.png" class="has_auth">
                                </c:when>
                                <c:when test="${user.userinfo.status==2}">
                                    <img src="${ctxStatic}/front/img/has_auth_2.png" class="has_auth">
                                </c:when>
                                <c:otherwise>
                                    <img src="${ctxStatic}/front/img/has_auth_0.png" class="has_auth">
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
            </div>
            <!--1-->
            <div class="col-sm-2 clearfix per_account">
                <div class="col-sm-12 clearfix">
                    <p class="pull-left"><span style="font-size:13px;color:#666;">账户余额</span></p>
                    <div class="pull-right issure_warning">
                        <i></i>
                        <div class="per_warning" style="width: 250px;">
                            <span>平台通过线下充值，财务转账进行账户充值</span>
                            <p>充值时间：周一至周五早上8点到晚上18点</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12"><span>可用额度</span></div>
                <div class="col-sm-12">
                    <p><span class="money_n">
        				<c:choose>
                            <c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
                            <c:otherwise><fmt:formatNumber
                                    value="${empty user.userPurse.availablebalance ? '0': user.userPurse.availablebalance }"
                                    pattern="#.##" minFractionDigits="2"></fmt:formatNumber></c:otherwise>
                        </c:choose>
        				</span><span class="money_n_s" style="color:#20a027"></span><span>元</span></p>
                </div>
                <div class="col-sm-12 clearfix">
                    <p class="pull-left">总额度<span>
        				<c:choose>
                            <c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
                            <c:otherwise><fmt:formatNumber
                                    value="${empty user.userPurse.webbalance ? '0': user.userPurse.webbalance }"
                                    pattern="#.##" minFractionDigits="2"></fmt:formatNumber></c:otherwise>
                        </c:choose>
        				</span><span>元</span></p>
                    <div class="pull-right"><a href="${wlpt}/wlpt/consume/toCash" class="text text-primary">提现</a></div>
                </div>
            </div>
            <!--2-->
            <c:choose>
                <c:when test="${not empty user.memberId}">
                    <div class="col-sm-2 per_account" id="account_div">
                        <div class="col-sm-12 clearfix">
                            <p class="pull-left"><span style="font-size:13px;color:#666;">账户系统余额</span></p>
                            <div class="pull-right issure_warning">
                                <i></i>
                                <div class="per_warning">
                                    <span>系统资金24小时在线交易</span>
                                    <p></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12"><span>可用额度</span></div>
                        <div class="col-sm-12">
                            <p><span class="money_n" style="color:#ffa037;" id="AavailableBalance">0</span><span
                                    class="money_n_s" style="color:#ffa037;"></span><span>元</span></p>
                        </div>
                        <div class="col-sm-12 clearfix">
                            <p class="pull-left">总额度<span id="AwebBalance">0</span><span>元</span></p>
                            <div class="pull-right"><a href="${wlpt}/wlpt/consume/toTransfer" class="text text-primary">转账</a>
                            </div>
                        </div>

                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-sm-2 per_account per_account_last" style="border-right: 1px solid #CCC;">
                        <div class="col-sm-12 clearfix">
                            <p class="pull-left">
                                <span style="font-size:13px;color:#666;">待收</span>
                            </p>
                            <div class="pull-right issure_warning">
                                <i></i>
                                <div class="per_warning">
                                    <span>待收／待付特指招标合同业务资金</span>
                                    <p><a href="" class="text text-primary"></a></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <p><span class="money_n" style="color:#ffa037;" id='CREATETOTALCOST'>0.00</span>
                                <span class="money_n_s" style="color:#ffa037;"></span><span>元</span>
                            </p>
                        </div>
                        <div class="col-sm-12" style="border-top:1px solid #ddd;">
                            <p style="margin-top:3px;">
                                <span style="font-size:13px;color:#666;">待付</span>
                            </p>
                            <p><span class="money_n" style="color:#ffa037;" id='STAYPAYTOTALCOST'>0.00</span>
                                <span class="money_n_s" style="color:#ffa037;"></span><span>元</span>
                            </p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

            <!--3-->
            <div class="col-sm-2 per_account" style="height:114px;">
                <div class="col-sm-12 clearfix">
                    <p class="pull-left"><span style="font-size:13px;color:#666;">油气余额</span></p>
                    <div class="pull-right issure_warning">
                        <i></i>
                        <div class="per_warning" style="width: 250px;">
                            <span>油气为一卡通业务资金，分为线上购买与线下充值</span>
                            <p>线上购买与线下充值两种方式</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12" style="margin:2px 0;">
                    <p><span class="money_n" style="color:#ffa037;">
        				<c:choose>
                            <c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
                            <c:otherwise><fmt:formatNumber
                                    value="${empty user.userPurse.petrolbalance ? '0': user.userPurse.petrolbalance}"
                                    pattern="#.##" minFractionDigits="2"></fmt:formatNumber></c:otherwise>
                        </c:choose>
        				</span><span class="money_n_s" style="color:#ffa037;"></span><span>元</span></p>
                </div>
                <div class="col-sm-12">
                    <a href="${wlpt}/wlpt/personal/toApplyCard" class="text text-primary">一卡通</a>
                </div>
            </div>
            <!--4-->
            <div class="col-sm-2 per_account per_account_last">
                <div class="col-sm-12 clearfix">
                    <p class="pull-left">
                        <span style="font-size:13px;color:#666;">保证金</span>
                    </p>
                    <div class="pull-right issure_warning">
                        <i></i>
                        <div class="per_warning">
                            <span>平台信誉保证金，在线交易安全可靠</span>
                            <p><a href="" class="text text-primary"></a></p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12">
                    <p><span class="money_n" style="color:#ffa037;">
        				<c:choose>
                            <c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
                            <c:otherwise><fmt:formatNumber
                                    value="${empty user.userPurse.guaranteemone ? '0': user.userPurse.guaranteemone}"
                                    pattern="#.##" minFractionDigits="2"></fmt:formatNumber> </c:otherwise>
                        </c:choose>
        				</span><span class="money_n_s" style="color:#ffa037;"></span><span>元</span></p>
                </div>
                <div class="col-sm-12" style="border-top:1px solid #ddd;">
                    <p style="margin-top:3px;">
                        <a id="buyZdCoin" href="${wlpt}/wlpt/shop/buyOil?shotName=zd_coin">
                        <b><span style="font-size:13px;color:#00bfff;text-decoration:underline;">卓币</span></b></a>
                    </p>
                    <p><span class="money_n" style="color:#ffa037;">
        					<c:choose>
                                <c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
                                <c:otherwise><fmt:formatNumber
                                        value="${empty user.userPurse.availablecoin ? '0': user.userPurse.availablecoin }"
                                        pattern="#.##" minFractionDigits="2"></fmt:formatNumber></c:otherwise>
                            </c:choose>
        				</span><span class="money_n_s" style="color:#ffa037;"></span><span>元</span></p>
                </div>
            </div>
        </div>
        <!--招标 货源 保险 油气-->
        <div class="col-sm-12 clearfix per_msg" ng-app="dataHall" ng-controller="dataHallCtrl">
            <!--左面4个导航-->
            <div class="col-sm-2 msg_four">
                <ul class="list-group">
                    <c:if test="${user.role.enname!='carowner'}">
                        <li class="list-group-item msg_four_li hasClass">
                            <a href="" ng-click="searchInfo('bid');" data-toggle="tab" data-target="#latest_bid">
                                <img src="${ctxStatic}/front/img/per_bid_click.png" alt="" class="img_red"/>
                                <img src="${ctxStatic}/front/img/per_bid.png" alt="" class="img_black"/>
                                <span>招标</span>
                                <em class="badge" ng-cloak>{{bidNum}}</em>
                            </a>
                        </li>
                    </c:if>
                    <li class="list-group-item msg_four_li ${user.role.enname=='carowner'?'hasClass':''}">
                        <a href="" ng-click="searchInfo('trade');" data-toggle="tab" data-target="#latest_waybill">
                            <img src="${ctxStatic}/front/img/per_thing.png" class="img_black"/>
                            <img src="${ctxStatic}/front/img/per_thing_click.png" class="img_red"/>
                            <span>货源</span>
                            <em class="badge" ng-cloak>{{goodsNum}}</em>
                        </a>
                    </li>
                    <li class="list-group-item msg_four_li">
                        <a href="">
                            <img src="${ctxStatic}/front/img/per_issure.png" alt="" class="img_black"/>
                            <img alt="" src="${ctxStatic}/front/img/per_issure_click.png" class="img_red"/>
                            <span>保险</span>
                            <em class="badge circle_badge"></em>
                        </a>
                    </li>
                    <li class="list-group-item msg_four_li">
                        <a href="">
                            <img src="${ctxStatic}/front/img/per_oil.png" alt="" class="img_black"/>
                            <img alt="" src="${ctxStatic}/front/img/per_oil_click.png" class="img_red"/>
                            <span>油气</span>
                            <em class="badge circle_badge"></em>
                        </a>
                    </li>
                    <div class="current_bar">
                        <img src="${ctxStatic}/front/img/per_tab.png" alt=""/>
                    </div>
                </ul>
            </div>
            <!--右边详细内容-->
            <div class="col-sm-10 msg_data">
                <input type="hidden" id="tab" value="${user.role.enname!='carowner'?'bid':'trade'}"/>
                <!--搜索-->
                <div class="col-sm-12 msg_search">
                    <div class="col-sm-2" style="margin-bottom:20px;">
                        <input class="form-control" placeholder="货物名称" id="goodsname">
                    </div>
                    <div class="col-sm-3" style="margin-bottom:20px;">
                        <input id="fromprovince" type="hidden" class="search-in" ng-model="searchData.fromprovince"
                               name="search-in"/>
                        <input id="fromcity" type="hidden" class="search-in" ng-model="searchData.fromcity"
                               name="search-in"/>
                        <input id="fromdistrict" type="hidden" class="search-in" ng-model="searchData.fromdistrict"
                               name="search-in"/>

                        <input class="form-control" readonly="readonly" id="addressStart" placeholder="出发地">
                    </div>
                    <div class="col-sm-3" style="margin-bottom:20px;">
                        <input id="toprovince" type="hidden" class="search-in" ng-model="searchData.toprovince"
                               name="search-in"/>
                        <input id="tocity" type="hidden" class="search-in" ng-model="searchData.tocity"
                               name="search-in"/>
                        <input id="todistrict" type="hidden" class="search-in" ng-model="searchData.todistrict"
                               name="search-in"/>

                        <input class="form-control" readonly="readonly" id="addressEnd" placeholder="目的地">
                    </div>
                    <div class="col-sm-2 btn-search-wrap">
                        <button class="btn btn-primary" style="width: 128px;" ng-click="searchInfo();"><i
                                class="fa fa-search white"></i> 查询
                        </button>
                    </div>
                </div>
                <div class="col-sm-12 data_all">
                    <c:if test="${user.role.enname!='carowner'}">
                        <!--招标信息-->
                        <div class="col-sm-12 search_wrap col_bid" id="bid">
                            <div style="overflow: auto;width: 100%;">
                                <table class="table" id="waybill_table">
                                    <thead>
                                    <tr>
                                        <th>招标文号</th>
                                        <th>操作</th>
                                        <th>发标用户</th>
                                        <th>货物名称</th>
                                        <th>重量/体积</th>
                                        <th>提货点</th>
                                        <th>卸货点</th>
                                        <th>状态</th>
                                        <th>截止时间</th>
                                    </tr>
                                    </thead>
                                    <tbody class="datainit">
                                    <tr ng-repeat="x2 in data2">
                                        <td ng-cloak>{{x2.bidcode}}</td>
                                        <td ng-cloak><a ng-cloak ng-if="x2.bidstatus=='发布' && x2.biddingList==null"
                                                        class="orange oprate" ng-click="checkbid(x2.id)"
                                        >竞标<!-- ({{x2.biddingcount}}) -->
                                        </a></td>
                                        <td ng-cloak title="{{x2.biduser.loginName}}/{{x2.biduser.phone }}">
                                            {{x2.biduser.loginName}}
                                        </td>
                                        <td ng-cloak>{{x2.goods.goodsname}}</td>
                                        <td ng-cloak>{{x2.goods.freightvolume| number :3}}{{x2.goods.freightunit}}</td>

                                        <td ng-cloak>
                                            {{x2.goods.shipAddress.city}} {{x2.goods.shipAddress.district}}
                                        </td>
                                        <td ng-cloak>
                                            {{x2.goods.consignAddress.city}} {{x2.goods.consignAddress.district}}
                                        </td>
                                        <td ng-cloak>
                                            <span ng-cloak ng-if="(x2.bidstatus=='草稿')" class="deep_greeen">{{x2.bidstatus}}</span>
                                            <span ng-cloak ng-if="(x2.bidstatus=='发布')" class="green">竞标中</span>
                                            <span ng-cloak ng-if="(x2.bidstatus=='正在交易中')"
                                                  class="blue">{{x2.bidstatus}}</span>
                                            <span ng-cloak ng-if="(x2.bidstatus=='废标')"
                                                  class="red">{{x2.bidstatus}}</span>
                                            <span ng-cloak ng-if="(x2.bidstatus=='已截标')" class="dark_yellow">{{x2.bidstatus}}</span>
                                            <span ng-cloak ng-if="(x2.bidstatus=='交易完成')" class="orange">{{x2.bidstatus}}</span>
                                        </td>
                                        <td ng-cloak>{{x2.endtime.substr(0,20)}}</td>
                                    </tr>

                                    </tbody>
                                </table>

                            </div>
                            <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                                <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                            </div>
                            <div>
                                <!--分页-->
                                <tm-pagination conf="paginationConf2"></tm-pagination>
                            </div>
                        </div>
                    </c:if>
                    <!--货源信息-->
                    <div class="col-sm-12 search_wrap col_bid" style="width: 100%;" id="trade">
                        <div style="overflow: auto;width: 100%;">
                            <table class="table" id="goods_table">
                                <thead>
                                <tr>
                                    <th>货物名称</th>
                                    <th>操作</th>
                                    <th>发货用户</th>
                                    <th>提货点</th>
                                    <th>卸货点</th>
                                    <th>货物类型</th>
                                    <th>货源价格</th>
                                    <th>运量</th>
                                    <th>剩余</th>
                                    <th>状态</th>
                                    <th>装车时间</th>
                                </tr>
                                </thead>
                                <tbody class="datainit">
                                <tr ng-repeat="x in data">
                                    <td ng-cloak>{{x.goodsname}}</td>
                                    <td ng-cloak>
                                        <a ng-cloak ng-show="x.status == 1" ng-click="checkgoods(x.id) "
                                           class="orange oprate">抢&nbsp;&nbsp;单</a>
                                        <span ng-cloak ng-show="x.status == 3" class="see oprate">已报价</span>
                                        <span ng-cloak ng-show="x.status == 2" class="see oprate">内部货源</span>
                                    </td>
                                    <td ng-cloak title="{{x.user.loginName}}/{{x.user.phone}}">{{x.user.loginName}}</td>
                                    <td ng-cloak>{{x.shipAddress.city}}{{x.shipAddress.district}}</td>
                                    <td ng-cloak>{{x.consignAddress.city}}{{x.consignAddress.district}}</td>
                                    <td ng-cloak>{{x.gsoddtype}}</td>
                                    <td ng-cloak>{{x.expectedprice}}元/{{x.freightunit}}</td>
                                    <td ng-cloak>{{x.freightvolume | number:3}}{{x.freightunit}}</td>
                                    <td ng-cloak>{{x.residualvolume | number:3}}{{x.freightunit}}</td>
                                    <td class="green" ng-cloak>
                                        <span ng-cloak ng-if="(x.tradestatus=='开始报价')"
                                              class="green">{{x.tradestatus}}</span>
                                        <span ng-cloak ng-if="(x.tradestatus=='报价中')"
                                              class="blue">{{x.tradestatus}}</span>
                                        <span ng-cloak ng-if="(x.tradestatus=='报价结束')"
                                              class="orange">{{x.tradestatus}}</span>
                                    </td>
                                    <td ng-cloak>{{x.sendtime}}</td>
                                </tr>


                                </tbody>
                            </table>
                        </div>
                        <div id="noneData1" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                            <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                        </div>
                        <!--分页-->
                        <div>
                            <tm-pagination conf="paginationConf"></tm-pagination>
                        </div>
                    </div>
                    <!--保险信息-->
                    <div class="col-sm-12 per_detail_img">
                        <a href="${wlpt}/wlpt/shop/buyInsur?shotName=bao_xian"><img
                                src="${ctxStatic}/front/img/per_issure.jpg" alt=""/></a>
                    </div>
                    <!--油气信息-->
                    <div class="col-sm-12 per_detail_img">
                        <a id="buyOil" href="${wlpt}/wlpt/shop/buyOil?shotName=you_qi"><img
                                src="${ctxStatic}/front/img/per_oil.jpg" alt=""/></a>
                    </div>
                </div>
            </div>
        </div>
        <!--end-->
    </div>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script>
	var mainPage=$('iframe',parent.document);
	$('#buyOil').click(function(e){
		e.preventDefault();
		var src=$(this).attr('href');
		mainPage.attr('src',src);
	});
	$('#buyZdCoin').click(function(e){
		e.preventDefault();
		var src=$(this).attr('href');
		mainPage.attr('src',src);
	});
    var w = document.documentElement.clientWidth;
    if (w < 1010) {
        $('.row').css('width', '1010px').css('background-color', '#fff').css('overflow-x', 'hidden').css('overflow-y', 'hidden');
        $('.data-model').css('height', '55px').find('.col-sm-2').css('margin-right', '1%');
    }


    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            ishow: true,
            currentPage: 1,
            itemsPerPage: 10
        };
        //配置分页基本参数
        $scope.paginationConf2 = {
            ishow: true,
            currentPage: 1,
            itemsPerPage: 10
        };
        $scope.goodsNum = 0;
        $scope.bidNum = 0;
        $scope.tab_info = 'bid';
        $scope.post_url = "${wlpt}/wlpt/hall/getbidsList";
        <c:if test="${user.role.enname=='carowner'}">
        $scope.tab_info = "trade";
        $scope.post_url = "${wlpt}/wlpt/hall/getGoodsList";
        </c:if>

        ///查询参数初始化
        $scope.postData = {
            type: '1',
            orderBy: '',
            pageNo: $scope.paginationConf.currentPage,
            pageSize: $scope.paginationConf.itemsPerPage
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $("#maskloading", parent.document).show();

                if ($scope.tab_info == 'trade') {
                    $("#noneData1").hide();
                } else {
                    $("#noneData").hide();
                }
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();

                if ($scope.tab_info == 'trade') {
                    $("#noneData1").show();
                } else {
                    $("#noneData").show();
                }

                $(".datainit").hide();
            } else {
                $("#maskloading", parent.document).hide();

                if ($scope.tab_info == 'trade') {
                    $("#noneData1").hide();
                } else {
                    $("#noneData").hide();
                }

                $(".datainit").show();
            }
        };
        $scope.checkbid = function (id) {
            var status = $("#status").val();
            if (!status) {
                $.MsgBox.Alert("温馨提示", "登录后才能竞标");
                return false;
            } else if (status != '2') {
                $.MsgBox.Alert("温馨提示", "认证后才能竞标");
                return false;
            } else {
                window.location.href = "${wlpt}/wlpt/bid/toBidding?bidinfoId=" + id;
                return true;
            }
        };
        $scope.checkgoods = function (id) {
            var status = $("#status").val();
            if (!status) {
                $.MsgBox.Alert("温馨提示", "登录后才能抢单");
                return false;
            } else if (status != '2') {
                $.MsgBox.Alert("温馨提示", "认证后才能抢单");
                return false;
            } else {
                <c:if test="${user.role.enname eq 'goodsowner'}">
                $.MsgBox.Alert("温馨提示", "货主不能抢单");
                return false;
                </c:if>
                window.location.href = "${wlpt}/wlpt/goods/goodsQuote?id=" + id;
                return true;
            }
        };


        $scope.searchInfo = function (tab) {
            if (tab == '' || tab == "" || tab == undefined) {
                tab = $("#tab").val();
            }
            $("#maskloading", parent.document).show();
            /* $("#tab_button_div button").removeClass("btn-active")
             $("#"+tab+"_button").addClass("btn-active"); */


            $scope.post_url = "${wlpt}/wlpt/hall/getbidsList";
            $scope.tab_info = tab;
            <c:if test="${user.role.enname=='carowner'}">
            $scope.tab_info = "trade";
            $scope.post_url = "${wlpt}/wlpt/hall/getGoodsList";
            </c:if>

            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
            if ($scope.tab_info == 'trade') {
                $scope.post_url = "${wlpt}/wlpt/hall/getGoodsList";
            } else {
                $scope.post_url = "${wlpt}/wlpt/hall/getbidsList";
                $scope.paginationConf2.currentPage = 1;
                $scope.paginationConf2.itemsPerPage = 10;
            }
            $("#tab").val(tab);
            //alert($scope.tab_info+"====="+$scope.post_url);
            GetAllEmployee();

        };
        var GetAllEmployee = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
            if ($scope.tab_info == 'trade') {
                $scope.postData = {
                    'shipAddress.province': $("#fromprovince").val(),
                    'shipAddress.city': $("#fromcity").val(),
                    'shipAddress.district': $("#fromdistrict").val(),
                    'consignAddress.province': $("#toprovince").val(),
                    'consignAddress.city': $("#tocity").val(),
                    'consignAddress.district': $("#todistrict").val(),
                    goodsname: $("#goodsname").val(),
                    type: '1',
                    orderBy: '',
                    pageNo: $scope.paginationConf.currentPage,
                    pageSize: $scope.paginationConf.itemsPerPage
                };
                /* $scope.postData.pageNo = $scope.paginationConf.currentPage;
                 $scope.postData.pageSize = $scope.paginationConf.itemsPerPage; */
            } else {
                $scope.postData = {
                    'goods.shipAddress.province': $("#fromprovince").val(),
                    'goods.shipAddress.city': $("#fromcity").val(),
                    'goods.shipAddress.district': $("#fromdistrict").val(),
                    'goods.consignAddress.province': $("#toprovince").val(),
                    'goods.consignAddress.city': $("#tocity").val(),
                    'goods.consignAddress.district': $("#todistrict").val(),
                    'goods.goodsname': $("#goodsname").val(),
                    type: '1',
                    orderBy: '',
                    pageNo: $scope.paginationConf2.currentPage,
                    pageSize: $scope.paginationConf2.itemsPerPage
                };
                /*
                 $scope.postData.pageNo = $scope.paginationConf2.currentPage;
                 $scope.postData.pageSize = $scope.paginationConf2.itemsPerPage;
                 */
            }

            $http({
                url: $scope.post_url,
                method: 'post',
                params: $scope.postData
            }).success(function (response) {
                $scope.tab_info = $("#tab").val();
                $scope.paginationConf.totalItems = response.value.count;
                if ($scope.tab_info == 'trade') {
                    $("#trade").show();
                    $("#bid").hide();
                    $scope.data = response.value.list;
                    $scope.paginationConf.totalItems = response.value.count;

                } else {
                    $("#bid").show();
                    $("#trade").hide();
                    $scope.data2 = response.value.list;
                    $scope.paginationConf2.totalItems = response.value.count;
                }
                if (!response.value.count) {
                    /*$scope.$apply(function () {
                     });*/
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };
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
        var GetStatusList = function () {
            $http.get("${wlpt}/wlpt/hall/getGoodsAndBidNum").success(function (response) {
                $scope.goodsNum = response.value.goodsnum;
                <c:if test="${user.role.enname!='carowner'}">
                $scope.bidNum = response.value.bidnum;
                </c:if>

            });
        }
        GetStatusList();
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/

        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

        <c:if test="${user.role.enname!='carowner'}">
        $scope.$watch('paginationConf2.currentPage + paginationConf2.itemsPerPage', GetAllEmployee);
        </c:if>
    }]);


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
        hasCounty: false,
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


    //绑定手机号
    $('.phone_hover').hover(function () {
        $(this).find('.per_warning').toggle();
    });
    $('.issure_warning').hover(function () {
        $(this).find('.per_warning').toggle();
    });
    $('.points_link').hover(function () {
        $(this).find('.per_warning').toggle();
    });

    //页面 招标 货源等 的高度问题
    var bheight = document.documentElement.clientHeight;
    var bwidth = document.documentElement.clientWidth;
    //整体的高度 铺满一屏
    $('.per_show').height(bheight - 35 + 'px');
    //$('.per_msg').height(bheight-150+'px');   //一旦定义高度 给他的父元素增加overflow-y才可以看见隐藏的内容
    //右边内容的宽度
    var l_h = $('.per_msg').width() - $('.msg_four').width() - 74;//60
    $('.per_msg .col-sm-10').width(l_h + 'px');


    //点击切换内容
    $('.msg_four li').click(function () {
        $(this).removeClass('active');
        $(this).find('.img_red').show();
        $(this).find('.img_black').hide();
        $(this).siblings().find('.img_red').hide().find('.img_black').show();
        $(this).siblings().find('.img_black').show();
        $(this).siblings().removeClass('hasClass');
        $(this).addClass('hasClass');
        var h = 79;
        var index = $(this).index();
        $('.current_bar').css('top', index * h + 15 + 'px');
        $('.data_all .col-sm-12').eq(index).slideDown().siblings().slideUp();
        if (index == 2 || index == 3) {
            $('.msg_search').hide();
        } else {
            $('.msg_search').show();
        }
    });
    $('.msg_four li a').click(function (e) {
        e.preventDefault();
    });
    //金额数字格式化
    $('.money_n').each(function () {
        var s = $(this).text();
        n = 2;
        s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";
        var l = s.split(".")[0].split("").reverse(),
            r = s.split(".")[1];
        t = "";
        for (i = 0; i < l.length; i++) {
            t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
        }
        var num = t.split("").reverse().join("") + "." + r;//整个数字
        var new_num = t.split("").reverse().join("");
        var num_s = num.slice(-3);
        $(this).text(new_num);
        $(this).next().text(num_s);
    });
    //判断是否是ie浏览器
    function isIE() { //ie?
        if (!!window.ActiveXObject || "ActiveXObject" in window) {
            var l_h = $('.per_msg').width() - $('.msg_four').width() - 80;
            $('.per_msg .col-sm-10').width(l_h + 'px');
        }
    }
    isIE();
    //头像部分的宽度问题
    var jj = $('.per_detail .col-sm-4').width() - 100;
    $('.per_detail .col-sm-4 .col-sm-9').width(jj + 'px');
    //$('.per_detail .col-sm-4 .col-sm-3').width(84+'px');
    //没有账户系统余额部分的时候
    var col_l = $('.per_detail .col-sm-2').length;
    var col_w = $('.per_detail').width() - $('.per_detail .col-sm-4').width() - 30;
    $('.per_detail .col-sm-2').width(col_w / col_l + 'px');


</script>
<script type="text/javascript">
    var memberId = "${user.memberId}"
    if (memberId != null && memberId != "") {
        click();
    } else {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/personal/getOrderinfoSum',
            dataType: 'json',
            data: {},
            cache: false,
            success: function (data) {
                if (data.state == 1) {
                    $("#STAYPAYTOTALCOST").html(
                        data.nopaymentOrder.sumtotalcost);
                    fomatNum();
                }
            }
        });

        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/personal/getBidOrderinfoSum',
            dataType: 'json',
            data: {},
            cache: false,
            success: function (data) {
                if (data.state == 1) {
                    $("#CREATETOTALCOST")
                        .html(data.bidOrderNo.sumcontracttotal);
                    fomatNum();
                }
            }
        });
    }
    function fomatNum() {
        var CREATETOTALCOST = $("#CREATETOTALCOST").html();
        var STAYPAYTOTALCOST = $("#STAYPAYTOTALCOST").html();
        if (CREATETOTALCOST != "" && CREATETOTALCOST != '' && CREATETOTALCOST != undefined) {
            $("#CREATETOTALCOST").html(
                fomatPrice(CREATETOTALCOST * 1 > 0 ? CREATETOTALCOST * 1 : "0"));
        } else {
            $("#CREATETOTALCOST").html("0.0");
        }
        if (STAYPAYTOTALCOST != "" && STAYPAYTOTALCOST != '' && STAYPAYTOTALCOST != undefined) {
            $("#STAYPAYTOTALCOST").html(
                fomatPrice(STAYPAYTOTALCOST * 1 > 0 ? STAYPAYTOTALCOST * 1 : "0"));
        } else {
            $("#STAYPAYTOTALCOST").html("0.0");
        }

        if (STAYPAYTOTALCOST == '0') {
            $("#CREATETOTALCOST").html("0.0");
        }
        if (STAYPAYTOTALCOST == '0') {
            $("#STAYPAYTOTALCOST").html("0.0");
        }
    }
    function click() {
        $.ajax({
            url: "${wlpt}/wlpt/consume/virtAcctList",
            dataType: 'json',
            data: {"memberId": memberId, "status": '1'},
            type: "post",
            success: function (data) {
                if (data.status == 200) {
                    var slaveAccounts = data.body.records[0].slaveAccounts;
                    for (i = 0; i < slaveAccounts.length; i++) {
                        if (slaveAccounts[i].accountType == 4) {
                            var webbalance = slaveAccounts[i].availableBalance + slaveAccounts[i].lockBalance + slaveAccounts[i].freezeBalance + slaveAccounts[i].undeterminedBalance;
                            webbalance = xround(webbalance, 2);
                            var availableBalance = slaveAccounts[i].availableBalance;
                            var freezemoney = slaveAccounts[i].freezeBalance;
                            $("#AwebBalance").html(webbalance);
                            $("#AavailableBalance").html(availableBalance);
                            /* $("#AfreezeBalance").html(freezemoney); */
                            /* var lockBalance=slaveAccounts[i].lockBalance;
                             $("#AlockBalance").html(lockBalance); */

                        }

                    }

                }
            }
        });
    }
</script>
</body>
</html>