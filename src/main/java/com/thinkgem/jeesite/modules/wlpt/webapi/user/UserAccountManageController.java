/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.webapi.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;

/**
 * 用户Controller
 * 
 * @author
 * @version 2013-8-29
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/account")
public class UserAccountManageController extends BaseController {

	@Autowired
	private SystemService systemService;

	@Autowired
	private UserBiz userBiz;
	

	/**
	 * 去子账户管理页面
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "toAccountList", "" })
	public String toAccountList(HttpServletRequest request, HttpServletResponse response, Model model) {
		User users = UserUtils.getUser();
		model.addAttribute("user", users);
		return "modules/user_front/account/my_account_list";
	}

	/**
	 * 我的子账户列表
	 * 
	 * @param user
	 * @param orderBy
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "myAccountList", "" })
	public Object myAccountList(User user, String orderBy, int pageNo, int pageSize, Model model) {
		Page<User> pg = new Page<>();
		pg.setLength(4);
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		pg.setOrderBy(orderBy);

		Page<User> page = userBiz.getAccountList(pg, user);
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/**
	 * 去子账户添加页面
	 * 
	 * @param user
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toAddAccount")
	public String toAddAccount(User user, Model model) {
		User users = UserUtils.getUser();
		if (users.getId() != null) {
			model.addAttribute("userId", users.getId());
		}
		model.addAttribute("user", user);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/user_front/account/account_add";
	}

	/**
	 * 保存子账户
	 * 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveMyuser")
	public Object saveMyuser(User user) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "添加失败";
		if (UserUtils.getUser().getId() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "登陆失效,请重新登陆";
		}
		if (state == DataDic.RETURN_STATUS_NORMAL) {
			// 保存子账户用户信息
			userBiz.saveMyUserAccount(user);
			message = "添加成功";
		}

		return this.getMapResult(state, message, null);
	}

	/**
	 * 删除子账户
	 * 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "deleteMyuser")
	public Object deleteMyuser(User user) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "删除子账户失败";
		if (UserUtils.getUser().getId() == null) {
			message = "登陆过期,请重新登陆";
			state = DataDic.RETURN_STATUS_AUTHBUG;
		}
		if (UserUtils.getUser().getId().equals(user.getId())) {
			message = "删除用户失败, 不允许删除当前用户";
			state = DataDic.RETURN_STATUS_AUTHBUG;
		} else if (User.isAdmin(user.getId())) {
			message = "删除用户失败, 不允许删除超级管理员用户";
			state = DataDic.RETURN_STATUS_AUTHBUG;
		} else {
			userBiz.deleteMyUserAccount(user);
			message = "删除子账户成功";
		}
		return this.getMapResult(state, message, null);
	}
	
}
