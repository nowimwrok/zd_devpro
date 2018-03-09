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
		<li><a href="${ctx}/wlpt/integrity/integrityEnterprise/">诚信信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityEnterprise/form?id=${integrityEnterprise.id}">诚信信息<shiro:hasPermission name="wlpt:integrity:integrityEnterprise:edit">${not empty integrityEnterprise.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:integrity:integrityEnterprise:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="integrityEnterprise" action="${ctx}/wlpt/integrity/integrityEnterprise/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">企业法人的姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司联系方式：</label>
			<div class="controls">
				<form:input path="linkphone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证图片用：</label>
			<div class="controls">
				<form:hidden id="idcard" path="idcard" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="idcard" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">个人地址：</label>
			<div class="controls">
				<form:textarea path="persionaladdress" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">房产证图片：</label>
			<div class="controls">
				<form:hidden id="certificateproperty" path="certificateproperty" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="certificateproperty" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司名称：</label>
			<div class="controls">
				<form:input path="companyname" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司地址：</label>
			<div class="controls">
				<form:textarea path="companyaddress" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">经营年限：</label>
			<div class="controls">
				<form:input path="operationyears" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">企业信息介绍：</label>
			<div class="controls">
				<form:input path="companyinfo" htmlEscape="false" maxlength="500" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">档口和法人的照片&ldquo;,：</label>
			<div class="controls">
				<form:hidden id="stallscorporate" path="stallscorporate" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="stallscorporate" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">办公场所：</label>
			<div class="controls">
				<form:hidden id="officespace" path="officespace" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="officespace" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">存储货物的地方：</label>
			<div class="controls">
				<form:hidden id="storageplace" path="storageplace" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="storageplace" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">员工合照：</label>
			<div class="controls">
				<form:hidden id="staffphoto" path="staffphoto" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="staffphoto" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业执照：</label>
			<div class="controls">
				<form:hidden id="businesslicense" path="businesslicense" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="businesslicense" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">银行开户许可证：</label>
			<div class="controls">
				<form:hidden id="bankopening" path="bankopening" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="bankopening" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">道路运输许可证：</label>
			<div class="controls">
				<form:hidden id="roadtransport" path="roadtransport" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="roadtransport" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自有车辆证明：</label>
			<div class="controls">
				<form:hidden id="owncar" path="owncar" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="owncar" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上游运输合同：</label>
			<div class="controls">
				<form:hidden id="upstreamcontract" path="upstreamcontract" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="upstreamcontract" type="files" uploadPath="/wlpt/integrity/integrityEnterprise" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">企业成立时间：</label>
			<div class="controls">
				<input name="operationyearstime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${integrityEnterprise.operationyearstime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">更新时间：</label>
			<div class="controls">
				<input name="updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${integrityEnterprise.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<input name="createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${integrityEnterprise.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否可以编辑 ：</label>
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
			<shiro:hasPermission name="wlpt:integrity:integrityEnterprise:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>