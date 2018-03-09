<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>绑定银行卡管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                rules: {
                    payPwd: {
                        remote: {
                            url: "${wlpt}/wlpt/user/validateCashPwd",
                            type: "post",
                            data: {
                                cashPwd: function () {
                                    return $("#payPwd").val()
                                },
                                isSave: function () {
                                    if ('${userBankinfo.id}' == null || '${userBankinfo.id}' == "") {
                                        return true;
                                    } else {
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                },
                messages: {
                    payPwd: {remote: "请输入正确的支付密码"}
                },
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
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/user/userBankinfo/index">银行卡信息</a></li>
    <li><a href="${ctx}/wlpt/user/userBankinfo/form?id=${userBankinfo.id}">绑定银行卡<shiro:hasPermission
            name="wlpt:user:userBankinfo:edit">${not empty userBankinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="wlpt:user:userBankinfo:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="userBankinfo" action="${ctx}/wlpt/user/userBankinfo/save" method="post"
           class="form-horizontal">
    <%--<form:hidden path="id"/>--%>

    <sys:message content="${message}"/>
    <c:if test="${empty userBankinfo.id}">
        <label class="label">暂未绑定信息</label>
    </c:if>
    <c:if test="${not empty userBankinfo.id}">
        <div class="control-group">
            <label class="control-label">银行卡类型：</label>
            <div class="controls">
                <label class="label">${userBankinfo.banktype}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">银行支行：</label>
            <div class="controls">
                <label class="label">${userBankinfo.bankname}</label>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">银行卡卡号：</label>
            <div class="controls">
                <label class="label">${userBankinfo.bankcard}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">绑卡姓名：</label>
            <div class="controls">
                <label class="label">${userBankinfo.bindname}</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">绑卡手机：</label>
            <div class="controls">
                <label class="label">${userBankinfo.bindphone}</label>
            </div>
        </div>
    </c:if>


    <div class="form-actions">
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>