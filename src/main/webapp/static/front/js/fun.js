(function($){
	/*$.fn.extend({
		'higlight':function(options){
			var opts=$.extend({},defaluts,options);
			this.each(function(){
				var $this=$(this);
				$this.css({
					backgroundColor:opts.background,
					color:opts.foreground
				});
			});
		},
	});
	var defaluts={background:'yellow',foreground:'red'};*/
	var defaults={id:'',text:''};//参数
	//显示信息的方法
	var showMsg=function(obj,msg,status){
		$(obj).next('#msg').remove();
		var html='<span id="msg" style="font-size:14px;color:red;">'+msg+'</span>';
		$(obj).next(html);
	};
	/*$.fn.extend({
		'check':function(options){
			var opts=$.extend({},defaults,options);
			this.each(function(){
				var $this=$(this);
				$(opts.id).bind('input propertychange',function(){
					var self_v=$this.val();
					if(self_v!=options.val){
						showMsg(options.text);
					}
				});
			});
		}
	});*/
	/*$.fn.checkForm=function(options){
		var options=$.extend({},defaults,options);
		$(options.id).bind('input propertychange',function(){
			var self_v=$(this).val();
			if(self_v!=options.val){
				showMsg(options.text);
			}
		});
	}*/
	var self_fun=function(options){
		var options=$.extend({},defaults,options);
		$(options.id).bind('input propertychange',function(){
			var self_v=$(this).val();
			if(self_v!=options.val){
				showMsg(options.text);
			}
		});
	}
})(window.jQuery)
