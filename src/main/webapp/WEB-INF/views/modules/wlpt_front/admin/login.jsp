<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>

</head>
<body style="animation:none;-webkit-animation:none;"  onkeydown="keyLogin();">

<div class="box">
    <!--画布 流星-->
    <!--<canvas id="stars" style=""></canvas>-->
    <div class="box_content">
        <div class="login_box clearfix">
            <form action="${wlpt }/login" id="inputForm" method="post" class="col-sm-12 clearfix">
                <input type="hidden" name="zd" value="front"/>
                <div class="front col-sm-12">
                    <div class="front_mm">
                        <h1 class="login_title text-center" style="margin-bottom:30px;font-size: 28px;text-align: left;;">${site.title}</h1>
                        <div class="col-sm-12 has-feedback form-group">
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>
                            <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名"/>
                        </div>
                        <div class="col-sm-12 has-feedback form-group">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码"/>
                        </div>
                        <div class="col-sm-12">
                            <button type="button" class="btn btn-block" style="font-size: 16px;height: 32px;" id="sub_form">登录</button>
                        </div>
                        <div class="col-sm-12 clearfix">
                            <p class="pull-right login_zc" style="font-size: 12px;">免费注册</p>
                            <a  href="${wlpt}/wlpt/personal/forgetpass"><p class="pull-right" style="font-size: 12px;">忘记密码</p></a>
                        </div>
                    </div>
                </div>
                <div class="back col-sm-12">
                    <div class="col-sm-12 text-center">
                        <h3>选择注册类型</h3>
                    </div>
                    <div class="col-sm-12 text-center">
                        <p class="change-id" data-owner="carowner">我是车主</p>
                    </div>
                    <div class="col-sm-12 text-center">
                        <p class="change-id" data-owner="goodsowner">我是货主</p>
                    </div>
                    <div class="col-sm-12 text-center">
                        <p class="change-id" data-owner="enterprise">物流企业</p>
                    </div>
                    <div class="col-sm-12 text-center" style="color:#fff;">
                        （账户类型一经创建，不得修改）
                    </div>
                    <div class="col-sm-12">
                        <button type="button" id="toRegister" class="btn btn-block">确认创建用户</button>
                    </div>
                    <div class="col-sm-12 text-center" style="margin-top:15px;">
                        <a href="" style="color:#426DED" class="back_login">登录</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="col-sm-12 text-center copyRight">
        <p>${site.copyright}</p>
    </div>
</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<!--<script src="${ctxStatic}/front/js/star.js" type="text/javascript"></script>-->

<script>
    var message="${message}";
    var isLogin="${login}";
    if(message.length>0){
        $("#register").css("display","none");
        $("#login").css("display","block");
        $.MsgBox.Alert("登录提示",message);
    }
    if(isLogin.length>0){
        $("#register").css("display","none");
        $("#login").css("display","block");
    }
    if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
        alert('未登录或登录超时。请重新登录，谢谢！');
        top.location = "${wlpt}/login?login=login";
    }
    var brower_w = document.documentElement.clientWidth;
    var brower_h = document.documentElement.clientHeight;
    $('.box').css('width', brower_w + 'px').css('height', brower_h + 'px');
    $('.box_content').height(brower_h + 'px');
    $('.box_content').width(brower_w * .3 + 'px');
    //canvas
    $('#stars').css('width', brower_w + 'px').css('height', brower_h + 'px');
    //免费注册
    $('.login_zc').click(function () {
        $('.front').css('transform', 'rotatey(180deg)').css('-webkit-transform', 'rotatey(180deg)').css('-moz-transform', 'rotatey(180deg)').css('-o-transform', 'rotatey(180deg)');
        $('.back').css('transform', 'rotatey(0deg)').css('-webkit-transform', 'rotatey(0deg)').css('-moz-transform', 'rotatey(0deg)').css('-o-transform', 'rotatey(0deg)');
    });
    //登录
    $('.back_login').click(function (e) {
        e.preventDefault();
        $('.front').css('transform', 'rotatey(0deg)');
        $('.back').css('transform', 'rotatey(180deg)');
    });

    $('#inputForm').bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            "username": {
                message: '用户名无效',
                validators: {
                    notEmpty: {
                        message: '用户名不能位空'
                    }
                }
            },
            "password": {
                message: '密码无效',
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    }
                }
            }
        }
    });
	
    function keyLogin(){
    	 if (window.event.keyCode==13)  //回车键的键值为13
    	   $("#sub_form").click(); //调用登录按钮的登录事件
    	}
    
    $("#sub_form").click(function () {
        var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            document.getElementById('inputForm').submit();
            //$('#inputForm').bootstrapValidator('validate');
           // $("form").submit();
            /*$.ajax({
                cache: true,
                type: "post",
                url: "${wlpt}/login",
                data: $('#inputForm').serialize(),// 你的formid
                async: false,
                error: function (request) {
                    $("#maskloading" , parent.document).hide();
                    $.MsgBox.Alert("保存提示", "用户名或密码错误");
                },
                success: function (data) {
                    $("#maskloading" , parent.document).hide();
                    $.MsgBox.Alert("保存提示", '${login}')
                }
            });*/
        }
    });

    /*注册模块*/
    var role="carowner";
    $(".change-id").on("click",function(){
        $(".change-id img").remove();
        $(this).css("position","relative");
        role=$(this).attr("data-owner");
    });
    $("#toRegister").click(function(){
        $("#toRegister").css("display","none");
        $("#reg_change").css("display","block");
        setTimeout(location.href="${wlpt}/wlpt/register?ename="+role,4000);
        return false;
    });
    //悬浮微信 出现二维码
    $('.login_wechat').hover(function () {
        $('.wechat_code').show(500);
    }, function () {
        $('.wechat_code').hide(500);
    });
    $('.back p').click(function () {
        $('.back p>img').remove();
        var str = '<img src="${ctxStatic }/front/img/right.png" alt="" class="right"/>';
        $(this).append(str);
    });
</script>
</body>
</html>
