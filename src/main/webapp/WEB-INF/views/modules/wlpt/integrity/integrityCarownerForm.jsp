<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/integrity/integrityCarowner/">诚信信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityCarowner/form?id=${integrityCarowner.id}">诚信信息<shiro:hasPermission name="wlpt:integrity:integrityCarowner:edit">${not empty integrityCarowner.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:integrity:integrityCarowner:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="integrityCarowner" action="${ctx}/wlpt/integrity/integrityCarowner/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">车主姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系方式：</label>
			<div class="controls">
				<form:input path="linkphone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证：</label>
			<div class="controls">
				<form:hidden id="idcard" path="idcard" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="idcard" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">驾驶证：</label>
			<div class="controls">
				<form:hidden id="driverlicense" path="driverlicense" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="driverlicense" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自有车辆证明：</label>
			<div class="controls">
				<form:hidden id="owncar" path="owncar" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="owncar" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">从业资格证：</label>
			<div class="controls">
				<form:hidden id="qualifycertficate" path="qualifycertficate" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="qualifycertficate" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车牌号：</label>
			<div class="controls">
				<form:input path="carnumber" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车身照片：</label>
			<div class="controls">
				<form:hidden id="bodywork" path="bodywork" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="bodywork" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年审记录：</label>
			<div class="controls">
				<form:hidden id="auditrecord" path="auditrecord" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="auditrecord" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险资料：</label>
			<div class="controls">
				<form:hidden id="insurance" path="insurance" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="insurance" type="files" uploadPath="/wlpt/integrity/integrityCarowner" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">更新时间：</label>
			<div class="controls">
				<input name="updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${integrityCarowner.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<input name="createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${integrityCarowner.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否可以编辑 0 是 1否：</label>
			<div class="controls">
				<form:input path="isedit" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('authenStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			<shiro:hasPermission name="wlpt:integrity:integrityCarowner:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>