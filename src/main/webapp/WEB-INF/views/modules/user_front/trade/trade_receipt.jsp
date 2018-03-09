<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>上传凭据</title>


<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<style type="text/css">
em {
	font-style: normal;
	font-weight: 700;
	font-family: sans-serif;
}

.tracktab td {
	height: 20px;
	margin: 0px;
	padding: 0px;
}

.ratings li {
	height: 40px;
	line-height: 40px;
}

.lift li {
	float: left;
	margin-right: 15px;
}

input[type='button'] {
	display: inline-block;
	font-size: 10px;
	background-color: white;
	border: solid 1px #CCC;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 30px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
	font-size: 16px;
}

.ic_img img {
	width: 25px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_val div {
	float: left;
	word-wrap: break-word;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.timeline-content p {
	width: 100%;
	border-top: 1px solid #CCC;
	padding-top: 5px;
}

h2 {
	font-size: 18px;
}

#timeline .timeline-item .timeline-content h2 {
	padding: 10px;
}

.sub-reListOrder table {
	width: 90%;
	border: 1px solid #000;
	font-size: 12px;
	margin: 20px auto;
}

.sub-reListOrder table td {
	width: 9%;
	border: 1px solid #000;
	text-align: center;
	height: 20px;
	color: #000;
	font-size: 14px;
}

.sub-reListOrder table td div {
	color: #000;
	font-size: 14px;
}

#subReceiptBtn, #btn-warning {
	margin: 10px;
	width: 200px;
}

.white {
	color: white;
	margin-left: 80px;
}

.page-title {
	border-left: 5px solid #368dff;
	text-indent: 10px;
}

#loading_lock {
	width: 100%;
	height: 100%;
	z-index: 999;
	position: fixed;
	background-color: rgba(165, 160, 154, 0.34);
	top: 0px;
	text-align: center;
}

#loading_lock img {
	margin-top: 25%;
}
</style>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/lightbox/css/lightbox.min.css" />
<script src='${ctxStatic }/lightbox/js/lightbox.min.js' type="text/javascript"></script>
</head>
<body scroll="no" style="width: 85%; margin: 0 auto;">
	<div>
		<div class="page-title page_title_small printhide"
			style="margin: 0px;">提货单</div>
		<input type="hidden" id="orderid" value="${orderinfo.id}" />
		<div style='margin-left: 30px; padding-top: 10px; line-height: 25px;'>
			1、提货、出库证明是司机装车的凭据，也是开始记录运单运输轨迹的开始时间。 <br />
			2、为了货主以及收货人能及时了解运单状况，请务必要及时上传装车证明照片。 <br /> 3、提货、出库证明由司机上传。<br />
			<div>
				4、图片大小不超过3M，限上传<span class="color_red">1</span>张，支持JPG、JPEG、PNG格式
			</div>
			<div>
				5、提货单上传后可以更改，包括第一次上传一共可以上传5次，剩余上传次数<span
					style="font-weight: bold; color: red;" id="startUpCount">${takeGoods.updatecount!=null?takeGoods.updatecount:'5'}</span>
			</div>
			<br>
			<div>
				<input type="hidden" id="takegoods" value="${takeGoods.receiptimg}"
					htmlEscape="false" maxlength="255" class="input-xlarge" />
				<c:choose>
					<c:when test="${takeGoods.updatecount<1}">
						<sys:ckfinder input="takegoods" type="images"
							uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
							maxHeight="100" readonly="true" />
					</c:when>
					<c:otherwise>
						<c:if
							test="${(orderinfo.orderstatus==3||orderinfo.orderstatus==1)&&orderinfo.isBuyer==true}">
							<sys:ckfinder input="takegoods" type="images"
								uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
								maxHeight="100" />
						</c:if>
						<c:if
							test="${(orderinfo.orderstatus!=3&&orderinfo.orderstatus!=1)||orderinfo.isBuyer==false}">
							<sys:ckfinder input="takegoods" type="images"
								uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
								maxHeight="100" readonly="true" />
						</c:if>
					</c:otherwise>
				</c:choose>
				<%-- <img id="showtakegoodsimg"
					src="${ctxStatic }/images/wlptfront/photo.png" class="photo-dis"
					style="display: none;"> --%>

			</div>
			<c:if
				test="${(orderinfo.orderstatus==3||orderinfo.orderstatus==1)&&orderinfo.isBuyer==true}">
				<button class="btn btn-defalut btn-warning" id="btn-warning"
					onclick="saveTakeGoods()">上传提货单</button>
			</c:if>
		</div>


	</div>
	<div style='margin-top: 30px;'>
		<div class="page-title page_title_small printhide"
			style="margin: 0px; margin-bottom: 28px;">回执单</div>

		<div style='margin-left: 30px; line-height: 25px;'>
			1、回执单是司机证明货物已经送到的重要电子凭据，请上传回执单后，继续保留纸质回执单。<br />
			2、上传回执单后，货主确认交易完成，运费支付给司机账号。<br /> 3、回执单由司机上传。<br />
			<div>
				4、图片大小不超过3M，限上传<span class="color_red">1</span>张，支持JPG、JPEG、PNG格式
			</div>
			<div>
				5、回执单上传后可以更改，包括第一次上传一共可以上传5次，剩余上传次数<span
					style="font-weight: bold; color: red;" id="endUpCount">${tradeReceipt.updatecount!=null?tradeReceipt.updatecount:'5'}</span>
			</div>
			<br />
			<div>
				<input type="hidden" id="receipt" value="${tradeReceipt.receiptimg}"
					htmlEscape="false" maxlength="255" class="input-xlarge" />
				<c:choose>
					<c:when test="${tradeReceipt.updatecount<1}">
						<sys:ckfinder input="receipt" type="images"
							uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
							maxHeight="100" readonly="true" />
					</c:when>
					<c:otherwise>
						<c:if
							test="${(orderinfo.orderstatus=='3'||orderinfo.orderstatus=='4')&&orderinfo.isBuyer==true}">
							<sys:ckfinder input="receipt" type="images"
								uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
								maxHeight="100" />
						</c:if>
						<c:if
							test="${(orderinfo.orderstatus!='3'&&orderinfo.orderstatus!='4')||orderinfo.isBuyer==false}">
							<sys:ckfinder input="receipt" type="images"
								uploadPath="/tradereceipt" selectMultiple="false" maxWidth="100"
								maxHeight="100" readonly="true" />
						</c:if>
					</c:otherwise>
				</c:choose>
				<%-- <img id="showreceiptimg"
					src="${ctxStatic }/images/wlptfront/photo.png" class="photo-dis"
					style="display: none;"> --%>

			</div>
			<c:if
				test="${(orderinfo.orderstatus=='3'||orderinfo.orderstatus=='4')&&orderinfo.isBuyer==true}">

				<button class="btn btn-defalut btn-warning" id="subReceiptBtn"
					onclick="saveTradeReceipt()">上传回执单</button>
			</c:if>
		</div>

	</div>
	<c:if
		test="${orderinfo.orderstatus!='0'&&orderinfo.orderstatus!='1'&&orderinfo.orderstatus!='2'&&orderinfo.orderstatus!='3'&&orderinfo.isonlinepay!='0'}">
		<div style='margin-top: 30px;'>
			<div class="page-title page_title_small printhide"
				style="margin: 0px; margin-bottom: 28px;">争议</div>

			<div style='margin-left: 30px; line-height: 25px;'>
				1、如承运方在实际运输过程运输完成的货物量与上传支付的数额有差异,货主可以发起争议。<br />
				2、请按实际运输填写发起争议所需信息,避免填写错误以免造成不必要损失。
				<div>3、发起争议后,工作人员会在24小时审核核对运输信息,核对完毕后将按结果处理修改运单所需支付运费的金额。</div>
				<div></div>
				<br />
				<div>
					<form:form id="inputForm" modelAttribute="orderinfo" action=""
						method="post" class="form-horizontal">
						<form:hidden path="id" />
						<div style="height: 40px; line-height: 20px;">
							<span style="">货物名称:</span><span style="padding-left: 16px;">
								<form:input id="goodsname" path="userDispute.goodsname"
									htmlEscape="false" maxlength="12" />
							</span>
						</div>
						<div style="height: 40px; line-height: 20px;">
							<span>提货吨数:</span><span style="padding-left: 20px;"><form:input
									id="takeloadweight" path="userDispute.takeloadweight"
									htmlEscape="false" maxlength="12" />吨</span>
						</div>
						<div style="height: 40px; line-height: 20px;">
							<span>卸货吨数:</span><span style="padding-left: 20px;"><form:input
									id="unloadweight" path="userDispute.unloadweight"
									htmlEscape="false" maxlength="12" />吨</span>
						</div>
						<div style="height: 40px; line-height: 20px;">
							<span>争议金额:</span><span style="padding-left: 20px;"><form:input
									id="disputemoney" path="userDispute.disputemoney"
									htmlEscape="false" maxlength="12" />元</span>
						</div>
						<div style="height: 40px; line-height: 20px;">
							<span>争议类型:</span>
							<span style="padding-left: 20px;">
								<form:select path="userDispute.disputetype" id="disputetype" class="input-xlarge " cssClass="required">
			                        <form:options items="${fns:getDictList('disputetype')}" itemLabel="label" itemValue="value"
			                                      htmlEscape="false" />
			                    </form:select>
								
							</span>
						</div>
						<div style="height: 50px; line-height: 50px;">
							<div style="width: 60px; float: left; text-align: right;">
								<span style="">理 由:</span>
							</div>
							<span style="padding-left: 20px; float: left;">
								<div>
									<form:textarea id="disputeinfo" path="userDispute.disputeinfo"
										style="margin-top: 5px;resize:none;" htmlEscape="false" rows="1" cols="50"
										maxlength="50" class="input-xxlarge " resize="none" />
								</div>
							</span>
						</div>
					</form:form>
				</div>
				<c:if
					test="${(orderinfo.orderstatus=='4'||orderinfo.orderstatus=='6')&&orderinfo.isBuyer==false}">
					<button class="btn btn-defalut btn-warning" id="subDisputeBtn"
						style="margin-left: 80px;" onclick="saveTradeDispute()">发起争议
					</button>
				</c:if>
			</div>

		</div>

		<div style='margin-top: 30px;'>
			<div class="page-title page_title_small printhide"
				style="margin: 0px; margin-bottom: 28px;">司机同意争议</div>
			<input type="hidden" id="disputeid"
				value="${orderinfo.userDispute.id}" />
			<div style='margin-left: 30px; line-height: 25px;'>
				1、司机是否同意对方发起的争议申请,如果同意请点击同意争议,如果觉得不符合请点击拒绝争议。<br />
				<!-- 2、
        <div>3、。</div> -->
				<div></div>
				<br />
				<div></div>
				<c:if
					test="${(orderinfo.orderstatus=='6')&&orderinfo.isBuyer==true}">
					<c:choose>
						<c:when
							test="${orderinfo.userDispute.disputeeverconfirmed=='0'&&orderinfo.userDispute.isreject=='0'}">
							<button class="btn btn-defalut btn-warning" id="agreeDisputeBtn"
								onclick="agreeDispute()">同意争议</button>
							<button class="btn btn-defalut btn-warning"
								id="disagreeDisputeBtn" onclick="disagreeDispute()">拒绝争议
							</button>
						</c:when>
						<c:when
							test="${orderinfo.userDispute.disputeeverconfirmed=='1'&&orderinfo.userDispute.isreject=='0'}">
							<button class="btn white">司机已同意</button>
						</c:when>
						<c:otherwise>
							<button class="btn white">司机不同意</button>
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if
					test="${(orderinfo.orderstatus=='6')&&orderinfo.isBuyer==false}">
					<c:choose>
						<c:when
							test="${orderinfo.userDispute.disputeeverconfirmed=='0'&&orderinfo.userDispute.isreject=='0'}">
							<button class="btn white">待司机同意</button>
						</c:when>
						<c:when
							test="${orderinfo.userDispute.disputeeverconfirmed=='1'&&orderinfo.userDispute.isreject=='0'}">
							<button class="btn white">司机已同意</button>
						</c:when>
						<c:otherwise>
							<button class="btn white">司机不同意</button>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>

		</div>
	</c:if>
	<div id="loading_lock" class="loading_lock" style="display: none;">
		<img src="${ctxStatic }/images/loading.gif">
		<p>等待中</p>
	</div>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
</body>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#loading_lock").show();

				var takeGoodsImg = '${takeGoods.receiptimg}';
				if (takeGoodsImg != null && takeGoodsImg != ""
						&& takeGoodsImg != "undefined") {
					$("#showtakegoodsimg").attr("src", takeGoodsImg);
					$("#showtakegoodsimg").show();
				}
				var receiptImg = '${tradeReceipt.receiptimg}';
				if (receiptImg != null && receiptImg != ""
						&& receiptImg != "undefined") {
					$("#showreceiptimg").attr("src", receiptImg);
					$("#showreceiptimg").show();
				}

				var disputeinfo = $("#disputeid").val();
				var isdispute = '${orderinfo.isdispute}';
				if (disputeinfo != null && disputeinfo != "") {
					if (isdispute != null && isdispute == '1') {
						$("#goodsname").attr("readonly", "true");
						$("#takeloadweight").attr("readonly", "true");
						$("#unloadweight").attr("readonly", "true");
						$("#disputeinfo").attr("readonly", "true");
						$("#disputemoney").attr("readonly", "true");
						$("#subDisputeBtn").hide();
					}
				}

				if (disputeinfo == null || disputeinfo == "") {
					$("#goodsname").attr("readonly", false);
					$("#takeloadweight").attr("readonly", false);
					$("#unloadweight").attr("readonly", false);
					$("#disputeinfo").attr("readonly", false);
					$("#disputemoney").attr("readonly", false);
					
					$("#goodsname").val('${orderinfo.quoteinfo.goods.goodsname}');
					$("#takeloadweight").val('${orderinfo.quoteinfo.actload}');
					$("#subDisputeBtn").show();
				}
				$("#loading_lock").hide();
			});
	//上传提货
	window.saveTakeGoods = function() {
		var orderid = $("#orderid").val();
		var takegoodsImg = $("#takegoods").val();
		if (takegoodsImg == null || takegoodsImg == ""
				|| takegoodsImg == undefined) {
			$.MsgBox.Alert("保存提示", "请选择提货凭据");
			return false;
		}
		$("#loading_lock").show();
		$.MsgBox.Confirm("温馨提示", "确定上传该提货凭据?", function() {

			$("#btn-warning").html("正在提交");
			$("#btn-warning").attr("disabled", "true");
			$("#btn-warning").css("background-color", "#ccc");
			$("#btn-warning").css("border-color", "#ccc");

			$.ajax({
				url : "${wlpt}/wlpt/trade/saveTradeTakeGoods",
				data : {
					id : orderid,
					receiptimg : takegoodsImg
				},
				dataType : 'json',
				cache : false,
				async : false,
				success : function(data) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("保存提示", data.message);
					parent.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true";
				}
			});
		}, function() {
			$("#loading_lock").hide();
		}, null, null, "确定", "取消");
	}
	//上传回单
	 window.saveTradeReceipt=function() {

		var orderid = $("#orderid").val();
		var receiptImg = $("#receipt").val();

		if (receiptImg == null || receiptImg == "" || receiptImg == undefined) {
			$.MsgBox.Alert("保存提示", "请选择回单凭据");
			return false;
		}

		$("#loading_lock").show();
		$.MsgBox.Confirm("温馨提示", "确定上传该回单凭据?", function() {
			$("#subReceiptBtn").html("正在提交");
			$("#subReceiptBtn").attr("disabled", "true");
			$("#subReceiptBtn").css("background-color", "#ccc");
			$("#subReceiptBtn").css("border-color", "#ccc");
			$("#loading_lock").show();
			$.ajax({
				url : "${wlpt}/wlpt/trade/saveTradeReceipt",
				data : {
					id : orderid,
					receiptimg : receiptImg
				},
				dataType : 'json',
				cache : false,
				async : false,
				success : function(data) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("保存提示", data.message);
					parent.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true";
				}
			});
		}, function() {
			$("#loading_lock").hide();
		}, null, null, "确定", "取消");
	}
	//发起争议
	$("#disputetype").click(function () {
		var actualamount='${orderinfo.payinfo.actualamount}';
		var onlineamount='${orderinfo.payinfo.onlineamount}';
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
			var isonlinepay='${orderinfo.isonlinepay}';//是否线上支付
			var isprepay='${orderinfo.isprepay}';//线上是否预支付
			var isprecoin='${orderinfo.isprecoin}';//是否卓币支付
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
			$("#disputemoney").val(onlineamount);//全额争议，争议金额为线上支付金额
			
		}else{
			 $("#disputemoney").removeAttr("readonly");
			 if(parseFloat($("#disputemoney").val())>parseFloat(actualamount)*0.5){
	    	   $("#disputemoney").tips({
	   			side : 3,
	   			msg : '争议金额不能大于实际支付金额的50%',
	   			bg : '#00A2E9',
	   			time : 3
	   		   });
	    	   $("#disputemoney").focus();
	   		   return false;
	        }
		}
	});
	
	window.saveTradeDispute=function() {
		var actualamount='${orderinfo.payinfo.actualamount}';
		var onlineamount='${orderinfo.payinfo.onlineamount}';
		
		var isnul = true;
		isnul = isnul && $("#goodsname").valid({
			methods : "required|string"
		});

		isnul = isnul && $("#takeloadweight").valid({
			methods : "required|isdecimal"
		});

		isnul = isnul && $("#unloadweight").valid({
			methods : "required|isdecimal"
		});

		isnul = isnul && $("#disputemoney").valid({
			methods : "required|isdecimal"
		});
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
			
			var isonlinepay='${orderinfo.isonlinepay}';//是否线上支付
			var isprepay='${orderinfo.isprepay}';//线上是否预支付
			var isprecoin='${orderinfo.isprecoin}';//是否卓币支付
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
			
		}else{
			 if(parseFloat($("#disputemoney").val())>parseFloat(actualamount)*0.5){
	    	   $("#disputemoney").tips({
	   			side : 3,
	   			msg : '争议金额不能大于实际支付金额的50%',
	   			bg : '#00A2E9',
	   			time : 3
	   		   });
	    	   $("#disputemoney").focus();
	   		   return false;
	        }
		}
		 isnul = isnul && $("#disputeinfo").valid({
				methods : "required|string"
			});
		if (!isnul) {
			return false;
		}
		$("#loading_lock").show();
		$.MsgBox.Confirm("温馨提示", "确定发起争议?", function() {
			$("#subDisputeBtn").html("正在提交");
			$("#subDisputeBtn").attr("disabled", "true");
			$("#subDisputeBtn").css("background-color", "#ccc");
			$("#subDisputeBtn").css("border-color", "#ccc");

			$.ajax({
				cache : true,
				type : "POST",
				url : "${wlpt}/wlpt/trade/saveTradeDispute",
				data : $('#inputForm').serialize(),// 你的formid
				async : false,
				error : function(request) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("系统提示", "数据异常,请联系平台人员");
				},
				success : function(data) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("操作提示", data.message);
					parent.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true";
				}
			});
		}, function() {
			$("#loading_lock").hide();
		}, null, null, "确定", "取消");
	}
	//同意争议
	window.agreeDispute=function () {
		$("#loading_lock").show();
		$.MsgBox.Confirm("温馨提示", "确定同意争议?", function() {
			$("#agreeDisputeBtn").attr("disabled", "true");
			$("#agreeDisputeBtn").css("background-color", "#ccc");
			$("#agreeDisputeBtn").css("border-color", "#ccc");
			$("#disagreeDisputeBtn").attr("disabled", "true");
			$("#disagreeDisputeBtn").css("background-color", "#ccc");
			$("#disagreeDisputeBtn").css("border-color", "#ccc");
			var disputeId = $("#disputeid").val();

			$.ajax({
				cache : false,
				type : "POST",
				url : "${wlpt}/wlpt/trade/isAgreeDispute",
				data : {
					id : disputeId,
					isreject : "0"
				},
				async : false,
				error : function(request) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("系统提示", "数据异常,请联系平台人员");
				},
				success : function(data) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("操作提示", data.message);
					parent.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true";
				}
			});
		}, function() {
			$("#loading_lock").hide();
		}, null, null, "确定", "取消");
	}
	//拒绝争议
	window.disagreeDispute=function() {
		$("#loading_lock").show();
		$.MsgBox.Confirm("温馨提示", "确定拒绝争议?", function() {
			$("#agreeDisputeBtn").attr("disabled", "true");
			$("#agreeDisputeBtn").css("background-color", "#ccc");
			$("#agreeDisputeBtn").css("border-color", "#ccc");
			$("#disagreeDisputeBtn").attr("disabled", "true");
			$("#disagreeDisputeBtn").css("background-color", "#ccc");
			$("#disagreeDisputeBtn").css("border-color", "#ccc");
			var disputeId = $("#disputeid").val();

			$.ajax({
				cache : false,
				type : "POST",
				url : "${wlpt}/wlpt/trade/isAgreeDispute",
				data : {
					id : disputeId,
					isreject : "1"
				},
				async : false,
				error : function(request) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("系统提示", "数据异常,请联系平台人员");
				},
				success : function(data) {
					$("#loading_lock").hide();
					$.MsgBox.Alert("操作提示", data.message);
					parent.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true";
				}
			});
		}, function() {
			$("#loading_lock").hide();
		}, null, null, "确定", "取消");
	}
</script>
</html>
