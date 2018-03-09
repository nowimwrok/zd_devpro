<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>卓大平台大转盘抽奖</title>

		<link
			href="${pageContext.request.contextPath}/static/css/lottcss/style.css"
			rel="stylesheet" type="text/css">

			<script type="text/javascript"
				src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"
				language="javascript"></script>
			<script type="text/javascript"
				src="${pageContext.request.contextPath}/static/js/lottery/awardRotate.js"></script>

			<script type="text/javascript">
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
				var giftnumcount = 0;
				var ACTIVITY_ID = '';
				$(document)
						.ready(
								function() {
									$
											.ajax({
												type : "POST",
												url : '${pageContext.request.contextPath}/weixin/activitylottery/getlotterty',
												data : "",
												dataType : 'json',
												cache : false,
												async : false,
												success : function(data) {
													if (data.state == 1) {
														if (data.data.varList.length > 0) {
															for ( var i = 0; i < data.data.varList.length; i++) {

																turnplate.restaraunts[i] = data.data.varList[i].GIFTNAME;
																turnplate.giftid[i] = data.data.varList[i].GIFT_ID;
																if (data.data.varList[i].SURPLUSNUM < 1) {
																	giftnum[giftnumcount] = i + 1;
																	giftnumcount++;
																}
																ACTIVITY_ID = data.data.varList[i].ACTIVITY_ID;
																if (data.data.varList[i].GIFTTYPE != 2) {
																	$(
																			"#giftdiv")
																			.append(
																					"<div style='width:100%;'><span style='padding-left:15%;'>"
																							+ data.data.varList[i].GIFTNAME
																							+ ":"
																							+ data.data.varList[i].GIFTCONTENT
																							+ "</span></div>");
																}
															}
															$("#gifttitle").html(data.data.pd.ACTIVITY_NAME);
															$("#lotteryinfo").html(data.data.pd.ACTIVITY_CONTENT);
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
										turnplate.colors[i] = (i % 2 == 0) ? "#FFFFFF"
												: "#FFF4D6";
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
										$('#wheelcanvas')
												.rotate(
														{
															angle : 0,
															animateTo : angles + 1800,
															duration : 8000,
															callback : function() {

																$
																		.ajax({
																			type : "POST",
																			url : '${pageContext.request.contextPath}/weixin/activitylottery/savelotterty',
																			data : {
																				GIFTID : giftid,
																				ACTIVITYID : ACTIVITY_ID
																			},
																			dataType : 'json',
																			cache : false,
																			async : false,
																			success : function(
																					data) {
																				if (data.state == 1) {
																					alert(txt);
																				} else {
																					alert(data.message);
																				}
																			}
																		});

																turnplate.bRotate = !turnplate.bRotate;
															}
														});
									};

									$('.pointer')
											.click(
													function() {
														if (turnplate.bRotate)
															return;
														turnplate.bRotate = !turnplate.bRotate;
														//获取随机数(奖品个数范围内)
														var item = rnd(
																1,
																turnplate.restaraunts.length);
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
																item = rnd(
																		1,
																		turnplate.restaraunts.length);
															} else {
																break;
															}
														}
														//奖品数量等于10,指针落在对应奖品区域的中心角度[252, 216, 180, 144, 108, 72, 36, 360, 324, 288]
														rotateFn(
																item,
																turnplate.restaraunts[item - 1],
																turnplate.giftid[item - 1]);
														/* switch (item) {
															case 1:
																rotateFn(252, turnplate.restaraunts[0]);
																break;
															case 2:
																rotateFn(216, turnplate.restaraunts[1]);
																break;
															case 3:
																rotateFn(180, turnplate.restaraunts[2]);
																break;
															case 4:
																rotateFn(144, turnplate.restaraunts[3]);
																break;
															case 5:
																rotateFn(108, turnplate.restaraunts[4]);
																break;
															case 6:
																rotateFn(72, turnplate.restaraunts[5]);
																break;
															case 7:
																rotateFn(36, turnplate.restaraunts[6]);
																break;
															case 8:
																rotateFn(360, turnplate.restaraunts[7]);
																break;
															case 9:
																rotateFn(324, turnplate.restaraunts[8]);
																break;
															case 10:
																rotateFn(288, turnplate.restaraunts[9]);
																break;
														} */
														console.log(item);
													});
								});

				function rnd(n, m) {
					var random = Math.floor(Math.random() * (m - n + 1) + n);
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
						ctx.font = '16px Microsoft YaHei';
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
									ctx.font = j == 0 ? 'bold 20px Microsoft YaHei'
											: '16px Microsoft YaHei';
									if (j == 0) {
										ctx
												.fillText(
														texts[j] + "M",
														-ctx
																.measureText(texts[j]
																		+ "M").width / 2,
														j * line_height);
									} else {
										ctx
												.fillText(
														texts[j],
														-ctx
																.measureText(texts[j]).width / 2,
														j * line_height);
									}
								}
							} else if (text.indexOf("M") == -1
									&& text.length > 6) {//奖品名称长度超过一定范围 
								text = text.substring(0, 6) + "||"
										+ text.substring(6);
								var texts = text.split("||");
								for ( var j = 0; j < texts.length; j++) {
									ctx.fillText(texts[j], -ctx
											.measureText(texts[j]).width / 2, j
											* line_height);
								}
							} else {
								//在画布上绘制填色的文本。文本的默认颜色是黑色
								//measureText()方法返回包含一个对象，该对象包含以像素计的指定字体宽度
								ctx.fillText(text,
										-ctx.measureText(text).width / 2, 0);
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
</head>
<body style="background:#e62d2d;overflow-x:hidden;">
	<br> <!-- 代码 开始 --> <img
		src="${pageContext.request.contextPath}/static/images/wlpt/images/lottimages/1.png"
		id="shan-img" style="display:none;" /> <img
		src="${pageContext.request.contextPath}/static/images/wlpt/images/lottimages/2.png"
		id="sorry-img" style="display:none;" />
		<div style="color:yellow;font-size:22px;font-family: inherit;text-align:center;padding-bottom:20px;"><span id="gifttitle">卓大平台抽奖活动</span></div>
		<div class="banner">
			<div class="turnplate"
				style="background-image:url(${pageContext.request.contextPath}/static/images/wlpt/images/lottimages/turnplate-bg.png);background-size:100% 100%;">
				<canvas class="item" id="wheelcanvas" width="422px" height="422px"></canvas>
				<img class="pointer"
					src="${pageContext.request.contextPath}/static/images/wlpt/images/lottimages/turnplate-pointer.png" />
			</div>
		</div> <!-- 代码 结束 -->

		<div
			style="text-align:center;margin:20px 0; font:normal 14px/24px 'MicroSoft YaHei';">
			<p>
				<a href="" target="_blank"> </a>
			</p>
			<p></p>
			<p>
				<center style="display:none"></center>
			</p>
		</div>
		<div style="color:yellow;font-size:18px;font-family: inherit;">
			<div style="width:100%;">
				<span style="padding-left:6%;">活动奖励:</span>
			</div>
			<div style="width:100%;">
				<div id="giftdiv"></div>
				<!-- <div style="width:100%;">
					<span style="padding-left:15%;">一等奖:现金红包</span>
				</div>
				<div style="width:100%;">
					<span style="padding-left:15%;">二等奖:神秘礼包</span>
				</div> -->

			</div>
		</div>
		<div style="width:100%;">&nbsp;</div>
		<div style="width:100%;">&nbsp;</div>
		<div style="width:100%;">&nbsp;</div>
		<div style="width:100%;color:yellow;font-size:14px;">
			<div style="width:100%;">
				<span style="padding-left:6%;">活动规则:</span>
			</div>
			<div style="width:100%;">
			    <span style="padding-left:8%;" id="lotteryinfo"></span>
			</div>
			<div style="width:100%;">
				<span style="padding-left:8%;">本次活动最终解释权归卓大平台所有。</span>
			</div>
		</div>
</body>
</html>