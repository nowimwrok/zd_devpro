/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.bid;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 竞标信息Controller
 * @author 刘欣
 * @version 2016-08-03
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bid/biddinginfo")
public class BiddinginfoController extends BaseController {

	@Autowired
	private BiddinginfoService biddinginfoService;
	
	@ModelAttribute
	public Biddinginfo get(@RequestParam(required=false) String id) {
		Biddinginfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = biddinginfoService.get(id);
		}
		if (entity == null){
			entity = new Biddinginfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:bid:biddinginfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(Biddinginfo biddinginfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Biddinginfo> page = biddinginfoService.findPage(new Page<Biddinginfo>(request, response), biddinginfo);
		model.addAttribute("page", page);
		return "modules/wlpt/bid/biddinginfoList";
	}

	@RequiresPermissions("wlpt:bid:biddinginfo:view")
	@RequestMapping(value = "form")
	public String form(Biddinginfo biddinginfo, Model model) {
		model.addAttribute("biddinginfo", biddinginfo);
		return "modules/wlpt/bid/biddinginfoForm";
	}

	@RequiresPermissions("wlpt:bid:biddinginfo:edit")
	@RequestMapping(value = "save")
	public String save(Biddinginfo biddinginfo, Model model, RedirectAttributes redirectAttributes) {
		biddinginfoService.save(biddinginfo);
		addMessage(redirectAttributes, "需要认证后才能竞标");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/biddinginfo/?repage";
	}
	
	@RequiresPermissions("wlpt:bid:biddinginfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Biddinginfo biddinginfo, RedirectAttributes redirectAttributes) {
		biddinginfoService.delete(biddinginfo);
		addMessage(redirectAttributes, "删除竞标信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/biddinginfo/?repage";
	}

}