<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>${agreement.name}</title>
<style type="text/css">
.wl_content_div{ 
  width:980px; 
  margin:0px auto;
  /* text-align:center;  */
  padding:0px;
  padding-bottom: 40px;
  margin-top:15px;
  border: 1px #ccc solid;
}
.foot_title_div{
  height: 50px;
  padding-top:15px;
  padding-bottom:15px;
  font-weight:700; 
  font-size: 36px;
  font-family: 微软幼圆; 
  color: rgb(50,50,50);
}
.foot_border_div{
  width: 930px;
  margin:0px auto;
  height: 6px; 
}
.foot_border_leftdiv{
  width: 100px;
  border-top: 4px #ff7300 solid;
  float: left; 
  height: 5px;
}
.foot_border_rightdiv{
  width: 830px;
  border-bottom: 1px #ccc solid;
  float: right;
  height: 3px;
}
.foot_content_div{ 
  width: 860px;
  margin:0px auto; 
  padding:10px 50px 0px 50px ;
}
.mt15{
  margin-top:15px;
}
body {
  width: 100%; margin: 0px;
}
.tabledetail-title{
  width:1000px; 
  margin:0px auto;
  padding-top: 5px;
  font-family: "微软雅黑";
  color: #999;
}
#title_a_title{
  text-decoration:none;
  color: #999;
}
#title_a_title:hover{
  color:#4100FF;
  text-decoration:underline;
}
</style>		
</head>

<body>
	<table class='tabledetail-title'>
		<tbody>
			<tr>
				<td style="font-size: 14px;">当前位置: <font id="title_font" style="color: rgb(110,110,110);font-size: 14px;"> 
				<a href="${wlpt}" id="title_a_title" style="font-size: 14px;">首页  </a><span>></span><span style="color: #999;"> ${agreement.name}</span>
				</font>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="wl_content_div">
	<div class="foot_content_div">${agreement.content}</div>
	</div>
</body>
</html>