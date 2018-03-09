<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--编辑个人信息</title>

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

<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<link href="${ctxStatic}/weixin/css/editpersonalinfo.css" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
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
		var userID = '${pd.USER_ID}';
		window.onload = function() {
			var userName = '${user.loginName}';
			var userStatus = '${user.userinfo.status}';
			var sex = '${user.userinfo.sex}';
			if("1" == sex){
				$("#man").attr("checked","checked");
			}
			if("0" == sex){
				$("#women").attr("checked","checked");
			}
			if ("" == userName) {	// 用户名为空，用户名可编辑
				$("#txtUserName").attr("readonly", false);
			}
			if ("2" == userStatus) {	// 用户已认证,公司名称不可编辑
				$("#txtCompanyName").attr("readonly", true);
			}
			
			$.ajax({
				type : "POST",
				url : '${wx}/weixin/getJSSign',
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
		};
	</script>
</head>

<body>
	<%--  <div id="title" style="background-color:rgb(32, 134, 226)"><img class="backhost" src="static/images/weixin/back_history.png"/><span class="title">我的${pd.ECSYSNAME }</span></div> --%>
	<div id="upload" style="background-color:rgba(32, 134, 226,0.8)">
		<input type="hidden" id="HeadImg" value="${user.photo}" />
		<div>
			<c:choose>
				<c:when test="${user.photo!=null}">
					<img id="imgUpload"
						src="${user.photo}" />
				</c:when>
				<c:otherwise>
					<img id="imgUpload" src="${ctxStatic}/images/weixin/upload.png" />
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<input id="btnUpload" style="background-color:rgba(32, 134, 226,1)"
				type="button" value="更换头像" onclick="chooseImg('photo')" />
		</div>
	</div>
	<div id="userInfo">
		<div class="userInfo">
			<div class="infoDetail">
				<span class="attr">用户名</span><input id="txtUserName"
					class="to_personal" type="text" value="${user.loginName }"
					readonly="true" />
			</div>
			<div class="infoDetail">
				<span class="attr" style="border:none;">性别</span> <span id="sexs"
					class="radio"><label><input type="radio" id="man"
						name="sex" value="1" checked="checked" />男</label> <label><input
						type="radio" id="women" name="sex" value="0" />女</label></span>
			</div>
			<div class="infoDetail" id="companyName">
				<!--height:40px;display:none;  -->
				<span class="attr" style="float:left;">公司名称</span><input
					style="float:left;height:40px;" id="txtCompanyName" type="text"
					value="${user.userinfo.companyname}" maxlength="100">
					<input type="hidden" id="userCompanyid" value="${user.userCompany.id}"/>
			</div>
			<div class="infoDetail">
				<span class="attr">注册手机</span><input id="txtPhone" type="text"
					value="${user.phone }" readonly="true">
			</div>
			<div class="infoDetail">
				<span class="attr">联系地址</span><input id="txtAddress"
					class="to_personal" type="text" value="${user.userinfo.contactaddress }"
					maxlength="100" />
			</div>
			<div class="infoDetail">
				<span class="attr">联系QQ</span><input id="txtQQ" type="text"
					value="${user.userinfo.qq}" maxlength="11" />
			</div>
			<div class="infoDetail">
				<span class="attr">注册时间</span><input type="text" id=""
					value="<fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="true" />
			</div>
			<div class="">&nbsp;</div>
			<div class="infoDetail">
				<input id="btnSave" type="button" class="btnModify" value="保    存"
					onclick="modifyInfo()"
					style="background-color:rgba(32, 162, 226, 0.87);" />
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript">
    	/*返回上一页*/
		$(".backhost").click(function() {
			window.history.go(-1);
		});
    	
	    var images = {
			    localId: [],
			    serverId: []
	    };
		function chooseImg(photo) {
			wx.chooseImage({
			  count:1,
		      success: function (res) {
		    	  images.localId = res.localIds;
		    	  $("#imgUpload").attr("src", images.localId[0]);
		    	  uploadImg(photo);
		      }
		    });
		};
		 
		// 5.3 上传图片
		function uploadImg(folderName) {
			wx.uploadImage({
				  localId: images.localId[0],
				  success: function (res) {
					  images.serverId=[];
					  images.serverId.push(res.serverId);
					  $.ajax({
							type : "POST",
							url : '${wx}/weixin/downloadImg',
							data : { ServerID : images.serverId[0],FolderName: folderName },
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.result) {
									$("#HeadImg").val("");
									$("#HeadImg").val(data.ImageName);
								} else {
									$("#btnUpload").tips({
										side : 3,
										msg : "更换头像失败！",
										bg : '#FF5080',
										time : 3
									});
								}
							}
					   });
				  }
			});
		};
				 
		/* 修改用户信息 */
		function modifyInfo() {
				modify();
		}
		
		function modify() {
			var userName = $("#txtUserName").val();
			var sex = $('input[name="sex"]:checked ').val();
			var companyName = $("#txtCompanyName").val();
			var address = $("#txtAddress").val();
			var qq = $("#txtQQ").val();
			
			var reg = /^\d{5,11}$/;
			if(!reg.test(qq) && qq){
				$("#txtQQ").tips({
					side : 3,
					msg : "请输入正确的QQ号！",
					bg : '#AE81FF',
					time : 3
				});
				return;
			}
			
			if(check()){
				var headimgs=$("#HeadImg").val();
				$.ajax({
					type : "POST",
					url : '${wx}/weixin/user/editUserInfo',
					data : {
						"userCompany.id":$("#userCompanyid").val(),
						"user.loginName" : userName,
						"user.photo" : headimgs,
						"sex" : sex,
						"companyname" : companyName,
						"contactaddress" : address,
						"qq" : qq
					},
					dataType : 'json',
					cache : false,
					success : function(data) {
						if (data.result) {
							window.location.href="${wx}/weixin/user/userHome";
						} else {
							$("#btnSave").tips({
								side : 3,
								msg : "修改用户信息失败！",
								bg : '#FF5080',
								time : 3
							});
						}
					}
				});
			}
		}
		
		function check() {
	  		var isnul = true;
	  		$(".to_personal").each(function(){
	  			if(isnul){
	  				if(!$(this).val()){
	  	  				$(this).attr("placeholder","此项不能为空").focus();
	  	  				isnul = false;
	  	  			}	  				
	  			}  			
			});
	  		return isnul;
	  	}
    </script>
</body>
</html>
