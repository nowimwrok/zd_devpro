<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保存地址管理</title>
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
		<li><a href="${ctx}/wlpt/user/address/">保存地址列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/user/address/form?id=${address.id}">保存地址<shiro:hasPermission name="wlpt:user:address:edit">${not empty address.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:user:address:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="address" action="${ctx}/wlpt/user/address/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>

		<div class="control-group">
			<label class="control-label">地址类型：</label>
			<div class="controls">
				<form:radiobuttons path="type" items="${fns:getDictList('addressType')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地址状态：</label>
			<div class="controls">
				<form:radiobuttons path="status" items="${fns:getDictList('addressStatus')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">省市区：</label>
			<div class="controls">
				<input  type="text" name="addressPCD" id="addressPCD" value="${address.province}${address.city}${address.district}" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				<form:hidden path="province" id="province" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				<form:hidden path="city" id="city" htmlEscape="false" maxlength="64" class="input-xlarge "/>
				<form:hidden path="district" id="district" htmlEscape="false" maxlength="64" class="input-xlarge "/>

			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">省：</label>
			<div class="controls">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">市：</label>
			<div class="controls">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区：</label>
			<div class="controls">
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">详细地址：</label>
			<div class="controls">
				<form:textarea path="address" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系人：</label>
			<div class="controls">
				<form:input path="linkman" htmlEscape="false" value="${address.linkman!=null?address.linkman:user.name}" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系人公司名称：</label>
			<div class="controls">
				<form:input path="linkcompany" htmlEscape="false" value="${address.linkcompany!=null?address.linkcompany:user.userinfo.companyname}" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系人手机：</label>
			<div class="controls">
				<form:input path="linkmobile" htmlEscape="false"  value="${address.linkmobile!=null?address.linkmobile:user.phone}" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="linktelphone" htmlEscape="false" value="${address.linktelphone!=null?address.linktelphone:user.userinfo.telphone}" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系邮箱：</label>
			<div class="controls">
				<form:input path="linkemail"  htmlEscape="false" value="${address.linkemail!=null?address.linkemail:user.email}" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:address:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript">
	$(function(){
		$("#addressPCD").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${ctx}/wlpt/base/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
					$("#province").val(data.province.NAME);
					$("#addressPCD").val(str);
				}
				if (data.city) {
					str += data.city.NAME + "";
					$("#city").val(data.city.NAME);
					$("#addressPCD").val(str);
				}
				if (data.county) {
					str += data.county.NAME;
					$("#district").val(data.county.NAME);
					$("#addressPCD").val(str);
				}
				if (str!=""){
					$("#addressPCD").val(str);
				}else{
					$("#addressPCD").val("");
				}

			}
		});
	});
</script>
</body>
</html>