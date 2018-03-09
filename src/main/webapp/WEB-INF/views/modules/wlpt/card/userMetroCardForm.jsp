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
		action="${ctx}/wlpt/card/userMetroCard/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
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
				<form:select id="status" path="status" class="input-xlarge ">
					<form:options items="${fns:getDictList('metro_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
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
			<label class="control-label">一卡通卡号：</label>
			<div class="controls">
				<form:input id="cardid" path="cardid" htmlEscape="false"
					class="input-xlarge" maxlength="18" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通密码：</label>
			<div class="controls">
				<form:password id="password" path="password" htmlEscape="false"
					class="input-xlarge" maxlength="16" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通工号：</label>
			<div class="controls">
				<form:input id="userAccount" path="userAccount" htmlEscape="false"
					class="input-xlarge" maxlength="5" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通姓名：</label>
			<div class="controls">
				<form:input id="trueName" path="trueName" htmlEscape="false"
					class="input-xlarge" maxlength="10" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通手机：</label>
			<div class="controls">
				<form:input id="mobile" path="mobile" htmlEscape="false"
					class="input-xlarge" maxlength="11" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通身份证：</label>
			<div class="controls">
				<form:input id="idcard" path="idcard" htmlEscape="false"
					class="input-xlarge " maxlength="18" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通性别：</label>
			<div class="controls">
				男
				<form:radiobutton path="sex" id="boy" cssStyle="margin-left: 5px"
					value="1" />
				女
				<form:radiobutton path="sex" id="girl" cssStyle="margin-left: 5px"
					value="2" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通生日：</label>
			<div class="controls">
				<form:input path="birth" htmlEscape="false" maxlength="32"
					class="input-xlarge"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
					readonly="readonly" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通地址：</label>
			<div class="controls">
				<form:input id="cardAddress" path="cardAddress" htmlEscape="false"
					maxlength="50" class="input-xlarge " />
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

			var cstatus = '${userMetroCard.status}';
			if (cstatus == '1' || cstatus == '3' || cstatus == '4') {
				$("#cardid").attr('readonly', 'readonly');
				$("#mobile").attr('readonly', 'readonly');
				$("#userAccount").attr('readonly', 'readonly');
			}

			window.save = function() {
				var status = $("#status").val();
				var isnul = true;
				if (status == '1') {
					isnul = isnul && $("#cardid").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#password").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#userAccount").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#trueName").valid({
						methods : "required|isName"
					});
					isnul = isnul && $("#mobile").valid({
						methods : "required|isPhone"
					});
					if ($("#idcard").val() != null && $("#idcard").val() != "") {
						isnul = isnul && $("#idcard").valid({
							methods : "isIDCard"
						});
					}
					if ($("#cardAddress").val() != null && $("#cardAddress").val() != "") {
						isnul = isnul && $("#cardAddress").valid({
							methods : "string"
						});
					}
					if (!isnul) {
						return false;
					}
					$("#inputForm").submit();
				} else if (status == '3') {
					if (cstatus != '1'&&cstatus!='4') {
						$("#status").tips({
							side : 3,
							msg : '您目前不能进行此操作!',
							bg : '#00A2E9',
							time : 3
						});
						return false;
					}
					isnul = isnul && $("#cardid").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#userAccount").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#mobile").valid({
						methods : "required|isPhone"
					});
					if (!isnul) {
						return false;
					}
					$("#inputForm").submit();
				} else if (status == '4') {
					if (cstatus != '3') {
						$("#status").tips({
							side : 3,
							msg : '您目前不能进行此操作!',
							bg : '#00A2E9',
							time : 3
						});
						return false;
					}
					isnul = isnul && $("#cardid").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#userAccount").valid({
						methods : "required|isNum"
					});
					isnul = isnul && $("#mobile").valid({
						methods : "required|isPhone"
					});
					if (!isnul) {
						return false;
					}
					$("#inputForm").submit();
				} else {
					$("#inputForm").submit();
				}
			}
		});
	</script>
</body>
</html>