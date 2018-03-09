<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>运单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/trade/orderinfo/">运单列表</a></li>
    <shiro:hasPermission name="wlpt:trade:orderinfo:edit">
        <li><a href="${ctx}/wlpt/trade/orderinfo/form">运单添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="orderinfo" action="${ctx}/wlpt/trade/orderinfo/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">

        <li><label>车队：</label>
            <sys:treeselect id="buyer" name="buyer.id" value="${orderinfo.buyer.id}" labelName=""
                            labelValue="${orderinfo.buyer.name}"
                            title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true"
                            notAllowSelectParent="true"/>
        </li>
        <li><label>货主：</label>
            <sys:treeselect id="seller" name="seller.id" value="${orderinfo.seller.id}" labelName=""
                            labelValue="${orderinfo.seller.name}"
                            title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true"
                            notAllowSelectParent="true"/>
        </li>
        <li><label>运单号：</label>
            <form:input path="orderno" htmlEscape="false" maxlength="64" class="input-medium"/>
        </li>
        <li><label>运单状态：</label>
            <form:select path="orderstatus" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>是否评价：</label>
            <form:select path="iscomment" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('iscomment')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>总运费：</label>
            <form:input path="totalcost" htmlEscape="false" class="input-medium"/>
        </li>
        <li><label>是否线上支付：</label>
            <form:select path="isonlinepay" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('order_isonlinepay')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>是否预支付：</label>
            <form:select path="isprepay" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('order_isprepay')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>支付状态：</label>
            <form:select path="paystatus" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('order_paystatus')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>支付方式：</label>
            <form:select path="payway" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('order_payway')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>是否打印：</label>
            <form:radiobuttons path="isprint" items="${fns:getDictList('order_isprint')}" itemLabel="label"
                               itemValue="value" htmlEscape="false"/>
        </li>
        <li><label>是否发起争议：</label>
            <form:radiobuttons path="isdispute" items="${fns:getDictList('order_isdispute')}" itemLabel="label"
                               itemValue="value" htmlEscape="false"/>
        </li>
        <li><label>是否开启定位：</label>
            <form:radiobuttons path="islocated" items="${fns:getDictList('order_location')}" itemLabel="label"
                               itemValue="value" htmlEscape="false"/>
        </li>
        <li><label>创建时间：</label>
            <input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${orderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
        </li>
        <li><label>更新时间：</label>
            <input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${orderinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
        </li>
        <li><label>创建者：</label>
            <form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
        </li>
        <li><label>更新者：</label>
            <form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>运单号</th>
        <th>报价信息</th>
        <th>车队</th>
        <th>货主</th>
        <th>总运费</th>
        <th>支付信息</th>
        <th>运单状态</th>
        <th>是否预支付</th>
        <th>支付状态</th>
        <th>创建时间</th>
        <th>更新时间</th>
        <shiro:hasPermission name="wlpt:trade:orderinfo:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="orderinfo">
        <tr>
            <td>
                <a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">
                        ${orderinfo.orderno}
                </a>
            </td>
            <td><a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">
                货物名:${orderinfo.quoteinfo.goods.goodsname}<br>
                货物类型: ${orderinfo.quoteinfo.goods.gsoddtype}<br>
                报价吨位:${orderinfo.quoteinfo.oddloadweight} ${orderinfo.quoteinfo.goods.freightunit}<br>
                报价:${orderinfo.quoteinfo.ooferprice}元

            </a></td>
            <td>
                车主:${orderinfo.buyer.name}<br>
                手机:${orderinfo.buyer.phone}<br>
                车辆:${orderinfo.quoteinfo.car.carnumber}<br>
                车型:${orderinfo.quoteinfo.car.cartype}<br>
            </td>
            <td>
                货主:${orderinfo.seller.name}<br>
                手机:${orderinfo.seller.phone}
            </td>
            <td>
                    ${orderinfo.totalcost}
            </td>
            <td>
                    线上支付比例:${orderinfo.payinfo.onlineratio}
                    线上支付:${orderinfo.payinfo.onlineamount}元
                    线下支付:${orderinfo.payinfo.lineamount}元
            </td>
            <td>
                    ${fns:getDictLabel(orderinfo.orderstatus, 'order_status', '')}
            </td>
            <td>
                    ${fns:getDictLabel(orderinfo.isprepay, 'order_isprepay', '')}
            </td>
            <td>
                    ${fns:getDictLabel(orderinfo.paystatus, 'order_paystatus', '')}
            </td>
            <td>
                <fmt:formatDate value="${orderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                <fmt:formatDate value="${orderinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <shiro:hasPermission name="wlpt:trade:orderinfo:edit">
                <td>
                    <a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">修改</a>
                    <a href="${ctx}/wlpt/trade/orderinfo/delete?id=${orderinfo.id}"
                       onclick="return confirmx('确认要删除该运单吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>