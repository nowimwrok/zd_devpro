/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.consume;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
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
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Deallog;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ConsumeauditRechargeVO;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumeauditService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.DeallogService;

/**
 * 后台账户充值，管理审核Controller
 * @author 饶江龙
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/consume/consumeaudit")
public class ConsumeauditController extends BaseController {

	@Autowired
	private ConsumeauditService consumeauditService;

	@Autowired
    private DeallogService deallogService;
	
	@Autowired
    private ConsumerecodService consumeRecodService;
	
	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;
	
	@ModelAttribute
	public Consumeaudit get(@RequestParam(required=false) String id) {
		Consumeaudit entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = consumeauditService.get(id);
		}
		if (entity == null){
			entity = new Consumeaudit();
		}
		return entity;
	}

	/***
	 * 去提现管理页面
	 * @param consumeaudit
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumeaudit:view")
	@RequestMapping(value = {"cash_list", ""})
	public String cash_list(Consumeaudit consumeaudit, HttpServletRequest request, HttpServletResponse response, Model model, String isRedrect) {
		///查询账户充值
		model.addAttribute("isRedrect", isRedrect);
		Page pg = new Page<Consumeaudit>(request, response);
		
    	Cookie[] cookies = request.getCookies();
    	for(Cookie c :cookies){
    		if(c.getName().equals("cash_searchinfo") ||c.getName().equals("cash_consumemony")
    				||c.getName().equals("cash_status")||c.getName().equals("cash_beginCreateDate")
    				||c.getName().equals("cash_endCreateDate")||c.getName().equals("cash_pageNo")
    				||c.getName().equals("cash_pageSize")){
    			String value = c.getValue();
    			if(!Tools.IsNullOrWhiteSpace(isRedrect)&& isRedrect.equals("true") && !Tools.IsNullOrWhiteSpace(value)){
    				if(c.getName().equals("cash_searchinfo")){
    					consumeaudit.setSearchinfo(c.getValue());
        			}else if(c.getName().equals("cash_consumemony")){
    					Consumerecod consume = new Consumerecod();
    					consume.setConsumemony(c.getValue());
    					consumeaudit.setConsume(consume);
        			}else if(c.getName().equals("cash_status")){
    					consumeaudit.setAuditstatus(c.getValue());
        			}else if(c.getName().equals("cash_beginCreateDate")){
    					consumeaudit.setBeginCreateDate(DateUtil.fomatDate(c.getValue()));
        			}else if(c.getName().equals("cash_endCreateDate")){
    					consumeaudit.setEndCreateDate(DateUtil.fomatDate(c.getValue()));
        			}else if(c.getName().equals("cash_pageNo")){
        				pg.setPageNo(Integer.parseInt(c.getValue()));
        			}
    			}
    			if(isRedrect == null || isRedrect ==""){
        			c.setValue(null);
        			response.addCookie(c);
    			}
    		}
    	}
		consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTCASH);
		User user = UserUtils.getUser();
		if(user!=null && user.getRole()!=null && !Tools.IsNullOrWhiteSpace(user.getRole().getId())){
			if(Role.DATA_SCOPE_POS.equals(user.getRole().getDataScope())){
				consumeaudit.getSqlMap().put("dsf", "AND u2.isposuser = 1");
			}
		}
		Page<Consumeaudit> page = consumeauditService.findPage(pg, consumeaudit);
		if(page.getList().size()>0){
			for (Consumeaudit cu : page.getList()) {
				Deallog deallog = new Deallog();
				Consumeaudit audit = new Consumeaudit();
				audit.setId(cu.getId());
				deallog.setConsumeaudit(audit);
				cu.setList(deallogService.findList(deallog));
			}
		}
		model.addAttribute("consumeaudit", consumeaudit);
		model.addAttribute("page", page);
		return "modules/wlpt/consume/cash_list";
	}

	/**
	 * 提现审核明细导出
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cashExport", method = RequestMethod.POST)
	public String cashExport(Consumeaudit consumeaudit, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			List<Consumeaudit> list=new ArrayList<>();
			String fileName = "用户提现审核明细信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			///查询账户充值
			consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTCASH);
			User user = UserUtils.getUser();
			if(user!=null && user.getRole()!=null && !Tools.IsNullOrWhiteSpace(user.getRole().getId())){
				if(Role.DATA_SCOPE_POS.equals(user.getRole().getDataScope())){
					consumeaudit.getSqlMap().put("dsf", "AND u2.isposuser = 1");
				}
			}
			Page<Consumeaudit> pg = new Page<Consumeaudit>(); 
			pg.setPageSize(Integer.MAX_VALUE);
			Page<Consumeaudit> page = consumeauditService.findPage(pg, consumeaudit);
			
			list = page.getList();
			
			
			new ExportExcel("提现审核明细信息数据", Consumeaudit.class).setDataList(list).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出提现审核明细失败！失败信息：" + e.getMessage());
		}
		return null;
	}

	
	
	/***
	 * 审核
	 * @param consumeaudit
	 * @param model
	 * @param redirectAttributes
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumeaudit:edit")
	@RequestMapping(value = "editConsumeAudit")
	public String consumeAuditStatus(Consumeaudit consumeaudit, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, consumeaudit)){
			return form(consumeaudit, model);
		}
		String url="list";
		int result=consumeRecodBiz.auditStatus(consumeaudit);
		if (result!=1){
			if(result==-3){
				Consumeaudit oldConsumaudit = consumeauditService.get(consumeaudit.getId());
				oldConsumaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_FAILED);
				oldConsumaudit.setRemarks("提现失败,资金正在冲正");
				consumeauditService.save(oldConsumaudit);
		        deallogService.saveDealLog(oldConsumaudit);
		        
				Consumerecod consumerecod = consumeRecodService.get(consumeaudit.getConsume().getId());
				Consumerecod upcode = new Consumerecod();
		        upcode.setId(consumerecod.getId());
	            upcode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_FAILED);
	            upcode.preUpdate();
	            consumeRecodService.updateByConsumeStatus(upcode);
	            
	            addMessage(redirectAttributes, "操作失败，已驳回");
	            if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(consumeaudit.getType())){
	    			url="cash_list";
	    		}
	            return "redirect:"+Global.getAdminPath()+"/wlpt/consume/consumeaudit/"+url+"?repage";
			}
			model.addAttribute("message", Tools.statusMessage(result,"审核"));
			return toAudit(consumeaudit, model);
		}
		if (DataDic.CONSUMEAUDIT_ACCOUNTCASH.equals(consumeaudit.getType())){
			url="cash_list";
		}
		addMessage(redirectAttributes, "审核成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/consumeaudit/"+url+"?isRedrect=true&repage";
	}


	/***
	 * 去审核页面
	 * @param consumeaudit
	 * @param model
	 * @param
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumeaudit:edit")
	@RequestMapping(value = "toAudit")
	public String toAudit(Consumeaudit consumeaudit, Model model) {
		consumeaudit=consumeRecodBiz.getConsumeAudit(consumeaudit);
		model.addAttribute("consumeaudit", consumeaudit);
		return "modules/wlpt/consume/consume_Audit";
	}

	/***
	 * 后台充值流
	 * @param consumeaudit
	 * @param model
	 * @param redirectAttributes
     * @return
     */

	@RequiresPermissions("wlpt:consume:consumeaudit:edit")
	@RequestMapping(value = "recharge")
	public String recharge(Consumeaudit consumeaudit, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, consumeaudit)){
			return form(consumeaudit, model);
		}
		////验证用户是否有操作权限
		if (UserUtils.vialedRole(DataDic.ROLE_FINANCEOFFICER)){
			Boolean reslut=consumeRecodBiz.recharge(consumeaudit,model);
			if (!reslut){
				return form(consumeaudit, model);
			}
		}else {
			model.addAttribute("message", "对不起,您无权限操作");
			return form(consumeaudit, model);
		}

		addMessage(redirectAttributes, "保存账户充值成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/consumeaudit/list?repage";
	}

	/***
	 * 去充值列表页面
	 * @param consumeaudit
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumeaudit:view")
	@RequestMapping(value = {"list", ""})
	public String list(Consumeaudit consumeaudit, HttpServletRequest request, HttpServletResponse response, Model model) {
		///查询账户充值
		consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE);
			Page<Consumeaudit> page = consumeauditService.findPage(new Page<Consumeaudit>(request, response), consumeaudit);
			if(page.getList().size()>0){
				for (Consumeaudit cu : page.getList()) {
					Deallog deallog = new Deallog();
					Consumeaudit audit = new Consumeaudit();
					audit.setId(cu.getId());
					deallog.setConsumeaudit(audit);
					cu.setList(deallogService.findList(deallog));
				}
			}
		model.addAttribute("page", page);
		return "modules/wlpt/consume/consumeauditList";
	}

	/**
	 * 提现审核明细导出
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "rechargeExport", method = RequestMethod.POST)
	public String rechargeExport(Consumeaudit consumeaudit, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			List<Consumeaudit> list=new ArrayList<>();
			String fileName = "用户充值审核明细信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			///查询账户充值
			consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE);
			User user = UserUtils.getUser();
			
			Page<Consumeaudit> pg = new Page<Consumeaudit>(); 
			pg.setPageSize(Integer.MAX_VALUE);
			Page<Consumeaudit> page = consumeauditService.findPage(pg, consumeaudit);
			
			list = page.getList();
			
			
			new ExportExcel("充值审核明细信息数据", ConsumeauditRechargeVO.class).setDataList(list).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出充值审核明细失败！失败信息：" + e.getMessage());
		}
		return null;
	}
	
	@RequiresPermissions("wlpt:consume:consumeaudit:view")
	@RequestMapping(value = "form")
	public String form(Consumeaudit consumeaudit, Model model) {
		model.addAttribute("consumeaudit", consumeaudit);
		return "modules/wlpt/consume/consumeauditForm";
	}

	@RequiresPermissions("wlpt:consume:consumeaudit:edit")
	@RequestMapping(value = "save")
	public String save(Consumeaudit consumeaudit, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, consumeaudit)){
			return form(consumeaudit, model);
		}
		consumeauditService.save(consumeaudit);
		addMessage(redirectAttributes, "保存账户充值成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/consumeaudit/?repage";
	}
	
	@RequiresPermissions("wlpt:consume:consumeaudit:edit")
	@RequestMapping(value = "delete")
	public String delete(Consumeaudit consumeaudit, RedirectAttributes redirectAttributes) {
		consumeauditService.delete(consumeaudit);
		addMessage(redirectAttributes, "删除账户充值成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/consume/consumeaudit/list?repage";
	}

}