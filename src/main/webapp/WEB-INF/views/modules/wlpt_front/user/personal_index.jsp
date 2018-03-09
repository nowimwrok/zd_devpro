<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${fns:getConst('SYSTEMTITLE')}</title>
<link href="${ctxStatic }/modules/wlpt/front/css/persional_index.css"
	type="text/css" rel="stylesheet" />
<link href="${ctxStatic }/modules/wlpt/front/css/wlpt_index.css"
	type="text/css" rel="stylesheet" />
</head>
<style> 
.table {
	width: 95%;
}

.table-bordered th, .table-bordered td {
	/* border-left: 1px solid #ddd; */
	
}

.table th, .table td {
	border-top: 1px solid #ddd;
	line-height: 20px;
	padding: 8px;
	text-align: center;
	vertical-align: top;
}

.table td {
	border-top: 1px dashed #ddd;
}

.table thead:first-child tr th:last-child, .table tr td:last-child {
	/*  border-right: 1px solid #ddd; */
	
}

.ft14 {
	font-size: 14px;
}

.ft16 {
	font-size: 16px;
}

.adbt {
	width: 65px;
	height: 25px;
	line-height: 25px;
	text-align: center;
	float: left;
	margin-top: 10px;
}

.adbt a {
	color: #FFFFFF
}

.more {
	float: right;
	line-height: 60px;
	padding-right: 10px;
}

.baseinfo-td {
	padding: 0px 20px;
}
.baseinfo-table{
	width:900px;
}
.baseinfo {
    float: left;
    color: #666;
    font-weight: bold;
    line-height: 20px;
    font-size: 13px;
}

.img-td {
	padding: 5px 15px;
}

.tip-td {
	text-align: center;
}

.tip-span {
	font-size: 15px;
	color: #000;
}

.ol-condition-div {
	height: 50px;
}

.ol-condition-ul {
	height: 36px;
	margin: 10px 0px;
}

.ol-condition-ul li {
	float: left;
	line-height: 30px;
	color: #666;
	font-size: 16px;
}

.sub-title-div {
	height: 15px;
	margin-top: 2px;
	background: #F5F5F5;
}

.ol-content-div {
	width: 832px;
	border: 1px solid #f2f2f2;
	border-top: 1px solid #EBEBEB;
	background-color: #FFF;
}

.lineinfo {
	display: none;
}

.carinfo {
	display: block;
}
/**
*/
.divbackgroup {
	background-color: #FFF;
	width: 835px;
	margin: 15px 0px 20px 0px;
	padding-top: 1px;
}

.titleborder {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
}

.ordertable_title {
	width: 8%;
	float: left;
	color: rgb(51, 187, 255);
	font-size: 16px;
}

.ordertable_border {
	width: 1px;
	float: left;
	border-right: 1px dashed #999;
	height: 24px;
	margin-top: 15px;
}

.record_title {
	width: 10%;
	float: left;
	color: rgb(51, 187, 255);
	font-size: 16px;
}

.altrow {
	text-align: center;
}
/**
*/
.user-checked {
	background-color: #5CC92E;
	color: white;
}

.cp_content {
	margin-top: 10px;
	width: 969px;
}


.cardbtm {
	width: 100px;
	background: #5cec2d;
	border: none;
	padding: 5px 0px;
	border-radius: 5px;
	color: #FFF;
	cursor: pointer;
}

.page-title {
	height: 40px;
	line-height: 40px;
}
.personright {
    width: 950px;
    height: 830px;
    padding: 0px;
    margin: 0px auto;
}
.psnl_baseInfo {
	width:900px;
    height: auto;
    background: #fff;
    display: inline-block;
    padding: 0px 20px 0px 30px;
    margin-bottom: 10px;
}
.personal_titel_img{
    border-radius: 65px;
    border: 1px solid #ccc;
}

.zhong_td_width{
	width: 25%;
	padding-left: 20px;
}
.personal_bottom {
    text-align: center;
    height: 60px;
    line-height: 60px;
}
.xia_td_width{
	width: 20%;
	text-align: center;
}
.baseInfo_tab{
	height: 45px;
	line-height: 45px;
}
.baseInfo_tab_ul{
	padding: 0px;
	margin: 0px;
	height: 45px;
	line-height: 45px;
}
.baseInfo_tab_ul li{
	list-style: none;
	float: left;
	height: 45px;
	line-height: 45px;
	width: 190px;
	border: 1px #ccc solid; 
	text-align: center;
}
.baseinfo_tab_select{
	background-color: rgb(0,77,159);
	color: #fff;
}
</style>
<body id="bodyid" style="height: 800px;     background-color: rgb(241,241,241);">
	<div  class="cp_content" style="">

		<div class="personright">
			<div class="psnl_baseInfo">
				<table class="baseinfo baseinfo-table">
					<tr>
						<td style="padding: 0px 20px;"><c:choose>
								<c:when test="${empty user.photo}">
									<img class="personal_titel_img" width="120px" height="120px;"
										src="${ctxStatic}/images/wlptfront/persional.png" />
								</c:when>
								<c:otherwise>
									<img class="personal_titel_img" width="120px" height="120px;" src="${user.photo}" />
								</c:otherwise>
							</c:choose></td>
						<td style="padding: 0px 20px 0px 10px;"><span
							style="font-size: 16px; line-height: 40px;" class="ft14">${user.name==null?user.phone:user.name}</span>
							<br /> 
								<span style="margin-right: 10px;" title="点击进入企业网站"><a
									style="" target="_blank">${user.role.name }</a></span>
							<c:if
								test="${user.userinfo.status==0||user.userinfo.status==3}">
								<span class="user-checked" style="width: 36px;">未认证</span>
							</c:if> <c:if test="${user.userinfo.status==1}">
								<span class="user-checked" style="width: 36px;">认证中</span>
							</c:if> <c:if test="${user.userinfo.status==2}">
								<span class="user-checked" style="width: 36px;">已认证</span>
							</c:if> 
								
							 <br />  <br /> <span>诚信：<span class="tip-span">AAA</span></span><span style="margin:0px 5px;"><a style="color: #005ea7;">提升</a></span>
							<%-- <img
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.gif" /> --%> 

						 <span>积分：<span class="tip-span">${user.userinfo.point!=null?user.userinfo.point:0}</span></span><span style="margin-left: 5px;"><a style="color: #005ea7;">查看</a></span><br />

						</td>
						<td>
							<!-- <div
								style="border-left: 1px solid #eee; width: 1px; height: 160px;"></div> -->
						</td>
						<td style="padding: 0px 16px 0px 15px;">
									<h1 style="height: 20px;"></h1>
									<span class="tip-td baseinfo">车辆(<span class="tip-span">
											${empty userStatistics.addcarcount ? '0': userStatistics.addcarcount}
									</span>)</span>
									<span class="tip-td baseinfo">货源(<span class="tip-span">
											${empty userStatistics.pubgodscount ? '0': userStatistics.pubgodscount}
									</span>)</span>
									<span class="tip-td baseinfo">招标(<span class="tip-span">
											${empty userStatistics.pubbidcount ? '0': userStatistics.pubbidcount}
									</span>)</span>
									<h1 style="height: 20px;"></h1>
									<span class="tip-td baseinfo">运单(<span class="tip-span">
											${empty
											userStatistics.tradeordercount ? '0': userStatistics.tradeordercount}
									</span>)</span>

									<span class="tip-td baseinfo">报价(<span class="tip-span">
											${(empty userStatistics.quotecount ? '0': userStatistics.quotecount)}
									</span>)</span>

									<span class="tip-td baseinfo">废标(<span class="tip-span">
											${empty userStatistics.cancelbidcount ? '0': userStatistics.cancelbidcount}
									</span>)</span>
						</td>
						<td><div
								style="border-left: 1px solid #eee; width: 1px; height: 160px;"></div></td>
						<td style="padding: 0px 0px 0px 15px;">
								 <span >余额:</span> 
								 <span >
								 <a class="tip-span">
								 	<c:choose>
										<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
										<c:otherwise>${empty user.userPurse.availablebalance ? '0': user.userPurse.availablebalance }</c:otherwise>
									</c:choose>
								 </a>元</span>
								 <span style="margin:0px 5px;"><a style="color: #005ea7;">提现</a></span>
							<h1 style="height: 0px;"></h1> 
							<span>油气:</span> 
							<span><a class="tip-span">
								<c:choose>
									<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
									<c:otherwise>${empty user.userPurse.petrolbalance ? '0': user.userPurse.petrolbalance}</c:otherwise>
								</c:choose>
							</a>元</span> 
							<span style="margin:0px 5px;"><a style="color: #005ea7;" href="${wlpt}/wlpt/personal/toApplyCard">一卡通</a></span>
									
							<h1 style="height: 0px;"></h1> 
							<span >卓币:</span> 
							<span ><a class="tip-span">
								<c:choose>
									<c:when test="${user.childUser.role.enname=='U_salesman'}">***</c:when>
									<c:otherwise>${empty user.userPurse.availablecoin ? '0': user.userPurse.availablecoin }</c:otherwise>
								</c:choose>
							</a>币&nbsp;</span>
							<span style="margin:0px 5px;"><a style="color: #005ea7;">购买</a></span>
						</td>
					</tr>
				</table>
			</div>
			<div class="psnl_baseInfo">
				<div class="page-title">今日业务动态</div>
				<div style="height: 110px;">
				<c:if test="${user.role.name=='物流企业'}">
					<table class="baseinfo baseinfo-table">
						<tr>
							<td class="zhong_td_width">
								<span >竞标(元):</span> 
								<span ><a class="tip-span">${contracttotalNum==null?0:contracttotalNum}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >待结算(元):</span> 
								<span ><a class="tip-span">${weiContracttotal==null?0:weiContracttotal}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >已结算(元):</span> 
								<span ><a class="tip-span">${yiContracttotal==null?0:yiContracttotal}</a></span>
								
								
							</td>
							<td>
								<div style="border-left: 1px solid #eee; width: 1px; height: 100px;"></div>
							</td>
							<td class="zhong_td_width">
								<span >运单(元):</span> 
								<span ><a class="tip-span">${priceNum==null?0:priceNum}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >待支付(元):</span> 
								<span ><a class="tip-span">${daiPrice==null?0:daiPrice}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >已支付(元):</span> 
								<span ><a class="tip-span">${yiPrice==null?0:yiPrice}</a></span>
							</td>
							<td>
								<div style="border-left: 1px solid #eee; width: 1px; height: 100px;"></div>
							</td>
							<td class="zhong_td_width">
								<span >竞标中(吨):</span> 
								<span ><a class="tip-span">${countNum==null?0:countNum}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >待运输(吨):</span> 
								<span ><a class="tip-span">${daiyun==null?0:daiyun}</a></span>
								
								<h1 style="height: 0px;"></h1> 
								
								<span >已运输(吨):</span> 
								<span ><a class="tip-span">${yiyun==null?0:yiyun}</a></span>
							</td>
							<td class="zhong_td_width" style="text-align: center;"><span style="margin:0px 5px;"><a style="color: #005ea7;font-size: 16px;" href="${wlpt}/wlpt/consume/toConsumeRecord">查看全部账单</a></span></td>
						</tr>
					</table>
				</c:if>
				<c:if test="${user.role.name!='物流企业'}">
					<table class="baseinfo baseinfo-table">
						<tr>
							<td class="zhong_td_width" style="text-align:center;">
								<br/>
								<span style="font-size:19px;"  class="ft14">运单(元)</span>
								<h1 style="height: 0px;"></h1> 
								<span ><a class="tip-span" style="font-size:17px;">${priceNum==null?0:priceNum}</a></span>
							</td>
							<td>
								<div style="border-left: 1px solid #eee; width: 1px; height: 100px;"></div>
							</td>
							<td class="zhong_td_width" style="text-align:center;">
								<br/>
								<span style="font-size:19px;"  class="ft14">待支付(元)</span>
								<h1 style="height: 0px;"></h1> 
								<span ><a class="tip-span" style="font-size:17px;">${daiPrice==null?0:daiPrice}</a></span>
							</td>
							<td>
								<div style="border-left: 1px solid #eee; width: 1px; height: 100px;"></div>
							</td>
							<td class="zhong_td_width" style="text-align:center;">
								<br/>
								<span style="font-size:19px;"  class="ft14">已支付(元)</span>
								<h1 style="height: 0px;"></h1> 
								<span ><a class="tip-span" style="font-size:17px;">${yiPrice==null?0:yiPrice}</a></span>
							</td>
							<td class="zhong_td_width" style="text-align: center;"><span style="margin:0px 5px;"><a style="color: #005ea7;font-size: 16px;" href="${wlpt}/wlpt/consume/toConsumeRecord">查看全部账单</a></span></td>
						</tr>
					</table>
				</c:if>
				</div>
				<div class="personal_bottom" style="display: none;">
					<span style="color: #666;font-weight: bold;">累计收入(元):</span> 
					<span style="margin-right: 40px;"><a class="tip-span">500</a></span>
					<span style="color: #666;font-weight: bold;">累计支出(元):</span> 
					<span ><a class="tip-span" style="color: red;">500</a></span>
				</div>
			</div>
			<div class="psnl_baseInfo" style="padding-bottom: 10px;">
				<div class="baseInfo_tab">
					<ul class="baseInfo_tab_ul">
						<li class="baseinfo_tab_select">最新运单</li>
						<c:if test="${user.role.name=='物流企业'}">
							<li>最新招标</li>
						</c:if>
						<c:if test="${user.role.name=='物流企业'}">
							<li>最新竞标</li>
						</c:if>
					</ul>
				</div>
				<div id="neworder">
					<table class="baseinfo baseinfo-table" style="border-collapse:collapse">
						<tr style="background-color: rgb(241,241,241);">
							<td class="xia_td_width">货源信息</td>
							<td class="xia_td_width">车辆信息</td>
							<td class="xia_td_width">运费</td>
							<td class="xia_td_width">交易状态</td>
							<td class="xia_td_width">操作</td>
						</tr>
						<c:forEach items="${orderinfolist}" var="orderinfo"
               				varStatus="status_list" end="3">
						
						<tr><td colspan="5" style="height: 10px"></td></tr>
						<tr style="border: 1px solid rgb(225, 225, 225); ">
							<td  class="xia_td_width">
								<p>${orderinfo.quoteinfo.goods.shipAddress.city}${fn:substring(orderinfo.quoteinfo.goods.shipAddress.district, 0, 3)} 
				                    <span ></span>
				                    ${orderinfo.quoteinfo.goods.consignAddress.city}${fn:substring(orderinfo.quoteinfo.goods.consignAddress.district, 0, 3)} 
				                </p>
				                <p>${orderinfo.quoteinfo.goods.goodsname}</p>
				                <p>
				                	<span>
				                	${orderinfo.quoteinfo.actload}
				                	</span>
			                	</p>
							</td>
							<td class="xia_td_width">
								<p>${orderinfo.quoteinfo.car.carnumber}</p>
								<p>${orderinfo.quoteinfo.driver.loginName}&nbsp;${orderinfo.quoteinfo.driver.phone}</p>
							</td>
							<td class="xia_td_width">
								￥${orderinfo.totalcost}
							</td>
							<td class="xia_td_width">
								${orderinfo.statusStr}
							</td>
							<td class="xia_td_width">
								<p>
				                    <a href="${wlpt}/wlpt/trade/trade_detail?urltype=trade_shadow&id=${orderinfo.id}" style="color: #005ea7;">运单详情</a>
				                </p>
							</td>
						</tr>
						<tr>
							<td colspan="5" style="background-color: rgb(241,241,241);text-align: right;"><span><fmt:formatDate value="${orderinfo.createDate}"
                                pattern="yyyy-MM-dd"/></span><span style="margin:0px 30px;">运单：${orderinfo.orderno}</span></td>
						</tr>
						</c:forEach>
					</table>
				</div>
				<div id="newbid" style="display:none;">
					<table class="baseinfo baseinfo-table" style="border-collapse:collapse">
						<tr style="background-color: rgb(241,241,241);">
							<td class="xia_td_width">招标信息</td>
							<td class="xia_td_width">拦标价格</td>
							<td class="xia_td_width">截止时间</td>
							<td class="xia_td_width">招标状态</td>
							<td class="xia_td_width">操作</td>
						</tr>
						<c:forEach items="${bidlist}" var="bidinfo">
						
						<tr><td colspan="5" style="height: 10px"></td></tr>
						<tr style="border: 1px solid rgb(225, 225, 225); ">
							<td  class="xia_td_width">
								<p>${bidinfo.goods.shipAddress.city}${fn:substring(bidinfo.goods.shipAddress.district, 0, 3)} 
				                    <span ></span>
				                    ${bidinfo.goods.consignAddress.city}${fn:substring(bidinfo.goods.consignAddress.district, 0, 3)} 
				                </p>
				                <p>${bidinfo.goods.goodsname}</p>
				                <p>
				                	<span>
				                	${bidinfo.goods.freightvolume} ${bidinfo.goods.freightunit}
				                	</span>
			                	</p>
							</td>
							<td class="xia_td_width">
								${bidinfo.expectedprice}元/${bidinfo.goods.freightunit}
							</td>
							<td class="xia_td_width">
								<fmt:formatDate value="${bidinfo.endtime}" pattern="yyyy-MM-dd"/> 
							</td>
							<td class="xia_td_width">
								<strong class="red_num">${bidinfo.bidstatus=='发布'?'竞标中':bidinfo.bidstatus}</strong>
							</td>
							<td class="xia_td_width">
								<p>
				                    <a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId=${bidinfo.id}" style="color: #005ea7;">招标详情</a>
				                </p>
							</td>
						</tr>
						<tr>
							<td colspan="5" style="background-color: rgb(241,241,241);text-align: right;"><span><fmt:formatDate value="${bidinfo.publishtime}" pattern="yyyy-MM-dd"/></span><span style="margin:0px 30px;">招标文号：${bidinfo.bidcode}</span></td>
						</tr>
						</c:forEach>
					</table>
				</div>
				<div id="newbidding" style="display:none;">
					<table class="baseinfo baseinfo-table" style="border-collapse:collapse">
						<tr style="background-color: rgb(241,241,241);">
							<td class="xia_td_width">竞标信息</td>
							<td class="xia_td_width">竞标价格</td>
							<td class="xia_td_width">截止时间</td>
							<td class="xia_td_width">竞标状态</td>
							<td class="xia_td_width">操作</td>
						</tr>
						<c:forEach items="${biddinglist}" var="biddinginfo">
						
						<tr><td colspan="5" style="height: 10px"></td></tr>
						<tr style="border: 1px solid rgb(225, 225, 225); ">
							<td  class="xia_td_width">
								<p>${biddinginfo.bidinfo.goods.shipAddress.city}${fn:substring(biddinginfo.bidinfo.goods.shipAddress.district, 0, 3)} 
				                    <span ></span>
				                    ${biddinginfo.bidinfo.goods.consignAddress.city}${fn:substring(biddinginfo.bidinfo.goods.consignAddress.district, 0, 3)} 
				                </p>
				                <p>${biddinginfo.bidinfo.goods.goodsname}</p>
				                <p>
				                	<span>
				                	${biddinginfo.bidinfo.goods.freightvolume} ${biddinginfo.bidinfo.goods.freightunit}
				                	</span>
			                	</p>
							</td>
							<td class="xia_td_width">
								${biddinginfo.biddingprice}元/${biddinginfo.bidinfo.goods.freightunit}
							</td>
							<td class="xia_td_width">
								<fmt:formatDate value="${biddinginfo.bidinfo.endtime}" pattern="yyyy-MM-dd"/> 
							</td>
							<td class="xia_td_width">
								<strong class="red_num">${biddinginfo.biddingstatus}</strong>
							</td>
							<td class="xia_td_width">
								<p>
				                    <a href="${wlpt}/wlpt/bid/bidDetails?bidinfoId=${biddinginfo.bidinfo.id}&biddingprice=${biddinginfo.biddingprice}" style="color: #005ea7;">竞标详情</a>
				                </p>
							</td>
						</tr>
						<tr>
							<td colspan="5" style="background-color: rgb(241,241,241);text-align: right;"><span><fmt:formatDate value="${biddinginfo.createDate}"
                                pattern="yyyy-MM-dd"/></span><span style="margin:0px 30px;">招标文号：${biddinginfo.bidinfo.bidcode}</span></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		$(".baseInfo_tab_ul li").click(function(){
			$(this).addClass("baseinfo_tab_select").siblings().removeClass("baseinfo_tab_select");
			var litext = $(this).text();
			if(litext=="最新竞标"){
				$("#newbid").hide();
				$("#neworder").hide();
				$("#newbidding").show();
			}else if(litext=="最新招标"){
				$("#neworder").hide();
				$("#newbidding").hide();
				$("#newbid").show();
			}else{
				$("#newbid").hide();
				$("#newbidding").hide();
				$("#neworder").show();
			}
		});
	});
</script>
</html>