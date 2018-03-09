<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="${ctxStatic }/modules/wlpt/front/css/analysis/global.css" />
<link href="${ctxStatic }/modules/wlpt/front/css/persional_index.css"
	type="text/css" rel="stylesheet" />
<link href="${ctxStatic }/modules/wlpt/front/css/wlpt_index.css"
	type="text/css" rel="stylesheet" />

<style type="text/css">
#carTypediv, #monthdiv {
	float: left;
	height: 450px;
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
	cursor: pointer;
}

.altrow {
	text-align: center;
	font-size: 14px;
}

.tr_backcolor {
	background-color: rgba(245, 245, 245, 0.27);
}

.record_titlehover {
	color: orange;
}

.record_titleclick {
	color: orange;
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

.searchinput {
	height: 20px;
	margin: 15px 0;
}
</style>
</head>
<body>

	<div style="width: 100%; height: 100%;" id="financialdiv">
		<div style="width: 100%; height: 50px;">
			<div class="page-title"
				style="float: left; margin: 20px 20px 0px 20px;">财务报表</div>
			<div style="float: right; width: 150px; margin: 20px; color: #999;">
				<a title="点击隐藏数据列表"
					style="color: rgb(51, 187, 255); font-size: 15px;" id="hiderecord"
					onclick="hiderecord()">隐藏财务报表</a> <a
					style="color: rgb(51, 187, 255); font-size: 15px; display: none;"
					id="showrecord" onclick="showrecord()">展示财务报表</a>
			</div>
		</div>
		<div
			style="width: 100%; height: 50px; line-height: 50px; border-bottom: 1px solid #EBEBEB; border-top: 1px solid #EBEBEB; clear: both;">
			<div
				style="width: 22%; float: left; text-align: center; font-size: 14px;">
				<input id="searchinfo" type="text" value="${searchinfo}"
					class="searchinput" placeholder="用户名/手机号" />
			</div>
			<div
				style="width: 30%; float: left; text-align: center; font-size: 14px;">
				<input id="starttimes" type="text"
					style="width: 85px; margin: 0; margin-right: 5px; height: 20px;"
					placeholder="开始时间" readonly="readonly"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					onblur="validates(this)" />-<input id="endtimes" type="text"
					style="margin: 0; margin-left: 5px; width: 85px; height: 20px;"
					placeholder="结束时间" readonly="readonly"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
					onblur="validates(this)" />
			</div>
			<div style="width: 3%; float: left; height: 50px;">
				<img style="width: 20px; height: 20px; padding: 15px 0;" class=""
					alt=""
					src="${ctxStatic}/images/wlptfront/persionlogo/persionbtn.png" />
			</div>
			<div class="record_title" onclick="searchRecordMain(this)" id="0">全部</div>
			<div class="record_title" onclick="searchRecordMain(this)" id="1">收入</div>
			<div class="record_title" onclick="searchRecordMain(this)" id="2">支出</div>
			<input type="hidden" id="searchtype" value="0" />
		</div>
		<div class="ol-content-div" style="clear: both;">
			<table cellspacing="0" id="recordtableList"
				style="width: 100%; line-height: 35px; border-bottom: 1px solid #EBEBEB;">
				<colgroup>
					<col width="120">
					<col width="120">
					<col width="160">
					<col width="180">
					<col width="80">
				</colgroup>
				<thead>
					<tr height="50" style="color: #555; font-size: 15px;">
						<th style="border-bottom: 1px solid #EBEBEB;">时间</th>
						<th style="border-bottom: 1px solid #EBEBEB;">交易类型</th>
						<th style="border-bottom: 1px solid #EBEBEB;">发起用户</th>
						<th style="border-bottom: 1px solid #EBEBEB;">受理用户</th>
						<th style="border-bottom: 1px solid #EBEBEB;">金额</th>
						<th style="border-bottom: 1px solid #EBEBEB;">&nbsp;</th>
					</tr>
				</thead>
				<tbody id="addtr" style="">
					<!-- <tr class="altrow">
                <td style="text-align:center;">2016.06.16</td>
                <td style="text-align:center;">运输交易</td>
                <td style="text-align:center;">邯钢巨恒物流</td>
                <td style="text-align:center;">邯钢众翔财务</td>
                <td style="text-align:center;"><span style="color:orange;">+</span>&nbsp;3545元</td>
                <td style="text-align:center;"><a target="_blank"
                    href="{{detail}}"
                    style="color:rgb(51, 187, 255);font-size:16px;">详情</a></td>
            </tr> -->
				</tbody>
			</table>
			<div id='notdata' style="text-align:center;">对不起！暂时没有查询到您的交易数据哦...</div>
			<div id='loading'
				style='width: 100%; vertical-align: middle; text-align: center; height: 65px; display: none;'>
				<div>
					<img src='${ctxStatic}/images/loading-30x30.gif'>
				</div>
				<div style=''>正在努力加载中，请稍等!</div>
			</div>
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
		<div
			style="width: 100%; height: 40px; line-height: 40px; color: rgb(128, 128, 128); clear: both;">
			<div
				style="float: left; width: 12%; text-align: center; cursor: pointer;"
				title="点击下载" id="twolastmonth" onclick="blancetoExcel(this)">
				<span>6</span>月对账单
			</div>
			<div
				style="float: left; width: 12%; text-align: center; cursor: pointer;"
				title="点击下载" id="lastmonth" onclick="blancetoExcel(this)">
				<span>7</span>月对账单
			</div>
			<div
				style="float: left; width: 12%; text-align: center; cursor: pointer;"
				title="点击下载" id="thismonth" onclick="blancetoExcel(this)">
				<span>8</span>月对账单
			</div>
			<div
				style="float: left; width: 18%; text-align: center; cursor: pointer;"
				title="点击下载" onclick="blancetoExcel(this)">下载总对账单</div>
			<div style="float: left; width: 39%; text-align: right;">查看所有交易记录</div>
			<div style="float: left; width: 5%; cursor: pointer;"
				title="点击下载所有交易记录" onclick="exportRecord()">
				<img style="width: 27px; height: 28px; padding: 6px;" class=""
					alt=""
					src="${ctxStatic}/images/wlptfront/persionlogo/persiondowload.png" />
			</div>
		</div>
	</div>

	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script
		src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"
		type="text/javascript"></script>
	<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"
		type="text/javascript"></script>

	<script type="text/javascript">
		$(function() {

			$(document).ready(
					function() {
						$(".record_title").hover(function() {
							$(this).addClass("record_titlehover");
						}, function() {
							$(this).removeClass("record_titlehover");
						});
						$(".record_title").click(
								function() {
									$(this).addClass("record_titleclick")
											.siblings().removeClass(
													"record_titleclick");
								});
					});

			var searchTypes = $("#searchtype").val();//记住筛选点击

			var nowdate = new Date();//本月日期
			var nowMonth = nowdate.getMonth() + 1;
			var lastMonthDate = new Date(); //上月日期 
			lastMonthDate.setMonth(lastMonthDate.getMonth() - 1);
			var lastMonth = (lastMonthDate.getMonth() + 1);
			var lastlMonthDate = new Date(); //上上月日期 
			lastlMonthDate.setMonth(lastlMonthDate.getMonth() - 2);
			var lastlMonth = (lastlMonthDate.getMonth() + 1);
			$("#twolastmonth span").text(lastlMonth);
			$("#lastmonth span").text(lastMonth);
			$("#thismonth span").text(nowMonth);

			window.blancetoExcel = function(num) {
				var numpar = $(num).children("span").text();
				var param = $(num).attr("id");
				window.location.href = '${wlpt}/wlpt/personal/exportFinance?monthParameter='
						+ param;
			};
			//获取列表数据
			function addData(curPageNo, searchtype) {
				$("#notdata").hide();
				$("#addtr").children().remove();
				$("#loading").show();
				jsons = {
					searchinfo : $("#searchinfo").val(),
					beginCreateDate : $("#starttimes").val(),
					endCreateDate : $("#endtimes").val(),
					pageNo : curPageNo,
					pageSize : 10,
					searchType : searchtype
				};
				$
						.ajax({
							url : "${wlpt}/wlpt/consume/personalGetRecodeList",
							data : jsons,
							dataType : 'json',
							cache : false,
							type : "POST",
							success : function(data) {
								$("#pageCount").html(
										Math.ceil(data.value.count
												/ data.value.pageSize));
								$("#curPage").html(curPageNo);
								$("#curPageGoto").val(curPageNo);
								var html = "";

								if (data.value.list!=null&&data.value.list!=undefined&&data.value.list.length > 0) {
									for (var i = 0; i < data.value.list.length; i++) {

										var backcolor = "<tr class='altrow'>";
										if (i % 2 == 0) {
											backcolor = "<tr class='altrow tr_backcolor'>";
										}
										var accountname = data.value.list[i].account.loginName != null ? data.value.list[i].account.loginName
												: (data.value.list[i].account.name != null ? data.value.list[i].account.name
														: data.value.list[i].account.phone);
										var targetname = data.value.list[i].target.loginName != null ? data.value.list[i].target.loginName
												: (data.value.list[i].target.name != null ? data.value.list[i].target.name
														: data.value.list[i].target.phone);
										var beforemony = data.value.list[i].beforemony;
										var aftermony = data.value.list[i].aftermony;
										var am = "<span style='color:orange;font-weight: bold;'>+</span>";
										if (beforemony > aftermony) {
											am = "<span style='color:red;font-weight: bold;'>-</span>";
										}
										var ordercode = "<td style=''>" + "-／-"
												+ "</td>";
										if (data.value.list[i].orderinfo != null
												&& data.value.list[i].orderinfo != "") {
											ordercode = "<td><a target='content' title='点击查看运单详情' style='color:rgb(51, 187, 255);font-size:14px;' href='${wlpt}/wlpt/trade/trade_detail?id="
													+ data.value.list[i].orderinfo.id
													+ "'>" + "详情" + "</a></td>";
										}
										html += backcolor
												+ "<td >"
												+ data.value.list[i].createDateFormat
												+ "</td><td>"
												+ data.value.list[i].consumetype
												+ "</td><td>"
												+ accountname
												+ "</td><td>"
												+ targetname
												+ "</td><td>"
												+ am
												+ (data.value.list[i].consumemony != null ? data.value.list[i].consumemony
														: "0") + "</td>"
												+ ordercode + "</tr>";
									}
								} else {
									$("#notdata").css({
										"display" : "block"
									});
								}
								$("#addtr").children().remove();
								$("#loading").hide();
								$("#addtr").append(html);
							}
						});
			}

			addData(1, null);

			//报表导出
			window.exportRecord = function() {
				window.location.href = "${wlpt}/wlpt/consume/personalExport";
			};

			//展示与隐藏
			window.hiderecord = function() {
				$("#financial_info", window.parent.document).hide();
				$("#mainFrame", window.parent.parent.document)
						.height(
								$("#mainFrame", window.parent.parent.document)
										.height() - 650);
				$("#financialrval", window.parent.document).val(0);
			};
			//财务状态点击筛选
			window.searchRecordMain = function(rstatus) {
				var restatus = $(rstatus).attr("id");
				if (restatus == "0") {
					restatus = null;
				}
				addData(1, restatus);
				$("#searchtype").val(restatus);
				searchTypes = restatus;
			};
			//校验财务开始日期不能大于结束日期
			window.validates = function(obj) {
				var starttimes = $("#starttimes").val();
				var endtimes = $("#endtimes").val();
				if (starttimes != '' && endtimes != ''
						&& starttimes >= endtimes) {
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
					addData(1, searchTypes);
				}
			});
			//上一页查询
			$("#previewPage").click(function() {
				var curPageNo = $("#curPage").html();
				if (curPageNo > 1) {
					curPageNo--;
				}
				$("#curPage").html(curPageNo);
				addData(curPageNo, searchTypes);
			});
			//下一页查询
			$("#nextPage").click(function() {
				var curPageNo = $("#curPage").html();
				var pageCount = $("#pageCount").html();
				if (parseInt(curPageNo) < parseInt(pageCount)) {
					curPageNo++;
					$("#curPage").html(curPageNo);
					addData(curPageNo, searchTypes);
				}
			});
			//尾页查询
			$("#lastPage").click(function() {
				var curPageNo = $("#curPage").html();
				var pageCount = $("#pageCount").html();
				if (curPageNo != pageCount) {
					$("#curPage").html(pageCount);
					addData(pageCount, searchTypes);
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
										addData(gotoPage, searchTypes);
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

