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
<div >


    <div class="row">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        基本信息
                    </h4>
                    <div class="col-sm-12 form-horizontal goods_details">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">货物信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    出口卷<span class="vertical-line">|</span>货运量:25.9250吨<span class="vertical-line">|</span>剩余:25.9250吨
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">司机信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    李志波  15511010541
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">发货信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    河北省邯郸市复兴区 <span class="vertical-line">|</span>李志波 17717768555<span class="vertical-line">|</span>益鑫运输队
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">收货信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    天津市天津市塘沽区<span class="vertical-line">|</span>杨经理<span class="vertical-line">|</span>18222642717
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">报价车辆</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    冀DP9422 <span class="vertical-line">|</span>栏板式 <span class="vertical-line">|</span>13.00米 <span class="vertical-line">|</span>85.00吨
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">报价金额</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    78.90元
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">报价吨位</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">35.00吨</div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">总运费</div>
                            <div class="col-sm-9 text-left">
                                <div class="form-control noborder-form-control">56677.00元</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4 class="modal-title">货物信息</h4>
                    </div>
                    <div class="modal-body form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-2 control-label text-left">货物吨位</div>
                            <div class="col-sm-9 text-left">
                                <input class="form-control"  value="2903874748.00吨" readonly>
                            </div>
                        </div>
                        <div style="overflow-x:auto;">
                            <table class="table table-hover" id="dialog_table" data-click-to-select="true" checkbox="true">
                                <thead>
                                <tr>
                                    <th><label><input class="" type="checkbox"></label></th>
                                    <th>提货单号</th>
                                    <th>品名材质</th>
                                    <th>规格</th>
                                    <th>定尺/板宽</th>
                                    <th>数量/吨</th>
                                    <th>批次号</th>
                                    <th>卸货地址</th>
                                    <th>备注</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td><label><input class="" type="checkbox"></label></td>
                                    <td>31932.0</td>
                                    <td>CSB</td>
                                    <td>1.5</td>
                                    <td>1000.00</td>
                                    <td>10.8200</td>
                                    <td>LE1601182702</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td><label><input class="" type="checkbox"></label></td>
                                    <td>31932.0</td>
                                    <td>CSB</td>
                                    <td>1.5</td>
                                    <td>1000.00</td>
                                    <td>10.8200</td>
                                    <td>LE1601182702</td>
                                    <td></td>
                                    <td></td>
                                </tr>

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>



    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        支付信息
                    </h4>
                    <div class="col-sm-12 form-horizontal goods_details">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">重新配载</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios">
                                    <label class="label_radio" for="radio-01" data-toggle="modal" data-target="#modal">
                                        <input name="sample-radio1" id="radio-01" value="1" type="radio" checked="">是
                                    </label>
                                    <label class="label_radio" for="radio-02">
                                        <input name="sample-radio1" id="radio-02" value="1" type="radio"> 否
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">是否线上支付</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios" id="online-pay">
                                    <label class="label_radio" for="radio-03" style="width: 35%;">
                                        <input name="sample-radio2" id="radio-03" value="1" type="radio" checked="">线上支付
                                    </label>
                                    <label class="label_radio" for="radio-04"  style="width: 35%;">
                                        <input name="sample-radio2" id="radio-04" value="1" type="radio"> 线下支付
                                    </label>
                                </div>
                            </div>
                        </div>


                        <!--折叠内容-->
                        <div class="clearfix pay_hide_box">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">支付方式</div>
                                <div class="col-sm-9 text-left">
                                    <div class="radios">
                                        <label class="label_radio" for="radio-05" style="width:30%;">
                                            <input name="sample-radio3" id="radio-05" value="1" type="radio" checked="">余额支付
                                        </label>
                                        <label class="label_radio" for="radio-06"  style="width:35%;">
                                            <input name="sample-radio3" id="radio-06" value="1" type="radio"> 卓币支付
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-sm-3 control-label text-left">线上支付金额</div>
                                <div class="col-sm-9 text-left">
                                    <input class="form-control"  style="border:none;border-bottom:1px solid #ddd;outline: none;border-radius:none;" placeholder="输入支付金额">
                                    <i class="unit">元</i>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">线下支付金额</div>
                                <div class="col-sm-9 text-left has-unit">
                                    <input class="form-control noborder-form-control" readonly value="56787.0元">
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">是否预支付</div>
                                <div class="col-sm-9 text-left">
                                    <div class="radios" id="pay_pre">
                                        <label class="label_radio" for="radio-07">
                                            <input name="sample-radio4" id="radio-07" value="1" type="radio" checked="">是
                                        </label>
                                        <label class="label_radio" for="radio-08">
                                            <input name="sample-radio4" id="radio-08" value="1" type="radio"> 否
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix payPre_hide_box">
                                <div class="form-group col-sm-12">
                                    <div class="col-sm-1 control-label text-left" style="width:12.2%;">预支付比例</div>
                                    <div class="col-sm-9 text-left">
                                        <div class="radios">
                                            <label class="label_radio" for="radio-09" style="width:10%;">
                                                <input name="sample-radio5" id="radio-09" value="1" type="radio">10%
                                            </label>
                                            <label class="label_radio" for="radio-10"  style="width:10%;">
                                                <input name="sample-radio5" id="radio-10" value="1" type="radio">20%
                                            </label>
                                            <label class="label_radio" for="radio-11"  style="width:10%;">
                                                <input name="sample-radio5" id="radio-11" value="1" type="radio">50%
                                            </label>
                                            <label class="label_radio" for="radio-12"  style="width:10%;">
                                                <input name="sample-radio5" id="radio-12" value="1" type="radio">100%
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">线上预支付金额</div>
                                    <div class="col-sm-9 text-left">
                                        <input class="form-control noborder-form-control" value="678元">
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">线上支付余款</div>
                                    <div class="col-sm-9 text-left">
                                        <input class="form-control noborder-form-control" value="678元">
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">支付密码</div>
                                    <div class="col-sm-9 text-left">
                                        <input class="form-control noborder-form-control"   style="border-bottom:1px solid #ddd;outline: none;"  value="" placeholder="支付密码">
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group" style="margin-bottom: 40px;">
                <div class="col-sm-3 control-label text-left"></div>
                <div class="col-sm-9 text-left">
                    <button type="button" class="btn btn-primary col-sm-4">提交</button>
                </div>
            </div>
        </div>
    </div>


</div>
<script>
    $('#dialog_table').bootstrapTable({
        clickToSelect: true
    });
    //    $('#basic2').selectpicker({
    //        liveSearch: true,
    //        maxOptions: 1
    //    });

    $("#online-pay label").click(function () {
        var labelIndex=$(this).index();
//        alert(labelIndex);
        if(labelIndex==0){
            $('.pay_hide_box').css("display","block");
        }
        else {
            $('.pay_hide_box').css("display","none");
        }
    })
    $("#pay_pre label").click(function () {
        var labelIndex=$(this).index();
        if(labelIndex==0){
            $('.payPre_hide_box').css("display","block");
        }
        else {
            $('.payPre_hide_box').css("display","none");
        }
    })
</script>
</body>
</html>
