/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.consume;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
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
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Transfer;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ConsumerecodPetrolVO;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;

/**
 * 用户交易流水信息表Controller
 * 
 * @author 饶江龙
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/consume/consumerecod")
public class ConsumerecodController extends BaseController {

	@Autowired
	private ConsumerecodService consumerecodService;
	@Autowired
    private ConsumeRecodBiz consumeRecodBiz;
	


	@ModelAttribute
	public Consumerecod get(@RequestParam(required = false) String id) {
		Consumerecod entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = consumerecodService.get(id);
		}
		if (entity == null) {
			entity = new Consumerecod();
		}
		return entity;
	}

	/**
	 * 交易流水报表导出
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "consumeRecodExport", method = RequestMethod.POST)
	public String consumeRecodExport(Consumerecod consumerecod, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			List<Consumerecod> list=new ArrayList<>();
			String fileName = "用户交易流水信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			list = consumerecodService.findList(consumerecod);
			new ExportExcel("交易流水信息数据", Consumerecod.class).setDataList(list).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出交易流水失败！失败信息：" + e.getMessage());
		}
		return null;
	}

	/**
	 * 交易流水报表导出
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "consumeRecodExportByType")
	public String consumeRecodExportByType(String id, String tradeType, Consumerecod consumerecod,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "用户交易流水信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			consumerecod.setId(id);// 用户id
			consumerecod.setSearchinfo(tradeType);// 流水类型
			Page<Consumerecod> page = consumerecodService
					.findDetailBySearchinfo(new Page<Consumerecod>(), consumerecod);
			new ExportExcel("交易流水信息数据", Consumerecod.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出交易流水失败！失败信息：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 交易流水报表导出
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "consumeRecodPetrolExportByType")
	public String consumeRecodExportByType(String id, String tradeType, ConsumerecodPetrolVO consumerecod,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "用户油气交易流水信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			consumerecod.setId(id);// 用户id
			consumerecod.setSearchinfo(tradeType);// 流水类型
			Page<ConsumerecodPetrolVO> page = consumerecodService
					.findPetrolDetailBySearchinfo(new Page<ConsumerecodPetrolVO>(), consumerecod);
			new ExportExcel("油气交易流水信息数据", ConsumerecodPetrolVO.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出交易流水失败！失败信息：" + e.getMessage());
		}
		return null;
	}


	@RequiresPermissions("wlpt:consume:consumerecod:view")
	@RequestMapping(value = { "ownerlist", "" })
	public String ownerlist(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		//// 获取当前用户的列表信息
		consumerecod.setAccount(UserUtils.getUser());
		Page<Consumerecod> page = consumerecodService.findPage(new Page<Consumerecod>(request, response), consumerecod);
		model.addAttribute("page", page);
		return "modules/wlpt/consume/consumerecodList";
	}

	/**
	 * 账单信息
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "list", "" })
	public String list(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<Consumerecod> page = consumerecodService.findPage(new Page<Consumerecod>(request, response), consumerecod);
		model.addAttribute("page", page);
		return "modules/wlpt/report/consumerecodList";
	}

	@RequiresPermissions("wlpt:consume:consumerecod:view")
	@RequestMapping(value = "form")
	public String form(Consumerecod consumerecod, Model model) {
		model.addAttribute("consumerecod", consumerecod);
		return "modules/wlpt/consume/consumerecodForm";
	}

	@RequiresPermissions("wlpt:consume:consumerecod:edit")
	@RequestMapping(value = "save")
	public String save(Consumerecod consumerecod, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, consumerecod)) {
			return form(consumerecod, model);
		}
		consumerecodService.save(consumerecod);
		addMessage(redirectAttributes, "保存交易信息成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/?repage";
	}

	@RequiresPermissions("wlpt:consume:consumerecod:edit")
	@RequestMapping(value = "delete")
	public String delete(Consumerecod consumerecod, RedirectAttributes redirectAttributes) {
		consumerecodService.delete(consumerecod);
		addMessage(redirectAttributes, "删除交易信息成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/?repage";
	}
	
	/**
	 * 用户转账列表
	 * 
	 * @param transfer
	 * @return
	 */
	@RequiresPermissions("wlpt:consume:consumerecod:view")
	@RequestMapping(value ="transferList")
	public String transferList(Transfer transfer, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<Transfer> page = consumerecodService.transferPage(new Page<Transfer>(request, response), transfer);
		for(Transfer tf:page.getList()){
			Consumerecod consumerecod=new Consumerecod();
			consumerecod.setSearch(tf.getUser().getId());
			consumerecod.setSearchType("3");
			tf.setList(consumerecodService.findList(consumerecod));
		}
		model.addAttribute("page", page);
		return "modules/wlpt/consume/transferList";
	}
	
	/**
	 * 转账导出
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "transferExport", method = RequestMethod.POST)
	public String transferExportFile( Consumerecod consumerecod,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "转账";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Consumerecod> page = consumerecodService.findPage(new Page<Consumerecod>(request, response), consumerecod); 
			new ExportExcel(title + "信息数据", Consumerecod.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出转账信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/transferExport/transferList/?repage";
	}
	
	/**
     * 转账
     * @param consumerecod
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumerecod:edit")
	@RequestMapping(value = "transfer")
	public String transfer(Consumerecod consumerecod, Model model,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes){
		if(consumerecod.getAccount().getId()==null||consumerecod.getTarget().getId()==null||consumerecod.getAccount().getId().equals("")||consumerecod.getTarget().getId().equals("")){
			addMessage(redirectAttributes, "请输入正确转账用户");
			return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/toTransfer?repage";
    	}
		User account = UserUtils.findUser(consumerecod.getAccount());
		User target = UserUtils.findUser(consumerecod.getTarget());
    	if(target==null||account==null){
    		addMessage(redirectAttributes, "请输入正确转账用户");
    		return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/toTransfer?repage";
    	}
    	String accountid=account.getId();
        String targetid=target.getId();
        double consumemony=Double.parseDouble(consumerecod.getConsumemony());
        int result=consumeRecodBiz.transferBiz(accountid,consumemony,targetid,consumerecod.getConsumeway());
        if(result==DataDic.RETURN_STATUS_NORMAL){
    		addMessage(redirectAttributes, "转账成功");
    		return list(new Consumerecod(), request, response,model);
    	}
        addMessage(redirectAttributes, "转账失败");
        return "redirect:" + Global.getAdminPath() + "/wlpt/consume/consumerecod/toTransfer?repage";
    	
	}
	
	/**
     * 去转账页面
     * @param consumerecod
     * @return
     */
	@RequiresPermissions("wlpt:consume:consumerecod:view")
    @RequestMapping(value = "toTransfer")
    public String toTransfer(Consumerecod consumerecod,Model model){
		model.addAttribute("consumerecod",consumerecod);
        return "modules/wlpt/consume/transfer";
    }

}