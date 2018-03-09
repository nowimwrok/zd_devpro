/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.freightrate;

import java.util.Date;
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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;

/**
 * 线路Controller
 * @author 曾煜佳
 * @version 2016-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/freightrate/freightrateLine")
public class FreightrateLineController extends BaseController {

	@Autowired
	private FreightrateLineService freightrateLineService;
	
	@ModelAttribute
	public FreightrateLine get(@RequestParam(required=false) String id) {
		FreightrateLine entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = freightrateLineService.get(id);
		}
		if (entity == null){
			entity = new FreightrateLine();
		}
		return entity;
	}
	
	/**
	 * 线路运价列表
	 * @param freightrateLine
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightrateLine:view")
	@RequestMapping(value = {"list", ""})
	public String list(FreightrateLine freightrateLine, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FreightrateLine> page = freightrateLineService.findPage(new Page<FreightrateLine>(request, response), freightrateLine); 
		model.addAttribute("page", page);
		return "modules/wlpt/freightrate/freightrateLineList";
	}

	/**
	 * 前往编辑线路信息页面
	 * @param freightrateLine
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightrateLine:view")
	@RequestMapping(value = "form")
	public String form(FreightrateLine freightrateLine, Model model) {
		model.addAttribute("freightrateLine", freightrateLine);
		return "modules/wlpt/freightrate/freightrateLineForm";
	}

	/**
	 * 保存线路信息
	 * @param freightrateLine
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightrateLine:edit")
	@RequestMapping(value = "save")
	public String save(FreightrateLine freightrateLine, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, freightrateLine)){
			return form(freightrateLine, model);
		}
		//判断当前线路是添加或是修改
		if(Tools.IsNullOrWhiteSpace(freightrateLine.getFrlineId())){
			freightrateLine.setFrlineId(IdGen.uuid());
			freightrateLine.setIsNewRecord(true);
			freightrateLine.setUpdatetime(new Date());
			freightrateLine.setCreatetime(new Date());
		}else {
			freightrateLine.setUpdateDate(new Date());
		}
		//保存线路信息
		freightrateLineService.save(freightrateLine);
		addMessage(redirectAttributes, "保存线路运价成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/freightrate/freightrateLine/?repage";
	}
	
	/**
	 * 删除线路信息
	 * @param freightrateLine
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightrateLine:edit")
	@RequestMapping(value = "delete")
	public String delete(FreightrateLine freightrateLine, RedirectAttributes redirectAttributes) {
		freightrateLineService.delete(freightrateLine);
		addMessage(redirectAttributes, "删除线路运价成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/freightrate/freightrateLine/?repage";
	}

}