<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<title></title>
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"
	rel="stylesheet">
<link href="${ctxStatic }/front/css/bootstrap.min.css" rel="stylesheet">
<link href="${ctxStatic }/front/css/per_global.css" rel="stylesheet">
<link href="${ctxStatic }/front/css/personal.css" rel="stylesheet">
<link rel="stylesheet" href="${ctxStatic }/front/css/add.css" />
</head>
<body>
	<div class="row"></div>
	<div class="gas">
		<!--图片-->
		<div class="increase_ad">
			<img src="${ctxStatic }/images/wlptfront/img/increase/gas.jpg" alt="" />
		</div>
		<!--购买列表-->
		<div class="gas_list">
			<table>
				<caption class="text-primary">提交订单</caption>
				<form:form method="post" name="Form" id="Form"
					modelAttribute="shopVO" action="${wlpt}/wlpt/shop/toPay">
					<tr class="list_title">
						<th class="text-center">商品</th>
						<th class="text-center">单价（${shopVO.shotName=='you_qi'?'元':'元'}）</th>
						<th class="text-center">数量</th>
						<th class="text-center">小计（${shopVO.shotName=='you_qi'?'元':'元'}）</th>
						<th class="text-center">购买</th>
					</tr>
					<form:hidden path="name" />
					<form:hidden path="shotName" />
					<form:hidden path="price" />
					<input id="money" name="total" type="hidden" />
					<tr class="gas_show">
						<td class="text-center text_bold"><img
							src="${ctxStatic }/images/wlptfront/shop_img/${shopVO.shotName}.png"
							alt="" />${shopVO.name}</td>
						<td class="text-center gas_price">${shopVO.price}</td>
						<td class="text-center"><input id="num" name="num"
							type="number" min="1" value="1" class="text-center" /></td>
						<td class="text-center gas_total" id="total"></td>
						<td class="text-center">
							<button id="btnSubmit" class="btn btn-primary">立即购买</button>
						</td>
					</tr>
			</table>
			<c:if test="${not empty wxgift }">
				<div class="pur_notice">
					<h5>好消息:</h5>
					<p>活动名称：${wxgift.giftname }</p>
					<p>活动内容：${wxgift.giftcontent }</p>
					<input type="hidden" id="giftid" name="giftid"
						value="${wxgift.id }" />
				</div>
			</c:if>
		</div>
		</form:form>
		<c:if test="${shopVO.shotName=='zd_coin'}">
			<div class="gas_msg">
				<!--卓币购买须知-->
        <div class="buy_know">
        <h5>卓币购买须知:</h5>
            <p>
                1、本产品仅在卓大物流平台进行使用、消费；
            </p>
            <p>
                2、本产品购买后可在账户中心查看购买记录。
            </p>
        </div>
        </c:if>
        <c:if test="${shopVO.shotName=='you_qi'}">
				<!--购买需知-->
				<div class="buy_know">
					<div>
						<b>油气购买须知：</b>
					</div>
					<p>1、本产品内含100元的油气费用；</p>
					<p>2、本产品购买后可在油气账户查看，通过一卡通在加油站进行油气消费。</p>
				</div>
			</div>
		</c:if>
	</div>
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script>

		$('.gas_list tr').find('input[type=number]').bind(
				'input propertychange',
				function() {
					var num = $(this).val();
					var price = parseInt($(this).parent()
							.siblings('.gas_price').text());
					$(this).parent().siblings('.gas_total').text(num * price);
				});
	</script>
	<script type="text/javascript">
		var price = $("#price").val() * 1;
		var num = $("#num").val() * 1;
		var total = price * num;
		$("#total").html(total);
		$("#num").change(function() {
			var num = $("#num").val() * 1;
			if (num < 1) {
				$("#num").val(1);
				return false;
			}
			var total = price * num;
			$("#total").html(total);
		});
		$("#btnSubmit").click(function() {
			var isnul = true;
			isnul = isnul && $("#num").valid({
				methods : "required|isNum"
			});
			if (!isnul) {
				return false;
			}
			var num = $("#num").val() * 1;
			var total = price * num;
			if (num * 1 > 0 && total * 1 > 0) {
				$("#money").val(total);
				$("#Form").submit();
			} else {
				$.MsgBox.Alert("支付提示", "请至少购买1数量的商品");
				return false;
			}

		});
	</script>
</body>
</html>
