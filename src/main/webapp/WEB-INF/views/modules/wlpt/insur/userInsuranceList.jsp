<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保险管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#btnExport").click(function() {
			top.$.jBox.confirm("确认要导出车辆数据吗？", "系统提示", function(v, h, f) {
				if (v == "ok") {
					$("#searchForm").attr("action", "${ctx}/wlpt/userInsurance/export");
					$("#searchForm").submit();
				}
			}, {
				buttonsFocus : 1
			});
			top.$('.jbox-body .jbox-icon').css('top', '55px');
		});
		$("#btnSubmit").click(function() {
			$("#searchForm").attr("action", "${ctx}/wlpt/userInsurance/list");
			$("#searchForm").submit();
		});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/wlpt/userInsurance/list");
		$("#searchForm").submit();
		return false;
	}
</script>
	<style>
      #contentTable{
       width:1900px;
      }
	</style>
</head>
<body>
	<form:form id="searchForm" modelAttribute="userInsurance" action="${ctx}/wlpt/userInsurance/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>投保人姓名：</label>
				<form:input path="applicant" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>保单号：</label>
				<form:input path="insuranceNO" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>被保货物名称：</label>
				<form:input path="goodsname" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>货物类型：</label>
				<form:input path="goodstype" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>货物价值：</label>
				<form:input path="worth" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>车牌号：</label>
				<form:input path="carnumber" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>车辆类型：</label>
				<form:input path="cartype" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>总重量：</label>
				<form:input path="totalweight" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>始发地：</label>
				<form:input path="shipAddress.city" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>目的地：</label>
				<form:input path="consignAddress.city" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>保险品种：</label>
				<form:input path="insurancetype" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>更新日期：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${userInsurance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li><label>保单状态：</label>
			<form:select path="status" class="input-xlarge ">
				<form:option value="" label="" />
				<form:options items="${fns:getDictList('insurance_status')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/><input
				id="btnExport" class="btn btn-primary" type="button" value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>投保用户</th>
				<th>投保人姓名</th>
				<!-- <th>被保货物名称</th>
				<th>货物类型</th>
				<th>货物价值</th> -->
				<th>联系手机号</th>
				<th>联系地址</th>
				<th>车牌号</th>
				<th>车辆类型</th>
				<!-- <th>总重量</th> -->
				<!-- <th>始发地</th>
				<th>目的地</th> -->
				<th>保险品种</th>
				<th>理赔保险金额</th>
				<th>保险购买费用</th>
				<th>更新日期</th>
				<th>保单状态</th>
				<th>保单号</th>
				<!-- <th>运单单号</th> -->
				<shiro:hasPermission name="wlpt:userInsurance:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userInsurance">
			<tr>
				<td>
					${userInsurance.user.name}
				</td>
				<td>
					${userInsurance.applicant}
				</td>
				<%-- <td>
					${userInsurance.goodsname}
				</td>
				<td>
					${userInsurance.goodstype}
				</td>
				<td>
					${userInsurance.worth}
				</td> --%>
				<td>
					${userInsurance.applicantAddress.linkmobile}
				</td>
				<td>
					${userInsurance.applicantAddress.province}${userInsurance.applicantAddress.city}${userInsurance.applicantAddress.district}
				</td>
				<td>
					${userInsurance.carnumber}
				</td>
				<td>
					${userInsurance.cartype}
				</td>
				<%-- <td>
					${userInsurance.totalweight}
				</td>
				<td>
					${userInsurance.shipAddress.province}${userInsurance.shipAddress.city}${userInsurance.shipAddress.district}
				</td>
				<td>
					${userInsurance.consignAddress.province}${userInsurance.consignAddress.city}${userInsurance.consignAddress.district}
				</td> --%>
				<td>
					${userInsurance.insurancetype}
				</td>
				<td>
					${userInsurance.insuranceamount}
				</td>
				<td>
					${userInsurance.insurancefeel}
				</td>
				<td>
					<fmt:formatDate value="${userInsurance.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${fns:getDictLabel(userInsurance.status, 'insurance_status', '')}</td>
				<%-- 
				<td>
					${userInsurance.orderno}
				</td> --%>
				<td>${userInsurance.insuranceNO}</td>
				<shiro:hasPermission name="wlpt:userInsurance:edit"><td>
					<c:if test="${userInsurance.insurlist.ismeasure==0 }">
    					<a href="${ctx}/wlpt/userInsurance/form?id=${userInsurance.id}">受理</a>
    				</c:if>
    				<c:if test="${userInsurance.insurlist.ismeasure==1 && userInsurance.measurestatus==1 }">
    					<a href="${ctx}/wlpt/userInsurance/form?id=${userInsurance.id}">受理</a>
    				</c:if>
    				<c:if test="${userInsurance.insurlist.ismeasure==1 && userInsurance.measurestatus!=1}">
    					<a href="${ctx}/wlpt/userInsurance/insurancemeasure?id=${userInsurance.id}">测算</a>
    				</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>