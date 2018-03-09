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

    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" class="has-js">

    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">余额提现</h4>
                </div>
                <div class="panel-body clearfix">
                    <form id="input_form">
                        <div class="col-sm-6 form-horizontal form-group-tab">
                            <div class="col-sm-8 text-left input-group"
                                 style="padding-left: 0;position: relative;float: left;">
                                <c:choose>
                                    <c:when test="${not empty userBankList}">
                                        <select class="show-tick form-control" name="bankid" id="bankid">
                                            <c:forEach items="${userBankList}" var="dr" varStatus="i">
                                                <option value="${dr.id}">
                                                        ${dr.bankcard}&nbsp;${dr.banktype}
                                                </option>
                                            </c:forEach>

                                        </select>
                                    </c:when>
                                    <c:otherwise><input id="bankid" value="" type="hidden"/>
                                        您没有绑定银行卡，不可提现！
                                    </c:otherwise>
                                </c:choose>
                                <%--<input placeholder="输入用户名/手机号" class="form-control" value=""
                                       id="balance_user" name="balance_user">
                                <input class="input-group-addon input-group-search" type="button"
                                       id="balance_search_user" onclick="search('balance')" value="查询">--%>
                            </div>
                            <div class="clearfix user_box" id="balance_user_box"
                                 style="clear:both;display: none;">
                                <div class="col-sm-6">
                                    <div class="col-sm-5 control-label pr-0 text-right">用户名：</div>
                                    <div class="form-control noborder-form-control pl-0"
                                         id="balance_loginName">张山
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="col-sm-5 control-label pr-0 text-right">姓名：</div>
                                    <div class="form-control noborder-form-control pl-0" id="balance_name">张山
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="col-sm-5 control-label text-right pr-0">状态：</div>
                                    <div class="form-control noborder-form-control pl-0" id="balance_status">
                                        已认证
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="col-sm-5 control-label text-right pr-0">手机号：</div>
                                    <div class="form-control noborder-form-control pl-0" id="balance_phone">
                                        13560021736
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix" style="clear:both;">
                                <div class="col-sm-8 text-left input-group"
                                     style="padding-left: 0;position: relative;float: left;">
                                    <input placeholder="输入提现金额" class="form-control" value=""
                                           id="balance_money" name="balance_money" style="border-radius: 4px;">
                                    <input class="input-group-addon input-group-unit" type="button"
                                           value="元">
                                </div>
                                <div class="col-sm-4"
                                     style="line-height:34px;line-height:34px;font-size: 12px;color: red;">
                                    <span id="available"><fmt:formatNumber
                                            value="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}"
                                            pattern="#.##" minFractionDigits="2"></fmt:formatNumber></span>元（可用）
                                </div>
                            </div>
                            <div class="col-sm-8 text-left input-group"
                                 style="padding-left: 0;position: relative;float: left;">
                                <input placeholder="输入支付密码" class="form-control" type="password" name="balance_pwd"
                                       id="balance_pwd"
                                       style="border-radius: 4px;">
                            </div>
                            <c:if test="${user.memberId!=null&&user.memberId!=''}">
                                <div class="col-sm-8 text-left input-group"
                                     style="padding-left: 0;position: relative;float: left;">
                                    <div class="checkboxes">
                                        <label id="cklabel" for="isAccount">
                                            <input type="checkbox" id="isAccount"
                                                   name="isAccount" value="1"/>银行卡账户
                                        </label>
                                    </div>

                                </div>
                            </c:if>
                            <div style="clear:both;width:40%;">
                                <button id="balance_submit" onclick="trans_Submit('balance')"
                                        class="btn btn-success btn-mini col-lg-8" style="width: 100%">确认提现
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


    </div>
</div>

<script type="text/javascript"
        src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script
        src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script
        src="/static/front/js/form-comment.js"></script>
<script>
    $(function () {
        $('#input_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                balance_money: {
                    message: '提现金额无效',
                    validators: {
                        notEmpty: {
                            message: '提现金额不能为空'
                        }, decimalTwo: {
                            message: '提现金额必须是小数或者整数'
                        }, between: {
                            min: 0.01,
                            max: '${user.userPurse.availablebalance}' * 1,
                            message: "提现金额必须大于0小于" + new Number(${user.userPurse.availablebalance})
                        }
                    }
                },
                balance_pwd: {
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
                        }, post_valid: {
                            url: '/a/wlpt/user/validateCashPwd?isSave=false',
                            name: "cashPwd",
                            delay: 2000,
                            message: '支付密码有误或未设置'
                        }
                    }
                }
            }

        });
        var flag;
        var targetstatus = 0;
        var availbalance = 0;
        var consumeway = 0;
        var rememberId = null;
        var reuserenname = '';
        var avail = "${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
        var amount = 0.00;
        avail=new Number(avail);
        availbalance = avail;
        var memberId = "${user.memberId}";
        if (memberId != null && memberId != "") {
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

                                amount = slaveAccounts[i].availableBalance;
                            }
                        }

                    }
                }
            });
        }

        $("#isAccount").click(function () {
            var isAccount = $("input[name='isAccount']:checked").val();
            /* alert(isAccount + "===" + amount); */
            //var isched = $("#cklabel").hasClass("c_off");
            if (isAccount * 1 == 1) {
                availbalance = amount;
                $("#available").html(amount);
                $("#balance_money").attr("max", amount);
                consumeway = "10";
            } else {
                availbalance = avail;
                $("#available").html(avail);
                $("#balance_money").attr("max", avail);
                consumeway = "0";
            }
        });

        window.trans_Submit = function (boxval) {

            $("#" + boxval + "_submit").attr("disabled", true);
            var status = '${user.userinfo.status}';
            if (status == null || status == '' || status == undefined || status != '2') {
                $.MsgBox.Alert("系统提示", '请先完成资质认证');
                $("#" + boxval + "_submit").attr("disabled", false);
                return false;

            }
            if ($("#bankid").val() == null || $("#bankid").val() == "") {
                $.MsgBox.Alert("系统提示", '请先绑定银行卡！');
                return false;
            }
            var bootstrapValidator = $("#input_form").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                var num = $("#" + boxval + "_money").val();
                var total = 0;
                var posturl = "${wlpt}/wlpt/consume/accountCash";
                total = availbalance;
                if (num * 1 > total * 1 || num * 1 <= 0) {
                    $.MsgBox.Alert("系统提示", '填写金额必须大于0并且小于可用金额！');
                    $("#" + boxval + "_submit").attr("disabled", false);
                    return false;
                }
                $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
                    $("#maskloading", parent.document).show();
                    $.ajax({
                        url: posturl,
                        dataType: 'json',
                        data: {
                            "bankid": $("#bankid").val(),
                            "passWord": $("#" + boxval + "_pwd").val(),
                            "cashMoney": num, "payway": consumeway
                        },
                        type: "post",
                        success: function (data) {
                            $("#maskloading", parent.document).hide();
                            $("#" + boxval + "_submit").attr("disabled", false);
                            if (data.state == 1) {
                                $.MsgBox.Alert("操作提示", "提现成功");
                                window.location.href = '${wlpt}/wlpt/consume/toPurse';
                            } else {
                                $.MsgBox.Alert("操作提示", data.message);
                                $("#maskloading", parent.document).hide();
                            }
                        }
                    });
                });
            } else {
                $("#" + boxval + "_submit").attr("disabled", false);
            }
        };
    });


</script>
</body>
</html>
