<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
    <meta name="decorator" content="site_default_basic"/>
   <%--  <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/foot.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/login.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/top_menu.css"> --%>
    <style type="text/css">
        *{
            margin: 0px;
            padding: 0px;
            font-family: "微软雅黑" !important;
        }
        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff;
            font-family: "微软雅黑";
        }
        @media screen and (max-width: 900px) {
            body {
                font-size: 1rem;
            }
        }
        input:-webkit-autofill {
            -webkit-box-shadow: 0 0 0px 1000px white inset;
            border: 1px solid #CCC!important;
        }
        
        .free-register:hover{
            cursor: pointer;
        }
        .container{
            width:100%;
            margin:0px;
            padding:0px;
        }
    </style>
</head>
<body>
  <%--   <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/top.jsp"%> --%>
 <div class="login_role_wrap">
    <!-- 登录框代码 -->
    <div class="login_content login_content_1" id="login">
      
        <h4 style="background-color:#676863;border-left:0px;">欢迎登录</h4>
        <div class="login-in">
       <form action="${wlpt }/login" id="indexForm"  method="post">
            <div class="login-col1" style="width:253px;"><input type="hidden" name="zd" value="front"/>
                <div class="img-wrap"><img src="${ctxStatic }/images/wlptfront/person.png" class="login-img"></div>
                <input type="text" id="username"  name="username" onblur="checkName();" placeholder="输入用户名"><span id="name_null" style="display:none;line-height:39px;float:right;color:red;">*必填</span>
            </div>
            <div class="login-col2" style="width:253px;">
                <div class="img-wrap">
                    <img src="${ctxStatic }/images/wlptfront/lock.png" class="login-img">
                </div>
                <input type="password" id="password" onblur="checkPass();" style="color: #000;padding-left:5px;"  name="password" placeholder="输入密码">
                <span id="pass_null" style="display:none;line-height:39px;float:right;color:red;">*必填</span>
            </div>
           <%-- <c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode">验证码</label>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if>  --%>
            <a class="forget" href="${wlpt}/wlpt/personal/forgetpass"style="margin:10px 0px;" target="_blank">忘记登录密码?</a>
            
            <input class="btn btn-success" style="display: block;"type="button" value="登录" id="sub_form">
             <input class="btn btn-success" style="background-color:red !important;display:none;" type="button" value="正在登录,请稍等......" id="sub_change">
          
            <a class="free-register change_register">免费注册</a>
            </form>
     
            
        </div>
        
    </div>

    <!-- 注册代码 -->
    <div class="login_content login_content_2" id="register">
        <div class="login-in">
            <h4 style="background-color:#676863;border-left:0px;">选择注册类型</h4>
            <div class="change-id-wrap">
                <p class="change-id" data-owner="carowner">我是车主</p>
                <p class="change-id" data-owner="goodsowner">我是货主 </p>
                <p class="change-id" data-owner="enterprise">物流企业</p>
            </div>
            <p>(账户类型一经创建，则不得修改)</p>
            <a id="toRegister"  class="btn btn-success ensure-creat">确认创建用户</a>
            <a id="reg_change"  class="btn btn-success ensure-creat">正在跳转.......</a>
            <a class="free-register change_login">登录</a>
        </div>
    </div>
 </div>
    <div class="login_bottom">
        <div class="bottom_wrap">
            <div class="bot_con_1 bot_con">
                <h4>货主特权</h4>
                <p><span class="bot_span">在线自主招标</span><br><span class="bot_span">货流价格透明</span><span>运输流程可视</span></p>
            </div>
            <div class="bot_con_2 bot_con">
                <h4>车主特权</h4>
                <p><span class="bot_span">一键业务抢单</span><br><span  class="bot_span">诚信担保支撑</span><span>运费即时结算</span></p>
            </div>
            <div class="bot_con_3 bot_con">
                <h4>企业特权</h4>
                <p><span class="bot_span">大宗合同撮合</span><br><span  class="bot_span">快速运力预定</span><span>运输管理支撑</span><br></p>
            </div>
        </div>
   

</div>
   
   <!-- <script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script> -->
   <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
   <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
   <script type="text/javascript">
// 如果在框架或在对话框中，则弹出提示并跳转到首页
	if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
		alert('未登录或登录超时。请重新登录，谢谢！');
		top.location = "${wlpt}/login?login=login";
	}
	</script>  
	<script type="text/javascript">
	 $(document).ready(function(){
		 function keyDown(e){
			  if(event.keyCode==13){
				  var ready=true;
				   if($("#username").val()==""||$("#username").val()==null){
					   $("#username").focus();
					   ready=false;
					   return;
				   }
				   if($("#password").val()==""||$("#password").val()==null){
					   $("#password").focus();
					   ready=false;
					   return;
				   } 
				   if(ready){
					   $("#sub_form").css("display","none");
					   $("#sub_change").css("display","block")
					   setTimeout($("form").submit(),2000);
					   
				   }
			  }
			}
			document.onkeydown = keyDown;
		 
		 $("#sub_form").click(function(){
			     var ready=true;
				   if($("#username").val()==""||$("#username").val()==null){
					   $("#username").focus();
					   ready=false;
					   return;
				   }
				   if($("#password").val()==""||$("#password").val()==null){
					   $("#password").focus();
					   ready=false;
					   return;
				   } 
				   if(ready){
					   $("#sub_form").css("display","none");
					   setTimeout($("#sub_change").css("display","block"),3000);
					   $("form").submit();
				   }
				   
			   });	
		 });
	
	</script>
   <script type="text/javascript">
   $(document).ready(function(){
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
   });
   </script>
   <script>
 var role="carowner";
 $(".change_register").on("click",function(){
     $(".login_content_1").hide();
     $(".login_content_2").show();
 })
 $(".change_login").on("click",function(){
     $(".login_content_2").hide();
     $(".login_content_1").show();
 })
 $(".change-id").on("click",function(){
     $(".change-id img").remove()
     $(this).css("position","relative")
     role=$(this).attr("data-owner");
     $(this).append("<img src='${ctxStatic }/images/wlptfront/right.png' style='position:absolute;left:70%;top:5px;'>")
 })
 $("#toRegister").click(function(){
	  $("#toRegister").css("display","none");
	  $("#reg_change").css("display","block");
	   setTimeout(location.href="${wlpt}/wlpt/register?ename="+role,4000);
	   return false;
 });
  $(".change-id").eq(0).css("position","relative")
  $(".change-id").eq(0).append("<img src='${ctxStatic }/images/wlptfront/right.png' style='position:absolute;left:70%;top:5px;'>")



var countdown=60; 
function settime(obj) { 
    if (countdown == 0) { 
        obj.removeAttribute("disabled");    
        obj.value="免费获取验证码"; 
        countdown = 60; 
        return;
    } else { 
        obj.setAttribute("disabled", true); 
        // obj.style("background-color","#D0CCC7");
        obj.value="重新发送(" + countdown + ")"; 
        countdown--; 
    } 
setTimeout(function() { 
    settime(obj) }
    ,1000) 
}

    //鼠标悬停出现二级菜单
    $(".dropdown").mouseover(function() {
            $(this).addClass('open');
        }).mouseout(function() {
            $(this).removeClass('open');
        });

   
    // 点击导航切换背景
    $(".menu li").on("click",function(){
        $(".menu li").removeClass("active-menu")
        $(this).addClass("active-menu")
    })
    $(".menu li").eq(0).addClass("active-menu")


</script>
</body>
</html>
