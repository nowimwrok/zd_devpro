window.onload = function() {
	$.ajax({
		type : "POST",
		url : '/wx/weixin/getJSSign',
		data : {
			Url : encodeURIComponent(location.href.split('#')[0])
		},
		dataType : 'json',
		cache : false,
		success : function(data) {
			var appID = data.appId;
			var nonceStr = data.nonceStr;
			var timestamp = data.timestamp;
			var signature = data.signature;
			wx.config({
				debug : false,
				appId : appID,
				timestamp : timestamp,
				nonceStr : nonceStr,
				signature : signature,
				jsApiList : [ 'checkJsApi', 'chooseImage', 'uploadImage',
						'downloadImage' ]
			});
		}
	});
};
$(function() {
	/* 选择图片 */
	var images = {localId : [],serverId : []};
	window.uploadImg = function(divId, valId,imgWidth,imgHeight,folderName) {
		if(imgWidth==""||imgWidth==null){
			imgWidth=40;
		}
		if(imgHeight==""||imgHeight==null){
			imgHeight=40;
		}
		wx.chooseImage({
			count : 1,
			success : function(res) {
				images.localId = res.localIds;
				wx.uploadImage({
					localId : images.localId[0],
					success : function(res) {
						images.serverId.push(res.serverId);
						$("#" + divId).html("");
						
							$.ajax({
								type : "POST",
								url : '/wx/weixin/downloadImg',
								data : {
									FolderName: folderName,
									ServerID : images.serverId[0]
								},
								dataType : 'json',
								cache : false,
								success : function(data) {
									if (data) {
										var imgName=data.ImageName;
										$("#" + divId).append('<img src="'+ images.localId[0] + '" style="width:'+imgWidth+'px;height:'+imgHeight+'px;"/>');
										$("#" + valId).val(imgName);
										images = {localId : [],serverId : []};
									} else {
										$("#" + divId).tips({
											side : 3,
											msg : "上传证件失败！",
											bg : '#FF5080',
											time : 3
										});
									}
								}
							});
							},error : function() {
								images = {localId : [],serverId : []};
								$("#" + divId).html("");
							}
						});
					}
				});
	};
});