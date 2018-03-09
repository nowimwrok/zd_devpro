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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsCar;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsCarService;

/**
 * 平台车辆统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsCar")
public class StatisticsCarController extends BaseController {

	@Autowired
	private StatisticsCarService statisticsCarService;
	
	@ModelAttribute
	public StatisticsCar get(@RequestParam(required=false) String id) {
		StatisticsCar entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsCarService.get(id);
		}
		if (entity == null){
			entity = new StatisticsCar();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsCar:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsCar statisticsCar, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsCar> page = statisticsCarService.findPage(new Page<StatisticsCar>(request, response), statisticsCar); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsCarList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsCar:view")
	@RequestMapping(value = "form")
	public String form(StatisticsCar statisticsCar, Model model) {
		model.addAttribute("statisticsCar", statisticsCar);
		return "modules/wlpt/statistics/statisticsCarForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsCar:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsCar statisticsCar, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsCar)){
			return form(statisticsCar, model);
		}
		statisticsCarService.save(statisticsCar);
		addMessage(redirectAttributes, "保存平台车辆统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsCar/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsCar:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsCar statisticsCar, RedirectAttributes redirectAttributes) {
		statisticsCarService.delete(statisticsCar);
		addMessage(redirectAttributes, "删除平台车辆统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsCar/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 平台车辆统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsCar statisticsCar,   HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "平台车辆统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsCar> page = statisticsCarService.findPage(new Page<StatisticsCar>(request, response), statisticsCar); 
			new ExportExcel(title + "信息数据", StatisticsCar.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsCar/?repage";
	}
}