<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>运输合同</title>
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	width: 100%;
	margin: 0 auto;
	text-align: center;
	border: 1px solid #D6D3CE;
	font-family: "微软雅黑";
}

ul p span a input td {
	font-family: "微软雅黑";
}
</style>
<style type="text/css">
.infoshow {
	visibility: visible;
}

.infohidden {
	visibility: hidden;
}

#btnSearch {
	line-height: 26px;
	float: left;
	margin-right: 5px;
}

#allcount {
	font-size: 16px;
}

c {
	font-size: 12px;
}
</style>
<link rel="stylesheet" type="text/css"
	href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
<link rel="stylesheet" type="text/css"
	href="${ctxStatic}/modules/wlpt/front/css/personal.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/modules/wlpt/front/css/bid/yqlindex.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/static/modules/wlpt/front/css/bid/Source.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/modules/wlpt/front/css/bid/member.css" />
</head>
<body ng-app="bid" ng-controller="bidCtrl">

	<input type="hidden" id="loginUser" value="${loginUser.id}">

	<p class="user_data">
		<img src="${ctxStatic }/images/wlptfront/line-left.png"> <span
			class="title_blue">我的</span><span class="title_orange">货源</span> <img
			src="${ctxStatic }/images/wlptfront/line-right.png">
	</p>
	<div id="cp_content" style="margin:0px auto;">
		<div class="cp_contentdiv">
			<!-- <div class="titlediv">
				<div class="page-title">我的货源</div>
				<div></div>
			</div> -->
			<!--titlediv end-->
			<div class="mygoods">
				<div class="searchtab">
					<table cellspacing="0" width="770px"
						style="margin: 15px 5px 15px -15px;" border="0">
						<tr
							style="text-align: center; font-family: '微软雅黑'; font-size: 14px;">
							<td style="text-align: right; width: 270px;">始发地: <input
								type="text" name="fromAddress" id="fromAddress"
								readonly="readonly" placeholder="请选择省市"
								class="address_select cy_da_input_size addressformar"> <input
								type="hidden" name="fromProvince" id="FromProv"> <input
								type="hidden" name="fromCity" id="FromCity"></td>
							<!-- <td width="30px;"></td> -->
							<td style="width: 170px">目的地:<input readonly="readonly"
								type="text" name="toAddress" id="toAddress" placeholder="请选择省市"
								class="address_select cy_da_input_size"> <input
								type="hidden" name="toProvince" id="ToProv"> <input
								type="hidden" name="toCity" id="ToCity"></td>
							<td>状态:<select id="AuditStatus">
									<option value="">所有</option>
									<option value="1">已生成运单</option>
									<option value="2">未生成运单</option>
									<option value="3">作废货源</option>
							</select>
							</td>
							<td style="text-align: left;">
								<!-- <input id="btnSearch" type="button" class="regbt smallsearch byusersearch" value="搜 索"> -->
								<button class="btn btn-warning" id="btn-warning"
									style="width: 80px; margin-top: -2px; margin-bottom: 0px; border-radius: 0px;float:left; margin-left: 0px; margin-right: 13px;"
									ng-click="selectPage(1)">
									<span class="glyphicon glyphicon-search"></span><span
										class="goods_search_btn" ng-click="selectPage(1)">搜索</span>
								</button> <a class="pubbtn_a" style="height:34px;" onclick="publishGoods()"> <img
									alt="发布货源" title="发布货源"
									src="${pageContext.request.contextPath}/static/images/pub_icon.png"><span>发布</span>
							</a>
							</td>
						</tr>
					</table>

				</div>
				<div class="datalist-head table-title" style="clear: both">
					<div class="title1 gmnavseplace"
						style="border-right: 1px dashed #fff;">始发地→目的地</div>
					<div class="title1 gdsname" style="border-right: 1px dashed #fff;">货物名称</div>
					<div class="title1 pu" style="border-right: 1px dashed #fff;">
						重量/体积</div>
					<div class="title1 putdate" style="border-right: 1px dashed #fff;">发布日期</div>
					<div class="title1 gmoption">操作</div>
				</div>
				<div id='loading'
					style='width: 100%; vertical-align: middle; text-align: center; height: 45px'>
					<div>
						<img
							src='${pageContext.request.contextPath}/static/images/loading-30x30.gif'>
					</div>
					<div style=''>正在努力加载中，请稍等!</div>
				</div>
				<div>
					<div id="soucrinfo"></div>
				</div>
				<div id='notdata'>抱歉！没有找到与您条件匹配的货源， 请重新搜索</div>
				<div class="pagediv">
					<table>
						<tr>
							<td><a id="firstPage" class="pagediv_size">首页</a></td>
							<td><a id="previewPage" class="pagediv_size">上一页</a></td>
							<td><a id="nextPage" class="pagediv_size">下一页</a></td>
							<td><a id="lastPage" class="pagediv_size">尾页</a></td>
							<td class="pagediv_size">总共<b id="pageCount"
								style="color: #ff7300;"></b>页
							</td>
							<td class="pagediv_size">到第<input id="curPageGoto"
								style="color: #ff7300; width: 20px; border-color: #ededed;"><b
								id="curPage" style="color: #ff7300; display: none;"></b>页
								<button class="regbt" id="gotoPage"
									style="width: 50px; height: 24px; background-color: white; color: #404040; border-color: #ededed;">
									<c style="font-size:12xp;">确&nbsp;定</c>
								</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<!--cp_contentdiv end-->
		</div>
		<!--cp_content end-->
	</div>

</body>
<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
<%-- <script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/myjs/wlpt/config.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/myjs/global.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/myjs/wlpt/mygoods.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/zDialog/zDialog.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/zDialog/zDrag.js"></script> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/modules/wlpt/front/js/jquery.pcc.js"></script>
<%-- <script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/hiddenareabox.js"></script> --%>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript">

function publishGoods(){
	//验证是否登录
	if (isLogined()) {
		var status = isStatused();
		//验证是否认证
		if (status!=$.myConfig.certificateStatus.status) {
			       //没有认证跳转认证中心
					$.alert("请先完成认证", function() {
						window.parent.location.href =  "${pageContext.request.contextPath}/wlpt/user/index.do";
					}, 500, 200);
		}else{
			//已认证即可去发布
			 window.location.href = "${pageContext.request.contextPath}/wlpt/goods/topubgoods";
		}
	} else {
		//若没有登录，则跳转登录界面
		window.parent.location.href ="${pageContext.request.contextPath}/wlpt/user/login.do";
	}
}

//********************************************************初始化地区********************************************************//
		$("#fromAddress").PCC({
            hasCounty: false,
            width:360,
            height: 220,
            //color: "blue"
            url: "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon: "${pageContext.request.contextPath}/static/images/pic12.gif",
            complete: function (data) {
                var str = "";
                if(data.province) {
                    str += data.province.NAME + " ";
                    $("#FromProv").val(data.province.NAME);
                    $("#fromAddress").val(str);
                }
                if(data.city) {
                    str += data.city.NAME +" ";
                    $("#FromCity").val(data.city.NAME);
                    $("#fromAddress").val(str);
                }
                $("#fromAddress").val(str);
            }
		});
		
		$("#toAddress").PCC({
            hasCounty: false,
            width:360,
            height: 220,
            //color: "blue"
            url: "${pageContext.request.contextPath}/wlpt/area/getarea",
			closeIcon: "${pageContext.request.contextPath}/static/images/pic12.gif",
            complete: function (data) {
                var str = "";
                if (data.province) {
                    str += data.province.NAME + " ";
                    $("#ToProv").val(data.province.NAME);
                    $("#toAddress").val(str);
                }
                if (data.city) {
                    str += data.city.NAME + " ";
                    $("#ToCity").val(data.city.NAME);
                    $("#toAddress").val(str);
                }
                $("#toAddress").val(str);
            }
		});
		
		var i = 0;
		var y = 0;
		$("#fromAddress").click(function(){
			i++;
			if(i%2==0){
				$(".pcc-container").hide();
			}
		});
		$("#toAddress").click(function(){
			y++;
			if(y%2==0){
				$(".pcc-container").hide();
			}
		});

		$("#gotoPage").click(function(){
			var gotoPage=$("#curPageGoto").val();
			gotoPage=(gotoPage!=null&&gotoPage!="")?gotoPage:"1";
			var thePageCount=$("#pageCount").html();
			if(isNums(curPageGoto)){
				
				if(parseInt(gotoPage)>parseInt(thePageCount)){
					$(curPageGoto).tips({
						side : 3,
						msg : '输入页码不能超过总页码',
						bg : '#FF7300',
						time : 3
					});
					$(curPageGoto).val('');
				}else{
					searchGoodsList(gotoPage);
				}
			}
		});
		

		//校验页码数字
		function isNums(obj) {
			var n = $(obj).val();
			if (n != '' && (isNaN(n) ||parseInt(n)==0|| parseInt(n) < 0)) {
				$(obj).tips({
					side : 3,
					msg : '请输入正数',
					bg : '#FF7300',
					time : 3
				});
				$(obj).val('');
				return  false;
			}
			return true;
		}


</script>
</html>

