<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <meta name="decorator" content="site_web_basic"/>
    <%@include
            file="/WEB-INF/views/modules/wlpt_front/include/head_web.jsp" %>
    <style type="text/css">
        html, body {
            position: relative;
            height: 100%;
        }

        .swiper-slide {
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }

        .footer{position:absolute;bottom:0;left:0;}
        .header{position:fixed;top:0;left:0;}
    </style>
</head>
<body>
<div class=" content_none">
    <div class="wrapper_none">
        <div class="swiper_none banner_down">
            <!--banner-->
            <p class="down"><img src="${ctxStatic }/images/wlptfront/index/down.png" alt="" /></p>
            <div class="swiper-container banner"><!--bouceIn-->
            	
                <div class="swiper-wrapper">
                    <div class="swiper-slide slide_one">
                        <img src="${ctxStatic }/images/wlptfront/index/banner_one.jpg" alt=""/>
                    </div>
                    <div class="swiper-slide slide_two">
                        <img src="${ctxStatic }/images/wlptfront/index/banner_two.jpg" alt=""/>
                    </div>
                    <div class="swiper-slide slide_three">
                        <img src="${ctxStatic }/images/wlptfront/index/banner_three.jpg" alt=""/>
                    </div>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
        </div>
        <!--content-->
        <!--2 功能介绍-->
        <div class="swiper_none">
            <div class="open_box funs">
                <h3 class="wow_fd text-nowrap text-center">功能介绍</h3>
                <div class="box_title clearfix wow_fd">
                    <p class="triangle text-center">
                        <span class="glyphicon glyphicon-chevron-down"></span>
                        <i class="box_line line_one"></i>
                        <i class="box_line line_two"></i>
                    </p>
                    <div class="pull-left col-sm-5 col-xs-5"></div>
                    <div class="pull-right col-sm-5 col-xs-5"></div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 col-xs-6 clearfix wow_or">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left wow fadeInRight funs_img">
                                    <img src="${ctxStatic }/images/wlptfront/index/business.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/business_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">业务管理</h4>
                                    <p>运输节点可控，运输流程可视，运输状态随时掌控，让业务便捷高效</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 clearfix wow_tr" data-wow-delay=".2s">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left funs_img">
                                    <img src="${ctxStatic }/images/wlptfront/index/control.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/control_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">财务管理</h4>
                                    <p class="">应收应付，重要款项无遗漏，流入流出，资金流动可查看</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 clearfix wow_thr" data-wow-delay=".4s">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left funs_img">
                                    <img src="${ctxStatic }/images/wlptfront/index/data.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/data_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">调度中心</h4>
                                    <p class="">车辆位置状态一键查看，车辆在途空载一目了然</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 clearfix wow_or">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left funs_img">
                                    <img src="${ctxStatic }/images/wlptfront/index/company.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/company_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">数据中心</h4>
                                    <p class="">多维度统计，全方位展现企业运营状况，让管理决策更高效</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 clearfix wow_tr" data-wow-delay=".2s">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left funs_img">
                                    <img src="${ctxStatic }/images/wlptfront/index/manage_one.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/manage_one_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">诚信档案</h4>
                                    <p class="">企业诚信档案，让物流运输交易更加安全保障</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 clearfix wow_thr" data-wow-delay=".4s">
                            <div class="col-sm-12 clearfix">
                                <div class="pull-left funs_img text-center">
                                    <img src="${ctxStatic }/images/wlptfront/index/manage_two.png" alt=""
                                         class="funs_img_one"/>
                                    <img src="${ctxStatic }/images/wlptfront/index/manage_two_w.png" alt=""
                                         class="funs_img_two"/>
                                </div>
                                <div class="pull-left col-sm-9">
                                    <h4 class="text-nowrap">物流服务</h4>
                                    <p class="">全方面物流运输服务，降低成本，提高效率</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--3数字-->
        <div class="swiper_none">
            <div class="data_count open_box  swiper-container" id="data_count">
                <h3 class="wow_fd text-nowrap text-center  fadeInDown">欢迎来到卓大物流</h3>
                <div class="wow_fd box_title clearfix  fadeInDown">
                    <p class="triangle text-center">
                        产品用心、服务贴心、品牌知心、助力企业“互联网+”进程
                        <i class="box_line line_one"></i>
                        <i class="box_line line_two"></i>
                    </p>
                    <div class="pull-left col-sm-5 col-xs-5"></div>
                    <div class="pull-right col-sm-5 col-xs-5"></div>
                </div>
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="container">
                            <div class="row">
                                <div class="col-sm-4 col-xs-12 ani" swiper-animate-effect="fadeInUp"
                                     swiper-animate-duration="1s">
                                    <div class="col-sm-12">
                                        <div class="text-center count_img">
                                            <img src="${ctxStatic }/images/wlptfront/index/welcome_five.png"
                                                 alt=""/>
                                        </div>
                                        <div class="text-center"><span class="text-center counter" data-to="3000"
                                                                       data-speed="1500"></span><span>万+</span>
                                        </div>
                                        <h4 class="text-center">每月成交量</h4>
                                        <p class="text-center">前期对产品功能定义及目标用户群调研，上线后进行用户可用性测试</p>
                                    </div>
                                </div>
                                <div class="col-sm-4 col-xs-12 ani" swiper-animate-effect="fadeInUp"
                                     swiper-animate-duration="1s"
                                     swiper-animate-delay="0.3s">
                                    <div class="col-sm-12">
                                        <div class="text-center count_img">
                                            <img src="${ctxStatic }/images/wlptfront/index/welcome_two.png" alt=""/>
                                        </div>
                                        <div class="text-center"><span class="text-center counter" data-to="5000"
                                                                       data-speed="1500"></span><span>+</span></div>
                                        <h4 class="text-center">平台会员数</h4>
                                        <p class="text-center">合作的客户中，50%以上的客户都签订了长期战略合作协议</p>
                                    </div>

                                </div>
                                <div class="col-sm-4 col-xs-12 ani" swiper-animate-effect="fadeInUp"
                                     swiper-animate-duration="1s"
                                     swiper-animate-delay="0.4s">
                                    <div class="col-sm-12">
                                        <div class="text-center count_img">
                                            <img src="${ctxStatic }/images/wlptfront/index/welcome_six.png" alt=""/>
                                        </div>
                                        <div class="text-center"><span class="text-center counter" data-to="2"
                                                                       data-speed="1500"></span><span>亿+</span>
                                        </div>
                                        <h4 class="text-center">平台交易流水</h4>
                                        <p class="text-center">凭借对服务品质和商业价值的追求，赢得了众多国内外客户的信任</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--4解决方案-->
        <div class="solve swiper_none">
            <div class="open_box">
                <h3 class="wow_fd fadeInDown text-nowrap text-center">解决方案</h3>
                <div class="box_title clearfix wow_fd fadeInDown">
                    <p class="triangle text-center">
                        <span class="glyphicon glyphicon-chevron-down"></span>
                        <i class="box_line line_one"></i>
                        <i class="box_line line_two"></i>
                    </p>
                    <div class="pull-left col-sm-5 col-xs-5"></div>
                    <div class="pull-right col-sm-5 col-xs-5"></div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4 col-xs-6 wow_sor  slideInRight"><!--rotateIn-->
                            <div class="col-sm-12 col-xs-12">
                                <img src="${ctxStatic }/images/wlptfront/index/solve_one.jpg" alt="" class=""/>
                                <div class="solve_btn clearfix">
                                    <p class="pull-left">业务管理</p>
                                    <a href="${wlpt}/wlpt/solution?index=1" class="pull-right">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        查看详情
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 wow_str  slideInRight" data-wow-delay=".2s">
                            <div class="col-sm-12 col-xs-12">
                                <img src="${ctxStatic }/images/wlptfront/index/solve_three.jpg" alt="" class=""/>
                                <div class="solve_btn clearfix">
                                    <p class="pull-left">调度中心</p>
                                    <a href="${wlpt}/wlpt/solution?index=1" class="pull-right">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        查看详情
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-xs-6 wow_shr  slideInRight" data-wow-delay=".4s">
                            <div class="col-sm-12 col-xs-12">
                                <img src="${ctxStatic }/images/wlptfront/index/solve_two.jpg" alt="" class=""/>
                                <div class="solve_btn clearfix">
                                    <p class="pull-left">数据中心</p>
                                    <a href="${wlpt}/wlpt/solution?index=1" class="pull-right">
                                        <span class="glyphicon glyphicon-chevron-right"></span>
                                        查看详情
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--战略合作伙伴-->
        <div class="swiper_none">
            <div style="width:100%;" class="footerP">
                <div class="partner open_box">
                    <h3 class="wow_fd fadeInDown text-nowrap text-center">战略合作伙伴</h3>
                    <div class="box_title clearfix wow_fd fadeInDown">
                        <p class="triangle text-center">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                            <i class="box_line line_one"></i>
                            <i class="box_line line_two"></i>
                        </p>
                        <div class="pull-left col-sm-5 col-xs-5"></div>
                        <div class="pull-right col-sm-5 col-xs-5"></div>
                    </div>
                    <div class="container swiper-container partner-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
                                <a href="http://www.zhaogang.com" target="_blank"><img
                                        src="${ctxStatic }/images/wlptfront/c1.png"
                                        alt=""/></a>
                            </div>
                            <div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
                                <a href="http://www.hbistc.com" target="_blank"><img
                                        src="${ctxStatic }/images/wlptfront/c2.png"/></a>
                            </div>
                            <div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
                                <a href="http://www.ouyeel.cn" target="_blank"><img
                                        src="${ctxStatic }/images/wlptfront/c3.png"/></a>
                            </div>
                            <div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
                                <a href="http://www.money56.com" target="_blank"><img
                                        src="${ctxStatic }/images/wlptfront/c4.png"/></a>
                            </div>
                        </div>
                        <div class="swiper-button-next er_next"></div>
                        <div class="swiper-button-prev er_prev"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //将footer放到footerP中
    $('.footer').appendTo('.footerP');
    //banner图片变形问题
    function aa() {
        var allWidth = $(window).width();
        if (allWidth > 500) {
            $('.banner img').jqthumb({
                width: '100%',
                height: '100%',
            });
        }
    }
    //手机端时解决全屏
    var brower_w=$(window).width();
    if(brower_w>768){
        $('.content_none').addClass('content_home');
        $('.content_none').addClass('swiper-container');
        $('.wrapper_none').addClass('swiper-wrapper');
        $('.swiper_none').addClass('swiper-slide');
    }
    if(brower_w<768){
        if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
            new WOW().init();
        };
        $('.fadeInDown').addClass('wow');
        $('.slideInRight').addClass('wow');
        $('.funs .col-sm-4').addClass('wow').addClass('slideInRight');
        $('.funs .wow_fd').addClass('wow').addClass('fadeInDown');
    }
    //banner部分
    var swiper_banner = new Swiper('.banner', {
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        paginationClickable: true,
        spaceBetween: 0,
        centeredSlides: true,
        loop: true,
        autoplay: 2000,
        speed: 1000,
        onInit: function (swiper) {
            aa()
        },
    });
    //合作伙伴
    var swiper2 = new Swiper('.partner-container', {
        nextButton: '.er_next',
        prevButton: '.er_prev',
        loop: true,
        autoplay: 2000,
        speed: 1000,
        paginationClickable: true,
        slidesPerView: 4,
        spaceBetween: 0,
        breakpoints: {
            500: {
                slidesPerView: 2,
            }
        }
    });
    //数字切换
    var swiper = new Swiper('.data_count', {
        onInit: function (swiper) {
            swiperAnimateCache(swiper); //隐藏动画元素
            swiperAnimate(swiper);
            //初始化完成开始动画
            $(".counter").each(count);
        },
        onSlideChangeEnd: function (swiper) {
            swiperAnimate(swiper); //每个slide切换结束时也运行当前slide动画
            $(".counter").each(count);
        }
    });
    function add_class(ani_one, ani_two, ani_th) {
        $(ani_one).css('animation', 'slideInRight 1.5s forwards');
        $(ani_two).css('animation', 'slideInRight 1.5s .2s forwards');
        $(ani_th).css('animation', 'slideInRight 1.5s .4s  forwards');
    }
    function remove_class(r_one, r_two, r_th) {
        $(r_one).css('animation', 'none');
        $(r_two).css('animation', 'none');
        $(r_th).css('animation', 'none');
    }
    function add_classT(one) {
        $(one).css('animation', 'fadeInDown .6s forwards');
    }
    var swiper_home = new Swiper('.content_home', {
        pagination: '.pagination_home',
        direction: 'vertical',
        slidesPerView: 1,
        paginationClickable: true,
        spaceBetween: 0,
        speed: 800,
        mousewheelControl: true,
        onInit: function (swiper) {
            //swiperAnimateCache(swiper); //隐藏动画元素
            //swiperAnimate(swiper);
        },
        onSlideChangeEnd: function (swiper) {
            swiperAnimate(swiper); //每个slide切换结束时也运行当前slide动画
            var index = swiper_home.realIndex;
            if (index == 1) {
                add_classT('.funs .wow_fd');
                add_class('.funs .wow_or', '.funs .wow_tr', '.funs .wow_thr');
            }
            if (index != 1) {
                remove_class('.funs .wow_fd');
                remove_class('.funs .wow_or', '.funs .wow_tr', '.funs .wow_thr');
            }
            if (index == 2) {
                add_classT('.data_count .wow_fd');
                $(".counter").each(count);
            }
            if (index != 2) {
                remove_class('.data_count .wow_fd');
            }
            if (index == 3) {
                add_classT('.solve .wow_fd');
                add_class('.solve .wow_sor', '.solve .wow_str', '.solve .wow_shr');
            }
            if (index != 3) {
                remove_class('.solve .wow_fd');
                remove_class('.solve .wow_sor', '.solve .wow_str', '.solve .wow_shr');
            }
            if (index == 4) {
                add_classT(".partner .wow_fd");
            }
            if (index != 4) {
                remove_class('.partner .wow_fd');
            }
        },
    });
    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
        new WOW().init();
    }
    $('.down img').click(function(){
		swiper_home.slideTo(1, 1000, false);
		add_classT('.funs .wow_fd');add_class('.funs .wow_or','.funs .wow_tr','.funs .wow_thr');
	});
</script>
</body>
</html>
