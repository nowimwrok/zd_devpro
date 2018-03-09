package com.thinkgem.jeesite.common.sms.util;

/**
 * 阿里大于短信通道配置参数
 *
 * @author  franky
 * @version 2016年11月1日下午2:10:40
 */
public interface SmsConfig {

    static String smsUrl = "dysmsapi.aliyuncs.com";

    static String appKey = "LTAIOijW5yWcLeaw";

    static String appSecret = "Bdqx27ub1V52yavt3JDpFhX7SiUBB2";

    static String smsFreeSignName = "卓大物流平台";

    /** 短信验证码模板ID*/
    static String smsValidateCode = "SMS_121851477"; //短信验证码模板ID，对应阿里大于上申请的模板ID。不同的模板各自申请

    /** 退款提醒*/
    static String smsRefund = "SMS_122294750";// 退款提醒

    /** 认证通过*/
    static String smsAuthSuccess = "SMS_122294786";//认证通过

    /** 回执单打印扣费通知*/
    static String smsPrintPay = "SMS_122294775";//回执单打印扣费通知

    /** 充值成功*/
    static String smsRechargeSuccess = "SMS_122284869";//充值成功

    /** 未中标*/
    static String smsUnBided = "SMS_122289858"; //未中标

    /** 生成运单*/
    static String smsNewOrder = "SMS_122294764";//生成运单

    /** 运输完成*/
    static String smsOrderEnd = "SMS_122289828";//运输完成

    /** 认证驳回*/
    static String smsAuthFiled = "SMS_122289854";//认证驳回

    /** 货物送达*/
    static String smsGoodsEnd = "SMS_122294768";//货物送达

    static String smsCash = "SMS_122299907";//提现


    /** 中标通知*/
    static String smsBided = "SMS_125015620"; // 	中标通知

    /** 收到运费*/
    static String smsGetFreight = "SMS_122284898";// 收到运费

    /** 发起争议*/
    static String smsDispute = "SMS_122284892";// 	发起争议

    /** 运单取消*/
    static String smsOrderCancel = "SMS_122299921"; //运单取消

    /** 新消息提示模板ID*/
    static String smsNewMess = "SMS_122299936"; //新消息提示

    /** 用户申请提醒模板ID*/
    static String smsUserapply = "SMS_123670152"; //用户申请提醒

    /** 用户申请提现模板ID*/
    static String smsUserWithdraw = "SMS_123795044"; //用户申请提现

    /** 一卡通挂失申请模板ID*/
    static String smsLossCard = "SMS_123665093"; //一卡通挂失申请

    /** 一卡通换卡扣费模板ID*/
    static String smsLossCardDeduction = "SMS_122294962"; //一卡通换卡扣费

}
