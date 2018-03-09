<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
<title>实名认证</title>
<style type="text/css">
        .goods_details .form-group{
            margin-left:2.5%;
            margin-right:2.5%;
        }
         .loading{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .loading img{
            margin-top: 25%;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
	<div class="row">
		<div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <div class="panel-heading">
                        实名认证
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 form-horizontal">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
	                            <c:choose>
		                            <c:when test="${user.role.enname eq 'enterprise'}">企业认证</c:when>
									<c:when test="${user.role.enname eq 'carowner'}">车主认证</c:when>
									<c:when test="${user.role.enname eq 'goodsowner'}">个人认证</c:when>
									<c:otherwise>个人认证</c:otherwise>
								</c:choose>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
                            	<c:choose>
                            		<c:when test="${user.userinfo.status==0 or user.userinfo.status==3}">
                            			<img src="${ctxStatic}/front/img/has_auth_0.png" class="pt-5px">
                            		</c:when>
                            		<c:when test="${user.userinfo.status==1}">
                            			<img src="${ctxStatic}/front/img/has_auth_1.png" class="pt-5px">
                            		</c:when>
                            		<c:when test="${user.userinfo.status==2}">
                            			<img src="${ctxStatic}/front/img/has_auth_2.png" class="pt-5px">
                            		</c:when>
                            		<c:otherwise>
                            			<img src="${ctxStatic}/front/img/has_auth_0.png" class="pt-5px">
                            		</c:otherwise>
                            	</c:choose>
                            	<%-- <c:if test="${user.userinfo.status==0}">未认证</c:if>
                            	<c:if test="${user.userinfo.status==1}">认证中</c:if> 
                            	<c:if test="${user.userinfo.status==2}">已认证</c:if> 
                            	<c:if test="${user.userinfo.status==3}">未认证</c:if> 
                            	<c:if test="${user.userinfo.status==null}">未认证</c:if> --%>
                            	<!-- <img src="img/has_auth.png" class="pt-5px"> -->
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                            	<c:choose>
									<c:when test="${user.role.enname eq 'enterprise'}">
										<button class="btn btn-primary" onclick="enterprise()">
									</c:when>
									<c:when test="${user.role.enname eq 'carowner'}">
										<button class="btn btn-primary" onclick="carowner()">
									</c:when>
									<c:when test="${user.role.enname eq 'goodsowner'}">
										<button class="btn btn-primary" onclick="goodsowner()">
									</c:when>
									<c:otherwise>
										<button class="btn btn-primary" onclick="goodsowner()">
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${user.userinfo.status==2 || user.userinfo.status==1}">认证信息</c:when>
									<c:otherwise>申请认证</c:otherwise>
								</c:choose>
								</button>
                            </div>
                    </div>
                </div>
            </div>

            <div class="panel clearfix">
                <div class="form_container">
                    <div class="panel-heading">
                        重要说明
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 form-horizontal">
                        <p>1、您的资料可能会被提交到国家公安机关及其下属单位进行证件真实性核实</p>
                        <p>2、身份认证一旦通过，不能够取消、删除、修改</p>
                        <p>3、企业身份认证一旦通过将与您对应的唯一账户进行绑定，企业身份具有唯一性</p>
                    </div>
                </div>
            </div>

            <div class="panel clearfix">
                <div class="form_container">
                    <div class="panel-heading">
                        个人认证示例
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 form-horizontal">
                        <div class="panel-body">
                            <div class="col-sm-4 form-horizontal">
                                <div class="text-center">
                                    <img src="/static/images/wlptfront/police.png" style="width:65%;">
                                    <p class="text-center">本人手持身份证正面头部照</p>
                                </div>
                            </div>
                            <div class="col-sm-8 pt-30px pb-30px" style="border-left: 1px solid #eff2f7;width:65%;margin-left: 1%;">
                                <p><strong>需要本人手持身份证合影，注意以下几点：</strong></p>
                                <p>1、建议在光线充足的环境下合影，保证照片清晰不模糊 </p>
                                <p>2、身份证正面在前，人在后，证件不能遮挡面部，保证证件清晰不模糊 </p>
                                <p>3、需要完整的身份证正面，保证身份证边缘处于图片内部，姓名、证件号码、照片清晰 </p>
                                <p>4、可以将照片向前伸，将证件靠近相机镜头，对焦在证件上 </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel clearfix">
                <div class="form_container">
                    <div class="panel-heading">
                        企业认证示例
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 form-horizontal">
                        <div class="panel-body">
                            <div class="col-sm-4 form-horizontal">
                                <div class="text-center">
                                    <img src="/static/images/wlptfront/license1.png" style="width:65%;">
                                    <p>企业营业执照正面照</p>
                                </div>
                            </div>
                            <div class="col-sm-8 pt-80px pb-80px" style="border-left: 1px solid #eff2f7;width:65%;margin-left: 1%;">
                                <p><strong>需要企业营业执照最新版本，注意以下几点：</strong></p>
                                <p>1、最好上传企业营业执照的色彩电子版 </p>
                                <p>2、营业执照复印件电子版需要加盖红色鲜章，并标注作卓大物流资质认证用途 </p>
                                <p>3、保证营业执照是最新版本，在工商局能够查询到，并且和执照上显示的信息一致</p>
                                <p>4、拍照时营业执照纸张边界应处于照片内，右上角“编号”需显示出来 </p>
                                <p>5、电子版需要保证营业执照的所以文字、二维码和登记机关签章都清晰可辨 </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel clearfix" style="margin-bottom:70px;">
                <div class="form_container">
                    <div class="panel-heading">
                        后续
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 form-horizontal">
                        <p>1、我们有专门的工作人员为您提交的资料进行核对认证</p>
                        <p>2、如果您没有资质认证，工作人员会通过客服热线与您联系</p>
                    </div>
                </div>
            </div>
        </div>
	</div>
</div>



	<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"
		type="text/javascript"></script>
	<script
		src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script type="text/javascript"
		src="${ctxStatic}/modules/wlpt/include/jqthumb.min.js"></script>
	<script type="text/javascript">
		var iscompleteinfo = '${user.userinfo.iscompleteinfo}';
		function enterprise() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/tocpy_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请点击顶部登录名，下拉框中‘个人设置’完善信息方可申请认证");
			}
		}
		function carowner() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/tocar_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请点击顶部登录名，下拉框中‘个人设置’完善信息方可申请认证");
			}
		}
		function goodsowner() {
			if (iscompleteinfo == '1') {
				window.location.href = "${wlpt}/wlpt/authentication/topersonal_authentication";
			} else {
				$.MsgBox.Alert("温馨提示!", "请点击顶部登录名，下拉框中‘个人设置’完善信息方可申请认证");
			}
		}
		$('.th_fo_right img').jqthumb({
			width : 250,
			height : 280,
			after : function(imgObj) {
				imgObj.css('opacity', 0).animate({
					opacity : 1
				}, 1000);
			}
		});
	</script>
</body>
</html>