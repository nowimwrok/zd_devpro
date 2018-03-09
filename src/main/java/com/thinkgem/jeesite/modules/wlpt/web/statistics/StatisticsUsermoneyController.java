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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsUsermoney;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsUsermoneyService;

/**
 * 账户资金统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsUsermoney")
public class StatisticsUsermoneyController extends BaseController {

	@Autowired
	private StatisticsUsermoneyService statisticsUsermoneyService;
	
	@ModelAttribute
	public StatisticsUsermoney get(@RequestParam(required=false) String id) {
		StatisticsUsermoney entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsUsermoneyService.get(id);
		}
		if (entity == null){
			entity = new StatisticsUsermoney();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsUsermoney:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsUsermoney statisticsUsermoney, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsUsermoney> page = statisticsUsermoneyService.findPage(new Page<StatisticsUsermoney>(request, response), statisticsUsermoney); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsUsermoneyList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsUsermoney:view")
	@RequestMapping(value = "form")
	public String form(StatisticsUsermoney statisticsUsermoney, Model model) {
		model.addAttribute("statisticsUsermoney", statisticsUsermoney);
		return "modules/wlpt/statistics/statisticsUsermoneyForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsUsermoney:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsUsermoney statisticsUsermoney, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsUsermoney)){
			return form(statisticsUsermoney, model);
		}
		statisticsUsermoneyService.save(statisticsUsermoney);
		addMessage(redirectAttributes, "保存账户资金统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsUsermoney/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsUsermoney:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsUsermoney statisticsUsermoney, RedirectAttributes redirectAttributes) {
		statisticsUsermoneyService.delete(statisticsUsermoney);
		addMessage(redirectAttributes, "删除账户资金统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsUsermoney/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 账户资金统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsUsermoney statisticsUsermoney, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "账户资金统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsUsermoney> page = statisticsUsermoneyService.findPage(new Page<StatisticsUsermoney>(request, response), statisticsUsermoney); 
			new ExportExcel(title + "信息数据", StatisticsUsermoney.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsUsermoney/?repage";
	}
}