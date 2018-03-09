<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>添加报价</title>
    <link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
    <style type="text/css">
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
		.form-control{
			border: 1px solid #ccc !important;
		}
		.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
		    padding: 10px;
		    line-height: 1.42857143;
		    border-bottom: 1px solid #ddd;
		    font-size: 13px;
		    vertical-align: bottom;
		    white-space: nowrap;
		    box-sizing: border-box;
		}
		.search_e {
		    line-height: 20px;
		    background-color: #fff;
		    padding: 0px;
		    position: relative;
		    border:0px;
		}
		.delivery_tr td{
			padding-left: 10px !important;
		}
		.text-left{
			text-align: left !important;
		}
		.col-sm-12{
			padding: 0px; 
		}
    </style>
    

</head>
<body style="background: #f5f5f5;">

<div >
    <div class="row">
        <div class="col-lg-12">
            	<i class="line"></i>
            	
            	<div class="form_container">
            		<div class="panel clearfix">
            			<h4 class="panel-heading">添加报价</h4>
            			<div class="col-sm-6 form-horizontal" style="margin-top:25px;">
	             			<div class="col-sm-12 form-group">
	             				<div class="col-sm-3 text-right control-label">
	             					用户名/电话
	             				</div>
	             				<div class="col-sm-7 text-left">
	             					<input id="searchinfo" name="searchinfo" class="form-control" placeholder="用户名/电话"/>
	             				</div>
	             				<div class="text-left" style="line-height: 35px;height: 35px;"><a  data-toggle="modal"
	                                        data-target="#myModal"  class="see oprate">常用联系人</a></div>
	             			</div>
	             			<div class="col-sm-12 form-group">
	             				<div class="col-sm-3 text-right control-label">
	             					搜索说明
	             				</div>
	             				<div class="col-sm-7 text-left" >
	             					<p class="search_e" id="addinfo">请输入承运方的完整用户名或手机号，然后生成运单即可！</p>
	             				</div>
	             			</div>
	             			<div class="col-sm-12">
	             				<div class="col-sm-4"></div>
	             				<button class="col-sm-6 btn  btn-primary driver_btn" onclick="search();">查询</button>
             				</div>
            			</div>
            			<div class="col-sm-1" style="width: 4.333333%"></div>
            			<div class="col-sm-5  form-horizontal" >
            				<!--没有搜索时的-->
            				<img src="${ctxStatic }/front/img/headPic.jpg" alt=""  class="search_img" id="search_img"/>
            				<div class="col-sm-12 search_content" id="info" hidden="hidden">
            				<form:form id="inputForm" modelAttribute="user" action="${wlpt}/wlpt/driver/saveAttach" method="post">
	            				<input id="userid" name="reuser.id" type="hidden"/>
            					<input id="role" type="hidden"/>
            					<div class=" clearfix col-sm-12 content_list">
		              				<div class="col-sm-2 label-control text-right" style="width: 22.6%">
		              					登录名：
		              				</div>
		              				<div class="col-sm-4 text-left list_c" id="login" style="width: 27%">
		              					
		              				</div>
		              				<div class="col-sm-2 label-control text-right" style="width: 22.6%">
		              					手机号码：
		              				</div>
		              				<div class="col-sm-4 text-left list_c" id="phone" style="width: 27%">
		              					
		              				</div>
            					</div>
            					<div class="clearfix col-sm-12 content_list">
            						<div class="col-sm-2 label-control text-right" style="width: 22.6%">
            							真实姓名：
            						</div>
		              				<div class="col-sm-4 text-left list_c" id="name" style="width: 27%">
		              					
		              				</div>
		              				<div class="col-sm-2 label-control text-right" style="width: 22.6%">
		              					认证：
		              				</div>
		              				<div class="col-sm-4 text-left list_c" id="status" style="width: 27%">
		              					
		              				</div>
            					</div>
            					
            					<div class="form-group has-unit clearfix col-sm-12 content_list">
		              				<div class="col-sm-3 label-control text-right" style="width: 26%;">
		              					价格：
		              				</div>
		              				<div class="col-sm-6 text-left list_c">
		              					<input id="ooferprice" name="ooferprice" placeholder="请输入价格" class="form-control" value="${goods.expectedprice}" class="input required number" type="text"/>
		              					<i class="unit">元/${goods.freightunit}</i>
		              				</div>
            					</div>
            					<div class="form-group has-unit clearfix col-sm-12 content_list">
		              				<div class="col-sm-3 label-control text-right"  style="width: 26%;">
		              					指派吨数：
		              				</div>
		              				<div class="col-sm-6 text-left list_c">
		              					<input id=residualvolume value="${goods.residualvolume}" type="hidden"/>
						                <input id="oddloadweight" name="oddloadweight" placeholder="请输入运输量" value="${goods.residualvolume}" class="form-control"
						                       type="text" /><i class="unit">${goods.freightunit}</i>
		              				</div>
            					</div>
            					<div class="col-sm-12 clearfix">
            						<input type="button" class="btn col-sm-6 col-sm-offset-3 btn-danger" id="btnSubmit" style="margin-top:3px;" value="指派">
            					</div>
            					</form:form>
            				</div>
            			</div>
            		</div>
            	
            	
           	</div>
        </div>
	</div>
	


	<div class="row">
        <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            基本信息 
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <input id="gsid" name="id"  value="${goods.id}" type="hidden"/>
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">货物名称</div>
                                <div class="col-sm-7 control-label text-left">
                                   	${goods.goodsname}
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit">
                                <div class="col-sm-5 control-label text-right">货物重量</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.freightvolume }吨
                                </div>
                            </div>
                            <!--下拉框-->
                            <div class="form-group col-sm-4">
                                <div class="col-lg-5 control-label text-right">货物类别</div>
                                <div class="col-lg-7 control-label" style="text-align:left;">
                                    <c:if test="${goods.gsoddtype == '1'}">成品</c:if>
                                 	<c:if test="${goods.gsoddtype == '2'}">原料</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-12">
                <div class="col-sm-6" style="padding-left:0;">
                    <div class="panel clearfix">
                        <div class="form_container">
                            <h4 class="panel-heading">
                                发货人
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-right">提货地址
                                    </div>
                                    <div class="col-sm-9 control-label text-left">
                                    	${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district} ${goods.shipAddress.address}
                                        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-right">
                                        	姓名
                                        </div>
                                        <div class="col-sm-2 control-label text-left" >
                                            ${goods.shipAddress.linkman}
                                        </div>
                                        <div class="col-sm-2 control-label text-right">手机号</div>
                                        <div class="col-sm-5 control-label text-left">
                                            ${goods.shipAddress.linkmobile}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6" style="padding-right:0;">
                    <div class="panel clearfix">
                        <div class="form_container">
                            <h4 class="panel-heading">
                                收货人
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-right">卸货地址
                                    </div>
                                    <div class="col-sm-9 control-label text-left" >
                                    	${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district} ${goods.consignAddress.address} 
                                        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-right">
                                        	姓名
                                        </div>
                                        <div class="col-sm-2 control-label text-left">
                                            ${goods.consignAddress.linkman}
                                        </div>
                                        <div class="col-sm-2 control-label text-right">手机号</div>
                                        <div class="col-sm-5 control-label text-left">
                                        	${goods.consignAddress.linkmobile}
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            货物信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">装车时间</div>
                                <div class="col-sm-7 control-label text-left">
                                     <fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm"/>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">运输方式</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.transportway }
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">期望价格</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.expectedprice}元/吨
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">有效天数</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.effectdays}天
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">货物价值</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.worth}元
                                </div>
                            </div>
                            
                        </div>
                            

                    </div>
                </div>
            </div>
            
            
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            需求车型
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">车型</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.cartype}
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">车长</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${not empty goods.carlength?goods.carlength:"不限"}${not empty goods.carlength?"米":""}
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            派车方式
                        </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-4">
                                    <div class="col-sm-5 control-label text-right">是否指派</div>
                                    <div class="col-sm-7 control-label text-left">
                                            ${fns:getDictLabel(not empty goods.issend?goods.issend:'0','yes_no','')}
                                        
                                    </div>
                                </div>
                                
                            </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            备注信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">备注</div>
                                <div class="col-sm-7 control-label text-left">
                                    ${goods.remarks }
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        
    </div>
    
    
    
    <div class="row">
        <div class="col-lg-12" style="border-bottom:50px solid #f5f5f5;">
                <c:if test="${blinfoList!=null && blinfoList.size()>0}">
                    <div class="panel clearfix">
                        <div class="form_container">
                            <h4 class="panel-heading">
                                提货单
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <table class="table" id="delivery_order">
                                    <thead>
                                    <tr>
                                        <th>提货单号</th>
                                        <th>品名材质</th>
                                        <th>规格</th>
                                        <th>定尺\板宽</th>
                                        <th>数量\吨</th>
                                        <th>批次号</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${blinfoList}" varStatus="status">
                                        <tr class="delivery_tr">
                                            <td>${item.contractno}</td>
                                            <td>${item.namematerials}</td>
                                            <td>${item.standard}</td>
                                            <td>${item.width}</td>
                                            <td>${item.quantity}</td>
                                            <td>${item.batch}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        
    </div>

</div>
<%@ include file= "/WEB-INF/views/modules/user_front/contacts/contacts_info.jsp"%>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
$(".learn_more_goods").click(function () {
    $('.goods_add_det').toggle();
})

$('#inputForm').bootstrapValidator({
    message: 'This value is not valid',
    fields: {
    	ooferprice: {
            message: '价格无效',
            validators: {
                notEmpty: {
                    message: '价格不能为空'
                },decimalTwo: {
                    message: '请输入正确的价格'
                },between: {
                    min: 0.001,
                    max:100000000,
                    message: '价格不能小于等于0'
                }
            }
        },oddloadweight: {
            message: '报价吨位无效',
            validators: {
                notEmpty: {
                    message: '报价吨位不能为空'
                },decimalFour: {
                    message: '报价吨位只能为小数或数字'
                }, lessThan: {
                    value: ($("#residualvolume").val() * 1),
                    message: '报价吨位不能大于货物剩余吨位！'
                },between: {
                    min: 0.001,
                    max:($("#residualvolume").val() * 1),
                    message: '报价吨位不能小于等于0'
                }
            }
        }
    }
});


    if ($("#residualvolume").val() == 0) {
        $("#btnSubmit").val("报价已结束");
        $("#btnSubmit").attr('disabled', 'disabled');
    } else {
        $("#btnSubmit").val("下一步,生成运单");
        

        $("#btnSubmit").click(function () {
            var isnul = true;
            
            if ($("#userid").val() == null || $("#userid").val() == "") {
                
                $.MsgBox.Alert("保存提示", "请输入用户！");
                return false;
            }
            if (($("#ooferprice").val() * 1) <= 0) {
                
                $.MsgBox.Alert("保存提示", "报价不能小于0");
                return false;
            }
            if (($("#oddloadweight").val() * 1) < 0) {
               
                $.MsgBox.Alert("保存提示", "报价吨位不能小于0");
                return false;
            }

            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                var gdsid = $("#gsid").val();
                var driverid = $("#driverid").val();
                var carid = $("#carid").val();
                var ooferprice = $("#ooferprice").val() * 1;
                var oddloadweight = $("#oddloadweight").val() * 1;
                var userid = $("#userid").val();
                $("#maskloading" , parent.document).show();
                $.ajax({
                    type: "POST",
                    url: '${wlpt}/wlpt/goods/saveAddQuote',
                    dataType: 'json',
                    data: {
                    	'userid':userid,
                        'goods.id': gdsid,
                        'ooferprice': ooferprice,
                        'oddloadweight': oddloadweight

                    },
                    cache: false,
                    success: function (data) {
                    	if (data.value.state == 1) {
                            if(data.value.data !=null && data.value.data.id!=""){
                            	window.location.href = '${wlpt}/wlpt/goods/quoteOrder?id='+data.value.data.id;
                            }else{
                            	window.location.href = '${wlpt}/wlpt/goods/goods_list?isRedrect=true';
                            }
                            
                        } else {
                        	$("#maskloading" , parent.document).hide();
                        	if(data.value.message == "已报价,请勿重复报价"){
                        		$.MsgBox.Alert("保存提示", "已报价,无法指派,请在查看报价页面，点击“生成运单”");
                        		
                        	}else if(data.value.message == "内部货源信息,无法报价"){
                        		$.MsgBox.Alert("保存提示", "内部货源信息,无法指派");
                        		
                        	}else{
                        		$.MsgBox.Alert("保存提示", data.value.message);
                        	}
                            
                        }
                        
                    }
                });
            }
        });
    }
    function updatePraiseNumber() {
        var gdsid = $("#gsid").val();
        var num =${goods.praisenumber};
        var newnum = $("#num").html();
        if ((num * 1) < (newnum * 1)) {
            return;
        }
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/goods/updatePraiseNumber',
            dataType: 'json',
            data: {
                'id': gdsid
            },
            cache: false,
            success: function (data) {

                $("#num").html(num + 1);
            }
        });
    }

function search() {
	var searchinfo = $("#searchinfo").val();
    if (searchinfo!='' || searchinfo!="") {
    	$("#maskloading" , parent.document).show();
        $.ajax({
            url: "${wlpt}/wlpt/goods/searchInfo",
            dataType: 'json',
            data: {searchinfo: searchinfo},
            cache: false,
            success: function (data) {
            	$("#maskloading" , parent.document).hide();
            	if (data) {
            		if (data.value == '未查到指定用户') {
            			$("#info").hide();
            			$("#search_img").show();
                        
                        $.MsgBox.Alert("温馨提示", "未查到指定用户!请确认用户是否已注册");
                    } else if(data.value=='该用户无车辆信息'){
                    	$("#info").hide();
                    	$("#search_img").show();
                    	$.MsgBox.Alert("温馨提示", "该用户无车辆信息,不可指派");
                    }else if(data.value=='该用户无司机信息'){
                    	$("#info").hide();
                    	$("#search_img").show();
                    	
                    	$.MsgBox.Alert("温馨提示", "该用户无司机信息,不可指派");
                    }else if (data.value == '不能指派给自己') {
                    	$("#info").hide();
                    	$("#search_img").show();
                        $.MsgBox.Alert("温馨提示", '不能指派给自己');
                    } else {
                    	if(data.value.user.id== '${user.id}'){
                    		$("#info").hide();
                        	$("#search_img").show();
                        	$.MsgBox.Alert("温馨提示", "不能指派给自己");
                    	}else if(data.value.role.enname!="carowner"&&data.value.role.enname!="enterprise"){
                        	$("#info").hide();
                        	$("#search_img").show();
                        	$.MsgBox.Alert("温馨提示", "只能指派给物流企业或车主");
                        }else{
                        	if (data.value.role.enname) {
                                $("#role").val(data.value.role.enname);
                            }else{
                            	$("#role").val("");
                            }
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }else{
                            	$("#userid").val("");
                            }
                            if (data.value.user.loginName) {
                                $("#login").html(data.value.user.loginName);
                            }else{
                            	$("#login").html("");
                            }
                            if (data.value.user.name) {
                                $("#name").html( data.value.user.name);
                            }else{
                            	$("#name").html("");
                            }
                            if (data.value.user.phone) {
                                $("#phone").html( data.value.user.phone);
                            }else{
                            	$("#phone").html("");
                            }
                            /* if (data.value.user.email) {
                                $("#email").html( data.value.user.email);
                            } */
                            /* if (data.value.info.sex) {
                                if (data.value.info.sex == '1') {
                                    $("#sex").html('男');
                                }
                                if (data.value.info.sex == '0') {
                                    $("#sex").html('女');
                                }
                            } */
                            if (data.value.info.status) {
                                if (data.value.info.status == '2') {
                                    $("#status").html('认证通过');
                                } else {
                                    $("#status").html('未通过');
                                }

                            }
                            $("#info").show();
                            $(".search_img").hide();
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            
                        }
                        
                    }
                }
            }
        });
        
    }else{
    	$.MsgBox.Alert("温馨提示", '请填写指派用户信息');
    }
   
}


</script>
</body>
</html>
