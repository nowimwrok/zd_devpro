$(function(){
	//banner
	var brower_w=$(window).width();
	var brower_h=$(window).height();
	var nav_h=$('.navbar-default').height();
	//$('.banner').height(brower_h/3*2+'px');
	$('.banner ul li').width(brower_w+'px').height(brower_h+'px');
	//合作伙伴  滚动
	var _speed=30;
    var _slide = $(".partner .pics");
    var _slideli1 = $(".partner .slide1");
    var _slideli2 = $(".partner .slide22");
    _slideli2.html(_slideli1.html());
    function Marquee(){
        if(_slide.scrollLeft() >= _slideli1.width())
            _slide.scrollLeft(0);
        else{
            _slide.scrollLeft(_slide.scrollLeft()+1);
        }
    }
    var sliding=setInterval(Marquee,_speed)
    _slide.hover(function() {
        clearInterval(sliding);
    },function(){
        sliding=setInterval(Marquee,_speed);
    });
    //数字li的宽度
    $('.num_content ul li').width($('.container').width()+'px');
	//数字模块的轮播
	/*jQuery(".data_count .container").slide({titCell:".hd ul",mainCell:".num_content ul",autoPage:true,trigger:'click',autoPlay:false,});*/
	$('.num li').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		var index=$(this).index();
		if(index==0){
			$(".counter").each(count);
		}
		if(index==1){
			//$('.num_content ul li').eq(index).addClass('bounceIn');
			$(".counter2").each(count);
		}
		$('.num_content ul li').eq(index).show().siblings().hide();
	});
	//数字模块的轮播
	function live(){
		var length=$('.num_content ul li').length;
		for(var i=0;i<length;i++){
			$('.num_content ul li').eq(i).show(500).siblings().hide();
		}
	}
	//setInterval(live,3000);
	//手机悬浮 关闭 
	$('.phone_img .close').click(function(){
		$('.phone_img').hide(500);
	});
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
	//鼠标滚动 返回顶部
	$('.back_top').smoothScroll({
		offset:0,
		speed:800,
		easing:'swing',
	});
	$(window).scroll(function(){
		var a=$(window).scrollTop();
		if(a>600){
			$('.back_top').show(500);
		}
		if(a==0){
			$('.back_top').hide(500);
		}
	});
	//手机悬浮控制
	$('.phone_control').click(function(){
		$('.phone_img').toggle(500);
	});
	//手机端导航
	$('.navbar-toggle').click(function(){
		$('.mask').toggle();
	    $('.header').css('z-index','1000');
	});
	$('.box .close').click(function(){
		$('.box').hide(500);
		$('.mask').hide();
	});
	
})
