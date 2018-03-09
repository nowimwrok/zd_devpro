<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->

    <title>一卡通信息</title>
    <style>


    </style>
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        基本信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-6 form-group">
                            <c:if test="${isenterprise ==true}">
                                <div class="col-sm-12">
                                    <div class="col-sm-4 control-label text-right">
                                        企业名称：
                                    </div>
                                    <div class="col-sm-8 control-label" style="text-align: left;padding-left:0;">
                                            ${user.userCompany.companyname}
                                    </div>
                                </div>
                                <div class="col-sm-12" style="margin-top:10px;">
                                    <div class="col-sm-4 control-label text-right">
                                        营业执照号：
                                    </div>
                                    <div class="col-sm-8 control-label" style="text-align:left;padding-left:0;">
                                            ${user.userCompany.businesslicencenum}
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${isenterprise ne true}">
                                <div class="col-sm-12">
                                    <div class="col-sm-4 control-label text-right">
                                        用户名：
                                    </div>
                                    <div class="col-sm-8 control-label" style="text-align: left;padding-left:0;">
                                            ${user.loginName}
                                    </div>
                                </div>
                            </c:if>
                            <div class="col-sm-12" style="margin-top:10px;">
                                <div class="col-sm-4 control-label text-right">
                                    手机号码：
                                </div>
                                <div class="col-sm-8 control-label" style="text-align:left;padding-left:0;">
                                    ${user.phone}
                                </div>
                            </div>
                            <div class="col-sm-12" style="margin-top:10px;">
                                <div class="col-sm-4 control-label text-right">
                                    所在地：
                                </div>
                                <div class="col-sm-8 control-label" style="text-align:left;padding-left:0;">
                                    <c:if test="${isenterprise ne true}">
                                        ${user.userinfo.contactaddress}
                                    </c:if>
                                    <c:if test="${isenterprise eq true}">
                                        ${user.userCompany.provinceCityDistrict}${user.userCompany.companyaddress}
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4" style="height:120px;">
                            <div class="col-sm-1"></div>
                            <img src="${ctxStatic}/images/wlptfront/shop_img/new_03.gif" alt="" style="height:100%"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form_container">
                <!--第一个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">
                        申请信息
                    </h4>
                    <form:form id="inputForm" modelAttribute="address" method="post"
                    class="form-horizontal">
                        <div class="col-sm-1 form-horizontal" style="margin-bottom: 0;"></div>
                        <div class="col-sm-10 form-horizontal" style="margin-bottom: 0;">
                            <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">
                                <c:if test="${not empty userMetroCard.cardid }">
                                    <div class="form-group col-sm-6">
                                        <div class="col-sm-3 control-label text-right">
                                            <span class="red">*</span>一卡通号
                                        </div>
                                        <div class="col-sm-9 text-left">
                                            <input type="text" name="loginName"
                                                   id="loginName" value="${userMetroCard.cardid}" readonly
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                </c:if>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>姓名
                                    </div>
                                    <div class="col-sm-9 text-left">
                                        <input type="text" id="linkman" name="linkman"
                                               value="${userMetroCard.address.linkman}" data-bv-trigger="keyup"
                                               data-bv-notempty-message="姓名不能为空" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>联系电话
                                    </div>
                                    <div class="col-sm-9 text-left">
                                        <input type="text" placeholder="请输入电话号码" id="linkmobile"
                                               value="${userMetroCard.address.linkmobile}" name="linkmobile"
                                               maxlength="11"
                                               class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>所在地区
                                    </div>
                                    <div class="col-sm-9 text-left">
                                        <input type="text" placeholder="请选择地址" id="address"
                                               value="${userMetroCard.address.province}${userMetroCard.address.city}${userMetroCard.address.district}"
                                               name="location" maxlength="50" class="form-control"/><input
                                            id="fromprovince" name="province" type="hidden" value="${userMetroCard.address.province}"> <input
                                            id="fromcity" name="city" type="hidden" value="${userMetroCard.address.city}"> <input
                                            id="fromdistrict" name="district" type="hidden" value="${userMetroCard.address.district}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">

                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>详细地址
                                    </div>
                                    <div class="col-sm-9 text-left">
                                        <input type="text" placeholder="请输入详细地址" id="detailAddress"
                                               name="address" value="${userMetroCard.address.address}"
                                               class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-right">
                                        <span class="red">*</span>邮政编码
                                    </div>
                                    <div class="col-sm-9 text-left">
                                        <input type="text" placeholder="请输入邮编" id="postalcode"
                                               value="${userMetroCard.address.postcode}" name="postcode"
                                               maxlength="6" class="form-control"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-12" style="margin-bottom:80px;margin-top:20px;">
                            <div class="col-sm-2"></div>
                            <c:if test="${ userMetroCard.cardid == null }">
                                <div class="col-sm-4">
                                    <button type="button" id="btn-warning" class="btn btn-primary col-sm-12">确定申请
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${not empty userMetroCard.cardid }">
                                <div class="col-sm-4">
                                    <button type="button" id="btn-loss" class="btn btn-primary col-sm-12">挂失</button>
                                </div>
                            </c:if>
                            <div class="col-sm-4">
                                <button type="button" class="btn btn-warning col-sm-12" onclick="history.go(-1)">返回</button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
        type="text/javascript"></script>
        
<script type="text/javascript">
	$(function(){
		//申请状态判断
	var status = "${userMetroCard.status}";
	//alert(status);
	if(status == "0"){
	$("#btn-warning").html("申请中");
	}
	});
</script>

        
<script type="text/javascript">
    $(function () {
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                linkman: {
                    message: '收货人信息无效',
                    validators: {
                        notEmpty: {
                            message: '收货人不能为空'
                        },
                        stringLength: {
                            min: 2,
                            max: 30,
                            message: '收货人必须大于1，小于30个字'
                        },
                        regexp: {
                            regexp: /^[\u4e00-\u9fa5]+$/,
                            message: '用户名只能中文'
                        }
                    }
                },
                linkmobile: {
                    validators: {
                        notEmpty: {
                            message: '手机号码不能为空'
                        },
                        phone: {
                            country: 'CN',
                            message: '请输入正确的手机号码'
                        }

                    }
                },
                location: {
                    trigger:"change",
                    validators: {
                        notEmpty: {
                            message: '收货地址不允许为空'
                        }
                    }
                },
                address: {
                    validators: {
                        notEmpty: {
                            message: '详细地址不能为空'
                        }
                    }
                },
                postcode: {
                    validators: {
                        notEmpty: {
                            message: '邮政编码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '邮政编码格式有误'
                        }
                    }
                }
            }

        });
        $("#btn-warning").on("click", function () {

            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
            	//alert($('#inputForm').serialize());
                $("#btn-warning").attr("disabled", "disabled");
                 var status = "${userMetroCard.status}";
                // alert(status);
                if(status == "0"){
                $.MsgBox.Alert("保存提示", "注册失败，不能重复注册");
                }else if(status == "2"||status == ""){
                	$.ajax({
                        cache: true,
                        type: "POST",
                        url: "${wlpt}/wlpt/personal/saveCard",
                        data: $('#inputForm').serialize(), //你的formid
                        async: false,
                        error: function (request) {
                            $.MsgBox.Alert("保存提示", "保存失败");
                            $("#btn-warning").attr("disabled", "none");
                        },
                        success: function (data) {
                            $.MsgBox.Alert("保存提示", data.message);
                            parent.location.href = "${wlpt}/wlpt/personal/index";
                        }
                    });
                }
                	 
                 }
			
               
            
            else{

            }
        });
        $("#btn-loss").on("click", function () {

            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                $.MsgBox.Confirm("挂失提示", "尊敬的用户，本次操作将会扣取20元挂失费用，请您确保账户余额足够完成本次扣费，确定申请挂失吗？", function () {
                    $("#btn-loss").attr("disabled", "disabled");
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: "${wlpt}/wlpt/personal/lossCard",
                        data: $('#inputForm').serialize(),// 你的formid
                        async: false,
                        error: function (request) {
                            $.MsgBox.Alert("保存提示", "保存失败");
                            $("#btn-loss").attr("disabled", "none");
                        },
                        success: function (data) {
                            $.MsgBox.Alert("保存提示", data.message);
                            parent.location.href = "${wlpt}/wlpt/personal/index";
                        }
                    });
                }, null, null, null, "是", "否");

            }
            else{

            }
        });
        $("#address").PCC({
            hasCounty: true,
            width: 360,
            height: 220,
            url: "${wlpt}/wlpt/chinaarea/getArea",
            //closeIcon: "static/images/pic12.gif",
            complete: function (data) {
                var str = "";
                if (data.province) {
                    str += data.province.NAME;
                    $("#fromprovince").val(data.province.NAME);
                }
                if (data.city) {
                    str += data.city.NAME;
                    $("#fromcity").val(data.city.NAME);
                }
                if (data.county) {
                    str += data.county.NAME;
                    $("#fromdistrict").val(data.county.NAME);
                }
               		$("#address").val(str).change();
            }	
        });
    });

</script>
</body>
</html>
