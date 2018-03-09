<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>车源大厅</title>
	<meta name="decorator" content="default"/>
	
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/car/carHall">车辆大厅</a></li>
		<li class="active"><a href="${ctx}/wlpt/car/detail?id=${car.id}">车辆<shiro:lacksPermission name="wlpt:car:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="car" action="${ctx}/wlpt/car/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户Id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${car.user.id}" labelName="user.name" labelValue="${car.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否会员车辆：</label>
			<div class="controls">
				<form:input path="ismembercar" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车牌号：</label>
			<div class="controls">
				<form:input path="carnumber" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车型：</label>
			<div class="controls">
				<form:input path="cartype" htmlEscape="false" maxlength="10" class="input-xlarge "/>
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
				<form:input path="lengthunit" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">载重：</label>
			<div class="controls">
				<form:input path="loadweight" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">载重单位：</label>
			<div class="controls">
				<form:input path="weightunit" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">主营路线：</label>
			<div class="controls">
				<form:input path="mainroad" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主姓名：</label>
			<div class="controls">
				<form:input path="ownername" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主手机：</label>
			<div class="controls">
				<form:input path="ownermobile" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">常停放位置：</label>
			<div class="controls">
				<form:input path="oftenparkedposition" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆类型：</label>
			<div class="controls">
				<form:input path="issocialcar" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">定位手机：</label>
			<div class="controls">
				<form:input path="locationmobile" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">订单数：</label>
			<div class="controls">
				<form:input path="tradecount" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">行驶证照片：</label>
			<div class="controls">
				<form:hidden id="travellicimg" path="travellicimg" htmlEscape="false" maxlength="500" class="input-xlarge"/>
				<sys:ckfinder input="travellicimg" type="files" uploadPath="/wlpt/car" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆外观照片：</label>
			<div class="controls">
				<form:hidden id="carsurfaceimg" path="carsurfaceimg" htmlEscape="false" maxlength="500" class="input-xlarge"/>
				<sys:ckfinder input="carsurfaceimg" type="files" uploadPath="/wlpt/car" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主身份证：</label>
			<div class="controls">
				<form:input path="owneridcardnum" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主身份证图片：</label>
			<div class="controls">
				<form:hidden id="owneridcardimg" path="owneridcardimg" htmlEscape="false" maxlength="100" class="input-xlarge"/>
				<sys:ckfinder input="owneridcardimg" type="files" uploadPath="/wlpt/car" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">道路运输许可证：</label>
			<div class="controls">
				<form:hidden id="transportcardimg" path="transportcardimg" htmlEscape="false" maxlength="500" class="input-xlarge"/>
				<sys:ckfinder input="transportcardimg" type="files" uploadPath="/wlpt/car" selectMultiple="true"/>
			</div>
		</div>
		<div class="form-actions">
			
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>