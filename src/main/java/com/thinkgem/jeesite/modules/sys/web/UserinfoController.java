/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户管理Controller
 * @author 饶江龙
 * @version 2016-07-13
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/Userinfo")
public class UserinfoController extends BaseController {

	@Autowired
	private UserinfoService userinfoService;

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public Userinfo get(@RequestParam(required=false) String id) {
		Userinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userinfoService.get(id);
		}
		if (entity == null){
			entity = new Userinfo();
		}
		return entity;
	}


	/***
	 * 通过查询条件获取用户信息
	 * @param searchinfo
	 * @return
     */
	@ResponseBody
	@RequestMapping(value = "searchInfo")
	public Object searchInfo(String searchinfo,Model model) {
		if (Tools.IsNullOrWhiteSpace(searchinfo)){
			return null;
		}
		Object map=systemService.getUserBySearch(searchinfo,model);
		return map;
	}


	/***
	 * 修改账户提现密码--支付秘密啊
	 * @param oldPassword  旧密码
	 * @param newPassword  新密码
	 * @param model  对象
	 * @return
	 */
	@RequiresPermissions("user")
	@RequestMapping(value = "modifyCashPwd")
	public String modifyPwd(String oldPassword, String newPassword, Model model) {
		User user = UserUtils.getUser();
		Userinfo userinfo=user.getUserinfo();
		if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
			if(Global.isDemoMode()){
				model.addAttribute("message", "演示模式，不允许操作！");
				return "modules/wlpt/user/userModifyCashPwd";
			}
			if (Tools.IsNullOrWhiteSpace(userinfo.getCashpassword())){
				model.addAttribute("message", "请先绑定银行卡！");
				return "modules/wlpt/user/userModifyCashPwd";
			}
			if (SystemService.validatePassword(oldPassword, userinfo.getCashpassword())){
				userinfoService.updateCashPwdById(userinfo.getId(), newPassword);
				model.addAttribute("message", "修改提现密码成功");
			}else{
				model.addAttribute("message", "修改提现密码失败，旧密码错误");
			}
		}else{
			model.addAttribute("message", "请填写修改信息");
		}
		model.addAttribute("userinfo", userinfo);
		return "modules/wlpt/user/userModifyCashPwd";
	}
	
	@RequiresPermissions("sys:Userinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(Userinfo Userinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Userinfo> page = userinfoService.findPage(new Page<Userinfo>(request, response), Userinfo);
		model.addAttribute("page", page);
		return "modules/wlpt/userinfo/sysUserinfoList";
	}

	@RequiresPermissions("sys:Userinfo:view")
	@RequestMapping(value = "form")
	public String form(Userinfo Userinfo, Model model) {
		;
		model.addAttribute("Userinfo", Userinfo);
		return "modules/wlpt/userinfo/sysUserinfoForm";
	}

	@RequiresPermissions("sys:Userinfo:edit")
	@RequestMapping(value = "save")
	public String save(Userinfo Userinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, Userinfo)){
			return form(Userinfo, model);
		}
		Userinfo usf= userinfoService.get(Userinfo.getId());
		//Boolean ispwdque=systemService.validatePassword(Userinfo.getPassword(),usf.getPassword());

		Boolean iscashpwdque=systemService.validatePassword(Userinfo.getCashpassword(),usf.getCashpassword());
		//System.out.print(ispwdque+"----"+iscashpwdque);
		///如果登录密码不为空则修改密码
		/*if (StringUtils.isNotBlank(Userinfo.getPassword())){
			Userinfo.setPassword(systemService.entryptPassword(Userinfo.getPassword()));
		}*/
		///如果提现密码不为空则修改密码
		if (StringUtils.isNotBlank(Userinfo.getCashpassword())){
			Userinfo.setCashpassword(systemService.entryptPassword(Userinfo.getCashpassword()));
		}
		userinfoService.save(Userinfo);
		addMessage(redirectAttributes, "保存用户管理成功");
		return "redirect:"+Global.getAdminPath()+"/sys/Userinfo/?repage";
	}
	
	@RequiresPermissions("sys:Userinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Userinfo Userinfo, RedirectAttributes redirectAttributes) {
		userinfoService.delete(Userinfo);
		addMessage(redirectAttributes, "删除用户管理成功");
		return "redirect:"+Global.getAdminPath()+"/sys/Userinfo/?repage";
	}

}