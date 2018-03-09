<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
<title>运单评价</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%--
	<meta name="decorator" content="site_personal_basic"/>
--%>

	<link rel="stylesheet"
	href="/static/modules/wlpt/front/js/raty/jquery.raty.css" />
<style type="text/css">
body {
	margin: 0px auto;
	 font-family: "微软雅黑"
     font-size: 14px;
}

.ol-content-div {
	margin: 0px auto;
	margin-top: 12px;
	width: 1000px;
	border: 1px solid #f2f2f2;
	margin-bottom: 20px;
}

.sub-title-div {
	height: 30px;
	line-height: 30px;
	margin-top: 2px;
	background: #F5F5F5;
}

.comment-div {
	border: 1px solid #d0e4c2;
	background: #fcfffa;
}

.ratings {
	margin: 20px;
}

.ratings li {
	height: 40px;
	line-height: 40px;
	list-style:none;
}
.lift li{float:left;margin-right:15px;list-style:none;}
#comment {
	height: 136px;
	padding: 0px;
	margin: 0px;
	line-height:20px;
}
.regbt {
            width: 100px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }

</style>

</head>

<body>
	<div class="ol-content-div">
		<input id="orderno" type="hidden" value="${order.orderno}"/>
		<input id="sellerid" type="hidden" value="${order.seller.id}"/>
		<input id="buyerid" type="hidden" value="${order.buyer.id}"/>
		<input id="userid" type="hidden" value="${user.id}"/>
		<input id="orderstatus" type="hidden" value="${order.orderstatus}"/>
		<table cellspacing="0" style="width:96%;line-height:24px; ">
			<thead>
				<tr height="32" style="width: 25%;color:#555;background:#e7e7e7;">
					<th style="width: 25%;">货物信息</th>
					<th style="width: 25%;">始发地-目的地</th>
					<th style="width: 25%;">车辆信息</th>
					<th style="width: 25%;">状态</th>
				</tr>
			</thead>
			<tbody id="order-templet">
				<tr>
					<td colspan="4">
						<div class="sub-title-div">
							<span style="float:left;padding:0px 20px;color:#666;">运单编号：<a>${order.orderno}</a></span>
							<span style="float:right;padding:0px 20px;color:#666;">提交时间：${order.showtime}</span>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align:center">${order.quoteinfo.goods.goodsname}|${fns:getDictLabel(order.quoteinfo.goods.gsoddtype,'gsoddtype','')}</td>
					<td style="text-align:center">
						<div>
							<span>始发地：${order.quoteinfo.goods.shipAddress.city}${order.quoteinfo.goods.shipAddress.district}</span> <br /> <span>目的地：${order.quoteinfo.goods.consignAddress.city}${order.quoteinfo.goods.consignAddress.district}</span>
						</div>
					</td>
					<td style="text-align:center;">
					${order.quoteinfo.car.carnumber}|${order.quoteinfo.car.cartype}<br />
					${order.quoteinfo.driver.loginName}|${order.quoteinfo.driver.phone}                                                  
					</td>
					<td id="orderstatus-td" style="text-align:center;">${fns:getDictLabel(order.orderstatus,'order_status','')}</td>
				</tr>
				<tr>
					<td colspan="4">
						<div class="comment-div">
							<table style="margin:0px auto;">
								<tr>
									<td colspan="3">
									<ul class="ratings lift">
										<li><input type="radio" <c:if test="${tradeComment.sellercommentlv eq '3' }">checked="checked"</c:if> name="sellercommentlv" value="3"/><img src="/static/images/wlptfront/good_comment.png"/>好评</li>
										<li><input type="radio" <c:if test="${tradeComment.sellercommentlv eq '2' }">checked="checked"</c:if> name="sellercommentlv" value="2"/><img src="/static/images/wlptfront/middle_comment.png"/>中评</li>
										<li><input type="radio" <c:if test="${tradeComment.sellercommentlv eq '1' }">checked="checked"</c:if> name="sellercommentlv" value="1"/><img src="/static/images/wlptfront/bad_comment.png"/>差评</li>
									</ul>
									</td>
								</tr>
								<tr>
									<td>
										<ul class="ratings">
											<li>服务态度：<span id="service"></span></li>
											<li>运输费用：<span id="price"></span></li>
											<li>运输时效：<span id="timer"></span></li>
											<li>货物安全：<span id="safe"></span></li>
										</ul>
									</td>
									<td><textarea id="comment" style="width:500px;    padding-top: 10px;" placeholder="用户尚未评价" rows="4" cols="2">${tradeComment.sellercomment }</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;">
										<c:if test="${order.iscomment eq '0' }">
											<input id="commit-comment" type="button" class="regbt" value="未评价" />
										</c:if>
										<input class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<script src="${ctxStatic}/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="/static/modules/wlpt/front/js/raty/jquery.raty.js"></script>
	<script src="/static/flash/zoom.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			 var service_score = ${tradeComment.serviceattitudepoint==''?tradeComment.serviceattitudepoint:0};
			 var price_score = ${tradeComment.transportationcostpoint==''?tradeComment.transportationcostpoint:0};
			 var timer_score = ${tradeComment.transportlimitationpoint==''?tradeComment.transportlimitationpoint:0};
			 var safe_score = ${tradeComment.goodssafetypoint==''?tradeComment.goodssafetypoint:0};
			 
			$("#service").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:service_score,
				number: 5,
				readOnly: true
			});

			$("#price").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:price_score,
				number: 5,
				readOnly: true
			});

			$("#timer").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:timer_score,
				number: 5,
				readOnly: true
			});

			$("#safe").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:safe_score,
				number: 5,
				readOnly: true
			});
			
		});
	</script>

</body>
</html>
