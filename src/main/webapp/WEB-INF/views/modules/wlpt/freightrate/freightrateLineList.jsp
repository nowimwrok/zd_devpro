<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>线路运价管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReset").click(function(){
				$("#startaddress").val('');
				$("#endaddress").val('');
				 $("#g_start").val(""); 
				$("#g_end").val('');
				$("#source").val('');
				location.href="${ctx}/wlpt/freightrate/freightrateLine?tabPageId=jerichotabiframe_71";
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/freightrate/freightrateLine/">线路运价列表</a></li>
		<shiro:hasPermission name="wlpt:freightrate:freightrateLine:edit"><li><a href="${ctx}/wlpt/freightrate/freightrateLine/form">线路运价添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="freightrateLine" action="${ctx}/wlpt/freightrate/freightrateLine?tabPageId=jerichotabiframe_71" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li style="margin-left: -60px;"><label>	起点：</label>
				<form:input path="startaddress" id="startaddress" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>	终点：</label>
				<form:input path="endaddress" id="endaddress" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>货源类型：</label>
				<form:select path="priceinfo.goodstype" id="source" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			<li><label>更新时间(开始)：</label>
				<input name="timeStart" type="text" id="g_start" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${freightrateLine.timeStart}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - (结束)：
				<input name="timeEnd" type="text" id="g_end" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${freightrateLine.timeEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" id="btnReset" value="重置" class="btn btn-primary"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
                <th>起点</th>
                <th>起点备注</th>
                <th>终点</th>
                <th>终点备注</th>
                <th>现价(吨/元)</th>
                <th>均价(吨/元)</th>
                <th>货物类型</th>
                <th>运输方式</th>
                <th>车辆长度(对应车型)(米)</th>
                <th>更新时间</th>
				<shiro:hasPermission name="wlpt:freightrate:freightrateLine:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="line">
			<tr>
				<td>${line.startaddress}</td>
                <td>${line.startaremarks}</td>
                <td>${line.endaddress}</td>
                <td>${line.endremarks}</td>

                <td>${line.priceinfo.newprice!=null?line.priceinfo.newprice:'0.00'}</td>
                <td>${line.priceinfo.averageprice!=null?line.priceinfo.averageprice:'0.00'}</td>
                <td>${fns:getDictLabel(line.priceinfo.goodstype, 'gsoddtype', '')}</td>
                <td>${line.priceinfo.modetranspor!=null?line.priceinfo.modetranspor:''}</td>
                <td>${line.priceinfo.carlength!=null?line.priceinfo.carlength:''}</td>
                <td><fmt:formatDate value="${line.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="wlpt:freightrate:freightrateLine:edit"><td>
    				<a href="${ctx}/wlpt/freightrate/freightrateLine/form?id=${line.frlineId}">修改</a>
    				<a href="${ctx}/wlpt/freightrate/freightratePriceinfo/form?pagetype=line&frlineId=${line.frlineId}">编辑价格</a>
					<a href="${ctx}/wlpt/freightrate/freightrateLine/delete?frlineId=${line.frlineId}" onclick="return confirmx('确认要删除该线路运价吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	
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