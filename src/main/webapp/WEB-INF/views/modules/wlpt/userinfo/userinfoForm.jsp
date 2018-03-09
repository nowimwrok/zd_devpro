<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户管理管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                rules: {},
                messages: {
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
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
    <li><a href="${ctx}/sys/Userinfo/">用户管理列表</a></li>
    <li class="active"><a href="${ctx}/sys/Userinfo/form?id=${Userinfo.id}">用户管理<shiro:hasPermission
            name="sys:Userinfo:edit">${not empty Userinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="sys:Userinfo:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="Userinfo" action="${wlpt}/wlpt/user/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="user.id"/>
    <form:hidden path="userCompany.id"/>

    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">头像:</label>
        <div class="controls">
            <form:hidden id="nameImage" path="user.photo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
            <sys:ckfinder input="nameImage" type="images" uploadPath="/photo" selectMultiple="false" maxWidth="100"
                          maxHeight="100"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">用户登录名：</label>
        <div class="controls">
            <label class="lbl">${user.loginName}</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">用户手机号码：</label>
        <div class="controls">
            <label class="lbl">${user.phone}</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">真实姓名：</label>
        <div class="controls">
            <form:input path="user.name" htmlEscape="false" maxlength="32" class="input-xlarge realName"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">用户邮箱：</label>
        <div class="controls">
            <form:input path="user.email" htmlEscape="false" maxlength="32" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">QQ：</label>
        <div class="controls">
            <form:input path="qq" htmlEscape="false" maxlength="32" class="input-xlarge qq"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">座机：</label>
        <div class="controls">
            <form:input path="telphone" htmlEscape="false" maxlength="32" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">联系地址：</label>
        <div class="controls">
            <form:input path="contactaddress" htmlEscape="false" maxlength="200" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">性别：</label>
        <div class="controls">
            <form:input path="sex" htmlEscape="false" maxlength="11" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">身份证：</label>
        <div class="controls">
            <form:input path="identitycard" htmlEscape="false" maxlength="32" class="input-xlarge card"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">公司名称：</label>
        <div class="controls">
            <form:input path="companyname" htmlEscape="false" maxlength="32" class="input-xlarge "/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">提现密码：</label>
        <div class="controls">
            <input name="cashpassword" id="cashpassword" htmlEscape="false" maxlength="100" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">确认密码:</label>
        <div class="controls">
            <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50"
                   minlength="3" class="required" equalTo="#cashpassword"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注信息：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>