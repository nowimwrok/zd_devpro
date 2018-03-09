<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
		<title>商城</title>
		<meta name="decorator" content="site_web_newbasic"/>
	    <style type="text/css">
	    </style>
	</head>
	<body>
		<div class="content">
			<!--banner-->
			<div class="solve_banner">
				<img src="${ctxStatic }/office/img/market/market_banner.jpg" alt="" />
			</div>
			<!--three-->
			<div class="data_count" id="market_title">
				<div class="container clearfix">
					<div class="pull-left data_c wow bounceInLeft">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/market/title_one.png" alt="" />
						</div>
						<h4 class="text-center">卓币</h4>	
						<p class="text-center dataC_h">卓币在手、天下我有<br />卓币当钱花</p>
						<div class="text-center">
							<a href="${wlpt}/wlpt/shop/buyOil?shotName=zd_coin">立即购买</a>
						</div>
					</div>
					<div class="pull-left data_c wow bounceIn">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/market/title_two.png" alt="" />
						</div>
						<h4 class="text-center">油气</h4>
						<p class="text-center dataC_h">天天优惠、全国通用<br />"e车有保，乐驾人生"</p>
						<div class="text-center">
							<a href="${wlpt}/wlpt/shop/buyOil?shotName=you_qi">立即购买</a>
						</div>
					</div>
					<div class="pull-left data_c wow bounceInRight">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/market/title_three.png" alt="" />
						</div>
						<h4 class="text-center">保险</h4>
						<p class="text-center dataC_H">会省钱的保险，全国通赔<br />任性加油、覆盖门店1299家</p>
						<div class="text-center">
							<a href="${wlpt}/wlpt/shop/buyInsur?shotName=bao_xian">立即购买</a>
						</div>
					</div>
				</div>
			</div>
			<!--detail-->
			<div class="solve" id="market_detail">
				<div class="container clearfix">
					<div class="col-sm-4 wow bounceInLeft">
						<img src="${ctxStatic }/office/img/market/market_one.jpg" alt="" />
						<div class="solve_c text_h">
							<p class="">“卓币”是卓大物流平台推出的一款在平台上使用的虚拟货币，用户可以通过“卓币”在平台上进行支付转账、消费等操作。<br />“卓币”可以在平台的商城通过账户余额进行购买，通常它的兑价是1卓价=1人民币。</p>
						</div>
						<div class="detail_title">什么是卓币？</div>
					</div>
					<div class="col-sm-4 wow fadeInUp" data-wow-duration="1s">
						<img src="${ctxStatic }/office/img/market/market_two.jpg" alt="" />
						<div class="solve_c text_nh">
							<p class="">卓大油气是卓大物流平台与线下油气站合作方联合推出的加油加气商品。<br />卓大油气可以在卓大商城进行购买，当购买成功后可以在个人中心的油气账户看到购买后的油气余额。</p>
						</div>
						<div class="detail_title">什么是油气？</div>
					</div>
					<div class="col-sm-4 wow bounceInRight">
						<img src="${ctxStatic }/office/img/market/market_three.jpg" alt="" />
						<div class="solve_c text_nh">
							<p class="">承保由于火灾、台风、暴雨、泥石流等原因造成的货物损失；网上投保方便报捷，只需三步走帮你买到想要的保险。<br />提供7x24小时报案理赔电话，更可全国通赔。</p>
						</div>
						<div class="detail_title">什么是保险？</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			//控制文字部分的高低
			var detail_h=$('.text_h').height();
			$('.text_nh').height(detail_h+'px');
			if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
				new WOW().init();
			};
			//微信app悬浮
			$('.wechat').hover(function(){
				$('.wechat_hover').fadeIn();
			},function(){
				$('.wechat_hover').fadeOut();
			});
			$('.app').hover(function(){
				$('.app_hover').fadeIn();
			},function(){
				$('.app_hover').fadeOut();
			});
		</script>
	</body>
</html>