<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>我的保单</title>
    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            padding: 10px;
            line-height: 1.42857143;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
            vertical-align: bottom;
            white-space: nowrap;
            box-sizing: border-box;
        }

        .fixed {
            position: fixed;
            background: #069DD5 !important;
            width: 200px;
        }

        .goods_details .form-group {
            margin-left: 2.5%;
            margin-right: 2.5%;
        }

        .has-js .label_radio {
            width: 18%;
        }

        .table-bordered > tbody > tr > td {
            border: 1px solid #000;
            color: #000;
        }

        #modal td {
            line-height: 40px;
            padding: 0;
        }

        #modal .col-sm-4, #modal .col-sm-2, #modal .col-sm-3, #modal .col-sm-6 {
            border-right: 1px solid #000;
        }
        #insutabel .col-sm-4 , #insutabel .col-sm-6, #insutabel .col-sm-2{
            border-right: 1px solid #0000001c!important;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">我的保单</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-2">
                                <input id="searchinfo" ng-model="searchData.searchinfo" type="text" class="form-control"
                                       placeholder="投保人/车牌号/手机号/货物名称"/>
                            </div>
                            <%--<div class="col-sm-2">
                                <input id="cartype" type="text" ng-model="searchData.cartype" class="form-control"
                                       placeholder="车型"/>
                            </div>--%>
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="请选择开始时间" name="beginCreateDate"
                                       id="beginCreateDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                            </div>
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="请选择结束时间" name="endCreateDate"
                                       id="endCreateDate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                            </div>
                            <div class="col-sm-1">
                                <select id="searchtype" ng-model="searchData.searchtype" class="form-control" placeholder="时间类型">
                                    <option value=''>全部</option>
                                    <option value='true'>起</option>
                                    <option value='false'>止</option>
                                </select>
                            </div>
                            <div class="col-sm-2">
                                <select id="status" ng-model="searchData.status" class="form-control" placeholder="状态">
                                    <option value=''>全部</option>
                                    <option value='0'>新建单</option>
                                    <option value='1'>处理中</option>
                                    <option value='2'>投保成功</option>
                                    <option value='3'>投保失败</option>
                                </select>
                            </div>

                            <div class="col-sm-2 btn-search-wrap">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary" style="width: 128px;"><i class="fa fa-search white"></i>
                                    查询
                                </button>
                            </div>

                        </form>
                    </div>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>保单号</th>
                            <th>手机号码</th>
                            <th>车牌号码</th>
                            <th>车型</th>
                            <th>保险类型</th>
                            <th>投保时间</th>
                            <th>保险到期</th>
                            <th>保单状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody class="datainit">
                        <tr ng-repeat="x in data">
                            <td ng-cloak>
                                {{x.applicant}}
                            </td>
                            <td ng-cloak>
                                {{x.insuranceNO}}
                            </td>
                            <td ng-cloak>
                                {{x.applicantAddress!=null? x.applicantAddress.linkmobile:"" }}
                            </td>
                            <td ng-cloak>
                                {{x.carnumber}}
                            </td>
                            <td ng-cloak>
                                {{x.cartype}}
                            </td>
                            <td ng-cloak>
<%--
                                <span ng-if="x.insurlist.ismeasure==0" ng-cloak>{{x.shipAddress!=null?x.shipAddress.province:""}}{{x.shipAddress!=null?x.shipAddress.city:""}} - {{x.shipAddress!=null?x.consignAddress.province:""}}{{x.shipAddress!=null?x.consignAddress.city:""}}</span>
--%>
                                {{x.insurancetype}}
                            </td>
                            <td ng-cloak>
                                {{x.startTime!=null?x.startTime:'暂未投保'}}
                            </td>
                            <td ng-cloak>
                                剩余{{x.dueTime!=null?x.dueTime:'0'}}天
                            </td>
                            <td ng-cloak>
                                {{x.status}}
                            </td>
                            <td ng-cloak>
                                <a ng-click="getObjDetail(x.id)" data-toggle="modal" data-target="#modal"
                                   class="see oprate">查看</a>
                                <a ng-if="x.statusInt==0 && x.insurlist.ismeasure==0"
                                   href="${wlpt}/wlpt/shop/toInsurPay?id={{x.id}}" target="content"
                                   class="green oprate">支付</a>
                                <a ng-if="x.statusInt==0 && x.insurlist.ismeasure==1 && x.measurestatus==1"
                                   href="${wlpt}/wlpt/shop/toInsurPay?id={{x.id}}" target="content"
                                   class="green oprate">支付</a>
                                <a ng-if="x.statusInt==0 && x.insurlist.ismeasure==1 && x.measurestatus!=1"
                                   target="content" class="see oprate">测算中</a>
                                <a ng-if="x.statusInt==0" href="${wlpt}/wlpt/shop/cancelInsur?id={{x.id}}"
                                   target="content" class="orange oprate">取消</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                    <!-- <div class="loading">
                        <img src="/static/images/loading.gif">
                        <p>加载中</p>
                    </div> -->
                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>

        </div>
    </div>
    <div class="row">
        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal"
             style="margin:auto;overflow-y:hidden;">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4 class="modal-title">保单详情</h4>
                    </div>
                    <div class="modal-body modal-body-h" style="overflow:scroll;">
                        <div class="col-sm-12">
                            <table class="table table-bordered">
                                <caption class="text-center" style="color:#000;">保单详情</caption>
                                <tr>
                                    <td class="text-center" rowspan='{{detal.insurance.insurlist.insuranceway==1?4:5}}'
                                        style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">投保信息</div>
                                    </td>

                                    <td>
                                        <div class="col-sm-4">
                                            保单号
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.insuranceNO}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            关联运单号
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.orderno}}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="col-sm-4">
                                            投保人
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.applicant}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            联系电话
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.applicantAddress.linkmobile}}
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">证件号</div>
                                        <div class="col-sm-8">{{detal.insurance.cardNo}}</div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">投保单位</div>
                                        <div class="col-sm-8"></div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td>
                                        <div class="col-sm-4">
                                            被保货物
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.goodsname}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            货物价值
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.worth}}元
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">货物类型</div>
                                        <div class="col-sm-8">{{detal.insurance.goodstype}}</div>
                                    </td>
                                    <td style="border-left:0;">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8"></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="col-sm-4">联系地址</div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.applicantAddress.province}}
                                            {{detal.insurance.applicantAddress.city}}
                                            {{detal.insurance.applicantAddress.district}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">详细地址</div>
                                        <div class="col-sm-8">{{detal.insurance.applicantAddress.address}}</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center" rowspan="{{detal.insurance.insurlist.insuranceway==1?5:3}}"
                                        style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">车辆信息</div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            车牌号码
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.carnumber}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            厂牌型号
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.carmodel}}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="col-sm-4">
                                            车辆类型
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.cartype}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            总质量
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.totalweight}}吨
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">车辆载重</div>
                                        <div class="col-sm-8">{{detal.insurance.carweight}}吨</div>
                                    </td>
                                    <td style="border-left:0;">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8"></div>
                                    </td>
                                </tr>

                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td>
                                        <div class="col-sm-4">车辆载重</div>
                                        <div class="col-sm-8">{{detal.insurance.carweight}}吨</div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">核定载客</div>
                                        <div class="col-sm-8">{{detal.insurance.passengersnum}} 人</div>
                                    </td>
                                </tr>

                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td>
                                        <div class="col-sm-4">
                                            使用性质
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.usecharacter}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            识别代码
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.vin}}
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td>
                                        <div class="col-sm-4">
                                            发动机号码
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.engineNo}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            登记日期
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.sendtime.substring(0,10)}}
                                        </div>
                                    </td>
                                </tr>

                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td class="text-center" rowspan="2" style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">运输信息</div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            始发地
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.shipAddress.province}}
                                            {{detal.insurance.shipAddress.city}}
                                            {{detal.insurance.shipAddress.district}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            详细地址
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.shipAddress.address}}
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td>
                                        <div class="col-sm-4">
                                            目的地
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.consignAddress.province}}
                                            {{detal.insurance.consignAddress.city}}
                                            {{detal.insurance.consignAddress.district}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            详细地址
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.consignAddress.address}}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center" rowspan="5" style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">承保信息</div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            承包险种
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.insurancetype}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">
                                            保险费合计
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.insurancefeel}}元
                                        </div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 0">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">
                                            理赔保险金额
                                        </div>
                                        <div class="col-sm-8">
                                            最高{{detal.insurance.insuranceamount}}元
                                        </div>
                                    </td>
                                    <td style="border-left:0;">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8"></div>
                                    </td>
                                </tr>
                                <%--<tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">
                                            本次购选保险
                                        </div>
                                        <div class="col-sm-8">
                         				<span>
                         					{{detal.insurance.subtype}}
                         				</span>

                                        </div>
                                    </td>
                                    <td style="border-left:0;">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8"></div>
                                    </td>
                                </tr>--%>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">
                                            交强险
                                        </div>
                                        <div class="col-sm-8">
                                            起：{{detal.insurance.jqxstartTime.substring(0,10)}};止{{detal.insurance.jqxendTime.substring(0,10)}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">总计</div>
                                        <div class="col-sm-8">{{detal.insurance.jqxinsurancefeel}}</div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">
                                            商业险
                                        </div>
                                        <div class="col-sm-8">
                                            起：{{detal.insurance.startTime.substring(0,10)}};止{{detal.insurance.endTime.substring(0,10)}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">总计</div>
                                        <div class="col-sm-8">{{detal.insurance.syxinsurancefeel}}</div>
                                    </td>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="" colspan="2">
                                        <%--<div class="col-sm-2 ">
                                            商业险
                                        </div>--%>
                                        <div class="col-sm-12">
                                            <%-- <div class="col-sm-2">险种</div>
                                             <div class="col-sm-2">保险金额</div>
                                             <div class="col-sm-2">保险费</div>
                                             <div class="col-sm-2">是否不计免赔</div>
                                             <div class="col-sm-2">保险费小计</div>--%>
                                            <table id="insutabel" style="border: 1px solid #C8CCD7;width: 100%;">
                                                <%--<tr>
                                                    <td>
                                                        <div class="col-sm-2 text-center">商业险</div>
                                                        <div class="col-sm-6 text-center">起：
                                                        </div>
                                                        <div class="col-sm-4">总计：</div>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td style="border: 1px solid #C8CCD7;">
                                                        <div class="col-sm-4 text-center">险种</div>
                                                        <div class="col-sm-2 text-center">保险金额</div>
                                                        <div class="col-sm-2 text-center">保险费</div>
                                                        <div class="col-sm-2 text-center">不计免赔?</div>
                                                        <div class="col-sm-2 text-center">保险费小计</div>
                                                    </td>
                                                    <%--<td>保险金额</td>
                                                    <td>保险费</td>
                                                    <td>是否不计免赔</td>
                                                    <td>保险费小计</td>--%>
                                                </tr>
                                                <tr ng-repeat="x in detal.insurance.infoList">
                                                    <td style="border: 1px solid #C8CCD7;">
                                                        <div class="col-sm-4">{{x.name}}</div>
                                                        <div class="col-sm-2 text-center">{{x.insuredamount}}</div>
                                                        <div class="col-sm-2 text-center">{{x.insurancepremium}}</div>
                                                        <div class="col-sm-2 text-center">{{x.isfranchise == 1?"是":"否"}}</div>
                                                        <div class="col-sm-2 text-center">{{x.subtotal}}</div>
                                                    </td>
                                                </tr>

                                            </table>
                                        </div>
                                    </td>
                                    <%--<td style="border-left:0;">
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8"></div>
                                    </td>--%>
                                </tr>
                                <tr ng-if="detal.insurance.insurlist.insuranceway == 1">
                                    <td style="border-right:0;">
                                        <div class="col-sm-4">
                                            银行流水号
                                        </div>
                                        <div class="col-sm-8">
                                            {{detal.insurance.serialNumber}}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="col-sm-4">投保时间</div>
                                        <div class="col-sm-8">{{detal.insurance.insuredTime.substring(0,10)}}</div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="text-center" style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">理赔记录</div>
                                    </td>
                                    <td colspan="2">
                                        {{detal.insurance.ClaimsRecords}}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center" style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">处理信息</div>
                                    </td>
                                    <td colspan="2" class="text-center" style="vertical-align: middle;border-right: 0; ">
                                        <div class="col-sm-4">核保：{{detal.insurance.underwriting}}</div>
                                        <div class="col-sm-4">制单：{{detal.insurance.voucher}}</div>
                                        <div class="col-sm-4">经办人：{{detal.insurance.agent}}</div>
                                    </td>

                                </tr>

                                <tr>
                                    <td class="text-center" style="vertical-align: middle;">
                                        <div class="col-sm-12 control-label">保单图片</div>
                                    </td>
                                    <td style="border-right:0;" colspan="2">
                                        <img  ng-if="detal.insurance.voucherimg !=null " src="{{detal.insurance.voucherimg}}" alt=""
                                             style="margin:2px;height: 120px;width: 120px;"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script
        src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script>

    var app = angular.module("dataHall", ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ///初始化搜索条件
        $scope.searchData = {
            searchinfo: '', cartype: '', carlength: '', issocialcar: '',searchtype:'',beginCreateDate:'',endCreateDate:''
        };

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
                'searchinfo': $("#searchinfo").val(),
                'cartype': $("#cartype").val(),
                'goodsname': $("#goodsname").val(),
                'status': $("#status").val(),
                searchtype:$("#searchtype").val(),
                beginCreateDate:$("#beginCreateDate").val(),
                endCreateDate:$("#endCreateDate").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/insur/getInsurList',
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

        $scope.getObjDetail = function (id) {
            $http.get("${wlpt}/wlpt/insur/getDetail?id=" + id).success(function (response) {
                $scope.detal = response.data;/// 招标详情
                $("#modal").show();
            });
        };

        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

    }]);


    getCarType();

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

    function check() {
        var status = "${user.userinfo.status}";
        if (status != '2') {
            $("#fabu").tips({
                side: 3,
                msg: '您还未认证！',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        return true;
    }

    var bheight = document.documentElement.clientHeight;
    var bwidth = document.documentElement.clientWidth;
    //弹框
    $('#modal').css('width', bwidth * .76 + 'px').css('height', bheight * .8 + 'px');
    $('.modal-body-h').css('height', bheight * .8 + 'px');
</script>
</body>
</html>
