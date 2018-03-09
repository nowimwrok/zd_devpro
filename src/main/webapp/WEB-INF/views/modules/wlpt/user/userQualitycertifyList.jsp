<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
<title>认证信息管理</title>
<meta name="decorator" content="default" />
<%@include
	file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<style type="text/css">
#modal_check .modal-backdrop {
	display: none;
}

#modal_check .check_service input[type=checkbox] {
	top: -3px;
}

#modal_check .form-group .control-label {
	text-align: left;
}

#modal_check {
	padding-right: -10px !important;
}
</style>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>

<!-- <script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script	src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script> -->

<script type="text/javascript">
	$(document).ready(function() {
		var num=$("#certifytype").val();
		if(num!=''){
    		$("#target").show();
    	}else{
    		$("#target").hide();
    		$("#targetInfo").val('');
    	}
        $("#certifytype").change(function(){
        	if($("#certifytype").val()!=''){
        		$("#target").show();
        	}else{
        		$("#target").hide();
        		$("#targetInfo").val('');
        	}
        })
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/user/userQualitycertify/">认证信息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="userQualitycertify"
		action="${ctx}/wlpt/user/userQualitycertify/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>关键字：</label> <form:input path="searchinfo"
					htmlEscape="false" maxlength="50" class="input-medium"
					placeholder="用户名/手机" /></li>
			<li><label>认证类型：</label> <form:select path="certifytype"
					class="input-medium">
					<form:option value="" label="" />
					<form:option value="" label="全部" />
					<form:options items="${fns:getDictList('certify_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li id="target" hidden="hidden"><label>认证信息：</label> <form:input
					path="targetInfo" htmlEscape="false" maxlength="50"
					class="input-medium" /></li>
			<li><label>认证状态：</label> <form:select path="certifystatus"
					class="input-medium">
					<form:option value="" label="" />
					<form:option value="" label="全部" />
					<form:options items="${fns:getDictList('user_authen')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li><label>认证时间：</label> <input name="beginRequesttime"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate" placeholder="开始时间"
				value="<fmt:formatDate value="${userQualitycertify.beginRequesttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				- <input name="endRequesttime" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate" placeholder="结束时间"
				value="<fmt:formatDate value="${userQualitycertify.endRequesttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width: 6%;">认证类型</th>
				<th style="width: 6%;">认证角色</th>
				<th style="width: 10%;">认证用户</th>
				<th style="width: 10%;">认证人手机号</th>
				<th style="width: 10%;">认证信息</th>
				<th style="width: 12%;">申请时间</th>
				<th style="width: 6%;">审批人</th>
				<th style="width: 6%;">认证状态</th>
				<th style="width: 18%;">审核说明</th>
				<th style="width: 10%;">认证时间</th>
				<shiro:hasPermission name="wlpt:user:userQualitycertify:edit">
				<th style="width: 6%;">操作</th>
				<th style="width: 10%;">车辆信息</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="userQualitycertify">
				<tr id="tr1">
					<td><a
						href="${ctx}/wlpt/user/userQualitycertify/form?id=${userQualitycertify.id}">
							<c:if test="${userQualitycertify.certifytype == 0}">个人信息</c:if> <c:if
								test="${userQualitycertify.certifytype == 1}">企业信息</c:if> <c:if
								test="${userQualitycertify.certifytype == 2}">车辆信息</c:if> <c:if
								test="${userQualitycertify.certifytype == 3}">司机信息</c:if>
					</a></td>
					<td>${userQualitycertify.requestuser.role.name}</td>
					<td id="name">${userQualitycertify.requestuser.loginName}</td>
					<td id="phone">${userQualitycertify.requestuser.phone}</td>

					<td id="vclN"><c:if
							test="${userQualitycertify.certifytype == 0}">${userQualitycertify.requestuser.loginName}</c:if>
						<c:if test="${userQualitycertify.certifytype == 1}">${userQualitycertify.companyInfo}</c:if>
						<c:if test="${userQualitycertify.certifytype == 2}">${userQualitycertify.carInfo}</c:if>
						<c:if test="${userQualitycertify.certifytype == 3}">${userQualitycertify.driverInfo}</c:if>
					</td>

					<td><fmt:formatDate value="${userQualitycertify.requesttime}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>

					<td>${userQualitycertify.certifyuser.loginName}</td>
					<td><c:if test="${userQualitycertify.certifystatus == 0}">未认证</c:if>
						<c:if test="${userQualitycertify.certifystatus == 2}">认证不通过</c:if>
						<c:if test="${userQualitycertify.certifystatus == 1}">认证通过</c:if>
					</td>
					<td>${userQualitycertify.certifycomment}</td>
					<td><fmt:formatDate value="${userQualitycertify.certifytime}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<shiro:hasPermission name="wlpt:user:userQualitycertify:edit">
						<td><a
							href="${ctx}/wlpt/user/userQualitycertify/form?id=${userQualitycertify.id}">审核</a>
							<%-- <a
							href="${ctx}/wlpt/user/userQualitycertify/delete?id=${userQualitycertify.id}"
							onclick="return confirmx('确认要删除该认证信息吗？', this.href)">删除</a> --%>
							  <%-- <c:if test="${userQualitycertify.certifytype == 2}">
							  	<input type="button" id="msg_regist" data-toggle="modal" data-target="#modal_check"  onclick="checkinfo('${userQualitycertify.requestuser.phone}','${userQualitycertify.requestuser.loginName}','${userQualitycertify.carInfo}','${userQualitycertify.id}');" value="信息校验"/>
							  </c:if> --%> 
							</td>
						<td>
							<c:if test="${userQualitycertify.certifytype == 2}">
							  	<input type="button" class="btn btn-primary" id="msg_regist" data-toggle="modal" data-target="#modal_check"  onclick="checkinfo('${userQualitycertify.requestuser.phone}','${userQualitycertify.requestuser.loginName}','${userQualitycertify.carInfo}','${userQualitycertify.id}');" value="车辆校验"/>
							  </c:if>
						</td>
								
						
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<!-- ------------------------------------------------------- -->
		<!--信息校验弹框-->
            	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal_check" class="modal" style="margin:auto;overflow-y:hidden;">
            		<div>
            			<div class="modal-content">
            				<div class="modal-header">
                                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                                <h4 class="modal-title">信息校验</h4>
                            </div>
                            <div class="modal-body form-horizontal">
                            	<!--司机信息-->
                            	<div class="col-sm-12 clearfix driver_msg">
                            		<div class="col-sm-4 form-group clearfix pull-left">
                            			<div class="pull-left control-label" >司机：</div>
                            			<div class="pull-left control-label">
                            				<span id="driver"></span>
                            				<input type="hidden" id="carid"/>
                            				<input type="hidden" id="area"/>
                            				<input type="hidden" id="rtcNo"/>
                            				
                            			</div>
                            		</div>
                            		<div class="col-sm-4 form-group clearfix pull-left">
                            			<div class="pull-left control-label">手机号：</div>
										<div class="pull-left control-label">
                            				<span id="phones"></span>
                            			</div>
                            		</div>
                            		<div class="col-sm-4 form-group pull-right">
                            			<div class="pull-left control-label">车牌：</div>
                            			<div class="pull-left control-label">
                            				<span id="vclns"></span>
                            			</div>
                            		</div>
                            	</div>
                            	<!--校验服务-->
                            	<div class="col-sm-12 check_box">
                            		<div class="check_service col-sm-12 check_before">
                            			<h5 class="service_title text-center">校验服务</h5>
                            			<div class=" col-sm-12 clearfix">
                            				<div class="col-sm-12 clearfix" id="maxcheckbox">
	                            				<div class="col-sm-4 pull-left form-group">
	                            					<label for="car_net">
	                                                	<input name="check" id="car_net" type="checkbox" value="1">车辆入网验证
	                                                	<span  style="color:#F00"
	                                                	>${fns:getMsgLabel("zjxl001","zjxl_port","")}元</span>
	                                            	</label>
	                            				</div>
	                            				<div class="col-sm-4 pull-left form-group">
	                            					<label for="user_check">
	                                                	<input name="check" id="user_check" type="checkbox" value="2">车主真实性验证
	                                            		<span  style="color:#F00"
	                                            		>${fns:getMsgLabel("zjxl004","zjxl_port","")}元</span>
	                                            	</label>
	                            				</div>
	                            				<div class="col-sm-4 pull-right form-group">
	                            					<label for="deck_check">
	                                                	<input name="check" id="deck_check" type="checkbox" value="3">套牌验证
	                                            		<span  style="color:#F00"
	                                            		>${fns:getMsgLabel("zjxl005","zjxl_port","")}元</span>
	                                            	</label>
	                            				</div>
	                            				<div class="col-sm-4 pull-left form-group">
	                            					<label for="road_check">
	                                                	<input name="check" id="road_check" type="checkbox" value="4">道路许可证验证
	                                            		<span  style="color:#F00"
	                                            		>${fns:getMsgLabel("zjxl003","zjxl_port","")}元</span>
	                                            	</label>
	                            				</div>
	                            				<div class="col-sm-4 pull-left form-group">
	                            					<label for="check">
	                                                	<input name="check" id="license_check" type="checkbox" value="5">车辆行驶证信息查询
	                                            		<span  style="color:#F00"
	                                            		>${fns:getMsgLabel("zjxl002","zjxl_port","")}元</span>
	                                            	</label>
	                            				</div>
                            					<!--服务费用-->
	                            				<div class="col-sm-12 fee_box" style="margin-left:25px;">
	                            					服务费：￥<span class="fee fee_bold" id="price">0.00</span><span class="fee"></span>元
	                            				</div>
	                            				<!--平台收费协议-->
	                            				<div class="col-sm-12 agree_box text-center">
	                            					<label for="agree">
	                                                	<input name="agree" id="agree" type="checkbox" checked ='checked' onclick="checkagree()" value="88">《平台增值服务收费协议》
	                                            	</label>
	                            				</div>
	                            				<div class="col-sm-12 submit_box text-center">
	                            					<button class="btn" id="subButton"  onclick="subinfo()">提交</button>
	                            				</div>
                            				</div>
                            			</div>
                            		</div>
                            		<!--点提交后显示的信息-->
                            		<div class="check_service check_after col-sm-12">
                            			<div class="col-sm-12">
                            				<h5 class="service_title text-center pull-left ">校验结果</h5>
                            				<button class="btn btn-warning pull-right back_look">返回查询</button>
                            			</div>
                            			
                            			<div class="col-sm-12 clearfix driver_msg">
			                            	<div class="col-sm-4 form-group clearfix pull-left" id="div1" style="display:none">
			                            		<div class="pull-left control-label" >入网验证：</div>
			                            		<div class="pull-left control-label" id="truckstatus">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="col-sm-4 form-group clearfix pull-left" id="div2" style="display:none">
			                            		<div class="pull-left control-label" >车主真实性：</div>
			                            		<div class="pull-left control-label" id="ownerstatus">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="col-sm-4 form-group pull-right" id="div3" style="display:none">
			                            		<div class="pull-left control-label" >是否套牌：</div>
			                            		<div class="pull-left control-label" id="areastatus">
			                            			
			                            		</div>
			                            	</div>
                            			</div>
	                            		<div class="col-sm-12 clearfix driver_msg " id="div4" style="display:none">
			                            	<div class="form-group clearfix pull-left driver_msg_road">
			                            		<div class="pull-left control-label">道路许可证：</div>
			                            		<div class="pull-left control-label" id="portcard">
			                            			
			                            		</div>
			                            	</div>
			                            	<div class="form-group clearfix pull-left">
			                            		<div class="pull-left control-label">有效期：</div>
			                            		<div class="pull-left control-label" id="dityterm">
			                            			
			                            		</div>
			                            	</div>
	                            		</div>
	                            		<div class="col-sm-12 license_msg" id="div5" style="display:none"s>
	                            			<div class="col-sm-12 license_title" style="margin-left:30px;">行驶证信息：</div>
	                            			<div class="col-sm-12">
		                            			<table class="table table-bordered table-striped">
		                            				<tr class="table_title"><th>名称</th><th>数据</th></tr>
		                            				<tr><td>联系人</td><td id="vclWnrNm"></td></tr>
		                            				<tr><td>联系人手机</td><td id="vclWnrPhn"></td></tr>
		                            				<tr><td>车籍地</td><td id="areaName"></td></tr>
		                            				<tr><td>车辆类型</td><td id="vclTpNm"></td></tr>
		                            				<tr><td>车辆品牌</td><td id="vbrndCdNm"></td></tr>
		                            				<tr><td>车辆型号</td><td id="prdCdNm"></td></tr>
		                            				<tr><td>车主/业主</td><td id="cmpNm"></td></tr>
		                            				<tr><td>车辆识别代码/车架号</td><td id="vin"></td></tr>
		                            				<tr><td>服务商名</td><td id="serviceName"></td></tr>
		                            				<tr><td>总质量</td><td id="vclTn"></td></tr>
		                            				<tr><td>核定载重量(Kg)</td><td id="ldTn"></td></tr>
		                            				<tr><td>准牵引总重量(Kg)</td><td id="vclDrwTn"></td></tr>
		                            				<tr><td>外廓尺寸长(mm)</td><td id="vclLng"></td></tr>
		                            				<tr><td>外廓尺寸宽(mm)</td><td id="vclWdt"></td></tr>
		                            				<tr><td>外廓尺寸高(mm)</td><td id="vclHgt"></td></tr>
		                            			</table>
	                            			</div>
	                            		</div>
                            		</div>
                            	</div>
                            </div>
            			</div>
            		</div>
            	</div>

	<script>

	//信息验证弹框
	$('#modal_check td').css('width','49%');
	 //点击提交后 上滑
    var after_h=$('.check_after').height();
    $('.submit_box .btn').click(function(){
    	var checkbox = document.getElementById("agree");//选中checkbox的id；
    	var SelectFalse = false; //用于判断是否被选择条件
    	var CheckBox = $('input[name = check]');//得到所的复选框
    	for(var i = 0; i < CheckBox.length; i++){
    								     //jquery1.6以上可以if(CheckBox[i].prop('checked') == true)去判断checkbox是否被选中
	    	if(CheckBox[i].checked){        //如果有1个被选中时
	    		SelectFalse = true;
	    	
	    	}
    	}
        if( SelectFalse && checkbox.checked==true){//按钮已选中
        	$('.check_before').animate({top:'-284px'},1000);
	    	$('.check_after').animate({top:'-284px'},1000);
	    	$('.check_after').show();
        }
    	
    });
	$('.back_look').click(function(){
		$('.check_before').animate({top:'0px'},1000);
		//$('.check_after').animate({top:after_h+'px'},1000);
		$('.check_after').animate({top:'0px'},1000);
		$('.check_after').hide();
	});
	
	
	function checkinfo(phone,loginName,carNum,carid){
		$("#driver").html(loginName);
    	$("#phones").html(phone);
    	$("#vclns").html(carNum);
    	$("#carid").html(carid);
		
	};
	
	 //服务金额格式化
    $('#modal_check .fee_bold').each(function(){
		var s=$(this).text();
		n=2;  
		s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
		var l=s.split(".")[0].split("").reverse(),   
		r=s.split(".")[1];   
		t="";   
		for(i=0;i<l.length;i ++ )   
		{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
	    var num=t.split("").reverse().join("") + "." + r;//整个数字
	    var new_num=t.split("").reverse().join("");
	    var num_s=num.slice(-3);
	    $(this).text(new_num);
	    $(this).next().text(num_s);
	});
	
	
	//服务价格显示
	$('#maxcheckbox').click(function(){
		var price=0;
		if(document.getElementById("car_net").checked==true){
			price=price+${fns:getMsgLabel("zjxl001","zjxl_port","")};
		};
		if(document.getElementById("user_check").checked==true){
			price=price+${fns:getMsgLabel("zjxl004","zjxl_port","")};
		};
		if(document.getElementById("deck_check").checked==true){
			price=price+${fns:getMsgLabel("zjxl005","zjxl_port","")};
		};
		if(document.getElementById("road_check").checked==true){
			price=price+${fns:getMsgLabel("zjxl003","zjxl_port","")};
		};
		if(document.getElementById("license_check").checked==true){
			price=price+${fns:getMsgLabel("zjxl002","zjxl_port","")};
		};
		var s=price;
		n=2;  
		s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
		var l=s.split(".")[0].split("").reverse(),   
		r=s.split(".")[1];   
		t="";   
		for(i=0;i<l.length;i ++ )   
		{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
	    var num=t.split("").reverse().join("") + "." + r;//整个数字
	    var new_num=t.split("").reverse().join("");
	    var num_s=num.slice(-3);
	    $('#price').text(new_num);
	    $('#price').next().text(num_s);
		
	});
	
	//点击提交事件
    function subinfo(){
		
    	var SelectFalse = false; //用于判断是否被选择条件
    	var CheckBox = $('input[name = check]');//得到所的复选框
    	for(var i = 0; i < CheckBox.length; i++){
    								     //jquery1.6以上可以if(CheckBox[i].prop('checked') == true)去判断checkbox是否被选中
	    	if(CheckBox[i].checked){        //如果有1个被选中时
	    		SelectFalse = true;
	    	
	    	}
    	}
    	var checkbox = document.getElementById("agree");//选中checkbox的id；
        if( SelectFalse && checkbox.checked==true){//按钮已选中

	    	var name = $('#driver').text().trim();
	    	var phone = $('#phone').text().trim();
	    	var vcln = $('#vclns').text().trim();
	    	var carid=$('#carid').text().trim();
	    	console.log(carid);
	    	var s1="";
	    	var s2="";
	    	var s3="";
	    	var s4="";
	    	var s5="";
	    	var s6="";
	    	if($("#car_net").is(":checked")){//选中  车辆入网验证
	    		var s1 = "zjxl001";
	    		$('#div1').show();
	    	}else{
	    		$('#div1').hide();
	    	};
	    	if($("#user_check").is(":checked")){//选中  车主真实性验证
		    	var s2 = "zjxl004";
		    	$('#div2').show();
	    	}else{
	    		$('#div2').hide();
	    	};
		    if($("#deck_check").is(":checked")){//选中  套牌验证
		    	var s3 = "zjxl005";
		    	$('#div3').show();
		    }else{
	    		$('#div3').hide();
	    	};
			if($("#road_check").is(":checked")){//选中  道路许可证验证
				var s4 = "zjxl003";
				$('#div4').show();
			}else{
	    		$('#div4').hide();
	    	};
			if($("#license_check").is(":checked")){//选中 车辆行驶证信息查询
				var s5 = "zjxl002";
				$('#div5').show();
			}else{
	    		$('#div5').hide();
	    	};
			
			s6 = s1+","+s2+","+s3+","+s4+","+s5;
			
			var jsonstr = {
					"name"  : name,             //
					"phone" : phone,
					"vclN"  : vcln,
					 "vco"  : "2",
					 //"area" :"110108",         //
					                            //
					"regist": s6 ,
					"carid" :carid,
					"authentication":"0"
			};
					
			

		    	$.ajax({
		    		url :"${wlpt}/wlpt/totalvalida/totalVali",
		    		data : jsonstr,
		    		dataType : 'json',
		    		contentType:'charset=UTF-8',
					success : function(result) {

						console.log(result);
						var payinfo=result.data.paymentinfo;
						if(payinfo==2){
							alert("用户信息缺失");
							$('#div1').hide();
							$('#div2').hide();
							$('#div3').hide();
							$('#div4').hide();
							$('#div5').hide();
						};
						if(payinfo==5){
							alert("账户可用余额不足");
							$('#div1').hide();
							$('#div2').hide();
							$('#div3').hide();
							$('#div4').hide();
							$('#div5').hide();
						};
						if(s6.indexOf("zjxl005") > -1){
							//套牌车验证状态：0未校验，1已入网，-1未查询到
							//var sa=result.data.AreaByVclNo.checkareastatus;
							$('#areastatus').html("不是套牌");
							/* if(sa=="1"){
								$('#areastatus').html("不是");							
							};
							if(sa=="2"){
								$('#areastatus').html("是");	
							};
							if(sa=="-1"){
								$('#areastatus').html("未查询到");							
							}; */
						};
						if(s6.indexOf("zjxl001") > -1){
						    //车辆入网验证
						     $('#truckstatus').html("未查询到");
							$('#truckstatus').html(result.data.TruckExist.checktruckstatus);							
						};
						if(s6.indexOf("zjxl002") > -1){
							//车辆行驶证信息
							
							$('#vclWnrNm').html(result.data.vQueryLicense.vclWnrNm);
							$('#vclWnrPhn').html(result.data.vQueryLicense.vclWnrPhn);
							$('#areaName').html(result.data.vQueryLicense.areaName);
							$('#vclTpNm').html(result.data.vQueryLicense.vclTpNm);
							$('#vbrndCdNm').html(result.data.vQueryLicense.vbrndCdNm);
							$('#prdCdNm').html(result.data.vQueryLicense.prdCdNm);
							$('#cmpNm').html(result.data.vQueryLicense.cmpNm);
							$('#vin').html(result.data.vQueryLicense.vin);
							$('#serviceName').html(result.data.vQueryLicense.serviceName);
							$('#vclTn').html(result.data.vQueryLicense.vclTn);
							$('#ldTn').html(result.data.vQueryLicense.ldTn);
							$('#vclDrwTn').html(result.data.vQueryLicense.vclDrwTn);
							$('#vclLng').html(result.data.vQueryLicense.vclLng);
							$('#vclWdt').html(result.data.vQueryLicense.vclWdt);
							$('#vclHgt').html(result.data.vQueryLicense.vclHgt);
						};
						if(s6.indexOf("zjxl003") > -1){
						    //道路许可证信息
						    $('#portcard').html("未查询到");
						    $('#dityterm').html("未查询到");
						    if(undefined!=result.data.RTCNo.transportcard){
						    	
								$('#portcard').html(result.data.RTCNo.transportcard);
						    }
						    if(undefined!=result.data.RTCNo.validityterm){
						    	
								$('#dityterm').html(result.data.RTCNo.validityterm);
						    }
						};
						if(s6.indexOf("zjxl004") > -1){
							//判断车主真实性验证状态：0未校验，1真实，2姓名不匹配，3手机号码不匹配，-1未查询到
							var sa=result.data.OwnerByVclNo.checkownerstatus;
							$('#ownerstatus').html("未查询到");
							if(sa=="1"){
								$('#ownerstatus').html("真实");
							};
							if(sa=="2"){
								$('#ownerstatus').html("姓名不匹配");
							};
							if(sa=="3"){
								$('#ownerstatus').html("手机号码不匹配");
							};
							if(sa=="-1"){
								$('#ownerstatus').html("未查询到");
							};
						};
						
						
					},
					error : function(message){
						alert("失败");
					}
			
	    		
	    	});
            
        }else{
           alert("必须选中协议,并且选中一项服务");
        }
    	
    }
		$('.modal-backdrop').click(function(){
			$('.modal').css('display','');
		});
</script>

</body>

</html>