package com.thinkgem.jeesite.modules.weixin.service;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.http.util.TextUtils;
import com.thinkgem.jeesite.modules.weixin.entity.AccessToken;
import com.thinkgem.jeesite.modules.weixin.utils.WeixinUtil;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.utils.Logger;
import com.thinkgem.jeesite.common.utils.Tools;

public class JSSignService {
	protected static Logger logger = Logger.getLogger(JSSignService.class);
	/**
	 * 得到JSApi ticket
	 */
	public static String GET_JSAPI_TICKET = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
	/**
	 * 缓存的JsApiTicket字符串
	 */
	private static String jsapiTicket;
	/**
	 * 最后一次获取JsApiTicket的时间
	 */
	private static long lastTime = System.currentTimeMillis() - 7001 * 1000;
	/**
	 * 时间格式化工具
	 */
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public static Map<String, String> sign(String url) {
		getJsApiTicket();
		Map<String, String> ret = new HashMap<String, String>();
		String nonce_str = create_nonce_str();
		String timestamp = create_timestamp();
		String string1;
		String signature = "";

		// 注意这里参数名必须全部小写，且必须有序
		string1 = "jsapi_ticket=" + jsapiTicket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url;

		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(string1.getBytes("UTF-8"));
			signature = byteToHex(crypt.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		ret.put("url", url);
		ret.put("jsapi_ticket", jsapiTicket);
		ret.put("nonceStr", nonce_str);
		ret.put("timestamp", timestamp);
		ret.put("signature", signature);

		return ret;
	}

	/**
	 * 
	 */
	private static void getJsApiTicket() {
		long currentTime = System.currentTimeMillis();
		StringBuilder info = new StringBuilder("当前时间：").append(format.format(new Date(currentTime)));
		long spaceTime = currentTime - lastTime;
		if (spaceTime > 7000 * 1000) {	// 当前时间 - 7001s > 大于上次获取到Ticket的时间
			String accessToken = WeixinUtil.getToken();
			if (!TextUtils.isEmpty(accessToken)) {
				String url = GET_JSAPI_TICKET.replace("ACCESS_TOKEN", accessToken);
				JSONObject jsonObject = WeixinUtil.httpsRequest(url, "POST", "");
				if (null != jsonObject) {
					if (0 == jsonObject.getInteger("errcode")) {
						lastTime = currentTime;	// 更新最后获取时间
						jsapiTicket = jsonObject.getString("ticket");
						info.append("获取JsApiTicket成功！");
 					} else {
 						info.append("获取JsApiTicket失败，错误代码：" + jsonObject.getInteger("errcode") + "错误消息：" + jsonObject.getString("errmsg"));
 					}
				}
			} else {
				info.append("获取JsApiTicket失败，由于获取access_token失败！");
 			}
		} else {
			info.append("使用缓存的JsApiTicket...");
		}
		logger.info(info);
		info = null;
	}

	private static String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}

	private static String create_nonce_str() {
		return UUID.randomUUID().toString();
	}

	private static String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}
}
