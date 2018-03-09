/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.interfacelog;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.InterfaceTokenService;

/**
 * 接口令牌生成Controller
 * @author qiao
 * @version 2017-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/interfacelog/interfaceToken")
public class InterfaceTokenController extends BaseController {

	@Autowired
	private InterfaceTokenService interfaceTokenService;
	@Autowired
	private InterfaceLogBiz interfaceLogBiz;
	@ModelAttribute
	public InterfaceToken get(@RequestParam(required=false) String id) {
		InterfaceToken entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = interfaceTokenService.get(id);
		}
		if (entity == null){
			entity = new InterfaceToken();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:interfacelog:interfaceToken:view")
	@RequestMapping(value = {"list", ""})
	public String list(InterfaceToken interfaceToken, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InterfaceToken> page = interfaceTokenService.findPage(new Page<InterfaceToken>(request, response), interfaceToken); 
		model.addAttribute("page", page);
		return "modules/wlpt/interfacelog/interfaceTokenList";
	}

	@RequiresPermissions("wlpt:interfacelog:interfaceToken:view")
	@RequestMapping(value = "form")
	public String form(InterfaceToken interfaceToken, Model model) {
		model.addAttribute("interfaceToken", interfaceToken);
		return "modules/wlpt/interfacelog/interfaceTokenForm";
	}

	@RequiresPermissions("wlpt:interfacelog:interfaceToken:edit")
	@RequestMapping(value = "save")
	public String save(InterfaceToken interfaceToken, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, interfaceToken)){
			return form(interfaceToken, model);
		}
		interfaceTokenService.save(interfaceToken);
		addMessage(redirectAttributes, "保存生成令牌成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/interfacelog/interfaceToken/?repage";
	}
	
	@RequiresPermissions("wlpt:interfacelog:interfaceToken:edit")
	@RequestMapping(value = "delete")
	public String delete(InterfaceToken interfaceToken, RedirectAttributes redirectAttributes) {
		interfaceTokenService.delete(interfaceToken);
		addMessage(redirectAttributes, "删除生成令牌成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/interfacelog/interfaceToken/?repage";
	}
	@RequestMapping(value="token")
	@ResponseBody
	public String interfacetoken() {
		String token =interfaceLogBiz.interfacetoken();
		return token;
		
	}
}