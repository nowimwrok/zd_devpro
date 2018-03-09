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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradeflow;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradeflowService;

/**
 * 运输流向统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsTradeflow")
public class StatisticsTradeflowController extends BaseController {

	@Autowired
	private StatisticsTradeflowService statisticsTradeflowService;
	
	@ModelAttribute
	public StatisticsTradeflow get(@RequestParam(required=false) String id) {
		StatisticsTradeflow entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsTradeflowService.get(id);
		}
		if (entity == null){
			entity = new StatisticsTradeflow();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsTradeflow:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsTradeflow statisticsTradeflow, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsTradeflow> page = statisticsTradeflowService.findPage(new Page<StatisticsTradeflow>(request, response), statisticsTradeflow); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsTradeflowList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsTradeflow:view")
	@RequestMapping(value = "form")
	public String form(StatisticsTradeflow statisticsTradeflow, Model model) {
		model.addAttribute("statisticsTradeflow", statisticsTradeflow);
		return "modules/wlpt/statistics/statisticsTradeflowForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsTradeflow:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsTradeflow statisticsTradeflow, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsTradeflow)){
			return form(statisticsTradeflow, model);
		}
		statisticsTradeflowService.save(statisticsTradeflow);
		addMessage(redirectAttributes, "保存运输流向统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsTradeflow/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsTradeflow:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsTradeflow statisticsTradeflow, RedirectAttributes redirectAttributes) {
		statisticsTradeflowService.delete(statisticsTradeflow);
		addMessage(redirectAttributes, "删除运输流向统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsTradeflow/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 运输流向统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsTradeflow statisticsTradeflow, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "运输流向统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsTradeflow> page = statisticsTradeflowService.findPage(new Page<StatisticsTradeflow>(request, response), statisticsTradeflow); 
			new ExportExcel(title + "信息数据", StatisticsTradeflow.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsTradeflow/?repage";
	}
}