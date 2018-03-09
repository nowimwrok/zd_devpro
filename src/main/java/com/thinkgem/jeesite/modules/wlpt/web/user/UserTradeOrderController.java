/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserDispute;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoNewVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.OrderinfoTradeVO;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserDisputeService;

/**
 * 运单信息Controller
 * 
 * @author lijintao
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/user/userTradeOrder")
public class UserTradeOrderController extends BaseController {

	@Autowired
	private TradeBiz tradeBiz;
	@Autowired
	private OrderinfoService orderInfoService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private ConsumerecodService consumerecodService;
	@Autowired
	private UserDisputeService userDisputeService;

	@ModelAttribute
	public Orderinfo get(@RequestParam(required = false) String id) {
		Orderinfo entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = orderInfoService.get(id);
		}
		if (entity == null) {
			entity = new Orderinfo();
		}
		return entity;
	}

	@RequestMapping(value = { "list", "" })
	public String list(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Orderinfo> page = tradeBiz.findPage(new Page<Orderinfo>(request, response), orderinfo);
		for(Orderinfo order:page.getList()){
			Consumerecod consumerecod=new Consumerecod();
			consumerecod.setOrderinfo(order);
			order.setList(consumerecodService.findList(consumerecod));
			if("1".equals(order.getIsdispute())){
				UserDispute userDispute=userDisputeService.getByUserDispute(order.getId());
				if(userDispute!=null){
					order.setDisputetype(userDispute.getDisputetype());
				}
			}
		}
		model.addAttribute("page", page);
		return "modules/wlpt/user/userTradeOrderList";
	}

	/**
	 * 导出运单数据
	 *
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(Orderinfo orderinfo, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "运单信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			List<OrderinfoNewVO> varOList=orderInfoService.findOrderList(orderinfo);
//			Page<Orderinfo> page = tradeBiz.findPage(new Page<Orderinfo>(), orderinfo);
//			List<Orderinfo> varOList = page.getList();
//			List<OrderinfoTradeVO> orderinfoTradeVOs = new ArrayList<OrderinfoTradeVO>();
//			for (Orderinfo orderinfo2 : varOList) {
//				OrderinfoTradeVO accountRechargeVO = new OrderinfoTradeVO();
//				BeanUtils.copyProperties(orderinfo2, accountRechargeVO);
//				orderinfoTradeVOs.add(accountRechargeVO);
//			}
			new ExportExcel("运单信息数据", OrderinfoNewVO.class).setDataList(varOList).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/user/userTradeOrder/list?repage";
	}

	@RequestMapping(value = { "goPrint" })
	public String goPrint(HttpServletRequest request, HttpServletResponse response, Model model) {
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setId(request.getParameter("ORDER_ID"));
		Orderinfo order = orderInfoService.get(orderinfo);
		model.addAttribute("result", order);
		return "modules/wlpt/user/orderPrint";
	}

	@RequestMapping(value = "/printEdit", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public boolean printEdit(HttpServletRequest request, HttpServletResponse response) {
		String orderId = request.getParameter("ORDERNO");
		String isPrint = "1";
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setId(orderId);
		if (!"".equals(orderId)) {
			try {
				Orderinfo order = orderInfoService.get(orderinfo);
				order.setIsprint(isPrint);
				order.setIsNewRecord(false);
				orderInfoService.save(order);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return true;
		// eturn biddingInfoBiz.getbidingInfo(args);
	}

}