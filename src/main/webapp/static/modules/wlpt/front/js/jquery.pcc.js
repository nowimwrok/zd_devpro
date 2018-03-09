(function ($) {
	
	$.fn.PCC = function(options){
		return new pcc($(this), options);
	};

	$.fn.PCC.unique = 0;
	
	function pcc($this, options){
		var result = {};
		var settings = {
				id:"",
				width: 360,
				height: 200,
				color: "#0c88e8",
				closeIcon:"",
				loadingIcon:"/static/images/loading.gif",
				url: "",
				hasCounty: false,
				location: "left",
				isPhone:false,
				complete: function (data) {
				}
		};

		$.extend(settings, options);
		
		if(!settings.id){
			settings.id = ++ $.fn.PCC.unique ;
		}

		// 添加控件样式
		var style = getStyle(settings.id, settings.color);
		$("head").append(style);

		// 添加控件元素
		var html = getElement(settings.id);
		$("body").append(html);

		var pccid = settings.id;
		var $top = $(window.top);

		// 关闭图标
		if(settings.closeIcon){
			$(".pcc-close"+pccid).html("<img class='pcc-close-icon"+ pccid +"' src='"+settings.closeIcon+"'/>");
			$(".pcc-close"+pccid).css("border", "none");
		}
		
		// 给宿主添加标志
		$this.data("pcc", pccid);
		
		$this.click(function () {
			// 有其他打开的就关闭掉
			$(".pcc").each(function(){
				if($(this).attr("id") != 'pcc'+pccid){
					$(this).hide("slow");
				}
			});
			
			var left = $this.offset().left;
			var right = $("body").width() - (left + $this.outerWidth());
			var top = $this.offset().top;
			var thisHeight = $this.outerHeight();

			$(".pcc-container"+pccid).css("top", (top + thisHeight) +"px");//top
			$(".pcc-container"+pccid).height(settings.height);// height
			$(".pcc-container"+pccid).width(settings.width);//width
			// 默认左，如果宽度超出界面变成右边
			if(left + $(".pcc-container"+pccid).width() > $("body").width()){
				settings.location = "right";
			}
			if(settings.location == "left"){
				$(".pcc-container"+pccid).css("left", left+"px");
			}else if(settings.location == "right"){
				$(".pcc-container"+pccid).css("right", right+"px");
			}
			if(settings.isPhone){
				$(".pcc-container"+pccid).css("right", 10+"px");
			}
			updateTitleStyle(pccid, settings.color);
			
			//得到焦点，热门城市显示
			$(".pcc-container"+pccid).show(function () {
				initStyle(pccid);
				initAddressList("hotcity");
				result = {};
			});
			
			//得到焦点，热门省分显示
			/*$(".pcc-container"+pccid).show(function () {
				initStyle(pccid);
				initAddressList("province","0");
				result = {};
			});*/
			
			$("body").mousedown(hideAll);
			$top.mousedown(hideAll);
		});
		
		$(".pcc-title-ul"+pccid+" li").click(function () {
			var id = $(this).attr("id");
			var tabId = id.replace("li", "ul");
			$("#" + tabId).show();
			$("#" + tabId).siblings().hide();
			$("#" + id).parent().parent().show();

			$(this).addClass("pcc-title-sel"+pccid);
			$(this).siblings().removeClass("pcc-title-sel"+pccid);
			updateTitleStyle(pccid, settings.color);
		});
		
		/*$("#pcc-hot-li"+pccid).click(function(){
			initAddressList("hotcity");
		});
		*/
		$("#pcc-province-li"+pccid).click(function(){
			initAddressList("province","0");
		});
		
		$(".pcc-close-icon"+pccid).click(function(){
			close(pccid, result);
		});
		
		function hideAll(e){
			var left = $(".pcc-container"+pccid).offset().left;
			var top = $(".pcc-container"+pccid).offset().top;
			var width = $(".pcc-container"+pccid).width();
			var height = $(".pcc-container"+pccid).height();
			var right = left + width;
			var bottom = top + height;
			if(e.pageX > left && e.pageX < right && e.pageY > top && e.pageY < bottom){
				return;
			}
			close(pccid, result);
		}

		function initAddressList(type, parentCode) {
			var url = settings.url;
			if (!url) {
				return '<li><a>没有数据，请检查地址来源是否正确.</a></li>';
			} else {
				var data = {};
				var loading;
				if(settings.loadingIcon){
					loading = '<li style="width: 100%;margin-top: 10%;"><img src="'+settings.loadingIcon+'"></li>';
				}else{
					loading = '<li style="width:200px;">正在加载，请稍后......</li>';
				}
				if (type == 'hotcity') {
					data.isSearchHotCity = true;
					$("#pcc-hot-ul"+pccid).html(loading);
				}
				if (type == 'province') {
					data.parentCode = parentCode;
					$("#pcc-province-ul"+pccid).html(loading);
				}
				if (type == 'city') {
					data.parentCode = parentCode;
					$("#pcc-city-ul"+pccid).html(loading);
				}
				if (type == 'county') {
					data.parentCode = parentCode;
					$("#pcc-county-ul"+pccid).html(loading);
				}
				$.ajax({
					url: url,
					data: data,
					type: "GET",
					success: function (data) {
						if (data) {

							if (data) {
								var adds = data;
								var html = "";
								for (var i = 0; i < adds.length; i++) {

									html += '<li><a id="' + adds[i].code + '" data-parentcode="'+ adds[i].parentcode +'">' + adds[i].name + '</a></li>';
								}
								if (type == 'hotcity') {
									$("#pcc-hot-ul"+pccid).html(html);
									addHotCityClickEvent(pccid);
								}
								if (type == 'province') {
									$("#pcc-province-ul"+pccid).html(html);
									addProvinceClickEvent(pccid);
								}
								if (type == 'city') {
									$("#pcc-city-ul"+pccid).html(html);
									addCityClickEvent(pccid);
								}
								if (type == 'county') {
									$("#pcc-county-ul"+pccid).html(html);
									addCountyClickEvent(pccid);
								}
							}
						}
					}
				});
			}
		}

		function addHotCityClickEvent(id){
			// 选择完热门城市之后
			$("#pcc-hot-ul"+id+" li").click(function () {
				var url = settings.url;
				var params = {
					code : $(this).children().data("parentcode")
				};
				
				$.ajax({
					url: url,
					data: params,
					type: "GET",
					async: false,
					success: function (data) {
						if (!data) return;
						if (!data) return;
						var res = data;
						if(res && res.length > 0){
							result.province = {
								NAME: res[0].name,
								CODE: res[0].code
							};
						}
					}
				});

				result.city = {
						NAME: $(this).children().html(),
						CODE: $(this).children().attr("id")
				};
				
				if (settings.hasCounty) {
					$("#pcc-province-li"+id).show();
					$("#pcc-city-li"+id).show();
					$("#pcc-county-li"+id).show();
					$("#pcc-county-ul"+id).show();
					$("#pcc-county-ul"+id).siblings().hide();
					$("#pcc-county-ul"+id).parent().children().first().show();

					$("#pcc-county-li"+id).addClass("pcc-title-sel"+id);
					$("#pcc-county-li"+id).siblings().removeClass("pcc-title-sel"+id);
					updateTitleStyle(pccid, settings.color);

					initAddressList("county", $(this).children().attr("id"));
				} else {
					close(pccid, result);
				}
			});
		}

		function addProvinceClickEvent(id){

			// 选择完省份之后
			$("#pcc-province-ul"+id+" li").click(function () {
				$("#pcc-city-li"+id).show();
				$(this).parent().next().show();
				$(this).parent().next().siblings().hide();
				$(this).parent().parent().children().first().show();

				$("#pcc-city-li"+id).addClass("pcc-title-sel"+id);
				$("#pcc-city-li"+id).siblings().removeClass("pcc-title-sel"+id);
				updateTitleStyle(id, settings.color);

				initAddressList("city", $(this).children().attr("id"));

				// 保存返回结果
				result.province = {
						NAME: $(this).children().html(),
						CODE: $(this).children().attr("id")
				};
			});
		}

		function addCityClickEvent(id){
			// 选择完城市之后
			$("#pcc-city-ul"+id+" li").click(function () {
				// 保存返回结果
				result.city = {
						NAME: $(this).children().html(),
						CODE: $(this).children().attr("id")
				};

				if (settings.hasCounty) {
					$("#pcc-city-li"+id).next().show();
					$(this).parent().next().show().siblings().hide();
					$(this).parent().parent().children().first().show();

					$("#pcc-county-li"+id).addClass("pcc-title-sel"+id);
					$("#pcc-county-li"+id).siblings().removeClass("pcc-title-sel"+id);
					updateTitleStyle(id, settings.color);

					initAddressList("county", $(this).children().attr("id"));

				} else {
					close(pccid, result);
				}
			});
		}

		function addCountyClickEvent(id){
			// 选择完县后退出窗体
			$("#pcc-county-ul"+id+" li").click(function () {
				// 保存返回结果
				result.county = {
						NAME: $(this).children().html(),
						CODE: $(this).children().attr("id")
				};
				close(pccid, result);
			});
		}

		function updateTitleStyle(id,color) {
			$(".pcc-title-sel"+id).attr("style", "border-top: 2px solid "+ color+";border-left: 2px solid "+ color+";border-right: 2px solid "+ color+";color:red;");
			$(".pcc-title-sel"+id).siblings().each(function () {
				$(this).attr( "style", "display:" + $(this).css("display") +";");
			});
//			$(".pcc-title-ul").attr("style", "border-bottom:3px solid "+settings.color+";");
		}

		function close(id, result) {
			$(".pcc-container"+id).hide("slow",initStyle(id));
			if(!result.province){
				result.province = {};
				result.province.CODE = "";
				result.province.NAME = "";
			}
			if(!result.city){
				result.city = {};
				result.city.CODE = "";
				result.city.NAME = "";
			}
			if(!result.county){
				result.county = {};
				result.county.CODE = "";
				result.county.NAME = "";
			}
			settings.complete(result);
			
			$("body").unbind("mousedown", hideAll);
			$top.unbind("mousedown", hideAll);
		}

		function getElement(id) {
			var html = "";
			html += '<div id="pcc'+id+'" class="pcc-container'+id+' pcc" style="border-radius: 2%;    border: 2px solid rgb(61, 170, 252);">                                                     ';
			html += '    <div class="pcc-title-div'+id+'">                                                 ';
			html += '        <ul class="pcc-title-ul'+id+'">                                               ';
			html += '            <li id="pcc-hot-li'+id+'"><a>热门城市</a></li>                            ';
			html += '            <li id="pcc-province-li'+id+'" class="pcc-title-sel'+id+'"><a>省份</a></li>     ';
			html += '            <li id="pcc-city-li'+id+'" style="display: none"><a>城市</a></li>         ';
			html += '            <li id="pcc-county-li'+id+'" style="display: none"><a>区县</a></li>       ';
			html += '        </ul>                                                                   ';
			html += '<div class="pcc-close'+id+'"><span class="pcc-close-icon'+id+'">X</span></div>';
			html += '    </div>                                                                      ';
			html += '    <ul id="pcc-hot-ul'+id+'" class="pcc-content-ul'+id+'">                                 ';
			html += '        <li></li>                                                    ';
			html += '    </ul>                                                                       ';
			html += '    <ul id="pcc-province-ul'+id+'" class="pcc-content-ul'+id+'"  style="display: block;">   ';
			html += '        <li></li>                                                    ';
			html += '    </ul>                                                                       ';
			html += '    <ul id="pcc-city-ul'+id+'" class="pcc-content-ul'+id+'">                                ';
			html += '        <li></li>                                                    ';
			html += '    </ul>                                                                       ';
			html += '    <ul id="pcc-county-ul'+id+'" class="pcc-content-ul'+id+'">                              ';
			html += '        <li></li>                                                    ';
			html += '    </ul>                                                                       ';
			html += '</div>                                                                          ';
			return html;
		}

		function getStyle(id,color) {
			var style = '<style id="pcc-style'+id+'" type="text/css">';
			style += '.pcc-container'+id+' {top: 0px;position: absolute;border: 1px solid #ccc;z-index: 99999;display: none;background:#fff;}';
			style += '.pcc-title-div'+id+' {height: 30px;width: 100%;margin-top: 10px;}';
			style += '.pcc-title-ul'+id+' { border-bottom:3px solid '+color+';width: 100%;height: 27px;list-style: none;margin: 0px;padding: 0px;text-align: center;cursor: pointer;}';
			style += '.pcc-title-ul'+id+' li { color:#0c88e8; float: left;width: 70px;line-height: 24px;font-size: 15px;font-family: "微软雅黑";border-top: 2px solid #0c88e8;border-left: 2px solid #0c88e8;border-right: 2px solid #0c88e8;margin: 0px 3px 0px 3px;}';
			style += '.pcc-title-ul'+id+' li a {display: block;}';
			style += '.pcc-title-ul'+id+' li:hover {color:'+color+';background: #fff;border-bottom:1px solid #fff;}';
			style += '.pcc-close'+id+'{position: absolute;right: 9px;top: 8px;width: 16px;height: 19px;cursor: pointer;border:solid 1px '+color+';}';
			style += '.pcc-close-icon'+id+'{padding:3px; font-family:"微软雅黑"; color:'+ color +'}';
			style += '.pcc-title-sel'+id+' {color:'+color+'; background:#fff; border :1px solid #fff;}';
			style += '.pcc-content-div'+id+' {border: 1px solid #ccc;}';
			style += '.pcc-content-ul'+id+' {list-style: none;margin: 0px;padding: 0px;text-align: center;cursor: pointer;display: none;}';
			style += '.pcc-content-ul'+id+' li {width:60px;color:#3daafc;float: left;height: 24px;padding: 0px 5px 0px 5px;line-height: 24px;font-size: 13px;font-family: "微软雅黑";}';
			style += '.pcc-content-ul'+id+' li a {display: block;}';
			style += '.pcc-content-ul'+id+' li:hover {color: '+color+';color:red;}';
			style += '</style>';
			return style;
		}

		// 打开控件的时候的样式（热门城市显示）
		function initStyle(id) {
			
			var $initTitle = $("#pcc-hot-li"+id);
			$initTitle.show();
			$initTitle.siblings().hide();
			$initTitle.parent().children().first().show();
			$initTitle.next().show();

			$initTitle.addClass("pcc-title-sel"+id);
			$initTitle.siblings().removeClass("pcc-title-sel"+id);

			var $initTab = $("#pcc-hot-ul"+id);
			$initTab.siblings().hide();
			$initTab.parent().children().first().show();
			$initTab.show();
			/*$initTab.next().show();*/
			
			updateTitleStyle(id, settings.color);
		}
		
		/*// 打开控件的时候的样式（省分显示）
		function initStyle(id) {
			
			var $initTitle = $("#pcc-province-li"+id);
			$initTitle.show();
			$initTitle.siblings().hide();
			$initTitle.parent().children().first().show();

			$initTitle.addClass("pcc-title-sel"+id);
			$initTitle.siblings().removeClass("pcc-title-sel"+id);

			var $initTab = $("#pcc-province-ul"+id);
			$initTab.siblings().hide();
			$initTab.parent().children().first().show();
			$initTab.show();
			
			updateTitleStyle(id, settings.color);
		}*/
	}

})(jQuery);