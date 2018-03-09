/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserBankinfoService;

/**
 * 用户绑定银行卡Controller
 * @author 饶江龙
 * @version 2016-07-21
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userBankinfo")
public class UserBankinfoController extends BaseController {

	@Autowired
	private UserBankinfoService userBankinfoService;
	
	@ModelAttribute
	public UserBankinfo get(@RequestParam(required=false) String id) {
		UserBankinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userBankinfoService.get(id);
		}
		if (entity == null){
			entity = new UserBankinfo();
		}
		return entity;
	}

	@RequestMapping(value = {"index", ""})
	public String index(UserBankinfo userBankinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		userBankinfo.setUser(UserUtils.getUser());
		userBankinfo=userBankinfoService.getBankByConditon(userBankinfo);
		model.addAttribute("userBankinfo", userBankinfo);
		return "modules/wlpt/user/userBankinfoIndex";
	}
	
	@RequiresPermissions("wlpt:user:userBankinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserBankinfo userBankinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserBankinfo> page = userBankinfoService.findPage(new Page<UserBankinfo>(request, response), userBankinfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userBankinfoList";
	}

	@RequiresPermissions("wlpt:user:userBankinfo:view")
	@RequestMapping(value = "form")
	public String form(UserBankinfo userBankinfo, Model model) {
		model.addAttribute("userBankinfo", userBankinfo);
		if (Tools.IsNullOrWhiteSpace(userBankinfo.getId())){
			model.addAttribute("isSave",true);
		}else{
			model.addAttribute("isSave",false);
		}
		model.addAttribute("user", UserUtils.getUser());
		return "modules/wlpt/user/userBankinfoForm";
	}

	@RequiresPermissions("wlpt:user:userBankinfo:edit")
	@RequestMapping(value = "save")
	public String save(UserBankinfo userBankinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userBankinfo)){
			return form(userBankinfo, model);
		}
		userBankinfo.setUser(UserUtils.getUser());
		///验证用户是否已经绑定银行卡信息对象
		UserBankinfo vidBank=new UserBankinfo();
		//赋值当前用户
		vidBank.setUser(UserUtils.getUser());
		///获取银行卡信息--通过用户ID
		vidBank=userBankinfoService.getBankByConditon(userBankinfo);
		////如果验证对象不为空,说明银行卡信息存在,则赋值保存对象主键作为修改
		if (vidBank!=null&&userBankinfo.getId()==null){
			userBankinfo.setId(vidBank.getId());
		}
		userBankinfoService.save(userBankinfo);
		addMessage(redirectAttributes, "保存绑定银行卡成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userBankinfo/index?repage";
	}
	
	@RequiresPermissions("wlpt:user:userBankinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(UserBankinfo userBankinfo, RedirectAttributes redirectAttributes) {
		userBankinfoService.delete(userBankinfo);
		addMessage(redirectAttributes, "删除绑定银行卡成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userBankinfo/?repage";
	}

}