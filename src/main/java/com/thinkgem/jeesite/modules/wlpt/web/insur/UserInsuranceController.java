/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.insur;

import java.util.List;

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

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsuranceInfo;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceInfoService;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;

/**
 * 保险Controller
 * @author 保险
 * @version 2016-12-19
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/userInsurance")
public class UserInsuranceController extends BaseController {

	@Autowired
	private UserInsuranceInfoService userInsuranceInfoService;
	@Autowired
	private UserInsuranceService userInsuranceService;
	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;
	
	@ModelAttribute
	public UserInsurance get(@RequestParam(required=false) String id) {
		UserInsurance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = userInsuranceService.get(id);
		}
		if (entity == null){
			entity = new UserInsurance();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:userInsurance:view")
	@RequestMapping(value = {"list", ""})
	public String list(UserInsurance userInsurance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<UserInsurance> page = userInsuranceService.findPage(new Page<UserInsurance>(request, response), userInsurance); 
		model.addAttribute("page", page);
		return "modules/wlpt/insur/userInsuranceList";
	}

	@RequiresPermissions("wlpt:userInsurance:view")
	@RequestMapping(value = "form")
	public String form(UserInsurance userInsurance, Model model) {
		UserInsuranceInfo info = new UserInsuranceInfo();
		info.setInsurance(userInsurance);
		List<UserInsuranceInfo> infoList = userInsuranceInfoService.findList(info);
		if(infoList.size()>0){
			userInsurance.setInfoList(infoList);
		}
		model.addAttribute("userInsurance", userInsurance);
		return "modules/wlpt/insur/userInsuranceForm";
	}

	@RequiresPermissions("wlpt:userInsurance:edit")
	@RequestMapping(value = "save")
	public String save(UserInsurance userInsurance, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userInsurance)){
			return form(userInsurance, model);
		}
		//userInsuranceService.save(userInsurance);
		int result=consumeRecodBiz.editInsurBiz(userInsurance);
		if(result!=1){
			addMessage(redirectAttributes, "受理保险失败");
			return form(userInsurance,model);
		}
		addMessage(redirectAttributes, "受理保险成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/userInsurance/list?repage";
	}
	
	@RequiresPermissions("wlpt:userInsurance:edit")
	@RequestMapping(value = "measuresave")
	public String measuresave(UserInsurance userInsurance, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, userInsurance)){
			return form(userInsurance, model);
		}
		//userInsuranceService.save(userInsurance);
		if(userInsurance.getInfoList()!=null && userInsurance.getInfoList().size()>0){
			userInsuranceService.insertInsuranceInfo(userInsurance);
		}
		userInsurance.setMeasurestatus(DataDic.YES);//已经测算
		int result=userInsuranceService.updateMeasuresInfo(userInsurance);

		if(result!=1){
			addMessage(redirectAttributes, "修改失败");
			return form(userInsurance,model);
		}
		addMessage(redirectAttributes, "修改成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/userInsurance/list?repage";
	}
	
	@RequiresPermissions("wlpt:userInsurance:view")
	@RequestMapping(value = "insurancemeasure")
	public String insurancemeasure(UserInsurance userInsurance, Model model) {
		model.addAttribute("userInsurance", userInsurance);
		return "modules/wlpt/insur/userInsuranceMeasure";
	}
	
	@RequiresPermissions("wlpt:userInsurance:edit")
	@RequestMapping(value = "delete")
	public String delete(UserInsurance userInsurance, RedirectAttributes redirectAttributes) {
		userInsuranceService.delete(userInsurance);
		addMessage(redirectAttributes, "删除保险成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/insur/userInsurance/?repage";
	}
	
	@RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(UserInsurance userInsurance, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
            String fileName = "保单列表数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            List<UserInsurance> list=userInsuranceService.findList(userInsurance);
    		new ExportExcel("保单列表数据", UserInsurance.class).setDataList(list).write(response, fileName).dispose();
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/wlpt/userInsurance/list?repage";
    }

}