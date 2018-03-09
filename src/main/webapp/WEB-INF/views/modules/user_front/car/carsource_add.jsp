<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>添加车辆</title>
	<link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
	<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
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
        
      	.form-control{
			border: 1px solid #ccc !important;
		}
		
		.car_addr{
		    height: 34px;
		    padding: 6px 12px;
		    font-size: 14px;
		    line-height: 1.42857143;
		    color: #555;
		    background-color: #fff;
		    background-image: none;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    /* -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
		    /* box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
		    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    box-shadow: none;
		    top:0px;
		}
		.car_addr[readonly], fieldset[disabled] .car_addr {
		    opacity: 1;
		    background: #fff;
		    box-shadow: none;
		    top:0px;
		}
		.img_switch {
		    position: relative;
		    top: 0px;
		}
    </style>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
	<div class="row">
       	<form:form action="${wlpt}/wlpt/carsource/saveCarSource" name="Form" id="Form" modelAttribute="carsource" method="post">
           <div class="col-lg-12">
           	 <div class="form_container">
           		<!--第一个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">
           				车辆详细信息
           			</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="form-group col-sm-4">
           					<div class="col-sm-5 control-label text-right">
           						车牌号码
           					</div>
           					<div class="col-sm-7" >
	           						<input type="hidden" id="id" name="id" value="${carsource.id }"/>
				                    <input type="hidden" id="status" name="status" value="${carsource.status}"/>
				                    <input type="hidden" id="carid" name="car.id" value="${carsource.car.id }"/>
				                    <input type="hidden" name="user.id" value="${carsource.user.id }"/>
				                    
                                    <input id="carnumber" name="carnumber" value="${carsource.car.carnumber }"  readonly="readonly" type="text"
                      				 class="form-control"/>
                                
           					</div>
           				</div>
           				
           				<div class="col-sm-4 form-group">
           					<div class="col-sm-5 control-label text-left">
           						车辆类型
           					</div>
           					<div class="col-sm-7">
           						<input id="cartype" value="${carsource.car.cartype}" readonly="readonly" type="text"
                      				 class="form-control"/>
           					</div>
           				</div>
           				
           				<div class="col-sm-4 form-group  has-unit">
           					<div class="col-sm-5 control-label text-left">
           						车辆载重
           					</div>
           					<div class="col-sm-7">
           						<input id="loadweight" value="${carsource.car.loadweight}" readonly="readonly" type="text"
                      				 class="form-control"/>
                      			<span class="unit">吨</span>
           					</div>
           				</div>
           			</div>
           		</div>
           		<!--第4个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车源信息(<span class="red">*</span>为必填项)</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					<span class="red">*</span>发车时间
            				</div>
            				<div class="col-sm-7 text-left">
            					<input name="departure" id="departuretime" type="text" readonly="readonly" maxlength="20"
	                            class="Wdate form-control" style="height: 34px;"
	                           value="<fmt:formatDate value="${carsource.departuretime}" pattern="yyyy-MM-dd"/>"
	                           onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate: '%y-%M-%d %H:%m'});"/>
	                           <i class="unit fa fa-calendar"></i>
            				</div>
           				</div>
           				<div class="col-sm-6 form-group">
            				<div class="col-sm-3 control-label text-left">
            					<span class="red">*</span>主营路线
            				</div>
            				<div class="col-sm-9">
            					<input type="hidden" name="mainroad" id="MAINROAD" value=""/>
            					<input type="text" name="fromaddress" id="fromAddress" value="${carsource.fromaddress }" readonly="readonly" class="car_addr" placeholder="请选择出发地" maxlength="100"/>
            					<img src="${ctxStatic }/front/img/switch_btn.png" alt="" class="img_switch"/>
            					<input type="text" name="toaddress" id="toAddress" value="${carsource.toaddress }" readonly="readonly" class="car_addr" placeholder="请选择目的地" maxlength="100"/>
            				</div>
           				</div>
           				
           			</div>
           		</div>
           		<!--第3个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">联系信息</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group">
            				<div class="col-sm-5 control-label text-left">
            					联系人
            				</div>
            				<div class="col-sm-7">
            					<input name="contactname" id="contactname" value="${carsource.contactname }"
                                     class="form-control" type="text" maxlength="20">
            				</div>
           				</div>
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					手机号
            				</div>
            				<div class="col-sm-7 text-left">
            					<input name="contactmobile" maxlength="11"
                                id="contactmobile" value="${carsource.contactmobile }"
                                   class="form-control" type="text">
            				</div>
           				</div>
           			</div>
           		</div>
           		
           		
           		<!--第6个面板-->
           		<div class="col-sm-12">
           			<div class="form-group" style="margin-bottom: 80px;">
	           			<div class="col-sm-2 control-label text-left"></div>
	          			<div class="col-sm-4">
		                    <input type="button" id="btnSubmit" class="btn btn-primary col-lg-12" value="保  存">
		                </div>
		                <div class="col-sm-4">
		                    <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
		                </div>
	                </div>
	                <!-- <div class="load">
			            <img src="/static/images/loading.gif">
			            <p>加载中</p>
			        </div> -->
	           	</div>
		       </div>
	         </div>
         </form:form>
     </div>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
   
    $("#fromAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
            }
            if (data.city) {
                if (data.city.NAME != data.province.NAME) {
                    str += data.city.NAME;
                }
            }
            $("#fromAddress").val(str).change();
        }
    });

    $("#toAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;

            }
            if (data.city) {
                if (data.city.NAME != data.province.NAME) {
                    str += data.city.NAME;
                }

            }
            $("#toAddress").val(str).change();
        }
    });
    
    $('#Form').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	fromaddress: {
                message: '始发地无效',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '始发地不能为空'
                    }
                }
            },toaddress: {
                message: '目的地无效',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '目的地不能为空'
                    }
                }
            },departure: {
            	trigger: "focus blur keyup change",
                validators: {
                	notEmpty: {
                        message: '发车时间不能为空'
                    }

                }
            },contactname: {
                message: '车主姓名无效',
                validators: {
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5]+$/,
                        message: '车主姓名只能中文'
                    }
                }
            },contactmobile: {
                validators: {
                	regexp: {
                        regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
                        message: '请填写正确的手机号码'
                    }
                }
            }
        }
    });
    
    
    
    $("#btnSubmit").click(function () {
        var bootstrapValidator = $("#Form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
        	$("#maskloading" , parent.document).show();
	        $.ajax({
	            url: "${wlpt}/wlpt/carsource/saveCarSource?" + $("#Form").serialize(),
	            dataType: 'json',
	            type: "post",
	            success: function (data) {
	                if (data.value.state == 1) {
	                    window.location.href = '${wlpt}/wlpt/carsource/carSource_list';
	                } else {
	                	$("#maskloading" , parent.document).hide();
	                    $.MsgBox.Alert("保存提示", data.value.message);
	                }
	            }
	        });
        }
    });

</script>
</body>
</html>
