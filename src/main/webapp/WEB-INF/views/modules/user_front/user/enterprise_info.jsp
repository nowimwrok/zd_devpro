<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>企业信息</title>

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
		.company_hide_box{display:none;}
		
    </style>

</head>

<body style="background: #f5f5f5;">
<%@ include file="/WEB-INF/views/modules/user_front/user/enterprise_head.jsp" %>

<div style="background: #f5f5f5;">
<form:form id="inputForm1" name="inputForm1" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post">
        <form:hidden path="id"/>
        <form:hidden path="user.id"/>
        <input type="hidden" value="0" name="type"/>
        <input type="hidden" value="enterprise_info" name="url"/>
	<div class="row">
		<div class="col-lg-12">
            <div class="panel" style="border:0;">
                <div class="panel-body">
                    <div class="tab-content">
                    	<div class="tab-pane fade in active" id="basic">
                    	<div class="panel">
                            <div class="form_container">
                                <h4 class="panel-heading ">完善基本资料 (<span class="red">注：</span>&nbsp;&nbsp;法人身份证号属于保密信息，不对外开放)</h4>
                            </div>
                            <div class="panel-body">
	                            <div class="col-sm-12 form-horizontal">
	                                <div class="form-group col-sm-4 ">
	                                    <div class="col-sm-5 control-label text-right"><span class="red">*</span>公司名称</div>
	                                    <div class="col-sm-7 text-left">
	                                    	<form:input path="companyname" id="companyname" htmlEscape="false" maxlength="50"
	                                			cssClass="form-control"/>
	                                    </div>
	                                </div>
	                                <div class="col-sm-4 form-group">
	                                    <div class="col-sm-5 control-label text-right"><span class="red">*</span>企业法人</div>
	                                    <div class="col-sm-7 text-left">
	                                    	<form:input path="legalperson" id="legalperson" htmlEscape="false"
	                            				maxlength="50" cssClass="form-control"/>
	                                    </div>
	                                </div>
	                                <div class="col-sm-4 form-group">
	                                    <div class="col-sm-5 control-label text-right"><span class="red">*</span>成立时间</div>
	                                    <div class="col-sm-7 text-left">
	                                    	<input name="setuptime" id="setuptime" type="text" readonly="readonly" maxlength="20"
				                           style="height: 37px;" class="form-control Wdate "
				                           value="<fmt:formatDate value="${userCompany.setuptime}" pattern="yyyy-MM-dd"/>"
				                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});"/>
	                                    </div>
	                                </div>
	                                <div class="col-sm-4 form-group">
	                                    <div class="col-sm-5 control-label text-right"><span class="red">*</span>法人身份证</div>
	                                    <div class="col-sm-7 text-left">
	                                    	<form:input path="legalidcardnum" id="legalidcardnum" htmlEscape="false"
	                                                          maxlength="50" cssClass="form-control"/>
	                                    </div>
	                                </div>
	                                
	   								<div class="col-sm-4 form-group ">
	   									<div class="col-sm-12 control-label" style="text-align:center;">
	   										<a class="perfect_info car_perfect_info">更多信息<i class="fa fa-chevron-circle-down"></i> </a>
	   									</div>
	                   				</div>
	                   				<div class="col-sm-4 form-group">
	   									<div class="col-sm-12 control-label" style="text-align:left;">
	   										<span class="perfect_info car_perfect_info">&nbsp;</span>
	   									</div>
	   								</div>
	                   				<!---->
	                                <div class="clearfix company_hide_box">
		                                <div class="col-sm-4 form-group">
		                                    <div class="col-sm-5 control-label text-right">公司网址</div>
		                                    <div class="col-sm-7 text-left">
		                                    	<form:input path="homepageurl" id="homepageurl" htmlEscape="false"
		                                                          maxlength="150" cssClass="form-control"/>
		                                    </div>
		                                </div>
		                                <div class="col-sm-4 form-group">
		                                    <div class="col-sm-5 control-label text-right">优势资源</div>
		                                    <div class="col-sm-7 text-left">
		                                    	<form:input path="advantagesresources" id="advantagesresources" htmlEscape="false"
		                                                          maxlength="50" cssClass="form-control"/>
		                                    </div>
		                                </div>
		                                <div class="col-sm-4 form-group">
		                                    <div class="col-sm-5 control-label text-right">主营业务</div>
		                                    <div class="col-sm-7 text-left">
		                                    	<form:input path="mainbusiness" id="mainbusiness" htmlEscape="false"
		                                                          maxlength="50" cssClass="form-control"/>
		                                    </div>
		                                </div>	
	                                </div>
	                            </div>
							</div>
						</div>
						
						
						<div class="panel">
                            <div class="form_container">
                                <h4 class="panel-heading ">地址信息</h4>
                            </div>
                            <div class="panel-body">
                            <div class="col-sm-12 form-horizontal">
                                <div class="col-sm-6 form-group">
                                    <div class="col-sm-3 control-label text-right"><span class="red">*</span>公司地址</div>
                                    <div class="col-sm-7 text-left">
                                    	<form:input path="provinceCityDistrict" id="provinceCityDistrict"
			                            htmlEscape="false" maxlength="50" cssClass="form-control"
			                            onmouseover="this.title=this.value"/>
                                    </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="col-sm-3 control-label text-right"><span class="red">*</span>详细地址</div>
                                    <div class="col-sm-7 text-left">
                                    	<form:input path="companyaddress" id="companyaddress" htmlEscape="false"
                                                          maxlength="50" cssClass="form-control"/>
                                    </div>
                                </div>
                                
                            </div>
							</div>
						</div>
						
						<!--3-->
       					<div class="panel">
        					<div class="form_container">
       							<h4 class="panel-heading">主营路线</h4>
       						</div>
        					<div class="panel-body">
        						<div class="col-sm-12 form-horizontal">
        						<form:hidden path="mainline"/>
        							<div class="col-sm-12 form-group mainline0 main_line">
                       					<div class="col-sm-3 control-label text-right">
                       						主营路线1
                       					</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="frommainline" id="frommainline1" maxlength="50" class="form-control" placeholder="始发地" />
                       					</div>
                       					<div class="col-sm-1 form-group control-label" style="text-align:center">至</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="tomainline" id="tomainline1" maxlength="50" class="form-control" placeholder="目的地"/>
                       					</div>
                       					<div class="col-sm-2">
                       						<div class="btn btn-danger  delete">删除</div>
                       					</div>
                       				</div>
                       				<div class="col-sm-12 form-group mainline1 main_line" style="display: none;">
                       					<div class="col-sm-3 control-label text-right">
                       						主营路线2
                       					</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="frommainline" id="frommainline2" maxlength="50" class="form-control" placeholder="始发地"/>
                       					</div>
                       					<div class="col-sm-1 form-group control-label" style="text-align:center">至</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="tomainline" id="tomainline2" maxlength="50" class="form-control" placeholder="目的地" />
                       					</div>
                       					<div class="col-sm-2">
                       						<button class="btn btn-danger  delete" type="button" >删除</button>
                       					</div>
                       				</div>
                       				<div class="col-sm-12 form-group mainline2 main_line" style="display: none;">
                       					<div class="col-sm-3 control-label text-right">
                       						主营路线3
                       					</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="frommainline" id="frommainline3" maxlength="50" class="form-control" placeholder="始发地"/>
                       					</div>
                       					<div class="col-sm-1 form-group control-label" style="text-align:center">至</div>
                       					<div class="col-sm-3 text-left">
                       						<input type="text" name="tomainline" id="tomainline3" maxlength="50" class="form-control" placeholder="目的地" />
                       					</div>
                       					<div class="col-sm-2">
                       						<button class="btn btn-danger delete" type="button" >删除</button>
                       					</div>
                       				</div>
                       				<button  type="button" class="col-sm-4 col-sm-offset-4 btn btn-primary" id="addMainline" style="">添加主营路线</button>
        						</div>
        					</div>
       					</div>
                					
						
						<div class="col-sm-6" style="padding-left:0;">
   						<div class="panel clearfix">
   							<div class="form_container">
                                <h4 class="panel-heading ">上传公司logo图片</h4>
                            </div>
                            <div class="panel-body" style="padding-bottom:0;">
	                            <div class="col-sm-12 form-horizontal">
	                            	
	                                <div class="col-sm-12 text-center">
	                					<span class="red" style="margin-bottom:40px;">注：</span>图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式!
	                				</div>
	                				<div class="col-sm-4 control-label text-right"></div>
                                    <div class="col-sm-7 text-left" style="height:188px;">
                                        <ul class="upimg-list clearfix">
	                                         <form:hidden id="logoname" path="logoname" htmlEscape="false" maxlength="255"
				                                 class="input-xlarge"/>
						                    <sys:ckfinder input="logoname" type="images" uploadPath="/usercompany" selectMultiple="false"
						                                  maxWidth="100"
						                                  maxHeight="100"/>
	                                    </ul>
                                    </div>
	                            </div>
							</div>
						</div>
						</div>
						
						<div class="col-sm-6" style="padding-left:0;">
   						<div class="panel clearfix">
   							<div class="form_container">
                            	<h4 class="panel-heading ">联系方式</h4>
                         	</div>
                         	
                            <div class="panel-body" style="padding-top:20px;padding-bottom:30px;">
                            <div class="col-sm-12 form-horizontal">
                				<div class="col-sm-12 form-group" style="margin-bottom:15px;">
                                    <div class="col-sm-4 control-label text-right"><span class="red">*</span>联系人手机</div>
                                    <div class="col-sm-7 text-left">
                                        <form:input path="companytel" id="companytel" htmlEscape="false" maxlength="50"
                                    			cssClass="form-control" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-group" style="margin-bottom:15px;">
                                    <div class="col-sm-4 control-label text-right">公司电话</div>
                                    <div class="col-sm-7 text-left">
                                        <form:input path="headertel" id="headertel" htmlEscape="false" maxlength="50"
                                    		cssClass="form-control" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-group" style="margin-bottom:15px;">
                                    <div class="col-sm-4 control-label text-right">公司传真</div>
                                    <div class="col-sm-7 text-left">
                                        <form:input path="companyfax" id="companyfax" htmlEscape="false" maxlength="50" class="form-control"/>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-group">
                                    <div class="col-sm-4 control-label text-right">联系QQ</div>
                                    <div class="col-sm-7 text-left">
                                        <form:input path="companyqq" id="companyqq" htmlEscape="false" maxlength="50" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>     
                            
                            
                        </div>
                           	<div class="col-lg-12">
                                <div class="form-group mb-80 mt-40">
                                	<div class="col-sm-2 control-label text-left"></div>
                                    <div class="col-sm-4">
                                    	<input type="button" id="btn-warning" class="btn btn-primary col-lg-12" value="保  存" style="margin-bottom:30px;">
                                    </div>
                                    <div class="col-sm-4">
		                            	<button class="btn btn-warning col-lg-12"  onclick="history.go(-1)" style="margin-bottom:30px;">返  回</button>
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

<script src="/static/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script>
	$(".qiye_menu li").removeClass("active")
    $(".qiye_menu li").eq(0).addClass("active");
    var msg = '${msg}';
    if (msg != '') {
        $.MsgBox.Alert("保存提示",'${msg}');
    }
 	//点击完善资料 显示
    $('.perfect_info').click(function(){
    	$('.company_hide_box').toggle();
    });
    
    //页面加载路线数据
    if ('${userCompany.mainline}' != '') {
        var mainline = '${userCompany.mainline}';
        var array = mainline.split('|');//获取所有线路以|符号分割
        //判断分割后的路线是否为空
        if (array != null && array != '' && array != undefined) {
            //循环分割后的路线
            for (var i = 0; i < array.length; i++) {
                //获取每组路线信息
                var linearray = array[i].split(';');
                //判断当前获取的路线对象是否为空
                if (linearray != null && linearray != '' && linearray != undefined) {
                    //判断是否地是否为空
                    if (linearray[0] != '') {
                        $(".mainline" + i + "").find("input[name='frommainline']").val(linearray[0]);
                    }
                    //判断目的地是否为空
                    if (linearray[1] != '') {
                        $(".mainline" + i + "").find("input[name='tomainline']").val(linearray[1]);
                    }
                    $(".mainline" + i + "").show();//显示当前路线
                    //如果三条路线都已经添加隐藏添加路线按钮
                    if (i == 2) {
                        $(this).hide();
                        $(".addMainline").hide();
                    }
                }
            }
        } else {
            var linearray = mainline.split(';');
            //判断当前获取的路线对象是否为空
            if (linearray != null && linearray != '' && linearray != undefined) {
                //判断是否地是否为空
                if (linearray[0] != '') {
                    $(".mainline0").find("input[name='frommainline']").val(linearray[0]);
                }
                //判断目的地是否为空
                if (linearray[1] != '') {
                    $(".mainline0").find("input[name='tomainline']").val(linearray[1]);
                }
            }
        }

    } 
    //删除主营路径
    $(".delete").click(function () {
        $(this).parents(".main_line").find("input").val('');
        $(this).parents(".main_line").css("display", "none");
        $("#addMainline").show();
        $(".addMainline").show();
    });

    
    $('#inputForm1').bootstrapValidator({
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
            },setuptime: {
                message: '公司成立时间无效',
                trigger: "focus blur keyup change",
                validators: {
                    notEmpty: {
                        message: '公司成立时间不能为空'
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
            },companytel: {
                message: '请填写正确的手机号码',
                validators: {
                	notEmpty: {
                        message: '联系人手机不能为空'
                    },integer: {
                        message: "请填写正确的手机号码"
                    }
                }
            },headertel: {
                message: '请填写正确的电话号码',
                validators: {
                    tel: {
                        message: "请填写正确的电话号码,例如:020-666666"
                    }
                }
            }, homepageurl: {
                message: '请填写正确的电子邮箱',
                validators: {
                    emailAddress: {
                        message: "请填写正确的电子邮箱"
                    }
                }
            }, companyqq: {
                message: '请填写正确的QQ',
                validators: {
                    integer: {
                        message: "请填写正确的QQ"
                    },
                    stringLength: {
                        min: 6,
                        max: 10,
                        message: 'QQ长度为6-10位字符'
                    }
                }
            }
        }

    });
    
    
    //企业基本信息保存时触发
    $("#btn-warning").click(function () {
        //线路集合
        var mainlinelist = "";
        //创建循环获取线路数据
        for (var i = 0; i < 3; i++) {
            //始发地
            var frommainline = "";
            //目的地
            var tomainline = "";
            //判断当前的线路是否是显示状态
            if ($(".mainline" + i + "").css("display") != "none") {
                frommainline = $(".mainline" + i + "").find("input[name='frommainline']").val();//获取始发地
                tomainline = $(".mainline" + i + "").find("input[name='tomainline']").val();//获取目的地
            }
            if (frommainline != '' || tomainline != "") {
                mainlinelist += frommainline + ";" + tomainline + "|";
            }
            if (i < 2) {
                mainlinelist + "|";
            }
        }
        $("#mainline").val(mainlinelist); 
        var bootstrapValidator = $("#inputForm1").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
        	$.ajax({
                cache: true,
                type: "POST",
                url: "${wlpt}/wlpt/company/saveCompany",
                data: $('#inputForm1').serialize(),// 你的formid
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
        /* $(".btn-warnings1").attr('disabled', 'disabled');
        $("#inputForm1").submit(); */


    });

    $(".qiye_menu li").on("click", function () {
        $(".qiye_menu li").removeClass("qiye_menu_1")
        $(this).addClass("qiye_menu_1");
    });

    loads();
    function loads() {

        var height = $("html").innerHeight();
        var myFrameheight = height + 100;
        top.$("#rightFrame").height(0); //清空父级iframe高度
        $("#rightFrame", parent.document).height(myFrameheight < 600 ? 600 : myFrameheight);//重新设置父级iframe高度
        $(".container").height(myFrameheight < 600 ? 600 : myFrameheight);//重新设置container高度

    }
    //判断是否是认证信息
    		var status = '${userCompany.status}';
			if (status == '1' || status == '2') {
				$("#companyname").attr("readonly", "true");
				$("#legalperson").attr("readonly", "true");
				$("#provinceCityDistrict").attr("disabled", "disabled");
				$("#companyaddress").attr("readonly", "true");
	
			}
    

    //添加主营路线
    $("#addMainline").click(function () {
        for (var i = 0; i < 3; i++) {
            if (i == 2) {
                $(this).hide();
                $(".addMainline").hide();
            }

            if ($(".mainline" + i + "").css("display") == "none") {
                $(".mainline" + i + "").show();
                //重新设置父级高度
                //top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
                var height = top.$("#rightFrame").contents().height() + 50;
                top.$("#rightFrame").height(height < 500 ? 500 : height);
                break;
            }

        }

    });

    //主营路线始发地与目的地加载地址控件
    initAddress("#frommainline1");
    initAddress("#frommainline2");
    initAddress("#frommainline3");
    initAddress("#tomainline1");
    initAddress("#tomainline2");
    initAddress("#tomainline3");
    //公司地址加载地址控件
    initAddress("#provinceCityDistrict");
    //設置地址插件
    function initAddress(id) {
        $(id).PCC({
            hasCounty: true,
            width: 360,
            height: 220,
            url: "${wlpt}/wlpt/chinaarea/getArea",
            closeIcon: "/static/images/close_hover.png",
            complete: function (data) {
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

</script>
</body>
</html>