<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
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
		<li><a href="${ctx}/wlpt/user/userCompanypicture/">企业信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/user/userCompanypicture/form?id=${userCompanypicture.id}">企业信息<shiro:hasPermission name="wlpt:user:userCompanypicture:edit">${not empty userCompanypicture.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:user:userCompanypicture:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userCompanypicture" action="${ctx}/wlpt/user/userCompanypicture/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">主键Id：</label>
			<div class="controls">
				<form:input path="picid" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">法人或负责人照片：</label>
			<div class="controls">
				<form:hidden id="headerimg" path="headerimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="headerimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业执照图片：</label>
			<div class="controls">
				<form:hidden id="businesslicencenumimg" path="businesslicencenumimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="businesslicencenumimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证照片：</label>
			<div class="controls">
				<form:hidden id="idcardimg" path="idcardimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="idcardimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">道路运输许可证书图片：</label>
			<div class="controls">
				<form:hidden id="transportcardimg" path="transportcardimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="transportcardimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">税务登记许可证图片：</label>
			<div class="controls">
				<form:hidden id="taximg" path="taximg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="taximg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司形象展示图片：</label>
			<div class="controls">
				<form:hidden id="companysimg" path="companysimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="companysimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运输风采图片：</label>
			<div class="controls">
				<form:hidden id="transporstyleimg" path="transporstyleimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="transporstyleimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车队展示图片：</label>
			<div class="controls">
				<form:hidden id="carteamimg" path="carteamimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="carteamimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">企业文化照片：</label>
			<div class="controls">
				<form:hidden id="comanycultureimg" path="comanycultureimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="comanycultureimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司荣誉：</label>
			<div class="controls">
				<form:hidden id="comanyhonorimg" path="comanyhonorimg" htmlEscape="false" maxlength="300" class="input-xlarge"/>
				<sys:ckfinder input="comanyhonorimg" type="files" uploadPath="/wlpt/user/userCompanypicture" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">创建时间：</label>
			<div class="controls">
				<input name="createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${userCompanypicture.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">修改时间：</label>
			<div class="controls">
				<input name="updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${userCompanypicture.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">公司荣誉图片标题,多张标题之间以分号隔开：</label>
			<div class="controls">
				<form:input path="comanyhonorimgtitle" htmlEscape="false" maxlength="300" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">remarks：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:userCompanypicture:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>