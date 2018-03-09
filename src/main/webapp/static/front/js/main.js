/**
 * Created by AUP2 on 2016/10/31.
 */


// µã»÷¸ß¼¶ËÑË÷³öÏÖËÑË÷¿ò
$(".search_wrap_one .senior_search").on("click",function(){
    $(".query_list").toggle(1000);
});


//ÈÃµ±Ç°µÃµ½½¹µãµÄÎÄ±¾¿ò¸Ä±äÆä±ß¿ò
$(".low_search input:text").focus(function(){
    $("input:text").removeClass("search_border");
    $(this).addClass("search_border");
});
$(".low_search input:text").blur(function(){
    $(this).removeClass("search_border");
});



//µ×²¿Í¼Æ¬»¬¶¯
$(".flexiselDemo3").flexisel({
    visibleItems: 5,
    animationSpeed: 1000,
    autoPlay: true,
    autoPlaySpeed: 2000,
    pauseOnHover: true,
    enableResponsiveBreakpoints: true,
    responsiveBreakpoints: {
        portrait: {
            changePoint:480,
            visibleItems: 1
        },
        landscape: {
            changePoint:640,
            visibleItems: 2
        },
        tablet: {
            changePoint:768,
            visibleItems: 3
        }
    }
});




//ÅàÑµÖÐÐÄ»¬¶¯
$(".train_flexisel").flexisel({
    visibleItems: 4,
    animationSpeed: 1000,
    autoPlay: true,
    autoPlaySpeed: 2000,
    pauseOnHover: true,
    enableResponsiveBreakpoints: true,
    responsiveBreakpoints: {
        portrait: {
            changePoint:480,
            visibleItems: 1
        },
        landscape: {
            changePoint:640,
            visibleItems: 2
        },
        tablet: {
            changePoint:768,
            visibleItems: 3
        }
    }
});



        // 车型要求

        $(".carType_require li a").on("click",function(){
            $(".carType_require li a").removeClass("search_active");
            $(this).addClass("search_active");
        });

        // 车长要求
        $(".carlength_require li a").on("click",function(){
            $(".carlength_require li a").removeClass("search_active");
            $(this).addClass("search_active");
        });

        // 货物重量�?
        $(".goodWei_ditail li a").on("click",function(){
            $(".goodWei_ditail li a").removeClass("search_active");
            $(this).addClass("search_active");
        });

        // 排序方式�?
        $(".sort_detail li a").on("click",function(){
            $(".sort_detail li a").removeClass("search_active");
            $(this).addClass("search_active");
        });

        // 车辆性质�?
        $(".carNature_detail li a").on("click",function(){
            $(".carNature_detail li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //诚信
        $(".honer_detail li a").on("click",function(){
            $(".honer_detail li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //仓库地址
        $(".warehouse_address li a").on("click",function(){
            $(".warehouse_address li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //仓库面积
        $(".warehouse_area li a").on("click",function(){
            $(".warehouse_area li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //仓库类型
        $(".warehouse_type li a").on("click",function(){
            $(".warehouse_type li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //仓库模式
        $(".warehouse_model li a").on("click",function(){
            $(".warehouse_model li a").removeClass("search_active");
            $(this).addClass("search_active");
        });
        //仓库模式
        $(".warehouse_model li a").on("click",function(){
            $(".warehouse_model li a").removeClass("search_active");
            $(this).addClass("search_active");
        });

//·ÖÒ³
/*
$(".tcdPageCode").createPage({
    pageCount:100,
    current:1,
    backFn:function(p){
        //console.log(p);
    }
});*/
