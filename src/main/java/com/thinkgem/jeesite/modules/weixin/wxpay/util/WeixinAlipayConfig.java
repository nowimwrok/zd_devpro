package com.thinkgem.jeesite.modules.weixin.wxpay.util;

/***
 * 微信支付参数，两种支付
 * 公众号支付:JSAPI,NATIVE
 * APP支付:app（Android，ios）
 * @author lwh
 *
 */
public class WeixinAlipayConfig {

	//--------------微信支付的JSAPI,NATIVE支付是依赖于微信公众号,但是需要有商户号,商户平台查找----------------
	//恒大-用于公众号支付的商户号
	public static String GZ_mch_id = "1325039401";
	/***恒大-商户密钥*/
	public static String GZ_key = "4e42ec1f537f4644a3bfc820eddeb5f5";
	public static String old_key = "";
	//恒大-appid-确定
	public static String GZ_APP_ID = "wx0d8fc2417dec26a9";  

	//--------------微信支付的app支付是依赖于微信开放平台,需要有商户号,商户平台查找----------------
	//恒大-用于app支付的商户号
	public static String app_APP_ID = "wx0d8fc2417dec26a9";  
	public static String app_mch_id = "1325039401";
	/***恒大-商户密钥*/
	public static String app_key = "4e42ec1f537f4644a3bfc820eddeb5f5";
	/**
	 * // 微信统一支付接口
	 */
	public static String weiXinRequestUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
	/**
	 * 关闭订单
	 */
	public static String weiXinCloseorderUrl = "https://api.mch.weixin.qq.com/pay/closeorder";
	/**
	 * 查询订单
	 */
	public static String weiXinOrderQuery = "https://api.mch.weixin.qq.com/pay/orderquery";

	/* 
	 * App微信支付接口配置
	 */
	// appid 请同时修改 androidmanifest.xml里面，.PayActivityd里的属性<data android:scheme="wxb4ba3c02aa476ea1"/>为新设置的appid
	public static final String APP_ID = "wx0d8fc2417dec26a9";	// APP
	/**
	 * 微信App支付商户号
	 */
	public static final String MCH_ID = "1325039401";
	/**
	 *  微信App支付的API密钥，在商户平台设置
	 */
	public static final String API_KEY = "4e42ec1f537f4644a3bfc820eddeb5f5";
	
}
