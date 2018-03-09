/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseAdvertisement;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseAdvertisementService;

/**
 * base_advertisementController
 * @author 王铸
 * @version 2016-08-06
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/baseAdvertisement")
public class BaseAdvertisementController extends BaseController {

	@Autowired
	private BaseAdvertisementService baseAdvertisementService;
	
	@ModelAttribute("baseAdvertisement")
	public BaseAdvertisement get(@RequestParam(required=false) String id) {
		BaseAdvertisement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseAdvertisementService.get(id);
		}
		if (entity == null){
			entity = new BaseAdvertisement();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:baseAdvertisement:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseAdvertisement baseAdvertisement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseAdvertisement> page = baseAdvertisementService.findPage(new Page<BaseAdvertisement>(request, response), baseAdvertisement); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/baseAdvertisementList";
	}

	@RequiresPermissions("wlpt:base:baseAdvertisement:view")
	@RequestMapping(value = "form")
	public String form(@ModelAttribute("baseAdvertisement") BaseAdvertisement baseAdvertisement, Model model) {
		model.addAttribute("baseAdvertisement", baseAdvertisement);
		return "modules/wlpt/base/baseAdvertisementForm";
	}

	@RequiresPermissions("wlpt:base:baseAdvertisement:edit")
	@RequestMapping(value = "save")
	public String save(BaseAdvertisement baseAdvertisement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseAdvertisement)){
			return form(baseAdvertisement, model);
		}
		if (baseAdvertisement.getIsNewRecord()){
			User user=UserUtils.getUser();
			String name=user.getLoginName();
//			String picture=baseAdvertisement.getPicture();
//			String[] pictures=picture.split("\\/");
//			int len= pictures.length;
//			picture= pictures[len-3]+"/"+pictures[len-2]+"/"+pictures[len-1];
//			baseAdvertisement.setPicture(picture);
			baseAdvertisement.setAdvertisementId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
			baseAdvertisement.setUploader(name);
			baseAdvertisement.setUploadtime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		}
		baseAdvertisementService.save(baseAdvertisement);
		addMessage(redirectAttributes, DataDic.SAVE_ADVERTISEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseAdvertisement/?repage";
	}
	
	@RequiresPermissions("wlpt:base:baseAdvertisement:edit")
	@RequestMapping(value = "delete")
	public String delete(@ModelAttribute("baseAdvertisement") BaseAdvertisement baseAdvertisement, RedirectAttributes redirectAttributes) {
		baseAdvertisementService.delete(baseAdvertisement);
		addMessage(redirectAttributes, DataDic.DELETE_ADVERTISEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseAdvertisement/?repage";
	}
	
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:baseAdvertisement:edit")
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
		baseAdvertisementService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_ADVERTISEMENT_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseAdvertisement/?repage";
	}

}