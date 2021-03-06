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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsBusiness;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsBusinessService;

/**
 * 业务数据统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsBusiness")
public class StatisticsBusinessController extends BaseController {

	@Autowired
	private StatisticsBusinessService statisticsBusinessService;
	
	@ModelAttribute
	public StatisticsBusiness get(@RequestParam(required=false) String id) {
		StatisticsBusiness entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsBusinessService.get(id);
		}
		if (entity == null){
			entity = new StatisticsBusiness();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsBusiness:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsBusiness statisticsBusiness, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsBusiness> page = statisticsBusinessService.findPage(new Page<StatisticsBusiness>(request, response), statisticsBusiness); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsBusinessList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsBusiness:view")
	@RequestMapping(value = "form")
	public String form(StatisticsBusiness statisticsBusiness, Model model) {
		model.addAttribute("statisticsBusiness", statisticsBusiness);
		return "modules/wlpt/statistics/statisticsBusinessForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsBusiness:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsBusiness statisticsBusiness, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsBusiness)){
			return form(statisticsBusiness, model);
		}
		statisticsBusinessService.save(statisticsBusiness);
		addMessage(redirectAttributes, "保存业务数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsBusiness/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsBusiness:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsBusiness statisticsBusiness, RedirectAttributes redirectAttributes) {
		statisticsBusinessService.delete(statisticsBusiness);
		addMessage(redirectAttributes, "删除业务数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsBusiness/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 业务数据统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsBusiness statisticsBusiness,HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "业务数据统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsBusiness> page = statisticsBusinessService.findPage(new Page<StatisticsBusiness>(request, response), statisticsBusiness);  
			new ExportExcel(title + "信息数据", StatisticsBusiness.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsBusiness/?repage";
	}
}