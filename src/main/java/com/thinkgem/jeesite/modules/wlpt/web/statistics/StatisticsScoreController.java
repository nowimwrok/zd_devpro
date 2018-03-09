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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsScore;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsScoreService;

/**
 * 诚信积分统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsScore")
public class StatisticsScoreController extends BaseController {

	@Autowired
	private StatisticsScoreService statisticsScoreService;
	
	@ModelAttribute
	public StatisticsScore get(@RequestParam(required=false) String id) {
		StatisticsScore entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsScoreService.get(id);
		}
		if (entity == null){
			entity = new StatisticsScore();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsScore:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsScore statisticsScore, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsScore> page = statisticsScoreService.findPage(new Page<StatisticsScore>(request, response), statisticsScore); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsScoreList";
	}

	@RequiresPermissions("wlpt:statistics:statisticsScore:view")
	@RequestMapping(value = "form")
	public String form(StatisticsScore statisticsScore, Model model) {
		model.addAttribute("statisticsScore", statisticsScore);
		return "modules/wlpt/statistics/statisticsScoreForm";
	}

	@RequiresPermissions("wlpt:statistics:statisticsScore:edit")
	@RequestMapping(value = "save")
	public String save(StatisticsScore statisticsScore, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, statisticsScore)){
			return form(statisticsScore, model);
		}
		statisticsScoreService.save(statisticsScore);
		addMessage(redirectAttributes, "保存诚信积分统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsScore/?repage";
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsScore:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsScore statisticsScore, RedirectAttributes redirectAttributes) {
		statisticsScoreService.delete(statisticsScore);
		addMessage(redirectAttributes, "删除诚信积分统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsScore/?repage";
	}
	///==============================================导出=================================================
	/**
	 * 诚信积分统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsScore statisticsScore,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "诚信积分统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsScore> page = statisticsScoreService.findPage(new Page<StatisticsScore>(request, response), statisticsScore); 
			new ExportExcel(title + "信息数据", StatisticsScore.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsScore/?repage";
	}
}