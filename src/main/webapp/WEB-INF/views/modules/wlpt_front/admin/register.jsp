<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <title>注册</title>
    <meta name="decorator" content="site_default_basic"/>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link
            href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css"
            type="text/css" rel="stylesheet"/>
    <script
            src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js"
            type="text/javascript"></script>
    <link href="${ctxStatic}/common/jeesite.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff;
            font-family: "微软雅黑" !important;
        }

        @media screen and (max-width: 900px) {
            body {
                font-size: 1rem;
            }
        }

        input[type="text"], input[type="password"], input[type="textarea"] {
            padding-left: 5px;
            height: 35px !important;
        }

        .control-group {
            padding-bottom: 8px;
            margin-bottom: 0;
            border-bottom: 0px;
        }

        .form-actions {
            background-color: #fff;
            border-top: 0px;
        }

        .container {
            width: 100%;
        }

        .control-label {
            padding-top: 10px;
        }
        .form-horizontal .control-label {
            padding-top: 10px;
        }
    </style>
    <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
    <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
    <script type="text/javascript"
            src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
    <script type="text/javascript">
        $(document)
                .ready(
                        function () {
                            var message = "${message}";
                            $("#no").focus();
                            $("#inputForm")
                                    .validate(
                                            {
                                                rules: {
                                                    loginName: {remote: "${wlpt}/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')},
                                                    phone: {
                                                        remote: {
                                                            url: "${wlpt}/checkPhone",
                                                            type: "post",
                                                            data: {
                                                                phone: function () {
                                                                    return $("#phone").val()
                                                                }
                                                            }
                                                        }
                                                    },
                                                    validateCode: {
                                                        remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"
                                                    },
                                                    regcode: {
                                                        remote: {
                                                            url: "${wlpt}/checkRegCode",
                                                            type: "post",
                                                            data: {
                                                                phone: function () {
                                                                    return $("#phone").val()
                                                                },
                                                                regcode: function () {
                                                                    return $("#regcode").val()
                                                                }
                                                            }
                                                        }
                                                    }

                                                },
                                                messages: {
                                                    loginName: {remote: "用户登录名已存在"},
                                                    phone: {
                                                        remote: "手机号已存在"
                                                    },
                                                    validateCode: {
                                                        remote: "验证码不正确.",
                                                        required: "请填写验证码."
                                                    },
                                                    confirmNewPassword: {
                                                        equalTo: "输入与上面相同的密码"
                                                    },
                                                    regcode: {
                                                        remote: "验证码有误或已过期"
                                                    }
                                                },
                                                submitHandler: function (form) {
                                                    loading('正在提交，请稍等...');
                                                    form.submit();
                                                },
                                                errorContainer: "#messageBox",
                                                errorPlacement: function (error,
                                                                          element) {
                                                    $("#messageBox").text(
                                                            "输入有误，请先更正。");
                                                    if (element.is(":checkbox")
                                                            || element.is(":radio")
                                                            || element.parent().is(".input-append")) {
                                                        error.appendTo(element
                                                                .parent().parent());
                                                    } else {
                                                        error.insertAfter(element);
                                                    }
                                                } 
                                            });

                            $("#sendRegCode").click(function () {
                                validRegCode();
                            });

                            function validRegCode() {
                            	var phone = $("#phone").val();
                                $
                                        .ajax({
                                            type: "POST",
                                            url: '${wlpt}/sendRegCode',
                                            dataType: 'json',
                                            data: {
                                                phone: phone
                                            },
                                            cache: false,
                                            success: function (data) {
                                                var message = data;
                                                if (message) {
                                                    sendTimeBtn($("#sendRegCode"));
                                                } else {
                                                	$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
                                                    
                                                }

                                            },
                                            error: function () {
                                            	$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
                                            }
                                        });
                            }
                        });
    </script>
</head>
<body>
<div class="register_wrap">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span
            class="title_blue">注册</span><span class="title_orange">用户</span><img
            src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <form:form id="inputForm" modelAttribute="user"
               action="${wlpt}/register" method="post"
               style="width: 550px;margin: 0px auto;background:none !important;"
               class="form-horizontal">
        <form:hidden path="id"/>
        <sys:message content="${message}"/>
        <input type="hidden" name="role" value="${role.enname }"/>
        <div class="control-group">
            <label class="control-label">登录名:</label>
            <div class="controls">
                <input id="oldLoginName" name="oldLoginName" type="hidden" value="${user.loginName}">
                <form:input path="loginName" htmlEscape="false" maxlength="50" class="required userName"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">手机号码:</label>
            <div class="controls">
                <form:input path="phone" id="phone" htmlEscape="false"
                            maxlength="11" cssClass="required mobile"/>
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">密码:</label>
            <div class="controls">
                <input id="newPassword" name="newPassword" required="required" type="password" value=""
                       maxlength="18" minlength="6"
                       class="${empty user.id?'required':''}"/>
                <c:if test="${empty user.id}">
                    <span class="help-inline"><font color="red">*</font> </span>
                </c:if>
                <c:if test="${not empty user.id}">
                    <span class="help-inline">若不修改密码，请留空。</span>
                </c:if>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">确认密码:</label>
            <div class="controls">
                <input id="confirmNewPassword" name="confirmNewPassword"
                       type="password" value="" maxlength="50" minlength="3"
                       equalTo="#newPassword"/>
                <c:if test="${empty user.id}">
                    <span class="help-inline"><font color="red">*</font> </span>
                </c:if>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label mid" for="validateCode">验证码:</label>
            <div class="controls">
                <input type="text" name="regcode"
                       style="width: 60px; text-align: center;" required="required" id="regcode" class=""/>
                <input type="button" id="sendRegCode" style="margin-left: 20px;"
                       value="获取验证码" class="btn btn-primary"/>
            </div>
        </div>
        <%--  <div class="control-group">
    <label class="control-label mid" for="validateCode">验证码:</label>
    <div class="controls">
        <sys:validateCode name="validateCode"  inputCssStyle="margin-bottom:0;width:60px !important;"/>
    </div>
</div> --%>
        <div class="control-group">
                <%-- <input id="chkCondition" type="checkbox" value="1" onclick="iswhitelistid()"/>
                     <span style="font-size:12px;">我已阅读</span> --%>
            <a target="_blank" onclick="openagreement('register');" style="line-height: 30px;text-decoration: none;">《卓大物流平台注册协议》</a>
        </div>
        <div class="form-actions" style="margin-left: -169px;margin-top: 0px;">
            <input id="btnSubmit" class="btn btn-primary" type="submit"
                   value="我已阅读并同意"/>&nbsp; <input id="btnCancel" class="btn"
                                                  type="button" value="返 回" onclick="history.go(-1)"/>
        </div>

    </form:form>
</div>
<script type="text/javascript">
    function iswhitelistid() {
        if ($("#WHITELISTID").prop("checked")) {
            $("#btnSubmit").attr('disabled', 'true');
        } else {
            $("#btnSubmit").attr('disabled', 'false');
        }
    }
</script>
</body>
</html>