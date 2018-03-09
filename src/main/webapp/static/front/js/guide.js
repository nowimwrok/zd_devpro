
var bwidth=$(document).width();
var bheight=$(document).height();
function nextStep(next){
	$(".tipbox").css({"visibility":"hidden","display":"none"});
	$(".tipbar").hide();
	$("#step" + next).css({"visibility":"visible","display":"block"});
	$("#tipbar" + (next -1)).show();
}
//点击回到上一步
function preStep(pre){
	$(".tipbox").css({"visibility":"hidden","display":"none"});
	$(".tipbar").hide();
	$("#step" + pre).css({"visibility":"visible","display":"block"});
	$("#tipbar" +(pre-1)).show();
}

//关闭提示框
function hideTip(){
	$("#searchTipBg").hide();
	$("#searchTip").hide();
	$(".tipbar").hide();
	$(".tipbox").css({"visibility":"hidden","display":"none"});
	$("#step1").css({"visibility":"visible","display":"block"});
	SetCookie("tipVisible","no");
}
function noShow(){
	if(document.getElementById("notip").checked){//提示框中 checkbox
		SetCookie("neverShow","no",{expires:37230}); //cookie不再显示
	}	
}
function GetCookie(name){
    var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
    if(arr != null) return decodeURIComponent(arr[2]); return null;
}
function SetCookie(name,value,options){
    var expires = '', path = '', domain = '', secure = ''; 
    if(options)
    {
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
            var exp;
            if (typeof options.expires == 'number') {
                exp = new Date();
                exp.setTime(exp.getTime() + options.expires*24*60*60*1000);
            }
            else{
                exp = options.expires;
            }
            expires = ';expires=' + exp.toUTCString();
        }
        path = options.path ? '; path=' + options.path : ''; 
        domain = options.domain ? ';domain=' + options.domain : ''; 
        secure = options.secure ? ';secure' : ''; 
    }
    document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
}
