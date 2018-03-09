<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>添加车辆</title>
	<link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
    <style>
        .goods_details .form-group{
            margin-left:2.5%;
            margin-right:2.5%;
        }
         .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
        ol li{
      		float:left;
      	}
      	.form-control{
			border: 1px solid #ccc !important;
		}
		.carnumbermin{
		    padding: 5px;
   			width: 30px;
		}	
		.car_addr{
		    height: 34px;
		    padding: 6px 12px;
		    font-size: 14px;
		    line-height: 1.42857143;
		    color: #555;
		    background-color: #fff;
		    background-image: none;
		    border: 1px solid #ccc;
		    border-radius: 4px;
		    /* -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
		    /* box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
		    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
		    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		    box-shadow: none;
		}
		.car_addr[readonly], fieldset[disabled] .car_addr {
		    opacity: 1;
		    background: #fff;
		    box-shadow: none;
		}
		.text-value-left{
        	text-align: left !important;
        }
    </style>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
	<div class="row">
       	<form:form action="#" name="Form" id="Form" modelAttribute="car" method="post">
           <div class="col-lg-12">
           	 <div class="form_container">
           		<!--第一个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">
           				车辆详细信息
           			</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="form-group col-sm-4">
           					<div class="col-sm-5 control-label text-right">
           						车牌号码
           					</div>
           					<div class="col-sm-7 control-label text-value-left">
           						${car.carnumber}
           					</div>
           				</div>
           				<div class="col-sm-4 form-group">
           					<div class="col-sm-5 control-label text-left">
           						车辆来源
           					</div>
           					<div class="col-sm-7 control-label text-value-left" >
                                    ${car.issocialcar}
                                
           					</div>
           				</div>
           				<div class="col-sm-4 form-group">
           					<div class="col-sm-5 control-label text-left">
           						车辆类型
           					</div>
           					<div class="col-sm-7 control-label text-value-left">
           						${car.cartype}
           					</div>
           				</div>
           			</div>
           		</div>
           		<!--第2个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车辆信息</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					车长
            				</div>
            				<div class="col-sm-7 control-label text-value-left">
            					${car.carlength}米
            				</div>
           				</div>
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					载重
            				</div>
            				<div class="col-sm-7 control-label text-value-left">
            					${car.loadweight}吨
            				</div>
           				</div>
           				<div class="col-sm-4 form-group">
            				<div class="col-sm-5 control-label text-left">
            					常停放位置
            				</div>
            				<div class="col-sm-7 control-label text-value-left">
            					${car.oftenparkedposition }
            				</div>
           				</div>
           			</div>
           		</div>
           		<!--第3个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车主信息</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-4 form-group">
            				<div class="col-sm-5 control-label text-left">
            					车主姓名
            				</div>
            				<div class="col-sm-7 control-label text-value-left">
            					${car.ownername }
            				</div>
           				</div>
           				<div class="col-sm-4 form-group has-unit">
            				<div class="col-sm-5 control-label text-left">
            					车主手机号
            				</div>
            				<div class="col-sm-7 control-label text-value-left">
            					${car.ownermobile }
            				</div>
           				</div>
           			</div>
           		</div>
           		<!--第4个面板-->
           		<div class="panel clearfix">
           			<h4 class="panel-heading">车辆路线</h4>
           			<div class="col-sm-12 form-horizontal">
           				<div class="col-sm-6 form-group">
            				<div class="col-sm-3 control-label text-left">
            					主营路线
            				</div>
            				<div class="col-sm-8 control-label text-value-left">
            					${car.mainroad}
            				</div>
           				</div>
           				<div class="col-sm-6 form-group">
            				<div class="col-sm-3 control-label text-left">
            					定位手机号
            				</div>
            				<div class="col-sm-4 control-label text-value-left">
            					${car.locationmobile }
            				</div>
            				
           				</div>
           			</div>
           		</div>
           		<!--第5个面板-->
           		<div class="col-sm-6">
           			<div class="panel clearfix" style="padding-bottom:20px;">
           				<h4 class="panel-heading">上传照片</h4>
            			<div class="col-sm-12 form-horizontal form-addr" style="margin-bottom:0;padding-top:0;">
            				<div class="form-group col-sm-12">
            					<div class="col-sm-3 control-label text-right" style="padding-left:0;">
            						行驶证照片
            					</div>
            					<div class="col-sm-9 text-left" id="a">
            						<form:hidden id="travellicimg" path="travellicimg" htmlEscape="false" maxlength="256"/>
                    				<sys:ckfinder input="travellicimg" type="images" uploadPath="/car" readonly="true" selectMultiple="false"
                                  	maxWidth="100" maxHeight="100"/>
            					</div>
            				</div>
            			</div>
           			</div>
           		</div>
           		<!--第6个面板-->
           		<div class="col-sm-6" >
           			<div class="panel clearfix" style="padding-bottom:20px;">
           				<h4 class="panel-heading">上传照片</h4>
            			<div class="col-sm-12 form-horizontal form-addr" style="margin-bottom:0;padding-top:0;">
            				<div class="form-group col-sm-12">
            					<div class="col-sm-3 control-label text-right" style="padding-left:0;">
            						车辆外观照片
            					</div>
            					<div class="col-sm-9 text-left"  id="b">
            						<form:hidden id="carsurfaceimg" path="carsurfaceimg" htmlEscape="false" maxlength="256"/>
				                    <sys:ckfinder input="carsurfaceimg" type="images" uploadPath="/car" readonly="true" selectMultiple="true"
				                                  maxWidth="100" maxHeight="100"/>
            					</div>
            				</div>
            			</div>
           			</div>
           		</div>
           		<!--第6个面板-->
           		<div class="col-sm-12">
           			<div class="form-group" style="margin-bottom: 105px;">
	           			<c:if test="${car.status!='0' && car.status!='3'}">
	           			<div class="col-sm-4 control-label text-left"></div>
	           			</c:if>
	          			<c:if test="${car.status=='0'||car.status=='3'}">
	          			<div class="col-sm-2 control-label text-left"></div>
	          			<div class="col-sm-4">
		                    <input type="button" id="renzheng" class="btn btn-primary col-lg-12" value="申请认证">
		                </div>
		                </c:if>
		                <div class="col-sm-4">
		                    <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
		                </div>
	                </div>
	           	</div>
		       </div>
	         </div>
         </form:form>
     </div>
</div>


<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
$("#maskloading" , parent.document).hide();
$("#renzheng").click(function() {
	var id="${car.id}";
	$("#maskloading" , parent.document).show();
	$.ajax({
		url : "${wlpt}/wlpt/authentication/car_authentication?id="+id,
		dataType : 'json',
		type:"post",
		success : function(data) {
			$("#maskloading" , parent.document).hide();
			if (data.message=="申请认证成功") {
				window.location.href = '${wlpt}/wlpt/car/car_list'; 
			}else{
				$.MsgBox.Alert("认证提示",data.message);
			}
		}
	});
	
});
</script>
</body>
</html>
