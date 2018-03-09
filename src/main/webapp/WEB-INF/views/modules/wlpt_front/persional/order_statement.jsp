<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
 <meta charset="utf-8">
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
 <meta name="viewport" content="width=device-width, initial-scale=1"> 
 
<link rel="stylesheet"
	href="${ctxStatic }/modules/wlpt/front/css/analysis/global.css" />
<link
	href="${ctxStatic }/modules/wlpt/front/css/persional_index.css"
	type="text/css" rel="stylesheet" />
<link
	href="${ctxStatic }/modules/wlpt/front/css/wlpt_index.css"
	type="text/css" rel="stylesheet" />
<style type="text/css">
#carTypediv,#monthdiv {
	float: left;
	height: 450px;
}

.table-bordered th,.table-bordered td {
	/* border-left: 1px solid #ddd; */
	
}

.table th,.table td {
	border-top: 1px solid #ddd;
	line-height: 20px;
	padding: 8px;
	text-align: center;
	vertical-align: top;
}

.table td {
	border-top: 1px dashed #ddd;
}

.table thead:first-child tr th:last-child,.table tr td:last-child {
	/*  border-right: 1px solid #ddd; */
	
}

.adbt a {
	color: #FFFFFF
}

.ol-condition-ul li {
	float: left;
	line-height: 30px;
	color: #666;
	font-size: 16px;
}

.ol-content-div {
	width: 832px;
	border: 1px solid #f2f2f2;
	border-top: 1px solid #EBEBEB;
	background-color: #FFF;
}

.titleborder {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
}

.ordertable_title {
	width: 7%;
	float: left;
	color: rgb(51, 187, 255);
	font-size: 16px;
	cursor: pointer;
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
	font-size:14px;
}

.ordertitlediv {
	background-color: #EBEBEB;
}

.ordertitledivclick {
	background-color: #EBEBEB;
}

.pagediv {
	width: 100%;
	height: 50px;
	text-align: center;
}

.pagediv table {
	float: right;
	margin-right: 70px;
}

.pagediv table tr td {
	height: 30px;
	line-height: 30px;
	padding: 10px;
	text-align: center;
}

.pagediv_size {
	color: #999;
	font-size: 13px;
	font-family: "微软雅黑";
}

</style>
</head>
<body>

	<div style="width: 100%;height: 100%;" id="orderdiv">
		<div style="width:100%;height:50px;">
			<div class="page-title" style="float:left;margin:20px 20px 0px 20px;">运单报表
			</div>
			<div style="float:right;width:150px;margin: 20px;color:#999;">
				<a title="点击隐藏数据列表" style="color:rgb(51, 187, 255);font-size:15px;"
					id="hideorder" onclick="hideorder()">隐藏运单报表</a> <a
					style="color:rgb(51, 187, 255);font-size:15px;display:none;"
					id="showorder" onclick="showorder()">展示运单报表</a>
			</div>
		</div>
		<div
			style="width:100%;height:50px;line-height:50px;border-bottom:1px solid #EBEBEB;border-top:1px solid #EBEBEB;text-align:center;clear:both;  ">

			<div class="ordertable_title" onclick="searchMain()" id="allorder">全部</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="0">待确认</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="1">待提货</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="3">待回单</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="4">待支付</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="5">已完成</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="2">已取消</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="6">争议中</div>
			<div class="ordertable_border">&nbsp;</div>
			<div class="ordertable_title" onclick="searchMain(this)" id="7">争议完</div>
			<input type="hidden" id="searchstatus" value="" />
			<div style="width:28%;float:left;font-size:14px;">
				<div>
					<input id="starttime" type="text"
						style="width:85px;margin:0;margin-right:5px;height:20px;"
						placeholder="开始时间" readonly="readonly"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
						onblur="validate(this)" />-<input id="endtime" type="text"
						style="margin:0;margin-left:5px;width:85px;height:20px;"
						placeholder="结束时间" readonly="readonly"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
						onblur="validate(this)" />
				</div>
			</div>
		</div>
		<div class="ol-content-div" id="ordertableList" style="clear:both;">
			<div id='notdata' style="display:none;text-align:center;">对不起！暂时没有查询到您的运单数据哦...</div>
			<div id='loading'
				style='width:100%;vertical-align: middle;text-align:center;height:55px;display:none;'>
				<div>
					<img src='${ctxStatic}/images/loading-30x30.gif'>
				</div>
				<div style=''>正在努力加载中，请稍等!</div>
			</div>
			<table cellspacing="0"
				style="width:100%;line-height:35px;border-bottom: 1px solid #EBEBEB;"
				id="backcolortable">
				<colgroup>
					<col width="100">
					<col width="400">
					<col width="100">
					<col width="100">
					<col width="80">
				</colgroup>
				<tbody id="order-templet" style="display:none;">

					<!-- <tr class="altrow">
						<td style="text-align:center;">{{createDate}}</td>
						<td style="text-align:center;">车牌号:{{quoteinfo.car.carnumber}};运费{{totalcost}}元
							;{{quoteinfo.oddloadweight}}{{quoteinfo.goods.freightunit}}{{quoteinfo.goods.goodsname}},从{{quoteinfo.goods.shipAddress.city}}到{{quoteinfo.goods.consignAddress.city}}
						</td>
						<td style="text-align:center;"><span
							style="color:orange;font-weight: bold;">+</span>&nbsp;{{totalcost}}</td>
						<td style="text-align:center;">{{orderstatus}}</td>
						<td style="text-align:center;"><a target="_blank"
							title="点击查看运单详情" href="{{detail}}"
							style="color:rgb(51, 187, 255);font-size:14px;">详情</a></td>
					</tr> -->
				</tbody>
			</table>
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
							style="color:#ff7300;width:20px;border-color:#ededed;"><b
							id="curPage" style="color: #ff7300;display:none;"></b>页
							<button class="regbt" id="gotoPage"
								style="width: 50px;height:24px;background-color:white;color:#404040;border-color:#ededed;">
								<span style="">确&nbsp;定</span>
							</button>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div
			style="width:100%;height:40px;line-height:40px;color:rgb(128,128,128);">

			<div style="float:left;width:95%;text-align:right;">查看所有交易记录</div>
			<div style="float:left;width:5%;cursor: pointer;"
				title="点击下载所有交易记录excel" onclick="exportOrder()">
				<img style="width:27px;height:28px;padding:6px;" class="" alt=""
					src="${ctxStatic}/images/wlptfront/persionlogo/persiondowload.png" />
			</div>
		</div>
	</div>
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js" type="text/javascript" ></script>
	<script type="text/javascript">
		$(function() {

			$(document).ready(
					function() {
						$(".ordertable_title").hover(function() {
							$(this).addClass("ordertitlediv");
						}, function() {
							$(this).removeClass("ordertitlediv");
						});
						$(".ordertable_title").click(
								function() {
									$(this).addClass("ordertitledivclick")
											.siblings().removeClass(
													"ordertitledivclick");
								});
					});

			var searchStatus = $("#searchstatus").val();//记住筛选点击

			var SIGLE_PAGE_COUNT = 10;
			var searchConditions = {
				DATATYPE : 0
			};
			$("#order-list-container").css("height", "900px");
			search(1, null);
			search(1, null);
			function search(currentPage, status) {
				$("#loading").show();
				searchConditions.pageNo = currentPage;
				searchConditions.pageSize = SIGLE_PAGE_COUNT;
				searchConditions.beginCreateDate = $("#starttime").val();
				searchConditions.endCreateDate = $("#endtime").val();
				searchConditions.orderstatus = status;

				$
						.ajax({
							url : "${wlpt}/wlpt/trade/getTradeList",
							data : searchConditions,
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list!=null&&data.value.list!=undefined) {
									var html = "";
									for ( var i = 0; i < data.value.list.length; i++) {
										$(".carinfo").css("display", "none");
										html += fillOneData(data.value.list[i]);
									}
									if (data.value.list.length <= 0) {
										$("#notdata").css({
											"display" : "block",
											"margin-bottom" : "10px"
										});
									} else {
										$("#notdata").css({
											"display" : "none",
											"margin-bottom" : "10px"
										});
									}
									$("#order-templet").nextAll().remove();
									$("#order-templet").after(html);
									$("#loading").hide();
									$("#pageCount").html(
											Math.ceil(data.value.count   
													/ data.value.pageSize));
									$("#curPage").html(searchConditions.pageNo);
									$("#curPageGoto").val(searchConditions.pageNo);
								}else{
									$("#notdata").css({
										"display" : "block",
										"margin-bottom" : "10px"
									});
								}
								$("#loading").hide();
							}
						});
			}
			function fillOneData(data) {
				if (parseInt(data.orderstatus) == 0) {
					data.orderstatus =  "待确认";
				} else if (parseInt(data.orderstatus) == 1) {
					data.orderstatus = "待提货";
				} else if (parseInt(data.orderstatus) == 2) {
					data.orderstatus ="已取消";
				} else if (parseInt(data.orderstatus) == 5) {
					data.orderstatus = "已完成";
				} else if (parseInt(data.orderstatus) == 3) {
					data.orderstatus = "待回单";
				} else if (parseInt(data.orderstatus) == 4||parseInt(data.orderstatus) == 7) {
					data.orderstatus ="待支付";
				} else if (parseInt(data.orderstatus) == 6) {
					data.orderstatus ="争议中";
				} else {
					data.orderstatus = "其他";
				}
				if(data.createDateFormat==undefined||data.createDateFormat==null){
					data.createDateFormat="";
				}
				var html = '<tr class="altrow">'
				+'<td style="text-align:center;">'+data.createDateFormat+'</td>'
				+'<td style="text-align:center;">'+data.quoteinfo.car.carnumber+';运费'+data.totalcost+'元'
				+	';'+data.quoteinfo.oddloadweight +data.quoteinfo.goods.freightunit+data.quoteinfo.goods.goodsname+',从'+data.quoteinfo.goods.shipAddress.city+'到'+data.quoteinfo.goods.consignAddress.city
				+'</td>'
				+'<td style="text-align:center;"><span'
				+'	style="color:orange;font-weight: bold;">+</span>&nbsp;'+data.totalcost+'</td>'
				+'<td style="text-align:center;">'+data.orderstatus+'</td>'
				+'<td style="text-align:center;"><a target="content"'
				+'title="点击查看运单详情" href="${wlpt}/wlpt/trade/trade_detail?id='+data.id+'"'
				+'style="color:rgb(51, 187, 255);font-size:14px;">详情</a></td>'
			    +'</tr>';
				return html;
			}

			//报表导出
			window.exportOrder = function() {
				window.location.href = "${wlpt}/wlpt/trade/export";
			};
			//展示与隐藏
			window.hideorder = function() {
				$("#order_info", window.parent.document).hide();
				$("#mainFrame", window.parent.parent.document)
						.height(
								$("#mainFrame", window.parent.parent.document)
										.height() - 580);
				$("#orderval", window.parent.document).val(0);
			};

			//运单状态点击筛选
			window.searchMain = function(status) {
				var numstatus = $(status).attr("id");
				if (numstatus == "allorder") {
					numstatus = null;
				}
				search(1, numstatus);
				$("#searchstatus").val(numstatus);
				searchStatus = numstatus;
			};
			//校验运单开始日期不能大于结束日期
			window.validate = function(obj) {
				var starttime = $("#starttime").val();
				var endtime = $("#endtime").val();
				if (starttime != '' && endtime != '' && starttime >= endtime) {
					$(obj).tips({
						side : 3,
						msg : '开始时间不能大于结束时间',
						bg : '#FF7300',
						time : 3
					});
					$(obj).val('');
				}
			};

			//首页查询
			$("#firstPage").click(function() {
				var curPageNo = $("#curPage").html();
				if (curPageNo != 1) {
					$("#curPage").html(1);
					search(1, searchStatus);
				}
			});
			//上一页查询
			$("#previewPage").click(function() {
				var curPageNo = $("#curPage").html();
				if (curPageNo > 1) {
					curPageNo--;
				}
				$("#curPage").html(curPageNo);
				search(curPageNo, searchStatus);
			});
			//下一页查询
			$("#nextPage").click(function() {
				var curPageNo = $("#curPage").html();
				var pageCount = $("#pageCount").html();
				if (parseInt(curPageNo) < parseInt(pageCount)) {
					curPageNo++;
					$("#curPage").html(curPageNo);
					search(curPageNo, searchStatus);
				}
			});
			//尾页查询
			$("#lastPage").click(function() {
				var curPageNo = $("#curPage").html();
				var pageCount = $("#pageCount").html();
				if (curPageNo != pageCount) {
					$("#curPage").html(pageCount);
					search(pageCount, searchStatus);
				}
			});

			$("#gotoPage")
					.click(
							function() {
								var gotoPage = $("#curPageGoto").val();
								gotoPage = (gotoPage != null && gotoPage != "") ? gotoPage
										: "1";
								var thePageCount = $("#pageCount").html();
								if (isNums(curPageGoto)) {

									if (parseInt(gotoPage) > parseInt(thePageCount)) {
										$(curPageGoto).tips({
											side : 3,
											msg : '输入页码不能超过总页码',
											bg : '#FF7300',
											time : 3
										});
										$(curPageGoto).val('');
									} else {
										search(gotoPage, searchStatus);
									}
								}
							});

			//校验页码数字
			function isNums(obj) {
				var n = $(obj).val();
				if (n != ''
						&& (isNaN(n) || parseInt(n) == 0 || parseInt(n) < 0)) {
					$(obj).tips({
						side : 3,
						msg : '请输入正数',
						bg : '#FF7300',
						time : 3
					});
					$(obj).val('');
					return false;
				}
				return true;
			}
		});
	</script>

</body>
</html>

