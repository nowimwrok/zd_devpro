<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>
    <title>个人中心</title>
    <style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">
<div  style="background: #f5f5f5;">

    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
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
                                            <div class="col-sm-4 text-left"  style="padding-left: 0">
                                                <span class="form-control noborder-form-control strong_blue">43456667.00元</span>
                                            </div>
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">可用余额</div>
                                            <div class="col-sm-4 text-left" style="padding-left: 0">
                                                <span class="form-control noborder-form-control strong_blue">43456667.00元</span>
                                            </div>
                                            <div class="col-sm-12 text-center" style="margin-top:10px;">
                                                <div class="col-lg-2"></div>
                                                <button class="btn btn-primary btn-mini col-lg-3">转账</button>
                                                <div class="col-lg-2"></div>
                                                <button class="btn btn-success btn-mini col-lg-3">提现</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6" style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;padding-top:15px;line-height: 30px;">
                                        <p>1、为了保护你的账户余额安全，请认真阅读《卓大物流平台充值服务协议》，如需提现，请致电客服进行申请和审核。 </p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">交易记录</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-lg-12 search_wrap">
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择开始时间">
                                        </div>
                                        <div class="col-sm-2">
                                            <input class="form-control" placeholder="请选择结束时间">
                                        </div>
                                        <div class="col-sm-2">
                                            <select class="form-control">
                                                <option value="">——交易类型——</option>
                                                <option value="">保证金</option>
                                                <option value="">运单交易</option>
                                                <option value="">运费余额支出</option>
                                            </select>
                                        </div>
                                        <div class="col-sm-2 btn-search-wrap">
                                            <button class="btn btn-primary" style="width: 128px;"><i class="fa fa-search white"></i> 搜索</button>
                                        </div>
                                        <div class="col-sm-2">
                                            <button class="btn btn-success">
                                                <i class="fa fa-upload white"> </i>  导  &nbsp;出 &nbsp;</button>
                                        </div>
                                    </div>
                                    <table class="table" id="account_list">
                                        <thead>
                                        <tr>
                                            <th>交易类型</th>
                                            <th>交易金额</th>
                                            <th>流水号</th>
                                            <th>交易描述</th>
                                            <th>交易方式</th>
                                            <th>交易状态</th>
                                            <th>交易时间</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>保证金充值</td>
                                            <td><strong class="add_Symbol">+</strong>234.00元</td>
                                            <td>08012017051884030001</td>
                                            <td>运单号:YD2016092416000029 向昕晟车队支付余款运费:1000.0元</td>
                                            <td>账户余额</td>
                                            <td><span class="green">交易完成</span></td>
                                            <td>2016-10-21 09:51:53</td>
                                        </tr>
                                        <tr>
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
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="zhuobi_trans">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">卓币转账</h4>
                                </div>
                                <div class="panel-body clearfix">
                                    <div class="col-sm-6 form-horizontal form-group-tab">
                                        <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                            <input placeholder="输入用户名/手机号" class="form-control" value="" name="">
                                            <input class="input-group-addon input-group-search" type="button" value="搜索">
                                        </div>
                                        <div class="col-sm-4" style="line-height: 34px;">
                                            <a  style="width: 100%;">常用联系人</a>
                                        </div>
                                        <div class="clearfix" style="clear:both;">
                                            <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                                <input placeholder="输入转账金额" class="form-control" value="" name="" style="border-radius: 4px;">
                                                <input class="input-group-addon input-group-unit" type="button" value="元">
                                            </div>
                                            <div class="col-sm-4" style="line-height:34px;">
                                                234484.00元（可用）
                                            </div>
                                        </div>
                                        <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                            <input placeholder="输入支付密码" class="form-control" value="" name="" style="border-radius: 4px;">
                                            <input class="input-group-addon input-group-unit" type="button" value="元">
                                        </div>
                                        <div style="clear:both;width:40%;">
                                            <button class="btn btn-success btn-mini col-lg-8" style="width: 100%">确认转账</button>
                                        </div>

                                    </div>

                                    <div class="col-sm-6" style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;padding-top:0px;">
                                        <p><strong>请注意</strong></p>
                                        <p>1、向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理 </p>
                                        <p>2、客服电话：0310-3188756  服务时间：周一至周日9：00-17:30 </p>
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
                                    <div class="col-sm-6 form-horizontal form-group-tab">
                                        <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                            <input placeholder="输入用户名/手机号" class="form-control" value="" name="">
                                            <input class="input-group-addon input-group-search" type="button" value="搜索">
                                        </div>
                                        <div class="col-sm-4" style="line-height: 34px;">
                                            <a  style="width: 100%;">常用联系人</a>
                                        </div>
                                        <div class="clearfix" style="clear:both;">
                                            <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                                <input placeholder="输入转账金额" class="form-control" value="" name="" style="border-radius: 4px;">
                                                <input class="input-group-addon input-group-unit" type="button" value="元">
                                            </div>
                                            <div class="col-sm-4" style="line-height:34px;">
                                                234484.00元（可用）
                                            </div>
                                        </div>
                                        <div class="col-sm-8 text-left input-group" style="padding-left: 0;position: relative;float: left;">
                                            <input placeholder="输入支付密码" class="form-control" value="" name="" style="border-radius: 4px;">
                                            <input class="input-group-addon input-group-unit" type="button" value="元">
                                        </div>
                                        <div style="clear:both;width:40%;">
                                            <button class="btn btn-success btn-mini col-lg-8" style="width: 100%">确认转账</button>
                                        </div>

                                    </div>

                                    <div class="col-sm-6" style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                        <p><strong>请注意</strong></p>
                                        <p>1、向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理 </p>
                                        <p>2、客服电话：0310-3188756  服务时间：周一至周日9：00-17:30 </p>
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
                            <div class="col-sm-6 form-horizontal form-group-tab">
                                <div class="col-sm-12 text-left form-group" style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                    <div class="col-sm-4 control-label" style="padding-right: 0;">当前账户余额</div>
                                    <div class="col-sm-8"><input class="form-control" value="5677667元" readonly></div>
                                </div>
                                <div class="col-sm-12 text-left form-group" style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                    <div class="col-sm-4 control-label" style="padding-right: 0;">当前保证金</div>
                                    <div class="col-sm-8"><input class="form-control" value="5677667元" readonly></div>
                                </div>
                                <div class="col-sm-12 text-left form-group" style="padding-left: 0;margin-bottom: 5px;padding-bottom: 5px;">
                                    <div class="col-sm-4 control-label" style="padding-right: 0;">充值保证金</div>
                                    <div class="col-sm-8"><input class="form-control" value="" placeholder="输入支付保证金金额"></div>
                                </div>
                                <div class="col-sm-12 text-left form-group" style="padding-left: 0;margin-bottom: 15px;padding-bottom: 5px;">
                                    <div class="col-sm-4 control-label" style="padding-right: 0;">支付密码</div>
                                    <div class="col-sm-8"><input class="form-control" value="" placeholder="请输入支付密码"></div>
                                </div>
                                <div style="clear:both;width:40%;" class="col-sm-12">
                                    <button class="btn btn-success btn-mini col-lg-8" style="width: 100%">确认转账</button>
                                </div>

                            </div>

                            <div class="col-sm-6" style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                <p><strong>请注意</strong></p>
                                <p>1、仅支持余额充值，在线支付成功后。充值金额会在一分钟内到账；如有疑问，请致电卓大物流客服办理 </p>
                                <p>2、客服电话：0310-3188756  服务时间：周一至周日9：00-17:30 </p>
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
<script>
    $('#account_list').bootstrapTable({
        pagination:true,//设置为 true 会在表格底部显示分页条
        pagesize:5
    })
</script>
</body>
</html>
