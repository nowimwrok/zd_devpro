/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.bid;

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

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BiddingBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 招标合同Controller
 * @author 刘欣
 * @version 2016-09-09
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bid/bidOrderinfo")
public class BidOrderinfoController extends BaseController {

	@Autowired
	private BidOrderinfoService bidOrderinfoService;
	@Autowired
	private BidBlinfoService bidBlinfoService;
	@Autowired
	private BiddingBiz biddingBiz;
	
	@ModelAttribute
	public BidOrderinfo get(@RequestParam(required=false) String id) {
		BidOrderinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bidOrderinfoService.get(id);
		}
		if (entity == null){
			entity = new BidOrderinfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:bid:bidOrderinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(BidOrderinfo bidOrderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BidOrderinfo> varList = bidOrderinfoService.datalistPage(new Page<BidOrderinfo>(request, response), bidOrderinfo); 
		/*for(BidOrderinfo bidorder:varList.getList()){
			bidorder.setBlinfoList(bidBlinfoService.findByBidId(bidorder.getContractno()));
        }*/
		model.addAttribute("varList", varList);
		return "modules/wlpt/bid/bidOrderinfoList";
	}

	@RequiresPermissions("wlpt:bid:bidOrderinfo:view")
	@RequestMapping(value = "form")
	public String form(BidOrderinfo bidOrderinfo, Model model) {
		model.addAttribute("bidOrderinfo", bidOrderinfo);
		return "modules/wlpt/bid/bidOrderinfoForm";
	}

	@RequiresPermissions("wlpt:bid:bidOrderinfo:edit")
	@RequestMapping(value = "save")
	public String save(BidOrderinfo bidOrderinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bidOrderinfo)){
			return form(bidOrderinfo, model);
		}
		bidOrderinfoService.save(bidOrderinfo);
		addMessage(redirectAttributes, "保存招标合同成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/bidOrderinfo/?repage";
	}
	
	@RequiresPermissions("wlpt:bid:bidOrderinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(BidOrderinfo bidOrderinfo, RedirectAttributes redirectAttributes) {
		bidOrderinfoService.delete(bidOrderinfo);
		addMessage(redirectAttributes, "删除招标合同成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/bidOrderinfo/?repage";
	}
	@RequestMapping(value = "bidovExport", method = RequestMethod.POST)
	public String bidovExport( BidOrderinfo bidOrderinfo,  HttpServletRequest request,
										  HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "招标 流水";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<BidOrderinfo> list = bidOrderinfoService.findBidOrderVo(bidOrderinfo);
			new ExportExcel(title + "信息数据", BidOrderinfo.class).setDataList(list).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出招标 业务信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/bidOrderinfo/?repage";
	}
	/**
	 * 招标导出
	 * @param bidOrderinfo
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "bidOrderinfoExport", method = RequestMethod.POST)
	public String bidOrderinfoExportFile( BidOrderinfo bidOrderinfo,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "招标 业务";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<BidOrderinfo> list = bidOrderinfoService.findList( bidOrderinfo);
			new ExportExcel(title + "信息数据", BidOrderinfo.class).setDataList(list).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出招标 业务信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/bidOrderinfo/?repage";
	}

	@RequiresPermissions("wlpt:bid:bidOrderinfo:edit")
	@RequestMapping(value = "biddingReturnPayBid")
	public String biddingReturnPayBid(Biddinginfo biddinginfo, RedirectAttributes redirectAttributes) {
		Map<String, Object> map=new HashMap<String,Object>();
		map = biddingBiz.biddingReturnPayBid(biddinginfo);
		addMessage(redirectAttributes, map.get("message").toString());
		return "redirect:"+Global.getAdminPath()+"/wlpt/bid/bidOrderinfo/?repage";
	}
}