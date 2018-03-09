package com.thinkgem.jeesite.modules.weixin.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.thinkgem.jeesite.common.utils.ToolHttp;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.weixin.entity.AccessTokenOAuth;
import com.thinkgem.jeesite.modules.weixin.entity.user.UserWeiXin;
import com.thinkgem.jeesite.modules.weixin.utils.StringUtil;
import com.thinkgem.jeesite.modules.weixin.utils.WeixinUtil;

/**
 * OAuth服务
 * 
 * @author txw
 * @version 1.0
 * 
 */
public class OAuthService {

	public static Logger log = Logger.getLogger(OAuthService.class);

	/**
	 * wechat oauth url
	 */
	public static String OAUTH = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=REDIRECT_URI&response_type=code&scope=SCOPE&state=STATE#wechat_redirect";


	/**
	 * 时间格式化工具
	 */
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	/**
	 * 获得Oauth认证的URL
	 * 
	 * @param redirectUrl 跳转的url
	 * @param charset 字符集格式
	 * @param scope OAUTH scope
	 * @return oauth url
	 */
	public static String getOauthUrl(String redirectUrl, String charset, String scope) {
		String url = "";
		try {
			url = OAUTH.replace("APPID", ConstantWeChat.APPID).replace("REDIRECT_URI", URLEncoder.encode(redirectUrl, charset)).replace("SCOPE", scope);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return url;
	}

	/**
	 * 获取Access_Token（oAuth认证,此access_token与基础支持的access_token不同）
	 * 
	 * @param code 用户授权后得到的code
	 * @return AccessTokenOAuth对象
	 */
	public static AccessTokenOAuth getOAuthAccessToken(String code) {
		AccessTokenOAuth accessTokenOAuth = null;
		long currentTime = System.currentTimeMillis();
		StringBuilder info = new StringBuilder("当前时间：").append(format.format(new Date(currentTime)));
		
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token?";
	    url += "appid=" + ConstantWeChat.APPID;
	    url += "&secret=" + ConstantWeChat.APPSECRET;
	    url += "&code=" + code;
	    url += "&grant_type=authorization_code";
	    url += "&r="+ Math.random();

		System.out.print(url);
	    //update by franky 2016-08-15
	    try{
	    	String jsonStr = ToolHttp.get(true, url);
		    accessTokenOAuth =  JSON.parseObject(jsonStr, AccessTokenOAuth.class);
		} catch (Exception e) {
			log.error("OAuthService.getOAuthAccessToken获取网页授权凭证异常，appId：" + ConstantWeChat.APPID + " appSecret：" + ConstantWeChat.APPSECRET + " code：" + code);
			return null;
		}
		JSONObject jsonObject = WeixinUtil.httpsRequest(url, "POST", null);
		if (null != jsonObject) {
			if (StringUtil.isNotEmpty(jsonObject.get("errcode")) && jsonObject.get("errcode") != "0") {
				info.append("获取access_token失败...\nerrcode:" + jsonObject.getInteger("errcode") + "，errmsg:" + jsonObject.getString("errmsg"));
			} else {
				accessTokenOAuth = new AccessTokenOAuth();
				accessTokenOAuth.setAccessToken(jsonObject.getString("access_token"));
				accessTokenOAuth.setExpiresIn(jsonObject.getInteger("expires_in"));
				accessTokenOAuth.setRefreshToken(jsonObject.getString("refresh_token"));
				accessTokenOAuth.setOpenid(jsonObject.getString("openid"));
				accessTokenOAuth.setScope(jsonObject.getString("scope"));
				info.append("获取页面access_token成功...");
			}
		}
		log.info(info);
		info = null;
		return accessTokenOAuth;
	}

	/**
	 * 通过oauth获取用户详细信息
	 * 
	 * @param token
	 * @param openid
	 * @return UserWeiXin对象
	 */
	public static UserWeiXin getUserInfoOauth(String token, String openid) {
		UserWeiXin user = null;
		if (token != null) {

			 String url = "https://api.weixin.qq.com/sns/userinfo?";
			    url += "access_token=" + token;
			    url += "&openid=" + openid;

			 //update by franky 2016-08-15
			try{
				String jsonStr = ToolHttp.get(true, url);
				user =  JSON.parseObject(jsonStr, UserWeiXin.class);
			} catch (Exception e) {
				log.error("OAuthService.getUserInfoOauth通过网页授权获取用户信息异常，accessToken：" + token + " openId：" + openid);
				return null;
			}
			JSONObject jsonObject = WeixinUtil.httpsRequest(url, "GET", null);
			if (null != jsonObject) {
				if (StringUtil.isNotEmpty(jsonObject.get("errcode")) && jsonObject.get("errcode") != "0") {
					log.error("获取用户信息失败 errcode:" + jsonObject.getInteger("errcode") + "，errmsg:" + jsonObject.getString("errmsg"));
				} else {
					user = new UserWeiXin();
					user.setOpenid(jsonObject.getString("openid"));
					user.setNickname(jsonObject.getString("nickname"));
					user.setSex(jsonObject.getInteger("sex"));
					user.setProvince(jsonObject.getString("province"));
					user.setCity(jsonObject.getString("city"));
					user.setCountry(jsonObject.getString("country"));
					user.setHeadimgurl(jsonObject.getString("headimgurl"));
					user.setPrivilege(jsonObject.getString("privilege"));
				}
			}
		}
		return user;
	}
}
