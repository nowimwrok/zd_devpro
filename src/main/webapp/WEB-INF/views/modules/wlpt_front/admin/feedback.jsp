<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="decorator" content="site_default_basic"/>
<title>意见反馈</title>
<style type="text/css">
.box {
	width: 990px;
	margin: 0px auto;
}

.bx_logo {
	padding: 30px 0px 30px 0px;
}

.main {
	border: 1px solid #cce8ff;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	font-family: Verdana;
	overflow: hidden;
	margin-bottom: 30px;
}

.main1 {
	border: 0px solid #cce8ff;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
	font-family: Verdana;
	overflow: hidden;
	margin-bottom: 30px;
}

.w {
	width: 990px;
	margin: 0 auto;
}

.o-mt h5 {
	
	font: 12px/14px \5FAE\8F6F\96C5\9ED1;
	padding-left: 20px;
	line-height:35px;
	margin-top: 0px;
}

#headers .step {
	float: right;
}

.step {
	overflow: hidden;
	color: #999999;
	font-weight: bold;
	margin: 0 auto 10px;
	zoom: 1;
	float: left;
}

.form .item {
	margin-bottom: 10px;
	clear: both;
}

.form .label {
	width: 160px;
	font-size: 17px;
	float: left;
	text-align: right;
	color: #666666;
	line-height: 30px;
}

.main .form .fl {
	font-size: 14px;
	width: 770px;
	float: left;
	line-height: 33px;
}

.amount_div {
	font-size: 14px;
	width: 770px;
	float: left;
}

.text {
	font-weight: bold;
	font-size: 16px;
	color: #cc0000;
	text-align: center;
	width: 93px;
}

.msg-text,.msg-error {
	font-size: 12px;
}

.msg-text {
	color: #999999;
}

.msg-text,.msg-error {
	float: left;
	line-height: 25px;
}

.i-tips {
	border: 1px solid #D9D9D9;
	background: #F5F5F5;
	color: #666666;
	float: left;
	padding: 3px 8px;
	font-size: 12px;
}

 .regbt {
            width: 100px;
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

.m1 {
	margin-left: 80px;
	margin-right: 80px;
	padding: 15px 30px;
	margin-bottom: 20px;
	border-width: 2px;
	border: 1px solid #edd28b;
	background: #fffdee;
}

.m1 .mt {
	margin-bottom: 5px;
}

.m1 .mt h3 {
	font-size: 12px;
}

.mc p {
	color: #2A2723;
}
.survey-welcome{
	height:80px;
	padding-left:50px;
}
.survey-welcome span{
	line-height:30px;
}
.textarea{
	margin:30px 0px 30px 50px;
	border-collapse:separate;
}
.submit-div {
    text-align: center;
    width: 100%;
    line-height:35px;
}
.subtn{
	color:blue;
	width:50px;
	height:28px;
	background-color: #cce8ff;
	border-radius:6px;
}
#loading{
	display:none;
}
</style>
</head>
<body>
	<div class="box">
	<br>
		<div id="step1" class="step">
				<h1 style="font-size:25px;font-weight:500;">卓大-用户反馈调查</h1>
		</div>
		<div class="w main1" style="margin-bottom:30px;">
			<span>尊敬的用户： </span><br>
			<span>您好！为了给您提供更好的服务，我们希望收集您使用<a href="${wlpt}/" style="font-size:16px;font-weight:bold;color:#F74000;">卓大</a>时的看法或建议。对您的配合和支持表示衷心感谢！ </span>
		</div>
		<div class="w main" style="margin-bottom:30px;">
			<div class="o-mt">
				<h5 >如果您在使用<a href="${wlpt}/" style="font-size:14px;font-weight:bold;color:#F74000;">卓大</a>时，有什么好或不好的地方，请说出来！我们会关注您的反馈，不断优化产品，为您提供更好的服务！</h5>
			</div>
			<div class="m">
					<textarea id="content" maxlength="200" class="textarea"  rows="8" cols="70" title="反馈信息"></textarea>
			</div>
			<!-- m -->
		</div>
		<!-- w main -->
		
		<div class="w main" style="margin-bottom:30px;">
			<div class="o-mt">
				<h5 style="line-height:20px;padding:5px;padding-left:20px;">我们会不定期邀请用户参与面对面的交流。如果您有意参与，请填写如下信息，方便我们与您联系，谢谢！（信息仅作为内部资料绝不外泄）<br>

如果您对卓大的使用体验有任何想法，也欢迎致电<sapn style="color:red">卓大（0310-3188756）</sapn> 进行提出建议</h5>

			</div>
			<div class="m">
			<div style="height:30px;margin:30px 0px 30px 50px;">
					<span style="margin-right:20px;">手机号:</span><input id="phone" name="phone" maxlength="11" type="text"/>
			</div>
			</div>
			<!-- m -->
		</div>
		<!-- w main -->
		<div class="submit-div">
		<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div><img src='/static/images/loading.gif'></div><div style=''>正在努力提交，请稍等!</div>
		</div>
			<input type="button" id="subtn" class="regbt" value="提交"/>
		</div>
	</div><br>
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script type="text/javascript">
		$("#subtn").click(function() {
			var isnul = true;
			isnul = isnul && $("#content").valid({
                methods: "required|string"
            });
            isnul = isnul && $("#phone").valid({
                methods: "required|isPhone"
            });
            if(!isnul){
            	return false;
            }
			var content=$("#content").val();
			var phone=$("input[name=phone]").val();
			var url='${wlpt}/wlpt/doFeedBack';
			if(content != '' && phone != ''){
				$("#loading").show();
				$(".submit-div").css("line-height","10px");
				$("#subtn").hide();
				$.ajax({
					url : url,
					type : "POST",
					dataType : 'json',
					data:{content:content,phone:phone},
					success : function(data) {
						$("#loading").hide();
						$(".submit-div").css("line-height","35px");
						$("#subtn").val("感谢您的反馈").attr("disabled","true").css("width","100px").show();
					}
				});
			}
		});
	</script>
</body>
</html>
