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
                                        <td class="text-right">定位价格：</td>
                                        <td class="text-left" id="locPrice"></td>
                                        <td class="text-right">轨迹查询次数：</td>
                                        <td class="text-left">${orderinfo.trailCount}</td>
                                        <td class="text-right">轨迹价格：</td>
                                        <td class="text-left" id="trailPrice"></td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <c:if test="${orderinfo.railFlag eq 1}">
                                        <td class="text-right">开通定位价格：</td>
                                        <td class="text-left" id="railPrice"></td>
                                        <td class="text-right">围栏开通总价:</td>
                                        <td class="text-left" id="sumPrice"></td>
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

                                </tbody>
                            </table>
                            <!--</div>-->
                        </div>
                        <div class="col-sm-4"
                             style="border-left: 1px solid #eff2f7;width: 27%;margin-left: 3%;padding-left:3%;padding-top:45px;padding-bottom:50px;">
                            <p><strong>温馨提示：</strong></p>
                            <p>确认运输完成，即可完成订单。</p>
                        </div>
                    </div>
                    
                </form>
            </div>

        </div>
    </div>
</div>
	<script type="text/javascript">
	$(document).ready(
			//围栏价格计算
		function(){
			var trailCount = ${orderinfo.trailCount};
			var trailPrice = ${fns:getMsgLabel('zjxl009', 'zjxl_port', '')};
			$('#trailPrice').html((trailCount*trailPrice)+"元");
			var locCount = ${orderinfo.locCount};
			var locPrice = ${fns:getMsgLabel('zjxl006', 'zjxl_port', '')};
			$('#locPrice').html((locCount*locPrice)+"元");
			var railPrice = ${fns:getMsgLabel('zjxl019', 'zjxl_port', '')}*2;
			var carPrice = ${fns:getMsgLabel('zjxl020', 'zjxl_port', '')}*2;
			$('#railPrice').html((railPrice+carPrice)+"元");
			$('#sumPrice').html((railPrice+carPrice+trailCount*trailPrice+locCount*locPrice)+"元");
	});
</script>
</body>
</html>
