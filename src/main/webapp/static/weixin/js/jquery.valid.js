(function ($) {
    $.fn.valid = function (options) {
        var settings = {
            methods: "",
            tipSide: 3,
            tipColor: "#00A2E9"
        };

        $.extend(settings, options);
        
        //$(this).after('<a name="'+ $(this).attr("id") +'-name"></a>');

        if (!settings.methods) return true;

        var methods = settings.methods.split("|");

        var rules = [];
        for (var i = 0; i < $.fn.valid.rules.length; i++) {
            for (var j = 0; j < methods.length; j++) {
                if ($.fn.valid.rules[i].name == methods[j]) {
                    rules.push($.fn.valid.rules[i]);
                }
            }
        }
        if (rules.length <= 0) return true;

        var b = true;
        for (var i = 0; i < rules.length; i++) {
        	if(rules[i].name == "required"){
        		b = $(this).val() ? true : false;
        	}else{
        		b = rules[i].regex.test($(this).val());
        	}
            if (!b) {
                $(this).tips({
                    msg: rules[i].msg,
                    side: settings.tipSide,
                    bg: settings.tipColor
                });
                $(this).focus();
                return b;
            }
        }
        return b;
    };

    $.fn.valid.rules = [
        { name: "required", title: "不能为空", regex: "", msg: "该信息不可为空" },
        { name: "string", title: "不允许包含特殊符号", regex: /^[\u0391-\uFFE5\w]+$/, msg: "不允许包含特殊符号" },
        { name: "isName", title: "请输入规范名称格式", regex: /^[0-9a-zA-Z\u4e00-\u9fa5]+$/, msg: "请输入规范的名称" },
        { name: "isPhonecode", title: "电话号码例：88888888或8888888", regex:/^(\d{7,8})$/, msg: "必须是电话号码例：88888888或8888888" },
        { name: "isAreacode", title: "区号例：020或0754", regex: /^(0\d{2,3})$/, msg: "必须是区号例：020或0754" },
        { name: "isTel", title: "电话号码", regex: /^((0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/, msg: "必须是电话号码例如:020-666666" },
        { name: "isPhone", title: "手机号码", regex: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/, msg: "手机号码格式有误" },
        { name: "isdecimal", title: "输入值-小数", regex: /^[0-9]+(\.[0-9]+)?$/, msg: "只能为数字或小数且小数点后不能超过两位" },
        { name: "isNum", title: "数字", regex: /^\d+$/, msg: "必须是数字" },
        { name: "isNumberOrLetter", title: "数字", regex: /^[0-9a-zA-Z]+$/, msg: "必须是数字或数字+字母" },
        { name: "ischinese", title: "中文", regex: /^[\u4e00-\u9fa5]+$/, msg: "必须是中文" },
        { name: "isZipCode", title: "邮政编码验证", regex: /^[0-9]{6}$/, msg: "请正确填写您的邮政编码" },
        { name: "isPassWord", title: "密码格式验证", regex: /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,}$/, msg: "请使用6位以上的字母加数字或特殊符号的安全密码" },
        { name: "isCarNumber", title: "车牌号码", regex: /^[A-Z]{1}[A-Z_0-9]{5}$/, msg: "车牌号码格式错误" },
        { name: "isCarNumbers", title: "带简称车牌号码", regex: /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/, msg: "车牌号码格式错误" },
        { name: "isBankAccountNumber", title: "银行卡号", regex:  /^\d{15,20}$/, msg: "银行卡号格式错误" },
        { name: "isBankAccountNumberRe", title: "所有银行卡号", regex: /^\d{15,20}$/, msg: "银行卡号格式错误" },
        { name: "isQQ", title: "QQ", regex: /^\s*\d{4,12}\s*$/g, msg: "请正确填写您的QQ号码" },
        { name: "isEmail", title: "邮箱验证", regex: /^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/, msg: "邮箱格式有误" },
        { name: "isIDCard", title: "身份证验证", regex: /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/, msg: "身份证格式有误" },
        { name: "isURL", title: "URL", regex: /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, msg: "网址不正确" }
    ];

})(jQuery);