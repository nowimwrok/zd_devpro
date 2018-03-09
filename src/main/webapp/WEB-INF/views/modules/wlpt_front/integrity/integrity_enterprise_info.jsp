<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>企业诚信信息</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/top_menu.css">
    
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
    }
    ul p span a input td{
        font-family: "微软雅黑";
    }
    .qiye_infor_right img {
	    width: 100px;
	    height: 100px;
	}	
	   
.qiye_infor_center {
    text-align: left;
    padding-left: 10px;
    height: 50px;
    line-height: 50px;
}
.qiye_infor_center input[type="text"] {
    width: 60%;
    padding: 5px;
    text-indent: 5px;
}
.qiye_infor_left {
    width: 25%;
    text-align: right;
    height: 50px;
}
input {
		margin-left:5px;
		padding: 5px;
		height: 37px;
	    padding-left: 5px;
	    line-height: 25px;
	}
    </style>
<link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="${ctxStatic }/jquery-select2/3.4/select2.min.css" rel="stylesheet">
<link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
<link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">


<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/global.js" type="text/javascript" ></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
    <%-- 
    <script type="text/javascript">
    $(document).ready(function () {
        $("#inputForm").validate({
        	rules: {
			},
			messages: {
				
			},
            submitHandler: function (form) {
                loading('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
    </script>
    --%>
</head>

<body>
<ul class="qiye_menu">
        <li data-type="1" class="qiye_menu_1">基本信息</li>
        <li data-type="2" ><a href="${wlpt }/wlpt/integrity/goEnterprise_Picture" target="content" style="color: #000;">企业资质</a></li>
    </ul>
<!-- 公司基本信息 -->
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">完善</span><span
        class="title_orange">基本资料</span><img src="${ctxStatic}/images/wlptfront/line-right.png">
</p>
<form:form id="inputForm" modelAttribute="integrityEnterprise" action="${wlpt}/wlpt/integrity/entrprseInfoSave" method="post" class="form-horizontal">
<form:hidden path="id"/>
<form:hidden path="user.id"/>	
<table class="qiye-infor">
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>企业名称:</td>
            <td class="qiye_infor_center">
            <input id="companyname" name="companyname" value="${not empty integrityEnterprise.companyname?integrityEnterprise.companyname:userCompany.companyname}"/></td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>企业法人:</td>
            <td class="qiye_infor_center"><input id="name" name="name" value="${not empty integrityEnterprise.name?integrityEnterprise.name:userCompany.legalperson}"/></td>
            <!-- <td class="qiye_infor_right"><span class="photo-word">图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式</span>  -->
            </td>
        </tr>
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>法人现地址:</td>
            <td class="qiye_infor_center"><input name="persionaladdress" id="persionaladdress" value="${integrityEnterprise.persionaladdress}"/></td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>公司成立时间:</td>
            <td class="qiye_infor_center">
			<input id="operationyearstime" name="operationyearstime" type="text" readonly="readonly" maxlength="20" style="height: 39px;width: 37%;" class="Wdate "
					value="<fmt:formatDate value="${not empty integrityEnterprise.operationyearstime?integrityEnterprise.operationyearstime:userCompany.setuptime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});"/>
			</td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>

        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>公司地址:</td>
            <td class="qiye_infor_center"><input name="companyaddress" id="companyaddress" value="${not empty integrityEnterprise.companyaddress?integrityEnterprise.companyaddress:userCompany.provinceCityDistrict}"/></td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>
       
        <tr>
            <td class="qiye_infor_left">企业简介（500字以内）:</td>
            <td class="qiye_infor_center"><form:textarea path="companyinfo" htmlEscape="false" cols="50" cssStyle="line-height:20px !important;font-size:15px !important;color:#000;" rows="5" maxlength="500" style="margin-top: 5px;"/></td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>

    </table>
    <div class="table_2">
        <p class="user_data break-up">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">联系</span><span class="title_orange">方式</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <table class="table2_con">
            <tr>
                <td class="table_2_left">
                      <p class="ta"><!-- <span class="star_red">*</span> -->企业电话：</p>
                      <input id="linkphone" name="linkphone" value="${integrityEnterprise.linkphone}" style="padding: 5px;height:35px;width:38%;"/>
                </td>
                <td class="table_2_right">
                   
                </td>
            </tr>
            
            <tr>
                <td colspan=2 style="text-align: center;"><button class="btn btn-warning btn-warnings" type="button" id="btn-warning1">保存</button></td>
            </tr>
        </table>
    </div>
</form:form>

<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/msgbox.js"></script>
  <script>
  /* if('${type}'!=''){
	  $(".qiye_menu li").qe(${type}).click();
  }
   */
   $("#btn-warning1").click(function() {
	   var isnul = true;
		isnul = isnul && $("#companyname").valid(																		{
			methods : "required"
			});
		isnul = isnul && $("#name").valid(																		{
			methods : "required"
			});
		isnul = isnul && $("#persionaladdress").valid(																		{
			methods : "required"
			});
		isnul = isnul && $("#operationyearstime").valid(																		{
			methods : "required"
			});
	//	if (isnul) {
    //        if (diffDate($("#operationyearstime")) <= 0) {
    //            isnul = false;
    //        }
     //   }
		isnul = isnul && $("#companyaddress").valid(																		{
			methods : "required"
			});
		/* isnul = isnul && $("#linkphone").valid(																		{
			methods : "required|isTel"
			}); */
		if(isnul){
			$("#btn-warning").attr('disabled','disabled');
			$("#inputForm").submit();
		}
   });
    $(".qiye_menu li").on("click",function(){
	    $(".qiye_menu li").removeClass("qiye_menu_1")
	    $(this).addClass("qiye_menu_1")
	    var type = $(this).attr("data-type");
	    $("#info"+type).show();
	    $("#info"+type).siblings("div").hide();
   })
   var msg = '${msg}';
   if(msg!=''){
	   $.MsgBox.Alert("保存提示",'${msg}');
   }
   //設置地址插件
		$("#persionaladdress").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
					$("#persionaladdress").val(str);
				} 
				if (data.city) {
					str += data.city.NAME + "";
					$("#persionaladdress").val(str);
				}
				if (data.county) {
					str += data.county.NAME + "";
					$("#persionaladdress").val(str);
				}
				if (str!=""){
					$("#persionaladdress").val(str);
				}else{
					$("#persionaladdress").val("");
				}

			}
		});
		$("#companyaddress").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "/static/images/close_hover.png",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME + "";
					$("#companyaddress").val(str);
				} 
				if (data.city) {
					str += data.city.NAME + "";
					$("#companyaddress").val(str);
				}
				if (data.county) {
					str += data.county.NAME + "";
					$("#companyaddress").val(str);
				}
				if (str!=""){
					$("#companyaddress").val(str);
				}else{
					$("#companyaddress").val("");
				}

			}
		});
</script>
<script type="text/javascript">

   
</script>
</body>
</html>