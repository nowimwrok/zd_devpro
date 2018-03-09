<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品列表管理</title>
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
	<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/activity/${activityWxgift.pagetype == 'info'?'activityWxinfo':'activityWxgift' }/">${activityWxgift.pagetype == "info"?"活动信息列表":"奖品列表" }</a></li>
		<li class="active"><a href="${ctx}/wlpt/activity/activityWxgift/form?id=${activityWxgift.id}">奖品<shiro:hasPermission name="wlpt:activity:activityWxgift:edit">${not empty activityWxgift.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:activity:activityWxgift:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="activityWxgift" action="${ctx}/wlpt/activity/activityWxgift/save" method="post" class="form-horizontal">
		<form:hidden path="pagetype" htmlEscape="false" class="input-xlarge "/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label">礼物名称：</label>
			<div class="controls">
				<form:hidden path="id" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<form:hidden path="wxinfo.id" htmlEscape="false" maxlength="32" class="input-xlarge "/>
				<form:input path="giftname" id="giftname" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动说明：</label>
			<div class="controls">
				<form:input path="giftcontent" id="giftcontent" htmlEscape="false" maxlength="250" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">奖品类型：</label>
			<div class="controls">
				<form:select path="gifttype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gifttype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">奖品数量：</label>
			<div class="controls">
				<form:input path="giftnum" id="giftnum" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">每天奖品最多数量：</label>
			<div class="controls">
				<form:input path="giftdaynum" id="giftdaynum" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">中奖机率：</label>
			<div class="controls">
				<form:input path="chance" id="chance" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">礼物价值：</label>
			<div class="controls">
				<form:input path="giftworth" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有效开始时间：</label>
			<div class="controls">
				<input name="starttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${activityWxgift.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有效结束时间：</label>
			<div class="controls">
				<input name="endtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${activityWxgift.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:activity:activityWxgift:edit"><input id="btnSubmit" class="btn btn-primary" type="button" onclick="save()" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
	   $(function() {
		   window.save = function() {
			   var isnul = true;
			   isnul = isnul && $("#giftname").valid({
					methods : "required"
				});
			   isnul = isnul && $("#giftcontent").valid({
					methods : "required"
				});
			   isnul = isnul && $("#giftnum").valid({
					methods : "required|isNum"
				});
			   isnul = isnul && $("#giftdaynum").valid({
					methods : "required|isNum"
				});
			   isnul = isnul && $("#chance").valid({
					methods : "required|isNum"
				});
			   if (!isnul) {
					return false;
				}
			   if ($("#giftnum").val()*1 <= 0) {
					$("#giftnum").tips({
						side : 3,
						msg : '礼物数量必须大于0!',
						bg : '#00A2E9',
						time : 3
					});
					return false;
				}
			   if ($("#giftdaynum").val()*1 <= 0 || $("#giftdaynum").val()*1 > $("#giftnum").val()*1) {
					$("#giftdaynum").tips({
						side : 3,
						msg : '每天礼物数量必须大于0并且小于礼物总数!',
						bg : '#00A2E9',
						time : 3
					});
					return false;
				}
			   if ($("#chance").val()*1 <= 0 || $("#chance").val()*1 > 100) {
					$("#chance").tips({
						side : 3,
						msg : '中奖几率大于0小于100!',
						bg : '#00A2E9',
						time : 3
					});
					return false;
				}
			   $("#inputForm").submit();
		   }
	   });
	</script>
</body>
</html>