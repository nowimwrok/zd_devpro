/**
 * 
 */
package com.thinkgem.jeesite.modules.weixin.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.util.TextUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.security.UsernamePasswordToken;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.weixin.entity.AccessTokenOAuth;
import com.thinkgem.jeesite.modules.weixin.entity.user.UserWeiXin;
import com.thinkgem.jeesite.modules.weixin.service.JSSignService;
import com.thinkgem.jeesite.modules.weixin.service.OAuthService;
import com.thinkgem.jeesite.modules.weixin.utils.WeixinUtil;

/**
 * 微信Controller
 * 
 * @author
 * @version
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/")
public class WeixinRequestController extends BaseController {

	/**
	 * 微信OAuth认证，获取OpenId
	 *
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "oauth", "" }, method = RequestMethod.GET)
	public void oAuth(HttpServletRequest request, HttpServletResponse response, Model model) {

		// 获取微信请求数据
		String from = request.getParameter("from"); // 功能请求地址
		String code = request.getParameter("code"); // 授权码
		
		 if (!"authdeny".equals(code)) {
			 
		 }
		// 获取access_token
		AccessTokenOAuth ato = OAuthService.getOAuthAccessToken(code);
		// 初始化获取
		if (null == ato) {
			// /获取微信用户的相关的信息
			ato = OAuthService.getOAuthAccessToken(code);
			if (null == ato) {
			}
		}

		// 将要跳转的用户页面
		String toPage = "";
		// 获取微信用户的OPEN_ID
		String openID = ato.getOpenid();
		String oldOpen_id="";
		request.setAttribute("openID", openID);
		request.setAttribute("fromPage", from);
		// new一个新的user参数对象
		User args = new User();
		String headImgUrl = "";// 定义微信用户的头像
		String userName = "";// 定义微信用户的用户名
		try {
			// 获取微信用户的基本信息
			UserWeiXin userInfo = OAuthService.getUserInfoOauth(ato.getAccessToken(), openID);
		
			if (userInfo != null) {
				headImgUrl = (!Tools.IsNullOrWhiteSpace(userInfo.getHeadimgurl()) ? userInfo.getHeadimgurl() : "");
				userName = (!Tools.IsNullOrWhiteSpace(userInfo.getNickname()) ? userInfo.getNickname() : "");
				request.setAttribute("headImgUrl", headImgUrl);
				request.setAttribute("userName", userName);
			}
			///是否存在缓存
			boolean isnohavu=true;
			////获取缓存用户
			User user = UserUtils.getUser();
			////如果存在用户缓存继续走-去相关的页面
			if(user !=null && !Tools.IsNullOrWhiteSpace(user.getId())){
				isnohavu=false;
				oldOpen_id=user.getUserinfo().getOpenid();
				///判断当前用户的open_id 是否等于数据库中的openid，如果不等，则清空缓存，重新绑定
				if(openID == null ||!openID.equals(oldOpen_id)){
					isnohavu=true;
					UserUtils.clearCache();
				}
			}
			args.setSearchinfo(openID);
			args = UserUtils.getByCondition(args);// 通过openid查询openid是否存在
			 if ("login".equals(from)) {// 用户的跳转链接为登录页面时
				// /当前用户的微信未绑定将去登录页面
				if (null == args && isnohavu) {
					// 获取用户的头像和昵称
					request.setAttribute("headImgUrl", headImgUrl);
					request.setAttribute("userName", userName);
					toPage="user/tologin?openID="+openID;
				} else {
					// 如果说存在绑定后
					request.setAttribute("headImgUrl", headImgUrl);
					request.setAttribute("userName", userName);
					toPage="user/tologin?openID="+openID;
				}
			} else if ("userHome".equals(from)) { // 当去用户个人中心的时候
				if (null == args  && isnohavu) { // 没有绑定过
					request.setAttribute("headImgUrl", headImgUrl);
					request.setAttribute("userName", userName);
					toPage="user/tologin?openID="+openID;
				}
				else {
					//bindLogin(user.getPhone(),openID);
					toPage="user/userHome?openID="+openID;
						
				}
			} else if ("chooseusertype".equals(from)) { // 当点击注册的时候去选择用户角色的时候
				if (null == args  && isnohavu) { // 没有绑定过
					toPage="chooseusertype";
				} else {
					toPage="user/userHome";
				}
			} else if ("informationHall".equals(from)) {// /////信息大厅
				if (null == args  && isnohavu) { // 没有绑定过
					request.setAttribute("headImgUrl", headImgUrl);
					request.setAttribute("userName", userName);
					toPage="user/tologin";
				} else if (openID.equals(args.getUserinfo().getOpenid())) {
					toPage="informationHall/infoHall_list";
				}
			} else {
				toPage="user/tologin?openID="+openID;
			}
			request.getRequestDispatcher(toPage).forward(request, response);

			// 跳转对应功能页面
			/*request.getRequestDispatcher(toPage.toString()).forward(request, response);*/
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				toPage="user/tologin?openID="+openID;
				request.getRequestDispatcher(toPage).forward(request, response);
			} catch (Exception e1) {
				e1.printStackTrace();
			}

		}
		/*return toPage;*/
	}
	
	/**
	 * 已绑定的用户微信自动登录
	 * @param loginName
	 * @param openid
	 */
	public int bindLogin(String loginName,String openid){
		int state = DataDic.RETURN_STATUS_SYSBUG;
		// 自定义登录
		// 创建用户名和密码的令牌
		if(StringUtils.isNoneBlank(openid)){
			try {
				String pwd = UserUtils.getPlainpwd(openid);
				if(StringUtils.isNoneBlank(pwd)){
					UserUtils.clearCache();
					UsernamePasswordToken token = new UsernamePasswordToken(loginName, pwd.toCharArray(), false, "",
							"", true);
					// 记录该令牌，如果不记录则类似购物车功能不能使用。
					token.setRememberMe(true);
					// subject理解成权限对象。类似user
					Subject subject = SecurityUtils.getSubject();
					subject.login(token); // 保存登录
					state = DataDic.RETURN_STATUS_NORMAL;
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			
		}
		return state;
		
	}

	/* 获取jsapi_ticket与签名信息用于使用js-sdk */

	@ResponseBody
	@RequestMapping(value = "getJSSign")
	public Object getJSSign(HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes, Model model) {
		String url = request.getParameter("Url");
		try {
			url = URLDecoder.decode(url, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<String, String> ret = JSSignService.sign(url);
		map.put("appId", ConstantWeChat.APPID);
		for (Entry<String, String> entry : ret.entrySet()) {
			map.put(entry.getKey(), entry.getValue());
		}
		return map;
	}

	/* 从微信服务器下载图片 */
	@ResponseBody
	@RequestMapping(value = "downloadImg")
	public Object downloadImg(HttpServletRequest request, HttpServletResponse response) {
		String userId = "";
		if (StringUtils.isNotBlank(UserUtils.getUser().getId())) {
			userId = UserUtils.getUser().getId() + "/";

		}
		String mediaID = request.getParameter("ServerID");
		String folderName = request.getParameter("FolderName");// 获取文件名
		String accessToken = WeixinUtil.getToken();
		Map<String, Object> map = new HashMap<String, Object>();
		if (!TextUtils.isEmpty(accessToken)) {
			String filepath = Global.USERFILES_BASE_URL;
			int index = filepath.indexOf("/", 0);
			if (index >= 0) {
				filepath = filepath.substring(1);
			}
			String month = String.valueOf(new Date().getMonth() + 1 + "/");
			if (month.length() == 2) {
				month = "0" + month;
			}
			// 上传的绝对路径
			String savePath = Global.getUserfilesBaseDir() + filepath + userId + "images/" + folderName + "/"
					+ DateUtil.getYear() + "/" + month;
			// 返回页面的相对路径
			String imagePath = Global.USERFILES_BASE_URL + userId + "images/" + folderName + "/" + DateUtil.getYear()
					+ "/" + month;

			String imageName = UUID.randomUUID().toString().trim().replaceAll("-", "") + ".jpg";

			boolean downState = WeixinUtil.downloadImage(accessToken, mediaID, savePath, imageName);
			map.put("result", downState);
			if (downState) {
				map.put("ImageName", imagePath + imageName);
			}
		} else {
			logger.info("Get access_token failed！");
		}
		return map;
	}
}
