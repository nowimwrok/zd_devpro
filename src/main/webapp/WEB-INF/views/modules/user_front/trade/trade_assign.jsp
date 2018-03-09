<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>修改报价信息</title>
    <style type="text/css">
		.loadings{
			text-align: center;
		}
		.loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }
    </style>
    <link href="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.css" type="text/css" rel="stylesheet"/>
	<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
 	<link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="dataHall" ng-controller="dataHallCtrl">

	<div class="row">
       	<div class="col-lg-12">
       		<div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                                                                           货物详情
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>地址信息</strong></div>
                            <div class="col-sm-10  goods_details">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">始发地</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.shipAddress.city}${goods.shipAddress.district}</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">详细地址</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.shipAddress.address }</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">目的地</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.consignAddress.city }${goods.consignAddress.district }</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">详细地址</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.consignAddress.address }</div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>货物基本信息</strong></div>
                            <div class="col-sm-10  goods_details" style="margin-bottom:0;">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">货物名称</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.goodsname}</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">货物重量</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.freightvolume }吨</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">车型要求</div>
                                    <div class="col-sm-9 text-left detList_con">${goods.cartype }</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
       		
       		<div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        	报价信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                    	<div class="row">
                    		<div class="col-sm-2 text-right"><strong>基本信息</strong></div>
                            <div class="col-sm-10  goods_details" style="margin-bottom:0;">
                            	
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">配载吨位</div>
                                    <div class="col-sm-9 text-left detList_con">
                                    <c:if test="${quoteinfo.isreload==1 }">
                                    	${quoteinfo.actload}吨
                                    </c:if>
                                    <c:if test="${quoteinfo.isreload!=1 }">
                                    	${quoteinfo.oddloadweight}吨
                                    </c:if>
                                    </div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">本次报价</div>
                                    <div class="col-sm-9 text-left detList_con">${quoteinfo.ooferprice}元/吨</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">状态</div>
                                    <div class="col-sm-9 text-left detList_con">
                                    	<span style="display:none;background-color:#5dc92f;color:#fff;padding:2px;">${fns:getDictLabel(quoteinfo.quotestatus, 'quotestatus', '')}</span>
                                    </div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">报价时间</div>
                                    <div class="col-sm-9 text-left detList_con"><fmt:formatDate value="${quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd"/></div>
                                </div>
                            </div>
                    	</div>
                    </div>
                </div>
            </div>
       		<div class="panel clearfix">
                 <div class="form_container">
                     <h4 class="panel-heading">
                         	运输信息
                     </h4>
                     <div class="col-sm-12 form-horizontal">
                     	<div class="form-group col-sm-4">
         					<div class="col-sm-5 control-label text-right">
         						司机
         					</div>
         					<div class="col-sm-7 text-left" id="driverinfo">
         						<select name="driverid" id="driverid"  class="form-control" placeholder="请输入司机手机号码或姓名" >
							        <option value="" id="driveroption">请选择...</option>
							    </select>
         					</div>
         				</div>
         				<div class="col-sm-2"></div>
         				<div class="form-group col-sm-4">
         					<div class="col-sm-5 control-label text-right">
         						车辆
         					</div>
         					<div class="col-sm-7 text-left" id="carinfo">
         						<select name="carid" id="carid"  class="form-control" placeholder="请输入车牌号码" >
							         <option value="" id="caroption" >请选择...</option>
							    </select>
         					</div>
         				</div>
                     </div>
                 </div>
             </div>
       		<div class="col-sm-12" style="margin-bottom:80px;margin-top:20px;">
            	<div class="col-sm-2"></div>
            	<div class="col-sm-4">
            		<button class="btn btn-primary col-sm-12" id="btnSubmit">确认运输</button>
            	</div>
            	<div class="col-sm-4">
            		<button class="btn btn-warning col-sm-12">返  回</button>
            	</div>
            </div>
            <!-- <div class="loading">
		        <img src="/static/images/loading.gif">
		        <p>加载中</p>
		    </div> -->
       		<sys:wlptmessage content="${message}"/>
       	</div>
   	</div>

</div>

 <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
 <script src="${ctxStatic }/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
 <script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
 <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
 <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
 <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
    
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/autocomplete.js?id=45" type="text/javascript"></script>
<script>
$("#maskloading" , parent.document).hide();
    getcaranddriverinfo("${user.id}")
    function getcaranddriverinfo(userid){
    	$("#driverid").combobox();
		$("#carid" ).combobox();
    	if(userid!=undefined && userid!=""&&userid!=null){
    		$.ajax({
                url: "${wlpt}/wlpt/goods/getCarAndDriverInfo",
                dataType: 'json',
                data: {id: userid},
                cache: false,
                success: function (data) {
                	if(data.value){
                    	var driverarray = data.value.driver;
						if(driverarray!=null && driverarray.length > 0){
							var driverhtml = "";
							for (var i = 0; i < driverarray.length; i++) {
								var name = driverarray[i].reuser.name!=undefined&&driverarray[i].reuser.name!=null?driverarray[i].reuser.name:"";
								var phone = driverarray[i].reuser.phone!=undefined&&driverarray[i].reuser.phone!=null?driverarray[i].reuser.phone:"";
								var driverid = "${quoteinfo.driver.id}";
								if(driverid != "" && driverid==driverarray[i].reuser.id){
									driverhtml+='<option value="'+driverarray[i].reuser.id+'" selected="selected">'+name+'&nbsp;'+phone+'</option>';
								}else{
									driverhtml+='<option value="'+driverarray[i].reuser.id+'">'+name+'&nbsp;'+phone+'</option>';
								}
								
							}
							$("#driverid").append(driverhtml);
	                		
                    	}else{
                    		$("#driverinfo").html("该用户没有可以选择的司机！");
                    	}
                    	var cararray = data.value.car;
                    	if(cararray!=null && cararray.length > 0){
                    		var carhtml = "";
							for (var i = 0; i < cararray.length; i++) {
								var carnumber = cararray[i].carnumber!=undefined&&cararray[i].carnumber!=null?cararray[i].carnumber:"";
								var loadweight = cararray[i].loadweight!=undefined&&cararray[i].loadweight!=null?cararray[i].loadweight:"";
								var carid = "${quoteinfo.car.id}";
								if(carid != "" && carid==cararray[i].id){
									carhtml+='<option value="'+cararray[i].id+'" selected="selected">'+carnumber+'&nbsp;'+loadweight+'吨</option>';
								}else{
									carhtml+='<option value="'+cararray[i].id+'">'+carnumber+'&nbsp;'+loadweight+'吨</option>';
								}
				                    
							}
                    		$("#carid" ).append(carhtml);
		                	
                    	}else{
                    		$("#carinfo").html("该用户没有可以选择的车辆！");
                    	}
                    	
                       
                	}else{
                		$("#driverinfo").html("该用户没有可以选择的司机！");
                		$("#carinfo").html("该用户没有可以选择的车辆！");
                	}
                	
                }
            });
    		
    	}
    	
    }

    $("#btnSubmit").click(function () {
        var isnul = true;
        if ($("#driverid").val() == null || $("#driverid").val() == "") {
            $.MsgBox.Alert("交易提示","请选择司机！");
            return false;
        }
        if ($("#carid").val() == null || $("#carid").val() == "") {
            $.MsgBox.Alert("交易提示","请选择车辆！");
            return false;
        }
        
        
            var driverid = $("#driverid").val();
            var carid = $("#carid").val();
            var userid = $("#userid").val();
            $("#maskloading" , parent.document).show();
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/trade/confrimOrder',
                dataType: 'json',
                data: {
                	'id':'${oinfo.id}',
                    'quoteinfo.ischange': '1',
                    'quoteinfo.driver.id': driverid,
                    'quoteinfo.car.id': carid,

                },
                cache: false,
                success: function (data) {
                    if (data.state == "1") {
                    	$.MsgBox.Alert("交易提示",data.message);
                    	window.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true"
                    }else {
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("交易提示",data.message);
                    }
                }
            });
    });
    

</script>
</body>
</html>
