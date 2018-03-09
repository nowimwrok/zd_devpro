package com.thinkgem.jeesite.modules.wlpt.webapi.agreement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscAgreement;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscAgreementService;

/**
 * @author 王铸
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/agreement")
public class AgreementController extends BaseController {
	
	@Autowired
	private BscAgreementService bscAgreementService;
	/**
	 * 跳转到关于物流平台页面
	 * */
	@RequestMapping(value = "/wlptToolInfo")
	public String wlptToolInfo(BscAgreement bscAgreement,Model model,String index){
		BscAgreement agreement=new BscAgreement();
		List<BscAgreement> list=bscAgreementService.findList(bscAgreement);
		if(list.size()>0){
			agreement=list.get(0);
		}
		model.addAttribute("agreement", agreement);
		return "modules/wlpt_front/admin/about";
	}
	
	/**
	 * 跳转到关于我们页面
	 * */
	@RequestMapping(value = "/wlptAboutUsInfo")
	public String wlptAboutUsInfo(BscAgreement bscAgreement,Model model){
		BscAgreement agreement=new BscAgreement();
		/*List<BscAgreement> list=bscAgreementService.findList(bscAgreement);
		if(list.size()>0){
			agreement=list.get(0);
		}*/
		model.addAttribute("agreement", agreement);
		return "modules/wlpt_front/admin/wlpt_aboutus";
	}
	
	/**
	 * 跳转到协议页面
	 * */
	@RequestMapping(value = "/agreementInfo")
	public String agreementInfo(BscAgreement bscAgreement,Model model) {
		BscAgreement agreement=new BscAgreement();
		List<BscAgreement> list=bscAgreementService.findList(bscAgreement);
		if(list.size()>0){
			agreement=list.get(0);
		}
		model.addAttribute("agreement", agreement);
		return "modules/wlpt_front/admin/agreement";
	}
}
