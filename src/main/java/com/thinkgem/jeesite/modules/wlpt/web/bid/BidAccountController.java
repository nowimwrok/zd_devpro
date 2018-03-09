/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.bid;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidAccount;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidDeposit;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;

/**
 * 竞标投标结算信息表Controller
 * @author lijintao
 * @version 2016-08-29
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bid/account")
public class BidAccountController extends BaseController {

	@Autowired
	private ConsumerecodService consumerecodService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public Account get(@RequestParam(required=false) String id) {
		Account entity = null;
		if (StringUtils.isNotBlank(id)){
		}
		if (entity == null){
			entity = new Account();
		}
		return entity;
	}
	@RequiresPermissions("wlpt:bid:account:list")
	@RequestMapping(value = {"list", ""})
	public String list(Account account, HttpServletRequest request, HttpServletResponse response, Model model) {
		account.setAccount(true);//只统计竞标结算
		Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(request, response), account);
		model.addAttribute("page", page);
		return "modules/wlpt/bid/bidaccountMsg";
	}
	
	 @SuppressWarnings("deprecation")
	@RequestMapping(value = "export", method=RequestMethod.POST)
	    public String exportFile(Account account, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
			try {
				account.setAccount(true);//只统计竞标结算
	            String fileName = "竞标押金信息数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
	            Page<Account> page=consumerecodService.findUserAccount(new Page<Account>(request,response), account);
	            
	    		new ExportExcel("竞标押金信息数据", BidAccount.class).setDataList(page.getList()).write(response, fileName).dispose();
	    		return null;
			} catch (Exception e) {
				addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
			}
			return "redirect:" + adminPath + "/wlpt/bid/account/";
	    }
	 
		@RequestMapping(value = "detail")
		public String detail(Consumerecod consumerecod,HttpServletRequest request, HttpServletResponse response, Model model) {
			String userId=request.getParameter("id");
			consumerecod.setId(userId);
			consumerecod.setSearchinfo("account");
			Page<Consumerecod> page=consumerecodService.findDetailById(new Page<Consumerecod>(request,response),consumerecod);
			model.addAttribute("page", page);
			return "modules/wlpt/bid/bidaccountDetail";
		}
	
}