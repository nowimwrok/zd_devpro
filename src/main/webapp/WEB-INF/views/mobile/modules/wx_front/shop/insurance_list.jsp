<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
      content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet">
<link href="${ctxStatic}/weixin/css/shop.css" rel="stylesheet">
<title>保险列表</title>
<style>
 *{
     padding:0px;
     margin: 0px;
 }
 .shop_menu .menu li p {
     height: 30px;
     line-height: 30px;
     text-align: center;
     font-size: 0.8rem;
 }
 .shop_menu .menu {
     width: 67%;
     float: left;
     padding: 0px;
     padding: 10px 0;
 }
 .shop_menu .header-info {
     /* height: 132px; */
     line-height: 80px;
     float: left;
     width: 31%;
     margin: auto 0px;
 }
.shop_introduce ul{
     width: 100%;
     margin: 0px;
     padding: 0px;
 }
 .shop_introduce ul li{
     margin-bottom: 10px;
 }
 .shop_menu .header-info .header img {
   margin-top: 15px;
   width: 50px;
   padding-top: 0px;
   height: 50px;
   border-radius: 50%;
}
input {
    font-size: 0.9em;
    line-height: 35px;
    text-align: center;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}
.search_top,.result_bottom {
	width: 100%;
	display: block;
	border-bottom: 1px dashed #999;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}

.search_top {
	height: 35px;
	width: 100%;
	line-height: 35px;
	border-bottom: 1px solid #EBEBEB;
	background-color: #FFF;
	margin: 0px auto;
}
.data_tab div {
	float: left;
	text-align: center;
	width: 33.3%;
}

.data_tab {
	width: 100%;
	margin: 0px auto;
}

/* .selected {
	color: #F74000;
} */
/* .selected {
    background-color: rgb(255,247,244); */
    /* color: rgb(27, 216, 244); */
    /*color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
} */
.selected {
    background-color: #fff;
    /* color: rgb(27, 216, 244); */
    color: #ff7400;
    border-bottom: 2px solid #FF7400;
}

.shop_introduce {
	width: 98%;
	margin: 0 auto;
	margin-top: 45px;
	margin-bottom: 30px;
}
.text-price{
	color: #ccc;
    float: right;
    padding-right: 20px;
}
.price {
    font-size: 18px;
    color: #ff7400;
}
.Buynow_right .line {
    height: 47px;
    line-height: 47px;
    font-size: 0.8rem;
}
.Buynow_right .line>div {
    float: left;
    line-height: 40px;
    line-height: 25px;
    height: 25px;
}
.line-telet{
	padding-right: 8px;
    font-size: 18px;
    font-family: 微软雅黑;
}

.Buynow_right {
    float: left;
    width: 64%;
    font-size: 0.9rem;
    margin-top: 5px;
    height: 95px;
    border-bottom: 0.3px solid #ccc;
}
.Buynow_left img {
    width: 93%;
    height: 100px;
    border: 0.3px solid #ccc;
}
</style>
</head>
<body>


<div class="search_top top" style="color:#1e1e1f;top:0px;">
		<div class="data_top data_tab" >
			<div class="selected">全部</div>
			<!-- <div>交易中</div>
			<div>待支付</div> -->
		</div>
</div>
<!--主体内容-->
<section class="allr_wrap">
    <div class="shop_introduce">
        <ul id="data_box">

            <%-- <li class="clearfix" onclick="return check();">
                <div class="Buynow_left">
                    <a class="shop_a" href="${wx }/weixin/shop/insur_detail" >
                        <img src="${ctxStatic }/images/weixin/shop_img/shop-icon_21.gif"/>
                    </a>
                </div>
                <div class="Buynow_right">
                    <div class="line">
                        <div class="line-telet">国内货物运输保险-人寿</div>
                        
                    </div>
                    <div class="line">
                        <strong>
                            <i class="">平安保险</i>
                        </strong>
                        <span class="text-price">直购价<span class="price">￥40</span></span>
                    </div>
                </div>
            </li> --%>
			
        </ul>
    </div>
    <div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
    <div id="pages" style="display:none;">
		<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
		<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
		<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
			id="pageCount">1</b><span>页</span> </span>
	</div>
	<div class="search_top result_bottom bottom">
		共<b id="totalCount">0</b>条信息
	</div>
</section>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script src="${ctxStatic }/weixin/js/weixin/global.js"></script>
<script type="text/javascript">
$("#loading").show();
$(function() {
	//条件
	var tab_i = 0;
	var searchConditions = {};
	searchConditions.pageSize = 10;
	searchConditions.pageNo = 1;
	searchData(1);
	var nowpage = 1; ///当前页数
	var nowcount = 1;
	//------------------------------------------------
	$(".data_tab div").click(function() {
			tab_i = $(this).index();
			$(this).addClass("selected");
			$(".data_tab div").not(this).removeClass("selected");
			searchConditions={};
			searchConditions.pageSize = 10;
			searchConditions.pageNo = 1;
			nowpage=1;
			nowcount = 1;
			/* if(tab_i==0){
			}else if(tab_i==1){
				searchConditions.istrading='1';
			}else if(tab_i==2){
				searchConditions.orderstatus='2';
			} */
			$("#data_box").html("");
			searchData(1);
	});
	$(window).scroll(
		function() {
			var pageCount = $("#pageCount").html();
			//下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8  
			var htmlHeight = document.body.scrollHeight
					|| document.documentElement.scrollHeight;
			//clientHeight是网页在浏览器中的可视高度，  
			var clientHeight = document.body.clientHeight
					|| document.documentElement.clientHeight;
			//scrollTop是浏览器滚动条的top位置，  
			var scrollTop = document.body.scrollTop
					|| document.documentElement.scrollTop;
			//通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；  
			if (scrollTop + clientHeight == htmlHeight) {
				nowpage += 1;
				if (nowpage <= parseInt(pageCount)) {
					searchData(nowpage);
				}

			}
		});
	//查询数据ajax
	function searchData(pageNo) {
		$("#loading").show();
		$("#page").hide();
		//$("#data_box").html("");
		searchConditions.pageNo = pageNo;
		$.ajax({
			type : "POST",
			url : '${wx}/weixin/shop/getInsuranceList',
			data : searchConditions,
			dataType : 'json',
			cache : false,
			success : function(data) {
				if (data.value.list != null) {
					if (data.value.list.length <= 0) {
						$("#totalCount").html(0);
						$("#data_box").show().append(
							'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
					} else {
						$("#page").show();
						nowcount = data.value.count;
						//赋值分页总数
						$("#pageCount").html(Math.ceil(data.value.count / searchConditions.pageSize));
						//赋值当前页数
						$("#curPage").html(searchConditions.pageNo);
						//赋值数据总条数
						$("#totalCount").html(nowcount);
						var fillDatas = "";
						for (var i = 0; i < data.value.list.length; i++) {
							fillDatas += fillDataOne(data.value.list[i]);
						}
						if(Math.ceil(data.value.count / searchConditions.pageSize)==1){
							$("#data_box").html("");	
						}
						$("#data_box").append(fillDatas);
					}
				} else {
					$("#totalCount").html(0);
					$("#data_box").html("");
					$("#data_box").show().append(
						'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
					$("#loading").hide();
				}
				$("#loading").css('display', 'none');
				$("#loading").hide();
			}
		});
	}
	
	/***************填充到页面的数据***************/

	function fillDataOne(data) {
		var insurAmount = data.insurAmount!=undefined?data.insurAmount:"0";
		
		
		//保险公司简称
		var insurCompanyname = data.insurCompanyname!=undefined?data.insurCompanyname:"--";
		if (insurCompanyname.length > 4) {
			insurCompanyname = insurCompanyname.substring(0, 4) ;
		}
		
		//保险名称
		var insurName = data.insurName!=undefined?data.insurName:"--";
		if (insurName.length > 15) {
			insurName = insurName.substring(0, 15) ;
		}
		
		
		var img =  +'<img src="${ctxStatic }/images/weixin/shop_img/insur-logo.jpg"/>'
		var insurLogo = data.insurLogo!=undefined?data.insurLogo:"";
		if(insurLogo != ""){
			img =  '<img src="'+insurLogo+'" onerror="this.onerror=null;this.src='+'"${ctxStatic }/images/weixin/shop_img/insur-logo.jpg"'+'"/>';
		}
		
		var html = '<li class="clearfix" onclick="dataDetails(' + "'"+ data.id+ "'"+ ')">'
            	   +'<div class="Buynow_left">'
            	   +img
            	   +'</div>'
            	   +'<div class="Buynow_right">'
            	   +'<div class="line">'
            	   +'<div class="line-telet">'+insurName+'</div>'
            	   +'</div>'
            	   +'<div class="line">'
            	   +'<strong>'
            	   +'<i class="">'+insurCompanyname+'保险</i>'
            	   +'</strong>'
            	   +'<span class="text-price">直购价<span class="price">￥'+insurAmount+'</span></span>'
            	   +'</div>'
            	   +'</div>';
		html = html + '</li>';
		return html;
	}

	window.dataDetails = function(id) {
		window.location.href = "${wx}/weixin/shop/insur_detail?id="
			+ id;
	}
});
</script>
</body>
</html>