<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信标准评分项管理</title>
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
		<li><a href="${ctx}/wlpt/integrity/integrityStandarditems/">诚信标准评分项列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityStandarditems/form?id=${integrityStandarditems.id}">诚信标准评分项<shiro:hasPermission name="wlpt:integrity:integrityStandarditems:edit">${not empty integrityStandarditems.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:integrity:integrityStandarditems:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="integrityStandarditems" action="${ctx}/wlpt/integrity/integrityStandarditems/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标准类型：</label>
			<div class="controls">
				<form:select path="standard.id"  class="input-xlarge ">
					<c:forEach items="${isLst }" var="s">
						<form:option value="${s.id }" label="${s.typename }" />
					</c:forEach>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分项：</label>
			<div class="controls">
				<form:input path="scoreitem" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分标准：</label>
			<div class="controls">
				<form:select path="integritycode" class="input-xlarge ">
					<form:options items="${fns:getDictList('integrity_standard')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分方式：</label>
			<div class="controls">
				<form:select path="scoreway"  class="input-xlarge ">
					<form:options items="${fns:getDictList('integrity_scoreway')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">评分值：</label>
			<div class="controls">
			
				<form:input path="scorevalue" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所得积分：</label>
			<div class="controls">
				<form:input path="integral" htmlEscape="false" maxlength="12" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否必填：</label>
			<div class="controls">
				<form:select path="isrequired" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yesorno')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:integrity:integrityStandarditems:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>