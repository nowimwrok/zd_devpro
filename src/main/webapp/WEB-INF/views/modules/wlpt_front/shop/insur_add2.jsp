<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>填写保单</title>


    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<style>
        * {
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
        form {
            width: 100%;
            margin: 50px 0;
        }
        .main-center{
            width:700px;
            margin: 0 auto;
        }
    
        .one { margin:15px 0;}
        .one label { 
            width:240px; 
            float:left; 
            text-align:right; 
            height:35px; 
            line-height:35px;
            font-weight: normal;
        }
        .one input { 
            width: 260px;
            border:1px solid #ccc; 
            height:35px;
            margin-left: 10px;
        }
        .main-center h3{
            width: 100%;
            font-size: 22px;
            text-align: center;
            border-bottom :1px solid #ccc;
        }
        .main-center .btn{
            margin: 20px 20px;
            width: 50%;
        }
        .user_data{
            margin: 30px auto;
        }
        .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 30px;
            left:0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
</style>

</head>
<body>


        <form method="post" id="Form">
            <div class="main-center">
                <div class="baodan-one">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">投保</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    <div class="one">
                        <label for="toubao_people">投保人:</label>
                        <input type="text" id="toubao_people" name="applicant" class="a1" placeholder="投保人姓名"/>
                    </div>
					
                    <div class="one">
                        <label for="toubao_goods">被保货物:</label>
                        <input type="text" id="toubao_goods" class="a1" name="goodsname" placeholder="被保险货物的名称"/>
                    </div>

                    <div class="one">
                        <label for="goods_type">货物类型:</label>
                        <input type="text" id="goods_type" class="a1" name="goodstype" placeholder="被保险货物的类型"/>
                    	
                    </div>

                    <div class="one">
                        <label for="goods_worth">货物价值(元):</label>
                        <input type="text" id="goods_worth" class="a1" name="worth" placeholder="被保险货物的价值"/>
                    </div>

                    <div class="one">
                        <label for="Address">联系地址:</label>
                        <input id="applicantprovince" name="applicantAddress.province" type="hidden">
                        <input id="applicantcity" name="applicantAddress.city" type="hidden">
                        <input id="applicantdistrict" name="applicantAddress.district" type="hidden">
                        <input name="applicantAddress.type" value="0" type="hidden">
                        <input type="text" id="Address" readonly="readonly" placeholder="请选择出发地">
                    </div>
                    <div class="one">
                        <label for="detail_address">详细地址:</label>
                        <input type="text" id="applicant_address" name="applicantAddress.address" placeholder="被保险货物的详细地址"/>

                    </div>
                    <div class="one">
                        <label for="tel">联系电话:</label>
                        <input type="text" id="tel" class="a1" name="applicantAddress.linkmobile" placeholder="联系电话"/>
                    </div>
                </div>
                <div class="baodan-two">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">运输</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    <div class="one">
                        <label for="car_id">车牌号码:</label>
                        <input type="text" id="car_id" class="a1" name="carnumber" placeholder="运输车辆车牌号码"/>
                    </div>

                    <div class="one">
                        <label for="car_type">机动车类型:</label>
                        <input type="text" id="car_type" class="a1" name="cartype" placeholder="运输车辆机动车类型"/>
                    </div>

                    <div class="one">
                        <label for="chanp_tn">厂牌型号:</label>
                        <input type="text" id="chanp_tn" class="a1" name="carmodel" placeholder="运输车辆厂牌型号"/>
                    </div>

                    <div class="one">
                        <label for="all_weight">总质量(吨):</label>
                        <input type="text" id="all_weight" class="a1" name="totalweight" placeholder="运输车辆机总质量"/>
                    </div>

                    <div class="one">
                        <label for="hed_weight">核定载质量(吨):</label>
                        <input type="text" id="hed_weight" class="a1" name="carweight" placeholder="运输车辆核定载质量"/>
                    </div>
                </div>
                <div class="baodan-three">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">线路</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    <div class="one">
                        <label for="from_address">始发地:</label>
                        <input id="fromprovince" name="shipAddress.province" type="hidden">
                        <input id="fromcity" name="shipAddress.city" type="hidden">
                        <input id="fromdistrict" name="shipAddress.district" type="hidden">
                        <input name="shipAddress.type" value="0" type="hidden">
                        <input type="text" id="from_address" class="a1" placeholder="始发地址" readonly="readonly"/>
                        <input type="text" id="detail_faddress" class="a1" name="shipAddress.address" placeholder="始发详细地址"/>
                    </div>

                    <div class="one">

                        <label for="end_address">目的地:</label>
                        <input id="toprovince" name="consignAddress.province" type="hidden">
                        <input id="tocity" name="consignAddress.city" type="hidden">
                        <input id="todistrict" name="consignAddress.district" type="hidden">
                        <input name="consignAddress.type" value="1" type="hidden">
                        <input type="text" id="end_address" class="a1" placeholder="目的地址" readonly="readonly"/>
                        <input type="text" id="detail_taddress" class="a1" name="consignAddress.address" placeholder="目的详细地址"/>
                    </div>

                </div>
                <div class="baodan-four">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">承保</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    <div class="one">
                        <label for="">承保险种:</label>
                        <input type="text" id="" class="a1" name="insurancetype" value="国内公路货物运输保险" readonly="readonly"/>
                    </div>

                    <div class="one">
                        <label for="">保险金额/责任限额:</label>
                        <input type="text" id="" class="a1" name="insuranceamount" value="160000" readonly="readonly"/>
                    </div>

                    <div class="one">
                        <label for="">保险费合计(单位:元):</label>
                        <input type="text" id="" class="a1" name="insurancefeel" value="60" readonly="readonly"/>
                    </div>

                </div>
                <div class="load">
                   <img src="/static/images/loading.gif">
                   <p>加载中</p>
                </div>
                <div class="baodan-four" style="text-align: center;">
                <input id="btnSubmit" type="button" class="btn btn-warning" value="提&nbsp;&nbsp;交&nbsp;&nbsp;保&nbsp;&nbsp;单">
                </div>
            </div>
        </form>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
   $(".load").hide();
   $("#Address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var applicantcounty="";
            if (data.province) {
                str += data.province.NAME;
                $("#applicantprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#applicantcity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                applicantcounty=data.county.NAME;
                $("#applicantdistrict").val(data.county.NAME);
            }
            if(applicantcounty==""){
            	str="";
            }
            $("#Address").val(str);
        }
    });
    $("#from_address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var fromcounty="";
            if (data.province) {
                str += data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                fromcounty=data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            if(fromcounty==""){
            	str="";
            }
            $("#from_address").val(str);
        }
    });
    $("#end_address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var tocounty="";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                tocounty=data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            if(tocounty==""){
            	str="";
            }
            $("#end_address").val(str);
        }
    });
    
    getCarType();

    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#car_type").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#car_type").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    
    $("#btnSubmit").click(function () {
    	var status = "${user.userinfo.status}";
        if (status != '2') {
        	$.MsgBox.Alert("温馨提示", "认证用户才可购买");
        	return;
        }

    	var isnul = true;
        isnul = isnul && $("input[name=applicant]").valid({
                    methods: "required|isName"
                });
        isnul = isnul && $("input[name=goodsname]").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=goodstype]").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=worth]").valid({
            methods: "required|isdecimal"
        });
        isnul = isnul && $("#Address").valid({
            methods: "required"
        });
        isnul = isnul && $("#applicant_address").valid({
            methods: "required"
        });
        isnul = isnul && $("#tel").valid({
            methods: "required|isPhone"
        });
        
        isnul = isnul && $("input[name=carnumber]").valid({
            methods: "required"
        });
        isnul = isnul && $("input[name=cartype]").valid({
            methods: "required"
        });
        isnul = isnul && $("input[name=carmodel]").valid({
            methods: "required"
        });
        isnul = isnul && $("input[name=totalweight]").valid({
            methods: "required|isdecimal"
        });
        isnul = isnul && $("input[name=carweight]").valid({
            methods: "required|isdecimal"
        });
        
        isnul = isnul && $("#from_address").valid({
            methods: "required"
        });
        isnul = isnul && $("#detail_faddress").valid({
            methods: "required"
        });
        isnul = isnul && $("#end_address").valid({
           methods: "required"
        });
        isnul = isnul && $("#detail_taddress").valid({
           methods: "required"
        });
        
        if ($(".load").is(':hidden') && isnul) {
            $(".load").show();
        } else {
            return false;
        }
        $.MsgBox.Confirm("温馨提示", "确定提交保单？", function() {
	        $.ajax({
	            url: "${wlpt}/wlpt/shop/saveInsur?" + $("#Form").serialize(),
	            dataType: 'json',
	            type: "post",
	            success: function (data) {
	                if (data.state == 1) {
	                	$.MsgBox.Confirm("温馨提示", "您的保单已提交，您可立即支付或在我的保单中继续支付，立即支付!", function() {
	                    	window.location.href = "${wlpt}/wlpt/shop/toinsurpay?id="+data.data.id;
	                	 }, function() {
	                		 window.location.href = "${wlpt}/wlpt/personal/index?flag=zhzx";
	             		}, null, null, "立即支付", "取消");
	                } else {
	                    $.MsgBox.Alert("保存提示", data.value.message);
	                }
	            }
	        });
        }, function() {
        	 $(".load").hide();
		}, null, null, "确定", "取消");
    });
</script>
</body>

</html>