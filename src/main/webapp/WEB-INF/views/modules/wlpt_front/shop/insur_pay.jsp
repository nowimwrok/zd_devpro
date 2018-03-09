<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>立即支付</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="/static/modules/wlpt/front/css/shop_new.css" rel="stylesheet" type="text/css">
    <style>
        /*主菜单样式*/
        .container {
            width: 100%;
            padding-right: 0px;
            padding-left: 0px;
        }

        .shop_content {
            width: 80%;
            padding-right: 0px;
            padding-left: 0px;
        }

        .dropdown-menu {
            display: none;
            overflow: hidden;
            position: absolute;
            top: 100%;
            left: -30%;
            z-index: 1000;
            display: none;
            float: left;
            min-width: 160%;
            padding: 5px 0;
            margin: 2px 0 0;
            font-size: 14px;
            text-align: left;
            list-style: none;
            background-color: #fff;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            border: 1px solid #ccc;
            border: 1px solid rgba(0, 0, 0, .15);
            border-radius: 4px;
            -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
            box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
        }

        .dropdown-menu li {
            display: block;
            float: none;
            width: 100%;
            overflow: hidden;
            position: relative;
            padding: 0;
            display: block;
            background: #fff;
        }

        .dropdown-menu > li > a {
            padding: 10px 20px;
            color: #2676ac;
            text-shadow: 0px 0px 13px #fff;

        }

        .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus {
            background-color: rgba(39, 189, 184, 0.77);
            color: #fff;
        }

        /*调用定义动画，使得二级目录背景淡入淡出*/
        .fadeIn_a {
            -webkit-animation-name: fadeIn;
            -webkit-animation-duration: 1000ms;
            -webkit-animation-iteration-count: 1;
            -webkit-animation-delay: 0s;
            background-color: rgba(39, 189, 184, 0.77);
            color: #2676ac;
        }

        /*定义淡入淡出动画*/
        @-webkit-keyframes fadeIn {
            0% {
                color: #27bdb8;
                opacity: 0; /*初始状态 透明度为0*/
            }
            100% {
                opacity: 1; /*最终状态 透明度为1*/
                color: #fff;
            }
        }

        /*End--主菜单样式*/
        .loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;

            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }

        .regbt {
            width: 100px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }

        .ticket i {
            font-style: normal;
            font-size: 20px;
        }

        .text_center {
            text-align: center
        }

        .ticket {
            width: 600px;
            margin: 0 auto;
            border: 1px solid #ddd;
            padding: 10px;
            margin-left: 42%;
        }

        .ticket li {
            margin-bottom: 10px;
            position: relative;
            margin-right: 10px;
            width: 160px;
            height: 95px;
            display: inline-block;
            background: url(${ctxStatic}/front/img/bg_quan.png) no-repeat;
            background-size: 100% 100%;
        }

        .ticket li span, .ticket li h3, .ticket li p, .ticket li b {
            color: #fff;
            font-size: 20px;
            letter-spacing: 2px;
        }

        .ticket li p {
            line-height: 24px;
        }

        .ticket li b {
            margin-left: 5px;
        }

        .ticket li span {
            margin-top: 5px;
            margin-left: 8px;
            display: inline-block;
            width: 22px;
            height: 22px;
            line-height: 22px;
            font-size: 14px;
            text-align: center;
            border-radius: 100%;
            border: 1px solid #fff;
        }

        .ticket .h3_m {
            margin-bottom: 5px;
        }

        .have {
            width: 24px;
            height: 20px;
            position: absolute;
            top: 5px;
            right: 10px;
            display: none;
        }
    </style>
</head>
<body>

<!----在线支付--------------------主要内容---->
<div class="shop_content">
    <h4>在线支付</h4>
    <!--头部提示支付信息-->
    <div class="onlinePay_notice">
        <h4>您已选购${shop.name}商品，请立即在线支付！</h4>
    </div><!--End----头部提示支付信息-->

    <!--table选择支付方式-->
    <table class="pur_tab" style="margin-bottom: 30px;    border-bottom: 1px dashed #ccc;">

        <tr>
            <td class="tab_left" style="width: 50%;">应付金额：</td>
            <td class="tab_right" style="width: 50%;">${not empty shop.total?shop.total:'0.00'}元</td>
        </tr>
        <tr id="aw_way" style="display: none;">
            <td class="tab_left" style="width: 50%;">实付金额：</td>
            <td class="tab_right" style="width: 50%;" id="sfmoney"></td>
        </tr>
        <tr>
            <td class="tab_left" style="height: 80px;line-height: 81px;">
                账户可用余额：
            </td>
            <td class="tab_right"><span id="available"><fmt:formatNumber
                    value="${not empty user.userPurse.availablebalance?user.userPurse.availablebalance:'0.00'}"
                    pattern="#.##" minFractionDigits="2"></fmt:formatNumber></span>元
            </td>
        </tr>
        <tr>
            <td class="tab_left" style="height: 80px;line-height: 81px;">支付方式：</td>
            <td class="tab_right">
                <input type="radio" class="paytyperadio" checked="checked"
                       name="payway" value="0"/><span>账户余额</span>&nbsp;&nbsp;

                <c:if test="${user.memberId!=null&&user.memberId!=''}">
                    <input type="radio" class="paytyperadio"
                           name="payway" value="10"/><span>银行卡账户</span>&nbsp;&nbsp;</c:if>
                <input type="radio" class="paytyperadio"
                       name="payway" value="1"/><span>线下支付</span>

            </td>
        </tr>
        <c:if test="${not empty awlist }">
            <tr>
                <td colspan="2">
                    <div class="ticket">
                        <ul>
                            <c:forEach var="item" items="${awlist}" varStatus="status">
                                <li onclick="clickaw('${status.index}','${not empty item.wxgift.giftworth ? item.wxgift.giftworth : "0"}','${item.awardno}')"
                                    id="aw${status.index}">
                                    <img src="${ctxStatic}/front/img/have.png" alt="" class="have"/>
                                    <span class="text_center">券</span>
                                    <h3 class="text_center h3_m" style="margin-top:8px;">
                                        <i>￥</i><b>${item.wxgift.giftworth}</b></h3>
                                    <h3 class="text_center"
                                        style="margin-top:8px;">${fns:getDictLabel(item.wxgift.gifttype,'gifttype','')}</h3>

                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </td>
            </tr>
        </c:if>
        <tr style="height: 70px;" id="zhifu">
            <td class="tab_left" style="width: 50%;">支付密码：</td>
            <td class="tab_right" style="width: 50%;"><input id="password" type="password"
                                                             style="height: 28px;line-height: 28px;width:102px;"/></td>
        </tr>
        <tr class="colspan2">
            <td colspan="2" class="btn_td" style="padding-bottom: 30px;">
                <span id="sub"><input id="btnSubmit" type="button" class="regbt" value="立即支付"/></span>
                &nbsp;
                <input id="btnSubmit" class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
                &nbsp;
                <span id="mone" hidden="hidden"><input id="btn" class="regbt" type="button" value="账户中心"/></span>
            </td>
        </tr>
    </table><!--End----table需要填写的信息-->

    <div class="loading">
        <img src="${ctxStatic}/images/loading.gif">
    </div>
</div><!--End----------在线支付--------------主要内容-->
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    $(".loading").hide();
    var awardno = "";
    var worth = 0;
    var type = "${shop.shotName}";
    var amount = 0.00;
    var avail = "${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
    var memberId = "${user.memberId}"
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
    function clickaw(li_id, giftworth, no) {
        $("#aw" + li_id).siblings().find('img').hide();
        $("#aw" + li_id).find('img').show();
        $("#aw_way").show();
        awardno = no;
        worth = giftworth * 1;
        var total = "${shop.total}";
        var money = total * 1 - worth;
        if (money < 0) {
            money = 0;
        }
        $("#sfmoney").html(money + "元");
    }
    $("input[name='payway']").click(function () {
        var paytype = $("input[name=payway]:checked").val();
        if (paytype * 1 == 1) {
            $("#zhifu").hide();
        }
        if (paytype * 1 == 0) {
            $("#zhifu").show();
            $("#available").html(avail);
        }
        if (paytype * 1 == 10) {
            $("#zhifu").show();
            $("#available").html(amount);
        }
    });
    $("#btnSubmit").click(function () {
        var total = "${shop.total}";
        var money = total * 1;
        var shotName = "${shop.shotName}";
        var paytype = $("input[name=payway]:checked").val();
        var available = $("#available").html();
        var insurid = "${userInsurance.id}"
        if (money < 0) {
            $("#btnSubmit").tips({
                side: 3,
                msg: '消费金额不能小于0',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        var pass = $("#password").val();
        if (paytype * 1 != 1) {
            if (available * 1 < (money - worth)) {
                $("#btnSubmit").tips({
                    side: 3,
                    msg: '账户余额不足',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            }
            if (pass == null || pass == "") {
                $("#password").tips({
                    side: 3,
                    msg: '请输入支付密码',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            }
        }
        if ($(".loading").is(':hidden')) {
            $(".loading").show();
        } else {
            return false;
        }
        if (pass != null || pass != "" || paytype * 1 == 1) {
            var issave = paytype * 1 == 1 ? true : false;
            $.ajax({
                url: "${ctx}/wlpt/user/validateCashPwd",
                dataType: 'json',
                data: {"cashPwd": $("#password").val(), "isSave": issave},
                type: "post",
                success: function (data) {
                    if (data == false) {
                        $(".loading").hide();
                        $("#password").tips({
                            side: 3,
                            msg: '请输入正确支付密码',
                            bg: '#00A2E9',
                            time: 4
                        });
                    } else {

                        $.ajax({
                            url: "${wlpt}/wlpt/shop/consumeType",
                            dataType: 'json',
                            data: {
                                total: total,
                                shotName: shotName,
                                num: '${shop.num}',
                                giftid: '${giftid}',
                                paytype: paytype,
                                insurid: insurid,
                                awardno: awardno
                            },
                            type: "post",
                            success: function (data) {
                                if (data.value == 6) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "购买金额错误，至少消费一元");
                                }
                                else if (data.value == 2) {
                                    //$.MsgBox.Alert("支付提示", "您还未登录");
                                    top.location.href = '${wlpt}/login';
                                } else if (data.value == 5) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "账户余额不足");
                                } else if (data.value == 1) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "购买成功");
                                    window.location.href = "${wlpt}/wlpt/shop/insur_list?index=2"
                                    $("#mone").show();
                                    $("#sub").hide();
                                } else if (data.value == -1) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "购买失败");
                                    $("#mone").show();
                                    $("#sub").hide();
                                } else if (data.value == 8) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "金额大于单笔交易最高限额");
                                    $("#mone").show();
                                    $("#sub").hide();
                                } else if (data.value == 10) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "电子钱包最低留存额度");
                                    $("#mone").show();
                                    $("#sub").hide();
                                } else if (data.value == 11) {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "单日交易最高限额");
                                    $("#mone").show();
                                    $("#sub").hide();
                                } else {
                                    $(".loading").hide();
                                    $.MsgBox.Alert("支付提示", "支付失败");
                                    $("#mone").show();
                                    $("#sub").hide();
                                }
                            }
                        });
                    }
                }
            });
        }
    });
    $("#btn").click(function () {
        window.location.href = "${wlpt}/wlpt/shop/insur_list?index=2"
    });
</script>
</body>
</html>