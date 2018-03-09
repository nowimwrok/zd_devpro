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
<link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
<link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">


<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/global.js" type="text/javascript" ></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
    
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
<div class="row">
   <div class="col-lg-12" style="height: 35px;">
       <div class="panel">
           <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
               <ul class="nav nav-tabs tab-nav-tabs qiye_menu">
                   <li class="active"><a href="${wlpt }/wlpt/integrity/goEnterprise_Info" >基本信息</a></li>
                   <li><a href="${wlpt }/wlpt/integrity/goEnterprise_Picture" >资质信息</a></li>
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
           	<div class="tab-pane fade in active" id="basic">
                   <div class="form_container">
                       <h4 class="panel-heading ">完善基本资料</h4>
                   </div>
                   <form:form id="inputForm" modelAttribute="integrityEnterprise" action="${wlpt}/wlpt/integrity/entrprseInfoSave" method="post" >
					<form:hidden path="id"/>
					<form:hidden path="user.id"/>	
                   <div class="col-sm-12 mt-20 clearfix">
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司名称：</div>
                           <div class="col-sm-4 text-left pr-0">
	                       		<input id="companyname" name="companyname" value="${not empty integrityEnterprise.companyname?integrityEnterprise.companyname:userCompany.companyname}" Class="form-control"/>
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>企业法人：</div>
                           <div class="col-sm-4 text-left pr-0">
                           		<input id="name" name="name" value="${not empty integrityEnterprise.name?integrityEnterprise.name:userCompany.legalperson}" class="form-control"/>
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>法人现地址：</div>
                           <div class="col-sm-4 text-left pr-0">
	                           	<input name="persionaladdress" id="persionaladdress" value="${integrityEnterprise.persionaladdress}" class="form-control"/>
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司成立时间：</div>
                           <div class="col-sm-4 text-left pr-0">
	                           	<input id="operationyearstime" name="operationyearstime" type="text" style="height: 34px;" readonly="readonly" maxlength="20" class="form-control Wdate "
								value="<fmt:formatDate value="${not empty integrityEnterprise.operationyearstime?integrityEnterprise.operationyearstime:userCompany.setuptime}" pattern="yyyy-MM-dd"/>"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});"/>
                           </div>
                           <div class="col-sm-4 validate_messege pl-5px pr-0 red" data-scroll-reveal="enter from the bottom after 1s">提示</div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>公司地址：</div>
                           <div class="col-sm-4 text-left pr-0">
	                           	  <input name="companyaddress" id="companyaddress" value="${not empty integrityEnterprise.companyaddress?integrityEnterprise.companyaddress:userCompany.provinceCityDistrict}" class="form-control"/>
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right">企业电话：</div>
                           <div class="col-sm-4 text-left pr-0">
                           		<input id="linkphone" name="linkphone" value="${integrityEnterprise.linkphone}" class="form-control"/>
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                            <div class="col-sm-4 control-label text-right">企业简介：</div>
                            <div class="col-sm-8 text-left pr-0">
                            	<form:textarea path="companyinfo" htmlEscape="false" cols="50" rows="5" maxlength="500" cssClass="form-control" style="width:100%;padding: 10px;"/>
                            </div>
                        </div>
                   </div>
                   <div class="col-lg-12">
                       <div class="form-group mb-80 mt-40">
                           <div class="col-sm-2 control-label text-left"></div>
                           <div class="col-sm-4">
                           	<input type="button" id="btn-warning1" class="btn btn-primary col-lg-12" value="保  存">
                           </div>
                           <div class="col-sm-4">
		                        <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
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

<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/msgbox.js"></script>
  <script>
  /* if('${type}'!=''){
	  $(".qiye_menu li").qe(${type}).click();
  }
   */
   
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
           },name: {
               message: '企业法人无效',
               validators: {
                   notEmpty: {
                       message: '企业法人不能为空'
                   },
                   stringLength: {
                       min: 2,
                       max: 30,
                       message: '企业法人必须大于1，小于30个字'
                   },
                   regexp: {
                       regexp: /^[\u4e00-\u9fa5]+$/,
                       message: '企业法人只能中文'
                   }
               }
           },operationyearstime: {
               message: '公司成立时间无效',
               validators: {
                   notEmpty: {
                       message: '公司成立时间不能为空'
                   }
               }
           },persionaladdress: {
               message: '法人地址无效',
               validators: {
                   notEmpty: {
                       message: '法人地址不能为空'
                   }
               }
           },companyaddress: {
               message: '公司地址无效',
               validators: {
                   notEmpty: {
                       message: '公司地址不能为空'
                   }
               }
           },linkphone: {
               message: '请填写正确的电话号码',
               validators: {
                   tel: {
                       message: "请填写正确的电话号码,例如:020-666666"
                   }
               }
           }
       }

   });
   
   
   
   $("#btn-warning1").click(function() {
	   var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
       bootstrapValidator.validate();
       if (bootstrapValidator.isValid()){
    	   $.ajax({
               cache: true,
               type: "POST",
               url: "${wlpt}/wlpt/integrity/entrprseInfoSave",
               data: $('#inputForm').serialize(),// 你的formid
               async: false,
               error: function (request) {
                   $.MsgBox.Alert("保存提示", "保存失败");
               }
               ,
               success: function (data) {
                   $.MsgBox.Alert("保存提示",data.message);
               }
           });
		}
   });
    $(".qiye_menu li").on("click",function(){
	    $(".qiye_menu li").removeClass("qiye_menu_1")
	    $(this).addClass("qiye_menu_1")
	    var type = $(this).attr("data-type");
	    $("#info"+type).show();
	    $("#info"+type).siblings("div").hide();
   })
   var msg = '${msg}';
   if(msg!=''){
	   $.MsgBox.Alert("保存提示",'${msg}');
   }
   //設置地址插件
		$("#persionaladdress").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
					$("#persionaladdress").val(str);
				} 
				if (data.city) {
					str += data.city.NAME + "";
					$("#persionaladdress").val(str);
				}
				if (data.county) {
					str += data.county.NAME + "";
					$("#persionaladdress").val(str);
				}
				if (str!=""){
					$("#persionaladdress").val(str);
				}else{
					$("#persionaladdress").val("");
				}

			}
		});
		$("#companyaddress").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
					$("#companyaddress").val(str);
				} 
				if (data.city) {
					str += data.city.NAME + "";
					$("#companyaddress").val(str);
				}
				if (data.county) {
					str += data.county.NAME + "";
					$("#companyaddress").val(str);
				}
				if (str!=""){
					$("#companyaddress").val(str);
				}else{
					$("#companyaddress").val("");
				}

			}
		});
</script>
<script type="text/javascript">

   
</script>
</body>
</html>