<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var execycle = '${bscJob.execycle}';
			var jobIntervalUnit = '${bscJob.jobIntervalUnit}'
			if(execycle != ''){
				setjob(execycle,jobIntervalUnit);
			}
			
			//执行方式
			$('#execycle').click(function () {
				setjob($("#execycle").val(),$("#jobIntervalUnit").val());
			})
			//执行周期
			$('#jobIntervalUnit').click(function () {
				setjobcen($("#jobIntervalUnit").val());
			})
			function setjob($execycle,$jobIntervalUnit){
				if($execycle != ''&& $execycle*1==1){
					$("#content2").show();
					$("#content1").hide();
					$("#jobIntervalUnit").val("")
					$("#jobcen").html("");
				}else{
					$("#content1").show();
					$("#content2").hide();
					$("#cronexpression").val("");
					setjobcen($jobIntervalUnit);
				}
			}
			function setjobcen($jobIntervalUnit){
				if($jobIntervalUnit != ''){
					if($jobIntervalUnit*1==0){
						$("#jobcen").html($("#jobInterval0").html());
						$("#intervalhour").attr("value","");
						$("#minute").attr("value",""); 
						$("#hour").attr("value","");
						$("#dayOfWeek").attr("value","");
						$("#dayOfMonth").attr("value","");
						
					}else if($jobIntervalUnit*1==1){
						$("#jobcen").html($("#jobInterval1").html());
						//清空数据
						$("#minute").attr("value","");
						$("#hour").attr("value","");
						$("#dayOfWeek").attr("value","");
						$("#dayOfMonth").attr("value","");
						$("#intervalminute").attr("value","");
					}else if($jobIntervalUnit*1==2){
						$("#jobcen").html($("#jobInterval2").html());
						//清空数据
						$("#intervalhour").attr("value","");
						$("#dayOfWeek").attr("value","");
						$("#dayOfMonth").attr("value","");
						$("#intervalminute").attr("value","");
					}else if($jobIntervalUnit*1==3){
						$("#jobcen").html($("#jobInterval3").html());
						//清空数据
						$("#intervalhour").attr("value","");
						$("#dayOfMonth").attr("value","");
						$("#intervalminute").attr("value","");
					}else if($jobIntervalUnit*1==4){
						$("#jobcen").html($("#jobInterval4").html());
						//清空数据
						$("#intervalhour").attr("value","");
						$("#dayOfWeek").attr("value","");
						$("#intervalminute").attr("value","");
					}else{
						$("#jobcen").html("");
						//清空数据
						$("#intervalhour").attr("value","");
						$("#minute").attr("value","");
						$("#hour").attr("value","");
						$("#dayOfWeek").attr("value","");
						$("#dayOfMonth").attr("value","");
						$("#intervalminute").attr("value","");
					}
					
				}
			}
			
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
		<li><a href="${ctx}/wlpt/bscJob/">任务列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/bscJob/form?id=${bscJob.id}">任务<shiro:hasPermission name="wlpt:bscJob:edit">${not empty bscJob.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:bscJob:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bscJob" action="${ctx}/wlpt/bscJob/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">任务执行代码：</label>
			<div class="controls">
				<form:input path="jobcode" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务类型：</label>
			<div class="controls">
			    <form:select path="jobtype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('jobtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务类：</label>
			<div class="controls">
				<form:input path="jobclass" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">执行方式：</label>
			<div class="controls">
			    <form:select path="execycle" class="input-xlarge " >
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('execycle')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		
		<div id="content1" class="control-group" style="display: none;">
			<label class="control-label">执行周期：</label>
			<div class="controls">
			    <form:select path="jobIntervalUnit" class="input-xlarge "  >
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('jobIntervalUnit')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span id="jobcen">
				
				</span>
			</div>
		</div>
		<div id="content2" class="control-group" style="display: none;">
			<label class="control-label">规则表达式：</label>
			<div class="controls">
				<form:input path="cronexpression" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否启用：</label>
			<div class="controls">
			    <form:select path="isenable" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否做日志记录：</label>
			<div class="controls">
			    <form:select path="islog" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">任务说明：</label>
			<div class="controls">
				<form:input path="jobdescription" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:bscJob:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<div  style="display: none;">
		
		<div id="jobInterval4">
			<input type="number" id="dayOfMonth"  name="dayOfMonth" value="${bscJob.dayOfMonth}"  min="0"  max="59" class="input-xlarge " style="width: 35px;"/>月
			<input type="number" id="hour"  name="hour" value="${bscJob.hour}" min="0"  max="23" class="input-xlarge " style="width: 35px;"/>时
			<input type="number" id="minute"  name="minute" value="${bscJob.minute}" min="0"  max="59" class="input-xlarge " style="width: 35px;"/>分
		</div>
		<div id="jobInterval3">
			<input type="number" path="dayOfWeek" id="dayOfMonth"  name="dayOfMonth" value="${bscJob.dayOfMonth}"  min="0"  max="52" class="input-xlarge " style="width: 35px;"/>周
			<input type="number" id="hour"  name="hour" value="${bscJob.hour}" min="0"  max="23" class="input-xlarge " style="width: 35px;"/>时
			<input type="number" id="minute"  name="minute" value="${bscJob.minute}" min="0"  max="59" class="input-xlarge " style="width: 35px;"/>分
		</div>
		<div id="jobInterval2">
			<input type="number" id="hour"  name="hour" value="${bscJob.hour}" min="0"  max="23" class="input-xlarge " style="width: 35px;"/>时
			<input type="number" id="minute"  name="minute" value="${bscJob.minute}" min="0"  max="59" class="input-xlarge " style="width: 35px;"/>分
		</div>
		
		<div id="jobInterval1">
			<input type="number" id="intervalhour"  name="intervalhour" value="${bscJob.intervalhour}" min="0"  max="23" class="input-xlarge " style="width: 35px;"/>时
		</div>
		<div id="jobInterval0">
			<input type="number" id="intervalminute"  name="intervalminute" value="${bscJob.intervalminute}" min="0"  max="59" class="input-xlarge " style="width: 35px;"/>分
		</div>
	</div>
	
</body>
</html>