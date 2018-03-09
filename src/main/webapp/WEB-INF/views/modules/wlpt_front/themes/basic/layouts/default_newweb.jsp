<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title default="欢迎光临"/> - ${site.title} -
        招标、找车、找货-海量货源车源永久免费</title>
    <meta charset="utf-8">
    	<link  rel="stylesheet" href="${ctxStatic }/office/css/bootstrap.min.css" />
		<link  rel="stylesheet" href="${ctxStatic }/office/css/animate.css" />
		<link  rel="stylesheet" href="${ctxStatic }/office/css/swiper.min.css" />
		<link  rel="stylesheet" href="${ctxStatic }/office/css/style.css?id=4" />
		<link rel="stylesheet" type="text/css" href="${ctxStatic }/office/css/style.css"/>
		<link rel="stylesheet" href="${ctxStatic }/office/css/erStyle.css" />
		<link href="${ctxStatic}/front/css/bootstrapValidator.css" type="text/css" rel="stylesheet"/>
		<!--[if lte IE 8]>
	    <script src="${ctxStatic }/office/js/respond.min.js"></script>
	    <script src="${ctxStatic }/office/js/html5shiv.min.js"></script>
	    <![endif]-->
    <sitemesh:head/>
    <script src="${ctxStatic}/front/js/jquery.min.js" type="text/javascript"></script>
		<script src="${ctxStatic }/office/js/bootstrap.min.js"></script>
	<script src="${ctxStatic }/office/js/wow.min.js"></script>
	<script src="${ctxStatic }/office/js/jquery.smooth-scroll.js"></script>
				<script src="${ctxStatic }/office/js/swiper.min.js"></script>
		<script src="${ctxStatic }/office/js/num.js"></script>
		<script src="${ctxStatic }/office/js/erindex.js"></script>
		
	<script type="text/javascript">
		$(document).ready(function() {
				$("#showMsg").hide();
				$("#loginStatus").hide();
			//判断是否有数据
			var status = '${fns:getUser().loginName==null or fns:getUser().loginName eq ''}';
			if(status != 'true'){
				var loginName = '${fns:getUser().loginName}';
					var msg = "<p class='userShow'><a href='${wlpt}/loginSuccess' class='all_show' target='_blank'><img src='${ctxStatic }/office/img/user.png'>"+loginName+"</a>"
					+"<a class='userShow_e' href='${wlpt}/logout'>退出</a></p>"+
					"<div class='userAll'>"+
					"<p>"+loginName+"</p></div>";
				$("#showMsg").append(msg);
				$("#showMsg").show();
			}else{
				$("#loginStatus").show();
			}
		    var parid = "${param.index}";
		    if (parid) {
		        $(".navbar-nav li").removeClass("active");
		        $(".navbar-nav li").eq(parid).addClass("active");
		    } else {
		        $(".navbar-nav li").removeClass("active");
		        $(".navbar-nav li").eq(0).addClass("active");
		    }
		});
	</script>
</head>
<body>
		<div class="header">
			<div class="navbar navbar-default">
				<div class="container">
					<div class="navbar-header">
        				<button class="navbar-toggle" data-toggle="collapse" data-target="#daohang">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
        				<a href="${wlpt}"><img src="${ctxStatic }/office/img/logo.png" alt="" class="navbar-brand"/></a>
    				</div>
    				<div class="navbar-collapse collapse navbar-left" id="daohang">
		                <ul class="nav navbar-nav">
		                    <c:set var="menuList" value="${fns:getWlptNavMenu()}"/>
		                    <c:set var="firstMenu" value="true"/>
		                    <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
		                        <c:if test="${menu.parent.id eq fns:getConst('MUNE_NAV_ID') &&menu.isShow eq '1'}">
		                            <li>
		                                <a href="${fn:indexOf(menu.href, '://') eq -1 and not empty menu.href ? wlpt: ''}${not empty menu.href ? menu.href : '#'}?index=${idxStatus.index}">
		                                     ${menu.name}
		                                </a>
		                            </li>
		                            <c:set var="firstMenu" value="false"/>
		                        </c:if>
		                    </c:forEach>
		                </ul>
					</div>
					<!--登录注册-->
					<div class="pull-left login_box2" id="loginStatus">
						<a href="${wlpt }/login?login=login" class="btn loginBtn">登录TMS</a>
						<a href="${wlpt }/login?login=login" class="btn sign">注册</a>
					</div>
					<!-- 登录后状态 -->
					<div class="pull-left login_box2" id="showMsg"></div>
					<!--app 微信-->
					<div class="enterOther">
						<a href="" class="wechat">卓大微信</a><span>|</span><a href="" class="app">App</a>
						<img src="${ctxStatic }/office/img/weichat_card_hover.jpg" alt="" class="wechat_hover"/>
						<img src="${ctxStatic }/office/img/weichat_card_hover.jpg" alt="" class="app_hover"/>
					</div>
				</div>
			</div>
		</div>
<!--end-header-->

<sitemesh:body/>
<!--main-container-->

<!--main-container-->
				<!--footer-->
		<div class="footer">
			<div class="container">
				<div class="row">
					<div class="col-sm-4 col-xs-6 contact">
						<i>联系我们</i>
						<p>电话：0310-3188756</p>
						<p>邮箱：kf@zhuoda56.com</p>
						<p>QQ：2127724161</p>
						<p>地址：河北邯郸市复兴区309国道巨恒物流园</p>
					</div>
					<div class="col-sm-4 col-xs-6 column text-center">
						<span>关注微信</span>
						<p class="text-center">
							<img src="${ctxStatic }/office/img/weichat_card_hover.jpg" alt="" />
						</p>
					</div>
					<div class="col-sm-4 col-xs-12 copy">
						<span>版权归属</span>
						<p>Copyright&copy;2015 邯郸市众翔信息科技有限公司 版权所有</p>
						<div class="clearfix">
							<p>冀ICP 备17021328号</p>
						</div>
						<script type="text/javascript" src="http://121.28.80.66:8089/hbwjww/VieidServlet?webId=90df6a4846787e9b08517753ac0911d5&width=30&heigth=40"></script>
					</div>
					<div class="col-sm-12 col-xs-12">
						<p class="text-center">服务商：邯郸市众翔信息有限公司</p>
					</div>
				</div>
			</div>
		</div>

		<!--右边悬浮 功能框-->
   	 	<div class="side">
			<ul>
				<li>
					<a href="${wlpt}">
						<div class="sidebox text-center">
							<img src="${ctxStatic }/office/img/index/home.png">
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="sidebox">
							<img src="${ctxStatic }/office/img/index/wechat.png">
						</div>
					</a>
					<img src="${ctxStatic }/office/img/weichat_card_hover.jpg" alt="" class="erCode"/>
				</li>
				<li>
					<a href="javascript:void(0);" >
						<div class="sidebox">
							<span class="side_text">2127724161</span>
							<img src="${ctxStatic }/office/img/index/qq_two.png">
						</div>
					</a>
				</li>
				<li>
					<a href="javascript:void(0);" >
						<div class="sidebox">
							<span class="side_text">0310-3188756</span>
							<img src="${ctxStatic }/office/img/index/phone.png">
						</div>
					</a>
				</li>
				<li>
					<a href="#index_header" class="index_back"><div class="sidebox"><img src="${ctxStatic }/office/img/index/index_top.png"></div></a>
				</li>
			</ul>
		</div>

		<!--返回顶部-->
		<a href="#header" class="back_top text-center">top</a>
		<script src="${ctxStatic }/office/js/index.js"></script>
		<script>
			//wow 动画
		    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
				new WOW().init();
			};
			//鼠标滚动 返回顶部
			$('.back_top').smoothScroll({
				offset:0,
				speed:1000,
				easing:'swing',
			});
		</script>
</body>

</html>