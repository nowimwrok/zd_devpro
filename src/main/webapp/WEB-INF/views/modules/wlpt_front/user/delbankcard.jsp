<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户银行卡管理</title>
    <style type="text/css">
        body {
            padding: 0;
            width: 100%;
            border: 1px solid #D6D3CE;
        }

        .cash_title {
            margin: 20px 0 50px 20px;
            height: 50px;
            line-height: 50px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
    </style>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
<div class="cash_title">
    <img src="${ctxStatic }/images/wlptfront/write.png"><span class="cash_title_con">删除银行卡</span>
</div>

<form:form id="inputForm" modelAttribute="userBankinfo" action="${ctx}/wlpt/user/userBank/bankBind" method="post" class="col-sm-8 form-horizontal">
    <form:hidden path="id"/>

   <%--  <input type="hidden" name="user.id" value="${model.id}">

    <div class="form-group">
        <label for="bindname" class="col-sm-4 control-label">持卡人：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="bindname" name="bindname" readonly value="${loginUser.name}" >
        </div>
    </div> --%>
	<input class="form-control" id="id" name="id" readonly value="${model.id}" type="hidden" >
    <div class="form-group">
        <label for="bankcard" class="col-sm-4 control-label">账户名：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="accountName" name="accountName" readonly value="${model.accountName }">
        </div>
    </div>
    
    <div class="form-group">
        <label for="bankcard" class="col-sm-4 control-label">卡号：</label>
        <div class="col-sm-8">
            <input type="tel" class="form-control" id="bankcard" name="bankcard" readonly value="${model.bankcard}">
        </div>
    </div>

    <div class="form-group">
        <label for="bindphone" class="col-sm-4 control-label">手机号：</label>
         <div class="col-sm-8 ">
            <input type="text" class="form-control" id="bindphone" name="bindphone" readonly value="${ model.bindphone}">
         	<input  type="button" value="获取验证码" class="btn btn-primary pull-right" id="sendRegCode">
        </div>
        
    </div>
	
	<div class="form-group">
		<label class="col-sm-4 control-label">手机验证码：</label>
		<div class="col-sm-8">
            <input type="text" class="form-control" id="validateCode" name="validateCode">
		</div>
	</div> 
	
    <div class="form-group">
        <label class="col-sm-4 control-label">所属银行：</label>
        <div class="col-sm-8">
            <%-- <form:select path="unionpayNo" class="form-control">
                <form:options items="${fns:getDictList('unionpay_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select> --%>
            <input type="text" class="form-control" id="banktype" name="banktype" readonly value="${model.banktype }">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-4 control-label">支行名称：</label>
        <div class="col-sm-8">
            <%-- <form:select path="unionpayNo" class="form-control">
                <form:options items="${fns:getDictList('unionpay_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select> --%>
            <input type="text" class="form-control" id="bankname" name="bankname" readonly  value="${model.bankname }">
        </div>
    </div>
    
<!--     <div class="form-group">
        <label class="col-sm-4 control-label">提现密码：</label>
        <div class="col-sm-8">
            <input id="password"  type="password" name="password" class="form-control"/>
        </div>
    </div> -->


    <input type="button" id="submit" onclick="remove();" class="btn btn-primary pull-right" value="删除"/>
</form:form>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script>
/* $("#bankcard").change(function () {
	var bankcard=$("#bankcard").val();
	$.ajax({
        url: "${wlpt}/wlpt/user/userBank/getNameByCard",
        dataType: 'json',
        type: "post",
        data : {"cardNo":bankcard},
        success: function (data) {
        	if (data.state == 1) {
        		$("#banktype").val(data.message);
        	}else{
        		$("#banktype").val("");
        	}
        }
    });
}); */
var remove=function remove(){
	var status='${loginUser.userinfo.status}';
/* 	if(status==null||status==''||status==undefined||status!='2'){
		$("#submit").tips({
            side: 3,
            msg: '请先完成认证',
            bg: '#00A2E9',
            time: 4
        });
        return false;
	} */
	var nul = true;
	nul = nul && $("#accountName").valid({
        methods: "required"
    });
    nul = nul && $("#bankcard").valid({
        methods: "required|isBankAccountNumber"
    });
    nul = nul && $("#bindphone").valid({
    	methods: "required|isPhone"  
    });
    nul = nul && $("#banktype").valid({
    	methods: "required"
    });
    nul = nul && $("#bankname").valid({
    	methods: "required"
    });
/*     nul = nul && $("#password").valid({
    	methods: "required"  
    }); */
    nul = nul && $("#validateCode").valid({
    	methods:"required"
    });
    
	if ($("#validateCode").val().length != 6) {
		$("#validateCode").tips({
			side : 3,
			msg : '验证码长度为6位！',
			bg : '#00A2E9',
			time : 3
		});
		return false;
	}
	
	checkValidateCode();
	
     if(nul){
    	 
    	 window.location.href = "${wlpt}/wlpt/user/userBank/deteleBank?id=" + '${model.id}';
  
/*     	 		$.ajax({
	            url: "${ctx}/wlpt/user/validateCashPwd",
	            dataType: 'json',
	            data:{"cashPwd":$("#password").val(),"isSave":false},
	            type: "post",
	            success: function (data) {
	                if (data == false) {
	                	$("#password").tips({
	                        side: 3,
	                        msg: '支付密码错误或未设置支付密码',
	                        bg: '#00A2E9',
	                        time: 4
	                    });
	                }else{
    	               $.ajax({
                            url: "${wlpt}/wlpt/user/userBank/bankBind?" + $("#inputForm").serialize(),
                            dataType: 'json',
                            type: "post",
                            success: function (data) {
                               if (data.value.state == 1) {
                                    window.location.href = '${wlpt}/wlpt/user/userBank/userBank';
                               } else {
                                    $.MsgBox.Alert("保存提示", data.value.message);
                               }
                            }
                     });
                   }
	            }
    		}); */
    	
    } 
}  
       
 
</script>

<script type="text/javascript">
	$("#sendRegCode").click(function(){
		var phone = $("#bindphone").val();
		
		if($("#bindphone").val() != null && $("#bindphone").val() !="" ){
			$.ajax({
				type:"POST",
				url:"${wlpt}/wlpt/personal/sendRegCode",
				data:{phone : $("#bindphone").val()},
				dataType:"json",
				cache:false,
				success:function(data){
					var message = data;
					if (message){
						sendTimeBtn($("#sendRegCode"));
					}else {
						$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
					}					
				},
				error : function() {
					$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
				}
			}); 
			
		}else{
			$("#bindphone").tips({
				side:3,
				msg:"手机号不能为空",
				bg:'#00A2E9',
				time:4
			});
		}
				
	});
	
	function checkValidateCode(){
		$.ajax({
			type:"POST",
			url:"${wlpt}/wlpt/personal/checkRegCode",
			data:{phone:$("#bindphone").val(),regcode:$("#validateCode").val()},
			dataType:"json",
			async:false,
			success:function(data){
				if (data == false) {
					$("#validateCode").tips({
						side:3,
			            msg:'验证码有误或已过期',
			            bg:'#00A2E9',
			            time:4
			        });
					$("#validateCode").focus();
					return false;
				}
			}
		});
	}
</script>
</body>
</html>

