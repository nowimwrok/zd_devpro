/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscAgreement;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscAgreementService;

/**
 * 系统文案Controller
 * @author 王铸
 * @version 2016-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/bscAgreement")
public class BscAgreementController extends BaseController {

	@Autowired
	private BscAgreementService bscAgreementService;
	
	@ModelAttribute("bscAgreement")
	public BscAgreement get(@RequestParam(required=false) String id) {
		BscAgreement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bscAgreementService.get(id);
		}
		if (entity == null){
			entity = new BscAgreement();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:bscAgreement:view")
	@RequestMapping(value = {"list", ""})
	public String list(BscAgreement bscAgreement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BscAgreement> page = bscAgreementService.findPage(new Page<BscAgreement>(request, response), bscAgreement); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/bscAgreementList";
	}

	@RequiresPermissions("wlpt:base:bscAgreement:view")
	@RequestMapping(value = "form")
	public String form(@ModelAttribute("bscAgreement") BscAgreement bscAgreement, Model model) {
		model.addAttribute("bscAgreement", bscAgreement);
		return "modules/wlpt/base/bscAgreementForm";
	}

	@RequiresPermissions("wlpt:base:bscAgreement:edit")
	@RequestMapping(value = "save")
	public String save(BscAgreement bscAgreement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bscAgreement)){
			return form(bscAgreement, model);
		}
		if (bscAgreement.getIsNewRecord()){
			bscAgreement.setAgreementId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
			bscAgreement.setCreatetime(new Date());
			bscAgreement.setUpdatetime(new Date());
		}else{
			bscAgreement.setUpdatetime(new Date());
		}
		bscAgreement.setContent(Jsoup.parse(bscAgreement.getContent()).text());
		bscAgreementService.save(bscAgreement);
		addMessage(redirectAttributes, DataDic.SAVE_AGREEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscAgreement/?repage";
	}
	
	@RequiresPermissions("wlpt:base:bscAgreement:edit")
	@RequestMapping(value = "delete")
	public String delete(@ModelAttribute("bscAgreement") BscAgreement bscAgreement, RedirectAttributes redirectAttributes) {
		bscAgreementService.delete(bscAgreement);
		addMessage(redirectAttributes, DataDic.DELETE_AGREEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscAgreement/?repage";
	}
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:bscAgreement:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(@RequestParam(required=false) String DATA_IDS,RedirectAttributes redirectAttributes) {
		StringBuilder sb=new StringBuilder();
		String ArrayDATA_IDS[] = DATA_IDS.split(",");
		sb.append("('");
		for (String item : ArrayDATA_IDS) {
			sb.append(item + "','");
		}
		String delteArrayStr = sb.substring(0, sb.lastIndexOf("','"))
				+ "')";
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("delteArrayStr", delteArrayStr);
		bscAgreementService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_AGREEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscAgreement/?repage";
	}
}