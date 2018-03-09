<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>中标通知</title>
    <style type="text/css">
        .loadings {
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
        .zhang{position:relative;}
    	.zhang img{z-index:1000;position:absolute;top:-88px;z-index:0;}
    	.zhang_text{width:160px;color:#000;}
    	.zhang_text p:first-child{margin-bottom:0;}
    </style>
</head>


<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;">
	
 		<div class="row">
             <div class="col-lg-12" style="padding-bottom:20px;">
             	<!--详细内容-->
             	<div class="form_container">
             		<!--第一个面板-->
             		<form action="${wlpt}/wlpt/bid/saveNotifys" name="Form" id="Form" method="post">
        			<input name="id" value="${bidOrderinfo.id}" type="hidden">
             		<div class="panel clearfix">
             			<h4 class="panel-heading">
             				招标信息
             			</h4>
             			<div class="col-sm-12 form-horizontal">
             				<div class="col-sm-10 col-sm-offset-1">
             					<div class="alert" style="box-shadow:0 0 10px rgba(0,0,0,.1);">
             							<textarea id="noticeinfo" name="noticeinfo" class="text" style="resize: none; width: 100%;height:100px; font-size:13px; border: 0px;" onblur="isNull(this)"></textarea>
             							<!-- 恭喜您在卓大物流网竞价的钢材运输项目中中标，请务必在<span>6月24日17:00</span>前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756 -->
             						
             					</div>
             				</div>
             				<div class="col-sm-12">
             					<div class="col-sm-4"></div>
             					<div class="col-sm-4">
             						<input id="fabu" type="button" class="btn col-sm-5 btn-primary" value="发送中标通知" onclick="save()"/>
             						<div class="col-sm-2"></div>
             						<input id="print" type="button" class="btn col-sm-5 btn-primary"  value="打印中标通知书"/>
             					</div>
             				</div>
             			</div>
             		</div>
             		</form>
             		<div class="panel clearfix" id="printhtml" style="margin-bottom:40px;">
             			<h4 class="panel-heading">
             				中标通知书
             			</h4>
             			<div class="col-sm-12 form-horizontal">
             				<h3 class="text text-danger text-center" style="margin-top:0;">中标通知书</h3>
             				
             				<div class="col-sm-10 col-sm-offset-1 ">
             					<p class="text" style="color:#000;font-weight:bold"><span>${biddinginfo.biddinguser.loginName}：</span></p>
             				</div>
             				<div class="col-sm-10 col-sm-offset-1">
             					<p class="text" style="line-height:24px;text-indent:28px;color:#000;">
             						恭喜！你单位在卓大平台上招标文号<span>${biddinginfo.bidinfo.bidcode}</span>的招标项目中，经评委综合评审，你单位满足招标要求确定为此项目中标单位。请务必在<span id="thistimes"></span>前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756
             					</p>
             					<p class="text" style="text-indent:28px;color:#000;">总价：<span id="price"><fmt:formatNumber value="${bidinfo.goods.freightvolume*biddinginfo.biddingprice}" type="Double"
                                              pattern="0.00"></fmt:formatNumber></span>元（具体单价详见招标比价单）</p>
             					<p class="text" style="text-indent:28px;color:#000;">吨数：<span id="bidloadweight">${bidinfo.goods.freightvolume}</span>${bidinfo.goods.freightunit}（具体重量详见招标比价单）</p>
             					<p class="text" style="text-indent:28px;color:#000;">具体要求以招标文件和合同为准</p>
             					<p class="text" style="text-indent:28px;color:#000;">特此通知。</p>
             					<input type="hidden" id="loadweight" value="${pd.LOADWEIGHT}"/>
                        		<input type="hidden" id="biddingprice" value="${pd.BIDDINGPRICE}"/>
             				</div>
             				<div class="col-sm-12" style="height:60px;"></div>
             				<div class="col-sm-12 form-group">
             					<div class="col-sm-4 pull-right">
             						<div class="zhang" style="position:relative;">
             							<div class="zhang_text" style="{width:160px;color:#000;margin-bottom:0;">
             								<p class="text-center">代理单位（盖章）</p>
             								<p class="text-center">日期：<span id="nowdates">2017</span></p>
             							</div>
             							<img src="${pageContext.request.contextPath}/static/images/zd2.png" alt="" class="img-responsive" style="width:160px;position:absolute;top:-88px;z-index:1000;"/>
             						</div>
             					</div>
             				</div>
             			</div>
             		</div>
             	</div>
             </div>
         </div>
    
</div>






<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctxStatic }/jquery/jquery.PrintArea.js"></script>
<script type="text/javascript">
$("#maskloading" , parent.document).hide();
    $("#print").click(function () {
    	$("#printhtml").printArea(); 
    });
    //提交
    function save() {
        if (isNull($("#noticeinfo"))) {
            $("#fabu").attr('disabled', 'disabled');
            $("#Form").submit();
        }
    }
    //非空判断，为空返回false，不为空返回true
    function isNull(obj) {
        var content = jQuery.trim($(obj).val());
        if (content == null || content == '') {
            $(obj).tips({
                side: 3,
                msg: '不能为空',
                bg: '#FF7300',
                time: 3
            });
            return false;
        }
        return true;
    }

    var myDate = new Date();
    $("#nowdates").html(myDate.toLocaleDateString());
    myDate.setDate(myDate.getDate() + 2);
    var thedate = myDate.getDate() < 10 ? "0" + myDate.getDate() : myDate
            .getDate(); //获取当前几号，不足10补0
    var thetimes = (myDate.getMonth() + 1) + "月"
            + thedate;
    $("#thistimes").html(thetimes);
    $("#noticeinfo").val("恭喜您在卓大物流网竞价的钢材运输项目已中标，请务必在" + thetimes + "日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756");

    var loadweight = $("#loadweight").val();
    var biddingprice = $("#biddingprice").val();

    if (loadweight != "" && biddingprice != null) {
        $("#price").html(((loadweight * 1) * (biddingprice * 1)).toFixed(2));
        $("#bidtotal").val(((loadweight * 1) * (biddingprice * 1)).toFixed(2));
    }

    //是否已经生成运输合同
    $(function () {
        var BIDINFO_ID = $("#BIDINFOID").val();
        if (BIDINFO_ID != null && BIDINFO_ID != "") {
            $.ajax({
                url: "${pageContext.request.contextPath}/wlpt/orders/isBidOrder",
                dataType: 'json',
                data: {BIDINFOID: BIDINFO_ID},
                type: 'post',
                cache: false,
                async: false,
                success: function (data) {
                    if (data.count > 0) {
                        $("#fabu").attr("disabled", true);
                        $("#fabu").val("已发送中标通知");
                        $("#nowdates").html('${pd.NOTICETIME}');

                        var myDates = new Date('${pd.NOTICETIME}');
                        myDates.setDate(myDates.getDate() + 2);
                        var thedates = myDates.getDate() < 10 ? "0" + myDates.getDate() : myDates
                                .getDate(); //获取当前几号，不足10补0
                        var thetimess = (myDates.getMonth() + 1) + "月"
                                + thedates;
                        $("#thistimes").html(thetimess);
                        $("#noticeinfo").val(
                                "恭喜您在卓大物流网竞价的钢材运输项目已中标，请务必在" + thetimess + "日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756");
                    }
                }


            });
        }
    });

    //格式数字后面的0
    function geShi(num) {
        if (num != null && num != "") {
            return parseFloat(num);
        } else {
            return "--";
        }
    }
    $("#price").html(geShi($("#price").html()));
    $("#bidloadweight").html(geShi($("#bidloadweight").html()));
</script>


</body>
</html>
