<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>一卡通POS机列表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				rules: {
					useraccount: {
                        remote: {
                            url: "${ctx}/wlpt/card/userMetroPos/checkUserAccount",
                            type: "post",
                            data: {
                            	useraccount: function () {
                                    return $("#useraccount").val()
                                },
                                id: function () {
                                    return $("#id").val()
                                }
                            }
                        }
                    },
                    searchinfo:{}
                },
                messages: {
                	useraccount: {
                        remote: "工号已存在"
                    }
                },
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			function getUsetInfo(searchinfo) {
				$("#searchinfo").val(searchinfo);
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: searchinfo},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            var company=data.userinfo.userinfo;
                            $("#searchinfo").val(searchinfo);
                            $("#loginName").html(userinfo.loginName);
                            $("#trueName").html(userinfo.name);
                            $("#memberName").val(userinfo.name);
                            $("#userphone").html(userinfo.phone);
                            $("input[name='user.id']").val(userinfo.id);
                            $("#companyName").html(data.company.companyname);

                        } else {
                            top.$.jBox.tip('请填写正确的手机号码', 'warning');
                            $("#loginName").html("");
                            $("#trueName").html("");
                            $("#memberName").val("");
                            $("#userphone").html("");
                            $("input[name='user.id']").val("");
                            $("#companyName").html("");
                        }

                    },
                    error: function () {
                        top.$.jBox.tip('用户不存在', 'warning');
                    }
                });
            }
			loaduserinfo();
			function loaduserinfo(){
				var phone = '${userMetroPos.user.phone}';
				if(phone!=''){
					getUsetInfo(phone);
				}
			}
			
			$("#searchinfo").change(function () {
				var searchinfo = $("#searchinfo").val();
				getUsetInfo(searchinfo);
            });
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/card/userMetroPos/">一卡通POS机列表列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/card/userMetroPos/form?id=${userMetroPos.id}">一卡通POS机列表<shiro:hasPermission name="wlpt:card:userMetroPos:edit">${not empty userMetroPos.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:card:userMetroPos:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userMetroPos" action="${ctx}/wlpt/card/userMetroPos/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="user.id"/>
		<input type="hidden" name = "olduseraccount" value="${userMetroPos.useraccount }" /> 
		<sys:message content="${message}"/>		
		<%-- <div class="control-group">
			<label class="control-label">POS机所属用户：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${userMetroPos.user.id}" labelName="user.name" labelValue="${userMetroPos.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div> --%>
		
		    <div class="control-group">
        <label class="control-label"><span style="color: red;">*</span>POS机所属用户：</label>
        <div class="controls">
            <input type="text" name="searchinfo" id="searchinfo" htmlEscape="false" maxlength="255" class="required input-xlarge  "/>
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
    </div>

		
		
		<div class="control-group">
			<label class="control-label"><span style="color: red;">*</span>会员姓名：</label>
			<div class="controls">
				<form:input path="memberName" htmlEscape="false" maxlength="20" class="required input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span style="color: red;">*</span>店铺名称：</label>
			<div class="controls">
				<form:input path="storeName" htmlEscape="false" maxlength="255" class="required input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><span style="color: red;">*</span>POS机工号：</label>
			<div class="controls">
				<form:input path="useraccount" htmlEscape="false" maxlength="32" class="required input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:card:userMetroPos:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>