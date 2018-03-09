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
                    <h4 class="panel-heading ">完成交易</h4>
                </div>
                <form id="inputForm" class="form-horizontal">
                    <div class="panel-body">
                        <div class="col-sm-8 form-horizontal">
                            <!--<h4 class="text-center">运单号：<strong class="orange">YD2017022531660012</strong></h4>-->
                            <!--<div class="col-sm-12">-->
                            <!--<div class="col-sm-4 text-center">总运费：6115.24元</div>-->
                            <!--<div class="col-sm-4 text-center">线上支付：<span class="green">1000.00元</span></div>-->
                            <!--<div class="col-sm-4 text-center">待付：<span class="red">1000.00元</span></div>-->
                            <table class="table table-bordered table-border-bot">
                                <tbody>
                                <tr>
                                    <td colspan="${orderinfo.isonlinepay eq 1? (orderinfo.isprepay eq 1 ? 10 : 8):4}"
                                        class="text-center">运单号：<strong
                                            class="orange">${orderinfo.orderno}</strong>
                                    </td>
                                </tr>
                                 <tr>

                                     <c:if test="${orderinfo.railFlag eq 1}">
                                        <td class="text-right">定位车辆次数：</td>
                                        <td class="text-left">${orderinfo.locCount}</td>
                                    </c:if>
                                    <c:if test="${orderinfo.railFlag eq 1}">
                                        <td class="text-right">定位总价：</td>
                                        <td class="text-left" id="locPrice"></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <c:if test="${orderinfo.railFlag eq 1}">
                                        <td class="text-right">轨迹次数：</td>
                                        <td class="text-left">${orderinfo.trailCount}</td>
                                    </c:if>
                                    <c:if test="${orderinfo.railFlag eq 1}">
                                        <td class="text-right">轨迹总价：</td>
                                        <td class="text-left" id="trailPrice"></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <td class="text-right">总运费：</td>
                                    <td class="text-left">${orderinfo.totalcost}元</td>
                                    <c:if test="${orderinfo.isonlinepay eq 1}">
                                        <td class="text-right">线上支付：</td>
                                        <td class="text-left">${orderinfo.payinfo.onlineamount}元</td>
                                    </c:if>
                                    <td class="text-right">线下支付：</td>
                                    <td class="text-left">${orderinfo.payinfo.lineamount}</td>
                                </tr>
                                <c:if test="${orderinfo.isonlinepay eq 1}">
                                    <tr>
                                        <c:if test="${orderinfo.isprepay eq 1}">
                                            <td class="text-right">已线上预付：</td>
                                            <td class="text-left">${orderinfo.payinfo.preamount}元</td>
                                        </c:if>
                                        <td class="text-right">待付：</td>
                                        <td class="text-left">${orderinfo.payinfo.actualamount}元</td>
                                        <td class="text-right"></td>
                                        <td class="text-left"></td>
                                    </tr>
                                </c:if>
                                <c:if test="${orderinfo.ispaycoin eq 1}">
                                    <tr>
                                        <td class="text-right">卓币支付：</td>
                                        <td class="text-left">${orderinfo.payinfo.coinamount}币</td>
                                        <c:if test="${orderinfo.isprecoin eq 1}">
                                            <td class="text-right">已卓币预付：</td>
                                            <td class="text-left">${orderinfo.payinfo.coinpreamount}</td>
                                        </c:if>
                                        <td class="text-right">待付：</td>
                                        <td class="text-left">${orderinfo.payinfo.coinactualpay}币</td>
                                        <c:if test="${orderinfo.isprecoin ne 1}">
                                            <td></td>
                                            <td></td>
                                        </c:if>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </c:if>

                                <tr>
                                    <td class="text-center form-horizontal" colspan="10">
                                        <div class="col-sm-5 text-left form-group">
                                            <input id="cashPwd" name="cashPwd" class="form-control"
                                                   data-bv-trigger="keyup" type="password"
                                                   data-bv-notempty-message="请输入支付密码"
                                                   placeholder="请输入支付密码">
                                        </div>
                                        <c:if test="${curUser.ischild}">
                                            <p class="num_red">操作提示:业务员无权限完成此操作</p>
                                        </c:if>
                                    </td>

                                </tr>

                                <tr>
                                    <td colspan="10" class="text-center" style="border:none;">
                                        <c:choose>
                                            <c:when test="${curUser.ischild}">
                                                <c:if test="${curUser.childUser.role.enname eq 'U_financial'}">
                                                    <button class="btn btn-success mt-10" style="width:30%;"
                                                            type="button"
                                                            id="btn-warning">确认运输完成
                                                    </button>
                                                </c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-success  mt-10" style="width:30%;" type="button"
                                                        id="btn-warning">确认运输完成
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>

                                </tbody>
                            </table>
                            <!--</div>-->
                        </div>
                        <div class="col-sm-4"
                             style="border-left: 1px solid #eff2f7;width: 27%;margin-left: 3%;padding-left:3%;padding-top:45px;padding-bottom:50px;">
                            <p><strong>温馨提示：</strong></p>
                            <p>确认运输完成，即可完成订单。</p>
                            <p>请您在<span class="red">12小时内</span>确认运输完成 </p>
                        </div>
                    </div>
                    <%-- <div id="loading_lock" class="loading_lock" style="display: none;text-align: center;">
                        <img src="${ctxStatic }/images/loading.gif">
                        <p>等待中</p>
                    </div> --%>
                </form>
            </div>

        </div>
    </div>
</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    $(function () {
        var order_id = "${orderinfo.id}";
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
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

        $("#btn-warning").click(function () {
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                $.MsgBox.Confirm("交易提示", "是否确认运输完成?", function () {
                	$("#maskloading" , parent.document).show();
                    $.ajax({
                        url: "${wlpt}/wlpt/trade/endOrder",
                        data: {
                            id: order_id
                        },
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                        	$("#maskloading" , parent.document).hide();
                            $.MsgBox.Alert("交易提示", data.message);
                            if (data.state == 1) {
                                window.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true"
                            }
                        }
                    });
                }, function () {
                	$("#maskloading" , parent.document).hide();
                });
            }
        });
    });
</script>
<script type="text/javascript">
	$(document).ready(
		function(){
			var trailCount = ${orderinfo.trailCount};
			var trailPrice = ${fns:getMsgLabel('zjxl009', 'zjxl_port', '')};
			$('#trailPrice').html((trailCount*trailPrice)+"元");
			var locCount = ${orderinfo.locCount};
			var locPrice = ${fns:getMsgLabel('zjxl006', 'zjxl_port', '')};
			$('#locPrice').html((locCount*locPrice)+"元");
	});
</script>
</body>
</html>
