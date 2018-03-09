<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>线路运价管理</title>
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
		<li><a href="${ctx}/wlpt/freightrate/freightrateLine/">线路运价列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/freightrate/freightrateLine/form?id=${freightrateLine.frlineId}">线路运价<shiro:hasPermission name="wlpt:freightrate:freightrateLine:edit">${not empty freightrateLine.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:freightrate:freightrateLine:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="freightrateLine" action="${ctx}/wlpt/freightrate/freightrateLine/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		
		<div class="control-group">
			<label class="control-label">起点：</label>
			<div class="controls">
				<form:input path="startaddress"  id="startaddress" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">起点备注：</label>
			<div class="controls">
				<form:input path="startaremarks" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">终点：</label>
			<div class="controls">
				<form:input path="endaddress" id="endaddress" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">终点备注：</label>
			<div class="controls">
				<form:input path="endremarks" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">最新的价格指数id：</label>
			<div class="controls">
				<form:input path="newpriceId" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div> --%>
		
		<div class="form-actions">
		<input type="hidden" name="frlineId" value="${freightrateLine.frlineId}"/>
			<shiro:hasPermission name="wlpt:freightrate:freightrateLine:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript">
	//設置地址插件
	$(function(){
		$("#startaddress").PCC({
			hasCounty : false,
			width : 360,
			height : 220,
			url : "${ctx}/wlpt/base/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				/* if (data.province) {
					str += data.province.NAME + "";
					$("#startaddress").val(str);
				} */
				if (data.city) {
					str += data.city.NAME + "";
					$("#startaddress").val(str);
				}
				if (str!=""){
					$("#startaddress").val(str);
				}else{
					$("#startaddress").val("");
				}

			}
		});
		$("#endaddress").PCC({
			hasCounty : false,
			width : 360,
			height : 220,
			url : "${ctx}/wlpt/base/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				/* if (data.province) {
					str += data.province.NAME + "";
					$("#endaddress").val(str);
				} */
				if (data.city) {
					str += data.city.NAME + "";
					$("#endaddress").val(str);
				}
				if (str!=""){
					$("#endaddress").val(str);
				}else{
					$("#endaddress").val("");
				}

			}
		});
	});
</script>
</body>
</html>