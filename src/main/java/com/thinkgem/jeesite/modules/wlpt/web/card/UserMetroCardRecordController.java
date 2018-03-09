/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.card;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.DoubleUnaryOperator;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.AccountUserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecorditem;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetrocardImport;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.user.CarUser;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.AccountBalanceVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecorditemVO;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecorditemService;

/**
 * 一卡通消费记录明细Controller
 * @author fjc
 * @version 2016-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/card/userMetroCardRecord")
public class UserMetroCardRecordController extends BaseController {

	@Autowired
	private UserMetroCardRecordService userMetroCardRecordService;
	@Autowired
	private UserMetroCardRecorditemService recorditemService;
	@Autowired
	private MetroCardBiz metroCardBiz;
	@ModelAttribute
	public UserMetroCardRecord get(@RequestParam(required=false) String id) {
		UserMetroCardRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userMetroCardRecordService.get(id);
		}
		if (entity == null){
			entity = new UserMetroCardRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserMetroCardRecord userMetroCardRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroCardRecord> page = userMetroCardRecordService.findPage(new Page<UserMetroCardRecord>(request, response), userMetroCardRecord); 
		List<UserMetroCardRecorditem> recorditemlLst = recorditemService.findList(new UserMetroCardRecorditem());//获取明细
		model.addAttribute("recorditemService",recorditemService);
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroCardRecordList";
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardRecord:view")
	@RequestMapping(value = {"recorditemlist", ""})
	public String recorditemlist(UserMetroCardRecord userMetroCardRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserMetroCardRecord> page = userMetroCardRecordService.finditemList(new Page<UserMetroCardRecord>(request, response), userMetroCardRecord); 

		model.addAttribute("page", page);
		return "modules/wlpt/card/recorditemList";
	}

	
	@RequestMapping(value = "form")
	public String form(UserMetroCardRecord userMetroCardRecord, Model model) {
		model.addAttribute("userMetroCardRecord", userMetroCardRecord);
		return "modules/wlpt/card/userMetroCardRecordForm";
	}

	@RequiresPermissions("wlpt:card:userMetroCardRecord:edit")
	@RequestMapping(value = "save")
	public String save(UserMetroCardRecord userMetroCardRecord, Model model, RedirectAttributes redirectAttributes) {
		if (userMetroCardRecord==null || Tools.IsNullOrWhiteSpace(userMetroCardRecord.getBillnumber())){
			addMessage(redirectAttributes, "单据号不能为空");
			return form(userMetroCardRecord, model);
		}
		String message = metroCardBiz.getConsumption(userMetroCardRecord.getBillnumber());
		addMessage(redirectAttributes, message);
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardRecord/list";
	}
	
	@RequiresPermissions("wlpt:card:userMetroCardRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(UserMetroCardRecord userMetroCardRecord, RedirectAttributes redirectAttributes) {
		userMetroCardRecordService.delete(userMetroCardRecord);
		addMessage(redirectAttributes, "删除一卡通消费记录成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/card/userMetroCardRecord/?repage";
	}

	/**
	 * 一卡通消费记录报表导出
	 * 
	 * @param userMetroCardRecord
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cardRecodExport", method = RequestMethod.POST)
	public String cardRecodExport(UserMetroCardRecord userMetroCardRecord, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "用户一卡通消费记录信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<UserMetroCardRecord> page = userMetroCardRecordService.findPage(new Page<UserMetroCardRecord>(), userMetroCardRecord);
			new ExportExcel("一卡通消费记录信息数据", UserMetroCardRecord.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出一卡通消费记录失败！失败信息：" + e.getMessage());
		}
		return null;
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
	public String cardRecoditemExport(UserMetroCardRecordVO recordVO, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "用户一卡通消费明细信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<UserMetroCardRecordVO> list = userMetroCardRecordService.finditembyexportList(recordVO);
			new ExportExcel("一卡通消费明细信息数据", UserMetroCardRecordVO.class).setDataList(list).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出一卡通消费明细失败！失败信息：" + e.getMessage());
		}
		return null;
	}
	
	/**
	 * 用户一卡通消费统计列表
	 * @param accountUserMetroCard
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"listAccount", ""})
	public String listAccount(AccountUserMetroCard accountUserMetroCard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<AccountUserMetroCard> page = userMetroCardRecordService.findAccountPage(new Page<AccountUserMetroCard>(request, response), accountUserMetroCard); 
		model.addAttribute("page", page);
		return "modules/wlpt/card/userMetroCardAccountList";
	}
	
	/**
	 * 用户一卡通消费统计报表导出
	 * 
	 * @param userMetroCardRecord
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "cardAccountExport", method = RequestMethod.POST)
	public String cardAccountExport(AccountUserMetroCard accountUserMetroCard, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {

		try {
			String fileName = "用户一卡通消费统计信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<AccountUserMetroCard> page = userMetroCardRecordService.findAccountPage(new Page<AccountUserMetroCard>(), accountUserMetroCard);
			new ExportExcel("用户一卡通消费统计信息数据", AccountUserMetroCard.class).setDataList(page.getList()).write(response, fileName)
					.dispose();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			addMessage(redirectAttributes, "导出用户一卡通消费统计失败！失败信息：" + e.getMessage());
		}
		return null;
	}

	@RequiresPermissions("wlpt:card:userMetroCardRecord:view")
	@RequestMapping(value = {"recorditemReconciliation", ""})
	public String recorditemReconciliation(UserMetroCardRecord userMetroCardRecord,HttpServletRequest request, HttpServletResponse response, Model model) {
		
		//pagelist.setPageNo(1);
		Page<UserMetroCardRecord> page = userMetroCardRecordService.finditemList(new Page<UserMetroCardRecord>(request,response), userMetroCardRecord); 
		
		model.addAttribute("page", page);
		return "modules/wlpt/card/recorditemReconciliation";
	}
	
	@RequestMapping(value = "importBox", method=RequestMethod.POST)
	public String importBox(MultipartFile file,UserMetroCardRecordVO recordVO,Model model, HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes){
		try {
			int successNum = 0;
			int failureNum = 0;
	    	StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<UserMetrocardImport> caruserlist = ei.getDataList(UserMetrocardImport.class);
			List<UserMetroCardRecordVO> itemlist = userMetroCardRecordService.finditembyexportList(recordVO);
			List<UserMetroCardRecordVO> importlist = getDifferent(caruserlist,itemlist);
			
			String fileName = "用户一卡通消费明细信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			
			new ExportExcel("一卡通消费明细信息数据", UserMetroCardRecordVO.class).setDataList(importlist).write(response, fileName)
					.dispose();
		} catch (Exception e) {
			/*addMessage(redirectAttributes, "导入用户失败！失败信息："+e.getMessage());*/
		}
		return null;
	}
	private static List<UserMetroCardRecordVO> getDifferent(List<UserMetrocardImport> prelist, List<UserMetroCardRecordVO> curlist) {  
        List<UserMetroCardRecordVO> diff = new ArrayList<UserMetroCardRecordVO>();  
         
        Map<String,UserMetroCardRecordVO> map = new HashMap<String,UserMetroCardRecordVO>(curlist.size());  
        for (UserMetroCardRecordVO item : curlist) {  
            map.put(item.getBillnumber(),item);  
        }  
        for (UserMetrocardImport card : prelist) { 
        	UserMetroCardRecordVO record = map.get(card.getBillnumber());
            if(record!=null)  
            {  
            	if(Double.parseDouble(record.getTotalpaid())==Double.parseDouble(card.getPaidmoney())){
            		record.setIsnormal("数据正常");
                    map.remove(card.getBillnumber());
                    map.put(card.getBillnumber(),record);
                    continue;  
            	}
            	
            }   
        }  
        for(Map.Entry<String,UserMetroCardRecordVO> entry:map.entrySet())  
        {  
        	UserMetroCardRecordVO record = entry.getValue();
            if(Tools.IsNullOrWhiteSpace(record.getIsnormal()))  
            {  
            	record.setIsnormal("数据异常");
            }  
            diff.add(record);
        }  
       
       return diff;  
         
   } 
	
}