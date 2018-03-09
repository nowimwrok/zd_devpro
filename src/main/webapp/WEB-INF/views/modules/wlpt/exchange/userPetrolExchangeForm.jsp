<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>油气兑换余额审核</title>
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
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出一卡通消费明细申请信息数据吗？","系统提示",function(v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action","${ctx}/wlpt/exchange/userPetrolExchange/cardRecoditemExport?exchangeNo=${userPetrolExchange.exchangeNo}");
						$("#searchForm").submit();
					}
				},
				{
					buttonsFocus : 1
				});
				top.$('.jbox-body .jbox-icon').css('top', '55px');
			});
			
			
		});
		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action",
					"${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}");
			$("#searchForm").submit();
			return false;
		}
		function select(){
			("#searchForm").attr("action",
			"${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}");
					$("#searchForm").submit();
					return false;
				}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/exchange/userPetrolExchange/list">油气兑换余额审核列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}">油气兑换余额审核<shiro:hasPermission name="wlpt:exchange:userPetrolExchange:edit">${not empty userPetrolExchange.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:exchange:userPetrolExchange:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userPetrolExchange" action="${ctx}/wlpt/exchange/userPetrolExchange/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">兑换号：</label>
			<div class="controls">
				${userPetrolExchange.exchangeNo}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">兑换明细条数：</label>
			<div class="controls">
				${userPetrolExchange.exchangeCount}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总金额：</label>
			<div class="controls">	
				${userPetrolExchange.totalcost}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请人登陆名：</label>
			<div class="controls">
				${userPetrolExchange.user.loginName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请人手机号码：</label>
			<div class="controls">
				${userPetrolExchange.user.phone}
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-medium">
                <form:option value="1" label="申请中"/>
                <form:options items="${fns:getDictList('exchange_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:exchange:userPetrolExchange:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<div style="text-align: right;"><input id="btnExport" class="btn btn-primary" type="button"
				value="导出数据" /></div>
		</div>
	</form:form>
	<form:form id="searchForm" modelAttribute="userPetrolExchange"
		action="${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
	</form:form>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>单据号</th>
				<th>会员姓名</th>
				<th>商品编号</th>
				<th>商品名称</th>
				<th>商品数量</th>
				<th>商品单价</th>
				<th>实付金额</th>
				<th>操作店面</th>
				<th>工号</th>
				<th>备注</th>
				<th>操作时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="card">
			<tr>
				<td>
					${card.billnumber}
				</td>
				<td>
					${card.truename}
				</td>
				<td>
					${card.recorditem.barcode}
				</td>
				<td>
					${card.recorditem.gooditemname}
				</td>
				<td>
					${card.recorditem.number}
				</td>
				<td>
					${card.recorditem.oldprice}
				</td>
				<td>
					${card.totalpaid}
				</td>
				<td>
					${card.storename}
				</td>
				<td>
					${card.useraccount}
				</td>
				
				<td>
					${card.meno}
				</td>
				<td>
					<fmt:formatDate value="${card.operatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
