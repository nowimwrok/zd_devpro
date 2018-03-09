package com.thinkgem.jeesite.modules.weixin.wxpay.util;

/**
 * 系统通用的常量
 * 
 * @author 覃东富
 * @version 1.0
 * @date 2014年10月23日上午10:56:46
 */
public interface CommonConstants
{
	
	/** 跨域默认方法名 */
	public final static String CROSS_DOMAIN_PARAMERNAME = "callback";
	
	public interface Client
	{
		public final static String PC = "pc";
		public final static String IOS = "ios";
		public final static String ANDROID = "android";
		public final static String WEIXIN = "weixin";
		public final static String SYSTEM = "system";
	}

	public interface UriPrefix
	{
		public final static String PC = "/pc/";
		public final static String IOS = "/ios/";
		public final static String ANDROID = "/android/";
		public final static String WEIXIN = "/weixin/";
		public final static String API = "/api/";
	}

}
