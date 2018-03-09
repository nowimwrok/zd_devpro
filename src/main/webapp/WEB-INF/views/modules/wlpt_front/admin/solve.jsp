<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
		<title>解决方案</title>
		<meta name="decorator" content="site_web_newbasic"/>
	</head>
	<body>

		<div class="content">
			<!--banner-->
			<div class="solve_banner">
				<img src="${ctxStatic }/office/img/solve/solve_banner.jpg" alt="" />
			</div>
			<!--content-->
			<div class="ersolve container">
				<div class="col-sm-12 wow fadeInUp">
					<div class="solve_title">
						<img src="${ctxStatic }/office/img/solve/solve_one.jpg" alt="" />
						<h2 class="text-center">业务模块</h2>
					</div>
					<div class="ersolve_c">
						<p>大宗货源招投标的合同管理，零担货源竞价的列表管理，让用户能清楚了解每笔业务运输交易的实时状态。</p>
					</div>
				</div>
				<div class="col-sm-12 wow fadeInUp" data-wow-delay=".2s">
					<div class="solve_title">
						<img src="${ctxStatic }/office/img/solve/solve_two.jpg" alt="" />
						<h2 class="text-center">业务模块</h2>
					</div>
					<div class="ersolve_c">
						<p>机械设备行业解决方案，完全针对机械设备行业特点和管理需求研发，有效满足了该行业客户信息散乱、项目难以掌控、销售机构众多、库存账务混乱、采购计划难定、生产现场失控等管理特点，实现从客户初次接触、销售订单生成、产品采购入库、自制委外并行、产品销售出库到客户关系维护全过程的一体化管理。该方案支持个性定制、按需扩展、移动办公，广泛应用于商贸型、小型制造、精益制造等各类型机械设备企业。</p>
					</div>
				</div>
				<div class="col-sm-12 wow fadeInUp" data-wow-delay=".4s">
					<div class="solve_title">
						<img src="${ctxStatic }/office/img/solve/solve_three.jpg" alt="" />
						<h2 class="text-center">业务模块</h2>
					</div>
					<div class="ersolve_c">
						<p>中小型企业解决方案，是在深入研究中国中小型企业的市场环境及管理特性之后，结合先进的7C管理理念，应运而生的本土化管理体系。它将企业的客户销售、产品、库存、采购、合同、资金、人员、办公等资源纳入到统一的平台中，通过规范的流程操作，了解企业运营中的每一个微小环节，从而帮助企业灵活应对市场变化、规避运营风险，获取市场决胜的关键竞争力。该方案支持个性定制、按需扩展、移动办公，广泛应用于各类中小微型企业。</p>
					</div>
				</div>
				<div class="col-sm-12 wow fadeInUp" data-wow-delay=".6s">
					<div class="solve_title">
						<img src="${ctxStatic }/office/img/solve/solve_four.jpg" alt="" />
						<h2 class="text-center">业务模块</h2>
					</div>
					<div class="ersolve_c">
						<p>手机端管理解决方案，是以手机终端为载体，通过无线网络连接服务器，建立可移动的信息化系统，将企业管理系统扩展到手机端，实现任何地点任何时间无缝连接，根据移动场景提供有针对性的碎片化节点应用。手机端与电脑端信息实时交互协同，使智能手机具备和电脑一样的办公功能，让用户把企业装进手机，业务随身而行，随时随地高效工作，将管理范围延伸至任何一个有网络的地方。Android、IOS、Windows Phone全面支持。</p>
					</div>
				</div>
			</div>
		</div>

		<script src="${ctxStatic }/office/js/jquery.min.js"></script>
		<script src="${ctxStatic }/office/js/wow.min.js"></script>
		<script src="${ctxStatic }/office/js/bootstrap.min.js"></script>
		<script>
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
