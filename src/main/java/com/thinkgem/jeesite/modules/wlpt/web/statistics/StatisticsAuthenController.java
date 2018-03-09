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
import com.thinkgem.jeesite.modules.wlpt.entity.statistics.StatisticsAuthen;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsAuthenService;

/**
 * 用户认证统计表Controller
 * @author 曾煜佳
 * @version 2016-09-12
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/statistics/statisticsAuthen")
public class StatisticsAuthenController extends BaseController {

	@Autowired
	private StatisticsAuthenService statisticsAuthenService;
	
	@ModelAttribute
	public StatisticsAuthen get(@RequestParam(required=false) String id) {
		StatisticsAuthen entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = statisticsAuthenService.get(id);
		}
		if (entity == null){
			entity = new StatisticsAuthen();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:statistics:statisticsAuthen:view")
	@RequestMapping(value = {"list", ""})
	public String list(StatisticsAuthen statisticsAuthen, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<StatisticsAuthen> page = statisticsAuthenService.findPage(new Page<StatisticsAuthen>(request, response), statisticsAuthen); 
		model.addAttribute("page", page);
		return "modules/wlpt/statistics/statisticsAuthenList";
	}


	@RequiresPermissions("wlpt:statistics:statisticsAuthen:edit")
	@RequestMapping(value = "delete")
	public String delete(StatisticsAuthen statisticsAuthen, RedirectAttributes redirectAttributes) {
		statisticsAuthenService.delete(statisticsAuthen);
		addMessage(redirectAttributes, "删除用户认证统计表成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsAuthen/?repage";
	}

	///==============================================导出=================================================
		/**
		 * 用户认证统计导出
		 * @param userStatistics
		 * @param request
		 * @param response
		 * @param redirectAttributes
		 * @return
		 */
		@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
		public String statisticsExportFile(StatisticsAuthen statisticsAuthen,   HttpServletRequest request,
				HttpServletResponse response, RedirectAttributes redirectAttributes) {
			String title = "用户认证统计";
			try {
				
				String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
				Page<StatisticsAuthen> page = statisticsAuthenService.findPage(new Page<StatisticsAuthen>(request, response), statisticsAuthen); 
				new ExportExcel(title + "信息数据", StatisticsAuthen.class).setDataList(page.getList()).write(response, fileName).dispose();

				return null;
			} catch (Exception e) {
				addMessage(redirectAttributes, "导出"+title+"信息数据失败！失败信息：" + e.getMessage());
			}
			return "redirect:"+Global.getAdminPath()+"/wlpt/statistics/statisticsAuthen/?repage";
		}
		
	
}