/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.statistics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRegister;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRegisterService;

/**
 * 统计用户注册量Controller
 * @author 曾煜佳
 * @version 2016-10-26
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsRegister")
public class StatisticsRegisterController extends BaseController {

	@Autowired
	private StatisticsRegisterService statisticsRegisterService;
	
	@ModelAttribute
	public StatisticsRegister get(@RequestParam(required=false) String id) {
		StatisticsRegister entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsRegisterService.get(id);
		}
		if (entity == null){
			entity = new StatisticsRegister();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsRegister:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsRegister statisticsRegister, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsRegister> page = statisticsRegisterService.findPage(new Page<StatisticsRegister>(request, response), statisticsRegister); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsRegisterList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsRegister:view")
	@RequestMapping(value = "form")
	public String form(StatisticsRegister statisticsRegister, Model model) {
		model.addAttribute("statisticsRegister", statisticsRegister);
		return "modules/wlpt/statistics/statisticsRegisterForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsRegister:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsRegister statisticsRegister, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsRegister)){
			return form(statisticsRegister, model);
		}
		statisticsRegisterService.save(statisticsRegister);
		addMessage(redirectAttributes, "保存用户注册统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRegister/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsRegister:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsRegister statisticsRegister, RedirectAttributes redirectAttributes) {
		statisticsRegisterService.delete(statisticsRegister);
		addMessage(redirectAttributes, "删除用户注册统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRegister/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 用户注册统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsRegister statisticsRegister,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "用户注册统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsRegister> page = statisticsRegisterService.findPage(new Page<StatisticsRegister>(request, response), statisticsRegister); 
			new ExportExcel(title + "信息数据", StatisticsRegister.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRegister/?repage";
	}
}