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
	//鼠标滚动 返回顶部
	$('.back_top').smoothScroll({
		offset:0,
		speed:1000,
		easing:'swing',
	});
	$(window).scroll(function(){
		var a=$(window).scrollTop();
		if(a>400){
			$('.back_top').show(500);
		}
		if(a==0){
			$('.back_top').hide(500);
		}
	});