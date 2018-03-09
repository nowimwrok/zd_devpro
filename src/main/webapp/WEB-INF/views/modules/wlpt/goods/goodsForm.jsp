<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货源管理</title>
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
		<li><a href="${ctx}/wlpt/gds/goods/">货源列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/gds/goods/form?id=${goods.id}">货源<shiro:hasPermission name="wlpt:gds:goods:edit">${not empty goods.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:gds:goods:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="goods" action="${ctx}/wlpt/gds/goods/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">用户ID,外键：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${goods.user.id}" labelName="user.name" labelValue="${goods.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物名称：</label>
			<div class="controls">
				<form:input path="goodsname" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物类型：</label>
			<div class="controls">
				<form:select path="goodstype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('goodstype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货源类型：</label>
			<div class="controls">
				<form:select path="gsoddtype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运输方式：</label>
			<div class="controls">
				<form:input path="transportway" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车型要求：</label>
			<div class="controls">
				<form:input path="cartype" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车长：</label>
			<div class="controls">
				<form:input path="carlength" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车长单位：</label>
			<div class="controls">
				<form:input path="lengthunit" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货运量：</label>
			<div class="controls">
				<form:input path="freightvolume" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">剩余货运量：</label>
			<div class="controls">
				<form:input path="residualvolume" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货运单位：</label>
			<div class="controls">
				<form:select path="freightunit" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('freightunit')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">件数：</label>
			<div class="controls">
				<form:input path="piecenumber" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">搬运工：</label>
			<div class="controls">
				<form:input path="stevedore" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">包装方式：</label>
			<div class="controls">
				<form:input path="packageway" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物价值：</label>
			<div class="controls">
				<form:input path="worth" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">期望价格：</label>
			<div class="controls">
				<form:input path="expectedprice" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发货时间：</label>
			<div class="controls">
				<input name="sendtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">到达时间：</label>
			<div class="controls">
				<input name="arrivetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${goods.arrivetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">有效期：</label>
			<div class="controls">
				<form:input path="effectdays" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">发货地址信息：</label>
			<div class="controls">
				<form:radiobuttons path="shipAddress.id" items="${fns:getUserSendAddress()}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>

				&lt;%&ndash;<form:input path="shipId" htmlEscape="false" maxlength="64" class="input-xlarge "/>&ndash;%&gt;
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货地址信息：</label>
			<div class="controls">
				<form:radiobuttons path="consignAddress.id" items="${fns:getUserRevAddress()}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>

				&lt;%&ndash;<form:input path="consignId" htmlEscape="false" maxlength="64" class="input-xlarge "/>&ndash;%&gt;
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">如果是子货源:父货源ID：</label>
			<div class="controls">
				<form:input path="relategoodsid" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">发货地址：</label>
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
					<c:otherwise>
						<c:forEach items="${shipAddress}" var="ship" varStatus="i">
							<input type="radio" name="shipAddress.id" value="${ship.id}"/>
							${ship.province}${ship.city}${ship.district}
							&nbsp;${ship.linkman}
							&nbsp;${ship.linkmobile}
							&nbsp;${ship.linkcompany}
							&nbsp;${ship.linktelphone}
							&nbsp;${ship.linkemail}<br>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货地址：</label>
			<div class="controls">
				<c:choose>
					<c:when test="${not empty goods.id}">
						${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district}
						&nbsp;${goods.consignAddress.linkman}
						&nbsp;${goods.consignAddress.linkmobile}
						&nbsp;${goods.consignAddress.linkcompany}
						&nbsp;${goods.consignAddress.linktelphone}
						&nbsp;${goods.consignAddress.linkemail}
					</c:when>
					<c:otherwise>
						<c:forEach items="${consignAddress}" var="consign" varStatus="s">
							<input type="radio" name="consignAddress.id" value="${consign.id}"></input>
							${consign.province}${consign.city}${consign.district}
							&nbsp;${consign.linkman}
							&nbsp;${consign.linkmobile}
							&nbsp;${consign.linkcompany}
							&nbsp;${consign.linktelphone}
							&nbsp;${consign.linkemail}<br>
						</c:forEach>
					</c:otherwise>
				</c:choose>


			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="wlpt:gds:goods:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>