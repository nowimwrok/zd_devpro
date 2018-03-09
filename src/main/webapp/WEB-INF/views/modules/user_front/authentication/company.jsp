<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
<title>企业认证</title>
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

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
	<div class="row">
		<div class="col-lg-12">
            <div class="panel">
                <div class="panel-body">
                    <div class="tab-content">
                    	<div class="tab-pane fade in active" id="basic">
                            <div class="form_container">
                                <h4 class="panel-heading ">认证信息</h4>
                            </div>
                            <form:form id="inputForm" modelAttribute="userCompany"
							action="${wlpt}/wlpt/authentication/company_authentication"
							method="post">
                            <div class="col-sm-12 mt-20 clearfix">
                            	<div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司名称：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                		<form:input id="companyname"
											path="companyname" htmlEscape="false" maxlength="20"
											class="required" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>营业执照号：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:input id="businesslicencenum" path="businesslicencenum"
											htmlEscape="false" maxlength="20" class="required" cssClass="form-control"/>
                                    	
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司联系人：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:input id="legalperson" path="legalperson" htmlEscape="false" maxlength="15"
											class="required" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>手机号码：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:input id="headermobile" path="headermobile" htmlEscape="false" maxlength="11"
										class="required" value="${userCompany.user.phone}" readonly="true" cssClass="form-control"/>
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司地址：</div>
                                    <div class="col-sm-4 text-left pr-0">
			                            <form:input id="provinceCityDistrict" path="provinceCityDistrict" onmouseover="this.title=this.value"
										htmlEscape="false" maxlength="11" class="required" readonly="true" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>详细地址：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:textarea id="companyaddress"
										path="companyaddress" htmlEscape="false" onmouseover="this.title=this.value"
										rows="1" cols="50" maxlength="50" class="input-xxlarge required" cssClass="form-control"/>	
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right">营业执照：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="businesslicencenumimg"
												path="usercompanypicture.businesslicencenumimg"
												htmlEscape="false" maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${userCompany.user.userinfo.status==1||userCompany.user.userinfo.status==2}">
													<sys:ckfinder input="businesslicencenumimg" type="images"
														uploadPath="/userpicture" selectMultiple="false" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="businesslicencenumimg" type="images"
														uploadPath="/userpicture" selectMultiple="false" maxWidth="165"
														maxHeight="165" btnName="上传营业执照" />
												</c:otherwise>
											</c:choose>
                                        </ul>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right">运输许可证：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="transportcardimg"
												path="usercompanypicture.transportcardimg" htmlEscape="false"
												maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${userCompany.user.userinfo.status==1||userCompany.user.userinfo.status==2}">
													<sys:ckfinder input="transportcardimg" type="images"
														uploadPath="/userpicture" selectMultiple="false" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="transportcardimg" type="images"
														uploadPath="/userpicture" selectMultiple="false" maxWidth="165"
														maxHeight="165" btnName="上传运输许可证" />
												</c:otherwise>
											</c:choose>
                                        </ul>
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right">身份证正反面：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传2张，支持JPG、JPEG、PNG格式</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="idcardimg" path="usercompanypicture.idcardimg"
												htmlEscape="false" maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${userCompany.user.userinfo.status==1||userCompany.user.userinfo.status==2}">
													<sys:ckfinder input="idcardimg" type="images"
														uploadPath="/userpicture" selectMultiple="true" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="idcardimg" type="images"
														uploadPath="/userpicture" selectMultiple="true" maxWidth="165"
														maxHeight="165" maxnumber="2" btnName="上传身份证正反面" />
												</c:otherwise>
											</c:choose>
                                        </ul>
                                    </div>
                                </div>
                                </div>
                            </div>

                            <div class="col-lg-12" style="margin-bottom: 105px;">
                                <div class="form-group mb-100 mt-40">
                                    <div class="col-sm-4 control-label text-left"></div>
                                    <div class="col-sm-4">
                                    	<button type="button" class="btn btn-primary col-lg-12" 
										onclick="save()" id="btn-warning">申请认证</button>
										<c:if test="${us.userinfo.status=='3' and not empty us}">
											<div style="width: 100%; clear: both; height: 20px;color: red;">
												您的上一次审核不通过,审核结果:${quality.certifycomment }
											</div>
										</c:if>
                                    </div>
                                </div>
                            </div>
                            </form:form>
                        </div>
                    	
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
	<script type="text/javascript">
	<c:if test="${us.userinfo.status=='3' and not empty us}">
		$.MsgBox.Alert("上传提示", "您的上一次审核不通过,审核结果:${quality.certifycomment }");
	
	</c:if>
		$(function() {
			
		    $('#inputForm').bootstrapValidator({
		        message: 'This value is not valid',
		        fields: {
		        	companyname: {
		                message: '公司名称无效',
		                validators: {
		                    notEmpty: {
		                        message: '公司名称不能为空'
		                    },
		                    stringLength: {
		                        min: 3,
		                        max: 30,
		                        message: '公司名称必须大于3，小于30个字'
		                    },
		                    userName: {
		                        message: '请填写正确的企业名称'
		                    }
		                }
		            },legalperson: {
		                message: '公司联系人无效',
		                validators: {
		                    notEmpty: {
		                        message: '公司联系人不能为空'
		                    },
		                    stringLength: {
		                        min: 2,
		                        max: 30,
		                        message: '公司联系人必须大于1，小于30个字'
		                    },
		                    regexp: {
		                        regexp: /^[\u4e00-\u9fa5]+$/,
		                        message: '公司联系人只能中文'
		                    }
		                }
		            },headermobile: {
		                message: '请填写正确的手机号码',
		                validators: {
		                	notEmpty: {
		                        message: '联系人手机不能为空'
		                    },integer: {
		                        message: "请填写正确的手机号码"
		                    },regexp: {
	                            regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
	                            message: '请填写正确的手机号码'
	                        }
		                }
		            },businesslicencenum: {
		                message: '营业执照号无效',
		                validators: {
		                    notEmpty: {
		                        message: '营业执照号不能为空'
		                    },regexp: {
	                            regexp: /^[0-9a-zA-Z]+$/,
	                            message: '必须是数字或数字+字母'
	                        }
		                }
		            },legalidcardnum: {
		                message: '法人身份证无效',
		                validators: {
		                    notEmpty: {
		                        message: '法人身份证不能为空'
		                    },integer: {
		                        message: "请填写正确的身份证号码"
		                    },stringLength: {
		                        min: 16,
		                        max: 19,
		                        message: '法人身份证必须大于1，小于19个字'
		                    }
		                }
		            },provinceCityDistrict: {
		                message: '公司地址无效',
		                trigger:"change",
		                validators: {
		                    notEmpty: {
		                        message: '公司地址不能为空'
		                    }
		                }
		            },companyaddress: {
		                message: '详细地址无效',
		                validators: {
		                    notEmpty: {
		                        message: '详细地址不能为空'
		                    }
		                }
		            }
		        }

		    });
			
			window.save = function() {
				
				
				if ($("#businesslicencenumimg").val() == null
						|| $("#businesslicencenumimg").val() == ""
						|| $("#transportcardimg").val() == null
						|| $("#transportcardimg").val() == ""
						|| $("#idcardimg").val() == null
						|| $("#idcardimg").val() == "") {
					$.MsgBox.Alert("上传提示", "请上传完整图片");
					return false;
				}
				var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
                bootstrapValidator.validate();
                if (bootstrapValidator.isValid()) {
					
				
				$("#btn-warning").attr("disabled", "disabled");
				$("#btn-warning").html("正在提交中...");
				$.ajax({
						cache : true,
						type : "POST",
						url : "${wlpt}/wlpt/authentication/company_authentication",
						data : $('#inputForm').serialize(),// 你的formid
						async : false,
						error : function(request) {
							$.MsgBox.Alert("系统提示", "数据异常,请联系平台人员");
						},
						success : function(data) {
							$.MsgBox.Alert("保存提示", data.message);
							window.location.href = "${wlpt}/wlpt/personal/authentication";

						}
					});
                }
			}

			var status = '${userCompany.user.userinfo.status}';
			if (status == '1' || status == '2') {
				$("#companyname").attr("readonly", "true");
				$("#businesslicencenum").attr("readonly", "true");
				$("#legalperson").attr("readonly", "true");
				$("#headermobile").attr("readonly", "true");
				$("#provinceCityDistrict").attr("disabled", "disabled");
				$("#companyaddress").attr("readonly", "true");
				
				$("#btn-warning").attr("disabled", "true");
				$("#btn-warning").css("background-color", "#ccc");
				$("#btn-warning").css("border-color", "#ccc");
				if (status == '1') {
					$("#btn-warning").html("已申请认证");
				}else{
					$("#btn-warning").html("已认证");
				}
			}

			//公司地址加载地址控件
			initAddress("#provinceCityDistrict");
			//設置地址插件
			function initAddress(id) {
				$(id).PCC({
					hasCounty : true,
					width : 360,
					height : 220,
					url : "${wlpt}/wlpt/chinaarea/getArea",
					closeIcon : "/static/images/close_hover.png",
					complete : function(data) {
						var str = "";
						if (data.province) {
							str += data.province.NAME + "";
							$(id).val(str);
						}
						if (data.city) {
							str += data.city.NAME + "";
							$(id).val(str);
						}
						if (data.county) {
							str += data.county.NAME + "";
							$(id).val(str);
						}
						if (str != "") {
							$(id).val(str).change();
						} else {
							$(id).val("").change();
						}

					}
				});
			}
		});
	</script>
</body>
</html>
