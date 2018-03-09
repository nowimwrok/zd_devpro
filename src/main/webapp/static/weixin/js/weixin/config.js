(function($){
	$.myConfig = (function(){
		var carLength = {
           "4.2米":{val:4.2},
           "4.8米":{val:4.8},
           "5.0米":{val:5.0},
           "5.8米":{val:5.8},
           "6.2米":{val:6.2},
           "6.8米":{val:6.8},
           "7.2米":{val:7.2},
           "8.6米":{val:8.6},
           "9.6米":{val:9.6},
           "10米":{val:10},
           "12.5米":{val:12.5},
           "13米":{val:13},
           "16米":{val:16},
           "17.5米":{val:17.5},
           "6米以下":{max:6},
           "6米-9米":{max:9,min:6},
           "9米-11米":{max:11,min:9},
           "11米-15米":{max:15,min:11},
           "15米-18米":{max:18,min:15},
           "18米-23米":{max:23,min:18},
           "23米以上":{min:23}
		};
		
		var carWeight={
           "8吨以下":{max:8},
           "8吨-10吨":{max:10,min:8},
           "10吨-15吨":{max:15,min:10},
           "15吨-20吨":{max:20,min:15},
           "20吨-25吨":{max:25,min:20},
           "25吨-30吨":{max:30,min:25},
           "30吨以上":{min:30}
		};
		///权限角色
		var roleName={
			personalGoods:"个人货主",
			personalCar:"个人车主",
			personalCompany:"物流企业"
		};
		//认证状态 2:已认证
		var certificateStatus={
			status:"2",
			uncertificateStatus:"未认证",
			certificateStatused:"已认证",
			certificateStatusfailed:"认证不通过"
		};
		//交易类型
		var transactionType={
			accountRecharge:"账户充值",
			collateralRecharge:"担保金充值"
		};
		//货物类型
		var goodsTypes={
			Heavygoods:"重货",
			lightgoods:"轻货"
		};
		var goodsType={
				"重货":{val:"重货"},
				"轻货":{val:"轻货"}
		};
		
		//运输类型
		var TransportWay={
			"整车":{val:"整车"},
			"零担":{val:"零担"}
		};
		var orderStatus = {
				0: "新订单",
				1: "待提货",
				2: "已取消",
				3: "我已确定交易完成",
				4: "对方已确定交易完成",
				5: "交易完成",
				6: "正在运输中",
				7: "待回单",
				8: "待支付",
				9: "新建单"
			};
		var sellerOrderStatus = {
			0: "新订单",
			1: "待提货",
			2: "已取消",
			3: "我已确定交易完成",
			4: "对方已确定交易完成",
			5: "交易完成",
			6: "正在运输中",
			7: "待回单",
			8: "待支付",
			9: "新建单"
		};
		
		var buyerOrderStatus = {
			0: "已提交",
			1: "待提货",
			2: "已取消",
			3: "对方已确定交易完成",
			4: "我已确定交易完成",
			5: "交易完成",
			6: "正在运输中",
			7: "待回单",
			8: "待支付"
		};
		//增值服务
		var addvalue=[
			{Name:'代收货款',ID:'ISCOLLECTIONPAY'},
			{Name:'送货上门',ID:'ISDELIVERYDOOR'},
			{Name:'上门接货',ID:'ISDOORRECEIVE'},
			{Name:'包装服务',ID:'ISPACKAGESERVICE'},
			{Name:'燃油附加费',ID:'ISFUELSURCHARGE'},
			{Name:'签收回单',ID:'ISRETURNRECEIPT'},
			{Name:'短信通知',ID:'ISSMSNOTIFICATION'},
			{Name:'货物保价',ID:'ISVALUEINSURED'},
			{Name:'工本费',ID:'ISPRODUCTIONFEE'},
			{Name:'等通知放货',ID:'ISNOTIFICATIONSHIP'},
			{Name:'开箱验货',ID:'ISUNPACKINGGOODS'}
		];
		return {
			carWeight:carWeight,
			carLength: carLength,
			roleName:roleName,
			certificateStatus:certificateStatus,
			transactionType:transactionType,
			sellerOrderStatus: sellerOrderStatus,
			buyerOrderStatus: buyerOrderStatus,
			TransportWay:TransportWay,
			goodsType:goodsType,
			goodsTypes:goodsTypes,
			orderStatus:orderStatus,
			addvalue:addvalue
		};
	})();
})(jQuery);