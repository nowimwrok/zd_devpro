/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.User;
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
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.service.user.AddressService;

/**
 * 用户地址管理Controller
 * @author 饶江龙
 * @version 2016-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/address")
public class AddressController extends BaseController {

	@Autowired
	private AddressService addressService;
	
	@ModelAttribute
	public Address get(@RequestParam(required=false) String id) {
		Address entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = addressService.get(id);
		}
		if (entity == null){
			entity = new Address();
		}
		return entity;
	}


	
	@RequiresPermissions("wlpt:user:address:view")
	@RequestMapping(value = {"list", ""})
	public String list(Address address, HttpServletRequest request, HttpServletResponse response, Model model) {
		address.setUser(UserUtils.getUser());
		Page<Address> page = addressService.findPage(new Page<Address>(request, response), address);
		model.addAttribute("page", page);
		return "modules/wlpt/user/addressList";
	}

	@RequiresPermissions("wlpt:user:address:view")
	@RequestMapping(value = "form")
	public String form(Address address, Model model) {
		address.setUser(UserUtils.getUser());
		model.addAttribute("address", address);
		return "modules/wlpt/user/addressForm";
	}

	@RequiresPermissions("wlpt:user:address:edit")
	@RequestMapping(value = "save")
	public String save(Address address, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, address)){
			return form(address, model);
		}
		address.setUser(UserUtils.getUser());
		addressService.save(address);
		addMessage(redirectAttributes, "保存保存地址成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/address/?repage";
	}
	
	@RequiresPermissions("wlpt:user:address:edit")
	@RequestMapping(value = "delete")
	public String delete(Address address, RedirectAttributes redirectAttributes) {
		addressService.delete(address);
		addMessage(redirectAttributes, "删除保存地址成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/address/?repage";
	}

}