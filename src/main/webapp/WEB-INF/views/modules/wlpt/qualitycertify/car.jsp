<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>车辆信息</title>
<meta name="decorator" content="default" />
<style type="text/css">
.imgheight{
height:110px;
width: 200px;
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {

				var idcardimg = '${info.travellicimg}';
				var idcardimglist = [];
				if (idcardimg != "" && idcardimg.indexOf("|") != -1) {
					idcardimglist = idcardimg.split("|");
					$("#showidcardimg").attr("src", idcardimglist[1]);
					$("#showidcardimg").show();
					if (idcardimglist[2] != null && idcardimglist[2] != "") {
						$("#showidcardimgtailimg")
								.attr("src", idcardimglist[2]);
						$("#showidcardimgtailimg").show();
					}
				}

				var driverlicimg = '${info.carsurfaceimg}';
				var driverlicimglist = [];
				if (driverlicimg != "" && driverlicimg.indexOf("|") != -1) {
					driverlicimglist = driverlicimg.split("|");
					$("#showdriverlicimg").attr("src", driverlicimglist[1]);
					$("#showdriverlicimg").show();
					if (driverlicimglist[2] != null
							&& driverlicimglist[2] != "") {
						$("#showdriverlicimgtailimg").attr("src",
								driverlicimglist[2]);
						$("#showdriverlicimgtailimg").show();
					}
				}

				//$("#name").focus();
				$("#inputForm")
						.validate(
								{
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
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
		<li><a href="${ctx}/wlpt/user/userQualitycertify/">认证信息列表</a></li>
		<li class="active"><a
			href="${ctx}/wlpt/user/userQualitycertify/form?id=${userQualitycertify.id}">认证信息<shiro:hasPermission
					name="wlpt:user:userQualitycertify:edit">${not empty userQualitycertify.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="wlpt:user:userQualitycertify:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userQualitycertify"
		action="${ctx}/wlpt/user/userQualitycertify/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">车主姓名：</label>
			<div class="controls">${info.user.loginName }</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码:</label>
			<div class="controls">${info.user.phone}</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">车牌号码:</label>
			<div class="controls">${info.carnumber}</div>
		</div>
		<div class="control-group">
			<label class="control-label">车型:</label>
			<div class="controls">${info.cartype}</div>
		</div>
		<div class="control-group">
			<label class="control-label">车长:</label>
			<div class="controls">${info.carlength}米</div>
		</div>
		<div class="control-group">
			<label class="control-label">载重:</label>
			<div class="controls">${info.loadweight}吨</div>
		</div>
		<div class="control-group">
			<label class="control-label">主营路线:</label>
			<div class="controls">${info.mainroad}</div>
		</div>

		<div class="control-group">
			<label class="control-label">行驶证：</label>
			<div class="controls">
				<img id="showidcardimg"
					src="/static/images/wlptfront/prompt/cardup.png" class="photo-dis imgheight"
					style="display: none;">
			</div>
			<div class="controls">
				<img id="showidcardimgtailimg"
					src="/static/images/wlptfront/prompt/cardup.png" class="photo-dis imgheight"
					style="display: none;">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆外观：</label>
			<div class="controls">
				<img id="showdriverlicimg"
					src="/static/images/wlptfront/prompt/cardup.png" class="photo-dis imgheight"
					style="display: none;">
			</div>
			<div class="controls">
				<img id="showdriverlicimgtailimg"
					src="/static/images/wlptfront/prompt/cardup.png" class="photo-dis imgheight"
					style="display: none;">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
				<form:select path="certifystatus" class="input-medium">
					<form:options items="${fns:getDictList('user_authen')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证内容：</label>
			<div class="controls">
				<form:textarea path="certifycomment" htmlEscape="false" rows="4"
					maxlength="500" class="input-xxlarge " />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:userQualitycertify:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>