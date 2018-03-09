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
		<table cellspacing="0" style="width:96%;line-height:24px;font-family: '微软雅黑';font-size: 14px; ">
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
							<table style="margin:0px auto;font-family: '微软雅黑';font-size: 14px;">
								<tr>
									<td colspan="3">
									<ul class="ratings lift">
										<li><input type="radio" <c:if test="${!((order.iscomment eq '0' )&& (order.flag) && (order.orderstatus eq '5'))}">disabled</c:if>  <c:if test="${tradeComment.sellercommentlv eq '3'|| empty tradeComment.sellercommentlv}">checked="checked"</c:if> name="sellercommentlv" value="3"/><img src="/static/images/wlptfront/good_comment.png"/>好评</li>
										<li><input type="radio" <c:if test="${!((order.iscomment eq '0' )&& (order.flag) && (order.orderstatus eq '5'))}">disabled</c:if> <c:if test="${tradeComment.sellercommentlv eq '2'}">checked="checked"</c:if> name="sellercommentlv" value="2"/><img src="/static/images/wlptfront/middle_comment.png"/>中评</li>
										<li><input type="radio" <c:if test="${!((order.iscomment eq '0' )&& (order.flag) && (order.orderstatus eq '5'))}">disabled</c:if> <c:if test="${tradeComment.sellercommentlv eq '1'}">checked="checked"</c:if> name="sellercommentlv" value="1"/><img src="/static/images/wlptfront/bad_comment.png"/>差评</li>
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
									<td><textarea id="comment" style="width:500px;padding-top: 10px;" <c:if test="${!((order.iscomment eq '0' )&& (order.flag) && (order.orderstatus eq '5'))}">readonly</c:if> placeholder="用户尚未评价" rows="4" cols="2">${tradeComment.sellercomment }</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: center;">
										<span id="commit">
										<c:if test="${(order.iscomment eq '0' )&& (order.flag) && (order.orderstatus eq '5')}">
											<input id="commit-comment" type="button" class="regbt"
												value="提交评价" />
										</c:if>
										</span>
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
	var flag='${order.flag}';
	var iscomment='${order.iscomment}';
	var status='${order.orderstatus}';
	if(flag=='true'&&iscomment=='0'&&status=='5'){
		$(function() {
			 var service_score = 5;
			 var price_score = 5;
			 var timer_score = 5;
			 var safe_score = 5;
			 
			$("#service").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:service_score,
				click:function(score, evt) {
					service_score = score;
				}
			});

			$("#price").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:price_score,
				click:function(score, evt) {
					price_score = score;
				}
			});

			$("#timer").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:timer_score,
				click:function(score, evt) {
					timer_score = score;
				}
			});

			$("#safe").raty({
				path : "/static/modules/wlpt/front/js/raty/images",
				score:safe_score,
				click:function(score, evt) {
					safe_score = score;
				}
			});

			$("#commit-comment").click(function(){
				
				 var all_scroe = (service_score+price_score+timer_score+safe_score)/4;
				 if($("#comment").val().length>=10&&$("#comment").val().length<500){
				 $.ajax({
					type:"POST",
				 	url :"${wlpt}/wlpt/trade/ordercomment",
					data : {
						orderno: $("#orderno").val(),
						selleriscomment: "1",
						sellercomment: $("#comment").val(),
						sellercommentlv:$("input[name=sellercommentlv]:checked").val(),
						
						serviceattitudepoint: service_score,
						transportationcostpoint: price_score,
						transportlimitationpoint: timer_score,
						goodssafetypoint: safe_score,
						comprehensivepoint: all_scroe	
					},
					success:function(data){
						if(data.state==1){
							$.MsgBox.Alert("评价提示","感谢您的评价，期待再合作啦！");
							$("#commit").hide();
						}else{
							$.MsgBox.Alert("评价提示","评价失败"+data.message);
						}
					}
				 });
				 }else{
					 $.MsgBox.Alert("评价提示","提交评论失败，评价内容字符长度10-500"); 
				 }
			});
			
		});
	}else{
		$(function() {
			var serviceattitudepoint='${tradeComment.serviceattitudepoint}';
			var transportationcostpoint='${tradeComment.transportationcostpoint}';
			var transportlimitationpoint='${tradeComment.transportlimitationpoint}';
			var goodssafetypoint='${tradeComment.goodssafetypoint}';
			 var service_score = serviceattitudepoint != ''?serviceattitudepoint*1:0;
			 var price_score = transportationcostpoint !=''?transportationcostpoint*1:0;
			 var timer_score = transportlimitationpoint !=''?transportlimitationpoint*1:0;
			 var safe_score = goodssafetypoint !=''?goodssafetypoint*1:0;
			 
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
	}
		
	</script>

</body>
</html>
