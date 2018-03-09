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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsRole;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRoleService;

/**
 * 角色会员总量统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsRole")
public class StatisticsRoleController extends BaseController {

	@Autowired
	private StatisticsRoleService statisticsRoleService;
	
	@ModelAttribute
	public StatisticsRole get(@RequestParam(required=false) String id) {
		StatisticsRole entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsRoleService.get(id);
		}
		if (entity == null){
			entity = new StatisticsRole();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsRole:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsRole statisticsRole, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsRole> page = statisticsRoleService.findPage(new Page<StatisticsRole>(request, response), statisticsRole); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsRoleList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsRole:view")
	@RequestMapping(value = "form")
	public String form(StatisticsRole statisticsRole, Model model) {
		model.addAttribute("statisticsRole", statisticsRole);
		return "modules/wlpt/statistics/statisticsRoleForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsRole:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsRole statisticsRole, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsRole)){
			return form(statisticsRole, model);
		}
		statisticsRoleService.save(statisticsRole);
		addMessage(redirectAttributes, "保存角色会员总量统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRole/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsRole:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsRole statisticsRole, RedirectAttributes redirectAttributes) {
		statisticsRoleService.delete(statisticsRole);
		addMessage(redirectAttributes, "删除角色会员总量统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRole/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 角色会员总量统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsRole statisticsRole, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "角色会员总量统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsRole> page = statisticsRoleService.findPage(new Page<StatisticsRole>(request, response), statisticsRole); 
			new ExportExcel(title + "信息数据", StatisticsRole.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsRole/?repage";
	}
}