<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>企业诚信信息</title>
    
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
<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="${ctxStatic }/jquery-select2/3.4/select2.min.css" rel="stylesheet">
<link href="${ctxStatic }/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet">
<link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
<link href="${ctxStatic }/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">


<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/global.js" type="text/javascript" ></script>
    <script type="text/javascript">
    $(document).ready(function () {
        $("#inputForm").validate({
        	rules: {
			},
			messages: {
				
			},
            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
    </script>
</head>

<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
<div class="row">
   <div class="col-lg-12" style="height: 35px;">
   		<div class="panel">
           <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
               <ul class="nav nav-tabs tab-nav-tabs qiye_menu">
                   <li><a href="${wlpt }/wlpt/integrity/goEnterprise_Info" >基本信息</a></li>
                   <li class="active"><a href="${wlpt }/wlpt/integrity/goEnterprise_Picture" >资质信息</a></li>
               </ul>
           </div>
       </div>
    </div>
</div>
<div class="row">
   <div class="col-lg-12">
       <div class="panel">
       <div class="panel-body">
           <div class="tab-content">
           		<div class="tab-pane fade in active" id="company-basic">
           			<!-- 公司资质 -->
					<form:form id="inputForm" modelAttribute="integrityEnterprise" action="${wlpt}/wlpt/integrity/entrprsePictureSave" method="post" >
					<form:hidden path="id"/>
					<form:hidden path="user.id"/>
					<input type="hidden" name="status" value="1" /> 
					<sys:wlptmessage content="${message}"/>	
                   <div class="panel">
                       <div class="form_container">
                           <h4 class="panel-heading ">上传资质<span class="red">（公司资质属于保密内容，不对外展示，请放心。每张图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式）</span></h4>
                       </div>
                       <div class="panel-body">
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">身份证：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="idcard" path="idcard" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="idcard" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">运营执照：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="businesslicense" path="businesslicense" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="businesslicense" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">道路运输许可证：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="roadtransport" path="roadtransport" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="roadtransport" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">房产证：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                      <!--  <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="certificateproperty" path="certificateproperty" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="certificateproperty" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">档口与法人合照：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="stallscorporate" path="stallscorporate" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="stallscorporate" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">办公场所：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="officespace" path="officespace" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="officespace" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">仓储场所：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="storageplace" path="storageplace" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="storageplace" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">员工合照：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="staffphoto" path="staffphoto" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="staffphoto" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">银行开户许可证：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="bankopening" path="bankopening" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="bankopening" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">自有车辆证明：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="owncar" path="owncar" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="owncar" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
                           <div class="form-group col-sm-6">
                               <div class="col-sm-4 control-label text-right">上游运输合同：</div>
                               <div class="col-sm-8 text-left">
                                   <div class="text-left">
                                       <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                   </div>
                                   <ul class="upimg-list clearfix mt-10">
                                       <form:hidden id="upstreamcontract" path="upstreamcontract" htmlEscape="false" maxlength="255"
					                                 class="input-xlarge"/>
					                    <sys:ckfinder input="upstreamcontract" type="images" uploadPath="/integrity" selectMultiple="true"
					                                  maxWidth="100"
					                                  maxHeight="100" maxnumber="4"/>
                                   </ul>
                               </div>
                           </div>
							
                           <div class="col-lg-12">
                               <div class="form-group mb-80 mt-40">
                                   <div class="col-sm-2 control-label text-left"></div>
                                   <div class="col-sm-4">
                                       <button class="btn btn-primary col-lg-12" type="submit"  id="btn-warning">提  交</button>
                                   </div>
                                   <div class="col-sm-4">
				                        <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
				                    </div>
                               </div>
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
  <script>
    $(".qiye_menu li").on("click",function(){
	    $(".qiye_menu li").removeClass("qiye_menu_1")
	    $(this).addClass("qiye_menu_1")
	    var type = $(this).attr("data-type");
	    $("#info"+type).show();
	    $("#info"+type).siblings("div").hide();
   })
   var msg = '${msg}';
   if(msg!=''){
	   jBox.tip('${msg}','warning');
   }
   
</script>
<script type="text/javascript">

    $(function () {
       
        $("#btn-warning2").click(function () {
        	$('#inputForm'+type).submit();
        });
       
       
      
    });
</script>
</body>
</html>