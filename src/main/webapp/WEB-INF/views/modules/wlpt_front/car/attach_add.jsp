<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>绑定司机管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet"/>
    <style type="text/css">
        .regbt {
            width: 200px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="content_wrap" style="height:500px;">

    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">绑定</span><span
            class="title_orange">司机</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div>
        <label class="control-label">用户：</label>
        <input id="searchinfo" name="searchinfo" style="font-size: 14px;line-height: 25px;" placeholder="用户名/电话"/>
        <button type="button" onclick="search();" class="regbt" style="width: 100px;">
            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
        </button>
    </div>
    <div id="addinfo" style="margin-top: 60px;">
        <label>请输入需要绑定司机的完整用户名或手机号，然后绑定指定司机即可！</label>
    </div>
    <div id="info" hidden="hidden">
        <form:form id="inputForm" modelAttribute="user" action="${wlpt}/wlpt/driver/saveAttach" method="post">
            <input id="userid" name="reuser.id" type="hidden"/>
            <input id="role" type="hidden"/>
            <table class="table_border" cellpadding="0" cellspacing="0"
                   style="margin: auto;width: 95%;margin-top: 50px;margin-bottom: 50px;">
                <tr>
                    <td id="login">登录名：</td>
                    <td id="name">真实姓名：</td>
                    <td id="phone">电话：</td>
                </tr>
                <tr>
                    <td id="email">邮箱：</td>
                    <td id="sex">性别：</td>
                    <td id="status">认证：</td>
                </tr>
            </table>
            <input id="btnSubmit" class="regbt" style="width: 100px;" type="button" value="请求绑定"/>
        </form:form>
    </div>
    <div class="loading">
        <img src="/static/images/loading.gif">
        <p>加载中</p>
    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">

    $(".loading").hide();
    function search() {
        var isnul = true;
        isnul = isnul && $("#searchinfo").valid({
                    methods: "required"
                });
        if (isnul) {
            var searchinfo = $("#searchinfo").val();
            $.ajax({
                url: "${wlpt}/wlpt/personal/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $("#info").hide();
                            $("#addinfo").html("未查到指定用户!请确认用户是否已注册");
                            $("#addinfo").show();
                        } else {
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            if (data.value.role.enname) {
                                $("#role").val(data.value.role.enname);
                            }
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            if (data.value.user.loginName) {
                                $("#login").html("登录名：" + data.value.user.loginName);
                            }
                            if (data.value.user.name) {
                                $("#name").html("真实姓名：" + data.value.user.name);
                            }
                            if (data.value.user.phone) {
                                $("#phone").html("电话：" + data.value.user.phone);
                            }
                            if (data.value.user.email) {
                                $("#email").html("邮箱：" + data.value.user.email);
                            }
                            if (data.value.info.sex) {
                                if (data.value.info.sex == '1') {
                                    $("#sex").html("性别：" + '男');
                                }
                                if (data.value.info.sex == '0') {
                                    $("#sex").html("性别：" + '女');
                                }
                            }
                            if (data.value.info.status) {
                                if (data.value.info.status == '2') {
                                    $("#status").html("认证：" + '认证通过');
                                } else {
                                    $("#status").html("认证：" + '未通过');
                                }

                            }
                            $("#addinfo").hide();
                            $("#info").show();
                        }
                    }
                }
            });
        }
    }
    $("#btnSubmit").click(function () {
        if ($("#status").html() == "认证：未通过") {
            $("#btnSubmit").tips({
                side: 3,
                msg: '用户未认证，不可绑定！',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        if ($("#role").val() != "enterprise" && $("#role").val() != "carowner") {
            $("#searchinfo").tips({
                side: 3,
                msg: '绑定的用户只能是车主或物流企业！',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }

        if ($(".loading").is(':hidden')) {
            $(".loading").show();
        } else {
            return false;
        }
        $.ajax({
            url: "${wlpt}/wlpt/driver/saveAttach?" + $("#inputForm").serialize(),
            dataType: 'json',
            type: "post",
            success: function (data) {
                $(".loading").hide();
                if (data.value.state == 1) {
                    window.location.href = '${wlpt}/wlpt/driver/attach_list';
                } else {
                    $.MsgBox.Alert("保存提示", data.value.message);
                }
            }
        });

    });
</script>
</body>
</html>