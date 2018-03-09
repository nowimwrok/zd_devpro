<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>会员账户</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
        	var keyword='${keyword}';
    		$("#keyword").val(keyword);
        	$("#btnSubmit").click(
					function() {
						$("#searchForm").attr("action","${ctx}/wlpt/account/memberlist");
						$("#searchForm").submit();
					});
        	$("#btnExport").click(
					function() {
						top.$.jBox.confirm("确认要导出流水数据吗？","系统提示",function(v, h, f) {
											if (v == "ok") {
												$("#searchForm").attr("action","${ctx}/wlpt/account/exportMember");
										        $("#searchForm").submit();
											}
										},
										{
											buttonsFocus : 1
										});
						top.$('.jbox-body .jbox-icon').css(
								'top', '55px');
					});

        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style>
        th, td {
            text-align: center !important;
        }
    </style>
</head>
<body>
<form:form id="searchForm" action="${ctx}/wlpt/account/memberlist" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>搜索关键字 ：</label> <input id="keyword" name="keyword" htmlEscape="false" maxlength="40" placeholder="账户名、账户号" class="input-medium"/></li>
        <li><label>会员状态:</label> 
        <select style="width: 100px;" name="memberStatus">
            <option <c:if test="${memberStatus=='0'}">selected</c:if> value="0">全部</option>
            <option <c:if test="${memberStatus=='1'}">selected</c:if> value="1">正常</option>
            <option <c:if test="${memberStatus=='-1'}">selected</c:if> value="-1">冻结</option>
        </select>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary"type="button" value="查询"/></li>
        <li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
        <li style="float:right;"><label style="width: 100px;padding: 15px;">总会员数：<b>${body.totalMember}</b></label></li>     
        <li style="float:right;"><label style="width: 200px;padding: 15px;">总可用余额：<b>${body.totalBalance}</b>元</label></li>                        
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable"
       class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th style="width:12%;">会员ID</th>
        <th style="width:12%;">账户号</th>
        <th style="width:10%;">账户名</th>
        <th style="width:5%;">会员状态</th>
        <th style="width:5%;">账户规则</th>
        <th style="width:10%;">创建时间</th>
        <th style="width:12%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="item">
        <tr>
            <td><a href="${ctx}/wlpt/account/memberTwoFlowList?accountId=${item.json.mainAccounts.accountId}" title="点击查看记账流水">${item.json.memberId}</a></td>
            <td>${item.json.mainAccounts.bankAccount }</td>
            <td>${item.json.mainAccounts.accountName }</td>
            <td>${fns:getDictLabel(item.json.memberStatus,'memberStatus','')}</td>
            <td><c:if test="${item.user!=null}">${fns:getDictLabel(item.user.rule.type,'rule_type','')}</c:if></td>
            <td>${item.json.createTime}</td>
            <td><a href="${ctx}/wlpt/account/accountList?memberId=${item.json.memberId}" title="点击查看账户明细">账户明细</a>&nbsp;
                <c:if test="${item.user!=null}">
                    <a href="javascript:;" onclick="change('${item.user.rule.type}','${item.user.id}');">规则设置</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>


<script type="text/javascript">

    var change = function change(ruleType, userid) {
        var oldrule;
        if (ruleType == "1") {
            oldrule = "A类规则";
        } else if (ruleType == "2") {
            oldrule = "B类规则";
        } else if (ruleType == "3") {
            oldrule = "C类规则";
        }
        $.jBox($("#rule").html(), {
            title: "规则设置", buttons: {"关闭": true},
            bottomText: ""
        });
        $("#userid").val(userid);
        $("#oldrule").html(oldrule);
    }

</script>
	<script type="text/template" id="rule">
   <form action="${ctx}/wlpt/account/changeRule" method="post" enctype="multipart/form-data"
          style="padding-left:20px;text-align:center;" onsubmit="loading('正在设置，请稍等...');"><br/>
        <span>原规则：</span><span id="oldrule"></span>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
        <span>新规则：</span>
        <select name="rule.type" style="width:85px;">
        <c:forEach items="${fns:getDictList('rule_type')}" var="dict">
			<option value="${dict.value}">${dict.label}</option>
		</c:forEach>
        </select>
        <br/><br/>
        <input id="userid" name="id" type="hidden"/>
        <input class="btn btn-primary" type="submit" value="设置"/>
    </form>
	</script>

</body>
</html>