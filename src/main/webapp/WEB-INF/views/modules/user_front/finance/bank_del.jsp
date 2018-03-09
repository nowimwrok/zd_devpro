<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>绑定银行卡</title>
    <style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;">
    <input class="form-control" id="id" name="id" readonly value="${model.id}" type="hidden">
    <!--两列-->
    <div class="row edit-box has-js">
        <form id="inputForm" name="inputForm">
        <div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        账户资料 (<span class="red">*</span>为必填项)
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right"><span class="red">*</span>账户名</div>
                            <div class="col-sm-9 text-left">
                                <input class="form-control" id="accountName" name="accountName" placeholder="请输入账户名称"
                                       readonly value="${model.accountName }">
                            </div>
                        </div>
                        <div class="form-group col-sm-6 has-unit">
                            <div class="col-sm-3 control-label text-right"><span class="red">*</span>银行号</div>
                            <div class="col-sm-9 text-left">
                                <input type="tel" class="form-control" id="bankcard" name="bankcard" readonly
                                       value="${model.bankcard}">

                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-lg-3 control-label text-right">手机号码</div>
                            <div class="col-lg-9 text-left ">
                                <input class="form-control" id="bindphone" name="bindphone" placeholder="请输入手机号码"
                                       readonly value="${ model.bindphone}">
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-lg-3 control-label text-right">验证码</div>
                            <div class="col-lg-9 text-left">

                                <div class="input-group">
                                    <input type="text" class="form-control col-sm-8" id="validateCode"
                                           name="validateCode"
                                           placeholder="请输入验证码">

                                    <span class="input-group-btn">
                                      <button style=" border-bottom-right-radius: 4px; border-top-right-radius: 4px; font-size: 12px; letter-spacing: 1px; color: #FFF; background-color: rgb(9, 169, 64);"
                                              class="form-control btn btn-default" id="sendRegCode"
                                              type="button">获取验证码!</button>
                                    </span>
                                </div><!-- /input-group -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        银行信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group has-unit col-sm-6">
                            <div class="col-sm-3 control-label text-right"><span class="red">*</span>所属银行</div>
                            <div class="col-sm-9 text-left">
                                <input type="text" class="form-control" id="banktype" name="banktype"
                                       readonly="readonly"
                                       placeholder="请选择银行" readonly value="${model.banktype }">


                            </div>
                        </div>
                        <div class="form-group has-unit col-sm-6">
                            <div class="col-sm-3 control-label text-right">支行名称</div>
                            <div class="col-sm-9 text-left">
                                <input type="text" class="form-control" id="bankname" name="bankname"
                                       readonly="readonly" readonly value="${model.bankname }"
                                       placeholder="请选择支行">
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-right">支付密码</div>
                            <div class="col-sm-9 text-left">
                                <input class="form-control" id="password" type="password" name="password" value="">
                            </div>
                        </div>


                        <div class="clearfix contact_hide_box">

                        </div>

                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>


    <div class="col-lg-12">
        <div class="form-group" style="margin-bottom: 80px;">
            <div class="col-sm-2 control-label text-left"></div>
            <div class="col-sm-4">
                <button id="submit" class="btn btn-primary col-lg-12">提  交</button>
            </div>
            <div class="col-sm-4">
                <button id="" class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
            </div>
        </div>

    </div>
</div>
</div>


<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>

<script>
    $(function () {

        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                validateCode: {
                    message: '验证码无效',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '请输入长度为6位的验证码'
                        }/*,
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/checkRegCode?phone=' + $("#bindphone").val(),
                            name: "regcode",
                            isran: false,
                            delay: 2000,
                            message: '验证码有误或已过期'
                        }*/
                    }
                },
                password: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }/*, post_valid: {
                            url: '/a/wlpt/user/validateCashPwd?isSave=false',
                            name: "cashPwd",
                            delay: 2000,
                            message: '支付密码有误或未设置'
                        }*/
                    }
                }
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
                        $.MsgBox.Alert("系统提示", "验证码有误或已过期");

                        $("#validateCode").focus();
                        return false;
                    }
                }
            });
        }
        $("#sendRegCode").click(function () {
            var phone = $("#bindphone").val();

            if ($("#bindphone").val() != null && $("#bindphone").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "${wlpt}/wlpt/personal/sendCode",
                    data: {phone: $("#bindphone").val()},
                    dataType: "json",
                    cache: false,
                    success: function (data) {
                        var message = data;
                        if (message) {
                            sendTimeBtn($("#sendRegCode"));
                        } else {
                            $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                        }
                    },
                    error: function () {
                        $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                    }
                });

            } else {
                $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
            }

        });
        $("#submit").click(function () {
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                checkValidateCode();
                var isvid=false;
                $.ajax({
                    url: "${ctx}/wlpt/user/validateCashPwd",
                    dataType: 'json',
                    data:{"cashPwd":$("#password").val(),"isSave":false},
                    async: false, ///同步请求传递
                    type: "post",
                    success: function (data) {
                        isvid=data;
                        if (data == false) {
                            $.MsgBox.Alert("系统提示", "支付密码错误或未设置支付密码");

                        }
                    }
                })
                if(isvid){
                    window.location.href = "${wlpt}/wlpt/user/userBank/deteleBank?id=" + '${model.id}';
                }
            }
        });


    });

</script>
</body>
</html>
