/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.railregist;

import java.util.HashMap;
import java.util.Map;

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

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.TotalValidationBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.railregistBiz.RailRegistBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.railregist.RailRegist;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.traceListVO;
import com.thinkgem.jeesite.modules.wlpt.service.railregist.RailRegistService;

/**
 * 自定义区域注册Controller
 * @author renshuai
 * @version 2017-10-10
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/railRegist")
public class RailRegistController extends BaseController {

	@Autowired
	private RailRegistService railRegistService;
	@Autowired
	private RailRegistBiz railRegistBiz;
	@Autowired
	private TradeBiz tradeBiz;
	@Autowired
	private TotalValidationBiz totalbiz;
	
//	@ModelAttribute
//	public RailRegist get(@RequestParam(required=false) String id) {
//		RailRegist entity = null;
//		if (StringUtils.isNotBlank(id)){
//			entity = railRegistService.get(id);
//		}
//		if (entity == null){
//			entity = new RailRegist();
//		}
//		return entity;
//	}
	
	
	@RequestMapping(value = {"list", ""})
	public String list(RailRegist railRegist, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<RailRegist> page = railRegistService.findPage(new Page<RailRegist>(request, response), railRegist); 
		model.addAttribute("page", page);
		return "modules/wlpt/railregist/railRegistList";
	}

	
	@RequestMapping(value = "form")
	public String form(RailRegist railRegist, Model model) {
		model.addAttribute("railRegist", railRegist);
		return "modules/wlpt/railregist/railRegistForm";
	}

	
	@RequestMapping(value = "save")
	public String save(RailRegist railRegist, Model model, RedirectAttributes redirectAttributes) {
//		if (!beanValidator(model, railRegist)){
//			return form(railRegist, model);
//		}
		Map<String,Object> map = railRegistBiz.save(railRegist);
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:"+Global.getAdminPath()+"/wlpt/railRegist/?repage";
	}
	
	
	@RequestMapping(value = "delete")
	public String delete(RailRegist railRegist, RedirectAttributes redirectAttributes) {
		Map<String,Object> map = railRegistBiz.delete(railRegist);
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:"+Global.getAdminPath()+"/wlpt/railRegist/?repage";
	}
	
	@RequestMapping(value = "test")
	@ResponseBody
	public void test(){
		tradeBiz.regionRegistration();
	}
	
	
}