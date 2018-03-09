<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保险管理</title>
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
	<form:form id="inputForm" modelAttribute="userInsurance" action="${ctx}/wlpt/userInsurance/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">保险品种：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.insurancetype}</label>
			</div>
		</div>
		<!-- 商业险 -->
		<c:if test="${userInsurance.insurlist.insuranceway eq 1 }">
			<c:if test="${not empty userInsurance.subtype }">
			<div class="control-group">
				<label class="control-label">本次购选保险：</label>
				<div class="controls">
					<c:forEach items="${fn:split(userInsurance.subtype,'|')}" var="val" varStatus="i" >
						<label class="lbl" style="margin-left: 10px;">${val}</label>
					</c:forEach>
				</div>
			</div>	
			</c:if>
		</c:if>
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
		
		<!-- 商业险 -->
		<c:if test="${userInsurance.insurlist.insuranceway eq 1 }">
			<div class="control-group">
				<label class="control-label">证件号：</label>
				<div class="controls">
					<label class="lbl">${userInsurance.cardNo}</label>
				</div>
			</div>
		</c:if>
		
		<!-- 货物险 -->
		<c:if test="${userInsurance.insurlist.insuranceway eq 0 }">
		<div class="control-group">
			<label class="control-label">被保货物名称：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.goodsname}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物类型：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.goodstype}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物价值：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.worth}</label>
			</div>
		</div>
		</c:if>
		
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
		
		<!-- 商业险 -->
		<c:if test="${userInsurance.insurlist.insuranceway eq 1 }">
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
		</c:if>
		
		<!-- 货物险 -->
		<c:if test="${userInsurance.insurlist.insuranceway eq 0 }">
			<div class="control-group">
				<label class="control-label">始发地：</label>
				<div class="controls">
					<label class="lbl">${userInsurance.shipAddress.province}${userInsurance.shipAddress.city}${userInsurance.shipAddress.district}</label>
				</div>
				<div class="controls">
					<label class="lbl">${userInsurance.shipAddress.address}</label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">目的地：</label>
				<div class="controls">
					<label class="lbl">${userInsurance.consignAddress.province}${userInsurance.consignAddress.city}${userInsurance.consignAddress.district}</label>
				</div>
				<div class="controls">
					<label class="lbl">${userInsurance.consignAddress.address}</label>
				</div>
			</div>

			<c:if test="${userInsurance.insurlist.insuranceway eq 1 }">
				<div class="control-group">
					<label class="control-label">商业险总计(元)：</label>
					<div class="controls">
						<form:input path="syxinsurancefeel" htmlEscape="false" maxlength="32" class="input-xlarge "/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">交强险总计(元)：</label>
					<div class="controls">
						<form:input path="jqxinsurancefeel" htmlEscape="false" maxlength="32" class="input-xlarge "/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">代收车船税(元)：</label>
					<div class="controls">
						<form:input path="taxfeel" htmlEscape="false" maxlength="32" class="input-xlarge "/>
					</div>
				</div>
			</c:if>

			<div class="control-group">
				<label class="control-label">理赔保险金额：</label>
				<div class="controls">
					<label class="lbl">${userInsurance.insuranceamount}元</label>
				</div>
			</div>
		</c:if>
		
		<div class="control-group">
			<label class="control-label">保险购买费用：</label>
			<div class="controls">
				<label class="lbl">${userInsurance.insurancefeel}元</label>
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
				<sys:ckfinder input="invoiceImg" readonly="true" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>

		<%-- <div class="control-group">
			<label class="control-label">运单号：</label>
			<div class="controls">
				<form:input path="orderno" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">保单状态：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge ">
				<form:option value="" label="" />
				<form:options items="${fns:getDictList('insurance_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保单号：</label>
			<div class="controls">
				<form:input path="insuranceNO" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">核保人信息：</label>
			<div class="controls">
				<form:input path="underwriting" htmlEscape="false" maxlength="32" class="input-xlarge "  placeholder="姓名／电话／日期"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">制单人信息：</label>
			<div class="controls">
				<form:input path="voucher" htmlEscape="false" maxlength="32" class="input-xlarge "  placeholder="姓名／电话／日期"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">经办人信息：</label>
			<div class="controls">
				<form:input path="agent" htmlEscape="false" maxlength="32" class="input-xlarge "  placeholder="姓名／电话／日期"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">银行流水号：</label>
			<div class="controls">
				<form:input path="serialNumber" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<c:if test="${userInsurance.insurlist.insuranceway eq 1 }">
			<div class="control-group">
				<label class="control-label">车辆所属：</label>
				<div class="controls">
					<form:input path="belongs" htmlEscape="false" maxlength="32" class="input-xlarge "/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">主挂信息：</label>
				<div class="controls">
					<form:input path="mainHang" htmlEscape="false" maxlength="32" class="input-xlarge "/>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">收费确认：</label>
			<div class="controls">
				<input name="chargeTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.chargeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">投保确认：</label>
			<div class="controls">
				<input name="insuredTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.insuredTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险开始：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险结束：</label>
			<div class="controls">
				<input name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">交强险开始：</label>
			<div class="controls">
				<input name="jqxstartTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.jqxstartTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交强险结束：</label>
			<div class="controls">
				<input name="jqxendTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${userInsurance.jqxendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">保单凭证：</label>
			<div class="controls">
			    <form:hidden id="voucherimg" path="voucherimg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="voucherimg" type="images" uploadPath="/insurance" selectMultiple="false" maxnumber="6" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		</div>
		<div class="control-group">
			<label class="control-label">理赔记录备注：</label>
			<div class="controls">
				<form:textarea path="ClaimsRecords" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:userInsurance:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		<tr>
			<th>险种</th>
			<th>保险金额(元)</th>
			<th>保险费用(元)</th>
			<th>是否不计免赔</th>
			<th>小计(元)</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${userInsurance.infoList}" var="info">
			<tr>
				<td>
						${info.name}
				</td>
				<td>
						${info.insuredamount}
				</td>
				<td>
						${info.insurancepremium}
				</td>
				<td>
						${fns:getDictLabel(info.isfranchise,'yes_no','')}
				</td>
				<td>
						${info.subtotal}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>