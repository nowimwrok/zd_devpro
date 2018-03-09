<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>历史运价管理</title>
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
		<li><a href="${ctx}/wlpt/freightrate/${freightratePriceinfo.pagetype == 'line'?'freightrateLine':'freightratePriceinfo' }/">${freightratePriceinfo.pagetype == "line"?"线路运价列表":"历史运价列表" }</a></li>
		<li class="active"><a href="${ctx}/wlpt/freightrate/freightratePriceinfo/form?id=${freightratePriceinfo.frpriceId}">历史运价<shiro:hasPermission name="wlpt:freightrate:freightratePriceinfo:edit">${not empty freightratePriceinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:freightrate:freightratePriceinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="freightratePriceinfo" action="${ctx}/wlpt/freightrate/freightratePriceinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<form:hidden path="pagetype" htmlEscape="false" class="input-xlarge "/>
		<div class="control-group">
			<label class="control-label">货源类型：</label>
			<div class="controls">
				<form:select path="goodstype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">新运价：</label>
			<div class="controls">
				<form:input path="newprice" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">均价：</label>
			<div class="controls">
				<form:input path="averageprice" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">运输方式：</label>
			<div class="controls">
				<form:input path="modetranspor" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车长：</label>
			<div class="controls">
				<form:input path="carlength" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		
		
		<div class="form-actions">
			<input type="hidden" name="frpriceId" value="${freightratePriceinfo.frpriceId}"/>
			<input type="hidden" name="frlineId" value="${freightratePriceinfo.frlineId}"/>
			<shiro:hasPermission name="wlpt:freightrate:freightratePriceinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>