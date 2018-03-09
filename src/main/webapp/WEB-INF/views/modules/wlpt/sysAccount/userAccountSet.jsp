<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员绑定</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if('${message}'!=null&&'${message}'!=''){
				top.$.jBox.tip('${message}', 'warning');
			}
			$("#btnSubmit").click(
					function() {
						var isnul = true;
						isnul = isnul && $("#memberId").valid({
							methods : "required"
						});
						if(!isnul){
							return false;
						}
						isnul = isnul && $("#target").valid({
							methods : "required|isPhone"
						});
						if (!isnul) {
							return false;
						}
						$("#inputForm").submit();
					});
			$("#memberId").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/wlpt/account/getMemberInfo',
                    dataType: 'json',
                    data: {memberId: $("#memberId").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                        	if(data.value){
                        		$("#bankAccount").html(data.value.bankAccount);
                                $("#accountName").html(data.value.accountName);
                        	}else{
                        		top.$.jBox.tip('请填写正确的memberId', 'warning');
                        	}
                        } else {
                            top.$.jBox.tip('请填写正确的memberId', 'warning');
                        }
                    },
                    error: function () {
                        top.$.jBox.tip('账户不存在', 'warning');
                    }
                });
            });
			$("#target").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#target").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            $("#loginName").html(userinfo.loginName);
                            $("#name").html(userinfo.name);
                        } else {
                            top.$.jBox.tip('请填写正确的手机号码', 'warning');
                        }
                    },
                    error: function () {
                        top.$.jBox.tip('用户不存在', 'warning');
                    }
                });
            });
		});
	</script>
</head>
<body>
  <h3>
    <span style="display: inline-block;width: 49%;"></span>
  </h3>
  <form:form id="inputForm" action="${ctx}/wlpt/user/userApplicationAccount/bindUserAccount" method="post" class="form-horizontal">
    <div class="control-group">
        <label class="control-label">memberID：</label>
        <div class="controls">
            <input id="memberId" name="memberId" htmlEscape="false" maxlength="255" class="input-xlarge"/>
        </div>
    </div>
    <div class="control-group">
            <label class="control-label">银行账户号：</label>
            <div class="controls">
                <label class="lbl" id="bankAccount"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">账户名：</label>
            <div class="controls">
                <label class="lbl" id="accountName"></label>
            </div>
    </div>
    
    <div class="control-group">
        <label class="control-label">绑定用户：</label>
        <div class="controls">
            <input id="target" name="target" htmlEscape="false" maxlength="255" class="input-xlarge" placeholder="用户手机号码"/>
        </div>
    </div>
    <div class="control-group">
            <label class="control-label">登录名：</label>
            <div class="controls">
                <label class="lbl" id="loginName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="name"></label>
            </div>
    </div>
   
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="button" value="绑定"/>&nbsp;
        <input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>