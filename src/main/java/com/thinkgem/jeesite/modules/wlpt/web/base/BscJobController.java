/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;

import javax.annotation.Resource;
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
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscJobService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;


/**
 * 任务Controller
 * @author 王铸
 * @version 2016-09-07
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bscJob")
public class BscJobController extends BaseController {

	@Autowired
	private BscJobService bscJobService;
	
	@Resource(name="jobBiz")
	private JobBiz jobBiz;
	
	@ModelAttribute
	public BscJob get(@RequestParam(required=false) String id) {
		BscJob entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bscJobService.get(id);
		}
		if (entity == null){
			entity = new BscJob();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:bscJob:view")
	@RequestMapping(value = {"list", ""})
	public String list(BscJob bscJob, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BscJob> page = bscJobService.findPage(new Page<BscJob>(request, response), bscJob); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/bscJobList";
	}

	@RequiresPermissions("wlpt:bscJob:view")
	@RequestMapping(value = "form")
	public String form(BscJob bscJob, Model model) {
		model.addAttribute("bscJob", bscJob);
		return "modules/wlpt/base/bscJobForm";
	}

	@RequiresPermissions("wlpt:bscJob:edit")
	@RequestMapping(value = "save")
	public String save(BscJob bscJob, Model model, RedirectAttributes redirectAttributes) throws Exception {
		if (!beanValidator(model, bscJob)){
			return form(bscJob, model);
		}
		if(Tools.IsNullOrWhiteSpace(bscJob.getId())){
			bscJob.setCreatetime(new Date());
			bscJob.setIsNewRecord(true);
			bscJob.setId(IdGen.uuid());
		}
		
		bscJob.setUpdatetime(new Date());
		jobBiz.save(bscJob);
		
		addMessage(redirectAttributes, "保存任务成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bscJob/?repage";
	}
	
	@RequiresPermissions("wlpt:bscJob:edit")
	@RequestMapping(value = "delete")
	public String delete(BscJob bscJob, RedirectAttributes redirectAttributes) throws Exception {
		jobBiz.delete(bscJob);
		addMessage(redirectAttributes, "删除任务成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bscJob/?repage";
	}

}