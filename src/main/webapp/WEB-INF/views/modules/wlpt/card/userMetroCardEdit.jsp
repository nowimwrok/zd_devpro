<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户一卡通管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {
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
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/card/userMetroCard/">用户一卡通列表</a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userMetroCard"
		action="${ctx}/wlpt/card/userMetroCard/edit" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="user.id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">申请用户：</label>
			<div class="controls">${userMetroCard.user.loginName}</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户角色：</label>
			<div class="controls">${userMetroCard.user.role.name}</div>
		</div>
		<div class="control-group">
			<label class="control-label">收货人：</label>
			<div class="controls">${userMetroCard.address.linkman}</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">${userMetroCard.address.linkmobile}</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系地址：</label>
			<div class="controls">
				${userMetroCard.address.province}${userMetroCard.address.city}${userMetroCard.address.district}${userMetroCard.address.address}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮政编码：</label>
			<div class="controls">${userMetroCard.address.postcode}</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核状态：</label>
			<div class="controls">
				<form:select id="status" path="status" class="input-xlarge "
					disabled="true">
					<form:options items="${fns:getDictList('metro_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否收费：</label>
			<div class="controls">
				是
				<form:radiobutton path="ispayment" id="yes" cssStyle="margin-left: 5px"
					value="1"  checked="true"/>
				否
				<form:radiobutton path="ispayment" id="no" cssStyle="margin-left: 5px"
					value="0" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通旧卡号：</label>
			<div class="controls">
				<input type="text" id="oldcardid" name="oldcardid" value="${userMetroCard.cardid }"
					class="input-xlarge" maxlength="18" readonly="readonly"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通新卡号：</label>
			<div class="controls">
				<form:input id="cardid" path="cardid" htmlEscape="false"
					class="input-xlarge" maxlength="18" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通工号：</label>
			<div class="controls">
				<form:input id="userAccount" path="userAccount" htmlEscape="false"
					readonly="true" class="input-xlarge" maxlength="5" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通姓名：</label>
			<div class="controls">
				<form:input id="trueName" path="trueName" htmlEscape="false"
					readonly="true" class="input-xlarge" maxlength="10" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通手机：</label>
			<div class="controls">
				<form:input id="mobile" path="mobile" htmlEscape="false"
					readonly="true" class="input-xlarge" maxlength="11" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通身份证：</label>
			<div class="controls">
				<form:input id="idcard" path="idcard" htmlEscape="false"
					readonly="true" class="input-xlarge " maxlength="18" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通生日：</label>
			<div class="controls">
				<form:input path="birth" htmlEscape="false" maxlength="32"
					readonly="true" class="input-xlarge"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通地址：</label>
			<div class="controls">
				<form:input id="cardAddress" path="cardAddress" htmlEscape="false"
					readonly="true" maxlength="50" class="input-xlarge " />
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="wlpt:card:userMetroCard:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button"
					value="保 存" onclick="save()" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
	<script type="text/javascript">
		$(function() {
			window.save = function() {
				var status = $("#status").val();
				var isnul = true;
				if (status == '1') {
					isnul = isnul && $("#cardid").valid({
						methods : "required|isNum"
					});
					if (!isnul) {
						return false;
					}
					$("#inputForm").submit();
				}
				$("#inputForm").submit();
			}
		});
	</script>
</body>
</html>