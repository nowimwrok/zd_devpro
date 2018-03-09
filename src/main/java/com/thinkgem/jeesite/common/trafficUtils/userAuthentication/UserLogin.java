package com.thinkgem.jeesite.common.trafficUtils.userAuthentication;

import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunReturnBean;

/**
 * 登陆接口调用即可返回token令牌
 * 
 * @author Shinelon
 *
 */
public class UserLogin {

	public static String token;

	public static String userLogin() {

		ZhiyunReturnBean bean = ZhiyunOpenapi.login();

		return token = bean.getResult() + "";

	}

}
