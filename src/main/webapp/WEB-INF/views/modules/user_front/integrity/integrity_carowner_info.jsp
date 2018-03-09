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
    <link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
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
		.carnumbermin{
		    padding: 5px;
   			width: 30px;
		}	
    </style>
<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="${ctxStatic }/jquery-select2/3.4/select2.min.css" rel="stylesheet">
<link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">


<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/global.js" type="text/javascript" ></script>
    
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
<div class="row">
   <div class="col-lg-12" style="height: 35px;">
       <div class="panel">
           <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
               <ul class="nav nav-tabs tab-nav-tabs qiye_menu">
                   <li class="active"><a href="${wlpt }/wlpt/integrity/goCarWner_Info" >基本信息</a></li>
                   <li><a href="${wlpt }/wlpt/integrity/goCarWner_Picture" >资质信息</a></li>
               </ul>
           </div>
       </div>
    </div>
</div>
<div class="row">
   <div class="col-lg-12" >
       <div class="panel">
       	<div class="panel-body">
           <div class="tab-content">
           	<div class="tab-pane fade in active" id="basic">
                   <div class="form_container">
                       <h4 class="panel-heading ">完善基本资料 </h4>
                   </div>
                   <form:form id="inputForm" modelAttribute="integrityCarowner" action="${wlpt}/wlpt/integrity/carownerInfoSave" method="post">
					<form:hidden path="id"/>
					<form:hidden path="user.id"/>	
                   <div class="col-sm-12 mt-20 clearfix">
                   
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>车主姓名：</div>
                           <div class="col-sm-4 text-left pr-0">
                       			<form:input path="name" htmlEscape="false" maxlength="50" cssClass="form-control required"  />
                           </div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>联系人手机：</div>
                           <div class="col-sm-4 text-left pr-0">
                           	   <form:input path="linkphone" htmlEscape="false" maxlength="50" cssClass="required form-control" />
                           </div>
                           <div class="col-sm-4 validate_messege pl-5px pr-0 red" data-scroll-reveal="enter from the bottom after 1s">提示</div>
                       </div>
                       <div class="form-group col-sm-6">
                           <div class="col-sm-4 control-label text-right"><span class="red">*</span>车牌号码：</div>
                           
                           <div class="col-sm-1 text-left">
           						<form:hidden path="carnumber" id="carnumber"/>
			                    <input id="mininame" name="mininame" readonly="readonly" type="text"
                      				class="required form-control carnumbermin" />
           				   </div>
           				   <div class="col-sm-5 text-left">
           						<input type="text" id="number" name="number"
                      					class="required isCarNumber form-control" maxlength="6"/>
           				   </div>
                       </div>
                   </div>
                   <div class="col-lg-12">
                       <div class="form-group mb-80 mt-40">
                           <div class="col-sm-2 control-label text-left"></div>
                           <div class="col-sm-4">
                           	<button class="btn btn-primary col-lg-12" type="button" id="btn-warning">保  存</button>
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
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>

<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/msgbox.js"></script>

  <script>
  if('${integrityCarowner.carnumber}'!=''){
	    var carNumbers='${integrityCarowner.carnumber}';
		var MininName=carNumbers.substring(0, 1);
		var Number=carNumbers.substring(1,carNumbers.length);
		$("#mininame").val(MininName);
		$("#number").val(Number);
  }
  
  $('#inputForm').bootstrapValidator({
      message: 'This value is not valid',
      fields: {
   	   name: {
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
          },linkphone: {
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
          },mininame: {
              message: '车牌简称无效',
              validators: {
                  notEmpty: {
                      message: '车牌简称不能为空'
                  }
              }
          },number: {
              message: '车牌编号无效',
              validators: {
                  notEmpty: {
                      message: '车牌编号不能为空'
                  },carNumber:{
                  	message: '请填写正确车牌号码'
                  }
              }
          }
      }

  });
  
  
  
  
   $("#btn-warning").click(function () {
	   var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
       bootstrapValidator.validate();
       if (bootstrapValidator.isValid()){
    	   var carnumber = $("#mininame").val() + $("#number").val();
           $("#carnumber").val(carnumber);
    	   $.ajax({
               cache: true,
               type: "POST",
               url: "${wlpt}/wlpt/integrity/carownerInfoSave",
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
	    $(".qiye_menu li").removeClass("active")
	    $(this).addClass("active")
	    var type = $(this).attr("data-type");
	    $("#info"+type).show();
	    $("#info"+type).siblings("div").hide();
   })
   var msg = '${msg}';
   if(msg!=''){
	   $.MsgBox.Alert("保存提示",'${msg}');
   }
 //获取车牌所属地区
	getArea();
	function getArea() {
		$.ajax({
            cache: true,
            type: "POST",
            url: "${wlpt}/wlpt/chinaarea/getArea",
            data: {parentCode:"0"},
            dataType : 'json',
            async: false,
            success: function (data) {
            	if (data) {
					var adds = data;
					$("#mininame").gridSelector({
						idKey: "code",
						textKey:"mininame",
						cellWidth:50,
						cellHeight:28,
						data: adds,
						colNum: 7,
						multiSelect:false,
						complete:function(data){
							if(data){
								if(data){
									$("#mininame").val(data.mininame);
								}
							}
						}
					});
				}
            }
        });
		
	}
</script>

</body>
</html>