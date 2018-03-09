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
    width: 62%;
}
.qiye_infor_center input[type="text"] {
    width: 28%;
    padding: 5px;
    text-indent: 5px;
}
.qiye_infor_left {
    width: 25%;
    text-align: right;
    height: 50px;
}
    </style>
<link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="${ctxStatic }/jquery-select2/3.4/select2.min.css" rel="stylesheet">
<link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">


<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/global.js" type="text/javascript" ></script>
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
    })
    </script>
</head>

<body>
<ul class="qiye_menu">
        <li data-type="1" class="qiye_menu_1">基本信息</li>
        <li data-type="2" ><a href="${wlpt }/wlpt/integrity/goCarWner_Picture" target="content" style="color: #000;">照片信息</a></li>
    </ul>
<!-- 公司基本信息 -->
<p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">完善</span><span
        class="title_orange">基本资料</span><img src="${ctxStatic}/images/wlptfront/line-right.png">
</p>
<form:form id="inputForm" modelAttribute="integrityCarowner" action="${wlpt}/wlpt/integrity/carownerInfoSave" method="post" class="form-horizontal">
<form:hidden path="id"/>
<form:hidden path="user.id"/>	
<table class="qiye-infor">
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>车主姓名:</td>
            <td class="qiye_infor_center">
            <form:input path="name" htmlEscape="false" maxlength="50" cssClass="required"  style="width: 35%;"/></td>
            <td class="qiye_infor_right"></span> 
            </td>
        </tr>
        <tr>
            <td class="qiye_infor_left"><span class="star_red">*</span>车牌号码:</td>
            <td class="qiye_infor_center">
            <form:hidden path="carnumber" id="carnumber"/>
            <input id="mininame" name="mininame" type="text" style="width:40px;text-align:center;" class="required"/>
            <input type="text" id="number" name="number" value=""  maxlength="6" class="required isCarNumber"/>
            </td>
            
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
                      <p class="ta"><span class="star_red">*</span>联系人手机号码：</p>
                      <form:input path="linkphone" htmlEscape="false" maxlength="50" cssClass="required" style="padding: 5px;height:35px;width:38%;"/>
                </td>
                <td class="table_2_right">
                   
                </td>
            </tr>
            
            <tr>
                <td colspan=2 style="text-align: center;"><button class="btn btn-warning btn-warnings" type="submit" id="btn-warning">保存</button></td>
            </tr>
        </table>
    </div>
</form:form>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>

<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript"
        src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/msgbox.js"></script>

  <script>
  if('${integrityCarowner.carnumber}'!=''){
	    var carNumbers='${integrityCarowner.carnumber}';
		var MininName=carNumbers.substring(0, 1);
		var Number=carNumbers.substring(1,carNumbers.length);
		$("#mininame").val(MininName);
		$("#number").val(Number);
  }
   $("#btn-warning").click(function () {
	   var carnumber = $("#mininame").val() + $("#number").val();
       $("#carnumber").val(carnumber);
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
 //获取车牌所属地区
	getArea();
	function getArea() {
		$.ajax({
            cache: true,
            type: "POST",
            url: "${wlpt}/wlpt/chinaarea/getArea",
            data: {parentCode:"0"},
            dataType : 'json',
            async: false,
            success: function (data) {
            	if (data) {
					var adds = data;
					$("#mininame").gridSelector({
						idKey: "code",
						textKey:"mininame",
						cellWidth:50,
						cellHeight:28,
						data: adds,
						colNum: 7,
						multiSelect:false,
						complete:function(data){
							if(data){
								if(data){
									$("#mininame").val(data.mininame);
								}
							}
						}
					});
				}
            }
        });
		
	}
</script>

</body>
</html>