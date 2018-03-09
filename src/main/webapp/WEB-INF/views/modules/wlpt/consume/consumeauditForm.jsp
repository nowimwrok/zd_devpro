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
            $("#searchinfo").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#searchinfo").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            var bankinfo=data.bankinfo;
                           /*  alert(JSON.stringify(data)); */
                            var company=data.userinfo.userinfo;
                            $("#loginName").html(userinfo.loginName);
                            $("#trueName").html(userinfo.name);
                            $("#userphone").html(userinfo.phone);
                            //$("#user.phone").html(userinfo.phone)
                            $("input[name='user.phone']").val(userinfo.phone);
                            //$("#user.phone").html(userinfo.phone);
                            /* $("#value").val(userinfo.userCompany); */
                            $("#companyName").html(data.company.companyname);
                            $("#bankName").html(bankinfo.bankname);
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
    <li><a href="${ctx}/wlpt/consume/consumeaudit/list">账户充值列表</a></li>
    <li class="active"><a href="${ctx}/wlpt/consume/consumeaudit/form?id=${consumeaudit.id}">账户充值<shiro:hasPermission
            name="wlpt:consume:consumeaudit:edit">${not empty consumeaudit.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="wlpt:consume:consumeaudit:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="consumeaudit" action="${ctx}/wlpt/consume/consumeaudit/recharge" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="user.phone"/>
    <sys:message content="${message}"/>
    <%--<div class="control-group">
        <label class="control-label">交易用户ID：</label>
        <div class="controls">
            <sys:treeselect id="user" name="user.id" value="${consumeaudit.user.id}" labelName="user.name" labelValue="${consumeaudit.user.name}"
                title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>--%>
    <div class="control-group">
        <label class="control-label">充值用户：</label>
        <div class="controls">
            <input name="searchinfo" id="searchinfo" htmlEscape="false" maxlength="255" class="input-xlarge  "/>
        </div>
    </div>
    <div id="userinfo">
        <div class="control-group">
            <label class="control-label">用户名：</label>
            <div class="controls">
                <label class="lbl" id="loginName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="trueName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">手机号：</label>
            <div class="controls">
                <label class="lbl" id="userphone"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">公司信息：</label>
            <div class="controls">
                <label class="lbl" id="companyName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">银行卡信息：</label>
            <div class="controls">
                <label class="lbl" id="bankName"></label>
            </div>
            <div class="controls">
                <label class="lbl" id="bankType"></label>
            </div>
            <div class="controls">
                <label class="lbl" id="bankCard"></label>
            </div>
        </div>
    </div>


    <div class="control-group">
        <label class="control-label">充值金额：</label>
        <div class="controls">
            <form:input id="consumemony" path="consume.consumemony" htmlEscape="false" class="decimalTwo required input-xlarge"/><!-- 验证条件是加在class里面的 -->
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">交易图片:凭据：</label>
        <div class="controls">
            <div class="controls">
                <form:hidden id="consumeImg" path="consumeImg" htmlEscape="false" maxlength="500" class="input-xlarge"/>
                <sys:ckfinder input="consumeImg" type="images" uploadPath="/wlpt/consume/consumeaudit" selectMultiple="false"/>
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
        <shiro:hasPermission name="wlpt:consume:consumeaudit:edit"><input id="btnSubmit" class="btn btn-primary"
                                                                          type="submit"
                                                                          value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
        $(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                	var decimalTwozz = /^-?\d+(\.\d{1,2})?$/;
                	var cvalue  = $("#consumemony").val();
					if(!decimalTwozz.test(cvalue)){
						$.MsgBox.Alert("充值提示","只能为数字或小数且小数点后不能超过2位");
                		return;
                	}
                	if(cvalue <= 0){
                		$.MsgBox.Alert("充值提示","充值金额不能为0");
                		return;
                	}
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
</body>
</html>