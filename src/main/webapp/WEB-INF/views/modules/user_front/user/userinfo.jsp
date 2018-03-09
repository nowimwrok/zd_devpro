<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
<title>用户资料</title>
<style>
        .goods_details .form-group{
            margin-left:2.5%;
            margin-right:2.5%;
        }
         .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
        ol li{
      		float:left;
      	}
      	.form-control{
			border: 1px solid #ccc !important;
		}
		
    </style>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script src="/static/common/jeesite.js" type="text/javascript"></script>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
<form:form id="inputForm" modelAttribute="userinfo"
		action="${wlpt}/wlpt/user/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<form:hidden path="user.id" />
		<form:hidden path="userCompany.id" />
		<input type="hidden" id="userId" name="userId" value="${userinfo.id }" />
	<div class="row edit-box">
		<div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        账号信息 (<span class="red">*</span>为必填项)
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right"><span class="red">*</span>登录名</div>
                            <div class="col-sm-5 text-left pr-0">
                                <form:input path="user.loginName" onblur="validLoginName()" cssClass="form-control"
									id="loginName"  />
                            </div>
                            <div class="col-sm-4 validate_messege pl-5px pr-0" data-scroll-reveal="enter from the bottom after 1s" id="Name_validate" >不能为空</div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right"><span class="red">*</span>公司名称</div>
                            <div class="col-sm-5 text-left pr-0">
                            	<c:choose>
									  <c:when test="${fns:getUser().role.enname eq 'enterprise'&& !empty userinfo.companyname && (userinfo.status==1||userinfo.status==2)}">
									  		  ${userinfo.companyname}</c:when>
									  <c:otherwise>
											  <form:input id="companyname" 
													path="companyname" htmlEscape="false" maxlength="32"
													cssClass="form-control" />
					                  </c:otherwise>
								</c:choose> 
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right">姓名</div>
                            <div class="col-sm-5 text-left pr-0">
                                <c:choose>
									<c:when test="${fns:getUser().role.enname ne 'enterprise' && (userinfo.status==1||userinfo.status==2)}">
										${userinfo.user.name}</c:when>
								    <c:otherwise>
					                	<form:input id="username" path="user.name"  cssClass="form-control"/>
					                </c:otherwise>
				                </c:choose> 
                            </div>
                        </div>
                        <div class="form-group col-sm-6 has-js">
                            <div class="col-sm-3 control-label text-right">性别</div>
                            <div class="col-sm-9 text-left pr-0">
                                <div class="radios">
                                    <label class="label_radio" for="male">
                                        <form:radiobutton path="sex" id="boy"  value="1" />男 
                                    </label>
                                    <label class="label_radio" for="famale">
                                        <form:radiobutton path="sex" id="girl"  value="0" />女
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-lg-3 control-label text-right">手机号码</div>
                            <div class="col-lg-5 text-left pr-0 has-error">
                                ${userinfo.user.phone}
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-lg-3 control-label text-right">注意</div>
                            <div class="col-lg-5 text-left pr-0">
                                <div class="form-control noborder-form-control" style="color:#e84c3d;">*已认证信息部分不可修改</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        联系信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right">固定电话</div>
                            <div class="col-sm-5 text-left">
                            	<form:input id="telphone"
									path="telphone" placeholder="请输入固话号码" htmlEscape="false"
									maxlength="32" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right">Email</div>
                            <div class="col-sm-5 text-left">
                                <form:input id="email"
									path="user.email" htmlEscape="false" maxlength="32"
									class="form-control" />
                            </div>
                            <div class="col-sm-4 text-center">
                                <a class="perfect_info car_perfect_info">更多信息<i class="fa fa-chevron-circle-down"></i> </a>
                            </div>
                        </div>

                        <div class="clearfix car_hide_box">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-right">QQ</div>
                                <div class="col-sm-5 text-left">
                                    <input class="form-control" value="">
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-sm-3 control-label text-right">联系地址</div>
                                <div class="col-sm-5 text-left">
                                    <textarea placeholder="补充说明" class="form-control" rows="2" style="padding:3px;text-indent:5px;"></textarea>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-sm-3 control-label text-right">上传头像</div>
                                <div class="col-sm-9 text-left">
                                    <div class="text-left" class="controls">
                                        <form:hidden id="nameImage" isdelall="false" path="user.photo"
											htmlEscape="false" maxlength="255" class="input-xlarge" />
										<sys:ckfinder input="nameImage" type="images" uploadPath="/photo"
											selectMultiple="false" maxWidth="100" maxHeight="100" />
                                    </div>
                                    
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        
	</div>
	
</form:form>
</div>
	
	
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		function validRegCode() {
			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/validateQQ',
				dataType : 'json',
				data : {
					QQ : $("#qq").val(),
					ID : $("#userId").val()
				},
				cache : false,
				success : function(data) {
					if (!data) {
						$("#QQ_validate").show();
					} else {
						$("#QQ_validate").hide()
					}
				},
				error : function() {
					top.$.jBox.tip('该QQ号码已存在', 'warning');
				}
			});
		}
		function validLoginName() {
			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/validateLoginName',
				dataType : 'json',
				data : {
					LoginName : $("#loginName").val(),
					ID : $("#userId").val()
				},
				cache : false,
				success : function(data) {
					if (!data) {
						$("#Name_validate").show();
					} else {
						$("#Name_validate").hide()
					}
				},
				error : function() {
					$.MsgBox.Alert("该用户名已存在", data.message)
				}
			});
		}

		$(function() {
			$("#btn-warning").click(
					function() {
						var isnul = true;
						if ($("#telphone").val() != ""
								&& $("#telphone").val() != null) {
							isnul = isnul && $("#telphone").valid({
								methods : "required|isTel"
							});
						}
						isnul = isnul && $("#loginName").valid({
							methods : "required"
						}); 
						if($("#companyname").val()!=''&&$("#companyname").val()!=null){
							isnul = isnul && $("#companyname").valid({
								methods : "ischinese"
							});
						}
						/* <c:if test="${fns:getUser().role.enname eq 'enterprise' && (userinfo.status!=1||userinfo.status!=2)}">
						isnul = isnul && $("#username").valid({
							methods : "required"
						});
						</c:if> */
						if ($("#email").val() != ""
								&& $("#email").val() != null) {
							isnul = isnul && $("#email").valid({
								methods : "isEmail"
							});
						}
						if ($("#qq").val() != "" && $("#qq").val() != null) {
							isnul = isnul && $("#qq").valid({
								methods : "isQQ"
							});
						}
						if (!isnul) {
							return false;
						}
						$.ajax({
							cache : true,
							type : "POST",
							url : "${wlpt}/wlpt/personal/saveUserInfo",
							data : $('#inputForm').serialize(),// 你的formid
							async : false,
							error : function(request) {
								$.MsgBox.Alert("保存提示", "保存失败");
							},
							success : function(data) {
								$.MsgBox.Alert("保存提示", data.message)
							}
						});
					});

			if ('${userinfo.user.photo}' != "") {
				$("#showimg").attr("src", '${userinfo.user.photo}');
				$("#showimg").attr("src", $("#nameImage").val());
			}
			if ("${userinfo.sex}" == 1) {
				$("#boy").attr("checked", true);
			} else {
				$("#girl").attr("checked", true);
			}

		});
	</script>
</body>
</html>
