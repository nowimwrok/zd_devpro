<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn" ng-app="oPublishApp" ng-controller="oPublishCtrl">
<head>
    <title>支付信息管理</title>
    <!-- <meta name="decorator" content="default"/> -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script> --%>
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/common/jeesite.css">


    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">

    <style type="text/css">
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

        .regbt {
            width: 200px;
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
    </style>


</head>
<body>
<form:form id="inputForm" modelAttribute="orderinfo" action="${wlpt}/wlpt/trade/createOrder" method="post"
           class="form-horizontal">
    <div class="content_wrap">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">生成</span><span
                class="title_orange">运单</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>

        <form:hidden path="id"/>
        <form:hidden path="quoteinfo.id"/>
        <form:hidden path="quoteinfo.car.carnumber"/>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">货物信息：</label>
            <div class="controls">
                    ${quoteinfo.goods.goodsname }&nbsp;<br>
                货运量:${quoteinfo.goods.freightvolume}${quoteinfo.goods.freightunit}&nbsp;剩余:${quoteinfo.goods.residualvolume}${quoteinfo.goods.freightunit}
                <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 }">
                &nbsp;<br>
                是否投保:${fns:getDictLabel(quoteinfo.goods.isinsur,'yes_no','')}&nbsp;&nbsp;&nbsp;保单支付方:${fns:getDictLabel(quoteinfo.goods.paypeople,'insur_paypeople','')}
				</c:if>
            </div>
        </div>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">发货信息：</label>
            <div class="controls">
                <c:choose>
                    <c:when test="${not empty quoteinfo.goods.id}">
                        ${quoteinfo.goods.shipAddress.province}${quoteinfo.goods.shipAddress.city}${quoteinfo.goods.shipAddress.district}
                        &nbsp;${quoteinfo.goods.shipAddress.linkman}
                        &nbsp;${quoteinfo.goods.shipAddress.linkmobile}
                        &nbsp;${quoteinfo.goods.shipAddress.linkcompany}
                        &nbsp;${quoteinfo.goods.shipAddress.linktelphone}
                        &nbsp;${quoteinfo.goods.shipAddress.linkemail}
                    </c:when>
                </c:choose>
            </div>
        </div>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">收货信息：</label>
            <div class="controls">
                <c:choose>
                    <c:when test="${not empty quoteinfo.goods.id}">
                        ${quoteinfo.goods.consignAddress.province}${quoteinfo.goods.consignAddress.city}${quoteinfo.goods.consignAddress.district}
                        &nbsp;${quoteinfo.goods.consignAddress.linkman}
                        &nbsp;${quoteinfo.goods.consignAddress.linkmobile}
                        &nbsp;${quoteinfo.goods.consignAddress.linkcompany}
                        &nbsp;${quoteinfo.goods.consignAddress.linktelphone}
                        &nbsp;${quoteinfo.goods.consignAddress.linkemail}
                    </c:when>
                </c:choose>
            </div>
        </div>
        <c:choose>
           <c:when test="${not empty quoteinfo.driver}">
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">司机信息：</label>
            <div class="controls">
                
                        ${quoteinfo.driver.name}
                        &nbsp;${quoteinfo.driver.phone}
                        <br>
                   
            </div>
        </div>
           </c:when>
        </c:choose>
        <c:choose>
              <c:when test="${not empty quoteinfo.car and not empty quoteinfo.car.id}">
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">报价车辆：</label>
            <div class="controls">
                
                        <input id="carnumber" value="${quoteinfo.car.carnumber}" type="hidden"/>
                        ${quoteinfo.car.carnumber}
                        &nbsp;${quoteinfo.car.cartype}
                        &nbsp;${quoteinfo.car.carlength}米
                        &nbsp;${quoteinfo.car.loadweight}吨
                        <br>
                    
            </div>
        </div>
        </c:when>
        </c:choose>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">报价金额：</label>
            <div class="controls">
                    ${quoteinfo.ooferprice}元
            </div>
        </div>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;"> 报价吨位：</label>
            <div class="controls">
                <form:hidden path="quoteinfo.blinfoList"/>
                <input type="number" style="margin: 5px;" min="0" max="${quoteinfo.goods.residualvolume}"
                       readonly="true" id="actload" value="${quoteinfo.oddloadweight}" ng-model="actload"
                       name="quoteinfo.actload" class="input-xlarge "/>${quoteinfo.goods.freightunit}
            </div>
        </div>

        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">总运费：</label>
            <div class="controls">
                <input id="total" value="${quoteinfo.ooferprice*quoteinfo.oddloadweight}" type="hidden"/>
                <label class="numbers" id="totalCost">0.00</label> 元
            </div>
        </div>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">重新配载：</label>
            <div class="controls">
                <form:radiobuttons id="isreload" path="quoteinfo.isreload" items="${fns:getDictList('order_isprepay')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
            </div>
        </div>
        <div class="control-group" style="border-bottom: 0;">
            <label class="control-label" style="width: 200px;">是否线上支付：</label>
            <div class="controls">

                <form:radiobuttons id="isonlinepay" path="isonlinepay" items="${fns:getDictList('order_isonlinepay')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>

            </div>
        </div>
        <div id="onlinepay" hidden="hidden">
            <div style="height: 190px;">
                <!-- 余额支付 -->
                <div style="width: 49%;float: left;">
                    <div class="control-group" style="border-bottom: 0;">
                        <label class="control-label" style="width: 200px;">支付方式：</label>
                        <div class="controls">
                        <c:choose>
                        <c:when test="${user.memberId!=null&&user.memberId!=''}">
                        <form:radiobuttons id="payway" path="payway"
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
                        <label class="control-label" style="width: 200px;">线上支付金额：</label>
                        <div class="controls" id="online">
                            <form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}"
                                        id="onlineamount" path="payinfo.onlineamount" style="width:50%;"
                                        htmlEscape="false" class="input-xlarge "/>元
                        </div>
                    </div>
                    <div class="control-group" style="border-bottom: 0;">
                        <label class="control-label" style="width: 200px;">线下支付金额：</label>
                        <div class="controls">
                            <label id="lineamount">0.00</label>元
                        </div>
                    </div>
                    <div class="control-group" style="border-bottom: 0;">
                        <label class="control-label" style="width: 200px;">是否预支付：</label>
                        <div class="controls">
                            <form:radiobuttons id="isprepay" path="isprepay"
                                               items="${fns:getDictList('order_isprepay')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false"/>

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
                        <label class="control-label" style="width: 200px;">线上支付卓币：</label>
                        <div class="controls" id="online">
                            <form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}"
                                        id="coinamount" path="payinfo.coinamount" style="width:80%;" htmlEscape="false"
                                        class="input-xlarge "/>币
                        </div>
                    </div>
                    <div class="control-group" style="border-bottom: 0;">
                        <label class="control-label" style="width: 200px;"></label>
                        <div class="controls">
                            <label id="lineamount" class="lbl"></label>
                        </div>
                    </div>
                    <div class="control-group" style="border-bottom: 0;">
                        <label class="control-label" style="width: 200px;">是否预支付：</label>
                        <div class="controls">
                            <form:radiobuttons id="isprecoin" path="isprecoin"
                                               items="${fns:getDictList('order_isprepay')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false"/>

                        </div>
                    </div>
                </div>
            </div>
            <div id="prepaydiv" style="width:100%;">
                <!-- 余额预支付 -->
                <div style="width: 51%;float: left;height: 121px;">
                    <div hidden="hidden" id="prepay">
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 200px;">预支付比例：</label>
                            <div class="controls" id="pre">
                                <form:radiobuttons id="preraio" path="payinfo.preraio"
                                                   items="${fns:getDictList('order_preratio')}" itemLabel="label"
                                                   itemValue="value" htmlEscape="false" class="input-xlarge "/>
                            </div>
                        </div>
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 200px;">线上预支付金额：</label>
                            <div class="controls">
                                <label id="preamount">0.00</label>元
                            </div>
                        </div>
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 200px;">线上支付余款：</label>
                            <div class="controls">
                                <label id="onlinebalance">0.00</label>元
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 卓币预支付 -->
                <div style="width: 49%;float: left;height: 121px;">
                    <div hidden="hidden" id="precoin">
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 180px;">预支付比例：</label>
                            <div class="controls" id="coin">
                                <form:radiobuttons id="coinprepaio" path="payinfo.coinprepaio"
                                                   items="${fns:getDictList('order_preratio')}" itemLabel="label"
                                                   itemValue="value" htmlEscape="false" class="input-xlarge "/>
                            </div>
                        </div>
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 180px;">线上预支付卓币：</label>
                            <div class="controls">
                                <label id="coinpreamount">0.00</label>币
                            </div>
                        </div>
                        <div class="control-group" style="border-bottom: 0;">
                            <label class="control-label" style="width: 180px;">线上支付卓币：</label>
                            <div class="controls">
                                <label id="coinactualpay">0.00</label>币
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="control-group" style="border-bottom: 0;clear: both;">
            <label class="control-label" style="width: 200px;">支付密码：</label>
            <div class="controls">
                <input type="password" style="margin: 5px;letter-spacing: 10px;text-align: center;" 
                        id="password"
                       class="input-xlarge " placeholder="请输入支付密码"/>
            </div>
        </div>
        </div>
        <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif">
            <p>等待中</p></div>
        
        <div>
            <input id="btnSubmit" class="regbt" style="width: 100px;" type="button" ng-click="submit()" value="保 存"/>
        </div>
        <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 and quoteinfo.goods.paypeople ne 1}">
        <div style="margin-top: 20px;">
        	温馨提示：本次除运单费用外，另扣取<span style="color: red;font-weight: bold;">40</span>元保单费用！
        </div>
        </c:if>
    </div>

    <div class="content_wrap" id="order_info" hidden="hidden">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue"> 货物</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <!--  <form id="inputForm"> -->
        <label>货源吨位 </label>


        <c:if test="${quoteinfo.goods.gsoddtype==1}">
            <input type="text" style="margin: 5px;" id="freightvolume" ng-model="freightvolume" readonly
                   name="freightvolume"/>
        </c:if>
        <div class="loading"><img src="/static/images/loading.gif">
            <p>加载中</p></div>
        <div ng-if="${quoteinfo.goods.gsoddtype==1}">

            <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns
                 class="grid"></div>
        </div>
        <!-- <table class="user-infor">
            <tr>
                <td colspan=5>
                    <button type='button' class="btn btn-defalut btn-warning" id="btn-warning" ng-click="submit()">
                        保 存
                    </button>
                </td>
            </tr>
        </table> -->


    </div>
</form:form>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>

<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>

<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script type="text/javascript">

    $(document).ready(function () {
        var price = '${quoteinfo.ooferprice}';
        var odweig = '${quoteinfo.oddloadweight}'
        var total = (price * 1) * (odweig * 1);
        total = xround(total, 2);
        $("#totalCost").html(total);

        ////重新配载
        $("input[name='quoteinfo.isreload']").click(function () {
            var isreload = $("input[name='quoteinfo.isreload']:checked").val();
            if (isreload == 1) {
                <c:if test="${quoteinfo.goods.gsoddtype==2 or bidinfo.isupbl==0}">
                $("#actload").removeAttr("readonly");
                $("#actload").val('${quoteinfo.oddloadweight}');
                </c:if>
                <c:if test="${quoteinfo.goods.gsoddtype==1}">
                $("#order_info").slideDown("slow");
                $("#actload").val($("#freightvolume").val());
                <c:if test="${quoteinfo.goods.datasource==0}">
                if ($("#freightvolume").val() * 1 != 0) {
                    $("#actload").attr("readonly", "true");
                } else {
                    $("#actload").removeAttr("readonly");
                }
                </c:if>

                <c:if test="${quoteinfo.goods.datasource!=0}">
                $("#actload").attr("readonly", "true");
                </c:if>
                </c:if>

            } else {
                $("#order_info").slideUp();
                $("#actload").val('${quoteinfo.oddloadweight}');
                $("#actload").attr("readonly", "true");

            }
            $("#total").val(($("#actload").val() * 1) * '${quoteinfo.ooferprice}' * 1);
            total = $("#total").val() * 1;
            total = xround(total, 2);
            $("#totalCost").html(total);
            
            var isonline = $("input[name='isonlinepay']:checked").val();
            if (isonline == 1) {
            	setmount("#coinamount");
            } else {
                $("#onlinepay").slideUp();
                $("#lineamount").html("0.00");
                $("#onlineamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
                $("#prepay").hide();
                //卓币
                $("input[name='ispaycoin']").attr("checked", false);
                $("#paycoin").slideUp();
                $("#coinamount").val("");
                $("input[name='isprepay']").attr("checked", false);
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
                $("#precoin").hide();
            }
            
        });

        ///报价吨位
        $("input[name='quoteinfo.actload']").change(function () {
            var residualvolume = '${quoteinfo.goods.residualvolume}' * 1;
            var actload = $("#actload").val() * 1;

            if (residualvolume*1 < actload*1) {
                $("#actload").tips({
                    side: 3,
                    msg: '不能大于剩余载重',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#actload").val('${quoteinfo.oddloadweight}');
                return false;
            } else if (actload * 1 <= 0) {
                $("#actload").tips({
                    side: 3,
                    msg: '必须大于0',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#actload").val('${quoteinfo.oddloadweight}');
                return false;
            }
            actload = $("#actload").val() * 1;
            //重置运费
            $("#total").val((actload * 1) * ('${quoteinfo.ooferprice}' * 1));
            totalCost = $("#total").val() * 1;
            totalCost = xround(totalCost, 2);

            $("#totalCost").html(totalCost);

            var isnul = true;
            isnul = isnul && $("#onlineamount").valid({
                        methods: "decimal"
                    });
            if (!isnul) {
                $("#onlineamount").val("0");
            }
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            if (totalCost < onlineAmount) {
                $("#onlineamount").tips({
                    side: 3,
                    msg: '不能大于总运费',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#onlineamount").val("0");
            } else if (totalCost == onlineAmount) {
                $("#coinamount").val("0");
            } else if (onlineAmount < 0) {
                $("#onlineamount").tips({
                    side: 3,
                    msg: '不能小于0',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#onlineamount").val("0");
            }

			
            setmount("#onlineamount");

        });

        ///单选按钮第一个值选择
        //$('input:radio:first').attr('checked', 'checked');
        $("input[name='isonlinepay']:first").attr('checked', 'checked');
        $("input[name='payway']:first").attr('checked', 'checked');
        ///单选按钮第一个值选择
        $("input[name='quoteinfo.isreload']:last").attr('checked', 'checked');

        ////是否线上支付
        $("input[name='isonlinepay']").click(function () {
            var isonline = $("input[name='isonlinepay']:checked").val();
            if (isonline == 1) {
                $("#onlinepay").slideDown("slow");
            } else {
            	$("input[name='payway']").attr("checked", false);
                $("#onlinepay").slideUp();
                $("#lineamount").html("0.00");
                $("#onlineamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
                $("#prepay").hide();
                //卓币
                $("input[name='ispaycoin']").attr("checked", false);
                $("#paycoin").slideUp();
                $("#coinamount").val("");
                $("input[name='isprepay']").attr("checked", false);
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
                $("#precoin").hide();
            }
        });
        
        ////卓币支付
        $("input[name='ispaycoin']").click(function () {
            var isonline = $("input[name='ispaycoin']:checked").val();
            if (isonline == 1) {
                $("#paycoin").slideDown("slow");
            } else {
                $("#paycoin").slideUp();
                $("#coinamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
                $("#precoin").hide();
                setmount("#coinamount");
            }
        });

        ///余额是否预支付
        $("input[name='isprepay']").click(function () {
            var isprepay = $("input[name='isprepay']:checked").val();
            if (isprepay == 1) {
                // $("#prepaydiv").slideDown("slow");
                $("#prepay").slideDown("show");
                /* $("input[name='payinfo.preraio']:radio:first").attr('checked', 'checked'); */
            } else {
                //$("#prepaydiv").slideUp();
                $("#prepay").slideUp();
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
            }
        });

        ///卓币是否预支付
        $("input[name='isprecoin']").click(function () {
            var isprecoin = $("input[name='isprecoin']:checked").val();
            if (isprecoin == 1) {
                //$("#prepaydiv").slideDown("slow");
                $("#precoin").slideDown("show");
                /* $("input[name='payinfo.coinprepaio']:radio:first").attr('checked', 'checked'); */
            } else {
                //$("#prepaydiv").slideUp();
                $("#precoin").slideUp();
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
            }
        });

        ///线上支付
        $("input[name='payinfo.onlineamount']").change(function () {
            ///总运费
            var totalCost = $("#totalCost").html() * 1;
            var isnul = true;
            isnul = isnul && $("#onlineamount").valid({
                        methods: "decimal"
                    });
            if (!isnul) {
                $("#onlineamount").val("0");
            }
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            if (totalCost < onlineAmount) {
                $("#onlineamount").tips({
                    side: 3,
                    msg: '不能大于总运费',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#onlineamount").val("0");
            } else if (totalCost == onlineAmount) {
                $("#coinamount").val("0");
            } else if (onlineAmount < 0) {
                $("#onlineamount").tips({
                    side: 3,
                    msg: '不能小于0',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#onlineamount").val("0");
            }


            setmount("#onlineamount");

        });
        ///卓币
        $("input[name='payinfo.coinamount']").change(function () {
        	 var isonline = $("input[name='ispaycoin']:checked").val();
             if (isonline != 1) {
            	 return false;
             }
            ///总运费
            var totalCost = $("#totalCost").html() * 1;

            //卓币支付
            var isnul = true;
            isnul = isnul && $("#coinamount").valid({
                        methods: "decimal"
                    });
            if (!isnul) {
                $("#coinamount").val("0");
            }
            //卓币支付金额
            var coinamount = $("#coinamount").val() * 1;
            if (totalCost < coinamount) {
                $("#coinamount").tips({
                    side: 3,
                    msg: '不能大于总运费',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#coinamount").val("0");
            } else if (totalCost == coinamount) {
                $("#onlineamount").val("0");
            } else if (coinamount < 0) {
                $("#coinamount").tips({
                    side: 3,
                    msg: '线上支付卓币不能小于0',
                    bg: '#00A2E9',
                    time: 4
                });
                $("#coinamount").val("0");
            }

            setmount("#coinamount");

        });

        function setmount(type) {
            var isonline = $("input[name='ispaycoin']:checked").val();
            ///总运费
            var totalCost = $("#totalCost").html() * 1;
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            //卓币支付金额
            var coinamount = $("#coinamount").val() * 1;

            ///线下支付总金额
            var lineAmount = totalCost - onlineAmount - coinamount;
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
                var totalCost = $("#totalCost").html() * 1;
                ///线上支付总金额
                var onlineAmount = $("#onlineamount").val() * 1;
                //卓币支付金额
                var coinamount = $("#coinamount").val() * 1;

                ///线下支付总金额
                var lineAmount = totalCost - onlineAmount - coinamount;
                lineAmount = xround(lineAmount, 2);
                //$("#onlineamount").html(onlineAmount);
                $("#lineamount").html(lineAmount);
            }

            var isprepay = $("input[name='isprepay']:checked").val();
            if (isprepay == 1) {
                //线上预支付比列
                var preratio = $("input[name='payinfo.preraio']:checked").val();
                //线上支付总运费
                var onlineAmount = $("input[name='payinfo.onlineamount']").val() * 1;
                ///预支付总金额
                var preAmount = xround(preratio * onlineAmount, 2);
                ///线下支付总金额
                var onlineBalance = onlineAmount - preAmount;
                $("#preamount").html(xround(preAmount, 2));
                $("#onlinebalance").html(xround(onlineBalance, 2));
            }
            var isprecoin = $("input[name='isprecoin']:checked").val();
            if (isprecoin == 1) {
                //线上预支付比列
                var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
                //线上支付总运费
                var coinamount = $("input[name='payinfo.coinamount']").val() * 1;
                ///预支付总金额
                var preAmount = xround(coinprepaio * coinamount, 2);
                ///线下支付总金额
                var coinactualpay = coinamount - preAmount;
                $("#coinpreamount").html(xround(preAmount, 2));
                $("#coinactualpay").html(xround(coinactualpay, 2));
            }
        }

        ///线上预支付比列
        $("input[name='payinfo.preraio']").click(function () {
            //线上预支付比列
            var preratio = $("input[name='payinfo.preraio']:checked").val();
            //线上支付总运费
            var onlineAmount = $("input[name='payinfo.onlineamount']").val() * 1;
            ///预支付总金额
            var preAmount = xround(preratio * onlineAmount, 2);
            ///线下支付总金额
            var onlineBalance = onlineAmount - preAmount;
            $("#preamount").html(xround(preAmount, 2));
            $("#onlinebalance").html(xround(onlineBalance, 2));

        });

        ///卓币预支付比列
        $("input[name='payinfo.coinprepaio']").click(function () {
            //线上预支付比列
            var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
            //线上支付总运费
            var coinamount = $("input[name='payinfo.coinamount']").val() * 1;
            ///预支付总金额
            var preAmount = xround(coinprepaio * coinamount, 2);
            ///线下支付总金额
            var coinactualpay = coinamount - preAmount;
            $("#coinpreamount").html(xround(preAmount, 2));
            $("#coinactualpay").html(xround(coinactualpay, 2));

        });

    });
</script>

<script>

    $(".loading").hide();


    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    var app = angular.module('oPublishApp', ['ui.grid', 'ui.grid.selection', 'ui.grid.grouping', 'ui.grid.pagination', 'ui.grid.resizeColumns', 'ui.grid.autoResize']);
    app.controller('oPublishCtrl', ['$scope', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
        function ($scope, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {
            $scope.actload = ${quoteinfo.oddloadweight};


            <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">

            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.freightvolume = 0;


            $scope.gridOptions.onRegisterApi = function (grid, newObjects) {
                $scope.bgrid = grid;
                //行选中事件
                $scope.bgrid.selection.on.rowSelectionChanged($scope, function (row, event) {
                    <c:if test="${quoteinfo.goods.datasource==0}">
                    if ($scope.bgrid.selection.getSelectedCount() == 0) {
                        $("#actload").removeAttr("readonly");
                    } else {
                        $("#actload").attr("readonly", "true");
                    }
                    </c:if>
                    if (row.isSelected) {
                        var num = accAdd($scope.freightvolume, Number(row.entity.quantity));
                        $scope.freightvolume = num;
                        /* $scope.actload = num; */
                        $("#actload").val(num);
                        //重新计算运费
                        $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                    } else {
                        var num = accSub($scope.freightvolume, Number(row.entity.quantity));
                        $scope.freightvolume = num;
                        /* $scope.actload = num; */
                        $("#actload").val(num);
                        //重新计算运费
                        $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {
                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                            var num = accAdd($scope.freightvolume, Number(r.entity.quantity));

                            $scope.freightvolume = num;
                            /* $scope.actload = num; */
                            $("#actload").val(num);
                            //重新计算运费
                            $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                            total = $("#total").val() * 1;
                            total = xround(total, 2);
                            $("#totalCost").html(total);
                            <c:if test="${quoteinfo.goods.datasource==0}">
                            $("#actload").attr("readonly", "true");
                            </c:if>
                        });
                    } else {

                        $scope.freightvolume = 0;
                        $scope.actload = 0;
                        //重新计算运费
                        $("#total").val(0);
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                        <c:if test="${quoteinfo.goods.datasource==0}">
                        $("#actload").removeAttr("readonly");
                        </c:if>
                    }
                });
            };

            $scope.gridOptions.rowIdentity = function (row) {
                return row.id;
            };

            $scope.gridOptions.getRowIdentity = function (row) {
                return row.id;
            };


            $scope.gridOptions.importerDataAddCallback = function (grid, newObjects) {
                if (newObjects) {
                    $scope.callsPending--;
                    newObjects.forEach(function (row) {
                        row.registered = new Date(row.registered);
                        $scope.myData.push(row);
                    });
                }
            };


            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'contractno', displayName: '提货单号'},
                {name: 'namematerials', displayName: '品名材质'},
                {name: 'standard', displayName: '规格'},
                {name: 'width', displayName: '定尺\\板宽'},
                {
                    name: 'quantity',
                    displayName: '数量\\吨'
                },
                {name: 'batch', displayName: '批次号'},
                {name: 'address', displayName: '卸货地址'},
                {name: 'remarks', displayName: '备注'}
            ];

            $scope.callsPending = 0;

            $scope.refreshData = function () {
                $(".loading").show();
                $scope.myData = [];
                var datas = [];
                if ('${quoteinfo.goods.datasource}' * 1 == 0) {
                    datas = {
                        'searchinfo': '${user.id}',
                        'tradestatus': '0'
                    }
                } else {
                    datas = {
                        'goods.id': '${quoteinfo.goods.id}',
                        'tradestatus': '1'
                    }
                }
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: datas
                    }).success(function (data) {

                        $scope.callsPending--;
                        data.value.forEach(function (row) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        });
                        $(".loading").hide();
                    });
                }, 200, 1);

                var timeout = $timeout(function () {
                    $interval.cancel(sec);
                    $scope.left = '';
                }, 2000);

                $scope.$on('$destroy', function () {
                    $timeout.cancel(timeout);
                    $interval.cancel(sec);
                });
            };
            $scope.refreshData();
            </c:if>

            $scope.submit = function () {
                var isnul = true;
                var totalCost = $("#totalCost").html() * 1;
                var isreload = $("input[name='quoteinfo.isreload']:checked").val();
                //

                var residualvolume = '${quoteinfo.goods.residualvolume}' * 1;
                var actload = $("#actload").val() * 1;

                if (residualvolume < actload) {
                    $("#actload").tips({
                        side: 3,
                        msg: '不能大于剩余载重',
                        bg: '#00A2E9',
                        time: 4
                    });

                    return false;
                } else if (actload * 1 <= 0) {
                    $("#actload").tips({
                        side: 3,
                        msg: '必须大于0',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }
               if ($("input[name='quoteinfo.isreload']:checked").val() == 1) {
                    <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">
                    if ('${quoteinfo.goods.datasource}' * 1 != 0) {
                        if ($scope.bgrid.selection.getSelectedRows().length <= 0) {
                            $.MsgBox.Alert("提示", "提货单条数不能小于1条");
                            return false;
                        }
                    }
                    </c:if>
                }
                if ($("input[name='isonlinepay']:checked").val() == 1) {
                    isnul = isnul && $("#onlineamount").valid({
                                methods: "required|decimal"
                            });
                    
                    //卓币支付
                    if ($("input[name='ispaycoin']:checked").val() == 1) {
                        isnul = isnul && $("#coinamount").valid({
                                    methods: "required|decimal"
                                });
                    }
                    if ($("#onlineamount").val() * 1 <= 0) {
                        $("#onlineamount").tips({
                            side: 3,
                            msg: '请填写正确的线上支付金额',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }
                }else{
                	$("#coinamount").val("0");
                	$("#onlineamount").val("0");
                }
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                	isnul = isnul && $("#password").valid({
                    	methods: "required"  
                    });
                }
                
                if (!isnul) {
                    return false;
                }

                var totalmount = ($("#coinamount").val() * 1) + ($("#onlineamount").val() * 1)
                if (totalCost < totalmount) {
                    $("#btnSubmit").tips({
                        side: 3,
                        msg: '线上支付运费必须大于0',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                var totalonline = "${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";

                
                var isAccount = $("input[name='payway']:checked").val();
                if (isAccount == 0) {
                    //$("#precoin").slideDown("show");
                    totalonline="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
                } else {
                		var memberId="${user.memberId}";
                	    $.ajax({
                	            url: "${wlpt}/wlpt/consume/virtAcctList",
                	            dataType: 'json',
                	            data:{"memberId":memberId,"status":'1'},
                	            type: "post",
                	            async : false, ///同步请求传递
                	            success: function (data) {
                	               if(data.status==200){
                	            	   var slaveAccounts=data.body.records[0].slaveAccounts;
                	            	   for(i=0;i<slaveAccounts.length;i++){
                	            		   if(slaveAccounts[i].accountType==4){
                	            			   totalonline=slaveAccounts[i].availableBalance;
                	            		   }
                	            	   }
                	            	   
                	               }
                	            }
                	    });
                   }
                
                <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 and quoteinfo.goods.paypeople ne 1}">
                	totalonline=totalonline*1-40;
                </c:if>
                if ($("#onlineamount").val() * 1 > totalonline * 1) {
                    $("#onlineamount").tips({
                        side: 3,
                        msg: '可用余额不足',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
                }

                if (($("input[name='isprepay']:checked").val()) == 1) {
                    var pre = $("input[name='payinfo.preraio']:checked").val();
                    if (pre == undefined) {
                        $("#pre").tips({
                            side: 3,
                            msg: '请选择预支付比例',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }


                }
                var isonline = $("input[name='ispaycoin']:checked").val();
                if (isonline == 1) {
                    if ($("#coinamount").val() * 1 <= 0) {
                        $("#coinamount").tips({
                            side: 3,
                            msg: '线上支付卓币必须大于0',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }
                    var total = "${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}"
                    if ($("#coinamount").val() * 1 > total * 1) {
                        $("#coinamount").tips({
                            side: 3,
                            msg: '可用卓币不足',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }
                }
                if (($("input[name='isprecoin']:checked").val()) == 1) {
                    var coin = $("input[name='payinfo.coinprepaio']:checked").val();
                    if (coin == undefined) {
                        $("#coin").tips({
                            side: 3,
                            msg: '请选择卓币预支付比例',
                            bg: '#00A2E9',
                            time: 4
                        });
                        return false;
                    }
                }

                var istrue =true;
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                	//同步验证--验证提现密码是否正确
        			$.ajax({
        				url : "${ctx}/wlpt/user/vadChildCashPwd",
        				type : "POST",
        				data : {"cashPwd":$("#password").val(),"isSave":false},
        				async : false, ///同步请求传递
        				success : function(data) {
        					istrue = data;
        					if(!data){
        						$("#password").tips({
        							side : 3,
        							msg : '支付密码错误或未设置!',
        							bg : '#00A2E9',
        							time : 3
        						});
        					}
        				}
        			}); 
                }
    			
    			if (!istrue) {
    				return false;
    			}
                $(".loading_lock").show();
                var inputForm = $("#inputForm").serializeObject();
                if ($("input[name='quoteinfo.isreload']:checked").val() == 1) {
                    <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">
                    inputForm.blinfoList = angular.toJson($scope.bgrid.selection.getSelectedRows());
                    </c:if>
                }
                $.ajax({
                    url: "${wlpt}/wlpt/trade/createOrder",
                    dataType: 'json',
                    method: 'post',
                    data: inputForm,
                    cache: false,
                    success: function (data) {
                        if (data.value == 1) {
                        	top.$("#rightFrame").parent().prev().children("#accordion").children().eq(3).children(".submenu").css("display","none").children().removeClass("menuSelect");
                        	top.$("#rightFrame").parent().prev().children("#accordion").children().removeClass("open").eq(2).addClass("open").children(".submenu").css("display","block").children().addClass("menuSelect");
                            top.$("#rightFrame").prev().children(".top_left").children("#tabmu").html("/运单中心/我的运单");
                            var searchinfo = $("#carnumber").val();
                            if(searchinfo==undefined){
                            	searchinfo = "";
                            }
                            window.location.href = '${wlpt}/wlpt/trade/trade_list?searchinfo=' + searchinfo;              
                        } else if (data.value == 5) {
                            $("#btnSubmit").tips({
                                side: 3,
                                msg: '账户余额或卓币不足',
                                bg: '#00A2E9',
                                time: 4
                            });
                            $(".loading_lock").hide();
                        } else if (data.value == 19) {
                            $("#btnSubmit").tips({
                                side: 3,
                                msg: '应用正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时',
                                bg: '#00A2E9',
                                time: 4
                            });
                            $(".loading_lock").hide();
                        } else if (data.value == 3) {
                            $("#online").tips({
                                side: 3,
                                msg: '该报价已过期！',
                                bg: '#00A2E9',
                                time: 4
                            });
                            $(".loading_lock").hide();
                        } else {
                            $("#btnSubmit").tips({
                                side: 3,
                                msg: '信息缺失！！',
                                bg: '#00A2E9',
                                time: 4
                            });
                            $(".loading_lock").hide();
                        }
                    }
                });
            };

        }]);

</script>


<script>


    //加法函数，用来得到精确的加法结果
    //说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
    //调用：accAdd(arg1,arg2)
    //返回值：arg1加上arg2的精确结果
    function accAdd(arg1, arg2) {
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
        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m + arg2 * m) / m).toFixed(n);
    }


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


</script>

</body>
</html>