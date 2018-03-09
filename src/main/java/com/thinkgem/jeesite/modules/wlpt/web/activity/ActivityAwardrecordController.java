/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.activity;

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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityAwardrecordService;

/**
 * 中奖记录Controller
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/activity/activityAwardrecord")
public class ActivityAwardrecordController extends BaseController {

	@Autowired
	private ActivityBiz activityBiz;
	
	@ModelAttribute
	public ActivityAwardrecord get(@RequestParam(required=false) String id) {
		ActivityAwardrecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityBiz.awardrecordGet(id);
		}
		if (entity == null){
			entity = new ActivityAwardrecord();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:activity:activityAwardrecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityAwardrecord activityAwardrecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityAwardrecord> page = activityBiz.awardrecordFindPage(new Page<ActivityAwardrecord>(request, response), activityAwardrecord); 
		model.addAttribute("page", page);
		return "modules/wlpt/activity/activityAwardrecordList";
	}

	@RequiresPermissions("wlpt:activity:activityAwardrecord:view")
	@RequestMapping(value = "form")
	public String form(ActivityAwardrecord activityAwardrecord, Model model) {
		model.addAttribute("activityAwardrecord", activityAwardrecord);
		return "modules/wlpt/activity/activityAwardrecordForm";
	}

	@RequiresPermissions("wlpt:activity:activityAwardrecord:edit")
	@RequestMapping(value = "save")
	public String save(ActivityAwardrecord activityAwardrecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, activityAwardrecord)){
			return form(activityAwardrecord, model);
		}
		activityBiz.awardrecordSave(activityAwardrecord);
		addMessage(redirectAttributes, "保存中奖记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityAwardrecord/?repage";
	}
	
	//奖品操作
	@RequiresPermissions("wlpt:activity:activityAwardrecord:edit")
	@RequestMapping(value = "pubgift")
	public String pubgift(ActivityAwardrecord activityAwardrecord, RedirectAttributes redirectAttributes) {
		String message = activityBiz.txMethodEditBiz(activityAwardrecord.getId(),Integer.parseInt(activityAwardrecord.getIssue()));
		addMessage(redirectAttributes, message);
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityAwardrecord/?repage";
	}
	
	@RequiresPermissions("wlpt:activity:activityAwardrecord:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityAwardrecord activityAwardrecord, RedirectAttributes redirectAttributes) {
		activityBiz.awardrecordDelete(activityAwardrecord);
		addMessage(redirectAttributes, "删除中奖记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityAwardrecord/?repage";
	}

}