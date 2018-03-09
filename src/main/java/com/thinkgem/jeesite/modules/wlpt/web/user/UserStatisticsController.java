/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserStatisticsBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountBidVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountBiddingVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountCashVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountOtherVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountRechargeVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountTradeOrderVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountTransferVO;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;

/**
 * 用户统计功能Controller
 * @author 曾煜佳
 * @version 2016-08-31
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userStatistics")
public class UserStatisticsController extends BaseController {

	@Autowired
	private UserStatisticsBiz userStatisticsBiz;
	
	@ModelAttribute
	public UserStatistics get(@RequestParam(required=false) String id) {
		UserStatistics entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userStatisticsBiz.get(id);
		}
		if (entity == null){
			entity = new UserStatistics();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:user:userStatistics:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserStatistics userStatistics, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserStatistics> page = userStatisticsBiz.findPage(new Page<UserStatistics>(request, response), userStatistics); 
		model.addAttribute("page", page);
		return "modules/wlpt/user/userStatisticsList";
	}

	@RequiresPermissions("wlpt:user:userStatistics:view")
	@RequestMapping(value = "form")
	public String form(UserStatistics userStatistics, Model model) {
		model.addAttribute("userStatistics", userStatistics);
		return "modules/wlpt/user/userStatisticsForm";
	}

	@RequiresPermissions("wlpt:user:userStatistics:edit")
	@RequestMapping(value = "save")
	public String save(UserStatistics userStatistics, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userStatistics)){
			return form(userStatistics, model);
		}
		userStatisticsBiz.save(userStatistics);
		addMessage(redirectAttributes, "保存用户数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userStatistics/?repage";
	}
	
	@RequiresPermissions("wlpt:user:userStatistics:edit")
	@RequestMapping(value = "delete")
	public String delete(UserStatistics userStatistics, RedirectAttributes redirectAttributes) {
		userStatisticsBiz.delete(userStatistics);
		addMessage(redirectAttributes, "删除用户数据统计成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userStatistics/?repage";
	}
	
	///==============================================导出=================================================
	/**
	 * 用户数据统计导出
	 * @param userStatistics
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "statisticsExport", method = RequestMethod.POST)
	public String statisticsExportFile( UserStatistics userStatistics,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "用户数据统计 ";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<UserStatistics> page = userStatisticsBiz.findPage(new Page<UserStatistics>(request, response), userStatistics); 
			new ExportExcel(title + "信息数据", UserStatistics.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户数据统计信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/user/userStatistics/?repage";
	}
	
	
	

}