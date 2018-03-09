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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsTradetype;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradetypeService;

/**
 * 货源运输量统计Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsTradetype")
public class StatisticsTradetypeController extends BaseController {

	@Autowired
	private StatisticsTradetypeService statisticsTradetypeService;
	
	@ModelAttribute
	public StatisticsTradetype get(@RequestParam(required=false) String id) {
		StatisticsTradetype entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsTradetypeService.gettradetype(id);
		}
		if (entity == null){
			entity = new StatisticsTradetype();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsTradetype:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsTradetype statisticsTradetype, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsTradetype> page = statisticsTradetypeService.findtradetypeList(new Page<StatisticsTradetype>(request, response), statisticsTradetype); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsTradetypeList";
	}
	///==============================================导出=================================================
	/**
	 * 货源运输量统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile(StatisticsTradetype statisticsTradetype, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		String title = "货源运输量统计";
		try {
			
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<StatisticsTradetype> page = statisticsTradetypeService.findtradetypeList(new Page<StatisticsTradetype>(request, response), statisticsTradetype); 
			new ExportExcel(title + "信息数据", StatisticsTradetype.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsTradetype/?repage";
	}
	

}