<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账户申请管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if('${message}'!=null&&'${message}'!=''){
				top.$.jBox.tip('${message}', 'warning');
			}
			$("#btnSubmit").click(
					function() {
						var isnul = true;
						isnul = isnul && $("#type").valid({
							methods : "required"
						});
						if(!isnul){
							return false;
						}
						isnul = isnul && $("#name").valid({
							methods : "required"
						});
						if(!isnul){
							return false;
						}
						isnul = isnul && $("#idcard").valid({
							methods : "required|isIDCard"
						});
						if(!isnul){
							return false;
						}
						if($("#type").val() == '1'){
							isnul = isnul && $("#legalname").valid({
								methods : "required"
							});
							if(!isnul){
								return false;
							}
							isnul = isnul && $("#bizlicenceno").valid({
								methods : "required"
							});
							if(!isnul){
								return false;
							}
						}
						isnul = isnul && $("#linkman").valid({
							methods : "required"
						});
						if(!isnul){
							return false;
						}
						isnul = isnul && $("#linkmobile").valid({
							methods : "required|isPhone"
						});
						if(!isnul){
							return false;
						}
						isnul = isnul && $("#linkaddress").valid({
							methods : "required"
						});
						if (!isnul) {
							return false;
						}
						isnul = isnul && $("#target").valid({
							methods : "required|isPhone"
						});
						if (!isnul) {
							return false;
						}
						$("#inputForm").submit();
					});
			$("#target").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#target").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            $("#loginName").html(userinfo.loginName);
                            $("#tname").html(userinfo.name);
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
		<li><a href="${ctx}/wlpt/user/userApplicationAccount/list">开户申请列表</a></li>
		<shiro:hasPermission name="wlpt:user:userApplicationAccount:edit"><li class="active"><a href="${ctx}/wlpt/user/userApplicationAccount/form">申请开户</a></li></shiro:hasPermission>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userApplicationAccount" action="${ctx}/wlpt/user/userApplicationAccount/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">会员类型：</label>
			<div class="controls">
				<form:select path="type" id="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('member_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">名称 ：</label>
			<div class="controls">
				<form:input path="name" id="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<form:input path="idcard" id="idcard" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">身份证图片：</label>
			<div class="controls">
				<form:hidden id="idcardimg" path="idcardimg" htmlEscape="false" maxlength="100" class="input-xlarge"/>
				<sys:ckfinder input="idcardimg" type="files" uploadPath="/wlpt/user/userApplicationAccount" selectMultiple="true"/>
				<span class="help-inline">
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">法人姓名：</label>
			<div class="controls">
				<form:input path="legalname" id="legalname" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业执照号：</label>
			<div class="controls">
				<form:input path="bizlicenceno" id="bizlicenceno" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">营业执照图片：</label>
			<div class="controls">
				<form:hidden id="bizlicenceimg" path="bizlicenceimg" htmlEscape="false" maxlength="100" class="input-xlarge"/>
				<sys:ckfinder input="bizlicenceimg" type="files" uploadPath="/wlpt/user/userApplicationAccount" selectMultiple="true"/>
				<span class="help-inline">
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">联系人：</label>
			<div class="controls">
				<form:input path="linkman" id="linkman" htmlEscape="false" maxlength="30" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系手机：</label>
			<div class="controls">
				<form:input path="linkmobile" id="linkmobile" htmlEscape="false" maxlength="30" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系地址：</label>
			<div class="controls">
				<form:input path="linkaddress" id="linkaddress" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
            <label class="control-label">绑定用户：</label>
            <div class="controls">
               <input id="target" name="target" htmlEscape="false" maxlength="255" class="input-xlarge" placeholder="用户手机号码"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">登录名：</label>
            <div class="controls">
                <label class="lbl" id="loginName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="tname"></label>
            </div>
        </div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:userApplicationAccount:edit"><input id="btnSubmit" class="btn btn-primary" type="button" value="申请"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>