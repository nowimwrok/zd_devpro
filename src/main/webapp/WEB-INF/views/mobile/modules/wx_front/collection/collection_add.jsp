<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--编辑关注信息</title>


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
	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
table {
	width: 95%;
	margin: 5px auto;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}

table tr {
	line-height: 35px;
}

table tr td {
	border-bottom: 1px solid #CCC;
	font-size: 18px;
	line-height:35px;
}
.small_img{
	width:40px;
	height:40px;
}
.img_text {
    font-size: 0.4em;
    width: 40px;
    text-align: center;
    background-image: url(./static/images/weixin/pic_bg_normal.png);
    height: 40px;
    background-repeat: no-repeat;
    line-height: 40px;
    background-size: 40px;
    margin: 5px;
    float: left;
    cursor: pointer;
    position:relative ;
}
.img_t {
    color: rgba(37, 35, 35, 0.57);
    position: absolute;
    bottom: 0px;
    width: 40px;
    height: 28px;
}
.icon {
	float: left;
	width: 26px;
	height: 26px;
	margin-top: 7px;
}
.input_load{
	width:70%;
}
.driver_div{
	float:left;
	word-break:break-all; width:65%;
}
.upimg{width:40px;height:40px;}
.smallbtn{width:65px;};
</style>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

</head>
<body>
	<div id="content">
		<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="35%" style="text-align:right;">
						<col width="60%" style="text-align:right;">
					</colgroup>
					<tbody>
					<form:form action="${wx}/wlpt/car/saveCar" name="Form" id="Form" modelAttribute="car" method="post">
						
						<tr>
							<td align="right"><span class="font-red">*</span>关注类型：</td>
							<td>
								<input type="hidden" id="id" name="id" value="${collection.id }"/>
								<input type="hidden" id="targettype" name="targettype" value="${collection.targettype }"/>
									${fns:getDictLabel(collection.targettype, 'collectionType', '')}
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>关注线路：</td>
							<td>
								<input type="hidden" id="fromprovince" name="fromprovince" value="${collection.fromprovince }"/>
								<input type="hidden" id="fromcity" name="fromcity" value="${collection.fromcity }"/>
								<input type="hidden" id="toprovince" name="toprovince" value="${collection.toprovince }"/>
								<input type="hidden" id="tocity" name="tocity" value="${collection.tocity }"/>
									<img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/local.png" /><input
								type="text" readonly="readonly" placeholder="请选择省市"
								name="fromaddress" id="fromAddress" value="${collection.fromprovince } " class="input_load" />
								<hr> <img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />
								<input type="text"  name="toaddress" id="toAddress" value="${collection.toprovince } ${collection.tocity }" readonly="readonly"
								placeholder="请选择省市" class="input_load" /> 
							</td>
						</tr>
						 </form:form>
					</tbody>
				</table>
			<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				<button class="regbt" id="btnSubmit">
					<span style="margin-top: -1px;">保&nbsp;存</span>
				</button>
			</p>
		</div>
	</div>
	<!-- content-end -->
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js?id=111"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script type="text/javascript">

	
  //********************************************************初始化地区********************************************************//
    $("#fromAddress").PCC({
        hasCounty: false,
        width : "84%",
		height : 325,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                
                //searchConditions.fromCity = data.city.NAME;
            }
            if(str!=" "){
				$("#fromAddress").val(str);
			}else{
				$("#fromAddress").val("");
				$("#fromprovince").val("");
				$("#fromcity").val("");
			}
        }
    });

    $("#toAddress").PCC({
        hasCounty: false,
        width : "84%",
		height : 325,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                

            }
            if(str!=" "){
				$("#toAddress").val(str);
			}else{
				$("#toAddress").val("");
				$("#toprovince").val("");
			    $("#tocity").val("");
			}
        }
    });

	

	
</script>
<script type="text/javascript">


	$("#loading").hide();

	  window.altmesg = function() {
			$("#btnSubmit").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};
	  $("#btnSubmit").click(function () {
		   $("#loading").show();
			$("#btnSubmit").hide();
	      	var status ='${user.userinfo.status}';
	      	if (status!=$.myConfig.certificateStatus.status) {
			       //没有认证
				$("#btnSubmit").tips({
					side:3,
		            msg:'请先完成认证!',
		            bg:'#FF7300',
		            time:3
		        });
				altmesg();
			    return ;
			}
	        var isnul = true;
	        isnul = isnul && $("input[name=fromaddress]").valid({
	                    methods: "required"
	                });
	        isnul = isnul && $("input[name=toaddress]").valid({
	                    methods: "required"
	                });
	        
	       
	        if (!isnul) {
	        	altmesg();
	            return false;
	        }

            $.ajax({
                url: "${wx}/weixin/collection/savecollection?" + $("#Form").serialize(),
                dataType: 'json',
                type: "post",
                success: function (data) {
                    if (data.value.state == 1) {
                    	$("#btnSubmit").show();
						 $("#btnSubmit").html("关注成功");
						 $("#btnSubmit").unbind();
                        window.location.href = '${wx}/weixin/collection/toCollectionList?type='+${collection.targettype};
                    } else {
                    	altmesg();
                        $.MsgBox.Alert("保存提示", data.value.message);
                    }
                }
            });
	    });
</script>
</body>
</html>
