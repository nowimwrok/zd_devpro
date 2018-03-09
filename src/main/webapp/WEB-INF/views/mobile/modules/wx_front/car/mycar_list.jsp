<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>


<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${fns:getConst('SYSTEMTITLE')}--车辆列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">

.search_top,.result_bottom {
	width: 100%;
	display: block;
	border-bottom: 1px dashed #999;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}
.search_top{
	height:72px;
	width:100%;
	line-height:50px;
	border-bottom: 10px solid #EBEBEB;
	background-color: #FFF;
	margin:0px auto;
	margin-top:2px;
	background-color: white;
}
.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.top {
	top: 0px;
}

.bottom {
	bottom: 0px;
}


#data_box,#data_add {
	width: 100%;
	margin:0 auto;
	margin-top: 84px;
	margin-bottom: 10px;
	background-color: #EBEBEB;
}

.data_div {
	width: 96%;
	background-color: #FFF;
	clear: both;
	height: 72px;
	margin: 0 auto;
	margin-bottom: 10px;
	border-radius:10px;
}

.data_rows {
	width: 100%;
	height: auto;
	display: block;
}
.goods_rows{
	height:70px;
}
.goods_rows .drw_left,.drw_middle,.drw_right {
	float: left;
	height: 82px;
}
.car_rows{
	height:72px;
}
.car_rows .drw_left,.drw_middle,.drw_right {
	float: left;
	height: 72px;
}
.drw_left {
	width: 20%;
	text-align: center;
	font-size:15px;
}

.drw_middle {
	width: 60%;
}

.goods_rows .drw_middle div {
	text-align: left;
	float:left;
	height: 25px;
	line-height: 25px;
	margin-right:5px;
	overflow:hidden;
}
.car_rows .drw_middle div {
	text-align: left;
	float:left;
	height: 24px;
	line-height: 24px;
	/* margin-right:5px; */
	overflow:hidden;
}
.drw_right {
	width: 20%;
}
.dm_bottom{
	clear:both;
	color:#666;
}
.dm_bottom div{
	float:left;
	margin-right:10px;
}
.icons {
	width: 56px;
	margin: 8px 0px;
}
.goods_icons{
	width: 56px;
	margin:7px 0;
}
.rows_bottom {
	background: #EBEBEB;
	height: 6px;
	line-height: 6px;
	text-indent: 12px;
	font-size: 14px;
	margin-left: -2%;
	margin-right: -2%;
	color:white;
}

.sendtime{
	width:50%;
	float:left;
}
.pubtime{
	width:40%;
	float:right;
	padding-right:10px;
}
.data_tab div {
	float: left;
	text-align: center;
	
}
.data_tab{
	width:98%;
	margin:0px auto;
}
.selected {
	/* background-color: rgb(32, 134, 226); */
	color: #3592E2;
}

.data_tab_left {
	width: 49%;
}

.data_tab_right {
	width: 50%;
}
.address_div {
	clear: both;
	width: 100%;
	margin: 0 auto;
	background-color:#FFFFFF;
}
.search_ul {
	width: 100%;
	height: 35px;
	list-style: none;
	margin: 5 auto;
	background-color: #EBEBEB;
}
.search_ul li {
    float: left;
    text-align: center;
    line-height: 35px;
    width:50%;
}
.li_icon {
	width: 10%;
	text-align: left;
}

.li_txt {
	width: 43%;
	text-align: left;
	float: left;
	padding-left: 10px;
	height:30px;
	line-height: 30px;
}
#search {
	cursor: pointer;
	line-height: 36px;
	text-align: center;
	background-color: rgba(32, 162, 226, 1);
	color: #FFFFFF;
	-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;
	padding:0px 1%;
}
#search2 {
	cursor: pointer;
	width: 100%;
	line-height: 35px;
	text-align: center;
	background-color: rgb(27, 216, 244);
	color: #FFFFFF;
}

#search a {
	text-decoration: none;
}
.hedImg {
    width: 56px;
    height: 56px;
    margin: 2px auto;
    border-radius: 40px;
    border: 1px solid #CCC;
}
.hededImg {
    width: 56px;
    height: 56px;
    margin: 8px auto;
    border-radius: 40px;
    border: 1px solid #CCC;
}
.hedImg img{
  width: 56px;
  height: 56px;
  border-radius: 40px;
}
.jqthumb div{
  width: 56px;
  height: 56px;
  border-radius: 40px;
}
.authened {
    color: white;
    margin-right: 5px;
    background: rgba(20, 181, 47, 0.83);
    font-size: 0.8em;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    padding: 5px;
    height: 20px;
    line-height: 20px;
    margin: 5px;
    text-align: center;
}
.authened1 {
    color: white;
    margin-right: 5px;
    background: rgb(32, 134, 226);
    font-size: 0.8em;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    padding: 5px;
    height: 70px;
    line-height: 70px;
    margin: 5px;
    text-align: center;
}
</style>
</head>

<body style="background-color:#EBEBEB;">

	<div class="search_top top">
		<div class="search_ul" style="width:100%;margin:0px auto;">
<input type="hidden" id="loginPhone" value="${fns:getUser().loginName}"/>
			<div style="width:100%;height:100%;">
			<div style="width:75%;height:100%;float:left;">
			<div style="width:96%;height:100%;float:left;margin:0px 3%;">
				<input class="li_txt" type="text" id="fromAddress"
					readonly="readonly" placeholder="请选择省市" /> <img
					style="float:left; margin-top:2px;width:30px;"
					src="${ctxStatic }/images/weixin/switch_btn.png" /><input
					class="li_txt" type="text" id="toAddress" readonly="readonly"
					placeholder="请选择省市" />
					<input id="Fpro" type="hidden" value="" /><input id="FCity"
						type="hidden" value="" /> <input id="Tpro" type="hidden" value="" /><input
						id="TCity" type="hidden" value="" />
			</div>
					
			</div>
			<div style="width:21.5%;float:right">
				<div id="search2"
						style="height:30px;text-align:center;line-height:30px;"><a style="display:block;width:100%;" href="${wx}/weixin/car/toSave"><span style="color:#FFFFFF;">发布</span></a></div>
				</div>
			
			</div>
			<div style="width:100%;background-color:white;">
				<div style="width:75%;height:100%;float:left;">
				<input type="text" id="searchinfo" placeholder="车牌号/手机号码"
					style="width:66%;float:left;margin:7px 18%;height:26px;line-height:26px;border:1px solid #EBEBEB;" />
				
					
						
				</div>
 				<div style="width:25%;height:100%;float:left;">
				<div id="search" style="height:35px;text-align:center;line-height:35px;float:left;width:90%;">搜索</div>
				</div>
			</div>
		</div>
	</div>
	<div id="data_box">
	</div>
	<div id="data_add" style="display:none;margin-top:50px;background:#FFF;">
	</div>
	<div id='loading'
		style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
		<div>
			<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
		</div>
		<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中……</div>
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
	
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/include/jqthumb.min.js"></script>
	<script type="text/javascript">
		$("#loading").show();
		$(function() {
			//条件
			var tab_i=0;
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
					if (tab_i == 0) {
						$("#data_add").hide();
						$("#data_box").show();
						$(".result_bottom").show();
					} else {
						$("#data_add").show();
						$("#data_box").hide();
						$(".result_bottom").hide();
						//window.href="${wx}/weixin/carSource/carSource_adds";
					}
			});
			//按地址条件查询
			$("#search").click(
					function() {
						searchConditions.fromcity = $("#FCity").val();
						searchConditions.fromprovince = $("#Fpro").val();
						searchConditions.tocity = $("#TCity").val();
						searchConditions.toprovince = $("#Tpro").val();
						searchConditions.searchinfo=$("#searchinfo").val();
						$("#data_box").html("");
						searchData(1);
					});
			
			$(window).scroll(function() {
					if(tab_i==1){
						return;
					}
					var curPageNo = $("#curPage").html();
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
			//类型查询
			$(".contype_per .contype").first().css("color", "#3592E2");
			$(".contype_per .contype").click(function() {
				$(this).css("color", "#3592E2");
				var type = $(this).index() / 2;
				searchConditions.BIDDINGSTATUS = type;
				if (type <= 0) {
					searchConditions = {};
					searchConditions.pageSize = 10;
					searchConditions.pageNo = 1;
				}
				$(".contype_per .contype").not(this).css("color", "#000");
				$("#data_box").html("");
				searchData(1);
			});
			//查询数据ajax
			function searchData(pageNo) {
				$("#loading").show();
				$("#page").hide();
				//$("#data_box").html("");
				searchConditions.pageNo = pageNo;
				searchConditions.ISMYCAR="trues";
				$.ajax({
							type : "POST",
							url : '${wx}/weixin/car/getCarList',
							data : searchConditions,
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list != null) { 
									if (data.value.list.length <= 0) {
										$("#data_box").html("");
										$("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									} else {
										$("#page").show();
										nowcount = data.value.count;
										$("#pageCount").html(Math.ceil(data.value.count / data.value.pageSize));
										//$("#allCount").html(data.data.ALLCOUNT);
										$("#curPage").html(
												searchConditions.pageNo);
										$("#totalCount").html(nowcount);
										var fillDatas = "";
										for (var i = 0; i < data.value.list.length; i++) {
											fillDatas += fillDataOne(data.value.list[i]);
										}
										/* $("#data_box").html(""); */
										$("#data_box").append(fillDatas);
										$('.hedImg img').jqthumb({
											width: 56,
											height: 56,
											after: function(imgObj){
												imgObj.css('opacity', 0).animate({opacity: 1}, 1000);
											}
										});
										$(".hedImg").removeClass("hedImg");
									}
								} else {
									$("#data_box").html("");
									$("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} 
								$("#loading").css('display', 'none');
								$("#loading").hide();
							}
						});
			}

			/***************填充到页面的数据***************/
			function fillDataOne(data) {
			
			var name=((data.ownername)!=null?(data.ownername):(data.user.name!=null?data.user.name:data.user.loginName));
			if(name.length>=5){
				name=name.substr(0,5)+"..";
			}
			var headurl='<div><img class="car_icons goods_icons" alt="车主"	src="${ctxStatic }/images/weixin/icon_personal.png"/></div>';
			if(data.user!=null&&data.user!=""&&data.user.photo!=null&&data.user.photo!=""){
				headurl='<div class="hedImg hededImg"><img class="car_icons goods_icons" alt="车主"	src="'+data.user.photo+'"/></div>';
			}else{
				headurl='<div><img class="car_icons goods_icons" alt="车主"	src="${ctxStatic }/images/weixin/icon_personal.png"/></div>';
			}
			
			var bnt = '<div class="authened" onclick="apply(' + "'"+ data.id+ "'"+ ')">认证</div>';
			var bntedit = '<div class="authened" onclick="Edit(' + "'"+ data.id+ "'"+ ')">编辑</div>';
			
			var bnted = '<a href="javascript:callPhone('+data.user.phone+')"><img class="icons" alt="电话" src="${ctxStatic }/images/weixin/weixincall.png"></a>';
			var statusbnt="";
			var status = "";
			if(data.status != undefined && data.status != null && data.status != ""){
				if( data.status==0){
					status = "未认证";
				}else if( data.status==1){
					status = "已申请";
				}else if( data.status==2){
					status = "已认证";
				}else if( data.status==3){
					status = "认证不通过";
				}else{
					
					status = "未认证";
				}
			}else{
				status = "未认证";
			}
			
			
			var html='<div class="data_div" style="height:72px;" >'
					+'<div class="data_rows car_rows">'
					+'<div class="drw_left">'
					+headurl
					+'</div><!-- drw_left end -->'
					+'<div class="drw_middle" onclick="datasEdit(' + "'"
					+ data.id
					+ "'"
					+ ')">'
					+'<div class="dm_top">'
					+'<div class="font_weight font15">'+name+'|'+(data.carnumber!=null?data.carnumber:"")+'|'+status+'</div>'
					+'</div><!-- dm_top -->'
					+'<div class="" style="float:left;color:#666;">'
					+'<div class=" font14 ">'+(data.mainroad!=null?data.mainroad:"暂无")+'</div>'
					+'</div>'
					+'<div class="dm_bottom font12">'
					+data.carlength+'米'+'&nbsp;&nbsp;'+data.cartype+'&nbsp;&nbsp;'+data.loadweight
					+'吨</div><!-- dm_bottom -->'
					+'</div><!-- drw_middle end -->'
					+'<div class="drw_right">'
					+''+bnted+''
					+'</div><!-- drw_right end -->'
					+'</div><!-- data_rows end -->'
					+'</div>';
			
			return html;
		}
			window.callPhone=function(phone){
				if($("#loginPhone").val()!= null&&$("#loginPhone").val()!= ""){
					window.location.href="tel:"+phone;
				}
			};
			window.datasEdit=function(id){
				if($("#loginPhone").val()!= null&&$("#loginPhone").val()!= ""){
				window.location.href="${wx}/weixin/car/car_detail?id=" + id;
				}else{
					alert("请先绑定或注册新的账号");
				}
			};
			
			window.Edit=function(id){
				window.location.href="${wx}/weixin/car/toSave?id=" + id;
				
			};
			window.apply=function(id){
				window.location.href="${wx}/weixin/car/carApply?id=" + id;
				
			};
			window.callPhone=function(phone){
				if($("#loginPhone").val()!= null&&$("#loginPhone").val()!= ""){
					window.location.href="tel:"+phone;
				}
			};
			
			
			//---------------------------------地址数据
			
			$("#fromAddress").PCC({
				hasCounty : false,
				width : "94%",
				height : 320,
				url : "${wlpt}/wlpt/chinaarea/getArea",
				closeIcon: "/static/images/pic12.gif",
				complete : function(data) {
					var str = "";
					searchConditions.FROMADDRESS='';
					searchConditions.fromcity = '';
					searchConditions.fromprovince = '';
					if (data.province) {
						str += data.province.NAME + " ";
						searchConditions.fromprovince = data.province.NAME;
						$("#Fpro").val(data.province.NAME);
					}
					if (data.city) {
						if (data.city.NAME != data.province.NAME) {
							str += data.city.NAME;
							searchConditions.fromcity = data.city.NAME;
							$("#FCity").val(data.city.NAME);
						}
					}
					if(str!=" "){
						$("#fromAddress").val(str);
					}else{
						$("#Fpro").val("");
						$("#FCity").val("");
						$("#fromAddress").val("");
					}
				}
			});

			$("#toAddress").PCC({
				hasCounty : false,
				width : "94%",
				height : 320,
				url : "${wlpt}/wlpt/chinaarea/getArea",
				closeIcon: "/static/images/pic12.gif",
				location: "left",
				ismiddle: true,
				complete : function(data) {
					var str = "";
					searchConditions.TOADDRESS='';
					searchConditions.tocity = '';
					searchConditions.toprovince = '';
					if (data.province) {
						str += data.province.NAME + " ";
						searchConditions.toprovince = data.province.NAME;
						$("#Tpro").val(data.province.NAME);
					}
					if (data.city) {

						if (data.city.NAME != data.province.NAME) {
							str += data.city.NAME;
							searchConditions.tocity = data.city.NAME;
							$("#TCity").val(data.city.NAME);
						}
					}
					if(str!=" "){
						$("#toAddress").val(str);
					}else{
						$("#Tpro").val("");
						$("#TCity").val("");
						$("#toAddress").val("");
					}
					/* searchGoods(1); */
				}
			});
		});
	</script>
</body>
</html>
