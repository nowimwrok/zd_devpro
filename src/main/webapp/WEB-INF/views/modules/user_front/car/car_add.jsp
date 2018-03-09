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
       	<form:form action="${wlpt}/wlpt/car/saveCar" name="Form" id="Form" modelAttribute="car" method="post">
           <div class="col-lg-12">
           	 <div class="form_container">
           		<!--第一个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">
           				车辆详细信息(<span class="red">*</span>为必填项)
           			</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="form-group col-sm-4">
           					<div class="col-sm-5 control-label text-right">
           						<span class="red">*</span>车牌号码
           					</div>
           					<div class="col-sm-7 text-left">
           						<input type="hidden" id="status" name="status" value="${car.status}"/>
			                    <input type="hidden" id="carid" name="id" value="${car.id }"/>
			                    <input type="hidden" name="user.id" value="${car.user.id }"/>
			                    <input type="hidden" name="carnumber" id="carnumber" value="${car.carnumber}"/>
			                    <input id="mininame" name="mininame" value="${car.mininame}" readonly="readonly" type="text"
                      				class="carnumbermin car_addr" style="padding-right: 0px;padding-left: 0px;text-align: center;"/>
                      			<input type="text" id="number" name="number"
                      					value="${car.number }" class="car_addr" style="width: 82%;" maxlength="6"/>
           					</div>
           				</div>
           				<div class="col-sm-4 form-group">
           					<div class="col-sm-5 control-label text-left">
           						<span class="red">*</span>车辆来源
           					</div>
           					<div class="col-sm-7" >
                                    <form:select path="issocialcar" name="issocialcar" class="form-control">
				                        <form:options items="${fns:getDictList('issocialcar')}" itemLabel="label" itemValue="value"
				                                      htmlEscape="false"/>
				                    </form:select>
                                
           					</div>
           				</div>
           				<div class="col-sm-4 form-group">
           					<div class="col-sm-5 control-label text-left">
           						<span class="red">*</span>车辆类型
           					</div>
           					<div class="col-sm-7">
           						<input id="cartype" name="cartype" value="${car.cartype}" readonly="readonly" type="text"
                      				 class="form-control"/>
           					</div>
           				</div>
           			</div>
           		</div>
           		<!--第2个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车辆信息</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					<span class="red">*</span>车长
            				</div>
            				<div class="col-sm-7">
            					<form:input path="carlength" name="carlength" htmlEscape="false" class="form-control"/>
            					<span class="unit">米</span>
            				</div>
           				</div>
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					<span class="red">*</span>载重
            				</div>
            				<div class="col-sm-7">
            					<form:input path="loadweight" name="loadweight" htmlEscape="false" class="form-control"/>
            					<span class="unit">吨</span>
            				</div>
           				</div>
           				<div class="col-sm-4 form-group">
            				<div class="col-sm-5 control-label text-left">
            					常停放位置
            				</div>
            				<div class="col-sm-7">
            					<input type="text" name="oftenparkedposition" id="OFTENPARKEDPOSITION"
                                          value="${car.oftenparkedposition }"
                                          class="form-control" maxlength="150">
            				</div>
           				</div>
           			</div>
           		</div>
           		<!--第3个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车主信息</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group">
            				<div class="col-sm-5 control-label text-left">
            					车主姓名
            				</div>
            				<div class="col-sm-7">
            					<input name="ownername"
                                     id="OWNERNAME" value="${car.ownername }"
                                     class="form-control" type="text" maxlength="20">
            				</div>
           				</div>
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					车主手机号
            				</div>
            				<div class="col-sm-7 text-left">
            					<input name="ownermobile" maxlength="11"
                                   id="OWNERMOBILE" value="${car.ownermobile }"
                                   class="form-control" type="text">
            				</div>
           				</div>
           			</div>
           		</div>
           		<!--第4个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车辆路线</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-6 form-group">
            				<div class="col-sm-3 control-label text-left">
            					<span class="red">*</span>主营路线
            				</div>
            				<div class="col-sm-8">
            					<input type="hidden" name="mainroad" id="MAINROAD" value=""/>
            					<input type="text" name="fromaddress" id="fromAddress" value="${car.fromaddress }" readonly="readonly" class="car_addr" placeholder="请选择出发地" maxlength="100"/>
            					<img src="${ctxStatic }/front/img/switch_btn.png" alt="" class="img_switch"/>
            					<input type="text" name="toaddress" id="toAddress" value="${car.toaddress }" readonly="readonly" class="car_addr" placeholder="请选择目的地" maxlength="100"/>
            				</div>
           				</div>
           				<div class="col-sm-6 form-group">
            				<div class="col-sm-3 control-label text-left">
            					定位手机号
            				</div>
            				<div class="col-sm-4">
            					<input name="locationmobile" maxlength="11" type="text"
                                                   id="LOCATIONMOBILE" value="${car.locationmobile }"
                                                   class="form-control"/>
            				</div>
            				<div class="col-sm-4">
            					<div class="radios" style="position: relative;top:6px;">
                                       <label class="label_radio" for="radio-bill1">
                                       	<input style="margin-left:5px;" id="WHITELISTID" name="WHITELISTID" type="checkbox" value="1"
                      						onclick="iswhitelistid()"/>是否开启定位
                                       </label>
                                   </div>
            				</div>
           				</div>
           			</div>
           		</div>
           		<!--第5个面板-->
           		<div class="col-sm-6">
           			<div class="panel clearfix" style="padding-bottom:20px;">
           				<h4 class="panel-heading">行驶证照片<span class="red">（每张图片大小不超过3M，限上传2张，支持JPG、JPEG、PNG格式）</span></h4>
            			<div class="col-sm-12 form-horizontal form-addr" style="margin-bottom:0;padding-top:0;">
            				<div class="form-group col-sm-12">
            					<div class="col-sm-3 control-label text-right" style="padding-left:0;">
            						<span class="red">*</span>行驶证照片
            					</div>
            					<div class="col-sm-9 text-left" id="a">
            						<form:hidden id="travellicimg" path="travellicimg" htmlEscape="false" maxlength="256"/>
	                    			<sys:ckfinder input="travellicimg" type="images" uploadPath="/car" maxnumber="2" selectMultiple="true"
	                                  maxWidth="100" maxHeight="100"/>
            					</div>
            				</div>
            			</div>
           			</div>
           		</div>
           		</div>
           		<!--第6个面板-->
           		<div class="col-sm-6" >
           			<div class="panel clearfix" style="padding-bottom:20px;">
           				<h4 class="panel-heading">车辆外观照片<span class="red">（每张图片大小不超过3M，限上传2张，支持JPG、JPEG、PNG格式）</span></h4>
            			<div class="col-sm-12 form-horizontal form-addr" style="margin-bottom:0;padding-top:0;">
            				<div class="form-group col-sm-12">
            					<div class="col-sm-3 control-label text-right" style="padding-left:0;">
            						<span class="red">*</span>车辆外观照片
            					</div>
            					<div class="col-sm-9 text-left"  id="b">
            						<form:hidden id="carsurfaceimg" path="carsurfaceimg" htmlEscape="false" maxlength="256"/>
	                    			<sys:ckfinder input="carsurfaceimg" type="images" uploadPath="/car" maxnumber="2" selectMultiple="true"
	                                  maxWidth="100" maxHeight="100"/>
            					</div>
            				</div>
            			</div>
           			</div>
           		</div>
           		</div>
           		<!--第6个面板-->
           		<div class="col-sm-12">
           			<div class="form-group" style="margin-bottom: 105px;">
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
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">


    if ($("#LOCATIONMOBILE").val() != "") {
        $("#WHITELISTID").attr("checked", "true");
        iswhitelistid();
    }
    function iswhitelistid() {
        if ($("#WHITELISTID").attr("checked")) {
            $("#xinhaos").html("*");
        } else {
            $("#xinhaos").html("");
        }
    }
    //获取车牌所属地区
    getArea();
    getCarType();
    function getArea() {
        $.ajax({
            url: "${wlpt}/wlpt/chinaarea/getArea",
            dataType: 'json',
            data: {parentCode: "0"},
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#mininame").gridSelector({
                        idKey: "code",
                        textKey: "mininame",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#mininame").val(data.mininame).change();
                            }
                        }

                    });
                }
            }
        });

    }
    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value).change();
                            }
                        }
                    });
                }
            }
        });
    }
    $("#fromAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                if (data.city.NAME != data.province.NAME) {
                    str += data.city.NAME;
                }
                //searchConditions.fromCity = data.city.NAME;
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
        	mininame: {
                message: '简称无效',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '简称不能为空'
                    }
                }
            },number: {
                message: '车牌编号无效',
                validators: {
                    notEmpty: {
                        message: '车牌编号不能为空'
                    },regexp:{
                        regexp:/^[A-Z]{1}(?![A-Z]+$)[A-Z0-9]{5}$/,
                        message: "请填写正确车牌号码"
                    }
                }
            },carlength: {
                message: '车长无效',
                validators: {
                    notEmpty: {
                        message: '车长不能为空'
                    },decimalTwo: {
                        message: '请输入正确的车长'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '车长不能小于等于0'
                    }
                }
            },cartype: {
                message: '车型无效',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '车型不能为空'
                    }
                }
            },loadweight: {
                message: '车辆载重无效',
                validators: {
                    notEmpty: {
                        message: '车辆载重不能为空'
                    },decimalTwo: {
                        message: '请输入正确的车辆载重'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '车辆载量不能小于等于0'
                    }
                }
            },fromaddress: {
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
            },locationmobile: {
                validators: {
                	regexp: {
                        regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
                        message: '请填写正确的手机号码'
                    }

                }
            },ownername: {
                message: '车主姓名无效',
                validators: {
                    regexp: {
                        regexp: /^[\u4e00-\u9fa5]+$/,
                        message: '车主姓名只能中文'
                    }
                }
            },ownermobile: {
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
        
        if($("#travellicimg").val()==null||$("#travellicimg").val()==""){
        	$.MsgBox.Alert("温馨提示", "请上传行驶证照片");
        	return false;
        }
        if($("#carsurfaceimg").val()==null||$("#carsurfaceimg").val()==""){
        	$.MsgBox.Alert("温馨提示", "请上传车辆外观照片");
        	return false;
        }

        var bootstrapValidator = $("#Form").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()){
        	$("#maskloading" , parent.document).show();
	        var mininame = $("#mininame").val();
	        var number = $("#number").val();
	        var newcarnumber = mininame + number;
	        var carnumber = $("#carnumber").val();
	        var carid = $("#carid").val();
	        if (carid == '' || carid == null || newcarnumber != carnumber) {
	            $.ajax({
	                url: "${wlpt}/wlpt/car/validCarnumber",
	                dataType: 'json',
	                type: "post",
	                async: false,
	                data: {carnumber: newcarnumber},
	                success: function (data) {
	                	$("#maskloading" , parent.document).hide();
	
	                    if (data.value == "1") {
	                        $("#NUMBER").tips({
	                            side: 3,
	                            msg: '车牌号码已存在',
	                            bg: '#00A2E9',
	                            time: 4
	                        });
	                        $("#NUMBER").focus();
	                    } else {
	                        $.ajax({
	                            url: "${wlpt}/wlpt/car/saveCar?" + $("#Form").serialize(),
	                            dataType: 'json',
	                            type: "post",
	                            success: function (data) {
	                                if (data.value.state == 1) {
	                                    window.location.href = '${wlpt}/wlpt/car/car_list';
	                                } else {
	                                    $.MsgBox.Alert("保存提示", data.value.message);
	                                }
	                            }
	                        });
	                    }
	                }
	            });
	        } else {
	            $.ajax({
	                url: "${wlpt}/wlpt/car/saveCar?" + $("#Form").serialize(),
	                dataType: 'json',
	                type: "post",
	                success: function (data) {
	                    if (data.value.state == 1) {
	                        window.location.href = '${wlpt}/wlpt/car/car_list';
	                    } else {
	                    	$("#maskloading" , parent.document).hide();
	                        $.MsgBox.Alert("保存提示", data.value.message);
	                    }
	                }
	            });
	        }
        }
    });

</script>
</body>
</html>
