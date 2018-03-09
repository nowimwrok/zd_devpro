<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->

    <title>用户资料</title>
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
            <form:form id="inputForm" modelAttribute="userinfo"
                       action="${wlpt}/wlpt/user/save" method="post" class="form-horizontal">
                <form:hidden path="id"/>
                <form:hidden path="user.id"/>
                <form:hidden path="userCompany.id"/>
                <input type="hidden" id="userId" name="ID" value="${userinfo.id }"/>
                <div class="form_container">
                    <!--第一个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">
                            基本信息（<span class="red">*</span>为必填项）&nbsp;&nbsp;&nbsp;&nbsp;<span
                                class="red">*注：已认证用户信息不可更改</span>
                        </h4>
                        <div class="col-sm-12 form-horizontal" style="margin-top: 0px;">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    登录名
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" placeholder="请输入登录名" class="form-control"
                                           value="${userinfo.user.loginName}" name="user.loginName"
                                           data-bv-field="LoginName"
                                           onblur="validLoginName()"
                                           id="loginName" style="color:#a6a6a6;"/>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>姓名
                                </div>
                                <div class="col-sm-7 text-left">
                                    <c:choose>
                                        <c:when test="${userinfo.status==1||userinfo.status==2}">
                                            <input class="form-control" readonly type="text" value="${userinfo.user.name}"> </c:when>
                                        <c:otherwise>
                                            <input type="text" id="username"  placeholder="请输入姓名" name="user.name"
                                                   value="${userinfo.user.name}"
                                                   class="form-control"
                                                   style="color:#a6a6a6;"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal" style="margin-top: 0px;">
                            <div class="form-group col-sm-6 has-js">
                                <div class="col-sm-5 control-label text-right">
                                    性别
                                </div>
                                <div class="col-sm-7">
                                            <input name="sex" id="radio-sex1" value="1" type="radio">男
                                       
                                            <input name="sex" id="radio-sex2" value="0" type="radio"> 女
                                      
                                   
                                </div>
                            </div>

                        </div>
                        <div class="col-sm-12 form-horizontal" style="margin-top:0;">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <!-- <span class="red">*</span> -->公司名称
                                </div>
                                <div class="col-sm-7 text-left">
                                    <c:choose>
                                        <c:when test="${fns:getUser().role.enname eq 'enterprise'&& !empty userinfo.companyname && (userinfo.status==1||userinfo.status==2)}">
                                           <input type="text" class="form-control" readonly value="${userinfo.companyname}"></c:when>
                                        <c:otherwise>
                                            <input type="text" class="form-control" id="companyname"
                                                   name="companyname" htmlEscape="false" value="${userinfo.companyname}"
                                                   style="color:#a6a6a6;"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">
                                    <span class="red">*</span>手机号码
                                </div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" class="form-control" readonly
                                           value=" ${userinfo.user.phone}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第3个面板-->
                    <div class="panel clearfix">
                        <h4 class="panel-heading">补充信息</h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">固定电话</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" id="telphone"
                                           name="telphone" placeholder="请输入固话号码" value="${userinfo.telphone}">
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-sm-5 control-label text-right">Email</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" id="email"
                                           name="user.email" value="${userinfo.user.email}">
                                    <div class="form-group col-sm-4 " style=" text-align: right !important; width: 90px; top: 0px; position: absolute; right: -50px;">
                                        <a class="perfect_info add_perfect_info">更多<i
                                                class="fa fa-chevron-circle-down"></i> </a>
                                    </div>
                                </div>

                            </div>

                            <div class="clearfix add_hide_box" style="display: none;">
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-5 control-label text-right">QQ</div>
                                    <div class="col-sm-7 text-left">
                                        <input class="form-control" id="qq" name="qq" value="${userinfo.qq}">
                                    </div>
                                </div>
                                <div class="form-group has-unit col-sm-6">
                                    <div class="col-sm-5 control-label text-right">联系地址</div>
                                    <div class="col-sm-7 text-left">
                                        <textarea placeholder="请输入联系地址" name="contactaddress" class="form-control"
                                                  rows="2"
                                                  style="padding:3px;text-indent:5px;"></textarea>
                                    </div>
                                </div>
                                <div class="col-sm-12 form-horizontal">
                                    <div class="form-group has-unit col-sm-10">
                                        <div class="col-sm-3 control-label text-right">上传头像</div>
                                        <div class="col-sm-9 text-left">
                                            <div class="text-left">
                                                    <%--<a class="form-control click_upimg"> 点击上传</a>--%>
                                                <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">
                                                    图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式!</p>
                                            </div>
                                            <ul class="upimg-list clearfix">
                                                <li class="col-sm-4">
                                                    <form:hidden id="nameImage" isdelall="false" path="user.photo"
                                                                 htmlEscape="false" maxlength="255"
                                                                 class="input-xlarge"/>
                                                    <sys:ckfinder input="nameImage" type="images" uploadPath="/photo"
                                                                  selectMultiple="false" maxWidth="100"
                                                                  maxHeight="100"/>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--第3个面板-->

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
        $(".add_perfect_info").click(function () {
            $('.add_hide_box').toggle();
        });
        
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                "user.loginName": {
                    message: '用户名无效',
                    validators: {
                        notEmpty: {
                            message: '用户名不能位空'
                        },
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/validateLoginName',
                            name: "ID",
                            isran: false,
                            delay :  2000,
                            message: '用户名不可用'
                        }
                    }
                },
                "user.name": {
                    message: '姓名无效',
                    validators: {
                        notEmpty: {
                            message: '姓名不能为空'
                        },
                        regexp: {
                            regexp: /^[\u4e00-\u9fa5]+$/,
                            message: '用户名只能中文'
                        }
                    }
                }, companyname: {
                    message: '公司名称无效',
                    validators: {
                        /* notEmpty: {
                            message: '公司名称不能为空'
                        }, */
                        stringLength: {
                            min: 3,
                            max: 30,
                            message: '公司名称必须大于3，小于30个字'
                        },
                        userName: {
                            message: '请填写正确的企业名称'
                        }
                    }
                }, telphone: {
                    message: '请填写正确的电话号码',
                    validators: {
                        tel: {
                            message: "请填写正确的电话号码,例如:020-666666"
                        }
                    }
                }, "user.email": {
                    message: '请填写正确的电子邮箱',
                    validators: {
                        emailAddress: {
                            message: "请填写正确的电子邮箱"
                        }
                    }
                }, "qq": {
                    message: '请填写正确的QQ',
                    validators: {
                        integer: {
                            message: "请填写正确的QQ"
                        },
                        stringLength: {
                            min: 6,
                            max: 10,
                            message: 'QQ长度为6-10位字符'
                        },
                        post_valid: {
                            url: ' ${wlpt}/wlpt/personal/validateQQ',
                            isran: false,
                            message: '此QQ不可用，已存在'
                        },
                    }
                }
            }

        });
        $("#btn-warning").on("click", function () {
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
            	$("#maskloading" , parent.document).show();
                $.ajax({
                    cache: true,
                    type: "POST",
                    url: "${wlpt}/wlpt/personal/saveUserInfo",
                    data: $('#inputForm').serialize(),// 你的formid
                    async: false,
                    error: function (request) {
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("保存提示", "保存失败");
                    },
                    success: function (data) {
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("保存提示", data.message)
                    }
                });
            }


        });
        if ('${userinfo.user.photo}' != "") {
            $("#showimg").attr("src", '${userinfo.user.photo}');
            $("#showimg").attr("src", $("#nameImage").val());
        }
        if ("${userinfo.sex}" == 1) {
            $("#radio-sex1").attr("checked", true).parent("label").addClass('r_on').siblings().removeClass('r_on');

        } else {
            $("#radio-sex2").attr("checked", true).parent("label").addClass('r_on').siblings().removeClass('r_on');
        }

    });
</script>
</body>
</html>
