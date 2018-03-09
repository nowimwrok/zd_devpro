<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->

    <title>账户安全</title>
    <style type="text/css">
		.panel{border:0;}
    </style>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;" class="has-js">
    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
                    <ul class="nav nav-tabs tab-nav-tabs">
                        <li class="active"><a href="#change-login" data-toggle="tab">修改登录密码</a></li>
                        <li><a href="#change-pay" data-toggle="tab">修改支付密码</a></li>
                        <li><a href="#change-card" data-toggle="tab">修改一卡通密码</a></li>
                    </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="change-login">
                            <form id="update_LoginPwd_form" name="update_LoginPwd_form">
                                <div class="panel">
                                    <div class="col-sm-12 form-horizontal">
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">手机号码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input type="text" name="phone" id="login_phone"
                                                       value="${fns:getUser().phone}"
                                                       readonly class="form-control" placeholder="填写手机号码">
                                            </div>
                                        </div>

                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">短信验证码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <div class="input-group">
                                                    <input class="form-control" name="regcode" id="regcode"
                                                           placeholder="请输入短信验证码" value="">
                                                    <span class="input-group-addon get-code"
                                                          onclick="sendRegCode('login')"
                                                          id="login_sendRegCode">获取验证码</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">旧密码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input class="form-control" type="password" name="oldpassword"
                                                       placeholder="请输入旧密码" value="">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">新密码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input class="form-control" type="password" name="password"
                                                       id="password"
                                                       placeholder="请输入新密码" value="">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">确认新密码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input class="form-control" type="password" placeholder="确认密码"
                                                       name="repassword" id="repassword" value="">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 mt-10">
                                            <div class="col-sm-2 control-label text-right"></div>
                                            <div class="col-sm-2 text-left pr-0">
                                                <button class="btn btn-success btn-let-10px col-lg-11"
                                                        onclick="subform('Login')" id="sub_Loginpwd">
                                                    提交
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="change-pay">
                            <form id="update_CashPwd_form" name="update_CashPwd_form">
                                <div class="panel">
                                    <div class="col-sm-12 form-horizontal">
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">手机号码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input type="text" class="form-control" readonly name="phone"
                                                       id="cash_phone" value="${fns:getUser().phone}"
                                                       placeholder="填写手机号码">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">短信验证码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <div class="input-group">
                                                    <input class="form-control" name="regcode" placeholder="请输入短信验证码"
                                                           value="">
                                                    <span class="input-group-addon get-code"
                                                          onclick="sendRegCode('cash')"
                                                          id="cash_sendRegCode">获取验证码</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">新支付密码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input class="form-control" name="cashpassword" type="password" placeholder="请输入新支付密码"
                                                       value="">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">确认新支付密码：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input class="form-control" placeholder="请确认支付密码" type="password" name="recashpassword"
                                                       value="">
                                            </div>
                                        </div>
                                        <div class="form-group col-sm-12 mt-10">
                                            <div class="col-sm-2 control-label text-right"></div>
                                            <div class="col-sm-2 text-left pr-0">
                                                <button class="btn btn-success btn-let-10px col-lg-11"
                                                        onclick="subform('Cash')" id="sub_CashPwd">提交
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="change-card">
                            <form id="update_CardPwd_form" name="update_CardPwd_form">
                                <div class="panel">
                                    <div class="col-sm-12 form-horizontal">
                                        <div class="form-group col-sm-12">
                                            <div class="col-sm-2 control-label text-right">一卡通号：</div>
                                            <div class="col-sm-5 text-left pr-0">
                                                <input type="text" name="cardid" id="cardid" class="form-control"
                                                       readonly
                                                       value="${userMetroCard.cardid != null? userMetroCard.cardid:'您还未是一卡通会员'}">
                                            </div>
                                        </div>
                                        <c:if test="${not empty userMetroCard.cardid}">
                                            <div class="form-group col-sm-12">
                                                <div class="col-sm-2 control-label text-right">手机号码：</div>
                                                <div class="col-sm-5 text-left pr-0">
                                                    <input type="text" name="phone" id="card_phone"
                                                           value="${userMetroCard.mobile}" readonly
                                                           class="form-control" placeholder="填写手机号码">
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <div class="col-sm-2 control-label text-right">短信验证码：</div>
                                                <div class="col-sm-5 text-left pr-0">
                                                    <div class="input-group">
                                                        <input class="form-control" name="regcode" id="cardRegcode"
                                                               placeholder="请输入短信验证码" value="">
                                                        <span class="input-group-addon get-code"
                                                              onclick="sendRegCode('card')"
                                                              id="card_sendRegCode">获取验证码</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <div class="col-sm-2 control-label text-right">旧密码：</div>
                                                <div class="col-sm-5 text-left pr-0">
                                                    <input class="form-control" type="password" name="oldpassword"
                                                           placeholder="请输入旧密码" value="">
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <div class="col-sm-2 control-label text-right">新密码：</div>
                                                <div class="col-sm-5 text-left pr-0">
                                                    <input class="form-control" type="password" name="password"
                                                           placeholder="请输入新密码" value="">
                                                </div>
                                            </div>
                                            <div class="form-group col-sm-12">
                                                <div class="col-sm-2 control-label text-right">确认新密码：</div>
                                                <div class="col-sm-5 text-left pr-0">
                                                    <input class="form-control" type="password" placeholder="确认密码"
                                                           name="repassword" value="">
                                                </div>
                                            </div>
                                        </c:if>
                                        <div class="form-group col-sm-12 mt-10">
                                            <div class="col-sm-2 control-label text-right"></div>
                                            <div class="col-sm-2 text-left pr-0">
                                                <c:if test="${not empty userMetroCard.cardid}">
                                                    <button class="btn btn-success btn-let-10px col-lg-11"
                                                            onclick="subform('Card')" id="sub_CardPwd">提交
                                                    </button>
                                                </c:if>
                                                <c:if test="${userMetroCard.cardid ==null}">
                                                    <a class="btn btn-success" id="fabu"
                                                       href="${wlpt}/wlpt/personal/toApplyCard">
                                                        <i class="fa fa-plus-square white"> </i> 申请一卡通
                                                    </a>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript">
    $(function () {
        window.sendRegCode = function (btn) {
            $.ajax({
                cache: true,
                type: "POST",
                url: "${wlpt}/wlpt/personal/sendRegCode",
                data: {phone: $("#" + btn + "_phone").val()},
                async: false,
                error: function (request) {
                    $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                },
                success: function (data) {
                    var message = data;
                    if (message) {
                        sendTimeBtn($("#" + btn + "_sendRegCode"));
                    } else {
                        $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                    }
                }
            });
        };
        window.subform = function (form) {
            var bootstrapValidator = $("#update_" + form + "Pwd_form").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
                    $("#sub_" + form + "pwd").attr('disabled', 'disabled');
                    var post_url = "${wlpt}/wlpt/personal/saveUpdatePass";
                    if (form == 'Login') {
                        post_url = "${wlpt}/wlpt/personal/saveUpdatePass";
                    } else if (form == 'Cash') {
                        post_url = "${wlpt}/wlpt/personal/saveCashPass";
                    } else {
                        post_url = "${wlpt}/wlpt/personal/updatePasswordCard";
                    }
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url: post_url,
                        data: $('#update_' + form + 'Pwd_form').serialize(),// 你的formid
                        async: false,
                        error: function (request) {
                            $.MsgBox.Alert("系统提示", "Connection error");
                        },
                        success: function (data) {
                            if (data.state == 1) {
                            	if (form == 'Login') {
                                	window.top.location.href = "${wlpt}/logout";
                            	}
                            }
                            $("#sendRegCode").val("获取验证码");
                            $("#sendRegCode").removeAttr("disabled");
                            $("#sendRegCode").css("background", "#428bca");
                            $("#sub_" + form + "pwd").removeAttr("disabled");
                            wait = 0;
                            $.MsgBox.Alert("系统提示", data.message);
                        }
                    });
                }, null, null, null, "是", "否");
            }
            else {
            }
        };
        $('#update_LoginPwd_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                regcode: {
                    message: '验证码无效',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '请输入长度为6位的验证码'
                        },
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/checkRegCode?phone=' + $("#login_phone").val(),
                            name: "regcode",
                            isran: false,
                            delay :  2000,
                            message: '验证码有误或已过期'
                        }
                    }
                },
                oldpassword: {
                    message: '旧密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '旧密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '旧密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }
                    }
                },
                password: {
                    message: '新密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '新密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        },
                        different: {
                            field: 'oldpassword',
                            message: '新密码和旧密码不能相同'
                        }
                    }
                }, repassword: {
                    validators: {
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次密码不一致'
                        }
                    }
                }
            }

        });
        $('#update_CashPwd_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                regcode: {
                    message: '验证码无效',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '请输入长度为6位的验证码'
                        },
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/checkRegCode?phone=' + $("#cash_phone").val(),
                            name: "regcode",
                            isran: false,
                            delay :  2000,
                            message: '验证码有误或已过期'
                        }
                    }
                },
                cashpassword: {
                    message: '新密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '新密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        },
                        different: {
                            field: 'recashpassword',
                            message: '新密码和旧密码不能相同'
                        }
                    }
                }, recashpassword: {
                    validators: {
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        identical: {
                            field: 'cashpassword',
                            message: '两次密码不一致'
                        }
                    }
                }
            }

        });
        $('#update_CardPwd_form').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                regcode: {
                    message: '验证码无效',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '请输入长度为6位的验证码'
                        },
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/checkRegCode?phone=' + $("#card_phone").val(),
                            name: "regcode",
                            isran: false,
                            delay :  2000,
                            message: '验证码有误或已过期'
                        }
                    }
                },
                oldpassword: {
                    message: '旧密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '旧密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '旧密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }
                    }
                },
                password: {
                    message: '新密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '新密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '新密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        },
                        different: {
                            field: 'oldpassword',
                            message: '新密码和旧密码不能相同'
                        }
                    }
                }, repassword: {
                    validators: {
                        notEmpty: {
                            message: '确认密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次密码不一致'
                        }
                    }
                }
            }

        });


    })
    ;
</script>
</body>
</html>
