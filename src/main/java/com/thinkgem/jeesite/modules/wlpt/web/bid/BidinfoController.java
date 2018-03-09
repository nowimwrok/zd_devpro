/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.bid;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 招标信息Controller
 *
 * @author 刘欣
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bid/bidinfo")
public class BidinfoController extends BaseController {

    @Autowired
    private BidinfoService bidinfoService;
    @Autowired
    private BiddinginfoService biddinginfoService;

    @ModelAttribute
    public Bidinfo get(@RequestParam(required = false) String id) {
        Bidinfo entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = bidinfoService.get(id);
        }
        if (entity == null) {
            entity = new Bidinfo();
        }
        return entity;
    }

    @RequiresPermissions("wlpt:bid:bidinfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(Bidinfo bidinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Bidinfo> varList = bidinfoService.findPage(new Page<Bidinfo>(request, response), bidinfo);
        for(Bidinfo bid:varList.getList()){
        	bid.setBiddingList(biddinginfoService.findByBidId(bid.getId()));
        }
        model.addAttribute("varList", varList);
        return "modules/wlpt/bid/bidinfoList";
    }

    @RequiresPermissions("wlpt:bid:bidinfo:view")
    @RequestMapping(value = "form")
    public String form(Bidinfo bidinfo, Model model) {
        model.addAttribute("bidinfo", bidinfo);
        return "modules/wlpt/bid/bidinfoForm";
    }

    @RequiresPermissions("wlpt:bid:bidinfo:edit")
    @RequestMapping(value = "save")
    public String save(Bidinfo bidinfo, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, bidinfo)) {
            return form(bidinfo, model);
        }
        return "redirect:" + Global.getAdminPath() + "/wlpt/bid/bidinfo/?repage";
    }

    @RequiresPermissions("wlpt:bid:bidinfo:edit")
    @RequestMapping(value = "delete")
    public String delete(Bidinfo bidinfo, RedirectAttributes redirectAttributes) {
        bidinfoService.delete(bidinfo);
        addMessage(redirectAttributes, "删除招标信息成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/bid/bidinfo/?repage";
    }

	/**
	 * 招标导出
	 * @param bidinfo
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "bidinfoExport", method = RequestMethod.POST)
	public String bidinfoExportFile( Bidinfo bidinfo,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "招标 ";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Bidinfo> page = bidinfoService.findPage(new Page<Bidinfo>(request, response), bidinfo); 
			new ExportExcel(title + "信息数据", Bidinfo.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出招标信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/wlpt/bid/bidinfo/?repage";
	}


}