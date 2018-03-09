<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保险测算</title>
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
	<form:form id="inputForm" modelAttribute="userInsurance" action="${ctx}/wlpt/userInsurance/measuresave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<label class="control-label">保险品种：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.insurancetype}</label>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">投保人姓名：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.applicant}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">投保定位：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.applicantUnit}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">联系电话：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.applicantAddress.linkmobile}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">证件号：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.cardNo}</label>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">联系地址：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.applicantAddress.province}${userInsurance.applicantAddress.city}${userInsurance.applicantAddress.district}</label>
			</div>
			<div class="controls">
				<label class="lbl">${userInsurance.applicantAddress.address}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车牌号：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.carnumber}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆类型：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.cartype}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">厂牌型号：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.carmodel}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总重量：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.totalweight}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆核对重量：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.carweight}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">核定载客(人)：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.passengersnum}</label>
			</div>
			
		</div>
		<div class="control-group">
			<label class="control-label">使用性质：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.usecharacter}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">识别代码：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.vin}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发动机号码：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.engineNo}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登记日期：</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${userInsurance.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">营业执照或身份证：</label>
			<div class="controls">
				<form:hidden id="idCardImg" path="idCardImg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="idCardImg" readonly="true" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">行驶证：</label>
			<div class="controls">
				<form:hidden id="vehicleLicenseImg" path="vehicleLicenseImg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="vehicleLicenseImg" readonly="true" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">合格证：</label>
			<div class="controls">
				<form:hidden id="qualifiedImg" path="qualifiedImg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="qualifiedImg" readonly="true" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发票照片：</label>
			<div class="controls">
				<form:hidden id="invoiceImg" path="invoiceImg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="voucherimg" readonly="true" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		<c:if test="${not empty userInsurance.subtype }">
			<div class="control-group">
				<label class="control-label">本次购选保险：</label>
				<div class="controls">
					<c:forEach items="${fn:split(userInsurance.subtype,'|')}" var="val" varStatus="i" >
						<label class="lbl" style="margin-left: 10px;">${val}</label>
					</c:forEach>
				</div>
			</div>
			<c:forEach items="${fn:split(userInsurance.subtype,'|')}" var="val" varStatus="status" >
				<div class="control-group">
					<label class="control-label">${val}：</label>
					<div class="controls">
						<form:hidden path="infoList[${status.index}].name" value="${val}"/>
						<form:input number = "true" style="width: 10%;" path="infoList[${status.index}].insuredamount" class="input-xlarge " htmlEscape="false" maxlength="20" placeholder="保险金额" />
						<form:input number = "true" style="width: 10%;" path="infoList[${status.index}].insurancepremium" class="input-xlarge " htmlEscape="false" maxlength="20" placeholder="保险费用" />
						<form:select style="width: 12%;" path="infoList[${status.index}].isfranchise" class="input-xlarge "  placeholder="是否不计免赔">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<form:input number = "true" style="width: 10%;" path="infoList[${status.index}].subtotal" class="input-xlarge " htmlEscape="false" maxlength="20" placeholder="小计" />
					</div>
				</div>
			</c:forEach>
		</c:if>
		<div class="control-group">
			<label class="control-label">商业险总计(元)：</label>
			<div class="controls">
				<form:input number = "true"  path="syxinsurancefeel" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交强险总计(元)：</label>
			<div class="controls">
				<form:input number = "true"  path="jqxinsurancefeel" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">代收车船税(元)：</label>
			<div class="controls">
				<form:input number = "true"  path="taxfeel" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保单费用(元)：</label>
			<div class="controls">
				<form:input number = "true"  path="insurancefeel" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>


		<div class="form-actions">
			<shiro:hasPermission name="wlpt:userInsurance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>