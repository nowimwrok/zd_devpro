/* 货源查找js */
function searchGoods() {
	var flag = $("#txtFlag").val();
	var startCity = $("#txtStartCity").val();
	var fromProvince = $("#FromProv").val();
	var fromCity = $("#FromCity").val();
	var fromDistrict = $("#FromArea").val();
	var toProvince = $("#ToProv").val();
	var toCity = $("#ToCity").val();
	var toDistrict = $("#ToArea").val();
	var endCity = $("#txtEndCity").val();
	var carType = $("#selCarType").val();
	var carLength = $("#selCarLength").val().split('-');
	var loadWeight = $("#selGoodsWeight").val().split('-');
	var carLengthMin,carLengthMax;
	var loadWeightMin,loadWeightMax;
	if(!carLength || carLength.length==1){
		carLengthMin = carLength[0];
		carLengthMax = "";
	}else{
		carLengthMin = carLength[0];
		carLengthMax = carLength[1];
	}
	
	if(!loadWeight || loadWeight.length==1){
		loadWeightMin = loadWeight[0];
		loadWeightMax = "";
	}else{
		loadWeightMin = loadWeight[0];
		loadWeightMax = loadWeight[1];
	}

	if (!startCity) {	// 当startCity或endCity内容为空，清除出发城市和到达城市
		fromProvince = "";
		fromCity = "";
		fromDistrict = "";
	}

	if (!endCity) {
		toProvince = "";
		toCity = "";
		toDistrict = "";
	}

	window.location.href="weixin/goodssource?pagenow=1&fromProvince=" + fromProvince + "&fromCity=" + fromCity + "&fromDistrict=" + fromDistrict + "&toProvince=" + toProvince +"&toCity=" + toCity + "&toDistrict=" + toDistrict + "&carType=" + carType + "&carLengthMin=" + carLengthMin + "&carLengthMax=" + carLengthMax + "&loadWeightMin=" + loadWeightMin + "&loadWeightMax=" + loadWeightMax + "&flag=" + flag;
}

//********************************************************初始化地区********************************************************//
var winWidth = document.body.clientWidth;
var widths,heights;
if (parseInt(winWidth) == 320) {	// 宽320(iphone4)
	widths = 254;
	heights = 325;
} else if (parseInt(winWidth) == 375) {	// 宽375(iphone6)
	widths = 298;
	heights = 260;
} else if (parseInt(winWidth) == 414) {	// 宽375(iphone6s)
	widths = 330;
	heights = 260;
} else {	// 其它分比率
	widths = 286;
	heights = 325;
}

$("#txtStartCity").PCC({
	hasCounty:false,
	width:widths,
	height: heights,
	url: "wlpt/area/getarea",
	closeIcon : "/LogisticsSystem/static/images/weixin/area_close.png",
	complete: function (data) {
		var str = "";
		if(data.province) {
			str += data.province.NAME + " ";
			$("#FromProv").val(data.province.NAME);
		}
		if(data.city) {
			str += data.city.NAME +" ";
			$("#FromCity").val(data.city.NAME);
		}
		if(data.county){
			str += data.county.NAME;
			$("#FromArea").val(data.county.NAME);
		}
		if ("  " == str) {	// 无选择地区时
			$("#txtStartCity").val("");
		} else {
			$("#txtStartCity").val(str);
		}
	}
});

$("#txtEndCity").PCC({
	hasCounty:false,
	width:widths,
	height: heights,
	url: "wlpt/area/getarea",
	closeIcon : "/LogisticsSystem/static/images/weixin/area_close.png",
	complete: function (data) {
		var str = "";
		if (data.province) {
			str += data.province.NAME + " ";
			$("#ToProv").val(data.province.NAME);
		}
		if (data.city) {
			str += data.city.NAME + " ";
			$("#ToCity").val(data.city.NAME);
		}
		if(data.county){
			str += data.county.NAME;
			$("#ToArea").val(data.county.NAME);
		}
		if ("  " == str) {	// 无选择地区时
			$("#txtEndCity").val("");
		} else {
			$("#txtEndCity").val(str);
		}
	}
});

$(".pcc-close-icon1").css({width:'18px',height:'18px'});
$(".pcc-close-icon2").css({width:'18px',height:'18px'});

//*************************************************************车辆类型***************************************************************//
$(function() {
	//获取车辆类型
	getCarType();
})

//获取车辆类型
function getCarType(){
	$.ajax({
		url :"wlpt/cartype/getCarType.do?tm="+ new Date().getTime(),
		dataType : 'json',
		cache : false,
		success : function(data) {
			if(data.ChinaArea){
				var cartypeoption = $("#cartypeoption");
				cartypeoption.siblings().remove();
				var list = "";
				var nullname = undefined;
				for (var i = 0; i < data.ChinaArea.length; i++) {
					var name = data.ChinaArea[i].NAME;
					if(name!=nullname){
						list+="<option value='"+name+"'>"+name+"</option>";
					}

				}
				cartypeoption.after(list);
			}
		}
	});
}

