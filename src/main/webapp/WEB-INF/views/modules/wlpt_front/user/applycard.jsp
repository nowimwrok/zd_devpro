<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>申请一卡通</title>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<%-- <link rel="stylesheet" type="text/css"
	href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
<link rel="stylesheet" type="text/css"
	href="${ctxStatic}/modules/wlpt/front/css/foot.css"> --%>
<link rel="stylesheet" type="text/css"
	href="${ctxStatic}/modules/wlpt/front/css/shop_new.css">

<style>
</style>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>


</head>
<body>

	<!--申请一卡通--------------主要内容-->
	<div class="shop_content">
		<h4>申请一卡通</h4>
		<!--基本信息table-->
		<table class="tab_one" id="companyTable"
			style="border-bottom: 1px dashed #ccc; margin-bottom: 30px; display: none">
			<tr>
				<td class="tab_left">企业名称：</td>
				<td class="tab_right">${user.userCompany.companyname}</td>
				<td rowspan="6" style="width: 40%;"><c:if
						test="${user.userinfo.status == 2 }">
						<img src="${ctxStatic}/images/wlptfront/shop_img/new_03.gif"
							width="143px">
					</c:if></td>
			</tr>
			<tr>
				<td class="tab_left">营业执照号：</td>
				<td class="tab_right">${user.userCompany.businesslicencenum}</td>
			</tr>
			<tr>
				<td class="tab_left">公司联系人：</td>
				<td class="tab_right">${user.userCompany.legalperson}</td>
			</tr>
			
			<tr>
				<td class="tab_left">手机号码：</td>
				<td class="tab_right">${user.phone}</td>
			</tr>
			<tr>
				<td class="tab_left">公司所在地：</td>
				<td class="tab_right">${user.userCompany.provinceCityDistrict}${user.userCompany.companyaddress}</td>
			</tr>
		</table>

		<table class="tab_one" id="otherRoleTable"
			style="border-bottom: 1px dashed #ccc; margin-bottom: 30px; border-collapse: inherit;">
			<tr>
				<td class="tab_left">姓名：</td>
				<td class="tab_right">${user.name}</td>
				<td rowspan="6" style="width: 40%;"><c:if
						test="${user.userinfo.status == 2 }">
						<img src="${ctxStatic}/images/wlptfront/shop_img/new_03.gif"
							width="143px">
					</c:if></td>
			</tr>
			<tr>
				<td class="tab_left">手机号码：</td>
				<td class="tab_right">${user.phone}</td>
			</tr>
			<%-- <tr>
				<td class="tab_left">身份证号码：</td>
				<td class="tab_right">${user.userinfo.identitycard}</td>
			</tr> --%>
			<tr>
				<td class="tab_left">联系地址：</td>
				<td class="tab_right">${user.userinfo.contactaddress}</td>
			</tr>
		</table>
		<!--End---基本信息table-->
		<form:form id="inputForm" modelAttribute="address" method="post"
			class="form-horizontal">
			<!--table需要填写的信息-->
			<table class="tab_two" style="margin-bottom: 30px;">
				<c:if test="${not empty userMetroCard.cardid }">
					<tr>
						<td class="tab_left">一卡通卡号：</td>
						<td class="tab_right">${userMetroCard.cardid}</td>
					</tr>
				</c:if>
				<tr>
					<td class="tab_left">收货人：</td>
					<td class="tab_right"><input type="text" id="linkman"
						value="${userMetroCard.address.linkman}" name="linkman"
						maxlength="10"></td>
				</tr>
				<tr>
					<td class="tab_left">联系电话：</td>
					<td class="tab_right"><input type="text" id="linkmobile"
						value="${userMetroCard.address.linkmobile}" name="linkmobile"
						maxlength="11"></td>
				</tr>
				<tr>
					<td class="tab_left">所在地区：</td>
					<td class="tab_right"><input type="text" id="address"
						value="${userMetroCard.address.province}${userMetroCard.address.city}${userMetroCard.address.district}"
						name="location" maxlength="50" readonly="readonly"> <input
						id="fromprovince" name="province" type="hidden"> <input
						id="fromcity" name="city" type="hidden"> <input
						id="fromdistrict" name="district" type="hidden"></td>
				</tr>
				<tr>
					<td class="tab_left">详细地址：</td>
					<td class="tab_right"><input type="text" id="detailAddress"
						name="address" value="${userMetroCard.address.address}"
						style="width: 295px;" maxlength="50"></td>
				</tr>
				<tr>
					<td class="tab_left">邮政编码：</td>
					<td class="tab_right"><input type="text" id="postalcode"
						value="${userMetroCard.address.postcode}" name="postcode"
						maxlength="6"></td>
				</tr>
				<tr>
					<td colspan="2" class="btn_td">
						<button class="btn_blue" id="apply" onclick="applyCard()">
							<a>免费办理</a>
						</button>
						<button class="btn_blue" id="toloss" style="display: none;">
							<a href="#" onclick="tolossCard();">我要挂失</a>
							<!-- onclick="tolossCard()"  -->
						</button>
					</td>
				</tr>
			</table>
			<!--End----table需要填写的信息-->
		</form:form>
	</div>
	<!--End----------申请一卡通--------------主要内容-->
	<script type="text/javascript">
		$(function() {
			window.tolossCard=function(){
				$.MsgBox.Confirm("挂失提示","尊敬的用户，本次操作将会扣取20元挂失费用，请您确保账户余额足够完成本次扣费，确定申请挂失吗？", function(){
					location.href = "${wlpt}/wlpt/personal/toLossCard";
				}, null,null,null, "是", "否");
			}
			var isenterprise = '${isenterprise}';
			if (isenterprise == 'true') {
				$("#otherRoleTable").hide();
				$("#companyTable").show();
			}
			var status = '${userMetroCard.status}';
			if (status != null && status != "" && status != undefined) {
				if (status == 0 || status == 1|| status == 3 || status == 4) {
					$("#apply").attr("disabled", "true");
					$("#apply").css("background-color", "#ccc");
					$("#apply").css("color", "white");
					$("#apply").css("border-color", "#ccc");
					$("#linkman").attr("readonly", "true");
					$("#linkmobile").attr("readonly", "true");
					$("#address").attr("disabled", "true");
					$("#detailAddress").attr("readonly", "true");
					$("#postalcode").attr("readonly", "true");
					$("#apply").html("申请中");
					if (status == 1|| status == 3 || status == 4) {
						$("#apply").html("已申请");
						$("#apply").hide();
						$("#toloss").show();
					}
				}
			}

			window.applyCard = function() {
				var userstatus = '${user.userinfo.status}';
				/* if (userstatus != '2') {
					$.MsgBox.Alert("温馨提示", "请先完成认证");
					return false;
				} */

				var isnul = true;
				isnul = isnul && $("#linkman").valid({
					methods : "required|isName"
				});
				isnul = isnul && $("#linkmobile").valid({
					methods : "required|isPhone"
				});
				isnul = isnul && $("#address").valid({
					methods : "required|string"
				});
				isnul = isnul && $("#detailAddress").valid({
					methods : "required|string"
				});
				isnul = isnul && $("#postalcode").valid({
					methods : "required|isZipCode"
				});
				if (!isnul) {
					return false;
				}
				$("#apply").attr("disabled", "disabled");
				$.ajax({
					cache : true,
					type : "POST",
					url : "${wlpt}/wlpt/personal/saveCard",
					data : $('#inputForm').serialize(),// 你的formid
					async : false,
					error : function(request) {
						$.MsgBox.Alert("保存提示", "保存失败");
						$("#apply").attr("disabled", "none");
					},
					success : function(data) {
						$.MsgBox.Alert("保存提示", data.message);
						parent.location.href = "${wlpt}/wlpt/personal/index";
					}
				});
			};

			/* window.tolossCard=function(){
				parent.location.href = "${wlpt}/wlpt/personal/toLossCard";
			} */

			$("#address").PCC({
				hasCounty : true,
				width : 360,
				height : 220,
				url : "${wlpt}/wlpt/chinaarea/getArea",
				//closeIcon: "static/images/pic12.gif",
				complete : function(data) {
					var str = "";
					if (data.province) {
						str += data.province.NAME;
						$("#fromprovince").val(data.province.NAME);
					}
					if (data.city) {
						str += data.city.NAME;
						$("#fromcity").val(data.city.NAME);
					}
					if (data.county) {
						str += data.county.NAME;
						$("#fromdistrict").val(data.county.NAME);
					}
					$("#address").val(str);
				}
			});

		});
	</script>
</body>
</html>
