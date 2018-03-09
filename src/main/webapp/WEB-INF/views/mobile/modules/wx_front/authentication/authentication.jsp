<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--${toPage}认证</title>

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

<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<link href="${ctxStatic}/weixin/css/authentication.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<style type="text/css">
#submittext {
    line-height: 40px;
    margin: 10px 10px 0px 10px;
    background: #666666;
    text-align: center;
    color: #fff;
    cursor: pointer;
    border-radius: 5px;
}
</style>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>


<script type="text/javascript">
	var userID = '${pd.userID}';
	window.onload = function() {
		/* if ("" != userID) { */
		$.ajax({
			type : "POST",
			url : '${wx}/weixin/getJSSign',
			data : {
				Url : encodeURIComponent(location.href.split('#')[0])
			},
			dataType : 'json',
			cache : false,
			success : function(data) {
				var appID = data.appId;
				var nonceStr = data.nonceStr;
				var timestamp = data.timestamp;
				var signature = data.signature;
				wx.config({
					debug : false,
					appId : appID,
					timestamp : timestamp,
					nonceStr : nonceStr,
					signature : signature,
					jsApiList : [ 'checkJsApi', 'chooseImage', 'uploadImage' ]
				});
			}
		});
		/* } */
		var idCardPic = '${pd.imageName}';
		if ("" != idCardPic) { /* 显示图片 */
			$(".photo_identify").show();
		}
	}
</script>
</head>

<body>
	<div id="title" style="background-color: #EBEBEB;">
		<span style="float: left; padding-left: 10px;">${toPage}信息</span>
	</div>
	<div class="authMargin" id="forPersonal" style="display: none">
		<div class="divbox">
			<div class="b_border com_height">
				<span>真实姓名:</span> <input type="text" id="txtName"
					value="${user.name}" placeholder="请输入您的姓名" maxlength="18" />
			</div>
			<div class="b_border com_height">
				<span>手机号:</span><input type="text" id="txtPhone"
					value="${user.phone}" readonly="readonly" placeholder="请输入您的手机号"
					maxlength="11" />
			</div>
			<div class="b_border com_height">
				<span>身份证号码:</span><input type="text" id="txtIDCardNum"
					value="${user.userinfo.identitycard}" placeholder="请输入您的身份证号码"
					maxlength="18" />
			</div>
			<div class="b_border upload_pic">
				<span>上传身份证:</span> <input type="hidden" name="IDCARDIMGS"
					id="IDCARDIMGS" />
				<c:choose>
					<c:when test="${not empty user.userinfo.userIdcard.slocalphoto }">
						<div class="for_img" id="idcardImgs" style="margin-top: 5px;"
							onclick="uploadImg('idcardImgs','IDCARDIMGS','','','useridcard')">
							<img src="${user.userinfo.userIdcard.slocalphoto}"
								class="for_img" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="for_img" id="idcardImgs" style="margin-top: 5px;"
							onclick="uploadImg('idcardImgs','IDCARDIMGS','','','useridcard')"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="authMargin" id="forEnterprise" style="display: none">
		<div class="divbox">
			<div class="b_border com_height">
				<span>企业名称:</span><input type="text" id="txtCompanyName"
					value="${userCompany.companyname}" placeholder="请输入企业名"
					maxlength="18" />
			</div>
			<div class="b_border com_height">
				<span>营业执照号:</span><input type="text" id="txtBusinessLicNum"
					value="${userCompany.businesslicencenum}" placeholder="请输入营业执照号"
					maxlength="18" />
			</div>
			<div class="b_border com_height">
				<span>公司所在地:</span><input type="text" id="txtCompanyAddress" readonly="readonly"
					value="${userCompany.provinceCityDistrict}" placeholder="请输入公司所在地"
					maxlength="50" />
			</div>
			<div class="b_border com_height">
				<span>详细地址:</span><input type="text" id="txtDetailAddress"
					value="${userCompany.companyaddress}" placeholder="请输入公司详细地址"
					maxlength="100" />
			</div>
			<div class="b_border com_height">
				<span>公司联系人:</span><input type="text" id="txtContactPerson"
					value="${userCompany.legalperson}" placeholder="请输入联系人姓名"
					maxlength="18" />
			</div>
			<div class="b_border com_height">
				<span>手机号码:</span><input type="text" id="txtContactNumber"
					value="${userCompany.headermobile}" placeholder="请输入联系人手机号"
					maxlength="11" />
			</div>
			<div class="b_border upload_pic">
				<span>上传营业执照:</span> <input type="hidden"
					name="BUSINESSLICENCENUMIMG" id="BUSINESSLICENCENUMIMG" value="" />
				<c:choose>
					<c:when
						test="${not empty userCompany.usercompanypicture.businesslicencenumimg }">
						<div class="for_img" id="businesslicencenumImg"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('businesslicencenumImg','BUSINESSLICENCENUMIMG','','','userpicture')">
							<img
								src="${userCompany.usercompanypicture.businesslicencenumimg}"
								class="for_img" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="for_img" id="businesslicencenumImg"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('businesslicencenumImg','BUSINESSLICENCENUMIMG','','','userpicture')"></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="b_border upload_pic">
				<span>上传道路运输许可证:</span> <input type="hidden" name="TRANSPORTCARDIMG"
					id="TRANSPORTCARDIMG" value="" />
				<c:choose>
					<c:when
						test="${not empty userCompany.usercompanypicture.transportcardimg }">
						<div class="for_img" id="transportcardImg"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('transportcardImg','TRANSPORTCARDIMG','','','userpicture')">
							<img src="${userCompany.usercompanypicture.transportcardimg}"
								class="for_img" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="for_img" id="transportcardImg"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('transportcardImg','TRANSPORTCARDIMG','','','userpicture')"></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="b_border upload_pic">
				<span>上传法人身份证正面:</span> <input type="hidden" name="IDCARDIMG1"
					id="IDCARDIMG1" />
				<c:choose>
					<c:when test="${not empty idcard1 }">
						<div class="for_img" id="idcardImg1"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('idcardImg1','IDCARDIMG1','','','userpicture')">
							<img src="${idcard1}" class="for_img" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="for_img" id="idcardImg1"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('idcardImg1','IDCARDIMG1','','','userpicture')"></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="b_border upload_pic">
				<span>上传法人身份证反面:</span> <input type="hidden" name="IDCARDIMG2"
					id="IDCARDIMG2" />
				<c:choose>
					<c:when test="${not empty idcard2 }">
						<div class="for_img" id="idcardImg2"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('idcardImg2','IDCARDIMG2','','','userpicture')">
							<img src="${idcard2}" class="for_img" />
						</div>
					</c:when>
					<c:otherwise>
						<div class="for_img" id="idcardImg2"
							style="line-height: 40px; background-size: 40px; margin: 5px;"
							onclick="uploadImg('idcardImg2','IDCARDIMG2','','','userpicture')"></div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>

	<!-- 同意协议 -->
	<div class="last_div">
		<p class="fortreaty">
			<span class="side">✔</span> 同意 <%-- <a
				href="/wlpt/agreement/AgreementInfo.do?AGREEMENT_ID=${pd.agreementID}"
				target="_blank" class="treaty" style="color: #444444;"> --%>实名认证协议<!-- </a> -->
		</p>
		<p class="forprompt">
			
			<span class="prompt">认证通过后，发布信息可以优先展示到平台</span>
			
		</p>
		<c:if test="${STATUS!='1' && STATUS!='2'}">
		<p id="submit" style="background-color: rgba(32, 162, 226, 0.87);">申请认证</p>
		</c:if>
			<c:if test="${STATUS=='3' and not empty quality}"> 
				<p><span style="color:red;">您的上一次审核不通过,审核结果:${quality.certifycomment }</span></p>
			</c:if>
			<c:if test="${STATUS=='1'}"> 
				<p id="submittext">认证中</p></c:if>
			<c:if test="${STATUS=='2'}"> 
				<p id="submittext">认证通过！</p></c:if>
			<input type="hidden" id="userStatus" name="userStatus"
				value="${STATUS}" />
	</div>
	<div id="erro">
		<p id="erro_prompt"
			style="text-align: center; margin-top: 250px; color: #FFF;">请输入正确的手机号或营业执照号</p>
	</div>
	<!-- 示例部分 -->
	<div class="explainMargin bor_bot">
		<strong>重要说明</strong>
		<%-- <c:if
			test="${pdqua.CERTIFYCOMMENT!=null&&pdqua.CERTIFYCOMMENT!=''&&STATUS=='3'}">
			<p>
				<span style="">您的上一次审核不通过,审核结果:${pdqua.CERTIFYCOMMENT!=null?pdqua.CERTIFYCOMMENT:''}</span>
			</p>
		</c:if> --%>
		<p>1、您的资料可能会被提交到国家公安机关及其下属单位进行证件真实性核实，我们不会将您的证件资料用作商业用途或非法提供给他人，但是如果出现法律纠纷它可能作为相关证据使用。</p>
		<p>2、身份认证一旦通过，不能取消、删除、修改，请保管好您的密码，避免信息被违法分子所用。</p>
		<p class="mar">3、企业身份认证一旦通过将与您对应的唯一帐户进行绑定，企业身份具有唯一性。</p>
	</div>
	<div id="personalSimple" style="display: none">
		<div class="explainMargin">
			<div class="simpleLeft">
				<strong>个人认证示例</strong>
				<p>1、身份证正面在前，人在后，证件不遮挡面部，保证证件清晰不模糊。</p>
				<p>2、需要完整的身份证正面，保证身份证边缘处于图片内部，姓名，证件号码，照片清晰。</p>
			</div>
		</div>
		<div class="explainMargin simpleRight bor_bot">
			<img class="imgSimple" src="static/images/weixin/per_pic.jpg" />
			<p class="simpleDesc mar">本人手持身份证正面头部照</p>
		</div>
	</div>
	<div id="enterpriseSimple" style="display: none">
		<div class="explainMargin">
			<strong>企业认证示例</strong>
			<p>需要企业营业执照最新版本，注意以下几点：</p>
			<p>1、最好上传企业营业执照的彩色电子版。</p>
			<p>
				2、营业执照复印件电子版需要加盖红色鲜章，并标注作${fns:getConst('SYSTEMTITLE')}资质认证用途。</p>
			<p>3、保证营业执照是最新版本，在工商局能够查询到，并且和执照上显示的信息一致。</p>
			<p>4、拍照时营业执照纸张边界应处于照片内，右上角“编号”需显示出来。</p>
			<p>5、电子版需要保证营业执照上的所有文字、二维码和登记机关签章都清晰可辨。</p>
		</div>
		<div class="explainMargin simpleRight bor_bot">
			<img src="http://static.95155.com/member/images/ent_pic2.png">
			<p>营业执照彩色电子版</p>
			<p class="simpleDesc mar">需在营业期限内</p>
		</div>
	</div>
	<div class="explainMargin">
		<strong>后续</strong>
		<p>1、我们有专门的工作人员为您提交的资料进行核对认证工作，不出意外的话，您可以在3个工作日内收到审核结果的短信提示。</p>
		<p>2、如果您没有通过资质认证，工作人员会通过客服热线与您联系，说明不通过原因。</p>
	</div>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/weiXinUpload.js"></script>
			<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
	<script type="text/javascript">
		var roleCode = '${roleCode}';
		var status = '${STATUS}';
		(function() {
			if (roleCode == "goodsowner" || roleCode == "carowner") { //个人货主、个人车主
				$("#forPersonal").css('display', 'block');
				$("#personalSimple").css('display', 'block');
				$(".last_div").css('display', 'block');
			} else if (roleCode == "enterprise") { //物流企业
				$("#forEnterprise").css('display', 'block');
				$("#enterpriseSimple").css('display', 'block');
				$(".last_div").css('display', 'block');
			} else { //未完善资料角色
				$("#personalSimple").css('display', 'block');
				$("#enterpriseSimple").css('display', 'block');
				$("#forPersonal,#forEnterprise").removeAttr("onclick");
			}
			if (status == "1" || status == "2") {
				$("#submit").hide();
			}
		})();

		/*返回上一页*/
		$(".backhost").click(function() {
			window.history.go(-1);
		});

		/* 选择图片 */
		var images = {
			localId : [],
			serverId : []
		};
		$("#for_imgP,#for_imgE").click(function() {
			wx.chooseImage({
				count : 1,
				success : function(res) {
					images.localId = res.localIds;
					$(".photo_identify").show();
					$(".photo_img").attr("src", images.localId[0]);
				}
			});
		});

		var imageInfo = "";
		window.uploadImg = function() {

			if (images.localId.length == 0) {
				if (roleCode == "goodsowner") {
					$("#for_imgE").tips({
						side : 3,
						msg : "请选择图片！",
						bg : '#FF5080',
						time : 3
					});
				} else {
					$("#for_imgP").tips({
						side : 3,
						msg : "请选择图片！",
						bg : '#FF5080',
						time : 3
					});
				}
				return;
			}
			var i = 0, length = images.localId.length;
			window.upload = function() {
				wx.uploadImage({
					localId : images.localId[i],
					success : function(res) {
						images.serverId.push(res.serverId);
						$.ajax({
							type : "POST",
							url : '${wx}/weixin/downloadImg',
							data : {
								ServerID : images.serverId[i],
								FolderName : "authentication"
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data) {
									if (length == images.serverId.length) {
										imageInfo = data.ImageName;
										submit();
									}
								} else {
									if (roleCode == "enterprise") {
										$("#for_imgE").tips({
											side : 3,
											msg : "上传证件失败！",
											bg : '#FF5080',
											time : 3
										});
									} else {
										$("#for_imgP").tips({
											side : 3,
											msg : "上传证件失败！",
											bg : '#FF5080',
											time : 3
										});
									}
								}
							}
						});
						i++;
						if (i < length) {
							upload();
						}
					},
					fail : function(res) {
						if (roleCode == "enterprise") {
							$("#for_imgE").tips({
								side : 3,
								msg : "上传证件失败！",
								bg : '#FF5080',
								time : 3
							});
						} else {
							$("#for_imgP").tips({
								side : 3,
								msg : "上传证件失败！",
								bg : '#FF5080',
								time : 3
							});
						}
					}
				});
			};
			upload();
		};

		$(function() {
			// bool判断是否同意协议
			var bool = true;

			$(".side").toggle(function() {
				$(this).text("").css({
					background : "#fff",
					border : "1px solid #ccc"
				});
				bool = false;
			}, function() {
				$(this).text("✔").css({
					background : "#FF9001",
					border : "1px solid #FF9001"
				});
				bool = true;
			});

			// 提交表单
			$("#submit").click(
					function() {
						if (bool) {
							if (check()) {
								if (roleCode == "goodsowner"
										|| roleCode == "carowner") { //个人货主、个人车主
									checkPersonalInfo();
								} else if (roleCode == "enterprise") { //物流企业
									checkEnterpriseInfo();
								}
							}
						}
					});
		});

		function checkPersonalInfo() {
			var phoneNum = $("#txtPhone").val().trim();
			var idCardNum = $("#txtIDCardNum").val().trim();
			var reg = /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/;
			var ireg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
			if (reg.test(phoneNum) && ireg.test(idCardNum)) {
				submit();
				/* if (images.localId.length == 1) {
					uploadImg();
					alert(2);
				} else {
					$("#for_imgP").tips({
						side : 3,
						msg : "请选择图片！",
						bg : '#FF5080',
						time : 3
					});
				} */
			} else {
				$("#erro").show();
				setTimeout(function() {
					$("#erro").fadeOut(2000);
				}, 1000);
			}
		}

		window.checkEnterpriseInfo = function() {
			var reg = /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/;
			var num = /^[0-9A-Z]+$/;
			var isNumberOrLetter = /^[0-9a-zA-Z]+$/
			var phoneNumber = $("#txtContactNumber").val().trim();
			var businessLicNum = $("#txtBusinessLicNum").val().trim();
			if (reg.test(phoneNumber) && isNumberOrLetter.test(businessLicNum)) {
				submit();
				/* if (images.localId.length == 1) {
					uploadImg();
					
				} else {
					$("#for_imgE").tips({
						side : 3,
						msg : "请选择图片！",
						bg : '#FF5080',
						time : 3
					});
				} */
			} else {
				if (!reg.test(phoneNumber) && !isNumberOrLetter.test(businessLicNum)) {
					$("#erro_prompt").text("请输入正确的手机号和营业执照号！");
					$("#erro").show();
					setTimeout(function() {
						$("#erro").fadeOut(2000);
					}, 1000);
				} else if (!isNumberOrLetter.test(businessLicNum)) {
					$("#erro_prompt").text("请输入正确的营业执照号！");
					$("#erro").show();
					setTimeout(function() {
						$("#erro").fadeOut(2000);
					}, 1000);
				} else if (!reg.test(phoneNumber)) {
					$("#erro_prompt").text("请输入正确的手机号！");
					$("#erro").show();
					setTimeout(function() {
						$("#erro").fadeOut(2000);
					}, 1000);
				}
			}
		};

		function submit() {
			if (roleCode == "goodsowner" || roleCode == "carowner") { //个人货主、个人车主
				sumbitPersonalAuth();
			} else if (roleCode == "enterprise") { //物流企业
				sumbitEnterpriseAuth();
			}
		}

		function sumbitPersonalAuth() {
			$("#submit").hide();
			var name = $("#txtName").val().trim();
			var phoneNum = $("#txtPhone").val().trim();
			var idCardNum = $("#txtIDCardNum").val().trim();
			var idCardID = '${pd.idCardID}';
			var IDCARDIMGS = $("input[name=IDCARDIMGS]").val();
			$
					.ajax({
						type : "POST",
						url : '${wx}/weixin/authentication/personalAuthentication',
						data : {
							"name" : name,
							"userinfo.identitycard" : idCardNum,
							"userinfo.userIdcard.slocalphoto" : IDCARDIMGS
						},
						dataType : 'json',
						cache : false,
						success : function(data) {
							window.location.href = "${wx}/weixin/user/userHome";
						}
					});
		}

		function sumbitEnterpriseAuth() {
			$("#submit").hide();
			var companyName = $("#txtCompanyName").val().trim();
			var businessLicNum = $("#txtBusinessLicNum").val().trim();
			var provinceCity = $("#txtCompanyAddress").val().trim();
			var companyAddress = $("#txtDetailAddress").val().trim();
			var contactPerson = $("#txtContactPerson").val().trim();
			var contactNumber = $("#txtContactNumber").val().trim();
			var BUSINESSLICENCENUMIMG = $("input[name=BUSINESSLICENCENUMIMG]")
					.val();
			var TRANSPORTCARDIMG = $("input[name=TRANSPORTCARDIMG]").val();//运输
			var IDCARDIMG1 = $("input[name=IDCARDIMG1]").val();
			var IDCARDIMG2 = $("input[name=IDCARDIMG2]").val();
			var IDCARDIMG = "|" + IDCARDIMG1 + "|" + IDCARDIMG2;//身份证
			$
					.ajax({
						type : "POST",
						url : '${wx}/weixin/authentication/companyAuthentication',
						data : {
							"companyname" : companyName,
							"businesslicencenum" : businessLicNum,
							"provinceCityDistrict" : provinceCity,
							"companyaddress" : companyAddress,
							"legalperson" : contactPerson,
							"headermobile" : contactNumber,
							"usercompanypicture.businesslicencenumimg" : BUSINESSLICENCENUMIMG,
							"usercompanypicture.idcardimg" : IDCARDIMG,
							"usercompanypicture.transportcardimg" : TRANSPORTCARDIMG
						},
						dataType : 'json',
						cache : false,
						success : function(data) {
							window.location.href = "${wx}/weixin/user/userHome";
						}
					});
		}

		// 客户端校验
		function check() {
			var isNull = true;
			if (roleCode == "goodsowner" || roleCode == "carowner") { //个人货主、个人车主
				var name = $("#txtName").val().trim();
				var phone = $("#txtPhone").val().trim();
				var idCardNum = $("#txtIDCardNum").val().trim();
				var idcardImgs = $("input[name=IDCARDIMGS]").val();
				if (!name) {
					$("#txtName").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}

				isNull = isNull && $("#txtName").valid({
					methods : "required|isName",
					tipSide : "3"
				});
				if (!phone) {
					$("#txtPhone").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!idCardNum) {
					$("#txtIDCardNum").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!idcardImgs) {
					$("#idcardImgs").focus().tips({
						side : 3,
						msg : "上传图片失败",
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				
			} else if (roleCode == "enterprise") { //物流企业
				var companyName = $("#txtCompanyName").val().trim();
				var businessLicNum = $("#txtBusinessLicNum").val().trim();
				var companyAddress = $("#txtCompanyAddress").val().trim();
				var contactPerson = $("#txtContactPerson").val().trim();
				var contactNumber = $("#txtContactNumber").val().trim();
				var businessImg = $("input[name=BUSINESSLICENCENUMIMG]").val();
				var transportImg = $("input[name=TRANSPORTCARDIMG]").val();//运输
				var idcardImg1 = $("input[name=IDCARDIMG1]").val();
				var idcardImg2 = $("input[name=IDCARDIMG2]").val();
				if (!companyName) {
					$("#txtCompanyName").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}

				isNull = isNull && $("#txtCompanyName").valid({
					methods : "required|isName",
					tipSide : "3"
				});
				if (!businessLicNum) {
					$("#txtBusinessLicNum").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!companyAddress) {
					$("#txtCompanyAddress").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!contactPerson) {
					$("#txtContactPerson").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!contactNumber) {
					$("#txtContactNumber").focus().tips({
						side : 3,
						msg : msg,
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!businessImg) {
					$("#businesslicencenumImg").focus().tips({
						side : 3,
						msg : "上传图片失败",
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!transportImg) {
					$("#transportcardImg").focus().tips({
						side : 3,
						msg : "上传图片失败",
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!idcardImg1) {
					$("#idcardImg1").focus().tips({
						side : 3,
						msg : "上传图片失败",
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
				if (!idcardImg2) {
					$("#idcardImg2").focus().tips({
						side : 3,
						msg : "上传图片失败",
						bg : '#FF5080',
						time : 3
					});
					isNull = false;
				}
			}
			return isNull;
		}

		/* 初始化地区 */
		var winWidth = document.body.clientWidth;
		var widths, heights;
		if (parseInt(winWidth) == 320) { // 宽320(iphone4)
			widths = 312;
			heights = 255;
		} else if (parseInt(winWidth) == 375) { // 宽375(iphone6)
			widths = 366;
			heights = 260;
		} else if (parseInt(winWidth) == 414) { // 宽375(iphone6s)
			widths = 404;
			heights = 210;
		} else { // 其它分比率
			widths = 352;
			heights = 260;
		}
		$("#txtCompanyAddress").PCC({
			hasCounty : true,
			width : widths,
			height : heights,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "/static/images/pic12.gif",
			location : "left",
			ismiddle : true,
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
				}
				if (data.city) {

					if (data.city.NAME != data.province.NAME) {
						str += data.city.NAME;
					}
				}
				if ("  " == str) { // 无选择地区时
					$("#txtCompanyAddress").val("");
				} else {
					$("#txtCompanyAddress").val(str);
				}
			}
		});
	</script>
</body>
</html>
