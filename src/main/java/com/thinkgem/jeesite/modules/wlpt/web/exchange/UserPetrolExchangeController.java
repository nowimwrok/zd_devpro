/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.exchange;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.exchange.PetrolExchangeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecordService;

/**
 * 油气兑换余额审核Controller
 * @author zyj
 * @version 2017-02-15
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/exchange/userPetrolExchange")
public class UserPetrolExchangeController extends BaseController {

	@Autowired
    private PetrolExchangeBiz petrolExchangeBiz; 
	
	@Autowired
    private UserMetroCardRecordService cardRecordService;
	
	@ModelAttribute
	public UserPetrolExchange get(@RequestParam(required=false) String id) {
		UserPetrolExchange entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = petrolExchangeBiz.get(id);
		}
		if (entity == null){
			entity = new UserPetrolExchange();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:exchange:userPetrolExchange:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserPetrolExchange userPetrolExchange, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserPetrolExchange> page = petrolExchangeBiz.findPage(new Page<UserPetrolExchange>(request, response), userPetrolExchange); 
		model.addAttribute("page", page);
		return "modules/wlpt/exchange/userPetrolExchangeList";
	}

	@RequiresPermissions("wlpt:exchange:userPetrolExchange:view")
	@RequestMapping(value = "form")
	public String form(UserPetrolExchange userPetrolExchange,HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroCardRecord> page = petrolExchangeBiz.getPetrolExchangeRecordList(new Page<UserMetroCardRecord>(request, response),userPetrolExchange.getExchangeNo());
		model.addAttribute("page", page);
		model.addAttribute("userPetrolExchange", userPetrolExchange);
		return "modules/wlpt/exchange/userPetrolExchangeForm";
	}

	@RequiresPermissions("wlpt:exchange:userPetrolExchange:edit")
	@RequestMapping(value = "save")
	public String save(UserPetrolExchange userPetrolExchange, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userPetrolExchange)){
			return form(userPetrolExchange, null, null, model);
		}
		int result = petrolExchangeBiz.petrolexchangeAudit(userPetrolExchange);
		if(DataDic.RETURN_STATUS_NORMAL == result){
			addMessage(redirectAttributes, "审核成功");
		}else{
			addMessage(redirectAttributes, "审核失败");
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/exchange/userPetrolExchange/?repage";
	}
	
	@RequiresPermissions("wlpt:exchange:userPetrolExchange:edit")
	@RequestMapping(value = "delete")
	public String delete(UserPetrolExchange userPetrolExchange, RedirectAttributes redirectAttributes) {
		petrolExchangeBiz.delete(userPetrolExchange);
		addMessage(redirectAttributes, "删除油气兑换余额成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/exchange/userPetrolExchange/?repage";
	}
	
	/**
     * 列表
     *
     * @param cardRecord
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getmcrList")
    public Object getmcrList( UserPetrolExchange userPetrolExchange, Model model) {
        Page<UserMetroCardRecord> pg = new Page<>();
        pg.setList(petrolExchangeBiz.getPetrolExchangeRecordInfo(userPetrolExchange.getExchangeNo()));
        
        model.addAttribute("page", pg);
        return new JSONPObject("callback", pg);
    }

    /**
	 * 一卡通消费记录明细报表导出
	 * 
	 * @param userMetroCardRecord
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cardRecoditemExport", method = RequestMethod.POST)
	public String cardRecoditemExport(UserPetrolExchange userPetrolExchange, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "兑换号"+userPetrolExchange.getExchangeNo()+"的一卡通消费明细信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<UserMetroCardRecordVO> list = petrolExchangeBiz.getPetrolExchangeRecordbyExportList(userPetrolExchange.getExchangeNo());
			new ExportExcel("兑换号为："+userPetrolExchange.getExchangeNo()+"的一卡通消费明细信息数据", UserMetroCardRecordVO.class).setDataList(list).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出一卡通消费明细失败！失败信息：" + e.getMessage());
		}
		return null;
	}
	
	@RequiresPermissions("wlpt:exchange:userPetrolExchange:edit")
	@RequestMapping(value = "editInvoiceStatus")
	public String editInvoiceStatus(UserPetrolExchange userPetrolExchange, RedirectAttributes redirectAttributes) {
		petrolExchangeBiz.editInvoiceStatus(userPetrolExchange.getId(),userPetrolExchange.getInvoiceStatus());
		addMessage(redirectAttributes, "确认收票成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/exchange/userPetrolExchange/?repage";
	}
    
}