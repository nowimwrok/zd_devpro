<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>消息模版管理</title>
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
    <li class="active"><a href="${ctx}/sms/template/">消息模版列表</a></li>
    <shiro:hasPermission name="sms:smstemplate:edit">
        <li><a href="${ctx}/sms/template/form">消息模版添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="template" action="${ctx}/sms/template/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>模板名字：</label>
            <form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
        </li>
        <li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>模板名字</th>
        <th>编码</th>
        <th>模版内容</th>
        <th>描述</th>
        <th>备注</th>
        <th>更新时间</th>
        <shiro:hasPermission name="sms:smstemplate:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="template">
        <tr>
            <td><a href="${ctx}/sms/template/form?id=${template.id}">
                    ${template.name}
            </a></td>
            <td>
                    ${template.code}
            </td>
            <td>
                    ${template.template}
            </td>
            <td>
                    ${template.description}
            </td>
            <td>
                    ${template.remarks}
            </td>
            <td>
                <fmt:formatDate value="${template.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <shiro:hasPermission name="sms:smstemplate:edit">
                <td>
                    <a href="${ctx}/sms/template/form?id=${template.id}">修改</a>
                    <a href="${ctx}/sms/template/delete?id=${template.id}"
                       onclick="return confirmx('确认要删除该消息模版吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>