<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
	<title>车主认证</title>
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
                            <form:form id="inputForm" modelAttribute="user"
								action="${wlpt}/wlpt/user/save" method="post">
                            <div class="col-sm-12 mt-20 clearfix">
                            	<div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>车主姓名：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:input path="driver.drivername" id="drivername" htmlEscape="false"
											maxlength="10" cssClass="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>身份证号码：</div>
                                    <div class="col-sm-4 text-left pr-0">
                                    	<form:input path="driver.idcardnum" id="idcardnum" htmlEscape="false"
											maxlength="18" cssClass="form-control"/>
                                    	
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-8">
                                    <div class="col-sm-3 control-label text-right" style="width: 24.7%;"><span class="red">*</span>手机号码：</div>
                                    <div class="col-sm-3 text-left pr-0" style="width: 24.7%;">
                                    	<form:input path="driver.drivermobile" id="drivermobile" htmlEscape="false"
											maxlength="11" value="${user.phone}" readonly="true" cssClass="form-control"/>
                                    </div>
                                </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right">驾驶证：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="driverlicimg" path="driver.driverlicimg"
												htmlEscape="false" maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${user.userinfo.status==1||user.userinfo.status==2}">
													<sys:ckfinder input="driverlicimg" type="images"
														uploadPath="/driver" selectMultiple="false" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="driverlicimg" type="images"
														uploadPath="/driver" selectMultiple="false" maxWidth="165"
														maxHeight="165" maxnumber="2" btnName="上传驾驶证" />
												</c:otherwise>
											</c:choose>
                                        </ul>
                                    </div>
                                </div>
                                
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-4 control-label text-right">司机头像：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="driverheadimg" path="driver.driverheadimg"
												htmlEscape="false" maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${user.userinfo.status==1||user.userinfo.status==2}">
													<sys:ckfinder input="driverheadimg" type="images"
														uploadPath="/driver" selectMultiple="false" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="driverheadimg" type="images"
														uploadPath="/driver" selectMultiple="false" maxWidth="165"
														maxHeight="165" btnName="上传司机头像" />
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
                                            <form:hidden id="idcardimg" path="driver.idcardimg"
												htmlEscape="false" maxlength="255" class="input-xlarge" />
											<c:choose>
												<c:when
													test="${user.userinfo.status==1||user.userinfo.status==2}">
													<sys:ckfinder input="idcardimg" type="images"
														uploadPath="/driver" selectMultiple="true" maxWidth="165"
														maxHeight="165" readonly="true" />
												</c:when>
												<c:otherwise>
													<sys:ckfinder input="idcardimg" type="images"
														uploadPath="/driver" selectMultiple="true" maxWidth="165"
														maxHeight="165" maxnumber="2" btnName="上传身份证正反面" />
												</c:otherwise>
											</c:choose>
                                        </ul>
                                    </div>
                                </div>
                                </div>
                            </div>

                            <div class="col-lg-12" style="margin-bottom: 105px;">
                                <div class="form-group mb-80 mt-40">
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
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
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
		        	'driver.drivername': {
		                message: '车主姓名无效',
		                validators: {
		                    notEmpty: {
		                        message: '车主姓名不能为空'
		                    },
		                    stringLength: {
		                        min: 2,
		                        max: 30,
		                        message: '车主姓名必须大于1，小于30个字'
		                    },
		                    regexp: {
		                        regexp: /^[\u4e00-\u9fa5]+$/,
		                        message: '车主姓名只能中文'
		                    }
		                }
		            },'driver.drivermobile': {
		                message: '请填写正确的手机号码',
		                validators: {
		                	notEmpty: {
		                        message: '手机号码不能为空'
		                    },integer: {
		                        message: "请填写正确的手机号码"
		                    },regexp: {
	                            regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
	                            message: '请填写正确的手机号码'
	                        }
		                }
		            },'driver.idcardnum': {
		                message: '身份证号无效',
		                validators: {
		                    notEmpty: {
		                        message: '身份证号不能为空'
		                    },regexp:{
		                    	regexp:/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
		                    	message: "请填写正确的身份证号码"
		                    },stringLength: {
		                        min: 15,
		                        max: 19,
		                        message: '身份证号必须大于14，小于19个字'
		                    }
		                }
		            }
		        }

		    });
			
			window.save = function() {

				if ($("#idcardimg").val() == null
						|| $("#idcardimg").val() == ""
						|| $("#driverlicimg").val() == null
						|| $("#driverlicimg").val() == ""
						|| $("#driverheadimg").val() == null
						|| $("#driverheadimg").val() == "") {
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
							url : "${wlpt}/wlpt/authentication/percar_authentication",
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

			var status = '${user.userinfo.status}';
			if (status == '1' || status == '2') {
				$("#divbtm").show();
				$("#drivername").attr("readonly", "true");
				$("#idcardnum").attr("readonly", "true");
				$("#drivermobile").attr("readonly", "true");
				$("#btn-warning").attr("disabled", "true");
				$("#btn-warning").css("background-color", "#ccc");
				$("#btn-warning").css("border-color", "#ccc");
				if (status == '1') {
					$("#btn-warning").html("已申请认证");
				}else{
					$("#btn-warning").html("已认证");
				}
			}
		});
	</script>
</body>
</html>
