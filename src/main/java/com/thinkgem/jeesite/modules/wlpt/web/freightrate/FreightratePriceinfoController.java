/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.freightrate;

import java.util.Date;

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
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightrateLine;
import com.thinkgem.jeesite.modules.wlpt.entity.freightrate.FreightratePriceinfo;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightrateLineService;
import com.thinkgem.jeesite.modules.wlpt.service.freightrate.FreightratePriceinfoService;

/**
 * 历史运价Controller
 * @author 曾煜佳
 * @version 2016-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/freightrate/freightratePriceinfo")
public class FreightratePriceinfoController extends BaseController {

	@Autowired
	private FreightratePriceinfoService freightratePriceinfoService;
	
	@Autowired
	private FreightrateLineService freightrateLineService;
	
	@ModelAttribute
	public FreightratePriceinfo get(@RequestParam(required=false) String id) {
		FreightratePriceinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = freightratePriceinfoService.get(id);
		}
		if (entity == null){
			entity = new FreightratePriceinfo();
		}
		return entity;
	}
	
	/**
	 * 历史运价列表信息
	 * @param freightratePriceinfo
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightratePriceinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(FreightratePriceinfo freightratePriceinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<FreightratePriceinfo> page = freightratePriceinfoService.findPage(new Page<FreightratePriceinfo>(request, response), freightratePriceinfo); 
		model.addAttribute("page", page);
		return "modules/wlpt/freightrate/freightratePriceinfoList";
	}

	/**
	 * 前往编辑运价页面
	 * @param freightratePriceinfo
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightratePriceinfo:view")
	@RequestMapping(value = "form")
	public String form(FreightratePriceinfo freightratePriceinfo, Model model) {
		model.addAttribute("freightratePriceinfo", freightratePriceinfo);
		return "modules/wlpt/freightrate/freightratePriceinfoForm";
	}

	/**
	 * 保存最新运价信息
	 * @param freightratePriceinfo
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightratePriceinfo:edit")
	@RequestMapping(value = "save")
	public String save(FreightratePriceinfo freightratePriceinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, freightratePriceinfo)){
			return form(freightratePriceinfo, model);
		}
		//是否存在线路ID
		if(!Tools.IsNullOrWhiteSpace(freightratePriceinfo.getFrlineId())){
			//获取线路信息
			FreightrateLine line = freightrateLineService.get(freightratePriceinfo.getFrlineId());
			freightratePriceinfo.setAddress(line.getStartaddress()+"-"+line.getEndaddress());//获取起点和终点拼接为历史表的路线
			//判断当前是添加或修改
			if(Tools.IsNullOrWhiteSpace(freightratePriceinfo.getFrpriceId())){
				
				freightratePriceinfo.setFrpriceId(IdGen.uuid());
				freightratePriceinfo.setIsNewRecord(true);
				freightratePriceinfo.setUpdatetime(new Date());
				freightratePriceinfo.setCreatetime(new Date());
			}else {
				freightratePriceinfo.setUpdateDate(new Date());
			}
			
			try {
				//保存最新运价
				freightratePriceinfoService.save(freightratePriceinfo);
				//修改线路的运价ID
				freightrateLineService.saveNewPriceID(freightratePriceinfo.getFrlineId(), freightratePriceinfo.getFrpriceId());
				addMessage(redirectAttributes, "保存历史运价成功");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				addMessage(redirectAttributes, "保存历史运价失败");
				e.printStackTrace();
			}
			
		}else{
			addMessage(redirectAttributes, "保存历史运价失败");
		}
		//判断上一个页面是否是运价线路
		if(freightratePriceinfo.getPagetype().equals("line")){
			return "redirect:"+Global.getAdminPath()+"/wlpt/freightrate/freightrateLine/?repage";
		}
		
		return "redirect:"+Global.getAdminPath()+"/wlpt/freightrate/freightratePriceinfo/?repage";
	}
	
	/**
	 * 删除历史运价
	 * @param freightratePriceinfo
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("wlpt:freightrate:freightratePriceinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(FreightratePriceinfo freightratePriceinfo, RedirectAttributes redirectAttributes) {
		freightratePriceinfoService.delete(freightratePriceinfo);
		addMessage(redirectAttributes, "删除历史运价成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/freightrate/freightratePriceinfo/?repage";
	}

}