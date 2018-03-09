<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报价管理</title>
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
		<li><a href="${ctx}/wlpt/gds/quoteinfo/">报价列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/gds/quoteinfo/form?id=${quoteinfo.id}">报价<shiro:hasPermission name="wlpt:goods:quoteinfo:edit">${not empty quoteinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:gds:quoteinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="quoteinfo" action="${ctx}/wlpt/gds/quoteinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="goods.id" value="${goods.id}"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">货物信息：</label>
			<div class="controls">
				${goods.goodsname }&nbsp;<br>
				货运量:${goods.freightvolume}${goods.freightunit}&nbsp;剩余:${goods.residualvolume}${goods.freightunit}

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地址信息：</label>
			<div class="controls">
				<c:choose>
					<c:when test="${not empty goods.id}">
						${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district}
						&nbsp;${goods.shipAddress.linkman}
						&nbsp;${goods.shipAddress.linkmobile}
						&nbsp;${goods.shipAddress.linkcompany}
						&nbsp;${goods.shipAddress.linktelphone}
						&nbsp;${goods.shipAddress.linkemail}
					</c:when>
				</c:choose>
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">用户id，：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${quoteinfo.user.id}" labelName="user.name" labelValue="${quoteinfo.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">司机ID：</label>
			<div class="controls">
				<c:choose>
					<c:when test="${not empty driver}">
						<c:forEach items="${driver}" var="dr" varStatus="i">
							<input type="radio" name="driver.id" value="${dr.reuser.id}"/>
							${dr.reuser.name}
							&nbsp;${dr.reuser.phone}
							<br>
						</c:forEach>
					</c:when>
				</c:choose>
				<%--<sys:treeselect id="driver" name="driver.id" value="${quoteinfo.driver.id}" labelName="${quoteinfo.driver.name}" labelValue="${quoteinfo.driver.name}"
								title="用户" url="/wlpt/car/attach/getAttachlist" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			--%></div>
		</div>
		<div class="control-group">
			<label class="control-label">报价车辆：</label>
			<div class="controls">
				<c:choose>
					<c:when test="${not empty car}">
						<c:forEach items="${car}" var="c" varStatus="s">
							<input type="radio" name="car.id" value="${c.id}"/>
							${c.carnumber}
							&nbsp;${c.cartype}
							&nbsp;${c.carlength}米
							&nbsp;${c.loadweight}吨
							<br>
						</c:forEach>
					</c:when>
				</c:choose>
				<%--<form:input path="car.id" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			--%></div>
		</div>
		<div class="control-group">
			<label class="control-label">报价：</label>
			<div class="controls">
				<form:input path="ooferprice" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">报价吨位：</label>
			<div class="controls">
				<form:input path="oddloadweight" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">remarks：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="wlpt:goods:quoteinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>