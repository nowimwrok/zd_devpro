/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseFeedback;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseFeedbackService;

/**
 * 意见反馈Controller
 * @author 王铸
 * @version 2016-08-09
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/baseFeedback")
public class BaseFeedbackController extends BaseController {

	@Autowired
	private BaseFeedbackService baseFeedbackService;
	
	@ModelAttribute
	public BaseFeedback get(@RequestParam(required=false) String id) {
		BaseFeedback entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseFeedbackService.get(id);
		}
		if (entity == null){
			entity = new BaseFeedback();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:baseFeedback:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseFeedback baseFeedback, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseFeedback> page = baseFeedbackService.findPage(new Page<BaseFeedback>(request, response), baseFeedback); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/baseFeedbackList";
	}

	@RequiresPermissions("wlpt:base:baseFeedback:view")
	@RequestMapping(value = "form")
	public String form(BaseFeedback baseFeedback, Model model) {
		model.addAttribute("baseFeedback", baseFeedback);
		return "modules/wlpt/base/baseFeedbackForm";
	}

	@RequiresPermissions("wlpt:base:baseFeedback:edit")
	@RequestMapping(value = "save")
	public String save(BaseFeedback baseFeedback, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseFeedback)){
			return form(baseFeedback, model);
		}
		if (!baseFeedback.getIsNewRecord()){
			baseFeedback.setResponsetime(new Date());
			baseFeedback.setResponseuserid(UserUtils.getUser().getId());
			baseFeedback.setResponseusername(UserUtils.getUser().getLoginName());
		}
		baseFeedbackService.save(baseFeedback);
		addMessage(redirectAttributes, DataDic.SAVE_FEEDBACK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseFeedback/?repage";
	}
	
	@RequiresPermissions("wlpt:base:baseFeedback:edit")
	@RequestMapping(value = "delete")
	public String delete(BaseFeedback baseFeedback, RedirectAttributes redirectAttributes) {
		baseFeedbackService.delete(baseFeedback);
		addMessage(redirectAttributes, DataDic.DELETE_FEEDBACK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseFeedback/?repage";
	}
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:baseFeedback:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(@RequestParam(required=false) String DATA_IDS,RedirectAttributes redirectAttributes) {
		StringBuilder sb=new StringBuilder();
		String ArrayDATA_IDS[] = DATA_IDS.split(",");
		sb.append("('");
		for (String item : ArrayDATA_IDS) {
			sb.append(item + "','");
		}
		String delteArrayStr = sb.substring(0, sb.lastIndexOf("','"))
				+ "')";
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("delteArrayStr", delteArrayStr);
		baseFeedbackService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_FEEDBACK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseFeedback/?repage";
	}

}