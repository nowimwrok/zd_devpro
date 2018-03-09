<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
<title>资讯新闻</title>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/global_mainbody.css">
<link  href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<style type="text/css">
	 *{
            margin: 0px;
            padding: 0px;
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
    
	</style>
	
</head>
<body>
    <!-- 新闻列表 -->
   <div class="news-list" style="border-top:1px #ccc solid;width:100%;padding-top: 30px;">
        <div id="container-index">
			<table id="contentdetail" style="margin: auto;">
				<tbody>
					<tr>
						<td valign="top" height="400">
							<table class="tabledetail-title" style="width:829px;text-align: center;">
								<tbody>
									<!-- 
									<tr>
										<td>&nbsp;</td>
										<td style="font-size: 14px;">当前位置:<font style="COLOR: red;font-size: 14px;"> 
										
										<a href="/common/index" style="font-size: 14px;">首页</a>&gt;
										
										<a href="/wlpt/info/news" style="font-size: 14px;">物流新闻</a>
										&gt;<a href="/wlpt/info/news/newsinfolist?NEWNAME=国内" style="font-size: 14px;">国内</a>
										&gt;<b style="font-size: 14px;">正文</b>
										</font>
										</td>
									</tr>
									 -->
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="tr-tatle">
										<td class="titletd">&nbsp;</td>
										<td class="titletd"><font class="titlefont" style="font-weight: bold;font-family: 微软雅黑;font-size: 20px;">${baseNews.title }</font></td>
									</tr>
								
									<tr class="tr-tatle">
										<td align="center" colspan="2" style="color: rgb(180,180,180);font-size: 10px;font-family: 微软雅黑;"> 来源：${baseNews.source }
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发布时间：<span value="2016-01-11"><fmt:formatDate value="${baseNews.releaseTime }" pattern="yyyy-MM-dd"/></span>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</tbody>
							</table>
							<table width="892" cellspacing="0" cellpadding="0" border="0" align="center">
								<tbody>
									<tr>
										<td height="1" bgcolor="#D8D8D8"></td>
									</tr>
								</tbody>
							</table>
							<table width="860" cellspacing="0" cellpadding="0" border="0" align="center">
								<tbody>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td style="font-family: 微软雅黑;">${baseNews.content }</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="center">【<a href="common/index" onclick="self.close()"> 关闭窗口</a> 】
										</td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
    </div>
   <script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
   <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
   <script >
 //鼠标悬停出现二级菜单
   $(".secon_menu_wrap").mouseover(function() {
           $(this).find(".new_secon_menu").css("display","block")
          
       }).mouseout(function() {
           $(this).find(".new_secon_menu").css("display","none")
       });
   $(".secon_menu_wrap li").on("click",function(){
	   var newstype= $(this).attr("data-newstype");
	   $("#newstype").val(newstype);
	   page(1);
   })
   
   </script>
   


</body>
</html>