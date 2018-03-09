<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>运单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document)
                .ready(
                        function () {
                            $("#btnExport")
                                    .click(
                                            function () {
                                                top.$.jBox
                                                        .confirm(
                                                                "确认要导出运单数据吗？",
                                                                "系统提示",
                                                                function (v, h, f) {
                                                                    if (v == "ok") {
                                                                        $(
                                                                                "#searchForm")
                                                                                .attr(
                                                                                        "action",
                                                                                        "${ctx}/wlpt/user/userTradeOrder/export");
                                                                        $(
                                                                                "#searchForm")
                                                                                .submit();
                                                                    }
                                                                },
                                                                {
                                                                    buttonsFocus: 1
                                                                });
                                                top.$('.jbox-body .jbox-icon').css(
                                                        'top', '55px');
                                            });
                            $("#btnImport")
                                    .click(
                                            function () {
                                                $
                                                        .jBox(
                                                                $("#importBox")
                                                                        .html(),
                                                                {
                                                                    title: "导入数据",
                                                                    buttons: {
                                                                        "关闭": true
                                                                    },
                                                                    bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"
                                                                });
                                            });
                            $("#btnSubmit")
                                    .click(
                                            function () {
                                                $("#searchForm")
                                                        .attr("action",
                                                                "${ctx}/wlpt/user/userTradeOrder/list");
                                                $("#searchForm").submit();
                                            });

                        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/wlpt/user/userTradeOrder/list");
            $("#searchForm").submit();
            return false;
        }
        /* function goPrint() {
            var orderId = "";
            $("input[name='ids']:checkbox").each(function () {
                if ($(this).attr("checked")) {
                    orderId = $(this).val();
                }
            });
            if (orderId == null || orderId == "") {
                alert("选择一条运单");
                return;
            }
            window.location.href = '${ctx}/wlpt/user/userTradeOrder/goPrint?ORDER_ID='
                    + orderId;
        } */
    </script>
    <style type="text/css">
        td, th {
            text-align: center !important;
        }

        .detail-row {
            display: none;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/user/userTradeOrder/list">运单信息列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="orderinfo"
           action="${ctx}/wlpt/user/userTradeOrder/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden"
           value="${page.pageSize}"/>
    <ul class="ul-form">

        <li><label>关键字：</label> <form:input path="searchinfo"
                                            htmlEscape="false" maxlength="50" class="input-medium"
                                            placeholder="运单号/用户名/手机/车牌号"/></li>
        
        
         <li><label>运单状态:</label> <form:select path="orderstatus"
                                              class="input-medium">
            <form:option value="" label="全部"/>
            <form:options items="${fns:getDictList('order_status')}"
                          itemLabel="label" itemValue="value" htmlEscape="false"/>
        </form:select></li>
        <li><label>货源类型:</label> <form:select
                path="quoteinfo.goods.gsoddtype" class="input-medium">
            <form:option value="" label="全部"/>
            <form:options items="${fns:getDictList('gsoddtype')}"
                          itemLabel="label" itemValue="value" htmlEscape="false"/>
        </form:select></li>
        <li><label>是否争议:</label> <form:select path="isdispute"
                                              class="input-medium">
            <form:option value="" label="全部"/>
            <form:options items="${fns:getDictList('yesorno')}"
                          itemLabel="label" itemValue="value" htmlEscape="false"/>
        </form:select></li>
        <li><label>打印缴费</label> <form:select path="isprint"
                                              class="input-medium">
            <form:option value='' label="全部"/>
            <form:options items="${fns:getDictList('order_isprint')}"
                          itemLabel="label" itemValue="value" htmlEscape="false"/>
        </form:select></li>
        
        <li><label>运单生成(开始):</label> <input
                name="quoteinfo.beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${orderinfo.quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="quoteinfo.endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${orderinfo.quoteinfo.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>
        
        <li><label>更新时间(开始):</label> <input
                name="quoteinfo.beginUpdateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${orderinfo.quoteinfo.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="quoteinfo.endUpdateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${orderinfo.quoteinfo.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>
        <li><label>支付时间(开始):</label> <input
                name="beginPayDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${orderinfo.beginPayDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endPayDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${orderinfo.endPayDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>

       
       
        

        <li class="btns" style="float: right;"><input id="btnSubmit"
                                                      class="btn btn-primary" type="button" value="查询"/><a
                class="btn btn-primary" href="${ctx}/wlpt/user/userTradeOrder/list">重置</a><input
                id="btnExport" class="btn btn-primary" type="button" value="导出"/><%--<a
                class="btn btn-primary" onclick="goPrint();">打印</a>--%>
            <!-- <input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li> -->
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable"
       class="table table-striped table-bordered table-condensed" style="">
    <thead>
    <tr>
        <th rowspan="2" colspan="2" class="center"
            style="vertical-align: middle;">序号
        </th>
        <th class="center" style="vertical-align: middle;">运单号</th>
        <th colspan="2" class="center" style="vertical-align: middle;">托运方</th>
        <th colspan="2" class="center" style="vertical-align: middle;">承运方</th>
        <th colspan="2" class="center" style="vertical-align: middle;">司机</th>
        <th colspan="7" class="center" style="vertical-align: middle;">运单信息</th>
        <th colspan="4" class="center" style="vertical-align: middle;">运单支付方式</th>
        <th colspan="6" class="center" style="vertical-align: middle;">金额</th>
        <th colspan="3" class="center" style="vertical-align: middle;">卓币</th>
        <th colspan="1" class="center" style="vertical-align: middle;">LBS定位费用</th>
        <th colspan="2" class="center" style="vertical-align: middle;">时间信息</th>
        <th colspan="1" class="center" style="vertical-align: middle;">操作</th>
    </tr>

    <tr>
        <th>运单号</th>

        <th>货主</th>
        <th>货主电话</th>
        <th style="width: 60px;">承运方</th>
        <th>承运方电话</th>
        <th>司机</th>
        <th>司机电话</th>
        <th style="width: 200px;">运单信息</th>
        <th>货物类型</th>
        <th>状态</th>
        <th style="">打印</th>
        <th>是否LBS定位</th>
        <th>是否争议</th>
        <th>争议类型</th>
        <th style="">支付方式</th>
        <th style="">支付类型</th>
        <th style="">预支付</th>
        <th style="width: 100px;">支付状态</th>
        <th>线上支付</th>
        <th>线下支付</th>
        <th>线上预支付</th>
        <th>线上余款支付</th>
        <th>线上争议</th>
        <th>实际支付</th>
        <th>线上支付</th>
        <th>线上预付</th>
        <th>线上实付</th>
        <th>金额</th>
        <th style="width: 100px;">下单时间</th>
        <th style="width: 100px;">更新时间</th>
        <th style="width: 100px;">查看</th>

    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="orderinfo"
               varStatus="status_list">
        <tr>
            <td class="center"><label><input type='checkbox'
                                             name='ids' value="${orderinfo.id}"/><span class="lbl"></span></label></td>
            <td>${status_list.index+1 }</td>
            <td><a onclick="detail(this);" title="点击查看交易明细">
                    ${orderinfo.orderno} </a></td>
            <td style="width: 60px;">${orderinfo.seller.loginName}</td>
            <td>${orderinfo.seller.phone}</td>
            <td style="width: 60px;">${orderinfo.buyer.loginName}</td>
            <td>${orderinfo.buyer.phone}</td>
            <td style="width: 60px;">${orderinfo.quoteinfo.driver.loginName}</td>
            <td>${orderinfo.quoteinfo.driver.phone}</td>

            <td style="width: 230px;">
                车牌号:${orderinfo.quoteinfo.car.carnumber};总运费:${orderinfo.totalcost};
                货物:${orderinfo.quoteinfo.oddloadweight}${orderinfo.quoteinfo.goods.freightunit}${orderinfo.quoteinfo.goods.goodsname};
                起终点:${orderinfo.quoteinfo.goods.shipAddress.city}至${orderinfo.quoteinfo.goods.consignAddress.city}
            </td>
            <td>${fns:getDictLabel(orderinfo.quoteinfo.goods.gsoddtype, 'gsoddtype', '')}</td>
            <td style="width: 100px;">
                    ${fns:getDictLabel(orderinfo.orderstatus, 'order_status', '')}</td>
            <td>${fns:getDictLabel(orderinfo.isprint, 'order_isprint', '')}</td>
            <td>${fns:getDictLabel(orderinfo.islocated, 'order_location', '')}</td>
            <td>${fns:getDictLabel(orderinfo.isdispute, 'yesorno', '')}</td>
            <td>${fns:getDictLabel(orderinfo.disputetype, 'disputetype', '')}</td>
            <td>${fns:getDictLabel(orderinfo.payway, 'order_payway', '')}</td>
            <td>${fns:getDictLabel(orderinfo.isonlinepay, 'order_isonlinepay', '')}</td>
            <td>${fns:getDictLabel(orderinfo.isprepay, 'order_isprepay', '')}</td>
            <td>${fns:getDictLabel(orderinfo.paystatus, 'order_paystatus', '')}</td>
            <td>${orderinfo.payinfo.onlineamount}</td>
            <td>${orderinfo.payinfo.lineamount}</td>
            <td>${orderinfo.orderstatus >=3 ? orderinfo.payinfo.preamount : 0.00}</td>
            <td>${orderinfo.orderstatus ==5 ? orderinfo.payinfo.onlinebalance : 0.00}</td>
            <td>${orderinfo.orderstatus >=3 ? orderinfo.payinfo.disputeamount : 0.00}</td>
            <td>${orderinfo.orderstatus ==5 ? orderinfo.payinfo.actualamount : 0.00}</td>
            <td>${orderinfo.payinfo.coinamount}</td>
            <td>${orderinfo.orderstatus >=3 ? orderinfo.payinfo.coinpreamount : 0.00}</td>
            <td>${orderinfo.orderstatus ==5 ? orderinfo.payinfo.coinactualpay : 0.00}</td>
            <td>${orderinfo.locationamount}</td>
            <td><fmt:formatDate value="${orderinfo.createDate}"
                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><fmt:formatDate value="${orderinfo.updateDate}"
                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
            <td><a href="${wlpt}/wlpt/trade/trade_detail?urltype=backurl&orderno=${orderinfo.orderno}">查看</a></td>
        </tr>
        <tr class="detail-row">
            <td colspan="27">
                <table class="table table-condensed">
                    <thead>
                    <th>交易编号</th>
                    <th>流出账户</th>
                    <th>流入账户</th>
                    <th>交易类型</th>
                    <th>交易方式</th>
                    <th>交易状态</th>
                    <th>交易金额</th>
                    <th>交易前金额</th>
                    <th>交易后金额</th>
                    <th>交易时间</th>
                    <th>更新时间</th>
                    <th>明细</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderinfo.list}" var="consumerecod">
                        <tr>
                            <td>${consumerecod.consumecode}</td>
                            <td>${consumerecod.account.loginName}</td>
                            <td>${consumerecod.target.loginName}</td>
                            <td>${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}</td>
                            <td>${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}</td>
                            <td>${fns:getDictLabel(consumerecod.consumestatus,'consume_status', '')}</td>
                            <td>${consumerecod.consumemony}</td>
                            <td>${consumerecod.beforemony}</td>
                            <td>${consumerecod.aftermony}</td>
                            <td><fmt:formatDate value="${consumerecod.createDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td><fmt:formatDate value="${consumerecod.updateDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${consumerecod.remarks}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<script type="text/javascript">
    function detail(e) {
        $(e).closest('tr').next().toggleClass('detail-row');
    }
</script>
</body>
</html>