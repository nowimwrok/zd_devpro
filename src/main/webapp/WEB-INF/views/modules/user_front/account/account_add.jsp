<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->

    <title>添加子账户</title>
    <style type="text/css">
        .loadings {
            text-align: center;
        }

        .loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }

        .file {
            filter: alpha(opacity:0);
            opacity: 0;
        }

        input {
            color: #a6a6a6;
        }

    </style>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;" class="has-js">
    <!--两列-->
    <div class="row">
        <div class="col-lg-12" style="padding-bottom:20px;">
            <!--详细内容-->
            <form:form id="inputForm" name="inputForm" modelAttribute="user"
                       action="${wlpt}/wlpt/account/saveMyuser" method="post"
                       class="form-horizontal">
                <input type="hidden" id="userId" name="ID" value="${userId} "/>
                <div class="form_container">
                    <!--第一个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">
                            添加子账户（<span class="red">*</span>为必填项）
                        </h4>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>登录名
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" name="loginName"
                                           id="loginName" <%--onblur="validLoginName()"--%> class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>姓名
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" name="name" data-bv-trigger="keyup"
                                           data-bv-notempty-message="姓名不能为空" id="name" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">
                            <div class="form-group col-sm-6 has-js">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>用户类型
                                </div>
                                <div class="col-sm-7">
                                    <div class="radios" style="position: relative;top:6px;">
                                            <%--<form:radiobuttons id="userrole"
                                                               path="role.enname" items="${fns:getDictList('account_role')}"
                                                               itemLabel="label" itemValue="value" htmlEscape="false" class="radiobuttons" />--%>
                                        
                                            <input name="role.enname" id="userrole1" value="U_financial" type="radio"
                                                   checked="checked">财务员
                                        
                                        
                                            <input name="role.enname" id="userrole2" value="U_salesman" type="radio">业务员
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>手机号码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" name="phone"
                                           id="phone" class="form-control"/>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--第3个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">密码</h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>密码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="password"
                                           name="password" type="password" value="" maxlength="16"
                                           minlength="3" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>确认密码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="repassword"
                                           name="repassword" type="password" value="" maxlength="16"
                                           minlength="3" class="form-control"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom:0;">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>支付密码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="cashpassword"
                                           name="userinfo.cashpassword" type="password" value="" maxlength="10"
                                           minlength="3" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>确认支付密码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input id="recashpassword"
                                           name="recashpassword" type="password" value="" maxlength="10"
                                           minlength="3" equalTo="#cashpassword" class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel clearfix col-sm-12" style="padding:0;">
                        <h4 class="panel-heading">备注</h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="col-sm-12 form-group">
                            <textarea rows="5" cols="" name="remarks"
                                      id="remarks" class="form-control"
                                      placeholder="在这里输入要补充的内容"></textarea>
                            </div>
                        </div>
                    </div>
                    <!--保存 按钮-->
                    <div class="col-lg-12">
                        <div class="form-group" style="margin-bottom: 80px;">
                            <div class="col-sm-2 control-label text-left"></div>
                            <div class="col-sm-4">
                                <input type="button" id="btn-warning" class="btn btn-primary col-lg-12" value="保  存">
                            </div>
                            <div class="col-sm-4">
                                <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
                            </div>
                        </div>
                        <!-- <div class="loading">
                            <img src="/static/images/loading.gif">
                            <p>加载中</p>
                        </div> -->
                    </div>
                </div>
            </form:form>
        </div>
    </div>

</div>
<script src="/static/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript">
    $(function () {
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                loginName: {
                    message: '用户名无效',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/validateLoginName?ID='+$("#userid").val(),
                            name: "LoginName",
                            isran: false,
                            delay :  2000,
                            message: '用户名不可用'
                        },
                        different: {
                            field: 'password',
                            message: '用户名和密码不能相同'
                        }
                    }
                },
                phone: {
                    validators: {
                        notEmpty: {
                            message: '手机号码不能为空'
                        },
                        post_valid: {
                            url: ' ${wlpt}/wlpt/personal/checkPhone ',
                            isran: true,
                            delay :  2000,
                            message: '手机号码不可用'
                        },integer: {
                            message: "请填写正确的手机号码"
                        },regexp: {
                            regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
                            message: '请填写正确的手机号码'
                        }

                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message:"请填写6位以上的字母加数字或特殊符号的安全密码"
                        },
                        different: {
                            field: 'username',
                            message: '用户名和密码不能相同'
                        }
                    }
                },
                repassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次密码不一致'
                        },
                        different: {
                            field: 'userinfo.cashpassword',
                            message: '用户名和密码不能相同'
                        }
                    }
                }, "userinfo.cashpassword": {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 16,
                            message: '用户名必须大于6，小于16个字符'
                        },
                        different: {
                            field: 'password',
                            message: '支付密码不能与登录密码相同'
                        }
                    }
                },
                recashpassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'userinfo.cashpassword',
                            message: '两次密码不一致'
                        },
                        different: {
                            field: 'password',
                            message: '支付密码不能与登录密码相同'
                        }
                    }
                }
            }

        });
        $("#btn-warning").click(function () {
        	$("#maskloading" , parent.document).show();
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()){
            	
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${wlpt}/wlpt/account/saveMyuser",
                    data: $('#inputForm').serialize(),// 你的formid
                    async: false,
                    error: function (request) {
                        $.MsgBox.Alert("保存提示", "保存失败");
                    },success: function (data) {
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("保存提示",data.message);
                        window.location.href = "${wlpt}/wlpt/account/toAccountList";
                    }
                });
            }
            else{
            	$("#maskloading" , parent.document).hide();
            }
        });
        /* //点击单选框 变换背景图片
        $('label').click(function () {
            $(this).addClass('r_on').siblings().removeClass('r_on');
            $("label").children("input").removeAttr("checked");
            $(this).children("input").attr("checked", "checked");
        }); */
    });
</script>
</body>
</html>
