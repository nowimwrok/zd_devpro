/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.goods;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
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
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;

/**
 * 货源管理数据Controller
 * @author 饶江龙
 * @version 2016-07-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/goods")
public class GoodsController extends BaseController {

	@Autowired
	private GoodsService goodsService;
	
	@ModelAttribute
	public Goods get(@RequestParam(required=false) String id) {
		Goods entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = goodsService.get(id);
		}
		if (entity == null){
			entity = new Goods();
		}
		return entity;
	}

	/***
	 * 去货源大厅
	 * @param goods  查询对象
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequestMapping(value = {"goodsHall", ""})
	public String goodsHall(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {

		Page<Goods> page = goodsService.findPage(new Page<Goods>(request, response), goods);
		model.addAttribute("page", page);
		return "modules/wlpt/goods/goodsHallList";
	}

	@RequestMapping(value = {"goods_list", ""})
	public String list(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		////当前登录用户
		//goods.setUser(UserUtils.getUser());
		Page<Goods> page = goodsService.findPage(new Page<Goods>(request, response), goods);
		model.addAttribute("page", page);
		return "modules/wlpt/goods/goodsList";
	}

	@RequestMapping(value = "form")
	public String form(Goods goods, Model model) {
		model.addAttribute("goods", goods);
		model.addAttribute("shipAddress",UserUtils.getUserSendAddress());
		model.addAttribute("consignList",UserUtils.getUserRevAddress());
		return "modules/wlpt/goods/goodsForm";
	}

	@RequestMapping(value = "save")
	public String save(Goods goods, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, goods)){
			return form(goods, model);
		}
		///如果用户信息为空,则是当前用户
		if (goods.getUser()==null){
			goods.setUser(UserUtils.getUser());
		}
		goodsService.save(goods);
		addMessage(redirectAttributes, "保存货源成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/goods/goods_list?repage";
	}
	
	@RequestMapping(value = "delete")
	public String delete(Goods goods, RedirectAttributes redirectAttributes) {
		goodsService.delete(goods);
		addMessage(redirectAttributes, "删除货源成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/goods/goods_list?repage";
	}
	
	
	
	/**
	 * 去货源统计
	 * @param goods
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"goodsStatisticsList", ""})
	public String goodsStatisticsList(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Page<Goods> page = goodsService.findSumGoodsList(new Page<Goods>(request, response), goods);
		model.addAttribute("page", page);
		return "modules/wlpt/goods/goods_statisticsList";
	}
	
	/**
	 * 货源数据统计导出
	 * @param goods
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "goodsStatisticsExport", method = RequestMethod.POST)
	public String goodsStatisticsExport( Goods goods,  HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "货源数据统计 ";
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Goods> page = goodsService.findSumGoodsList(new Page<Goods>(request, response), goods); 
			new ExportExcel(title + "信息数据", Goods.class).setDataList(page.getList()).write(response, fileName).dispose();

			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出货源数据统计信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:"+Global.getAdminPath()+"/wlpt/goods/?repage";
	}

}