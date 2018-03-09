<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统文案管理</title>
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
		<li><a href="${ctx}/wlpt/base/bscAgreement/">系统文案列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/bscAgreement/form?id=${bscAgreement.agreementId}">系统文案<shiro:hasPermission name="wlpt:base:bscAgreement:edit">${not empty bscAgreement.agreementId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:bscAgreement:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bscAgreement" action="${ctx}/wlpt/base/bscAgreement/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<!--	
		<div class="control-group">
			<label class="control-label">系统协议ID：</label>
			<div class="controls">
				<form:input path="agreementId" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		-->	
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">编码：</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型：</label>
			<div class="controls">
				<!-- <form:input path="type" htmlEscape="false" maxlength="11" class="input-xlarge "/> -->
				<select  name="type"  onchange="changeSelectOption(this)"  id="type" data-placeholder="请选择" style="vertical-align:top;width: 120px;" path="type" htmlEscape="false" class="input-xlarge ">
						<option value="0" <c:if test="${bscAgreement.type == '0'}">selected</c:if>>链接</option>
						<option value="1" <c:if test="${bscAgreement.type == '1'}">selected</c:if>>菜单</option>
						<option value="2" <c:if test="${bscAgreement.type == '1'}">selected</c:if>>其他</option>
				</select>
			</div>
		</div>
		<div id="bb" class="control-group">
			<label class="control-label">parentid：</label>
			<div class="controls">
				<form:input path="parentid" htmlEscape="false" class="input-xlarge "/>多个字符用英文逗号隔开“,”
				<!-- 
				<select  id="parentid"  name='parentid' style="vertical-align:top;" path="parentid" htmlEscape="false" class="input-xlarge "> 
				<c:forEach items="${pdAgreementList}" var="agreement">
					<option value="${agreement.AGREEMENT_ID }"
					 <c:if test="${agreement.AGREEMENT_ID == pd.PARENTID }">selected</c:if>>
					 ${agreement.NAME }</option>
				</c:forEach>
				</select>
				 -->
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序码：</label>
			<div class="controls">
				<!-- <form:input path="sortcode" htmlEscape="false" maxlength="11" class="input-xlarge "/> -->
				<input type="number" name="sortcode" id=""sortcode"" value="${bscAgreement.sortcode}" 
				  maxlength="11" placeholder="这里输入排序码" title="排序码" path="sortcode" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<!-- <form:input path="isdelete" htmlEscape="false" maxlength="11" class="input-xlarge "/> -->
		    <select  name="isdelete" id="isdelete" data-placeholder="请选择" style="vertical-align:top;width: 120px;" path="isdelete" htmlEscape="false" class="input-xlarge "  >
				<option value="0" <c:if test="${bscAgreement.isdelete == '0'}">selected</c:if>>显示</option>
				<option value="1" <c:if test="${bscAgreement.isdelete == '1'}">selected</c:if>>隐藏</option>
		    </select>
			</div>
		</div>

		<!-- 
		<div class="control-group">
			<label class="control-label">createtime：</label>
			<div class="controls">
				<input name="createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bscAgreement.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">updatetime：</label>
			<div class="controls">
				<input name="updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bscAgreement.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		-->
		<div id="kk" class="control-group">
			<label class="control-label">内容：</label>
			<div class="controls">
				<form:textarea id="content" htmlEscape="false" path="content" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="content" uploadPath="/agreement"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:bscAgreement:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
	
		function changeSelectOption(select){
			setButton(select.options[select.selectedIndex].value); 
		}
		function setButton(selectValue){
			if(selectValue!=0){
				$('#kk').hide();
				$('#bb').show();
			}else{
				$('#kk').show();
				$('#bb').hide();
			}
		}
		var type="${bscAgreement.type}";
		setButton(type);
</script>
</body>
</html>