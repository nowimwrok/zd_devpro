<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>争议信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
	});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/user/userDispute/">争议信息列表</a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userDispute"
		action="${ctx}/wlpt/user/userDispute/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="orderinfo.id" />
		<sys:message content="${message}" />

		<div class="control-group">
			<label class="control-label">争议运单号：</label>
			<div class="controls">${userDispute.orderno}</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单运费：</label>
			<div class="controls">
				<fmt:formatNumber value="${userDispute.orderinfo.totalcost}"></fmt:formatNumber>
				元
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上支付金额：</label>
			<div class="controls">
				<fmt:formatNumber value="${userDispute.orderinfo.payinfo.onlineamount}"></fmt:formatNumber>
				元
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上支付卓币：</label>
			<div class="controls">
				<fmt:formatNumber value="${userDispute.orderinfo.payinfo.coinamount}"></fmt:formatNumber>
				币
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单生成时间：</label>
			<div class="controls">
				<fmt:formatDate value="${userDispute.orderinfo.createDate}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单更新时间：</label>
			<div class="controls">
				<fmt:formatDate value="${userDispute.orderinfo.updateDate}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物名称：</label>
			<div class="controls">${userDispute.goodsname}</div>
		</div>
		<div class="control-group">
			<label class="control-label">货物吨数：</label>
			<div class="controls">
				<fmt:formatNumber
					value="${userDispute.orderinfo.quoteinfo.goods.freightvolume}"></fmt:formatNumber>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提货吨数：</label>
			<div class="controls">
				<fmt:formatNumber value="${userDispute.takeloadweight}"></fmt:formatNumber>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货卸吨数：</label>
			<div class="controls">
				<fmt:formatNumber value="${userDispute.unloadweight}"></fmt:formatNumber>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布货物时间：</label>
			<div class="controls">
				<fmt:formatDate
					value="${userDispute.orderinfo.quoteinfo.goods.createDate}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">争议说明：</label>
			<div class="controls">${userDispute.disputeinfo}</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理状态：</label>
			<div class="controls">
				<form:select id="status" path="status" class="input-xlarge ">
					<form:options items="${fns:getDictList('dispute_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		</div>
		<div class="control-group">
			<label class="control-label">争议金额：</label>
			<div class="controls">
				<form:input id="disputemoney" path="disputemoney" htmlEscape="false"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">争议类型：</label>
			<div class="controls">
				<form:select path="disputetype" id="disputetype" class="input-xlarge " cssClass="required">
                    <form:options items="${fns:getDictList('disputetype')}" itemLabel="label" itemValue="value"
                                  htmlEscape="false" />
                </form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理人姓名：</label>
			<div class="controls">
				<form:input id="dealname" path="dealname" htmlEscape="false"
					maxlength="32" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理人电话：</label>
			<div class="controls">
				<form:input id="dealphone" path="dealphone" htmlEscape="false"
					maxlength="32" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">争议处理反馈：</label>
			<div class="controls">
				<form:input id="disputecontent" path="disputecontent"
					htmlEscape="false" rows="4" maxlength="55" class="input-xlarge " />
			</div>

			<div class="form-actions">
				<c:if test="${userDispute.status!=2}">
					<shiro:hasPermission name="wlpt:user:userDispute:edit">
						<input id="btnSubmit" class="btn btn-primary" type="button"
							onclick="save()" value="保 存" />&nbsp;</shiro:hasPermission>
				</c:if>
				<input id="btnCancel" class="btn" type="button" value="返 回"
					onclick="history.go(-1)" />
			</div>
		</div>
	</form:form>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>

	<script type="text/javascript">
	$(document).ready(function () {
	//发起争议
	$("#disputetype").click(function () {
		var actualamount='${userDispute.orderinfo.payinfo.actualamount}';
		var onlineamount='${userDispute.orderinfo.payinfo.onlineamount}';
		var disputetype = $("#disputetype").val();//争议类型：0为普通争议，1为全额争议
		if(disputetype*1==1){
			if (onlineamount*1<=0) {
				$("#disputemoney").tips({
					side : 3,
					msg : '该运单不允许全额争议，运单线上支付金额为0',
					bg : '#AE81FF',
					time : 2
				});
				$("#disputemoney").focus();
				return false;
			}
        
			var isonlinepay='${userDispute.orderinfo.isonlinepay}';//是否线上支付
			var isprepay='${userDispute.orderinfo.isprepay}';//线上是否预支付
			var isprecoin='${userDispute.orderinfo.isprecoin}';//是否卓币支付
			if(isonlinepay*1!=1){
				$("#disputetype").tips({
		   			side : 3,
		   			msg : '该运单为线下支付不支持全额退款争议',
		   			bg : '#00A2E9',
		   			time : 3
		   		   });
		   		   return false;
			}
			if(isprepay*1==1){
				$("#disputetype").tips({
		   			side : 3,
		   			msg : '该运单存在预支付不支持全额退款争议',
		   			bg : '#00A2E9',
		   			time : 3
		   		   });
		   		   return false;
			}
			if(isprecoin*1==1){
				$("#disputetype").tips({
		   			side : 3,
		   			msg : '该运单存在卓币预支付不支持全额退款争议',
		   			bg : '#00A2E9',
		   			time : 3
		   		   });
		   		   return false;
			}
			$("#disputemoney").attr("readonly", "true");//全额争议，争议金额不可手动输入
			$("#disputemoney").val(onlineamount);//全额争议，争议金额为实际支付金额
			
		}else{
			 $("#disputemoney").removeAttr("readonly");
			 if(parseFloat($("#disputemoney").val())>parseFloat(onlineamount)*0.5){
	    	   $("#disputemoney").tips({
	   			side : 3,
	   			msg : '争议金额不能大于实际支付金额的50%',
	   			bg : '#00A2E9',
	   			time : 3
	   		   });
	   		   return false;
	        }
		}
	});
	});
		function save() {
			var isnul = true;
			var actualamount = '${userDispute.disputemoneybefore}';
			isnul = isnul && $("#status").valid({
				methods : "required"
			});
			isnul = isnul && $("#disputemoney").valid({
				methods : "required|isdecimal"
			});
			
			var actualamount='${userDispute.orderinfo.payinfo.actualamount}';
			var onlineamount='${userDispute.orderinfo.payinfo.onlineamount}';
			var disputetype = $("#disputetype").val();//争议类型：0为普通争议，1为全额争议
			if(disputetype*1==1){
				
				if (onlineamount*1<=0) {
					$("#disputemoney").tips({
						side : 3,
						msg : '该运单不允许全额争议，运单线上支付金额为0',
						bg : '#AE81FF',
						time : 2
					});
					$("#disputemoney").focus();
					return false;
				}
				var isonlinepay='${userDispute.orderinfo.isonlinepay}';//是否线上支付
				var isprepay='${userDispute.orderinfo.isprepay}';//线上是否预支付
				var isprecoin='${userDispute.orderinfo.isprecoin}';//是否卓币支付
				if(isonlinepay*1!=1){
					$("#disputetype").tips({
			   			side : 3,
			   			msg : '该运单为线下支付不支持全额退款争议',
			   			bg : '#00A2E9',
			   			time : 3
			   		   });
			   		   return false;
				}
				if(isprepay*1==1){
					$("#disputetype").tips({
			   			side : 3,
			   			msg : '该运单存在预支付不支持全额退款争议',
			   			bg : '#00A2E9',
			   			time : 3
			   		   });
			   		   return false;
				}
				if(isprecoin*1==1){
					$("#disputetype").tips({
			   			side : 3,
			   			msg : '该运单存在卓币预支付不支持全额退款争议',
			   			bg : '#00A2E9',
			   			time : 3
			   		   });
			   		   return false;
				}
				$("#disputemoney").attr("readonly", "true");//全额争议，争议金额不可手动输入
				$("#disputemoney").val(onlineamount);//全额争议，争议金额为实际支付金额
				
			}else{
				 $("#disputemoney").removeAttr("readonly");
				 if (parseFloat($("#disputemoney").val()) > parseFloat(onlineamount)*0.5) {
						$("#disputemoney").tips({
							side : 3,
							msg : '争议金额不能超过运单线上支付金额的50%',
							bg : '#AE81FF',
							time : 2
						});
						$("#disputemoney").focus();
						return false;
					}
			}
			
			isnul = isnul && $("#dealname").valid({
				methods : "required|isName"
			});
			isnul = isnul && $("#dealphone").valid({
				methods : "required|isPhone"
			});
			isnul = isnul && $("#disputecontent").valid({
				methods : "required|string"
			});
			if (!isnul) {
				return false;
			}

			$("#inputForm").submit();
		}
	</script>
</body>
</html>