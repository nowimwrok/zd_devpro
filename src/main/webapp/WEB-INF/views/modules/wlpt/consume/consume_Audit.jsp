<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户充值管理</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .fltdiv {
            float: left;
        }
    </style>
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
            $("#searchinfo").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#searchinfo").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo = data.userinfo;
                            var bankinfo = data.bankinfo;
                            $("#loginName").html(userinfo.loginName);
                            $("#trueName").html(userinfo.name);
                            $("#userphone").html(userinfo.phone);
                            //$("#user.phone").html(userinfo.phone)
                            $("input[name='user.phone']").val(userinfo.phone)
                            //$("#user.phone").html(userinfo.phone);
                            $("#companyName").html(userinfo.userinfo.companyname);
                            $("#bankName").html(bankinfo.bankname);
                            $("#bindName").html(bankinfo.bindname);
                            $("#bankType").html(bankinfo.banktype);
                            $("#bankCard").html(bankinfo.bankcard);

                        } else {
                            top.$.jBox.tip('请填写正确的手机号码', 'warning');
                        }

                    },
                    error: function () {
                        top.$.jBox.tip('用户不存在', 'warning');
                    }
                });
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li>
        <a href="${ctx}/wlpt/consume/consumeaudit/list">充值列表</a>
    </li>
    <li>        <a href="${ctx}/wlpt/consume/consumeaudit/cash_list?isRedrect=true">提现列表</a>
    </li>
    <li class="active"><a
            href="${ctx}/wlpt/consume/consumeaudit/editConsumeAudit?id=${consumeaudit.id}">交易审核<shiro:hasPermission
            name="wlpt:consume:consumeaudit:edit">${not empty consumeaudit.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="wlpt:consume:consumeaudit:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="consumeaudit" action="${ctx}/wlpt/consume/consumeaudit/editConsumeAudit"
           method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="type"/>
    <sys:message content="${message}"/>
    <div id="userinfo">
        <div class="control-group">
            <label class="control-label">用户名：</label>
            <div class="controls">
                <label class="lbl" id="loginName">${consumeaudit.user.loginName}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="trueName">${consumeaudit.user.name}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">手机号：</label>
            <div class="controls">
                <label class="lbl" id="userphone">${consumeaudit.user.phone}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">公司信息：</label>
            <div class="controls">
                <label class="lbl" id="companyName">${consumeaudit.user.userCompany.companyname}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">银行卡信息：</label>
            <div class="controls">
                <label class="lbl" id="bindName">${consumeaudit.user.bankinfo.accountName}</label>
            </div>
            <div class="controls">
                <label class="lbl" id="bankName">${consumeaudit.user.bankinfo.bankname}</label>
            </div>
            <div class="controls">
                <label class="lbl" id="bankType">${consumeaudit.user.bankinfo.banktype}</label>
            </div>
            <div class="controls">
                <label class="lbl" id="bankCard">${consumeaudit.user.bankinfo.bankcard}</label>
            </div>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">类型：</label>
        <div class="controls">
            <c:if test="${consumeaudit.type eq 1}">
                账户充值
            </c:if>
            <c:if test="${consumeaudit.type eq 2}">
                账户提现
            </c:if>
            <c:if test="${empty consumeaudit.type}">
                <form:radiobuttons path="type" disabled="true" items="${fns:getDictList('consumeaudit_type')}"
                                   itemLabel="label"
                                   itemValue="value" htmlEscape="false" class=""/>
            </c:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">交易金额：</label>
        <div class="controls">
                ${consumeaudit.consume.consumemony}
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">交易凭据：</label>
        <div class="controls">
            <div class="controls">
                <form:hidden id="consumeImg" path="consumeImg" htmlEscape="false" maxlength="255" class="input-xlarge"/>
                <sys:ckfinder input="consumeImg" type="images" uploadPath="/wlpt/consume/consumeaudit"
                              selectMultiple="false" maxWidth="100" maxHeight="100"/>
            </div>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">审核状态：</label>
        <div class="controls">
            <form:select path="auditstatus" class="input-medium">
                <form:option value="1" label="新建单"/>
                <form:options items="${fns:getDictList('consumeaudit_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="wlpt:consume:consumeaudit:edit">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>