/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserDisputeService;

/**
 * 争议处理Controller
 * 
 * @author fjc
 * @version 2016-08-05
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userDispute")
public class UserDisputeController extends BaseController {

	@Autowired
	private UserDisputeService userDisputeService;

	@Autowired
	private TradeBiz tradeBiz;

	@ModelAttribute
	public UserDispute get(@RequestParam(required = false) String id) {
		UserDispute entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = userDisputeService.get(id);
		}
		if (entity == null) {
			entity = new UserDispute();
		}
		return entity;
	}

	@RequiresPermissions("wlpt:user:userDispute:view")
	@RequestMapping(value = { "list", "" })
	public String list(UserDispute userDispute, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserDispute> page = userDisputeService.findPage(new Page<UserDispute>(request, response), userDispute);
		model.addAttribute("page", page);
		return "modules/wlpt/user/userDisputeList";
	}

	@RequiresPermissions("wlpt:user:userDispute:view")
	@RequestMapping(value = "form")
	public String form(UserDispute userDispute, Model model) {
		model.addAttribute("userDispute", userDispute);
		return "modules/wlpt/user/userDisputeForm";
	}

	@RequiresPermissions("wlpt:user:userDispute:edit")
	@RequestMapping(value = "save")
	public String save(UserDispute userDispute, Model model, RedirectAttributes redirectAttributes) {
		
		Map<String, Object> map=tradeBiz.editUserdispute(userDispute,model);
		
		if(String.valueOf(DataDic.RETURN_STATUS_NORMAL).equals(map.get("state").toString()) ){
			addMessage(redirectAttributes, map.get("message").toString());
		}else{
			addMessage(redirectAttributes, map.get("message").toString());
		}
		return "redirect:" + Global.getAdminPath() + "/wlpt/user/userDispute/?repage";
	}

	@RequiresPermissions("wlpt:user:userDispute:edit")
	@RequestMapping(value = "delete")
	public String delete(UserDispute userDispute, RedirectAttributes redirectAttributes) {
		userDisputeService.delete(userDispute);
		addMessage(redirectAttributes, "删除争议信息成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/user/userDispute/?repage";
	}

	/**
	 * 去添加争议
	 * @param userDispute
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:user:userDispute:view")
	@RequestMapping(value = "addform")
	public String addform(UserDispute userDispute, Model model) {
		model.addAttribute("userDispute", userDispute);
		return "modules/wlpt/user/userDisputeAddForm";
	}

	/**
	 * 添加争议
	 * @param userDispute
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:user:userDispute:edit")
	@RequestMapping(value = "addDispute")
	public String addDispute(UserDispute userDispute, Model model, RedirectAttributes redirectAttributes) {
		Map<String, Object> map = (Map<String, Object>)tradeBiz.saveUserDispute(userDispute.getOrderinfo().getId(),
				userDispute.getGoodsname(), userDispute.getTakeloadweight(), userDispute.getUnloadweight(),
				userDispute.getDisputeinfo(),userDispute.getDisputemoney(),userDispute.getDisputetype());
		if ((int)map.get("state")==DataDic.RETURN_STATUS_NORMAL) {
			addMessage(redirectAttributes, "保存争议信息成功");
		} else {
			addMessage(redirectAttributes, "保存争议信息失败");
		}
		return "redirect:" + Global.getAdminPath() + "/wlpt/user/userDispute/?repage";
	}
}