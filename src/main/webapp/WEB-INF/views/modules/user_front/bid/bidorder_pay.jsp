<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运单结算</title>
    <style type="text/css">
        .loadings {
            text-align: center;
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

</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;">
    <!--两列-->
    <div class="row edit-box has-js">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">运费信息</h4>
                </div>

                <div class="panel-body">
                    <div class="col-sm-8 form-horizontal">
                        <table class="table table-bordered table-border-bot">
                            <tbody>
                            <tr>
                                <td colspan="4"
                                    class="text-center">招标文号：<strong
                                        class="orange">${bidOrderinfo.bidinfo.bidcode}</strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-right">总运费：</td>
                                <td class="text-left">${bidOrderinfo.contracttotal}元</td>
                                <td class="text-right">待付：</td>
                                <td class="text-left"><span class="red">${bidOrderinfo.contracttotal}</span>元</td>
                            </tr>
                            <tr>
                                <td class="text-right">运输方：</td>
                                <td class="text-left">${bidOrderinfo.biddinguser.loginName}</td>
                                <td class="text-right">竞标价：</td>
                                <td class="text-left">${bidOrderinfo.biddinginfo.biddingprice}</td>
                            </tr>
                            </tbody>
                        </table>
                        <!--</div>-->

                    </div>
                    <div class="col-sm-4"
                         style="border-left: 1px solid #eff2f7;width: 27%;margin-left: 3%;padding-left:3%;padding-top:45px;padding-bottom:50px;">
                        <p><strong>温馨提示：</strong></p>
                        <p>确认支付，即可完成合同结算。</p>
                        <p>请您尽快完成支付 </p>
                    </div>
                </div>


                <%-- <div id="loading_lock" class="loading_lock" style="display: none;text-align: center;">
                    <img src="${ctxStatic }/images/loading.gif">
                    <p>等待中</p>
                </div> --%>

            </div>

        </div>
    </div>
    <div class="row has-js">
        <div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        支付信息
                    </h4>
                    <form id="inputForm" class="form-horizontal">
                        <div class="col-sm-12 form-horizontal goods_details">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-4 control-label text-left">是否线上支付：</div>
                                <div class="col-sm-8 text-left">
                                    <div class="radios" id="online-pay">
                                            <input id="isOnlinePay_line" name="isOnlinePay" value="0"
                                                   type="radio" checked=checked> 线下支付
                                            <input name="isOnlinePay" id="isOnlinePay_online" value="1"
                                                   type="radio">线上支付
                                      
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6  pay_hide_box" style="display: none;">
                                <div class="col-sm-3 control-label text-left">支付方式：</div>
                                <div class="col-sm-9 text-left">

                                    <c:choose>
                                        <c:when test="${curUser.memberId!=null&&curUser.memberId!=''}">
                                                <input name="isAccount" id="isAccount1" value="0" type="radio"
                                                       checked="checked">余额支付
                                                <input name="isAccount" id="isAccount2" value="2" type="radio"
                                                       checked="checked">银行账户支付
                                        </c:when>
                                        <c:otherwise>
                                            <label style="width:30%;float: left;line-height: 35px;">
                                                余额支付
                                            </label>
                                        </c:otherwise>

                                    </c:choose>
                                    <%--<div class="checkboxes">
                                        <label class="label_check" for="ispaycoin"
                                               style="padding: 15px;margin-top: 10px;display: block;">
                                            <input id="ispaycoin" name="ispaycoin" value="1" type="checkbox"/>
                                        </label>
                                    </div>--%>
                                </div>
                            </div>

                            <!--折叠内容-->
                            <div class="clearfix pay_hide_box" style="display: none">

                                <div class="form-group has-unit col-sm-6" style="">
                                    <div class="col-sm-4 control-label text-left">线上支付金额：</div>
                                    <div class="col-sm-8 text-left" style="width: 60%;">
                                        <input class="form-control"
                                               style="border:none;border-bottom:1px solid #ddd;outline: none;border-radius:0;box-shadow: none;"
                                               id="webamount" name="webamount" onkeyup="webamountKeyUp()" min="0"
                                               max="${bidOrderinfo.contracttotal}"
                                               value="${bidOrderinfo.contracttotal}" placeholder="输入支付金额">
                                        <i class="unit" style="right: 45px;">元</i>
                                    </div>
                                </div>
                                <%--<div class="form-group has-unit col-sm-6" id="coin_hide_box" style="display: none">
                                    <div class="col-sm-3 control-label text-left">支付卓币：</div>
                                    <div class="col-sm-9 text-left" style="width: 60%;">
                                        <input class="form-control"
                                               style="border:none;border-bottom:1px solid #ddd;outline: none;border-radius:0;box-shadow: none;"
                                               id="coinamount" name="coinamount" min="0" value="0"
                                               max="0" placeholder="输入支付金额">
                                        <i class="unit" style="right: 45px;">元</i>
                                    </div>
                                </div>--%>
                                <input type="hidden" id="coinamount" name="coinamount" value="0" />
                                <div class="form-group col-sm-6" style="clear:both;">
                                    <div class="col-sm-4 control-label text-left">线下支付金额：</div>
                                    <div class="col-sm-8 text-left has-unit">
                                        <input id="lineamount" class="form-control noborder-form-control" readonly
                                               value="0元">
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">支付密码：</div>
                                    <div class="col-sm-9 text-left">
                                        <input class="form-control noborder-form-control" type="password" name="cashPwd"
                                               style="border-bottom:1px solid #ddd;outline: none;" value=""
                                               placeholder="支付密码">
                                    </div>
                                </div>

                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="form-group mb-80" style="margin-bottom: 40px;">
                <div class="col-sm-5 control-label text-left"></div>
                <div class="col-sm-2 text-left">
                    <c:choose>
                        <c:when test="${fns:getUser().ischild}">
                            <c:if test="${fns:getUser().childUser.role.enname eq 'U_financial'}">
                                <button type="button" class="btn btn-success col-sm-12" id="btn-warning">提交
                                </button>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-success col-sm-12" id="btn-warning">提交
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
$("#maskloading" , parent.document).hide();
    $(function () {
        var order_id = "${bidOrderinfo.id}";
        var payMoney = "${bidOrderinfo.contracttotal}";
        var curAval = "${curUser.userPurse.availablebalance}";
        $("input[name='isAccount']:first").attr('checked', 'checked');
        $("input[name='isAccount']").click(function () {
            var isAccount = $("input[name='isAccount']:checked").val();
            if (isAccount == 0) {
                //$("#precoin").slideDown("show");
                curAval = "${curUser.userPurse.availablebalance}";
            } else {
                var memberId = "${curUser.memberId}";
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
                                    curAval = slaveAccounts[i].availableBalance;
                                }
                            }

                        }
                    }
                });
            }
        });
        $("#online-pay input").click(function () {
            var labelIndex = $(this).index();
            $("#online-pay input").removeAttr("checked");
            // alert(labelIndex);
            if (labelIndex == 1) {
                $("#isOnlinePay_online").attr("checked", "checked");
                $('.pay_hide_box').css("display", "block");

            }
            else {
                $("#isOnlinePay_line").attr("checked", "checked");
                $('.pay_hide_box').css("display", "none");
            }
        });
        $("#pay_pre label").click(function () {
            var labelIndex = $(this).index();
            if (labelIndex !== 0) {
                $('.payPre_hide_box').css("display", "block");
            }
            else {
                $('.payPre_hide_box').css("display", "none");
            }
        });
        /* //点击单选框 变换背景图片
        $('.label_radio').click(function () {
            $(this).addClass('r_on').siblings().removeClass('r_on');
            $(".label_radio").children("input").removeAttr("checked");
            $(this).children("input").attr("checked", "checked");
        }); */
        //点击单选框 变换背景图片
        /*$('.label_check').toggle(function () {
            $(this).addClass('c_on');
        }, function () {
            $(this).removeClass('c_on');
        });*/
        var totalmoney = '${bidOrderinfo.contracttotal}' * 1;
        var conMax = 0;
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                webamount: {
                    message: "线上支付金额不能为空",
                    validators: {
                        notEmpty: {
                            message: '线上支付金额不能为空'
                        },
                        decimalTwo: {
                            message: '请输入正确的资金'
                        }, lessThan: {
                            value: (totalmoney - $("#coinamount").val() * 1),
                            message: '线上支付金额不能大于' + (totalmoney - $("#coinamount").val() * 1)
                        }
                    }
                },
                cashPwd: {
                    message: '请输入支付密码',
                    validators: {
                        notEmpty: {
                            message: '请输入支付密码'
                        },
                        post_valid: {
                            url: '/a/wlpt/user/vadChildCashPwd',
                            isran: false,
                            message: '支付密码错误或未设置'
                        }
                    }
                }
            }

        });
        window.webamountKeyUp = function () {
            conMax = accSub(totalmoney, $("#webamount").val());
            $("#coinamount").attr("max", conMax);
            $("#lineamount").val(accSub(totalmoney, $("#webamount").val()));
        };
        $("#coinamount").keyup(function () {
            var line = accSub(accSub(totalmoney, $("#webamount").val()), $(this).val());
            if (line < 0) {
                $(this).val(0);
                return;
            }
            $("#lineamount").val(line);
        });
        function accSub(arg1, arg2) {
            var r1, r2, m, n;
            try {
                r1 = arg1.toString().split(".")[1].length
            } catch (e) {
                r1 = 0
            }
            try {
                r2 = arg2.toString().split(".")[1].length
            } catch (e) {
                r2 = 0
            }
            m = Math.pow(10, Math.max(r1, r2));
            //last modify by deeka
            //动态控制精度长度
            n = (r1 >= r2) ? r1 : r2;
            return ((arg1 * m - arg2 * m) / m).toFixed(n);
        }

        $("#btn-warning").click(function () {
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {

                var ispaycoin = 0;
                var isOnlinePay = $("input[name='isOnlinePay']:checked").val();
                var totalCost = $("#totalCost").html() * 1;
                ///余额支付金额
                var webamount = $("#webamount").val() * 1;
                //卓币支付金额
                var coinamount = $("#coinamount").val() * 1;
                var total = "${not empty curUser.userPurse.availablecoin ? curUser.userPurse.availablecoin:'0.00'}";

                $.MsgBox.Confirm("交易操作", "确认支付结算运费吗?", function () {
                    $("#maskloading" , parent.document).show();
                    $.ajax({
                        url: "${wlpt}/wlpt/bid/payBidOrder",
                        data: {
                            id: order_id,
                            ispaycoin: ispaycoin,
                            webamount: webamount,
                            coinamount: coinamount,
                            isOnlinePay: isOnlinePay,
                            isAccount: $("input[name='isAccount']:checked").val()
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $.MsgBox.Alert("交易提示", data.message);
                            if (data.state == 1) {
                                window.location.href = "${wlpt}/wlpt/bid/bidOrder"
                            } else {
                                //$(this).removeAttr("disabled")
                                $("#maskloading" , parent.document).hide();
                            }
                        }
                    });
                });
            }
        });
    });
</script>
</body>
</html>
