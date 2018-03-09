/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.integrity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandardlogService;

import java.util.List;

/**
 * 诚信积分日志Controller
 * @author 刘欣
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityStandardlog")
public class IntegrityStandardlogController extends BaseController {

	@Autowired
	private IntegrityStandardlogService integrityStandardlogService;
	
	@ModelAttribute
	public IntegrityStandardlog get(@RequestParam(required=false) String id) {
		IntegrityStandardlog entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityStandardlogService.get(id);
		}
		if (entity == null){
			entity = new IntegrityStandardlog();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandardlog:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityStandardlog integrityStandardlog, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityStandardlog> page = integrityStandardlogService.findPage(new Page<IntegrityStandardlog>(request, response), integrityStandardlog);
		if(integrityStandardlog!=null && integrityStandardlog.getUser()!=null){
			model.addAttribute("userid", integrityStandardlog.getUser().getId());
		}
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityStandardlogList";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandardlog:view")
	@RequestMapping(value = "form")
	public String form(IntegrityStandardlog integrityStandardlog, Model model) {
		model.addAttribute("integrityStandardlog", integrityStandardlog);
		return "modules/wlpt/integrity/integrityStandardlogForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandardlog:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityStandardlog integrityStandardlog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityStandardlog)){
			return form(integrityStandardlog, model);
		}
		integrityStandardlogService.save(integrityStandardlog);
		addMessage(redirectAttributes, "保存诚信积分日志成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandardlog/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandardlog:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityStandardlog integrityStandardlog, RedirectAttributes redirectAttributes) {
		integrityStandardlogService.delete(integrityStandardlog);
		addMessage(redirectAttributes, "删除诚信积分日志成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandardlog/?repage";
	}


	/**
	 * 导出积分日志记录数据
	 *
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(IntegrityStandardlog integrityStandardlog, HttpServletRequest request, HttpServletResponse response,
							 RedirectAttributes redirectAttributes) {
		try {
			String fileName = "积分日志记录信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<IntegrityStandardlog> page = integrityStandardlogService.findPage(new Page<IntegrityStandardlog>(), integrityStandardlog);
			List<IntegrityStandardlog> varOList=page.getList();

			new ExportExcel("积分日志记录信息数据", IntegrityStandardlog.class).setDataList(varOList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户积分日志记录信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/integrity/integrityStandardlog/list?repage&user.id="+integrityStandardlog.getUser().getId();
	}

}