<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>友情链接管理</title>
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
		<li><a href="${ctx}/wlpt/base/bscFriendlylink/">友情链接列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/bscFriendlylink/form?id=${bscFriendlylink.friendlylinkId}">友情链接<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit">${not empty bscFriendlylink.friendlylinkId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:bscFriendlylink:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bscFriendlylink" action="${ctx}/wlpt/base/bscFriendlylink/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">网站名字：</label>
			<div class="controls">
				<form:input path="webname" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">网站路径：</label>
			<div class="controls">
				<form:input path="weburl" htmlEscape="false" maxlength="4000" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">网站类型：</label>
			<div class="controls">
				<select path="webtype" name="webtype" id="webtype" htmlEscape="false" class="input-xlarge ">
                    <option value="1" <c:if test="${bscFriendlylink.webtype == '1'}">selected</c:if>>政府行业协会</option>
                    <option value="2" <c:if test="${bscFriendlylink.webtype == '2'}">selected</c:if>>商贸网站</option>
                    <option value="3" <c:if test="${bscFriendlylink.webtype == '3'}">selected</c:if>>物流企业</option>
                    <option value="4" <c:if test="${bscFriendlylink.webtype == '4'}">selected</c:if>>互联网企业</option>
                    <option value="5" <c:if test="${bscFriendlylink.webtype == '5'}">selected</c:if>>其他</option>
				</select>
			</div>		
		</div>
		<div class="control-group">
			<label class="control-label">网站信息：</label>
			<div class="controls">
				<form:input path="webinfo" htmlEscape="false" maxlength="300" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系人：</label>
			<div class="controls">
				<form:input path="linkname" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">
				<form:input path="linkmobile" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系邮箱：</label>
			<div class="controls">
				<form:input path="linkemail" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<select path="auditstatus" name="auditstatus" id="auditstatus" htmlEscape="false" class="input-xlarge ">
                    <option value="0" <c:if test="${bscFriendlylink.auditstatus == '0'}">selected</c:if>>待审批</option>
                    <option value="1" <c:if test="${bscFriendlylink.auditstatus == '1'}">selected</c:if>>审批通过</option>
                    <option value="2" <c:if test="${bscFriendlylink.auditstatus == '2'}">selected</c:if>>审批不通过</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否显示：</label>
			<div class="controls">
				<select path="isvisible" name="isvisible" id="isvisible" htmlEscape="false" class="input-xlarge ">
                    <option value="0" <c:if test="${bscFriendlylink.isvisible == '0'}">selected</c:if>>否</option>
                    <option value="1" <c:if test="${bscFriendlylink.isvisible == '1'}">selected</c:if>>是</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所属模块：</label>
			<div class="controls">
				<select path="module" name="module" id="module" htmlEscape="false" class="input-xlarge ">
                    <option value="0" <c:if test="${bscFriendlylink.module == '0'}">selected</c:if>>common</option>
                    <option value="1" <c:if test="${bscFriendlylink.module == '1'}">selected</c:if>>wlpt</option>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序码：</label>
			<div class="controls">
				<input type="number" name="sortcode" id="sortcode" value="${bscFriendlylink.sortcode}"
			     maxlength="11" placeholder="这里输入排序码" title="排序码" path="sortcode" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>