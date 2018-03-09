<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport"
		  content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>卓大平台大转盘抽奖</title>

	<link
			href="${ctxStatic}/weixin/css/lottcss/style.css?id=1"
			rel="stylesheet" type="text/css">

	<script type="text/javascript"
			src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/lottery/awardRotate.js"></script>
	<script type="text/javascript">
        var gift_id="";
        var turnplate = {
            giftid : [],//奖品主键id
            restaraunts : [], //大转盘奖品名称
            colors : [], //大转盘奖品区块对应背景颜色
            outsideRadius : 192, //大转盘外圆的半径
            textRadius : 155, //大转盘奖品位置距离圆心的距离
            insideRadius : 68, //大转盘内圆的半径
            startAngle : 0, //开始角度

            bRotate : false
            //false:停止;ture:旋转
        };
        var giftnum = [];
        var giftdata= [];
        var giftnumcount = 0;
        var ACTIVITY_ID = '';
        $(document).ready(function() {
            $.ajax({
                type : "POST",
                url : '${wx}/weixin/activitylottery/getlotterty',
                data : "",
                dataType : 'json',
                cache : false,
                async : false,
                success : function(data) {
                    $("#giftdiv").append('<h3>活动奖励：</h3>');
                    if (data.state == 1) {
                        if (data.data.varList.length > 0) {
                            for ( var i = 0; i < data.data.varList.length; i++) {

                                turnplate.restaraunts[i] = data.data.varList[i].giftname;
                                giftdata[i]={
                                    giftname : data.data.varList[i].giftname,
                                    chance : data.data.varList[i].chance
                                }
                                turnplate.giftid[i] = data.data.varList[i].id;
                                if (data.data.varList[i].surplusnum < 1) {
                                    giftnum[giftnumcount] = i + 1;
                                    giftnumcount++;
                                }
                                ACTIVITY_ID = data.data.varList[i].wxinfo.id;
                                if (data.data.varList[i].gifttype != 2) {
                                    $("#giftdiv").append("<p>"
                                        + data.data.varList[i].giftname
                                        + ":"
                                        + data.data.varList[i].giftcontent
                                        + "</p>");
                                }
                            }
                            $("#gifttitle").html(data.data.activityWxinfo.activityName);
                            $("#lotteryinfo").html(data.data.activityWxinfo.activityContent);
                        } else {
                            alert("请重新进入...");
                        }
                    } else {
                        alert(data.message);
                    }
                }
            });
            //动态添加大转盘的奖品与奖品区域背景颜色
            var restarauntslength = turnplate.restaraunts.length;
            for ( var i = 0; i < turnplate.restaraunts.length; i++) {
                turnplate.colors[i] = (i % 2 == 0) ? "#FFFFFF" : "#FFF4D6";
            }

            var rotateTimeOut = function() {
                $('#wheelcanvas').rotate({
                    angle : 0,
                    animateTo : 2160,
                    duration : 8000,
                    callback : function() {
                        alert('网络超时，请检查您的网络设置！');
                    }
                });
            };

            //旋转转盘 item:奖品位置; txt：提示语;
            var rotateFn = function(item, txt, giftid) {
                var angles = item
                    * (360 / turnplate.restaraunts.length)
                    - (360 / (turnplate.restaraunts.length * 2));
                if (angles < 270) {
                    angles = 270 - angles;
                } else {
                    angles = 360 - angles + 270;
                }
                $('#wheelcanvas').stopRotate();
                $('#wheelcanvas').rotate({
                    angle : 0,
                    animateTo : angles + 1800,
                    duration : 8000,
                    callback : function() {
                        gift_id = giftid;
                        var phone = $("#phone").val();
                        if(phone==undefined || phone =='' || phone ==""){
                            $("#phone_div").show();

                        }else{
                            $.ajax({
                                type : "POST",
                                url : '${wx}/weixin/activitylottery/savelotterty',
                                data : {
                                    giftid : giftid,
                                    activityid : ACTIVITY_ID,
                                    phone : $("#phone").val()
                                },
                                dataType : 'json',
                                cache : false,
                                async : false,
                                success : function(data) {
                                    $("#erro_text").html(data.message);
                                    /*if (data.state == 1) {
                                        $("#erro_text").html(data.message);
                                        alert(data.message);
                                    } else {
                                        alert(data.message);
                                    }*/
                                }
                            });
                        }
                        turnplate.bRotate = !turnplate.bRotate;
                    }
                });
            };



            $('.pointer').click(function() {
                var phone = $("#phone").val();
                if(phone==undefined || phone =='' || phone ==""){
                    //alert("请输入手机号码！");
                    $("#erro_text").html("请输入手机号码！");
                    return;
                }else {
                    var bValidate = RegExp(/(^1[3|4|5|6|7|8｜9]{1}[0-9]{9}$)/).test(phone);
                    if (!bValidate) {
                        //alert("手机号码格式有误！");
                        $("#erro_text").html("手机号码格式有误！");
                        return false;
					}
                    if(gift_id!=undefined && gift_id !='' && gift_id !=""){
                        $("#erro_text").html("每人只可参加一次！");
                        return;
                    }
                    $("#erro_text").html("");
                if (turnplate.bRotate)
                    return;
                turnplate.bRotate = !turnplate.bRotate;
                //获取随机数(奖品个数范围内)
                var item = rnd1();//rnd(1,turnplate.restaraunts.length);
                var falg = false;
                for ( var i = 0;; i++) {
                    for ( var a = 0; a < giftnumcount; a++) {
                        if (giftnum[a] == item) {
                            falg = true;
                            break;
                        } else {
                            falg = false;
                            continue;
                        }

                    }
                    if (falg) {
                        item = rnd1();//rnd(1,turnplate.restaraunts.length);
                    } else {
                        break;
                    }
                }

                //奖品数量等于10,指针落在对应奖品区域的中心角度[252, 216, 180, 144, 108, 72, 36, 360, 324, 288]
                rotateFn(item+1,turnplate.restaraunts[item],turnplate.giftid[item]);
                console.log(item);
                }
            });
        });
        function savaaw() {
            if(gift_id==undefined || gift_id =='' || gift_id ==""){
                return;
            }
            if(ACTIVITY_ID==undefined || ACTIVITY_ID =='' || ACTIVITY_ID ==""){
                return;
            }
            $.ajax({
                type : "POST",
                url : '${wx}/weixin/activitylottery/savelotterty',
                data : {
                    giftid : gift_id,
                    activityid : ACTIVITY_ID,
                    phone : $("#phone").val()
                },
                dataType : 'json',
                cache : false,
                async : false,
                success : function(data) {
                    $("#erro_text").html(data.message);
                    /*if (data.state == 1) {
                        $("#erro_text").html(data.message);
                        alert(data.message);
                    } else {
                        alert(data.message);
                    }*/
                }
            });
        }
        function rnd(n, m) {
            andom = Math.floor(Math.random() * (m - n + 1) + n);
            return random;

        }

        function rnd1() {
            var random = 0;
            var sumchance = 0;
            //计算总概率
            for (var i=0;i<giftdata.length;i++){
                sumchance=sumchance+(giftdata[i].chance*1);
            }
            //产生随机数
            var randomNumber =  Math.random();

            //根据随机数在所有奖品分布的区域并确定所抽奖品
            var d1 = 0;
            var d2 = 0;
            for(var i=0;i<giftdata.length;i++){
                d2 = d2+((giftdata[i].chance*1)/sumchance);
                if(i==0){
                    d1=0;
                }else {
                    d1=d1+((giftdata[i-1].chance*1)/sumchance);
                }
                if(randomNumber >= d1 && randomNumber <= d2){
                    random = i;
                    break;
                }
            }
            return random;

        }

        //页面所有元素加载完毕后执行drawRouletteWheel()方法对转盘进行渲染
        window.onload = function() {
            drawRouletteWheel();
        };

        function drawRouletteWheel() {
            var canvas = document.getElementById("wheelcanvas");
            if (canvas.getContext) {
                //根据奖品个数计算圆周角度
                var arc = Math.PI / (turnplate.restaraunts.length / 2);
                var ctx = canvas.getContext("2d");
                //在给定矩形内清空一个矩形
                ctx.clearRect(0, 0, 422, 422);
                //strokeStyle 属性设置或返回用于笔触的颜色、渐变或模式
                ctx.strokeStyle = "#FFBE04";
                //font 属性设置或返回画布上文本内容的当前字体属性
                ctx.font = '18px Microsoft YaHei';
                for ( var i = 0; i < turnplate.restaraunts.length; i++) {
                    var angle = turnplate.startAngle + i * arc;
                    ctx.fillStyle = turnplate.colors[i];
                    ctx.beginPath();
                    //arc(x,y,r,起始角,结束角,绘制方向) 方法创建弧/曲线（用于创建圆或部分圆）
                    ctx.arc(211, 211, turnplate.outsideRadius, angle,
                        angle + arc, false);
                    ctx.arc(211, 211, turnplate.insideRadius, angle
                        + arc, angle, true);
                    ctx.stroke();
                    ctx.fill();
                    //锁画布(为了保存之前的画布状态)
                    ctx.save();

                    //----绘制奖品开始----
                    ctx.fillStyle = "#E5302F";
                    var text = turnplate.restaraunts[i];
                    var line_height = 17;
                    //translate方法重新映射画布上的 (0,0) 位置
                    ctx.translate(211 + Math.cos(angle + arc / 2)
                        * turnplate.textRadius, 211
                        + Math.sin(angle + arc / 2)
                        * turnplate.textRadius);

                    //rotate方法旋转当前的绘图
                    ctx.rotate(angle + arc / 2 + Math.PI / 2);

                    /** 下面代码根据奖品类型、奖品名称长度渲染不同效果，如字体、颜色、图片效果。(具体根据实际情况改变) **/
                    if (text.indexOf("M") > 0) {//流量包
                        var texts = text.split("M");
                        for ( var j = 0; j < texts.length; j++) {
                            ctx.font = j == 0 ? 'bold 20px Microsoft YaHei' : '16px Microsoft YaHei';
                            if (j == 0) {
                                ctx.fillText(texts[j] + "M",-ctx.measureText(texts[j]+ "M").width / 2,j * line_height);
                            } else {
                                ctx.fillText(texts[j],-ctx.measureText(texts[j]).width / 2,j * line_height);
                            }
                        }
                    } else if (text.indexOf("M") == -1 && text.length > 6) {//奖品名称长度超过一定范围
                        text = text.substring(0, 6) + "||"+ text.substring(6);
                        var texts = text.split("||");
                        for ( var j = 0; j < texts.length; j++) {
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height);
                        }
                    } else {
                        //在画布上绘制填色的文本。文本的默认颜色是黑色
                        //measureText()方法返回包含一个对象，该对象包含以像素计的指定字体宽度
                        ctx.fillText(text,-ctx.measureText(text).width / 2, 0);
                    }

                    //添加对应图标
                    if (text.indexOf("闪币") > 0) {
                        var img = document.getElementById("shan-img");
                        img.onload = function() {
                            ctx.drawImage(img, -15, 10);
                        };
                        ctx.drawImage(img, -15, 10);
                    } else if (text.indexOf("谢谢参与") >= 0) {
                        var img = document.getElementById("sorry-img");
                        img.onload = function() {
                            ctx.drawImage(img, -15, 10);
                        };
                        ctx.drawImage(img, -15, 10);
                    }
                    //把当前画布返回（调整）到上一个save()状态之前
                    ctx.restore();
                    //----绘制奖品结束----
                }
            }
        }
	</script>
	<style type="text/css">

		.reward_text{width:100%;padding:4% 1% 10% 6%;background:url(${ctxStatic}/weixin/images/lottimages/text_bg1.jpg) no-repeat;background-size:100% 100%;}
		.box{position:relative;width:100%;height:75%;padding-bottom:9%;background:url(${ctxStatic}/weixin/images/lottimages/reward_bg.jpg) no-repeat;background-size:100% 100%;}
	</style>
</head>
<body style="overflow-x:hidden;">
<div class="box">
	<br> <!-- 代码 开始 -->
	<img src="${ctxStatic}/weixin/images/lottimages/1.png" id="shan-img" style="display:none;" />
	<img src="${ctxStatic}/weixin/images/lottimages/2.png" id="sorry-img" style="display:none;" />
	<div class="banner">
		<div class="turnplate" style="background-image:url(${ctxStatic}/weixin/images/lottimages/turnplate-bg.png);background-size:100% 100%;">
			<canvas class="item" id="wheelcanvas" width="422px" height="422px"></canvas>
			<img class="pointer" src="${ctxStatic}/weixin/images/lottimages/turnplate-pointer.png" />
		</div>

	</div>
</div>
<div class="reward_text">
	<!--手机号-->
	<div class="phone">
		<p id="erro_text" style="text-align: center;line-height: 10px;color: red;"></p>
	</div>
	<div class="phone">
		<input type="text" id="phone" style="text-align: center;" maxlength="11" class="phone" placeholder="输入手机号进行抽奖"/>
	</div>
	<div class="reward" id="giftdiv">
		<!--<h3>活动奖励：</h3>
        <p>30元油气券：可以购买油气</p>
        <p>30元油气券：可以购买油气</p>
        <p>30元油气券：可以购买油气</p>
        <p>30元油气券：可以购买油气</p>-->
	</div>
	<div class="rule" >
		<h3 >活动规则：</h3>
		<p id="lotteryinfo"></p>
	</div>
</div>
</body>
</html>