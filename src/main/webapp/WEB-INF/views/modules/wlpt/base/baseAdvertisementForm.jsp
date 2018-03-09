<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告管理</title>
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
		<li><a href="${ctx}/wlpt/base/baseAdvertisement/">广告列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/baseAdvertisement/form?id=${baseAdvertisement.advertisementId}">广告<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit">${not empty baseAdvertisement.advertisementId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:baseAdvertisement:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="baseAdvertisement" action="${ctx}/wlpt/base/baseAdvertisement/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">应用系统：</label>
			<div class="controls">
				<select name="accesssystemcode" id="accesssystemcode" path="accesssystemcode" htmlEscape="false" class="input-xlarge required">
                      <option value="0" <c:if test="${baseAdvertisement.accesssystemcode == '0'}">selected</c:if>>门户网站</option>
			          <option value="1" <c:if test="${baseAdvertisement.accesssystemcode == '1'}">selected</c:if>>物流平台</option>
				</select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>		
		<div class="control-group">
			<label class="control-label">广告标题：</label>
			<div class="controls">
				<form:input path="adverttitle" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">广告名称：</label>
			<div class="controls">
				<form:input path="advertname" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">摆放位置：</label>
			<div class="controls">
			    <select path="positionid" name="positionid" id="positionid" htmlEscape="false" class="input-xlarge required">
			          <option value="0" <c:if test="${baseAdvertisement.positionid == '0'}">selected</c:if>>上面(首页轮播)</option>
			          <option value="1" <c:if test="${baseAdvertisement.positionid == '1'}">selected</c:if>>中间广告</option>
			          <option value="2" <c:if test="${baseAdvertisement.positionid == '2'}">selected</c:if>>左边广告</option>
			          <option value="3" <c:if test="${baseAdvertisement.positionid == '3'}">selected</c:if>>右边广告</option>
				</select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">选择图片：</label>
			<div class="controls">
				<form:hidden id="picture" path="picture" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="picture" type="files" uploadPath="/advertisement" selectMultiple="false"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图片大小：</label>
			<div class="controls">
				<form:input path="advertbytes" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">广告尺寸：</label>
			<div class="controls">
				<form:input path="advertsize" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">链接地址：</label>
			<div class="controls">
				<form:input path="linkaddress" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序码：</label>
			<div class="controls">
			    <input type="number" name="sortcode" id="sortcode" value="${baseAdvertisement.sortcode}"
			     maxlength="11" placeholder="这里输入排序码" title="排序码" path="sortcode" htmlEscape="false" class="input-xlarge required"/>
			     <span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>	
		<div class="control-group">
			<label class="control-label">是否显示：</label>
			<div class="controls">
				<select path="isdelete" id="isdelete" name="isdelete" class="input-xlarge required">
                      <option value="0" <c:if test="${baseAdvertisement.isdelete == '0'}">selected</c:if>>显示</option>
			          <option value="1" <c:if test="${baseAdvertisement.isdelete == '1'}">selected</c:if>>隐藏</option>					
				</select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">背景颜色:：</label>
			<div class="controls">
				<form:input path="backgroundcolor" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>