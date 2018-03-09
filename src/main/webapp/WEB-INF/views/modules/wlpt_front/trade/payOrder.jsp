<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>

    <title>付款</title>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/foot.css">

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

        .loading_lock {
            display: none;
            width: 100%;
            height: 100%;
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


</head>
<body>
<p class="user_data">
    <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">运单</span><span
        class="title_orange">详情</span><img
        src="/static/images/wlptfront/line-right.png">
</p>
<!--页面内容-填写提现信息块信息-->
<div class="cash_wrap" style="margin: 0px;border: none;width: 100%">
    <div class="payment_title" style="width: 80%">
        <p class="payment_title_con">您的运单:${orderinfo.orderno}</p>
        <p class="bg_like_sea">
        <p>总运费：${orderinfo.totalcost}元&nbsp;&nbsp;
            <c:if test="${orderinfo.isonlinepay eq 1}">|
                线上支付：<span class="num_red">${orderinfo.payinfo.onlineamount}</span>元
                <c:if test="${orderinfo.isprepay eq 1}">
                    已线上预付：<span class="num_green">${orderinfo.payinfo.preamount}</span>元
                </c:if>
                待付：<span class="num_red">${orderinfo.payinfo.actualamount}</span>元

            </c:if>
        </p>
        <c:if test="${orderinfo.ispaycoin eq 1}">
            <p>
                卓币支付：<span class="num_red">${orderinfo.payinfo.coinamount}</span>币
                <c:if test="${orderinfo.isprecoin eq 1}">
                    已卓币预付：<span class="num_green">${orderinfo.payinfo.coinpreamount}</span>币
                </c:if>
                待付：<span class="num_red">${orderinfo.payinfo.coinactualpay}</span>币&nbsp;&nbsp;|&nbsp;&nbsp;
            </p>
        </c:if>
        <p>确认运输完成，即可完成订单。请您在<span class="num_red">12小时</span>内确认运输完成</p>
        <c:if test="${orderinfo.isonlinepay eq 1}">
        <p>
            <input type="password"
                   style="margin: 5px;letter-spacing: 10px;text-align: center;width: 25%;border-radius: 5px;border: 1px solid #CCC;"
                   id="password"
                   class="input-xlarge " placeholder="请输入支付密码"/>
        </p>
        </c:if>
        <c:if test="${curUser.ischild}">
            <p class="num_red">操作提示:业务员无权限完成此操作</p>
        </c:if>

    </div>
</div>
<c:choose>
    <c:when test="${curUser.ischild}">
        <c:if test="${curUser.childUser.role.enname eq 'U_financial'}">
            <button class="btn btn-defalut btn-warning" id="btn-warning">确认运输完成</button>
        </c:if>
    </c:when>
    <c:otherwise>
        <button class="btn btn-defalut btn-warning" id="btn-warning">确认运输完成</button>
    </c:otherwise>
</c:choose>
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

<div id="loading_lock" class="loading_lock" style="display: none;">
    <img src="${ctxStatic }/images/loading.gif">
    <p>等待中</p>
</div>
<script src="${ctxStatic}/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script>
    $(function () {
        var order_id = "${orderinfo.id}";
        $("#btn-warning").click(function () {
        	var isonlinepay='${orderinfo.isonlinepay}';
            var isvid=false;
            if(isonlinepay=='1'){
            	$.ajax({
                    url: "${ctx}/wlpt/user/vadChildCashPwd",
                    type: "POST",
                    data: {"cashPwd": $("#password").val()},
                    async: false, ///同步请求传递
                    success: function (data) {
                        isvid=data;
                        if (!data) {
                            $("#password").tips({
                                side: 3,
                                msg: '支付密码错误或未设置!',
                                bg: '#00A2E9',
                                time: 3
                            });
                        }
                    }
                });
            }else{
            	isvid=true;
            }
                
            if (isvid) {
                $.MsgBox.Confirm("交易提示", "是否确认运输完成?", function () {
                    $("#loading_lock").show();
                    $.ajax({
                        url: "${wlpt}/wlpt/trade/endOrder",
                        data: {
                            id: order_id
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $(".loading_lock").hide();
                            $.MsgBox.Alert("交易提示", data.message);
                            if (data.state == 1) {
                                window.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true"
                            }
                        }
                    });
                }, function () {
                    $(".loading_lock").hide();
                });
            }


        });


    });
    // 点击图片添加对号选择符号
    $(".pay_wrap_list li").on("click", function () {
        $(".pay_wrap_list li .change_paytype").remove();
        $(this).append("<img src='/static/images/wlptfront/right.png' style='position: absolute;left: 150px;top: 34px;border: 3px solid red;border-radius: 50%;background: red;' class='change_paytype'>")
    });
    $(".pay_wrap_list li").eq(0).append("<img src='/static/images/wlptfront/right.png' style='position: absolute;left: 150px;top: 34px;border: 3px solid red;border-radius: 50%;background: red;' class='change_paytype'>")
</script>
</body>
</html>
