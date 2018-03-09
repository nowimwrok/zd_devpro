<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>支付信息管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="/static/common/global.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            ///单选按钮第一个值选择
            $('input:radio:first').attr('checked', 'checked');
            ////是否线上支付
            $("input[name='isonlinepay']").click(function () {
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                    $("#onlinepay").slideDown("slow");
                } else {
                    $("#onlinepay").slideUp();
                }
            });
            ///是否预支付
            $("input[name='isprepay']").click(function(){
                var isprepay = $("input[name='isprepay']:checked").val();
                if (isprepay == 1) {
                    $("#prepaydiv").slideDown("slow");
                } else {
                    $("#prepaydiv").slideUp();
                }
            });

            ///线上支付比例
            $("input[name='payinfo.onlineamount']").change(function(){
                ///总运费
                var totalCost=$("#totalCost").html()*1;
                ///线上支付总金额
                var onlineAmount=$(this).val()*1;
                ///线下支付总金额
                var lineAmount=totalCost-onlineAmount;
                //$("#onlineamount").html(onlineAmount);
                $("#lineamount").html(lineAmount);
            });

            ///线上预支付比列
            $("input[name='payinfo.preraio']").click(function(){

                //线上预支付比列
                var preratio = $("input[name='payinfo.preraio']:checked").val();
                //线上预支付总运费
                var onlineAmount=$("input[name='payinfo.onlineamount']").val()*1;
                ///预支付总金额
                var preAmount=xround(preratio*onlineAmount,2);
                ///线下支付总金额
                var onlineBalance=onlineAmount-preAmount;
                $("#preamount").html(preAmount);
                $("#onlinebalance").html(onlineBalance);

            });

        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/wlpt/trade/tradePayinfo/">支付信息列表</a></li>
    <li class="active"><a href="${ctx}/wlpt/trade/tradePayinfo/form?id=${orderinfo.id}">支付信息<shiro:hasPermission
            name="wlpt:trade:tradePayinfo:edit">${not empty orderinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="wlpt:trade:tradePayinfo:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="orderinfo" action="${ctx}/wlpt/trade/orderinfo/createOrder" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="quoteinfo.id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">货物信息：</label>
        <div class="controls">
                ${quoteinfo.goods.goodsname }&nbsp;<br>
            货运量:${quoteinfo.goods.freightvolume}${quoteinfo.goods.freightunit}&nbsp;剩余:${quoteinfo.goods.residualvolume}${quoteinfo.goods.freightunit}

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">发货信息：</label>
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
    <div class="control-group">
        <label class="control-label">收货信息：</label>
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
    <div class="control-group">
        <label class="control-label">司机信息：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.driver}">
                    ${quoteinfo.driver.name}
                    &nbsp;${quoteinfo.driver.phone}
                    <br>
                </c:when>
            </c:choose>
                <%--<sys:treeselect id="driver" name="driver.id" value="${quoteinfo.driver.id}" labelName="${quoteinfo.driver.name}" labelValue="${quoteinfo.driver.name}"
                                title="用户" url="/wlpt/car/attach/getAttachlist" cssClass="" allowClear="true" notAllowSelectParent="true"/>
            --%></div>
    </div>
    <div class="control-group">
        <label class="control-label">报价车辆：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.car}">
                    ${quoteinfo.car.carnumber}
                    &nbsp;${quoteinfo.car.cartype}
                    &nbsp;${quoteinfo.car.carlength}米
                    &nbsp;${quoteinfo.car.loadweight}吨
                    <br>
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">报价：</label>
        <div class="controls">
            报价金额:${quoteinfo.ooferprice}元
            报价吨位:${quoteinfo.oddloadweight}${quoteinfo.goods.freightunit}
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">总运费：</label>
        <div class="controls">
            <label class="numbers" id="totalCost">${quoteinfo.ooferprice*quoteinfo.oddloadweight}</label> 元
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">是否线上支付：</label>
        <div class="controls">

            <form:radiobuttons id="isonlinepay" path="isonlinepay" items="${fns:getDictList('order_isonlinepay')}"
                               itemLabel="label" itemValue="value" htmlEscape="false"/>

        </div>
    </div>
    <div id="onlinepay" hidden="hidden">
        <div class="control-group">
            <label class="control-label">支付方式：</label>
            <div class="controls">
                <form:select path="payway" class="input-xlarge ">
                    <form:option value="0" label="余额支付"/>
                    <form:options items="${fns:getDictList('order_payway')}" itemLabel="label" itemValue="value"
                                  htmlEscape="false"/>
                </form:select>
            </div>
        </div>
       <%-- <div class="control-group">
            <label class="control-label">线上支付比例：</label>
            <div class="controls">
                <form:radiobuttons path="payinfo.onlineratio" items="${fns:getDictList('order_onlineratio')}" itemLabel="label" itemValue="value" htmlEscape="false" class="input-xlarge "/>

            </div>
        </div>--%>
        <div class="control-group">
            <label class="control-label">线上支付金额：</label>
            <div class="controls">
                <form:input path="payinfo.onlineamount" htmlEscape="false" class="input-xlarge "/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">线下支付金额：</label>
            <div class="controls">
                <label id="lineamount" class="lbl">0.00</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">是否预支付:：</label>
            <div class="controls">
                <form:radiobuttons id="isprepay" path="isprepay" items="${fns:getDictList('order_isprepay')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>

            </div>
        </div>
        <div id="prepaydiv" hidden="hidden">
            <div class="control-group">
                <label class="control-label">预支付比例：</label>
                <div class="controls">
                    <form:radiobuttons path="payinfo.preraio" items="${fns:getDictList('order_preratio')}" itemLabel="label" itemValue="value" htmlEscape="false" class="input-xlarge "/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">线上预支付金额：</label>
                <div class="controls">
                    <label id="preamount" class="lbl">0.00</label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">线上支付余款：</label>
                <div class="controls">
                    <label id="onlinebalance"  class="lbl ">0.00</label>
                </div>
            </div>
        </div>
    </div>


    <div class="form-actions">
        <shiro:hasPermission name="wlpt:trade:orderinfo:edit"><input id="btnSubmit" class="btn btn-primary"
                                                                        type="submit"
                                                                        value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>

</body>
</html>