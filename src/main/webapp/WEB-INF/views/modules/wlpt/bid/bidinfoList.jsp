<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招标信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出用户数据统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/bid/bidinfo/bidinfoExport");
							$("#searchForm").submit();
						}
					},
					{
						buttonsFocus : 1
					});
				top.$('.jbox-body .jbox-icon').css('top', '55px');
			});
			$("#btnSubmit").click(function() {
				$("#searchForm").attr("action","${ctx}/wlpt/bid/bidinfo/");
				$("#searchForm").submit();
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<script type="text/javascript" src="/static/common/global.js"></script>
	<style type="text/css">
	   .detail-row{
	     display: none;
	   }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/bid/bidinfo/">招标信息列表</a></li>
	<%-- 	<shiro:hasPermission name="wlpt:bid:bidinfo:edit"><li><a href="${ctx}/wlpt/bid/bidinfo/form">招标信息添加</a></li></shiro:hasPermission>  --%>
	</ul>
	<form:form id="searchForm" modelAttribute="bidinfo" action="${ctx}/wlpt/bid/bidinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>招标文号：</label>
				<form:input path="bidcode" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>招标状态：</label>
				<form:select path="bidstatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('bid_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>招标截止时间：</label>
				<input name="beginEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bidinfo.beginEndtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - 
				<input name="endEndtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bidinfo.endEndtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li>
				<label>发布时间：</label>
				<input name="beginPublishtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bidinfo.beginPublishtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - 
				<input name="endPublishtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bidinfo.endPublishtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出" />
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id=table_report class="table table-striped table-bordered table-hover">
		<thead>
			<tr>
			    <th>序号</th>
			    <th>详情</th>
				<th>标招文号</th>
				<th>招标用户</th>
				<th>货物名称</th>
				<th>招标吨数</th>
				<th>招标价</th>
				<th>整标价</th>
				<th>始发地</th>
				<th>目的地</th>
				<th>招标状态</th>
				<th>招标时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${varList.list}" var="bidinfo" varStatus="vs">
			<tr>
			    <td class='center' style="width: 30px;">${vs.index+1}</td>
			    <td>
			        <a href="javascript:;" onclick="detail(this);">查看</a>
				</td>
				<td>
					${bidinfo.bidcode}
				</td>
				<td>
					${bidinfo.biduser.loginName}
				</td>
				<td>
					${bidinfo.goods.goodsname}
				</td>
				<td>
				    ${bidinfo.goods.freightvolume}
				</td>
				<td>
				    ${bidinfo.expectedprice}
				</td>
				<td>
				    ${bidinfo.expectedprice*bidinfo.goods.freightvolume}
				</td>
				<td>
				    ${bidinfo.goods.shipAddress.province}${bidinfo.goods.shipAddress.city}
				</td>
				<td>
				    ${bidinfo.goods.consignAddress.province}${bidinfo.goods.consignAddress.city}
				</td>
				<td>
					${fns:getDictLabel(bidinfo.bidstatus, 'bid_status', '')}
				</td>
				<td>
					<fmt:formatDate value="${bidinfo.publishtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			<tr class="detail-row">
								<td colspan="12">
									<table class="table table-condensed">
										<thead>
											<th>竞标方</th>
											<th>联系方式</th>
											<th>竞标单价</th>
											<th>竞标总价</th>
											<th>是否中标</th>
											<th>竞标时间</th>
											<th>是否缴纳保证金</th>
										</thead>
										<tbody>
										<c:forEach items="${bidinfo.biddingList}" var="bidding">
												<tr>
													<td>${bidding.linkman}</td>
													<td>${bidding.linkphone}</td>
													<td>${bidding.biddingprice}</td>
													<td>${bidding.biddingprice*bidinfo.goods.freightvolume}</td>
													<td>
														${fns:getDictLabel(bidding.biddingstatus, 'bidding_status', '')}
													</td>
													<td>${bidding.formatCreateDate}</td>
													<td>
														${not empty bidding.guarantee?"是":"否"}
													</td>
												</tr>
										</c:forEach>
										</tbody>
									</table>
								</td>
							</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${varList}</div>
	<script type="text/javascript">
       function detail(e){
    	   $(e).closest('tr').next().toggleClass('detail-row');
       }
	</script>
	
</body>
</html>