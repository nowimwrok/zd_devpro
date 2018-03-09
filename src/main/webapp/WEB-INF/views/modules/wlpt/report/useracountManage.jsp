<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户钱包管理</title>
    <meta name="decorator" content="default"/>
    <style>
        th, td {
            text-align: center !important;
        }

        .select2-choice {
            width: 166px;
            text-align: center;
        }

        #loginName {
            width: 176px !important;
        }

        #phone {
            width: 176px !important;
        }

        .active:hover {
            cursor: pointer;
        }

        #contentTable {
            width: 3100px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnReset").click(function () {
                $("#j_user").val('');
                $("#j_id").val('');
                $("#j_accou").val('');
                $(".select2-choice").html("");
                $("#j_type").val('');
                $("#j_way").val('');
                $("#j_status").val('');
                $("#j_time").val('');
                $("#j_money").val('');
                $("#c_time").val('');
                location.href = "${ctx}/wlpt/consume/useraccount/balanceVo";
            });
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/wlpt/consume/useraccount/balanceVo");
            $("#searchForm").submit();
            return false;
        }
        $(document)
                .ready(
                        function () {
                            $("#btnExport")
                                    .click(
                                            function () {
                                                top.$.jBox
                                                        .confirm(
                                                                "确认要导出钱包数据吗？",
                                                                "系统提示",
                                                                function (v, h, f) {
                                                                    if (v == "ok") {
                                                                        $(
                                                                                "#searchForm")
                                                                                .attr(
                                                                                        "action",
                                                                                        "${ctx}/wlpt/consume/useraccount/balanceVoExport");
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
                            $("#btnSubmit")
                                    .click(
                                            function () {
                                                $("#searchForm")
                                                        .attr("action",
                                                                "${ctx}/wlpt/consume/useraccount/balanceVo");
                                                $("#searchForm").submit();
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
                        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/consume/useraccount/balanceVo">账户钱包列表</a></li>
    <li><a href="${ctx}/wlpt/consume/useraccount/detail" title="查看所有交易">账户交易详情</a></li>
</ul>
<form:form id="searchForm" modelAttribute="account"
           action="${ctx}/wlpt/consume/useraccount/balanceVo?tabPageId=jerichotabiframe_62"
           method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden"
           value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>登录名：</label> <form:input path="user.loginName"
                                            id="loginName"/></li>
        <li><label>用户角色：</label> <form:select path="user.role.name">
            <form:option value="" label="全部"/>
            <form:option value="车主" label="车主"/>
            <form:option value="货主" label="货主"/>
            <form:option value="物流企业" label="物流企业"/>

        </form:select></li>
        <li><label>手机号码：</label> <form:input path="user.phone"
                                             id="phone"/></li>
        <li class="btns" style="float: right;"><input id="btnSubmit"
                                                      class="btn btn-primary" type="button" value="查询"/><input
                type="button" id="btnReset" class="btn btn-primary" value="重置"/> <input
                id="btnExport" class="btn btn-primary" type="button" value="导出"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable"
       class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th rowspan="2" class="center" style="vertical-align: middle">序号</th>
        <th colspan="3" class="center" style="vertical-align: middle">用户信息</th>
        <th colspan="5" class="center ">帐户钱包</th>
        <th colspan="8" class="center ">运单模块</th>
        <th colspan="4" class="center ">招标模块</th>
        <th colspan="2" class="center ">转账</th>
        <th colspan="3" class="center ">提现(现提现)</th>
        <th colspan="2" class="center ">商城</th>
        <th colspan="3" class="center ">其他</th>
        <!-- <th colspan="2" class="center ">活动</th> -->
    </tr>
    <tr>
        <!-- 账户信息 -->
        <th>角色</th>
        <th>用户名</th>
        <th>手机号码</th>
        <!--  账户钱包 -->
        <th>账户余额</th>
        <th>可用账户余额</th>
        <th>担保金</th>
        <th>冻结资金</th>
        <th>充值</th>
        <!-- 运费结算 -->
        <th>现有运费冻结</th>
        <th>累计运费冻结</th>
        <th>运费预付</th>
        <th>运费尾付</th>
        <th>运单取消退款</th>
        <th>运费预收</th>
        <th>运费尾收</th>
        <th>争议退费</th>

        <!--招标模块-->
        <th>竞标保证金冻结</th>
        <th>竞标保证金退款</th>
        <th>结算支出</th>
        <th>结算收入</th>

        <!-- 转帐 -->
        <th>转账支出</th>
        <th>转账收入</th>
        <!--提现-->
        <th>提现冻结</th>
        <th>提现成功</th>
        <th>提现失败</th>
        <!--商城-->
        <th>消费支出</th>
        <th>消费收入</th>
        <!--  其他 -->
        <th>保证金冻结</th>
        <th>缴费支出</th>
        <th>缴费收入</th>
		<!-- 活动 -->
		<!-- <th>收到赠送油气</th>
		<th>赠送油气</th> -->
		
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="account" varStatus="step_status">
        <tr>
            <td>${step_status.index+1 }</td>
                <%--  <td>user.
                        ${user.id} </a> </td> --%>
            <td>${account.user.role.name }</td>
            <td><a
                    href="${ctx}/wlpt/consume/useraccount/detail?ismemberAccount=2&id=${account.user.id}"
                    target="_self"> ${account.user.loginName} </a></td>
            <td>${account.user.phone}</td>

            <td>
                <fmt:formatNumber value="${account.webbalance != null ? account.webbalance:0.0}" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td>${account.user.userPurse.availablebalance != null ? account.user.userPurse.availablebalance:0.0 }</td>
            <td>${account.user.userPurse.guaranteemone != null ? account.user.userPurse.guaranteemone:0.0 }</td>
            <td>${account.user.userPurse.freezemoney != null ? account.user.userPurse.freezemoney:0.0 }</td>
            <td><%--${account.balanace }--%>
                <fmt:formatNumber value="${account.balanace }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 运单交易 -->
            
            <td><%--${account.newforzenonline }--%>
                <fmt:formatNumber value="${account.newforzenonline }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.forzenonline }--%>
                <fmt:formatNumber value="${account.forzenonline }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.paypremoney }--%>
                <fmt:formatNumber value="${account.paypremoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.payonlienmoney }--%>
                <fmt:formatNumber value="${account.payonlienmoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.returnforzen }--%>
                <fmt:formatNumber value="${account.returnforzen }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.getpremoney }--%>
                <fmt:formatNumber value="${account.getpremoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.getonlinemoney }--%>
                <fmt:formatNumber value="${account.getonlinemoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.disputemoneyreturn }--%>
                <fmt:formatNumber value="${account.disputemoneyreturn }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 招标模块 -->
            <td><%--${account.bidingpay }--%>
                <fmt:formatNumber value="${account.bidingpay }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.bidingreturn }--%>
                <fmt:formatNumber value="${account.bidingreturn }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <!-- 招标结算 -->
            <td><%--${account.settlepay }--%>
                <fmt:formatNumber value="${account.settlepay }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.getsettle }--%>
                <fmt:formatNumber value="${account.getsettle }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 转账 -->
            <td>
                <fmt:formatNumber value="${account.accounttransfer }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

                <%-- <td>${account.accounttransfer }</td>--%>
            <td><%--${account.receivedtransfer }--%>
                <fmt:formatNumber value="${account.receivedtransfer }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 提现 -->
            <td><%--${account.cashmoney }--%>
                <fmt:formatNumber value="${account.cashmoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.getcashmoney }--%>
                <fmt:formatNumber value="${account.getcashmoney }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.cashmoneyreturn }--%>
                <fmt:formatNumber value="${account.cashmoneyreturn }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 商城 -->
            <td><fmt:formatNumber value="${account.coinrecharge }" type="Double" pattern="0.00"></fmt:formatNumber></td>
            <td><%--${account.getcoinconsume }--%>
                <fmt:formatNumber value="${account.getcoinconsume }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>

            <!-- 其他 -->
            <td><%--${account.guenalanace }--%>
                <fmt:formatNumber value="${account.guenalanace }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.printpay }--%>
                <fmt:formatNumber value="${account.printpay }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td><%--${account.getprintpay }--%>
                <fmt:formatNumber value="${account.getprintpay }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
			<!-- 活动 -->            
			<%-- <td>${account.getprintpay }
                <fmt:formatNumber value="${account.paypetrolgrant }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td>
            <td>${account.getprintpay }
                <fmt:formatNumber value="${account.petrolgrant }" type="Double"
                                  pattern="0.00"></fmt:formatNumber>
            </td> --%>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>