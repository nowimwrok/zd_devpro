///获取小数点后几位数据X为原始数据、num为小数点后几位
function xround(x, num) {
    return Math.round(x * Math.pow(10, num)) / Math.pow(10, num);
}
//减
function accSub(arg1, arg2) {
    var r1, r2, m, n;
    try {
        r1 = arg1.toString().split(".")[1].length
    } catch (e) {
        r1 = 0
    }
    try {
        r2 = arg2.toString().split(".")[1].length
    } catch (e) {
        r2 = 0
    }
    m = Math.pow(10, Math.max(r1, r2));
//last modify by deeka
//动态控制精度长度
    n = (r1 >= r2) ? r1 : r2;
    return ((arg1 * m - arg2 * m) / m).toFixed(n);
}
//加法函数，用来得到精确的加法结果
//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
//调用：accAdd(arg1,arg2)
//返回值：arg1加上arg2的精确结果
function accAdd(arg1, arg2) {
    var r1, r2, m;
    try {
        r1 = arg1.toString().split(".")[1].length
    } catch (e) {
        r1 = 0
    }
    try {
        r2 = arg2.toString().split(".")[1].length
    } catch (e) {
        r2 = 0
    }
    m = Math.pow(10, Math.max(r1, r2));
    return (arg1 * m + arg2 * m) / m
}

//给Number类型增加一个add方法，调用起来更加方便。
Number.prototype.add = function (arg) {
    return accAdd(arg, this);
};
//乘法函数，用来得到精确的乘法结果
//说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。
//调用：accMul(arg1,arg2)
//返回值：arg1乘以arg2的精确结果
function accMul(arg1, arg2) {
    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
    try {
        m += s1.split(".")[1].length
    } catch (e) {
    }
    try {
        m += s2.split(".")[1].length
    } catch (e) {
    }
    returnNumber(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
}

//给Number类型增加一个mul方法，调用起来更加方便。
Number.prototype.mul = function (arg) {
    return accMul(arg, this);
};

//除法函数，用来得到精确的除法结果
//说明：JavaScript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。
//调用：accDiv(arg1,arg2)
//返回值：arg1除以arg2的精确结果
function accDiv(arg1,arg2){
    var t1=0,t2=0,r1,r2;
    try{t1=arg1.toString().split(".")[1].length}catch(e){}
    try{t2=arg2.toString().split(".")[1].length}catch(e){}
    with(Math){
        r1=Number(arg1.toString().replace(".",""));
        r2=Number(arg2.toString().replace(".",""));
        return (r1/r2)*pow(10,t2-t1);
    }
}

//给Number类型增加一个div方法，调用起来更加方便。
Number.prototype.div = function (arg){
    return accDiv(this, arg);
};

//判断时间，时间必须大于当前时间
function diffDate(indate) {
    var evalue = indate.val();
    var dB = new Date(evalue.replace(/-/g, "/"));
    if (new Date() <= Date.parse(dB)) {
        return true;
    } else {
        indate.tips({
            msg: '日期必须大于当前时间！',
            side: 2,
            bg: "#FF7300",
            time: 2
        });
        return false;
    }
}


//判断两个时间的先后
function completeDate(beforedate, laterdate) {
    beforedate = new Date(beforedate.replace(/-/g, "/"));
    laterdate = new Date(laterdate.replace(/-/g, "/"));
    if (Date.parse(beforedate) <= Date.parse(beforedate)) {
        return true;
    } else {
        indate.tips({
            side: 3,
            msg: '日期必须大于当前时间！',
            bg: '#AE81FF',
            time: 2
        });
        return false;
    }
}
///发送短信验证码按钮的间隔操作
var wait = 60;// 时间
function sendTimeBtn(o,p,type) {// o为按钮的对象，这里是60秒过后，提示文字的改变
    if (wait == 0) {
        o.removeAttr("disabled");
        o.css("background", "#428bca");
        o.html("获取验证码");// 改变按钮中value的值

        o.val("获取验证码");// 改变按钮中value的值
        wait = 60;
        if(type==1){
        	p.removeAttr("readonly");
        }
        
    } else {
        o.attr("disabled", true);// 倒计时过程中禁止点击按钮
        o.val(wait + "秒后重新获取");// 改变按钮中value的值
        o.html(wait + "秒后重新获取");// 改变按钮中value的值
        o.css("background", "#CCC");
        if(type==1){
        	p.attr("readonly","readonly");
        }
        wait--;
        setTimeout(function () {
            sendTimeBtn(o,p,type);// 循环调用
        }, 1000);
    }
}

//弹出服务窗口
var newWindow;//定义一个窗口，有利于窗口间的通讯
function openagreement(id) {
    if (!newWindow || newWindow.closed) {
        var width = 900;
        var height = 500;
        var left = parseInt((screen.availWidth / 2) - (width / 2));//屏幕居中
        var top = parseInt((screen.availHeight / 2) - (height / 2));
        var windowFeatures = "width="
            + width
            + ",height="
            + height
            + ",left="
            + left
            + ",top="
            + top
            + "screenX="
            + left
            + ",toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no,screenY="
            + top;
        newWindow = window
            .open(
                window.document.location.pathname.substring(0, 8) + "/agreement/agreementInfo?code="
                + id, "卓大协议", windowFeatures);
    } else {
        // window is already open, so bring it to the front
        newWindow.focus();
    }
}
//给所有的input添加 autocomplete属性
$(function(){
	$('input').attr('autocomplete','off');
})