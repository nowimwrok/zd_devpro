<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
		<title>新版解决方案</title>
		<meta name="decorator" content="site_web_newbasic"/>
	</head>
	<body>
		<!--content-->
		<div class="content">
			<!--banner-->
			<div class="solve_banner">
				<img src="${ctxStatic }/office/img/solve/solve_banner.jpg" alt="" />
			</div>
			<!--管理问题-->
			<div class="open_box newMan">
				<h3 class="newTitle text-center wow fadeInDown">管理问题</h3>
				<div class="new_line text-center wow fadeInUp">
					<span></span>
				</div>
				<div class="container clearfix">
					<div class="manCol pull-left wow slideInLeft">
						<div class="manCol_img">
							<img src="${ctxStatic }/office/img/newSolve/manOne.jpg" alt="" class="manCol_bg"/>
							<img src="${ctxStatic }/office/img/newSolve/manText_bg.png" alt="" class="manCol_tx"/>
							<p class="manCol_tx text-center">业务管理</p>
						</div>
						<div class="man_text">
							<p class="text-center">
								业务节点状态跟踪及管理<br />调度管理
							</p>
						</div>
					</div>
					<div class="pull-left manCol_pd"></div>
					<div class="manCol pull-left wow fadeInUp">
						<div class="manCol_img">
							<img src="${ctxStatic }/office/img/newSolve/manTwo.jpg" alt="" class="manCol_bg"/>
							<img src="${ctxStatic }/office/img/newSolve/manText_bg.png" alt="" class="manCol_tx"/>
							<p class="manCol_tx text-center">财务管理</p>
						</div>
						<div class="man_text">
							<p class="text-center">
								业务结算装填统计，资金流水统计<br />线上自主对账
							</p>
						</div>
					</div>
					<div class="pull-left manCol_pd"></div>
					<div class="manCol pull-left wow slideInRight">
						<div class="manCol_img">
							<img src="${ctxStatic }/office/img/newSolve/manThree.jpg" alt="" class="manCol_bg"/>
							<img src="${ctxStatic }/office/img/newSolve/manText_bg.png" alt="" class="manCol_tx"/>
							<p class="manCol_tx text-center">数据报表</p>
						</div>
						<div class="man_text">
							<p class="text-center">
								企业业务、财务报表<br />多维度数据展示统计
							</p>
						</div>
					</div>
				</div>
			</div>
			<!--业务问题-->
			<div class="open_box bus">
				<h3 class="newTitle text-center wow fadeInDown">业务问题</h3>
				<div class="busQ text-center wow fadeInUpBig">
					<i></i><span>查找合适的运输业务</span>
					<i></i><span>担保业务运输安全可靠性</span>
					<i></i><span>全程跟踪运输状态</span>
					<i></i><span>提供结算保障</span>
				</div>
				<div class="new_line text-center wow fadeInUp">
					<span></span>
				</div>
				<div class="container">
					<div class="swiper-container solve_swiper">
						<div class="swiper-wrapper">
							<div class="swiper-slide flow text-center">
								<img src="${ctxStatic }/office/img/newSolve/flow.png" alt="" />
							</div>
							<div class="swiper-slide clearfix">
								<div class="bus_text clearfix">
									<div class="busCol pull-left">
										<div class="busCol_img text-center">
											<img src="${ctxStatic }/office/img/newSolve/busOne.png" alt="" />
										</div>
										<p class="text-center">
											一键找货找车<br />业务运输便捷高效
										</p>
									</div>
									<div class="bus_line pull-left"></div>
									<div class="busCol pull-left">
										<div class="busCol_img text-center">
											<img src="${ctxStatic }/office/img/newSolve/busTwo.png" alt="" />
										</div>
										<p class="text-center">
											业务流程透明化<br />运输结算多重选择
										</p>
									</div>
									<div class="bus_line pull-left"></div>
									<div class="busCol pull-left">
										<div class="busCol_img text-center">
											<img src="${ctxStatic }/office/img/newSolve/busThree.png" alt="" />
										</div>
										<p class="text-center">
											多元化支付方式<br />运费结算多重选择
										</p>
									</div>
									<div class="bus_line pull-left"></div>
									<div class="busCol pull-left">
										<div class="busCol_img text-center">
											<img src="${ctxStatic }/office/img/newSolve/busFour.png" alt="" />
										</div>
										<p class="text-center">
											企业诚信担保<br />物流交易安全可靠
										</p>
									</div>
								</div>
							</div>
						</div>
        				<div class="swiper-pagination"></div>
					</div>
				</div>
			</div>
			<!--服务问题-->
			<div class="open_box newSer">
				<h3 class="newTitle text-center wow fadeInDown">服务问题</h3>
				<div class="new_line text-center wow fadeInUp">
					<span></span>
				</div>
				<div class="container clearfix">
					<div class="serviceCol pull-left wow slideInLeft">
						<div class="serOne text-center">
							<img src="${ctxStatic }/office/img/newSolve/serviceOne.png" alt="" />
							<div class="ser_line"></div>
							<p class="text-center">
								消费优惠低<br />运营成本居高不下
							</p>
						</div>
						<div class="serTwo text-center">
							<img src="${ctxStatic }/office/img/newSolve/triOne.png" alt="" />
							<p class="text-center">
								多元化物流服务，便捷高效<br />降低物流成本
							</p>
						</div>
					</div>
					<div class="ser_pd pull-left"></div>
					<div class="serviceCol serUn pull-left wow fadeInUp">
						<div class="serOne text-center">
							<img src="${ctxStatic }/office/img/newSolve/serviceOne.png" alt="" />
							<div class="ser_line"></div>
							<p class="text-center">
								产品渠道单一<br />服务质量没保障
							</p>
						</div>
						<div class="serTwo text-center">
							<img src="${ctxStatic }/office/img/newSolve/triTwo.png" alt="" />
							<p class="text-center">
								油气服务(价格优惠，服务高效)<br />保险服务(一键投保、一站式承保) 
							</p>
						</div>
					</div>
					<div class="ser_pd pull-left"></div>
					<div class="serviceCol pull-left wow slideInRight">
						<div class="serOne text-center">
							<img src="${ctxStatic }/office/img/newSolve/serviceOne.png" alt="" />
							<div class="ser_line"></div>
							<p class="text-center">
								传统消费方式<br />服务效率较低
							</p>
						</div>
						<div class="serTwo text-center">
							<img src="${ctxStatic }/office/img/newSolve/triOne.png" alt="" />
							<p class="text-center">
								ETC服务(多线路覆盖、优惠大)<br />一卡通(一卡通行、便捷高效)

							</p>
						</div>
					</div>
					<!--服务解决-->
					<div class="serSolve text-center wow fadeInDownBig pull-left">
						<span><i>【服务解决】</i>降低运营成本</span>
						<span><i>【服务解决】</i>提高服务消费质量及效率</span>
						<span><i>【服务解决】</i>产品多元化，渠道覆盖面广，全方面满足企业物流服务需求</span>
					</div>
				</div>
			</div>
		</div>
		<a href="#header" class="back_top text-center">top</a>
		<script src="${ctxStatic }/office/js/jquery.min.js"></script>
		<script src="${ctxStatic }/office/js/bootstrap.min.js"></script>
		<script src="${ctxStatic }/office/js/swiper.min.js"></script>
		<script src="${ctxStatic }/office/js/jquery.smooth-scroll.js"></script>
		<script src="${ctxStatic }/office/js/wow.min.js"></script>
		<script src="${ctxStatic }/office/js/index.js"></script>
		<script>
			var mySwiper = new Swiper('.swiper-container', {
        		pagination: '.swiper-pagination',
        		paginationClickable: true,
        		spaceBetween:0,
        		centeredSlides: true,
        		loop:true,
        		autoplay:3000,
        		speed:2000,
			})
			if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
				new WOW().init();
			};
			$('.swiper-slide').hover(function(){
				mySwiper.stopAutoplay();
			},function(){
				mySwiper.startAutoplay();
			});
			var brower_w=$(window).width();
			if(brower_w<500){
				mySwiper.stopAutoplay();
				mySwiper.lockSwipes()
			}
		</script>
	</body>
</html>
