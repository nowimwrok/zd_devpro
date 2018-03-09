<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>财务中心</title>
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

        .form-group-tab > div {
            margin-bottom: 0px;
        }
    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="dataHall"
     ng-controller="dataHallCtrl">

    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel" style="border:0;">
                <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
                    <ul class="nav nav-tabs tab-nav-tabs">
                        <li class="active"><a href="#account_balance" data-toggle="tab">账户余额</a></li>
                        <li><a href="#zhuobi_trans" data-toggle="tab">卓币转账</a></li>
                        <li><a href="#gas_trans" data-toggle="tab">油气转账</a></li>
                        <li><a href="#bond_recharge" data-toggle="tab">保证金充值</a></li>
                    </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="account_balance">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">账户余额</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-6 form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">账户余额</div>
                                            <div class="col-sm-4 text-left" style="padding-left: 0">
                                                <span class="form-control noborder-form-control strong_blue"><fmt:formatNumber
                                                        value="${not empty user.userPurse.webbalance ? user.userPurse.webbalance:'0.00'}"
                                                        pattern="#.##" minFractionDigits="2"></fmt:formatNumber>元</span>
                                            </div>
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">可用余额</div>
                                            <div class="col-sm-4 text-left" style="padding-left: 0;">
                                                <span class="form-control noborder-form-control strong_blue"><fmt:formatNumber
                                                        value="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}"
                                                        pattern="#.##" minFractionDigits="2"></fmt:formatNumber>元</span>
                                            </div>
                                            <div class="col-sm-12 text-center" style="margin-top:10px;">
                                                <div class="col-lg-2"></div>
                                                <button class="btn btn-primary btn-mini col-lg-3" id="btn_transfer">转账
                                                </button>
                                                <div class="col-lg-2"></div>
                                                <button class="btn btn-success btn-mini col-lg-3" id="btn_cash">提现
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;padding-top:15px;line-height: 30px;">
                                        <p>1、为了保护你的账户余额安全，请认真阅读<a target="_blank"
                                                                  onclick="openagreement('prepaidAgreement');"
                                                                  style="line-height: 30px;text-decoration: none;">《卓大物流平台充值服务协议》</a>，如需提现，请致电客服进行申请和审核。
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">交易记录</h4>
                                </div>
                                <div class="panel-body">

                                    <div class="col-lg-12 search_wrap">
                                        <form:form id="searchForm" modelAttribute="consumerecod"
                                                   action="${wlpt}/wlpt/consume/export" method="post"
                                        >
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择开始时间" name="beginCreateDate"
                                                   id="beginCreateDate"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                        </div>
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择结束时间" name="endCreateDate"
                                                   id="endCreateDate"
                                                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                                        </div>
                                        <div class="col-sm-2">
                                            <select class="form-control" id="trademodel" ng-model="trademodel"
                                                    name="trademodel">
                                                <option value="">--交易模块--</option>
                                                <option value="0">充值</option>
                                                <option value="1">运单交易</option>
                                                <option value="2">结算账户</option>
                                                <option value="3">竞标</option>
                                                <option value="4">提现</option>
                                                <option value="5">转账</option>
                                                <option value="6">卓币</option>
                                                <option value="7">油气</option>
                                                <option value="8">保证金</option>
                                                <option value="9">保险</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-4 text-left">
                                            <button class="btn btn-primary" type="button" ng-click="searchInfo(1)"
                                            ><i
                                                    class="fa fa-search white"></i> 查询
                                            </button>
                                            <button class="btn btn-success">
                                                <i class="fa fa-upload white"> </i> 导 出
                                            </button>
                                        </div>
                                    </div>
                                    <div style="overflow: auto;width: 100%;">
                                        <table class="table" id="account_list">
                                            <thead>
                                            <tr>
                                                <th>流水号</th>
                                                <th>交易类型</th>
                                                <th>交易金额</th>
                                                <th>交易描述</th>
                                                <th>交易方式</th>
                                                <th>交易状态</th>
                                                <th>交易时间</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr ng-repeat="x in data">
                                                <td ng-cloak>{{x.consumecode}}</td>
                                                <td ng-cloak>{{x.consumetype}}</td>
                                                <td ng-cloak>
                                                    <strong class="add_Symbol" ng-if="x.aftermony-x.beforemony<0"
                                                            style="color: red; font-weight: bold;">-</strong> <strong
                                                        ng-if="x.aftermony-x.beforemony>0"
                                                        style="color: green; font-weight: bold;">+</strong>
                                                    {{x.consumemony}}元
                                                </td>

                                                <td ng-cloak>{{x.consumewaydesp}}</td>
                                                <td ng-cloak>{{x.consumeway}}</td>
                                                <td><span class="green" ng-cloak>{{x.consumestatus}}</span></td>
                                                <td ng-cloak>{{x.createDate}}</td>
                                            </tr>
                                                <%-- <tr>
                                                     <td>运费余额支出</td>
                                                     <td><strong class="reduce_symbol">-</strong>234.00元</td>
                                                     <td>08012017051884030001</td>
                                                     <td>运单号:YD2016092416000029 向昕晟车队支付余款运费:1000.0元</td>
                                                     <td>账户余额</td>
                                                     <td><span class="orange">冻结中</span></td>
                                                     <td>2016-10-21 09:51:53</td>
                                                 </tr>
                                                 <tr>
                                                     <td>保证金充值</td>
                                                     <td><strong class="reduce_symbol">-</strong>234.00元</td>
                                                     <td>08012017051884030001</td>
                                                     <td>运单号:YD2016092416000029 向昕晟车队支付余款运费:1000.0元</td>
                                                     <td>账户余额</td>
                                                     <td><span class="red">交易失败</span></td>
                                                     <td>2016-10-21 09:51:53</td>
                                                 </tr>--%>
                                            </tbody>
                                        </table>
                                    </div>
                                    </form:form>
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
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="zhuobi_trans">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">卓币转账</h4>
                                </div>
                                <div class="panel-body clearfix">
                                    <form id="coin_form">
                                        <div class="col-sm-6 form-horizontal form-group-tab">
                                            <div class="col-sm-8 text-left form-group input-group"
                                                 style="padding-left: 0;position: relative;float: left;">
                                                <input type="hidden" class="form-control" id="coin_login_user"
                                                       value="${user.phone}">
                                                <input placeholder="输入用户名/手机号" class="form-control" value=""
                                                       id="coin_user" name="coin_user">
                                                <input class="input-group-addon input-group-search" type="button"
                                                       id="coin_search_user" onclick="search('coin')" value="查询">
                                            </div>
                                            <%--<div class="col-sm-4" style="line-height: 34px;">
                                                <a style="width: 100%;" data-toggle="modal"
                                  					 data-target="#myModal" onclick="setsearchname('coin');">常用联系人</a>
                                            </div>--%>
                                            <div class="clearfix user_box" id="coin_user_box"
                                                 style="clear:both;display: none;margin-bottom: 5px;margin-left: -15px;">
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label pr-0 text-right">用户名：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="coin_loginName">张山
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label pr-0 text-right">姓名：</div>
                                                    <div class="form-control noborder-form-control pl-0" id="coin_name">
                                                        张山
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label text-right pr-0">状态：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="coin_status">
                                                        已认证
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label text-right pr-0">手机号：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="coin_phone">
                                                        13560021736
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix" style="clear:both;">
                                                <div class="col-sm-8 text-left form-group input-group"
                                                     style="padding-left: 0;position: relative;float: left;">
                                                    <input placeholder="输入转账金额" class="form-control" value=""
                                                           id="coin_money" name="coin_money" min="0.01"
                                                           max="${user.userPurse.webcoin}"
                                                           style="border-radius: 4px;">
                                                    <input class="input-group-addon input-group-unit" type="button"
                                                           value="元">
                                                </div>
                                                <div class="col-sm-4"
                                                     style="line-height:34px;line-height:34px;font-size: 12px;color: red;">
                                                    ${not empty user.userPurse.webcoin ? user.userPurse.webcoin:'0.00'}元（可用）
                                                </div>
                                            </div>
                                            <div class="col-sm-8 text-left form-group input-group"
                                                 style="padding-left: 0;position: relative;float: left;">
                                                <input placeholder="输入支付密码" class="form-control" type="password"
                                                       name="coin_pwd"
                                                       id="coin_pwd"
                                                       style="border-radius: 4px;">
                                            </div>
                                            <div class="col-sm-8 text-left form-group input-group" id="coin_submit"
                                                 onclick="trans_Submit('coin')">
                                                <button
                                                        class="btn btn-success btn-mini" style="width: 100%">
                                                    确认转账
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;padding-top:0px;">
                                        <p><strong>请注意</strong></p>
                                        <p>1、向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理 </p>
                                        <p>2、客服电话：0310-3188756 服务时间：周一至周日9：00-17:30 </p>
                                        <p><strong>温馨提示</strong></p>
                                        <p>1、转账支付金额确认支付后不可修改，请熟知</p>
                                        <p>2、转账完成后，在充值中心可以查看转账操作记录</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="gas_trans">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">油气转账</h4>
                                </div>
                                <div class="panel-body clearfix">
                                    <form id="petrol_form">
                                        <div class="col-sm-6 form-horizontal form-group-tab">
                                            <div class="col-sm-8 text-left form-group input-group"
                                                 style="padding-left: 0;position: relative;float: left;">
                                                <input type="hidden" id="petrol_login_user" value="${user.phone}">
                                                <input placeholder="输入用户名/手机号" id="petrol_user" class="form-control"
                                                       value="" name="petrol_user">
                                                <input class="input-group-addon input-group-search"
                                                       onclick="search('petrol')" id="petrol_search_user" type="button"
                                                       value="查询">
                                            </div>
                                            <%--<div class="col-sm-4" style="line-height: 34px;">
                                                <a style="width: 100%;" data-toggle="modal" 
                                   					data-target="#myModal" onclick="setsearchname('petrol');">常用联系人</a>
                                            </div>--%>
                                            <div class="clearfix user_box" id="petrol_user_box"
                                                 style="clear:both;display: none;margin-bottom: 10px;margin-left: -15px;">
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label pr-0 text-right">用户名：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="petrol_loginName">张山
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label pr-0 text-right">姓名：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="petrol_name">
                                                        张山
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label text-right pr-0">状态：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="petrol_status">
                                                        已认证
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="col-sm-5 control-label text-right pr-0">手机号：</div>
                                                    <div class="form-control noborder-form-control pl-0"
                                                         id="petrol_phone">
                                                        13560021736
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="clearfix" style="clear:both;">
                                                <div class="col-sm-8 text-left form-group input-group"
                                                     style="padding-left: 0;position: relative;float: left;">
                                                    <input placeholder="输入转账金额" class="form-control" id="petrol_money"
                                                           value="" name="petrol_money" min="0.01"
                                                           max="${user.userPurse.petrolbalance}"
                                                           style="border-radius: 4px;">
                                                </div>
                                                <div class="col-sm-4"
                                                     style="line-height:34px;line-height:34px;font-size: 12px;color: red;">
                                                    ${not empty user.userPurse.petrolbalance ? user.userPurse.petrolbalance:'0.00'}元（可用）
                                                </div>
                                            </div>
                                            <div class="col-sm-8 text-left form-group input-group"
                                                 style="padding-left: 0;position: relative;float: left;">
                                                <input placeholder="输入支付密码" id="petrol_pwd" type="password"
                                                       class="form-control" value="" name="petrol_pwd"
                                                       style="border-radius: 4px;">
                                            </div>
                                            <div class="col-sm-8 text-left form-group input-group">
                                                <button class="btn btn-success btn-mini" id="petrol_submit"
                                                        onclick="trans_Submit('petrol')" style="width: 100%">确认转账
                                                </button>
                                            </div>

                                        </div>
                                    </form>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                        <p><strong>请注意</strong></p>
                                        <p>1、向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理 </p>
                                        <p>2、客服电话：0310-3188756 服务时间：周一至周日9：00-17:30 </p>
                                        <p><strong>温馨提示</strong></p>
                                        <p>1、转账支付金额确认支付后不可修改，请熟知</p>
                                        <p>2、转账完成后，在充值中心可以查看转账操作记录</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="bond_recharge">
                            <div class="form_container">
                                <h4 class="panel-heading ">保证金充值</h4>
                            </div>
                            <form id="guean_form">
                                <div class="col-sm-6 form-horizontal form-group-tab">
                                    <div class="col-sm-12 text-left form-group"
                                         style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                        <div class="col-sm-4 control-label" style="padding-right: 0;">当前账户余额</div>
                                        <div class="col-sm-8"><input class="form-control"
                                                                     value="<fmt:formatNumber
                                                        value="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}"
                                                        pattern="#.##" minFractionDigits="2"></fmt:formatNumber>元"
                                                                     readonly></div>
                                    </div>
                                    <div class="col-sm-12 text-left form-group"
                                         style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                        <div class="col-sm-4 control-label" style="padding-right: 0;">当前保证金</div>
                                        <div class="col-sm-8"><input class="form-control"
                                                                     value="${not empty user.userPurse.guaranteemone ? user.userPurse.guaranteemone:'0.00'}元"
                                                                     readonly></div>
                                    </div>
                                    <div class="col-sm-12 text-left form-group"
                                         style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                        <div class="col-sm-4 control-label" style="padding-right: 0;">充值保证金</div>
                                        <div class="col-sm-8"><input class="form-control" id="guean_money"
                                                                     name="guean_money" min="0.01"
                                                                     max="${user.userPurse.availablebalance}" value=""
                                                                     placeholder="输入支付保证金金额">
                                        </div>
                                    </div>
                                    <div class="col-sm-12 text-left form-group"
                                         style="padding-left: 0;margin-bottom: 15px;padding-bottom: 5px;">
                                        <div class="col-sm-4 control-label" style="padding-right: 0;">支付密码</div>
                                        <div class="col-sm-8"><input class="form-control" id="guean_pwd"
                                                                     name="guean_pwd" type="password"
                                                                     value="guean_pwd" placeholder="请输入支付密码">
                                        </div>
                                    </div>
                                    <div class="col-sm-12 text-left form-group"
                                         style="padding-left: 0;margin-bottom: 15px;padding-bottom: 5px;">
                                        <div class="col-sm-4 control-label" style="padding-right: 0;"></div>
                                        <div class="col-sm-8">
                                            <button class="btn btn-success btn-mini" id="guean_sumit"
                                                    onclick="trans_Submit('guean')" style="width: 100%">确认充值
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <div class="col-sm-6" style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                <p><strong>请注意</strong></p>
                                <p>1、仅支持余额充值，在线支付成功后。充值金额会在一分钟内到账；如有疑问，请致电卓大物流客服办理 </p>
                                <p>2、客服电话：0310-3188756 服务时间：周一至周日9：00-17:30 </p>
                                <p><strong>温馨提示</strong></p>
                                <p>1、保证金充值金额 确认支付后不可修改，请悉知</p>
                                <p>2、转账完成后，在充值中心可以查看转账操作记录</p>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </div>


    </div>
</div>
<%-- <%@ include file="/WEB-INF/views/modules/user_front/contacts/contacts_info.jsp" %> --%>
<script
        src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script>
    $("#maskloading", parent.document).show();
    $(function () {

        $('#coin_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                coin_user: {
                    message: '查询信息无效',
                    validators: {
                        notEmpty: {
                            message: '转账用户信息不能为空'
                        }, different: {
                            fieldval: $('#coin_login_user').val(),
                            message: '不能给自己转账'
                        }
                    }
                },
                coin_money: {
                    message: '转账金额无效',
                    validators: {
                        notEmpty: {
                            message: '转账金额不能为空'
                        }, decimalTwo: {
                            message: '转账金额必须是小数或者整数'
                        }, between: {
                            min: 1,
                            max: '${user.userPurse.webcoin}' * 1,
                            message: "转账金额必须大于0小于${user.userPurse.webcoin}"
                        }
                    }
                },
                coin_pwd: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }/*, post_valid: {
                         url: '/a/wlpt/user/validateCashPwd?isSave=false',
                         name: "cashPwd",
                         delay :  2000,
                         message: '支付密码有误或未设置'
                         }*/
                    }
                }
            }

        });
        $('#petrol_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                petrol_user: {
                    message: '查询信息无效',
                    validators: {
                        notEmpty: {
                            message: '转账用户信息不能为空'
                        },
                        different: {
                            fieldval: $('#petrol_login_user').val(),
                            message: '不能给自己转账'
                        }
                    }
                },
                petrol_money: {
                    message: '转账金额无效',
                    validators: {
                        notEmpty: {
                            message: '转账金额不能为空'
                        }, decimalTwo: {
                            message: '转账金额必须是小数或者整数'
                        }, between: {
                            min: 1,
                            max: '${user.userPurse.petrolbalance}' * 1,
                            message: "转账金额必须大于0小于${user.userPurse.petrolbalance}"
                        }
                    }
                },
                petrol_pwd: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }/*, post_valid: {
                         url: '/a/wlpt/user/validateCashPwd?isSave=false',
                         name: "cashPwd",
                         delay :  2000,
                         message: '支付密码有误或未设置'
                         }*/
                    }
                }
            }

        });
        $('#guean_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                guean_money: {
                    message: '充值金额无效',
                    validators: {
                        notEmpty: {
                            message: '充值金额不能为空'
                        }, decimalTwo: {
                            message: '充值金额必须是小数或者整数'
                        }, between: {
                            min: 1,
                            max: '${user.userPurse.availablebalance}' * 1,
                            message: "充值金额必须大于0小于${user.userPurse.availablebalance}"
                        }
                    }
                },
                guean_pwd: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }/*, post_valid: {
                         url: '/a/wlpt/user/validateCashPwd?isSave=false',
                         name: "cashPwd",
                         delay :  2000,
                         message: '支付密码有误或未设置'
                         }*/
                    }
                }
            }

        });
        var flag = "false";
        var targetstatus = 0;
        $("#coin_user").keyup(function () {
            var val = $(this).val();
            if (!val) {
                $("#coin_user_box").hide();
                flag = "false";
            }
        });
        $("#petrol_user").keyup(function () {
            var val = $(this).val();
            if (!val) {
                $("#petrol_user_box").hide();
                flag = "false";
            }
        });
        $("#btn_transfer").click(function () {
            window.location.href = '${wlpt}/wlpt/consume/toTransfer';
        });
        $("#btn_cash").click(function () {
            window.location.href = '${wlpt}/wlpt/consume/toCash';
        });

        $("#btnExport").click(function () {

            $("#searchForm").attr("action", "${wlpt}/wlpt/consume/export");

            top.$('.jbox-body .jbox-icon').css('top', '55px');
        });
        window.search = function (boxval) {

            var searchinfo = $("#" + boxval + "_user").val();
            if (!searchinfo) {
                $.MsgBox.Alert("系统提示", '请填写搜索用户信息');
                return;
            }
            $("#maskloading", parent.document).show();
            $.ajax({
                url: "${wlpt}/wlpt/personal/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    $("#maskloading", parent.document).hide();

                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $("#info").addClass("detail-row");
                            flag = "false";
                            $.MsgBox.Alert("系统提示", '搜索用户不存在');
                            $("#" + boxval + "_user_box").hide("2000");
                        } else {

                            flag = "true";
                            if (data.value.role.enname) {
                                reuserenname = data.value.role.enname;
                            }
                            if (data.value.user.loginName) {
                                $("#" + boxval + "_loginName").html(data.value.user.loginName);
                            }
                            if (data.value.user.name) {
                                $("#" + boxval + "_name").html(data.value.user.name);
                            }
                            if (data.value.user.phone) {
                                $("#" + boxval + "_phone").html(data.value.user.phone);
                                $("#" + boxval + "user").val(data.value.user.phone);
                            }

                            if (data.value.info.status) {
                                targetstatus = data.value.info.status;
                                if (data.value.info.status == '2') {
                                    $("#" + boxval + "_status").html('认证通过');
                                } else {
                                    $("#" + boxval + "_status").html('未通过');
                                }

                            }
                            $("#" + boxval + "_user_box").slideDown();
                        }
                    }
                }
            });
        };
        window.trans_Submit = function (boxval) {
            $("#" + boxval + "_submit").attr("disabled", true);
            var status = '${user.userinfo.status}';
            if (status == null || status == '' || status == undefined || status != '2') {
                $.MsgBox.Alert("系统提示", '请先完成资质认证');
                $("#" + boxval + "_submit").attr("disabled", false);
                return false;

            }
            if (boxval == "guean") {
                flag = true;
            }
            if (flag == "false") {
                $.MsgBox.Alert("系统提示", '请输入正确用户信息');
                $("#" + boxval + "_submit").attr("disabled", false);
                return false;
            }

            var phone = "${user.phone}";
            var name = "${user.name}";
            var search = $("#" + boxval + "_user").val();
            if (boxval != "guean") {
                if (search == phone || search == name) {
                    $.MsgBox.Alert("系统提示", '不能给自己转账');
                    $("#" + boxval + "_submit").attr("disabled", false);
                    return false;

                }
                if (targetstatus != '2') {
                    $.MsgBox.Alert("系统提示", '目标用户未完成资质认证');
                    $("#" + boxval + "_submit").attr("disabled", false);
                    return false;
                }
            }

            var num = $("#" + boxval + "_money").val();

            var total = 0;
            var posturl = "${wlpt}/wlpt/consume/transferCoin";
            if (boxval == "coin") {
                total = "${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}";
                posturl = "${wlpt}/wlpt/consume/transferCoin";
            } else if (boxval == "petrol") {
                total = "${not empty user.userPurse.petrolbalance ? user.userPurse.petrolbalance:'0.00'}";
                posturl = "${wlpt}/wlpt/consume/transferPetro";
            } else if (boxval == "guean") {
                total = "${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
                posturl = "${wlpt}/wlpt/consume/gueanRecharge";
            }

            if (num * 1 > total * 1 || num * 1 <= 0) {
                $.MsgBox.Alert("系统提示", '填写金额必须大于0并且小于可用金额');
                $("#" + boxval + "_submit").attr("disabled", false);
                return false;
            }

            var bootstrapValidator = $("#" + boxval + "_form").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
                    $("#maskloading", parent.document).show();
                    var isvid = false;
                    $.ajax({
                        url: "${ctx}/wlpt/user/validateCashPwd",
                        dataType: 'json',
                        data: {"cashPwd": $("#" + boxval + "_pwd").val(), "isSave": false},
                        async: false, ///同步请求传递
                        type: "post",
                        success: function (data) {
                            isvid = data;
                            if (data == false) {
                                $.MsgBox.Alert("系统提示", "支付密码错误或未设置支付密码");
                            }
                        }
                    })
                    if (isvid) {
                        $.ajax({
                            url: posturl,
                            dataType: 'json',
                            data: {"target.searchinfo": $("#" + boxval + "_user").val(), "consumemony": num},
                            type: "post",
                            success: function (data) {
                                $("#maskloading", parent.document).hide();
                                $("#" + boxval + "_submit").attr("disabled", false);
                                if (boxval == "petrol") {
                                    if (data.state == 1) {
                                        $.MsgBox.Alert("操作提示", "操作成功");
                                        window.location.href = '${wlpt}/wlpt/consume/toPurse';
                                    } else {
                                        $.MsgBox.Alert("温馨提示", data.message);
                                        $("#maskloading", parent.document).hide();
                                    }
                                } else {
                                    if (data.value == 1) {
                                        $.MsgBox.Alert("操作提示", "操作成功");
                                        window.location.href = '${wlpt}/wlpt/consume/toPurse';
                                    } else if (data.value == 5) {
                                        $.MsgBox.Alert("操作提示", "可用余款不足");
                                        $("#maskloading", parent.document).hide();
                                    } else if (data.value == 2) {
                                        $.MsgBox.Alert("操作提示", "用户不存在");
                                        $("#maskloading", parent.document).hide();
                                    }
                                    else {
                                        $.MsgBox.Alert("温馨提示", "操作失败");
                                        $("#maskloading", parent.document).hide();
                                    }
                                }
                            }
                        });
                    }
                });


            } else {
                $("#" + boxval + "_submit").attr("disabled", false);
            }
        };
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
                $(".no-items").html('');
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".no-items").html('');
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'beginCreateDate': $("#beginCreateDate").val(),
                'endCreateDate': $("#endCreateDate").val(),
                'trademodel': $("#trademodel").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/consume/getRecodeList',
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
        $scope.exportExcel = function () {
            $http({
                url: '${wlpt}/wlpt/consume/export',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {

            });
        };
    }]);


</script>
</body>
</html>
