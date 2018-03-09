/* 处理浏览器是否为微信浏览器 */
var ua = navigator.userAgent.toLowerCase();
var isWeixin = ua.indexOf('micromessenger') != -1;
if (!isWeixin) {
	/*window.location.href = "weixin/errorpage";*/
}