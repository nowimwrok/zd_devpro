<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>付款</title>
    <script type="text/javascript" src="/static/common/global.js"></script>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/foot.css">


    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css">

</head>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
<link rel="stylesheet" type="text/css" href="${ctxStatic}/common/jeesite.css">
<body>
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

    .num_red {
        color: #f22525;
        font-weight: bold;
    }

    .num_green {
        color: green;
    }

    .control-group:before, .control-group:after {
        display: table;
        line-height: 0;
        content: "";
    }

    .control-label {
        padding-top: 3px;
    }

    .control-label {
        float: left;
        width: 160px;
        padding-top: 5px;
        text-align: right;
    }

    label {
        display: inline-block;
        margin-right: 8px;
        margin-bottom: 0px;
        font-weight: normal;
        iiiiiiiiiii line-height: 20px;
    }

    .controls {
        text-align: left;
        overflow-x: auto;
        overflow-y: hidden;
        margin-left: 180px;
    }

    .controls .lbl {
        display: inline-block;
        padding-top: 5px;
        margin-bottom: 0;
        vertical-align: middle;
    }

    input[type="number"] {
        padding-left: 5px;
        line-height: 25px;
    }
    .loading_lock {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading_lock img {
            margin-top: 25%;
        }
</style>
<p class="user_data">
    <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">招标</span><span
        class="title_orange">结算</span><img
        src="/static/images/wlptfront/line-right.png">
</p>
<!--页面内容-填写提现信息块信息-->
<div class="cash_wrap" style="margin: 0px;border: none;width: 100%">

    <div class="payment_title" style="width: 80%">
        <p class="payment_title_con">您的招标文号:${bidOrderinfo.bidinfo.bidcode}</p>
        <div class="bg_like_sea">
            <p>总运费：${bidOrderinfo.contracttotal}元&nbsp;&nbsp;|
                &nbsp;&nbsp;待付：<span class="num_red">${bidOrderinfo.contracttotal}</span>元</p>
            <p>确认支付，即可完成合同结算。请您尽快完成支付</p>
            <c:if test="${fns:getUser().ischild}">
                <p class="num_red">操作提示:业务员无权限完成此操作</p>
            </c:if>
        </div>

    </div>
    <form:form modelAttribute="bidOrderinfo" action="" method="post" class="form-horizontal">

        <div id="ispay" style="height: 210px;">
            <div class="control-group" style="border-bottom: 0;">
                <label class="control-label" style="width: 200px;">是否线上支付：</label>
                <div class="controls">

                    <form:radiobuttons id="isOnlinePay" path="isOnlinePay"
                                       items="${fns:getDictList('order_isonlinepay')}"
                                       itemLabel="label" itemValue="value" htmlEscape="false"/>

                </div>
            </div>
            <!-- 余额支付 -->
            <div style="width: 49%;float: left;" id="onlinepay" hidden="hidden">
                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">支付方式：</label>
                    <div class="controls">
                        <c:choose>
                        <c:when test="${curUser.memberId!=null&&curUser.memberId!=''}">
                             <form:radiobuttons id="isAccount" path="isAccount"
                                               items="${fns:getDictList('payway')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false"/>
                            <label class="lbl "><input type="checkbox" id="ispaycoin" name="ispaycoin" value="1"/>卓币支付</label>
                        </c:when>
                        <c:otherwise>
                        <label class="lbl ">余额支付</label>
                        <label class="lbl "> <input type="checkbox" id="ispaycoin" name="ispaycoin" value="1"/>卓币支付</label>
                        </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">支付金额：</label>
                    <div class="controls" id="online">
                        <input type="number" id="webamount" name="webamount" min="0" max="${bidOrderinfo.contracttotal}"
                               value="${bidOrderinfo.contracttotal}" style="width:70%;" htmlEscape="false"
                               class="input-xlarge "/>
                    </div>
                </div>
                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">线下支付金额：</label>
                    <div class="controls">
                        <label id="lineamount" class="lbl">0.00</label>
                    </div>
                </div>
            </div>
            <!-- 卓币支付 -->
            <div style="width: 49%;float: left;" hidden="hidden" id="paycoin">
                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">支付方式：</label>
                    <div class="controls">
                        <label class="lbl ">卓币支付</label>

                    </div>
                </div>

                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">支付卓币：</label>
                    <div class="controls" id="online">
                        <input type="number" id="coinamount" name="coinamount" min="0"
                               max="${bidOrderinfo.contracttotal}" style="width:70%;" htmlEscape="false"
                               class="input-xlarge "/>
                    </div>
                </div>
            </div>
            <div style="width: 49%;clear: both;">
                <div class="control-group" style="border-bottom: 0;">
                    <label class="control-label" style="width: 200px;">支付密码：</label>
                    <div class="controls">
                        <input type="password" id="password" name="password" min="0" style="width:70%;border: 1px solid #CCC;height: 30px;text-align: center;letter-spacing: 10px;font-size: 20px;"
                               htmlEscape="false" class="input-xlarge "/>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
    <c:choose>
        <c:when test="${fns:getUser().ischild}">
            <c:if test="${fns:getUser().childUser.role.enname eq 'U_financial'}">
                <button class="btn btn-defalut btn-warning" id="btn-warning">确认支付</button>
            </c:if>
        </c:when>
        <c:otherwise>
            <button class="btn btn-defalut btn-warning" id="btn-warning">确认支付</button>
        </c:otherwise>
    </c:choose>
    <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif">
            <p>等待中</p></div>
        <div>
    <!--页面内容-填写提现信息内容-->
    <%--<div class="withdraw_cash_wrap">
        <div class="pay_wrap">
            <p class="pay_wrap_title">付款方式：</p>
            <ul class="pay_wrap_list">
                <li>
                   <div>平台余额</div>
                </li>
                &lt;%&ndash;<li> <img src="../../images/account_img/pay_weixin.png" class="pay_change_img"></li>
                <li><img src="../../images/account_img/pay_zhifu.png" class="pay_change_img"></li>
                <li><img src="../../images/account_img/pay_zhifu.png" class="pay_change_img"></li>&ndash;%&gt;
            </ul>


        </div>

    </div>--%>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>

var order_id="${bidOrderinfo.id}";
var payMoney="${bidOrderinfo.contracttotal}";
var curAval="${curUser.userPurse.availablebalance}";
$("input[name='isAccount']:first").attr('checked', 'checked');
$("input[name='isAccount']").click(function () {
        var isAccount = $("input[name='isAccount']:checked").val();
        if (isAccount == 0) {
            //$("#precoin").slideDown("show");
            curAval="${curUser.userPurse.availablebalance}";
        } else {
        		var memberId="${curUser.memberId}";
        	    $.ajax({
        	            url: "${wlpt}/wlpt/consume/virtAcctList",
        	            dataType: 'json',
        	            data:{"memberId":memberId,"status":'1'},
        	            type: "post",
        	            success: function (data) {
        	               if(data.status==200){
        	            	   var slaveAccounts=data.body.records[0].slaveAccounts;
        	            	   for(i=0;i<slaveAccounts.length;i++){
        	            		   if(slaveAccounts[i].accountType==4){
        	            			   curAval=slaveAccounts[i].availableBalance;
        	            		   }
        	            	   }
        	            	   
        	               }
        	            }
        	    });
        }
    });


////是否线上支付

    $("input[name='isOnlinePay']").click(function () {
        var isonline = $("input[name='isOnlinePay']:checked").val();
        if (isonline == 1) {
            $("#onlinepay").slideDown("slow");
            $("#webamount").val(payMoney);
            setmount("#webamount");
        } else {
            $("#onlinepay").slideUp();
            $("#lineamount").html("0.00");
            $("#webamount").val("");

            //卓币
            $("input[name='ispaycoin']").attr("checked", false);
            $("#coinamount").val("");
            $("#paycoin").hide();
        }
    });


    ////卓币支付
    $("input[name='ispaycoin']").click(function () {
        var isonline = $("input[name='ispaycoin']:checked").val();
        if (isonline == 1) {
            $("#paycoin").slideDown("slow");
            setmount("#webamount");
        } else {
            $("#paycoin").slideUp();
            $("#coinamount").val("");
            setmount("#webamount");
        }
    });

    ///线上支付
    $("input[name='webamount']").change(function () {
        ///总运费
        var totalCost = payMoney * 1;
        ///线上支付总金额
        var webamount = $("#webamount").val() * 1;
        var isnul = true;
        isnul = isnul && $("#webamount").valid({
                    methods: "decimal"
                });
        if (!isnul) {
            $("#webamount").val("0");
        }
        if (totalCost < webamount||webamount<=0) {
            $("#webamount").tips({
                side: 3,
                msg: '请填写正确运费',
                bg: '#00A2E9',
                time: 4
            });
            $("#webamount").val("0");
        } else if (totalCost == webamount) {
            $("#coinamount").val("0");
        }


        setmount("#webamount");

    });
    ///卓币支付
    $("input[name='coinamount']").change(function () {
        ///总运费
        var totalCost = payMoney * 1;

        //卓币支付金额
        var coinamount = $("#coinamount").val() * 1;
        var isnul = true;
        isnul = isnul && $("#coinamount").valid({
                    methods: "decimal"
                });
        if (!isnul) {
            $("#coinamount").val("0");
        }
        if (totalCost < coinamount) {
            $("#coinamount").tips({
                side: 3,
                msg: '不能大于总运费',
                bg: '#00A2E9',
                time: 4
            });
            $("#coinamount").val("0");
        } else if (totalCost == coinamount) {
            $("#webamount").val("0");
        }

        setmount("#coinamount");

    });

    function setmount(type) {
        var isonline = $("input[name='ispaycoin']:checked").val();
        ///总运费
        var totalCost = payMoney * 1;
        ///线上支付总金额
        var webamount = $("#webamount").val() * 1;
        //卓币支付金额
        var coinamount = $("#coinamount").val() * 1;

        ///线下支付总金额
        var lineAmount = totalCost - webamount - coinamount;
        lineAmount = xround(lineAmount, 2);
        //$("#onlineamount").html(onlineAmount);
        $("#lineamount").html(lineAmount);
        if (lineAmount < 0) {
            $(type).val("0");
            $(type).tips({
                side: 3,
                msg: '线下支付不能小于0',
                bg: '#00A2E9',
                time: 4
            });
            ///总运费
            var totalCost = payMoney * 1;
            ///线上支付总金额
            var webamount = $("#webamount").val() * 1;
            //卓币支付金额
            var coinamount = $("#coinamount").val() * 1;

            ///线下支付总金额
            var lineAmount = totalCost - webamount - coinamount;
            lineAmount = xround(lineAmount, 2);
            //$("#onlineamount").html(onlineAmount);
            $("#lineamount").html(lineAmount);
        }
    }

    $(function () {

        $("#btn-warning").click(function () {
           // $(this).attr("disabled", "disabled");
            var ispaycoin = $("input[name='ispaycoin']:checked").val();
            var isOnlinePay = $("input[name='isOnlinePay']:checked").val();
            if (isOnlinePay == 1) {

                var isnul = true;
                isnul = isnul && $("#webamount").valid({
                            methods: "required|decimal"
                        });

                if (ispaycoin == 1) {
                    isnul = isnul && $("#coinamount").valid({
                                methods: "required|decimal"
                            });
                }
                if (!isnul) {
                    //$(this).attr("disabled", "false");
                    return false;
                }
                var totalCost = $("#totalCost").html() * 1;
                ///余额支付金额
                var webamount = $("#webamount").val() * 1;
                //卓币支付金额
                var coinamount = $("#coinamount").val() * 1;
                /*  ///判断账户余额
                 if (payMoney>curAval){
                 $.MsgBox.Alert("交易提示","账户余额不足,请及时充值",function(){

                 return;
                 });
                 } */
                if (ispaycoin == 1) {
                    if ((coinamount * 1) <= 0) {
                        $("#coinamount").tips({
                            side: 3,
                            msg: '卓币必须大于0',
                            bg: '#00A2E9',
                            time: 4
                        });
                       // $(this).attr("disabled", "false");
                        return false;
                    }
                    var total = "${not empty curUser.userPurse.availablecoin ? curUser.userPurse.availablecoin:'0.00'}"
                    if (coinamount * 1 > total * 1) {
                        $("#coinamount").tips({
                            side: 3,
                            msg: '可用卓币不足,请及时充值',
                            bg: '#00A2E9',
                            time: 4
                        });
                       // $(this).attr("disabled", "false");
                        return false;
                    }
                    
                    if (webamount * 1 <= 0) {
                    	$("#webamount").tips({
                            side: 3,
                            msg: '支付运费必须大于0',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }

                    if (webamount * 1 > curAval * 1) {
                        $("#webamount").tips({
                            side: 3,
                            msg: '账户余额不足,请及时充值',
                            bg: '#00A2E9',
                            time: 4
                        });
                      //  $(this).attr("disabled", "false");
                        return false;
                    }

                    if ((webamount * 1 + coinamount * 1) > payMoney) {
                        $("#coinamount").tips({
                            side: 3,
                            msg: '两个金额相加不能大于待付运费',
                            bg: '#00A2E9',
                            time: 4
                        });
                      //  $(this).attr("disabled", "false");
                        return false;
                    }
                } else {
                    ispaycoin = 0;
                    if (webamount * 1 <= 0) {
                        $("#webamount").tips({
                            side: 3,
                            msg: '线上支付金额不能小于0',
                            bg: '#00A2E9',
                            time: 4
                        });
                      //  $(this).attr("disabled", "false");
                        return false;
                    }
                    if (webamount * 1 > curAval * 1) {
                        $("#webamount").tips({
                            side: 3,
                            msg: '账户余额不足,请及时充值',
                            bg: '#00A2E9',
                            time: 4
                        });
                     //   $(this).attr("disabled", "false");
                        return false;
                    }
                    if (webamount * 1 > payMoney) {
                        $("#webamount").tips({
                            side: 3,
                            msg: '不能大于待付运费',
                            bg: '#00A2E9',
                            time: 4
                        });
                    //    $(this).attr("disabled", "false");
                        return false;
                    }
                }

            }
            var isvid = false;
            $.ajax({
                url: "${ctx}/wlpt/user/vadChildCashPwd",
                type: "POST",
                data: {"cashPwd": $("#password").val()},
                async: false, ///同步请求传递
                success: function (data) {
                    isvid = data;
                    if (!data) {
                       // $(this).attr("disabled", "false");
                        $("#password").tips({
                            side: 3,
                            msg: '支付密码错误或未设置!',
                            bg: '#00A2E9',
                            time: 3
                        });
                    }
                }
            });
            if (!isvid) {
				return false;
			}
            $(".loading_lock").show();
            if (isvid) {
                $.MsgBox.Confirm("交易操作", "确认支付结算运费吗?", function () {
                    $.ajax({
                        url: "${wlpt}/wlpt/bid/payBidOrder",
                        data: {
                            id: order_id,
                            ispaycoin: ispaycoin,
                            webamount: webamount,
                            coinamount: coinamount,
                            isOnlinePay: isOnlinePay,
                            isAccount:$("input[name='isAccount']:checked").val()
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $.MsgBox.Alert("交易提示", data.message);
                            if (data.state == 1) {
                                window.location.href = "${wlpt}/wlpt/bid/bidOrder"
                            } else {
                                //$(this).removeAttr("disabled")
                            	$(".loading_lock").hide();
                            }
                        }
                    });
                });
            }
        });


    });
    // 点击图片添加对号选择符号
    $(".pay_wrap_list li").on("click", function () {
        $(".pay_wrap_list li .change_paytype").remove()
        $(this).append("<img src='/static/images/wlptfront/right.png' style='position: absolute;left: 150px;top: 34px;border: 3px solid red;border-radius: 50%;background: red;' class='change_paytype'>")
    })
    $(".pay_wrap_list li").eq(0).append("<img src='/static/images/wlptfront/right.png' style='position: absolute;left: 150px;top: 34px;border: 3px solid red;border-radius: 50%;background: red;' class='change_paytype'>")
</script>
</body>
</html>
