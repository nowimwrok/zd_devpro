


//轮播图--点击左右按钮切换图片
$(".carousel").carousel();
  $(".left").on("click",function(){
      $(".carousel").carousel("prev");
  })
  $(".right").on("click",function(){
      $(".carousel").carousel("next");
  })






//车长要求、车型要求、货物重量等切换背景--根据页面有部分公共样式
   $(".car_require li").on("click",function(){
    $(".car_require li").removeClass("active")
    $(this).addClass("active")
   })
   $(".carLength_req li").on("click",function(){
    $(".carLength_req li").removeClass("active")
    $(this).addClass("active")
   })
   $(".goods_weight li").on("click",function(){
    $(".goods_weight li").removeClass("active")
    $(this).addClass("active")
   })

   $(".sort_style li").on("click",function(){
    $(".sort_style li").removeClass("active")
    $(this).addClass("active")
   })
   $(".car_nature li").on("click",function(){
    $(".car_nature li").removeClass("active")
    $(this).addClass("active")
   })
   $(".model_weight li").on("click",function(){
    $(".model_weight li").removeClass("active")
    $(this).addClass("active")
   })






// 点击首页导航切换背景--公共
$(".menu li").on("click",function(){
    $(".menu li").removeClass("active-menu")
    $(this).addClass("active-menu")
})
$(".menu li").eq(0).addClass("active-menu")
//鼠标悬停出现二级菜单--公共
$(".dropdown").mouseover(function() {
        $(this).addClass('open');
    }).mouseout(function() {
        $(this).removeClass('open');
    });