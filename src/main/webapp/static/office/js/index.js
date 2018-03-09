$(function(){
	$('.side ul li').hover(function(){
		var index=$(this).index();
		if(index==1){
			$(this).find('.erCode').show(500);
			$(this).find('div').css('background-color','#b20e10');
		}
		else if(index==0 || index==2 || index==3){
			$(this).find('span').show(500);
			$(this).find('div').css('background-color','#b20e10');
		}
	},function(){
		var index=$(this).index();
		if(index==1){
			$(this).find('.erCode').hide(500);
			$(this).find('div').css('background-color','rgba(0,0,0,.5)');
		}
		else if(index==0 || index==2 || index==3){
			$(this).find('span').hide(500);
			$(this).find('div').css('background-color','rgba(0,0,0,.5)');
		}
	});
	$('.index_back').smoothScroll({
		offset:0,
		speed:1000,
		easing:'swing',
	});
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
	$('.solve .col-sm-4').hover(function(){
		$(this).find('i').css('left',"0").css('opacity','1');
	},function(){
		$(this).find('i').css('left',"-20px").css('opacity','0');
	});
	//解决侧边导航在ie浏览器的问题 
    if (!!window.ActiveXObject || "ActiveXObject" in window){
    	$('.side').css('right','15px');
    }
    //用户名显示全名称
    var userAll=$('.userAll').height();
	$('.userAll').css('bottom',-userAll+"px");
	$('.all_show').hover(function(){
		$('.userAll').fadeIn();
	},function(){
		$('.userAll').fadeOut();
	});
})
