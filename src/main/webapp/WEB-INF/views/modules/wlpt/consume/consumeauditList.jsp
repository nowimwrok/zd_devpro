<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户充值管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnReset").click(function () {
                $("#userName").val("");
                $(".select2-choice").html("");
                $("#type").val("");
                $("#status").val("");
                $("#g_start").val("");
                $("#g_end").val("");
                $("#c_start").val("");
                $("#c_end").val("");
                location.href = "${ctx}/wlpt/consume/consumeaudit/list";
            });
            $("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出用户充值审核明细数据吗？","系统提示",function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/consume/consumeaudit/rechargeExport");
							$("#searchForm").submit();
						}
					},
					{
						buttonsFocus : 1
					});
				top.$('.jbox-body .jbox-icon').css('top', '55px');
			});
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">
        #contentTable th {
            text-align: center;
        }
		.detail-row {
            display: none;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/consume/consumeaudit/list">账户充值列表</a></li>
    <shiro:hasPermission name="wlpt:consume:consumeaudit:edit">
        <li><a href="${ctx}/wlpt/consume/consumeaudit/form">账户充值添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="consumeaudit" action="${ctx}/wlpt/consume/consumeaudit/list" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form" style="height:150px;">
        <li><label>交易用户：</label>
            <sys:treeselect id="user" name="user.id" value="${consumeaudit.user.id}" labelName="user.name"
                            labelValue="${consumeaudit.user.name}"
                            title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true"
                            notAllowSelectParent="true"/>
        </li>
        <li>
            <label>查询信息：</label>
            <input name="searchinfo" id="searchinfo" type="text" maxlength="20" placeholder="用户名"/>
        </li>
        <li>
            <label>交易金额：</label>
            <input name="consume.consumemony" id="consumemony" type="text" maxlength="20"/>
        </li>
        <li><label>审核状态：</label>
            <form:select path="auditstatus" id="status" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('consumeaudit_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>

        <li><label>创建时间(开始):</label>
            <input name="beginCreateDate" id="c_start" type="text" readonly="readonly" maxlength="20"
                   class="input-medium Wdate"
                   value="<fmt:formatDate value="${consumeaudit.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> -(结束)
            <input name="endCreateDate" id="c_end" type="text" readonly="readonly" maxlength="20"
                   class="input-medium Wdate"
                   value="<fmt:formatDate value="${consumeaudit.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>

        <%--<li><label>更新时间(开始):</label>
            <input name="beginUpdateDate" id="g_start" type="text" readonly="readonly" maxlength="20"
                   class="input-medium Wdate"
                   value="<fmt:formatDate value="${consumeaudit.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> -(结束)
            <input name="endUpdateDate" type="text" id="g_end" readonly="readonly" maxlength="20"
                   class="input-medium Wdate"
                   value="<fmt:formatDate value="${consumeaudit.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
        </li>--%>
        <li class="btns" style="float:right;">
        	<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
        	<input id="btnReset" class="btn btn-primary" type="button" value="重置">
        	<input id="btnExport" class="btn btn-primary" type="button" value="导出" />
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>编号</th>
        <th colspan="3">用户信息</th>

        <th colspan="3">充值信息</th>

        <th colspan="3">审核状态</th>
        <shiro:hasPermission name="wlpt:consume:consumeaudit:edit">
            <th rowspan="2">操作</th>
        </shiro:hasPermission>
    </tr>
    <tr>
        <th>消费编号</th>

        <th>用户名</th>
        <th>真实姓名</th>
        <th>手机号码</th>


        <th>充值前</th>
        <th>充值金额</th>
        <th>充值后</th>

        <th>审核状态</th>
        <th>充值时间</th>
        <th>更新者</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="consumeaudit">
        <tr>
            <td>
                <a href="${ctx}/wlpt/consume/consumeaudit/form?id=${consumeaudit.id}">
                        ${consumeaudit.consume.consumecode}
                </a>
            </td>
            <td><a href="${ctx}/wlpt/consume/consumeaudit/form?id=${consumeaudit.id}">
                    ${consumeaudit.user.loginName}
            </a></td>
            <td>
                    ${consumeaudit.user.name}
            </td>
            <td>
                    ${consumeaudit.user.phone}
            </td>


            <td>
                    ${consumeaudit.consume.beforemony}
            </td>
            <td>
                    ${consumeaudit.consume.consumemony}
            </td>
            <td>
                    ${consumeaudit.consume.aftermony}
            </td>


            <td>
                    <a onclick="detail(this);" title="点击查看交易明细">${fns:getDictLabel(consumeaudit.auditstatus, 'consumeaudit_status', '')}</a>
            </td>
                <%--  <td>
                         ${consumeaudit.createBy.loginName}
                 </td> --%>
            <td>
                <fmt:formatDate value="${consumeaudit.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                    ${consumeaudit.updateBy.loginName}
            </td>
            <%--<td>
                <fmt:formatDate value="${consumeaudit.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>--%>
            <shiro:hasPermission name="wlpt:consume:consumeaudit:edit">
                <td>
                    <c:if test="${consumeaudit.auditstatus eq 1}">
                        <a href="${ctx}/wlpt/consume/consumeaudit/form?id=${consumeaudit.id}">修改</a>
                    </c:if>

                    <a href="${ctx}/wlpt/consume/consumeaudit/toAudit?id=${consumeaudit.id}">审核</a>

                    <a href="${ctx}/wlpt/consume/consumeaudit/delete?id=${consumeaudit.id}"
                       onclick="return confirmx('确认要删除该账户充值吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
        <tr class="detail-row">
            <td colspan="11">
                <table class="table table-condensed">
                    <thead>
                    <th>处理用户</th>
					<th>处理时间</th>
					<th>充值类型</th>
					<th>处理状态</th>
					<th>交易编号</th>
					<th>交易金额</th>
					<th>备注</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${consumeaudit.list}" var="deallog">
                        <tr>
                            <td>
								${deallog.createBy.loginName}
							</td>
							<td>
								<fmt:formatDate value="${deallog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</td>
							<td>
								${fns:getDictLabel(deallog.dealtype, 'consumeaudit_type', '')}
							</td>
							<td>
								${fns:getDictLabel(deallog.consumeaudit.auditstatus, 'consumeaudit_status', '')}
							</td>
							<td>
								${deallog.consumeaudit.consume.consumecode}
							</td>
							<td>
								${deallog.consumeaudit.consume.consumemony}
							</td>
							<td>
								${deallog.remarks}
							</td>
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
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript">
$("#btnSubmit").click(function () {
	var isnul = true;
	if($("#consumemony").val()!=null&&$("#consumemony").val()!=''){
		isnul = isnul && $("#consumemony").valid({
            methods: "decimalTwo"
        });
	}
    if(isnul){
    	$("#searchForm").submit();
    }
});

function detail(e) {
    $(e).closest('tr').next().toggleClass('detail-row');
}
</script>
</body>
</html>