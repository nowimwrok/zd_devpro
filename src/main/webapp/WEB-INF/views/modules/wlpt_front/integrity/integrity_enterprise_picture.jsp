<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>企业诚信信息</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/top_menu.css">
    
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
    }
    ul p span a input td{
        font-family: "微软雅黑";
    }
    .qiye_infor_right img {
	    width: 100px;
	    height: 100px;
	}	
	
    </style>
<link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
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

<body>
<ul class="qiye_menu">
        <li data-type="1" ><a href="${wlpt }/wlpt/integrity/goEnterprise_Info" target="content" style="color: #000;">基本信息</a></li>
        <li data-type="2" class="qiye_menu_1">企业资质</li>
    </ul>


<!-- 公司资质 -->
<form:form id="inputForm" modelAttribute="integrityEnterprise" action="${wlpt}/wlpt/integrity/entrprsePictureSave" method="post" class="form-horizontal">
<form:hidden path="id"/>
<form:hidden path="user.id"/>
<input type="hidden" name="status" value="1" /> 
<sys:wlptmessage content="${message}"/>	
<p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">上传</span><span class="title_orange">资质</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div class="qualification_wrap">
    	<p>公司资质属于保密内容，不对外展示，请放心。每张图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式</p>
    	
       

        <div class="photo_list">
            <p class="photo_title_1">身份证：</p>
            <div class="photo_type">
                <form:hidden id="idcard" path="idcard" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="idcard" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        
         <div class="photo_list">
            <p class="photo_title_1">运营执照：</p>
            <div class="photo_type">
                <form:hidden id="businesslicense" path="businesslicense" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="businesslicense" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        
        <div class="photo_list">
            <p class="photo_title_1">道路运输许可证：</p>
            <div class="photo_type">
                <form:hidden id="roadtransport" path="roadtransport" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="roadtransport" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">房产证：</p>
            <div class="photo_type">
                <form:hidden id="certificateproperty" path="certificateproperty" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="certificateproperty" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">档口与法人合照：</p>
            <div class="photo_type">
                <form:hidden id="stallscorporate" path="stallscorporate" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="stallscorporate" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">办公场所：</p>
            <div class="photo_type">
                <form:hidden id="officespace" path="officespace" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="officespace" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">仓储场所：</p>
            <div class="photo_type">
                <form:hidden id="storageplace" path="storageplace" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="storageplace" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">员工合照：</p>
            <div class="photo_type">
                <form:hidden id="staffphoto" path="staffphoto" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="staffphoto" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">银行开户许可证：</p>
            <div class="photo_type">
                <form:hidden id="bankopening" path="bankopening" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="bankopening" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">自有车辆证明：</p>
            <div class="photo_type">
                <form:hidden id="owncar" path="owncar" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="owncar" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <div class="photo_list">
            <p class="photo_title_1">上游运输合同：</p>
            <div class="photo_type">
                <form:hidden id="upstreamcontract" path="upstreamcontract" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="upstreamcontract" type="images" uploadPath="/integrity" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
            </div>
        </div>
        <button class="btn btn-warning btn-warnings"  type="submit"  id="btn-warning">保存</button>
    </div>
</form:form>

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