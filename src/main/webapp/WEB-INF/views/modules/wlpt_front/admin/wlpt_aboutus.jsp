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

.container {
    width: 100%;
    padding-right: 0px;
    padding-left: 0px;
}

		.about_us_wrap{
            width: 100%;
        }
		.about_us_title{
            width:100%;
            height: 160px;
            position: relative;
            background: url("${ctxStatic }/images/wlptfront/about_show_title_bg.png") no-repeat;
            background-size: 100% 100%;
            color: #fff;
        }
        .about_intro{
            width: 80%;
            margin:0 auto;
        }
        .logis_show{
            position: relative;
            width: 480px;
            height: 300px;
            float: right;
            margin-left: 50px;
            margin-top: -95px;
        }
        .about_us_title>div{
            width: 80%;
            margin: 0 auto;
        }
        .about_us_title h2{
            padding: 40px 0 10px;
            font-size: 36px;
            font-weight: normal;
            text-align: left;
        }
        .about_us_title p{
            text-align: left;
        }
        .intro_details p{
            text-indent: 2rem;
            line-height: 50px;
            color: #1e1b29;
            padding-top: 20px;
        }
        .intro_details{
            margin-bottom: 160px;
        }  
</style>		
</head>

<body>
	<%-- <table class='tabledetail-title'>
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
	</div> --%>
	<div class="about_us_wrap">
    <div class="about_us_title">
        <div>
            <h2>关于我们</h2>
            <p>about us</p>
        </div>
    </div>
    <div class="about_intro">
        <div class="logis_show">
            <img src="${ctxStatic }/images/wlptfront/about_show_bg.png">
        </div>
        <div class="intro_details">
            <p>卓大物流是一个供应链的集成商，通过搭建卓大物流平台，发布相关物流信息、提供共享物流资源，实现物流线上交易。
                同时通过拥有的信息技术、整合能力以及其他资源提供一套完整的供应链解决方案。</p>
            <p>卓大物流是一个供应链的集成商，通过搭建卓大物流平台，发布相关物流信息、提供共享物流资源，实现物流线上交易。
                同时通过拥有的信息技术、整合能力以及其他资源提供一套完整的供应链解决方案。
                卓大物流是一个供应链的集成商，通过搭建卓大物流平台，发布相关物流信息、提供共享物流资源，实现物流线上交易。
                同时通过拥有的信息技术、整合能力以及其他资源提供一套完整的供应链解决方案。</p>
        </div>
    </div>
</div>
</body>
</html>