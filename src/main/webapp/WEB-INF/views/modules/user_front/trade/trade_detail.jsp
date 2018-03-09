<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运单详情</title>


	<style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">
<div>
	<!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
            	<div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
                    <ul class="nav nav-tabs tab-nav-tabs">
                        <li id="trade_shadow" class="${empty urltype or urltype=='trade_shadow'?'liselect active':''}"><a href="#waybill_track" data-toggle="tab">运单跟踪</a></li>
                        <li id="trade_track" class="${urltype=='trade_track'?'liselect active':'' }"><a href="#trans_trail" data-toggle="tab">运输轨迹</a></li>
                        <li id="trade_receipt" class="${urltype=='trade_receipt'?'liselect active':'' }"><a href="#trans_voucher" data-toggle="tab">运输凭证</a></li>
                        <li id="trade_taklist" class="${urltype=='trade_taklist'?'liselect active':'' }"><a href="#receipt" data-toggle="tab">回执单</a></li>
                        <li id="to_ordercomment" class="${urltype=='to_ordercomment'?'liselect active':'' }"><a href="#voucher" data-toggle="tab">评价</a></li>
                    </ul>
                </div>
                
                <div class="panel-body">
                    <div class="tab-content">
                    	<iframe id="myFrame" src="${wlpt}/wlpt/trade/${empty urltype?'trade_shadow':urltype }?id=${orderinfo.id}" width="100%" scrolling="no" height="450px" frameborder="0"
                			name="order_content" ></iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<script>

    $(function () {
        var orderid="${orderinfo.id}"
        
        $(".tab-nav-tabs li").click(function () {
            
            $("#myFrame").attr("src", "${wlpt}/wlpt/trade/"+$(this).attr("id")+"?id="+orderid);
            $(".tab-nav-tabs li").removeClass("liselect");
            $(this).addClass("liselect");
        });
        $("#myFrame").load(function() {
    	  $(this).height(0); //用于每次刷新时控制IFRAME高度初始化
          var height = $(this).contents().height() + 10;
          $(this).height( height < 500 ? 500 : height );
          
          
          top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
          var heights =  $("#myFrame").height() + 210;
          top.$("#rightFrame").height( heights < 500 ? 500 : heights );
        }) 
       
    });
</script>
</body>
</html>
