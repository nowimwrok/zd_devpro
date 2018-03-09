
package com.thinkgem.jeesite.modules.wlpt.web.trade;

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
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;
import com.thinkgem.jeesite.modules.wlpt.service.comment.TradeCommentService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;

/**
 * 运单评价Controller
 * @author 王铸
 * @version 2016-09-24
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/tradeComment")
public class TradeCommentController extends BaseController {

	@Autowired
	private TradeCommentService tradeCommentService;
	
	@ModelAttribute
	public TradeComment get(@RequestParam(required=false) String id) {
		TradeComment entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = tradeCommentService.get(id);
		}
		if (entity == null){
			entity = new TradeComment();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:tradeComment:view")
	@RequestMapping(value = {"list", ""})
	public String list(TradeComment tradeComment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<TradeComment> page = tradeCommentService.findPage(new Page<TradeComment>(request, response), tradeComment); 
		model.addAttribute("page", page);
		return "modules/wlpt/trade/tradeCommentList";
	}

	@RequiresPermissions("wlpt:tradeComment:view")
	@RequestMapping(value = "form")
	public String form(TradeComment tradeComment, Model model) {
		model.addAttribute("tradeComment", tradeComment);
		return "modules/wlpt/tradeCommentForm";
	}

	@RequiresPermissions("wlpt:tradeComment:edit")
	@RequestMapping(value = "save")
	public String save(TradeComment tradeComment, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, tradeComment)){
			return form(tradeComment, model);
		}
		tradeCommentService.save(tradeComment);
		addMessage(redirectAttributes, "保存运单评价成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/tradeComment/?repage";
	}
	
	@RequiresPermissions("wlpt:tradeComment:edit")
	@RequestMapping(value = "delete")
	public String delete(TradeComment tradeComment, RedirectAttributes redirectAttributes) {
		tradeCommentService.delete(tradeComment);
		addMessage(redirectAttributes, "删除运单评价成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/tradeComment/?repage";
	}
	
	/**
	 * 评价导出
	 * @param tradeComment
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "commentExport", method = RequestMethod.POST)
	public String bidinfoExportFile( TradeComment tradeComment,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "评价";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<TradeComment> list=tradeCommentService.findList(tradeComment);
			new ExportExcel(title + "信息数据", TradeComment.class).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出评价信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/tradeComment/?repage";
	}

}