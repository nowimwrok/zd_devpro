<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>企业认证</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
<link href="static/css/weixin/enterprisecertificate.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
		window.onload = function () {
			$.ajax({
				type : "POST",
				url : 'weixin/getJSSign',
				data : {Url : encodeURIComponent(location.href.split('#')[0])},
				dataType : 'json',
				cache : false,
				success : function(data) {
					var appID = data.appId;
					var nonceStr = data.nonceStr;
					var timestamp = data.timestamp;
					var signature = data.signature;
					wx.config({
					    debug: false, 
					    appId: appID, 
					    timestamp: timestamp ,
					    nonceStr: nonceStr, 
					    signature: signature, 
					    jsApiList: ['checkJsApi', 'chooseImage', 'uploadImage', 'downloadImage'] 
					});
				}
			});
		}
	</script>
</head>

<body>
	<div class="for_title">
		<img class="backhost" src="static/images/weixin/back_history.png" /><span class="title">企业认证</span>
	</div>
	<div class="divbox">
		<div class="b_border com_height">
			<span>企业名称</span><input type="text" id="txtCompanyName" name="companyName" value="${pd.companyName}" placeholder="请输入企业名" maxlength="18" />
		</div>
		<div class="b_border com_height">
			<span>营业执照号</span><input type="text" id="txtBusinessLiceceNum" name="businessLicenceNum" value="${pd.businessLicenceNum}" placeholder="请输入营业执照号" maxlength="18" />
		</div>
		<div class="b_border com_height">
			<span>公司所在地</span><input type="text" id="txtCompanyAddress" name="companyAddress" value="${pd.companyAddress}" placeholder="请输入公司所在地" maxlength="50" />
		</div>
		<div class="b_border com_height">
			<span>详细地址</span><input type="text" id="txtDetailAddress" name="detailAddress" value="" placeholder="请输入公司详细地址" maxlength="100" />
		</div>
		<div class="b_border com_height">
			<span>公司联系人</span><input type="text" id="txtContactPerson" name="contactPerson" value="${pd.companyContactPerson}" placeholder="请输入联系人姓名" maxlength="18" />
		</div>
		<div class="b_border com_height">
			<span>手机号码</span><input type="text" id="txtContactNumber" name="contactNumber" value="${pd.companyNumber}" placeholder="请输入联系人手机号" maxlength="11" />
		</div>
		<div class="b_border upload_pic">
			<span>上传营业执照</span>
			<div class="for_img" id="for_img" title="请上传身份证号/驾驶证号"></div>
		</div>
		<div class="photo_identify">
			<img class="photo_img" src="" />
		</div>
		<div class="last_div">
			<p class="fortreaty">
				<span class="side">✔</span> 同意 <a href="./wlpt/agreement/AgreementInfo.do?AGREEMENT_ID=${pd.agreementID}" target="_blank" class="treaty">${pd.agreementName}</a>
			</p>
			<p class="forprompt">
				<span class="prompt">认证通过后，发布信息可以优先展示到平台</span>
			</p>
			<p id="submit">申请认证</p>
		</div>
	</div>
	<div id="erro">
		<p id="erro_prompt" style="text-align: center;margin-top: 250px;color:#FFF;">请输入正确的手机号或营业执照号</p>
	</div>
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	  	/* 选择图片 */	
	  	var images = { localId:[], serverId:[]};
	  	$(".for_img").click(function() {
	  		wx.chooseImage({
	  			count:1,
	  			success:function (res) {
	  				images.localId = res.localIds;
	  				$(".photo_identify").show();
			        $(".photo_img").attr("src", images.localId[0]);
	  			}
	  		});
	  	});
	  	
	  	var imageInfo = "";
	  	function uploadImg() {
	  		if (images.localId.length == 0) {
	  			$("#for_img").tips({
						side : 3,
						msg : "请选择图片！",
						bg : '#FF5080',
						time : 3
				});
	  			return ;
	  		}
	  		var i = 0, length = images.localId.length;
	  		function upload() {
	  			wx.uploadImage({
	  				localId : images.localId[i],
	  				success : function (res) {
	  					images.serverId.push(res.serverId);
	  					$.ajax({
	  						type : "POST",
	  						url : 'weixin/downloadImg',
	  						data : { ServerID : images.serverId[i] },
	  						dataType : 'json',
	  						cache : false,
	  						success : function(data) {
	  							if (data) {
	  								alert(data.ImageName);
	  								if (length == images.serverId.length) {
	  									alert(data.ImageName);
	  									imageInfo = data.ImageName;
	  									submit();
	  								}
	  							} else {
	  								$("#for_img").tips({
	  									side : 3,
	  									msg : "上传证件失败！",
	  									bg : '#FF5080',
	  									time : 3
	  								});
	  							}
	  						}
	  					});
	  					i++;
	  					if (i < length) {
	  						upload();
	  					}
	  				}, 
	  				fail: function (res) {
	  					$("#for_img").tips({
							side : 3,
							msg : "上传证件失败！",
							bg : '#FF5080',
							time : 3
						});
	  				}
	  			});
	  		}
	  		upload();
	  	}
	  	
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
	  		
	  		// 返回上一页
	  		$(".backhost").click(function() {
	  			window.history.go(-1);
	  		});
	  		
	  		// 提交表单
	  		$("#submit").click(function() {
	  			if (bool) {
	  				if (check()) {
	  					var reg = /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/;
	  					var num = /^[0-9a-zA-Z]$/;
	  					var p = $("#txtContactNumber").val().trim();
	  			  		var b = $("#txtBusinessLiceceNum").val().trim();
	  		  			if (reg.test(p) && num.test(b)) {
	  		  				if (images.localId.length == 1) {
								uploadImg();
							} else {
								$("#for_img").tips({
									side : 3,
									msg : "请选择图片！",
									bg : '#FF5080',
									time : 3
								});
		 					}
	  		  			} else {
	  		  				if(!reg.test(p) && !num.test(b)){
								$("#erro_prompt").text("请输入正确的手机号和营业执照号！");
								$("#erro").show();
		  	  					setTimeout(function() {
		  	  						$("#erro").fadeOut(3000);
		  	  					}, 1000);
							}
	  		  				else if(!num.test(b)){
								$("#erro_prompt").text("请输入正确的营业执照号！");
								$("#erro").show();
		  	  					setTimeout(function() {
		  	  						$("#erro").fadeOut(3000);
		  	  					}, 1000);
							}
	  		  				else if(!reg.test(p)){
	  							$("#erro_prompt").text("请输入正确的手机号！");
	  							$("#erro").show();
	  	  	  					setTimeout(function() {
	  	  	  						$("#erro").fadeOut(3000);
	  	  	  					}, 1000);
	  						}  		  				
	  	  				}
	  		  		}
	  			}
	  		});
	  	});
	
	  	function submit() {
	  		var json = {};
	  		json['userID'] = '${pd.userID}';
	  		json['userID'] = '${pd.userID}';
	  		json['businessLicenceNumPic'] = imageInfo;
	  		alert(imageInfo);
	  		$("input[type='text']").each(function() {
	  			json[$(this).attr('name')] = $(this).val().trim();
	  		});
	  		
  			/* $.ajax({
  				type : "POST",
  				url : 'weixin/applyEnterpriseAuth',
  				data : json,
  				dataType : 'json',
  				cache : false,
  				success : function(data) {
  					if (data.msg == "ok") {
  						 window.location.href = "weixin/personalinfo?openID=" + data.openID; 
  						window.location.href="${wx}/weixin/user/userHome";
  					}
  				}
  			}); */
	  	}
	
	  	// 客户端校验
	  	function check() {
	  		var isnul = true;
	  		$("input[type='text']").each(function() {
	  			if (isnul) {
	  				var val = $(this).val().trim();
	  				if (!val) {
	  					var msg = $(this).attr("placeholder");
	  					$(this).focus().tips({
							side : 3,
							msg : msg,
							bg : '#FF5080',
							time : 3
						});
	  					isnul = false;
	  				}
	  			}
	  		});
	  		return isnul;
	  	}
	  	
	  	// ********************************************************初始化地区********************************************************//
		var winWidth = document.body.clientWidth;
		var widths,heights;
		if (parseInt(winWidth) == 320) {	// 宽320(iphone4)
			widths = 312;
			heights = 255;
		} else if (parseInt(winWidth) == 375) {	// 宽375(iphone6)
			widths = 366;
			heights = 260;
		} else if (parseInt(winWidth) == 414) {	// 宽375(iphone6s)
			widths = 404;
			heights = 210;
		} else {	// 其它分比率
			widths = 352;
			heights = 260;
		}
	  	$("#txtCompanyAddress").PCC({
	  		hasCounty : true,
	  		width : widths,
	  		height : heights,
	  		url : "wlpt/area/getarea",
	  		closeIcon : "./static/images/pic12.gif",
	  		complete : function(data) {
	  			var str = "";
	  			if (data.province) {
	  				str += data.province.NAME + " ";
	  			}
	  			if (data.city) {
	  				str += data.city.NAME + " ";
	  			}
	  			if (data.county) {
	  				str += data.county.NAME;
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
