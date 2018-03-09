package com.thinkgem.jeesite.modules.weixin.controller.goods;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz.GoodsBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz.QualityCertifyBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;

/**
 * 我的货源Controller
 *
 * @author
 * @version 2016-08-24
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/goodssource")
public class GoodsSourceWeiXinController extends BaseController {
	@Autowired
	private GoodsBiz goodsBiz;

	@Autowired
	private CarBiz carBiz;

	@Autowired
	private DriverBiz driverBiz;

	@Autowired
	private QualityCertifyBiz qualityCertifyBiz;
	@RequestMapping(value = { "goods_list", "" })
	public String goods_list(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/wx_front/goodsSource/goods_list";
	}

	/***
	 * 获取信息大厅货源列表
	 *
	 * @param goods
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getHallGoodsList")
	public Object getHallGoodsList(Goods goods, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		Page<Goods> page = goodsBiz.findPage(pg, goods);
		for (Goods gds : page.getList()) {
			gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
			gds.getUser().setPointlevle(gds.getUser().getUserinfo().getPointlevle());
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 去货源详情 --抢单
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "toGoodsQuote")
	public String toGoodsQuote(@RequestParam(required = false) String id, Model model) {
		Goods gs = goodsBiz.get(id);// 货源详情
		Attach attach = new Attach();
		attach.setUser(UserUtils.getUser());
		attach.setIsagree(DataDic.ATTACH_AGGREE);
		List<Attach> list = driverBiz.findList(attach);// 司机列表
		goodsBiz.updatePageViews(gs);/// 更新浏览次数
		model.addAttribute("driver", list);
		List<Car> cars = new ArrayList<>();
		for(Car car:carBiz.getMyCar()){
			if(car.getStatus().equals(DataDic.AUTHENSUCCES))
				cars.add(car);
		}
		model.addAttribute("car", cars);// 获取用户车辆
		model.addAttribute("goods", gs);
		return "modules/wx_front/goodsSource/goodsSource_detail";
	}

	/***
	 * 保存报价
	 *
	 * @param quoteinfo
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveQuote")
	public Object saveQuote(Quoteinfo quoteinfo, Model model) {
		/// 当前用户是报价用户
		quoteinfo.setUser(UserUtils.getUser());
		int vaiStatus = validQuote(quoteinfo.getGoods().getId());
		if (vaiStatus != 1) {
			String message = "报价信息有误";
			switch (vaiStatus) {
			case -1:
				message = "货源信息有误";
				break;
			case 0:
				message = "请登录后报价";
				break;
			case 2:
				message = "内部货源信息,无法报价";
				break;
			case 3:
				message = "已报价,请勿重复报价";
				break;
			case 4:
				message = "货物已运完";
				break;
			}
			return new JSONPObject("callback", message);
		}
		float oodweight = StringUtils.toFloat(quoteinfo.getOddloadweight());
		Goods goods = goodsBiz.get(quoteinfo.getGoods().getId());
		float reweight = StringUtils.toFloat(goods.getResidualvolume());
		if (oodweight - reweight > 0) {
			return new JSONPObject("callback", "剩余吨位不足");
		}
		/// 货源报价中
		goods.setTradestatus(DataDic.GDS_QUOTING);
		goodsBiz.save(goods);
		/// 更新货源报价次数
		goodsBiz.updateQuoteCount(goods);
		goodsBiz.saveQuote(quoteinfo);
		 //统计报价次数
        UserStatistics statistics = new UserStatistics();
        statistics.setQuotecount("1");
        UserUtils.userDataSourceCount(statistics);	
		return new JSONPObject("callback", "报价成功");
	}

	/**
	 * 验证当前用户是否已报价
	 *
	 * @param goodsid
	 *            货源ID
	 * @return status:-1货源信息有误,0:用户请先登录1:正常可以报价2:内部信息3:已报价4:已运输完
	 */
	@ResponseBody
	@RequestMapping(value = "validQuote")
	public Integer validQuote(String goodsid) {
		Integer status = 1;
		Quoteinfo quoteinfo = new Quoteinfo();
		/// 获取货源信息
		Goods goods = goodsBiz.get(goodsid);
		if (goods == null) {
			return -1;
		}
		/// 是否已报价完
		if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
			return 4;
		}
		if (UserUtils.getUser() == null) {
			return 0;
		}

		String gdsuid = goods.getUser().getId();
		quoteinfo.setGoods(goods);
		quoteinfo.setUser(UserUtils.getUser());
		//// 是否是内部货源
		if (gdsuid.equals(UserUtils.getUser().getId())) {
			status = 2;
		}
		/// 报价状态为0;如果报价中的状态,则不能报价
		quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTING);
		/// 是否已报价
		List<Quoteinfo> result = goodsBiz.findQuoteList(quoteinfo);
		if (result != null && result.size() > 0) {
			status = 3;
		}
		return status;
	}

	/***
	 * 获取货源列表
	 *
	 * @param goods
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getGoodsList")
	public Object getGoodsList(Goods goods, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		//
		//// 获取当前用户
		goods.setUser(UserUtils.getUser());
		Page<Goods> page = goodsBiz.findPage(pg, goods);
		for (Goods gds : page.getList()) {
			gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 货主查看货源报价
	 *
	 * @param id 貨源
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "goodsSource_quote")
	public String goodsSource_quote(@RequestParam(required = false) String id, Model model) {
		Goods gs = goodsBiz.get(id);
		model.addAttribute("goods", gs);	
		return "modules/wx_front/goodsSource/goodsSource_quote";
	}

	/***
	 * 获取司机报价
	 * 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getQuote")
	public Object getQuote(Goods goods, int pageNo, int pageSize, Model model) {
		Page pg = new Page();
		pg.setPageNo(pageNo);
		pg.setPageSize(pageSize);
		Quoteinfo quote = new Quoteinfo();
		quote.setGoods(goods);
		Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quote);
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 获取交易的信息
	 * 
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "dataTradeQuote")
	public Object dataTradeQuote(Goods goods, Model model) {
		Page pg = new Page();
		Quoteinfo quote = new Quoteinfo();
		quote.setQuotestatus(DataDic.GDS_FULLQUOTE);
		quote.setGoods(goods);
		Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quote);
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 货主发布货源
	 *
	 * @param goods
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "goodsSource_add")
	public String goodsSource_add(Goods goods, Model model) {
		User user = UserUtils.getByCondition(UserUtils.getUser());
		goods = goodsBiz.get(goods.getId());
		if (goods == null) {
			goods = new Goods();
		}
		// 实例化发货地址并赋默认值
		if (goods.getShipAddress() == null) {
			Address shipAddress = new Address();
			shipAddress.setLinkman(user.getName());
			shipAddress.setLinkcompany(user.getUserinfo() != null ? user.getUserinfo().getCompanyname() : "");
			shipAddress.setLinkmobile(user.getPhone());
			goods.setShipAddress(shipAddress);
		}
		// 实例化收货地址
		if (goods.getConsignAddress() == null) {
			goods.setConsignAddress(new Address());
		}
		model.addAttribute("user", user);
		model.addAttribute("goods", goods);
		return "modules/wx_front/goodsSource/goods_add";
	}

	/***
	 * 发布货源
	 *
	 * @param goods
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "saveGoods")
	public Object save(Goods goods, Model model, RedirectAttributes redirectAttributes) {
		goods.setDatasource("0");// 设置数据来源
		goodsBiz.saveGoodsBiz(goods, UserUtils.getUser());
		return this.getMapResult(DataDic.RETURN_STATUS_NORMAL, "保存成功", goods);
	}

	// =============================================我的报价列表======================================
	/***
	 * 我的报价
	 *
	 * @param quote
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "quoteInfo_list")
	public String quoteInfo_list(Quoteinfo quoteinfo, Model model) {
		model.addAttribute("quoteinfo", quoteinfo);
		return "modules/wx_front/goodsSource/quoteinfo_list";
	}

	/**
	 * 获取我的报价列表
	 * 
	 * @param quoteinfo
	 * @param pg
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getQuoteInfoList")
	public Object getQuoteInfoList(Quoteinfo quoteinfo, Page pg, Model model) {
		quoteinfo.setUser(UserUtils.getUser());// 获取当前登录用户
		Page<Quoteinfo> page = goodsBiz.getQuoteList(pg, quoteinfo);
		for (Quoteinfo var : page.getList()) {
			var.setStatusStr((DictUtils.getDictLabel(var.getQuotestatus(), "quotestatus", "")));
		}
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
	}

	/***
	 * 我的报价详情
	 *
	 * @param 报价id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "quoteInfo_detail")
	public String quoteInfo_detail(@RequestParam(required = false) String id, Model model) {
		Quoteinfo quoteinfo = new Quoteinfo();
		quoteinfo.setId(id);
		quoteinfo = goodsBiz.getQuote(quoteinfo);
		model.addAttribute("quoteinfo", quoteinfo);
		return "modules/wx_front/goodsSource/quoteinfo_detail";
	}
}
