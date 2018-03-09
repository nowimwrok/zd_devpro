<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html lang="zh-cn">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
		<title>首页</title>
		<meta name="decorator" content="site_web_newbasic"/>
	</head>
	<body>
		<div class="content">
			<!--banner-->
			<div class="swiper-container banner" style="position:relative;">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<img src="${ctxStatic }/office/img/index/banner_one.jpg" alt="" />
					</div>
					<div class="swiper-slide">
						<img src="${ctxStatic }/office/img/index/banner_two.jpg" alt="" />
					</div>
					<div class="swiper-slide">
						<img src="${ctxStatic }/office/img/index/banner_three.jpg" alt="" />
					</div>
        		</div>
	        	<div class="swiper-pagination"></div>
			</div>
			<!--功能介绍-->
			<div class="open_box funs">
				<h3 class="text-nowrap text-center wow fadeInDown">功能介绍</h3>
				<div class="line text-center"></div>
				<div class="container clearfix">
					<div class="pull-left clearfix funs_box wow bounceInLeft">
						<div class="pull-left funs_img">
							<img src="${ctxStatic }/office/img/index/funs_one.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">业务管理</h4>
							<p>运输节点可控，运输流程可视，<br />运输状态随时掌控，让业务便捷高效</p>
						</div>
					</div>
					<div class="pull-left clearfix funs_box wow bounceIn">
						<div class="pull-left funs_img">
							<img src="${ctxStatic }/office/img/index/funs_two.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">调度管理</h4>
							<p class="">应收应付，重要款项无遗漏<br />流入流出，资金流动可查重</p>
						</div>
					</div>
					<div class="pull-left clearfix funs_box wow bounceInRight">
						<div class="pull-left funs_img">
							<img src="${ctxStatic }/office/img/index/funs_three.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">数据中心</h4>
							<p class="">车辆位置状态一键查看<br />车辆在途空载一目了然</p>
						</div>
					</div>
					<div class="pull-left clearfix mbz  funs_box wow bounceInLeft">
						<div class="pull-left funs_img">
							<img src="${ctxStatic }/office/img/index/funs_four.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">企业管理</h4>
							<p class="">多维度统计，全方位展现企业运营状况<br />让管理决策更高效</p>
						</div>
					</div>
					<div class="pull-left clearfix mbz funs_box wow bounceIn">
						<div class="pull-left funs_img">
							<img src="${ctxStatic }/office/img/index/funs_five.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">业务管理</h4>
							<p class="">企业诚信档案<br />让物流运输交易更加安全保障</p>
						</div>
					</div>
					<div class="pull-left clearfix mbz  funs_box wow bounceInRight">
						<div class="pull-left funs_img text-center">
							<img src="${ctxStatic }/office/img/index/funs_six.png" alt="" class="funs_img_one"/>
						</div>
						<div class="pull-left fun_text">
							<h4 class="text-nowrap">业务管理</h4>
							<p class="">全方面物流运输服务<br />降低成本，提高效率</p>
						</div>
					</div>
				</div>
			</div>
			<!--流程图-->
			<div class="open_box picGif">
				<h3 class="wow fadeInDown text-nowrap text-center wow fadeInDown">上下游协同作业</h3>
				<div class="line text-center"><span></span></div>
				<p class="text-center text_title wow fadeInUp" data-wow-duration='1.5s'>产品用心、服务贴心、品牌知心<br />助力企业“互联网+”进程</p>
				<div class="gif_box container wow bounceIn text-center">
					<img src="${ctxStatic }/office/img/index/mine.png" alt=""/>
				</div>
			</div>
			<!--欢迎数字-->
			<div class="data_count open_box  swiper-container" id="data_count">
				<h3 class="wow fadeInDown text-nowrap text-center wow fadeInDown">欢迎来到卓大物流</h3>
				<div class="line text-center"><span></span></div>
				<p class="text-center text_title wow fadeInUp">产品用心、服务贴心、品牌知心<br />助力企业“互联网+”进程</p>
				<div class="container clearfix">
					<div class="pull-left data_c wow bounceInLeft">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/index/count_two.png" alt="" />
						</div>
						<h4 class="text-center">平台会员量</h4>
						<div class="text-center"><span class="text-center counter" data-to="5000" data-speed="2500"></span><span>+</span></div>	
						<p class="text-center">前期对产品功能定义及目标用户群调研，上线后进行用户可用性测试</p>
					</div>
					<div class="pull-left data_c wow bounceIn">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/index/count_one.png" alt="" />
						</div>
						<h4 class="text-center">每月成交量</h4>
						<div class="text-center"><span class="text-center counter" data-to="3000" data-speed="2500"></span><span>万+</span></div>
						<p class="text-center">合作的客户中，50%以上的客户都签订了长期战略合作协议</p>
					</div>
					<div class="pull-left data_c wow bounceInRight">
						<div class="text-center count_img">
							<img src="${ctxStatic }/office/img/index/count_three.png" alt="" />
						</div>
						<h4 class="text-center">累计成交量</h4>
						<div class="text-center"><span class="text-center counter" data-to="2" data-speed="2500"></span><span>亿+</span></div>
						<p class="text-center">凭借对服务品质和商业价值的追求，赢得了众多国内外客户的信任</p>
					</div>
				</div>
			</div>
			<!--解决方案-->
			<div class="open_box solve">
				<h3 class="text-nowrap text-center wow fadeInDown">解决方案</h3>
				<div class="line text-center"></div>
				<div class="container clearfix">
					<div class="col-sm-4 wow bounceInLeft">
						<img src="${ctxStatic }/office/img/index/solve_one.jpg" alt="" />
						<div class="solve_c clearfix">
							<h4 class="pull-left">业务问题</h4>
							<p class="pull-right"><a href="${wlpt}/office/answer?index=1"><span>查看详情</span><i></i></a></p>
						</div>
					</div>
					<div class="col-sm-4 wow bounceIn">
						<img src="${ctxStatic }/office/img/index/solve_two.jpg" alt="" />
						<div class="solve_c clearfix">
							<h4 class="pull-left">业务问题</h4>
							<p class="pull-right"><a href="${wlpt}/office/answer?index=1"><span>查看详情</span><i></i></a></p>
						</div>
					</div>
					<div class="col-sm-4 wow bounceInRight" data-wow-duration='1.5s'>
						<img src="${ctxStatic }/office/img/index/solve_three.jpg" alt="" />
						<div class="solve_c clearfix">
							<h4 class="pull-left">业务问题</h4>
							<p class="pull-right"><a href="${wlpt}/office/answer?index=1"><span>查看详情</span><i></i></a></p>
						</div>
					</div>
				</div>
			</div>
			
			<!--合作伙伴-->
			<div class="partner open_box">
				<h3 class="text-nowrap text-center wow fadeInDown">战略合作伙伴</h3>
				<div class="line"></div>
				<div class="container swiper-container partner-container wow bounceIn">
					<div class="swiper-wrapper">
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_one.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_two.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_three.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_four.png" alt=""/></a>
						</div>
					</div>
					<div class="swiper-button-next er_next"></div>
	        		<div class="swiper-button-prev er_prev"></div>
				</div>
			</div>
		</div>
	
		</div>

		<script>
			//banner部分轮播
			var swiper_banner = new Swiper('.banner', {
        		pagination: '.swiper-pagination',
        		paginationClickable: true,
        		spaceBetween:0,
        		centeredSlides: true,
        		loop:true,
        		autoplay:2000,
        		speed:2000,
			})
			//合作伙伴轮播
	  		var swiper2 = new Swiper('.partner-container', {
			        nextButton: '.er_next',
	        		prevButton: '.er_prev',
	        		loop:true,
	        		autoplay:2000,
	        		speed:1000,
			        paginationClickable: true,
			        slidesPerView: 4,
			        spaceBetween:0,
			        breakpoints:{
			        	500:{
			        		slidesPerView:2,
			        	}
			        }
			});
			if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
				new WOW().init();
			};
			function live(){
				$(".counter").each(count);
				$(window).unbind('scroll');
			}
			$(window).on("scroll",function(){
    			if(( $("#data_count").offset().top - $(this).scrollTop() ) <$(this).height()){
    				live();
    			}
			});
		</script>
	</body>
</html>