<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>付款</title>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/foot.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
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

        .baojia-list {
            width: 100%;
            padding: 2% 3%;
            text-align: center;
            margin: 0 auto;
            border-bottom: 0px;
        }
        .table_border{
            width: 90%;
            line-height: 30px;
            text-align: center;
            margin: 10px auto;
        }
        .table_border th,td{
            text-align: center;
        }
        .bg_like_sea {
            padding: 5px;
            text-align: center;
            background: #F1FDEC;
            padding: 25px 5px;
        }
    </style>

    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

</head>
<body>

<div class="cash_wrap" style="margin: 0px;border: none;width: 100%">
    <div class="payment_title" style="width: 80%">
        <p class="payment_title_con">您的运单:${orderinfo.orderno}</p>
        <div class="bg_like_sea">
            <p>总运费：${orderinfo.totalcost}元&nbsp;&nbsp;|
                <c:if test="${orderinfo.isonlinepay eq 1}">
                    线下支付：<span class="num_green">${orderinfo.payinfo.lineamount}</span>元&nbsp;&nbsp;|
                    线上支付：<span class="num_green">${orderinfo.payinfo.onlineamount+orderinfo.payinfo.coinamount}</span>元
                    <c:if test="${orderinfo.isdispute eq 1}">
                        争议运费：<span class="num_red">${orderinfo.payinfo.disputeamount}</span>元
                    </c:if>
                </c:if>
                <c:if test="${orderinfo.isonlinepay eq 0}">
                    线下支付：<span class="num_green">${orderinfo.payinfo.lineamount}</span>元
                </c:if>
            </p>
            <c:if test="${orderinfo.isonlinepay eq 1}">

            <table class="table_border" cellpadding="0" cellspacing="0">
                <tr>
                    <th>线上支付</th>
                    <th>是否预付</th>
                    <th>预付比例</th>
                    <th>预付</th>
                    <th>线上余款</th>
                </tr>
                <tr>
                    <td>${orderinfo.payinfo.onlineamount}</td>
                    <td>${fns:getDictLabel(orderinfo.isprepay, 'order_isprepay', '')}</td>
                    <td>${orderinfo.payinfo.preraio}</td>
                    <td>${orderinfo.payinfo.preamount}</td>
                    <td>${orderinfo.payinfo.actualamount}</td>
                </tr>
                <c:if test="${orderinfo.ispaycoin eq 1}">
                    <tr>
                        <th>卓币支付</th>
                        <th>是否预付</th>
                        <th>预付比例</th>
                        <th>预付</th>
                        <th>卓币余款</th>
                    </tr>
                    <tr>
                        <td>${orderinfo.payinfo.coinamount}</td>
                        <td>${fns:getDictLabel(orderinfo.isprecoin, 'order_isprepay', '')}</td>
                        <td>${orderinfo.payinfo.coinprepaio}</td>
                        <td>${orderinfo.payinfo.coinpreamount}</td>
                        <td>${orderinfo.payinfo.coinactualpay}</td>
                    </tr>
                </c:if>
            </table>

        </div>
    </div>
    </c:if>
    <%--<div class="content-2 baojia-list">
        <p class="list_two">
            <input id="gsid" name="id" value="${goods.id}" type="hidden"/>
        <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">运单号:${orderinfo.orderno}</span></td>
            </tr>

            <tr>
                <td class="cols_1">总运费：</td>
                <td class="cols_2" colspan=3>${orderinfo.totalcost}元
                </td>
            </tr>
            <tr>
                <td class="cols_1">线下支付：</td>
                <td class="cols_2" colspan=3>${orderinfo.payinfo.lineamount}元</td>
            </tr>

            <tr>
                <td class="cols_1">支付方式：</td>
                <td class="cols_2">${fns:getDictLabel(orderinfo.isonlinepay, 'order_isonlinepay', '')}
                </td>
                <c:if test="${orderinfo.ispaycoin eq 1}">
                    <td class="cols_3">是否卓币支付：</td>
                    <td class="cols_4">${fns:getDictLabel(orderinfo.ispaycoin, 'order_isonlinepay', '')}</td>
                </c:if>
                <c:if test="${orderinfo.ispaycoin eq 0}">
                    <td class="cols_3"></td>
                    <td class="cols_4"></td>
                </c:if>
            </tr>
            <c:if test="${orderinfo.isonlinepay eq 1}">

                <tr>
                    <td class="cols_1">线上余额支付：</td>
                    <td class="cols_2">${orderinfo.payinfo.onlineamount}元
                    </td>
                    <c:if test="${orderinfo.ispaycoin eq 1}">
                        <td class="cols_3">线上卓币支付：</td>
                        <td class="cols_4">${orderinfo.payinfo.coinamount}币</td>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 0}">
                        <td class="cols_3"></td>
                        <td class="cols_4"></td>
                    </c:if>
                </tr>
                <tr>
                    <td class="cols_1">是否预付：</td>
                    <td class="cols_2">${fns:getDictLabel(orderinfo.isprepay, 'order_isprepay', '')}
                    </td>
                    <c:if test="${orderinfo.ispaycoin eq 1}">
                        <td class="cols_3">卓币是否预付：</td>
                        <td class="cols_4">${fns:getDictLabel(orderinfo.isprecoin, 'order_isprepay', '')}</td>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 0}">
                        <td class="cols_3"></td>
                        <td class="cols_4"></td>
                    </c:if>
                </tr>

                <tr>
                    <c:if test="${orderinfo.isprepay eq 1}">
                        <td class="cols_1">预付：</td>
                        <td class="cols_2">${orderinfo.payinfo.preamount}元
                        </td>
                    </c:if>
                    <c:if test="${orderinfo.isprepay eq 0}">
                        <td class="cols_1"></td>
                        <td class="cols_2"></td>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 1}">
                        <td class="cols_3">卓币预付：</td>
                        <td class="cols_4">${orderinfo.payinfo.coinpreamount}币</td>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 0}">
                        <td class="cols_3"></td>
                        <td class="cols_4"></td>
                    </c:if>
                </tr>

                <tr>
                    <c:if test="${orderinfo.isprepay eq 1}">
                        <td class="cols_1">余款运费：</td>
                        <td class="cols_2">${orderinfo.payinfo.actualamount}元</td>
                    </c:if>
                    <c:if test="${orderinfo.isprepay eq 0}">
                        <td class="cols_1"></td>
                        <td class="cols_2"></td>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 1}">
                        <c:if test="${orderinfo.isprecoin eq 1}">
                            <td class="cols_3">卓币余款运费：</td>
                            <td class="cols_4">${orderinfo.payinfo.coinactualpay}币</td>
                        </c:if>
                        <c:if test="${orderinfo.isprecoin eq 0}">
                            <td class="cols_3"></td>
                            <td class="cols_4"></td>
                        </c:if>
                    </c:if>
                    <c:if test="${orderinfo.ispaycoin eq 0}">
                        <td class="cols_3"></td>
                        <td class="cols_4"></td>
                    </c:if>
                </tr>

            </c:if>

        </table>
        </p>
    </div>--%>
    <div class="loading_lock"><img src="${ctxStatic }/images/loading.gif">
        <p>等待中</p></div>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.js"></script>
    <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
    <script>
        $(function () {
            var order_id = "${orderinfo.id}";
            $("#btn-warning").click(function () {
                $.MsgBox.Confirm("交易提示", "是否确认运输完成?", function () {
                    $.ajax({
                        url: "${wlpt}/wlpt/trade/endOrder",
                        data: {
                            id: order_id
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            $.MsgBox.Alert("交易提示", data.message);
                            if (data.state == 1) {
                                window.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true"
                            }
                        }
                    });
                }, function () {
                    $(".loading_lock").hide();
                });

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
