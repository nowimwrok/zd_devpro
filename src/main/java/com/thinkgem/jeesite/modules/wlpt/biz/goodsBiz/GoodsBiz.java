/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.biz.goodsBiz;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.GoodsPushUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.MessagePushUtil;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BscMessageBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.OrderGoods;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.QuoteBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserMessage;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.OrderGoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 货源管理数据Service
 *
 * @author 饶江龙
 * @version 2016-07-25
 */
@Service
@Transactional(readOnly = true)
public class GoodsBiz extends BaseController{

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private BidBlinfoService bidBlinfoService;

    @Autowired
    private BidOrderinfoService bidOrderinfoService;

    @Autowired
    private QuoteinfoService quoteinfoService;

    @Autowired
    private OrderGoodsService orderGoodsService;

    @Autowired
    private UserBiz userBiz;

    @Autowired
    private CarService carService;

    @Autowired
	private CollectionBiz collectionBiz;

    @Autowired
    private BscMessageBiz bscMessageBiz;

    @Autowired
    private CarBiz carBiz;

    public Goods get(String id) {
        return goodsService.get(id);
    }


    /***
     * 修改货源关闭状态的联动效果
     * 1.提货单列表的列表数据为关闭状态
     * 2.如果是招标合同的招标货源,则需要修改招标货源的剩余吨位
     * 3.如果招标货源未运输完成了的需要更改状态
     * @param goods  传入goods对象
     */
    @Transactional (readOnly = false)
    public void cancelGoods(Goods goods){
        ///货源类型
        String gdsSource=goods.getDatasource();
        ////判断是否是招标合同货源
        if (DataDic.GDS_DATASORCE_BIDORDERBL.equals(gdsSource)||DataDic.GDS_DATASORCE_BIDORDER.equals(gdsSource)){
            ///运输合同关系货源表,查找该货源关联的所有合同
            OrderGoods orderGoods=new OrderGoods();
            orderGoods.setGoods(goods);
            List<OrderGoods> orderGoodsList=orderGoodsService.findList(orderGoods);
            for (OrderGoods ogd:orderGoodsList){
                String tradeStatus=ogd.getBidorder().getBidinfo().getGoods().getTradestatus();
                ///关联的该合同,此货源发布的吨位
                Double ogd_volume=Double.parseDouble(ogd.getFreightvolume());
                Double bidgd_res=Double.parseDouble(ogd.getBidorder().getBidinfo().getGoods().getResidualvolume());
                Goods upBidGd=new Goods();
                upBidGd.setId(ogd.getBidorder().getBidinfo().getGoods().getId());
                ////交易关闭后该招标货源的剩余吨位增加
                Double residual=ogd_volume+bidgd_res;
                residual= PreciseCompute.round(residual,4);
                upBidGd.setResidualvolume(residual.toString());
                ///如果货源是报价完--也就是剩余吨位为0的时候
                if (DataDic.GDS_FULLQUOTE.equals(tradeStatus)){
                    upBidGd.setTradestatus(DataDic.GDS_QUOTING);
                }
                ///修改剩余吨位
                goodsService.save(upBidGd);
                //统计关闭的货源
                UserStatistics statistics = new UserStatistics();
                statistics.setCancelgodscount("1");
                UserUtils.userDataSourceCount(statistics);
            }
        }
        ///修改提货单状态为关闭状态
        bidBlinfoService.updateCancelByGoods(goods.getId());
    }

    /***
     * 有提货单的招标合同发布的货源
     * @param user
     * @param blinfoList
     * @param goods
     * @return
     */
    @Transactional(readOnly = false)
    public Object bidBLPubGodosBiz(User user, List<BidBlinfo> blinfoList, Goods goods) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        if (user == null || blinfoList.size()<0 || goods == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "发布货源信息缺失";
        } else if (Tools.IsNullOrWhiteSpace(goods.getFreightvolume()) || goods.getShipAddress() == null || goods.getConsignAddress() == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "请选择吨位和地址";
        }
        Quoteinfo quo = new Quoteinfo();
        Goods gs=goods;//查询
        gs.setUser(user);
        List<Goods> result=goodsService.findList(gs);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "货源已经发布，请勿重新发布";
        }
        if (DataDic.RETURN_STATUS_NORMAL != state){
            return Tools.getMapResult(state,message,null);
        }

      //保存发货人信息
    	Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getShipAddress(), user);
    	if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
    		state = DataDic.RETURN_STATUS_INFOBUG;
            message = "保存发货人信息失败";
    		return Tools.getMapResult(state, message, null);
    	}
    	//保存收货人信息
    	Map<String, Object> consignmap = (Map<String, Object>)userBiz.saveAddressBiz(goods.getConsignAddress(), user);
    	if((int)consignmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
    		state = DataDic.RETURN_STATUS_INFOBUG;
            message = "保存收货人信息失败";
    		return Tools.getMapResult(state, message, null);
    	}
    	//重新赋值发货人
    	goods.setShipAddress((Address)shipmap.get("data"));
    	//重新赋值收货人
    	goods.setConsignAddress((Address)consignmap.get("data"));

        ///货源发布设置主键
        goods.preInsert();
        goods.setIsNewRecord(true);///新纪录
        Double freightVolume = 0.00;
        ///如果没有招标提货单,则是正常发布的提货单
        goods.setDatasource(DataDic.GDS_DATASORCE_BLNOMAL);
        Map<String, Double> orderMap = new HashMap<>();
        ///获取提货单列表数据
        for (BidBlinfo blinfo : blinfoList) {
            BidBlinfo bl = bidBlinfoService.get(blinfo);
            ///提货单总吨位
            freightVolume += Double.parseDouble(bl.getQuantity());
            ///合同ID
            if (bl.getBidOrder()!= null && !Tools.IsNullOrWhiteSpace(bl.getBidOrder().getId())) {
                String orderid = bl.getBidOrder().getId();
                ///获取提货单信息中的招标合同信息
                if (orderMap.get(orderid) != null) {
                    orderMap.put(orderid, orderMap.get(orderid) + Double.parseDouble(bl.getQuantity()));
                } else {
                    orderMap.put(orderid, Double.parseDouble(bl.getQuantity()));
                }
            }
            ///赋值货源
            bl.setGoods(goods);
            bl.setBlstatus(DataDic.Bl_STATUS_PUBLISH);  //改变提货单发布
            bl.setTradestatus(DataDic.BL_TRADE_STATUS_WYS);////未运输1
            bl.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);  // 竞标方仓库状态
            if(bl.getBiduser()!=null && bl.getBiddinguser()!=null && !Tools.IsNullOrWhiteSpace(bl.getBiduser().getId()) && !Tools.IsNullOrWhiteSpace(bl.getBiddinguser().getId())){
                if(bl.getBiduser().getId().equals(bl.getBiddinguser().getId())){
                    bl.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);  // 招标方仓库状态
                }
            }
            bidBlinfoService.save(bl);
        }
        ///循环获取招标合同对象数据
        for (Map.Entry<String, Double> entry : orderMap.entrySet()) {
            OrderGoods orderGoods = new OrderGoods();
            ///招标提货单发布的货源
            goods.setDatasource(DataDic.GDS_DATASORCE_BIDORDERBL);
            orderGoods.setGoods(goods);
            ///初始化招标合同对象数据
            BidOrderinfo bidorder = new BidOrderinfo();
            bidorder.setId(entry.getKey());
            ///招标合同关系表赋值合同
            orderGoods.setBidorder(bidorder);
            orderGoods.setFreightvolume(entry.getValue().toString());
            orderGoods.setFreightunit(goods.getFreightunit());
            System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
            ///获取招标合同信息
            BidOrderinfo bidOrderinfo = bidOrderinfoService.get(entry.getKey());
            /// 获取招标货源信息
            Goods bidGoods = goodsService.get(bidOrderinfo.getBidinfo().getGoods());
            ///招标货源剩余吨位
            Double bidresidual = Double.parseDouble(bidGoods.getResidualvolume());
            bidresidual = PreciseCompute.round(bidresidual, 4);
            ///修改招标货源对象
            Goods upbidgd = new Goods();
            upbidgd.setId(bidGoods.getId());
            /// 招标剩余吨位减少
            Double upresidual = bidresidual - entry.getValue();
            if (upresidual <= 0) {
                upbidgd.setTradestatus(DataDic.GDS_FULLQUOTE);
            }
            upresidual = PreciseCompute.round(upresidual, 4);
            upbidgd.setResidualvolume(upresidual.toString());
            ///修改招标货源剩余吨位
            goodsService.save(upbidgd);
            bidorder.setContractstatus(DataDic.BIDORDER_STATUS_TRADING);
            bidOrderinfoService.save(bidorder);
            orderGoodsService.save(orderGoods);
        }
        ///运输吨位
        goods.setFreightvolume(freightVolume.toString());
        goods.setResidualvolume(freightVolume.toString());

        goods.setUser(user);
        goodsService.save(goods);
        if(DataDic.YES.equals(goods.getIssend())&&!Tools.IsNullOrWhiteSpace(goods.getQuoteuserid())){
        	String quoid = IdGen.uuid();
    		quo.setId(quoid);
        	sendGoodsOwnerAddQuote(goods.getId(),goods.getExpectedprice(),goods.getFreightvolume(),goods.getQuoteuserid(),quoid);
        }

        //推送货源
        sendgoodsinfo(goods.getId());
        /*//统计发布的货源数
        UserStatistics statistics = new UserStatistics();
        statistics.setPubgodscount("1");
        UserUtils.userDataSourceCount(statistics);	*/
        return Tools.getMapResult(state,message,quo);
    }

    /***
     * 修改提货单与报价信息关系
     * @param blinfoList 提货单列表
     * @param goods_id 货源ID
     * @param freightunit  货源单位
     * @param quote_id  报价ID
     * @param isNomalGoods  是否是普通货源
     */
    @Transactional(readOnly = false)
    public void saveQuoteBlinfoBIz(List<BidBlinfo> blinfoList,String goods_id,String freightunit,String  quote_id,Boolean isNomalGoods){
        Map<String, Double> orderMap = new HashMap<>();
        Double freightVolume=0.00;
        ///报价ID
        Quoteinfo quoteinfo=new Quoteinfo();
        quoteinfo.setId(quote_id);
        //货源ID
        Goods goods=new Goods();
        goods.setId(goods_id);
        goods.setFreightunit(freightunit);
        ///获取提货单列表数据
        for (BidBlinfo blinfo : blinfoList) {
            ///报价提货单对
            QuoteBlinfo quoteBlinfo=new QuoteBlinfo();
            BidBlinfo bl = bidBlinfoService.get(blinfo);

            ///提货单总吨位
            freightVolume += Double.parseDouble(bl.getQuantity());
            ///合同ID
            if (bl.getBidOrder()!=null && !Tools.IsNullOrWhiteSpace(bl.getBidOrder().getId())) {
                String orderid = bl.getBidOrder().getId();
                ///获取提货单信息中的招标合同信息
                if (orderMap.get(orderid) != null) {
                    orderMap.put(orderid, orderMap.get(orderid) + Double.parseDouble(bl.getQuantity()));
                } else {
                    orderMap.put(orderid, Double.parseDouble(bl.getQuantity()));
                }
            }
            ///赋值货源
            bl.setGoods(goods);
            bl.setBlstatus(DataDic.Bl_STATUS_PUBLISH);  //改变提货单发布
            bl.setTradestatus(DataDic.BL_TRADE_STATUS_YYS); ///已运输
            quoteBlinfo.setBlinfo(bl);
            quoteBlinfo.setQuote(quoteinfo);
            ///保存提货单与报价ID的关系
            quoteinfoService.saveQuote_Blinfo(quoteBlinfo);
            bidBlinfoService.save(bl);
        }
        ////如果是没有提货单的成品货源选择 了提货单则执行下面的内容
        if (isNomalGoods) {
            ///循环获取招标合同对象数据
            for (Map.Entry<String, Double> entry : orderMap.entrySet()) {
                OrderGoods orderGoods = new OrderGoods();
                orderGoods.setGoods(goods);
                ///初始化招标合同对象数据
                BidOrderinfo bidorder = new BidOrderinfo();
                bidorder.setId(entry.getKey());
                ///招标合同关系表赋值合同
                orderGoods.setBidorder(bidorder);
                orderGoods.setFreightvolume(entry.getValue().toString());
                orderGoods.setFreightunit(goods.getFreightunit());
                System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
                ///获取招标合同信息
                BidOrderinfo bidOrderinfo = bidOrderinfoService.get(entry.getKey());
                /// 获取招标货源信息
                Goods bidGoods = goodsService.get(bidOrderinfo.getBidinfo().getGoods());
                ///招标货源剩余吨位
                Double bidresidual = Double.parseDouble(bidGoods.getResidualvolume());
                bidresidual = PreciseCompute.round(bidresidual, 4);
                ///修改招标货源对象
                Goods upbidgd = new Goods();
                upbidgd.setId(bidGoods.getId());
                /// 招标剩余吨位减少
                Double upresidual = bidresidual - entry.getValue();
                if (upresidual <= 0) {
                    upbidgd.setTradestatus(DataDic.GDS_FULLQUOTE);
                }
                upresidual = PreciseCompute.round(upresidual, 4);
                upbidgd.setResidualvolume(upresidual.toString());
                ///修改招标货源剩余吨位
                goodsService.save(upbidgd);
                bidorder.setContractstatus(DataDic.BIDORDER_STATUS_TRADING);
                bidOrderinfoService.save(bidorder);
                orderGoodsService.save(orderGoods);
            }
        }
    }

    public void editBidGoods(String bidOrder_id,Goods goods){

    }

    /***
     * 从招标合同发布的货源--没有提货单的招标合同
     * @param user
     * @param bidOrder_id
     * @param goods
     * @return
     */
    @Transactional(readOnly = false)
    public Object bidPubGodosBiz(User user, String bidOrder_id, Goods goods) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        if (user == null || Tools.IsNullOrWhiteSpace(bidOrder_id) || goods == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "发布货源信息缺失";
        } else if (Tools.IsNullOrWhiteSpace(goods.getFreightvolume()) || goods.getShipAddress() == null || goods.getConsignAddress() == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "请选择吨位和地址";
        }
        Quoteinfo quo = new Quoteinfo();
        Goods gs=goods;//查询
        gs.setUser(user);
        List<Goods> result=goodsService.findList(gs);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "货源已经发布，请勿重新发布";
        }
        if (DataDic.RETURN_STATUS_NORMAL == state) {

        	//保存发货人信息
        	Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getShipAddress(), user);
        	if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
        		state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存发货人信息失败";
        		return Tools.getMapResult(state, message, null);
        	}
        	//保存收货人信息
        	Map<String, Object> consignmap = (Map<String, Object>)userBiz.saveAddressBiz(goods.getConsignAddress(), user);
        	if((int)consignmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
        		state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存收货人信息失败";
        		return Tools.getMapResult(state, message, null);
        	}
        	//重新赋值发货人
        	goods.setShipAddress((Address)shipmap.get("data"));
        	//重新赋值收货人
        	goods.setConsignAddress((Address)consignmap.get("data"));

            ///获取招标合同信息
            BidOrderinfo bidOrder = bidOrderinfoService.get(bidOrder_id);
            ////获取招标货源信息
            Goods bidGoods = goodsService.get(bidOrder.getBidinfo().getGoods().getId());
            ///招标发布货源吨位
            Double bidResiduVolume = Double.parseDouble(bidGoods.getResidualvolume());
            ///合同发布货源吨位
            Double pubFreightVolume = Double.parseDouble(goods.getFreightvolume());
            ///招标发布货源剩余吨位
            Double bidResiduall = bidResiduVolume - pubFreightVolume;
            if (bidResiduall < 0 || DataDic.GDS_FULLQUOTE.equals(bidGoods.getTradestatus())) {
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "剩余吨位不足";
            } else {
                //修改招标货源对象
                Goods upBidGoods = new Goods();
                upBidGoods.setId(bidGoods.getId());
                ///如果剩余吨位==0则招标货源运输完成---修改招标
                if (bidResiduall == 0) {
                    upBidGoods.setTradestatus(DataDic.GDS_FULLQUOTE);
                }
                ///修改招标货源的剩余吨位
                upBidGoods.setResidualvolume(bidResiduall.toString());
                //如果发布货源ID是新增
                ///竞标用户发布货源
                goods.setUser(bidOrder.getBiddinguser());
                ///剩余吨位为发布吨位
                goods.setResidualvolume(goods.getFreightvolume());
                ///招标合同发布货源
                goods.setDatasource(DataDic.GDS_DATASORCE_BIDORDER);
                goods.setIsNewRecord(true);
                goods.setId(IdGen.uuid());
                goods.setDelFlag(DataDic.DEL_FLAG_NORMEL);
                OrderGoods orderGoods = new OrderGoods();
                orderGoods.setBidorder(bidOrder);
                orderGoods.setGoods(goods);

                ///修改招标货源的剩余吨位
                goodsService.save(upBidGoods);
                goodsService.save(goods);
                ///运输合同与发布的货源进行管理
                orderGoodsService.save(orderGoods);
                BidOrderinfo upBid=new BidOrderinfo();
                upBid.setId(bidOrder.getId());
                upBid.setContractstatus(DataDic.BIDORDER_STATUS_TRADING);
                bidOrderinfoService.save(upBid);
                if(DataDic.YES.equals(goods.getIssend())&&!Tools.IsNullOrWhiteSpace(goods.getQuoteuserid())){
                	String quoid = IdGen.uuid();
            		quo.setId(quoid);
                	sendGoodsOwnerAddQuote(goods.getId(),goods.getExpectedprice(),goods.getFreightvolume(),goods.getQuoteuserid(),quoid);
                }
                //推送货源
                sendgoodsinfo(goods.getId());
                /*//统计发布的货源数
                UserStatistics statistics = new UserStatistics();
                statistics.setPubgodscount("1");
                UserUtils.userDataSourceCount(statistics);	*/
            }

        }
        return Tools.getMapResult(state,message,quo);
    }

//    /***
//     * 检验用户是否报价
//     *
//     * @param goods_id 货源ID
//     * @param user     当前用户
//     * @return
//     */
//    public Object validQuote(String goods_id, User user) {
//        Integer status = 1;
//        Quoteinfo quoteinfo = new Quoteinfo();
//        ///获取货源信息
//        Goods goods = this.get(goods_id);
//        if (goods == null) {
//            status = DataDic.RETURN_STATUS_INFOBUG;
//        } else if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {///是否已报价完
//            status = DataDic.RETURN_STATUS_OVERCONTROLBUG;
//        } else if (user == null) {
//            status = DataDic.RETURN_STATUS_AUTHBUG; ///没有登录,则没权报价
//        } else if (goods.getUser().getId().equals(user.getId())) {
//            status = DataDic.RETURN_STATUS_AUTHBUG;////是否是内部货源
//        } else {
//            quoteinfo.setGoods(goods);
//            quoteinfo.setUser(user);
//
//            ///报价状态为0;如果报价中的状态,则不能报价
//            quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTING);
//            ///是否已报价
//            List<Quoteinfo> result = quoteinfoService.findList(quoteinfo);
//            if (result != null && result.size() > 0) {
//                status = DataDic.RETURN_STATUS_OVERCONTROLBUG;///已报价过
//            }
//        }
//
//        return Tools.getMapResult(status, Tools.statusMessage(status, "报价"), null);
//    }


    /***
     * 提货单货源发布
     *
     * @param goods
     * @param curUser 交易状态默认0未报价;1:已报价(开始报价),2:已报价完成(剩余吨位0)
     *                数据发布源:0:自发没有明细，1:明细发布，2:合同发布，3招标发布
     * @return
     */
    @Transactional(readOnly = false)
    public Object saveBlGoodsBiz(Goods goods, User curUser) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        if(curUser == null){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if(!userBiz.getUser().getUserinfo().getStatus().equals("2")){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        //1.判断对象是否为空
        if (goods == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "信息不完整";
        } else if (Tools.IsNullOrWhiteSpace(goods.getFreightvolume()) || Tools.IsNullOrWhiteSpace(goods.getGsoddtype())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "缺失发布信息";
        }/* else if (Tools.IsNullOrWhiteSpace(goods.getConsignAddress().getId()) || Tools.IsNullOrWhiteSpace(goods.getShipAddress().getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "请选择地址信息";
        }*/
        Quoteinfo quo = new Quoteinfo();
        Goods gs=goods;//查询
        gs.setUser(curUser);
        List<Goods> result=goodsService.findList(gs);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "货源已经发布，请勿重新发布";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            //保存发货人信息
            Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getShipAddress(), curUser);
            if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存发货人信息失败";
                return Tools.getMapResult(state, message, null);
            }
            //保存收货人信息
            Map<String, Object> consignmap = (Map<String, Object>)userBiz.saveAddressBiz(goods.getConsignAddress(), curUser);
            if((int)consignmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存收货人信息失败";
                return Tools.getMapResult(state, message, null);
            }
            //重新赋值发货人
            goods.setShipAddress((Address)shipmap.get("data"));
            //重新赋值收货人
            goods.setConsignAddress((Address)consignmap.get("data"));
            ///如果货源ID为null则是新增
            if (Tools.IsNullOrWhiteSpace(goods.getId())) {
                goods.setUser(curUser);
                ///剩余吨位为发布吨位
                goods.setResidualvolume(goods.getFreightvolume());
            }

            goodsService.save(goods);

            List<BidBlinfo> blinfoList = goods.getBlinfoList();
            for (BidBlinfo bl:blinfoList){
                ///赋值货源
                bl.setGoods(goods);
                bl.setBlstatus(DataDic.Bl_STATUS_PUBLISH);  //改变提货单发布
                bl.setTradestatus(DataDic.BL_TRADE_STATUS_WYS);
                bidBlinfoService.save(bl);
            }
            if(DataDic.YES.equals(goods.getIssend())&&!Tools.IsNullOrWhiteSpace(goods.getQuoteuserid())){
            	String quoid = IdGen.uuid();
        		quo.setId(quoid);
            	sendGoodsOwnerAddQuote(goods.getId(),goods.getExpectedprice(),goods.getFreightvolume(),goods.getQuoteuserid(),quoid);
            }
            //推送货源
            sendgoodsinfo(goods.getId());
            //保存货源消息
            saveGoodsMessage(goods.getId());
            //统计发布的货源数
            UserStatistics statistics = new UserStatistics();
            statistics.setPubgodscount("1");
            UserUtils.userDataSourceCount(statistics);
        }

        return Tools.getMapResult(state, message, quo);
    }



    /***
     * 货源发布信息
     *
     * @param goods
     * @param curUser 交易状态默认0未报价;1:已报价(开始报价),2:已报价完成(剩余吨位0)
     *                数据发布源:0:自发没有明细，1:明细发布，2:合同发布，3招标发布
     * @return
     */
    @Transactional(readOnly = false)
    public Object saveGoodsBiz(Goods goods, User curUser) {

        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if(!userBiz.getUser().getUserinfo().getStatus().equals("2")){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        //1.判断对象是否为空
        if (goods == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "信息不完整";
        } else if (Tools.IsNullOrWhiteSpace(goods.getFreightvolume()) || Tools.IsNullOrWhiteSpace(goods.getGsoddtype())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "缺失发布信息";
        }/* else if (Tools.IsNullOrWhiteSpace(goods.getConsignAddress().getId()) || Tools.IsNullOrWhiteSpace(goods.getShipAddress().getId())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "请选择地址信息";
        }*/
        Quoteinfo quo = new Quoteinfo();
        Goods gs=goods;//查询
        gs.setUser(curUser);
        List<Goods> result=goodsService.findList(gs);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "货源已经发布，请勿重新发布";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
        	//保存发货人信息
        	Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getShipAddress(), curUser);
        	if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
        		state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存发货人信息失败";
        		return Tools.getMapResult(state, message, null);
        	}
        	//保存收货人信息
        	Map<String, Object> consignmap = (Map<String, Object>)userBiz.saveAddressBiz(goods.getConsignAddress(), curUser);
        	if((int)consignmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
        		state = DataDic.RETURN_STATUS_INFOBUG;
                message = "保存收货人信息失败";
        		return Tools.getMapResult(state, message, null);
        	}
        	//重新赋值发货人
        	goods.setShipAddress((Address)shipmap.get("data"));
        	//重新赋值收货人
        	goods.setConsignAddress((Address)consignmap.get("data"));
            ///如果货源ID为null则是新增
            if (Tools.IsNullOrWhiteSpace(goods.getId())) {
                goods.setUser(curUser);
                ///剩余吨位为发布吨位
                goods.setResidualvolume(goods.getFreightvolume());
            }
            try{
            	goodsService.save(goods);

            	if(DataDic.YES.equals(goods.getIssend())&&!Tools.IsNullOrWhiteSpace(goods.getQuoteuserid())){

            		String quoid = IdGen.uuid();
            		quo.setId(quoid);
                	sendGoodsOwnerAddQuote(goods.getId(),goods.getExpectedprice(),goods.getFreightvolume(),goods.getQuoteuserid(),quoid);
                }


            }finally{
            	GoodsPushUtils.goodsPush(goods);
                saveGoodsMessage(goods.getId());
            }
            //推送货源
            sendgoodsinfo(goods.getId());
            //统计发布的货源数
            UserStatistics statistics = new UserStatistics();
            statistics.setPubgodscount("1");
            UserUtils.userDataSourceCount(statistics);
        }

        return Tools.getMapResult(state, message, quo);
    }

    @Transactional(readOnly = false)
    public void saveQuote(Quoteinfo quote){
    	quoteinfoService.save(quote);
    }
    /**
     * 报价次数更新
     *
     * @param goods
     */
    @Transactional(readOnly = false)
    public void updateQuoteCount(Goods goods) {
        goodsService.updateQuoteCount(goods);
    }

    /**
     * 更新浏览次数
     *
     * @param goods
     */
    @Transactional(readOnly = false)
    public void updatePageViews(Goods goods) {
        goodsService.updatePageViews(goods);
    }

    /**
     * 更新点击次数
     *
     * @param goods
     */
    @Transactional(readOnly = false)
    public void updatePraiseNumber(Goods goods) {
        goodsService.updatePraiseNumber(goods);
    }

    /**
     * 发布零担货源页面 获取提货单关联的招标信息数据
     *
     * @param userId
     * @param goodsId
     * @return
     */
    public Goods getBLgoodsData(String userId, String goodsId) {
        return goodsService.getBLgoodsData(userId, goodsId);
    }


    /**
     * 发布货源 编辑货源
     *
     * @param goods
     * @param ids
     * @param orderid
     * @return
     */
    @Transactional(readOnly = false)
    public Boolean saveGoodsSource(Goods goods, String ids, String orderid) {
        Boolean result = false;
        if (goods.getId() == null) {
            goods.preInsert();
            User user = UserUtils.getUser();
            goods.setUser(user);
            //货源有明细
            if (goods.getDatasource() != null) {
                String blid = ids;
                String[] strs = null;
                if (blid.indexOf(",") != -1) {
                    strs = blid.split(",");
                } else {
                    strs = new String[]{blid};
                }
                BidBlinfo bidBlinfo = new BidBlinfo();
                bidBlinfo.preUpdate();
                bidBlinfo.setBlstatus("2");
                if (goods.getDatasource().equals("")) {//货源类型设置
                    bidBlinfo.setBltype(DataDic.Bl_TYPE_BL);
                }
                //更改提货单的信息
                for (String Blid : strs) {
                    bidBlinfo.setId(Blid);
                    bidBlinfoService.save(bidBlinfo);
                }
                //更改招标合同交易状态
                if (orderid != null) {
                    BidOrderinfo bidOrderinfo = new BidOrderinfo();
                    bidOrderinfo.setId(orderid);
                    bidOrderinfo.setContractstatus("2");
                    bidOrderinfoService.save(bidOrderinfo);
                }
                goodsService.save(goods);

                //推送货源
                sendgoodsinfo(goods.getId());

                //统计发布的货源数
                UserStatistics statistics = new UserStatistics();
                statistics.setPubgodscount("1");
                UserUtils.userDataSourceCount(statistics);
            }
        } else {
            goods.preUpdate();
            goodsService.save(goods);
        }

        return result;
    }

    public Page<Quoteinfo> getQuoteList(Page<Quoteinfo> page, Quoteinfo quote) {
        return quoteinfoService.findPage(page, quote);
    }

    public Quoteinfo getQuote(Quoteinfo quote) {
        return quoteinfoService.get(quote);
    }



    public List<Goods> findList(Goods goods) {
        return goodsService.findList(goods);
    }

    public Page<Goods> findPage(Page<Goods> page, Goods goods) {
        return goodsService.findPage(page, goods);
    }

    /***
     * 保存货源
     *
     * @param goods
     */
    @Transactional(readOnly = false)
    public void save(Goods goods) {
        goodsService.save(goods);
    }

    @Transactional(readOnly = false)
    public void delete(Goods goods) {
        goodsService.delete(goods);
    }

    /**
     * 获取报价信息
     * @param quoteinfo
     * @return
     */
    public List<Quoteinfo> findQuoteList(Quoteinfo quoteinfo) {
		return quoteinfoService.findList(quoteinfo);
	}
    /**
     * 保存车主报价信息
     * @param quoteinfo
     * @return
     */
    @Transactional(readOnly = false)
    public String saveDriverQuote(Quoteinfo quoteinfo) {
    	String message="";
        ///当前用户是报价用户
    	if(Tools.IsNullOrWhiteSpace(quoteinfo.getCar().getId())||Tools.IsNullOrWhiteSpace(quoteinfo.getDriver().getId())||
    			Tools.IsNullOrWhiteSpace(quoteinfo.getOoferprice())||Tools.IsNullOrWhiteSpace(quoteinfo.getOddloadweight())){
    		return "缺少报价信息！";
    	}
    	User user=UserUtils.getUser();
    	User user1=userBiz.getUser();
    	if(user.getId()==null){
    		return "请先登录系统";
    	}
    	if(!user1.getUserinfo().getStatus().equals("2")){

            return "您还没有认证！";
        }
//    	if(!user.getRole().getEnname().equals("carowner")){
//    		return "只有车主才可以报价";
//    	}
    	if(!user.getRole().getEnname().equals("carowner")&&!user.getRole().getEnname().equals("enterprise")){
    		return "只有物流企业和车主才可以报价";
    	}
        quoteinfo.setUser(user);
        int vaiStatus = validQuote(quoteinfo.getGoods().getId());
        if (vaiStatus != 1) {
            message = "报价信息有误";
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
            return  message;
        }
        User gdsuser=goodsService.get(quoteinfo.getGoods().getId()).getUser();
        gdsuser=UserUtils.getUserBySearch(gdsuser.getLoginName());
//        if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&Tools.IsNullOrWhiteSpace(gdsuser.getMemberId())){
//    		return "暂不支持账户系统用户与非账户系统用户的交易";
//    	}
    	if(Tools.IsNullOrWhiteSpace(user.getMemberId())&&!Tools.IsNullOrWhiteSpace(gdsuser.getMemberId())){
    		UserBankinfo userBankinfo=new UserBankinfo();
        	userBankinfo.setUser(user);
        	List<UserBankinfo> userBankList=userBiz.findUserBankList(userBankinfo);
        	if(userBankList==null||userBankList.size()==0){
        		return "为了能够及时给您支付运费，请您先绑定银行卡";
        	}
    	}
        float oodweight = StringUtils.toFloat(quoteinfo.getOddloadweight());
        Goods goods = get(quoteinfo.getGoods().getId());
        float reweight = StringUtils.toFloat(goods.getResidualvolume());
        if (oodweight - reweight > 0) {
            return "剩余吨位不足";
        }
//        if (oodweight > 100) {
//            return "报价吨位不能超过100吨";
//        }
        Car car=carService.get(quoteinfo.getCar().getId());
        float loadweight=StringUtils.toFloat(car.getLoadweight());
//    	if(oodweight>loadweight){
//    		return "报价吨位不能大于车辆载重";
//    	}
        ///货源报价中
        goods.setTradestatus(DataDic.GDS_QUOTING);
        save(goods);
        ///更新货源报价次数
        updateQuoteCount(goods);
        quoteinfo.setActload(oodweight+"");
        quoteinfoService.save(quoteinfo);
        //统计报价次数
        UserStatistics statistics = new UserStatistics();
        statistics.setQuotecount("1");
        UserUtils.userDataSourceCount(statistics);
        return "报价成功";
    }



   /**
    * 保存车主报价信息
    * @param quoteinfo
    * @param userid
    * @return
    */
    @Transactional(readOnly = false)
    public String saveGoodsOwnerAddQuote(Quoteinfo quoteinfo,String userid) {
    	String message="";
        ///当前用户是报价用户
    	if(Tools.IsNullOrWhiteSpace(quoteinfo.getCar().getId())||Tools.IsNullOrWhiteSpace(quoteinfo.getDriver().getId())||
    			Tools.IsNullOrWhiteSpace(quoteinfo.getOoferprice())||Tools.IsNullOrWhiteSpace(quoteinfo.getOddloadweight())||
    			Tools.IsNullOrWhiteSpace(userid)){
    		return "缺少报价信息！";
    	}
    	User user=UserUtils.getUserById(userid);
    	if(user==null){
    		return "用户不存在";
    	}
    	if(!user.getRole().getEnname().equals("carowner")&&!user.getRole().getEnname().equals("enterprise")){
    		return "只能为物流企业或车主添加报价";
    	}
        quoteinfo.setUser(user);
        int vaiStatus = validQuoteByUser(quoteinfo.getGoods().getId(),user);
        if (vaiStatus != 1) {
            message = "报价信息有误";
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
            return  message;
        }
        float oodweight = StringUtils.toFloat(quoteinfo.getOddloadweight());
        Goods goods = get(quoteinfo.getGoods().getId());
        float reweight = StringUtils.toFloat(goods.getResidualvolume());
        if (oodweight - reweight > 0) {
            return "剩余吨位不足";
        }
        Car car=carService.get(quoteinfo.getCar().getId());
        float loadweight=StringUtils.toFloat(car.getLoadweight());

        ///货源报价中
        goods.setTradestatus(DataDic.GDS_QUOTING);
        save(goods);
        ///更新货源报价次数
        updateQuoteCount(goods);
        quoteinfo.setActload(oodweight+"");
        quoteinfoService.save(quoteinfo);
        //统计报价次数
        UserStatistics statistics = new UserStatistics();
        statistics.setUser(user);
        statistics.setQuotecount("1");
        UserUtils.userDataSourceCount(statistics);
        return "报价成功";
    }

    /**
     * 添加报价
     * @param quoteinfo
     * @param userid
     * @return
     */
    @Transactional(readOnly = false)
    public Object addquoteBiz(Quoteinfo quoteinfo , String userid) {
    	int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";

      ///当前用户是报价用户
    	if(Tools.IsNullOrWhiteSpace(quoteinfo.getOoferprice())||Tools.IsNullOrWhiteSpace(quoteinfo.getOddloadweight())||
    			Tools.IsNullOrWhiteSpace(userid)){
    		message = "缺少报价信息！";
    		state = DataDic.RETURN_STATUS_INFOBUG;
    		return Tools.getMapResult(state, message,null);
    	}
        String quoid = IdGen.uuid();
        quoteinfo.setId(quoid);
        message = sendGoodsOwnerAddQuote(quoteinfo.getGoods().getId(),quoteinfo.getOoferprice(), quoteinfo.getOddloadweight(),userid,quoid);
		if(!message.equals("报价成功")){
			state = DataDic.RETURN_STATUS_OVERCONTROLBUG;
			return Tools.getMapResult(state, message,null);
		}
        return Tools.getMapResult(state, message, quoteinfo);
    }

    /**
     * 保存货主添加报价信息
     * @param gid
     * @param ooferprice
     * @param oddloadweight
     * @param userid
     * @return
     */
     @Transactional(readOnly = false)
     public String sendGoodsOwnerAddQuote(String gid,String ooferprice, String oddloadweight,String userid,String quoid) {


     	 String message="";
         ///当前用户是报价用户
     	 if(Tools.IsNullOrWhiteSpace(ooferprice)||Tools.IsNullOrWhiteSpace(oddloadweight)||
     			Tools.IsNullOrWhiteSpace(userid)){
     		return "缺少报价信息！";
     	 }
     	 User user=UserUtils.getUserById(userid);
     	 if(user==null){
     		 return "用户不存在";
     	 }
     	 if(!user.getRole().getEnname().equals("carowner")&&!user.getRole().getEnname().equals("enterprise")){
     	 	return "只能为物流企业或车主添加报价";
     	 }
     	 Quoteinfo quoteinfo = new Quoteinfo();
     	 quoteinfo.setOoferprice(ooferprice);
     	 quoteinfo.setOddloadweight(oddloadweight);
     	 Goods goods = get(gid);
     	 quoteinfo.setGoods(goods);
         quoteinfo.setUser(user);
         int vaiStatus = validQuoteByUser(quoteinfo.getGoods().getId(),user);
         if (vaiStatus != 1) {
             message = "报价信息有误";
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
             return  message;
         }
         float oodweight = StringUtils.toFloat(quoteinfo.getOddloadweight());

         float reweight = StringUtils.toFloat(goods.getResidualvolume());
         if (oodweight - reweight > 0) {
             return "剩余吨位不足";
         }
         /*Car car=carService.get(quoteinfo.getCar().getId());
         float loadweight=StringUtils.toFloat(car.getLoadweight());*/

         ///货源报价中
         goods.setTradestatus(DataDic.GDS_QUOTING);
         save(goods);
         ///更新货源报价次数
         updateQuoteCount(goods);
         quoteinfo.setActload(oodweight+"");
         quoteinfo.setIsassign(DataDic.YES);
         quoteinfo.setIsNewRecord(true);
         quoteinfo.setId(quoid);
         quoteinfoService.save(quoteinfo);
         //统计报价次数
         UserStatistics statistics = new UserStatistics();
         statistics.setUser(user);
         statistics.setQuotecount("1");
         UserUtils.userDataSourceCount(statistics);
         return "报价成功";
     }

     /**
      * 保存货主添加报价信息
      * @param quoteinfo
      * @return
      */
      @Transactional(readOnly = false)
      public int updateQuoteinfo(Quoteinfo quoteinfo) {

    	  String message="";
    	  ///当前用户是报价用户
      	  if(Tools.IsNullOrWhiteSpace(quoteinfo.getCar().getId())||Tools.IsNullOrWhiteSpace(quoteinfo.getDriver().getId())||
      			Tools.IsNullOrWhiteSpace(quoteinfo.getId())){
      		  return DataDic.RETURN_STATUS_INFOBUG;
      	  }

          quoteinfoService.save(quoteinfo);
          return DataDic.RETURN_STATUS_NORMAL;
      }

    /***
     * 货主指派报价 检验用户是否报价
     *
     * @param goodsid 货源ID
     * @return
     */
     public Integer validQuoteByUser(String goodsid,User user) {
         Integer status = 1;
         Quoteinfo quoteinfo = new Quoteinfo();
         ///获取货源信息
         Goods goods = get(goodsid);
         if (goods == null) {
             return -1;
         }

         if (user == null) {
             return 0;
         }
         ///是否已报价完
         if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
             return 4;
         }

         String gdsuid = goods.getUser().getId();
         quoteinfo.setGoods(goods);
         quoteinfo.setUser(user);
         ////是否是内部货源
         if (gdsuid.equals(user.getId())) {
             status = 2;
         }
         ///报价状态为0;如果报价中的状态,则不能报价
         quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTING);
         ///是否已报价
         List<Quoteinfo> result = quoteinfoService.findList(quoteinfo);
         if (result != null && result.size() > 0) {
             status = 3;
         }
         return status;
     }
    /***
    * 检验用户是否报价
    *
    * @param goodsid 货源ID
    * @return
    */
    public Integer validQuote(String goodsid) {
        Integer status = 1;
        Quoteinfo quoteinfo = new Quoteinfo();
        ///获取货源信息
        Goods goods = get(goodsid);
        if (goods == null) {
            return -1;
        }

        if (UserUtils.getUser().getId() == null) {
            return 0;
        }
        ///是否已报价完
        if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())) {
            return 4;
        }

		if(goods.getSendtime().before(new Date())){
			return 4;
		}

        String gdsuid = goods.getUser().getId();
        quoteinfo.setGoods(goods);
        quoteinfo.setUser(UserUtils.getUser());
        ////是否是内部货源
        if (gdsuid.equals(UserUtils.getUser().getId())) {
            status = 2;
        }
        ///报价状态为0;如果报价中的状态,则不能报价
        quoteinfo.setQuotestatus(DataDic.QUOTE_QUOTING);
        ///是否已报价
        List<Quoteinfo> result = quoteinfoService.findList(quoteinfo);
        if (result != null && result.size() > 0) {
            status = 3;
        }
        return status;
    }

    public void sendgoodsinfo(String id){
    	new Thread(){
            public void run(){
            	///获取货源信息
                Goods goods = get(id);
                if(goods!=null){
                	String url = getOauthUrl(ConstantWeChat.SERVICE_URLS+ "goodssource/toGoodsQuote?id=" + goods.getId(), "UTF-8", ConstantWeChat.SCOPE_SNSAPI_USERINFO);
                    String addressStart = goods.getShipAddress().getProvince() + goods.getShipAddress().getCity() + goods.getShipAddress().getDistrict();    //起点
                	String addressEnd = goods.getConsignAddress().getProvince() + goods.getConsignAddress().getCity() + goods.getConsignAddress().getDistrict();   ///终点
                	String unit = StringUtils.isNoneBlank(goods.getFreightunit())?goods.getFreightunit():"吨";
                    String[] keyword = {"货源", goods.getGoodsname(),goods.getFreightvolume() + unit,addressStart+"/"+addressEnd,Tools.date2Str(goods.getSendtime(),"yyyy-MM-dd"),Tools.date2Str(goods.getCreateDate(),"yyyy-MM-dd"), Global.LINK_TEL};
                    sendallUser(keyword,url,goods.getShipAddress().getCity(),goods.getConsignAddress().getCity());//推送
                }

           }
        }.start();
    }

    /**
     * 推送发布的货源给关注的用户
     * @param keyword
     * @param url
     */
 	public void sendallUser( String[] keyword, String url,String fromcity,String tocity ) {
 		try {
 			WlptCollection wlptCollection = new WlptCollection();
 			//获取关注货源条数
 			wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_GOODS);
 			wlptCollection.setFromcity(fromcity);
 			wlptCollection.setTocity(tocity);

 			List<WlptCollection> list = collectionBiz.findList(wlptCollection);
 			if(list.size()>0){
 				for (WlptCollection collec : list) {
 					if(collec!=null){
 						String openId = collec.getOpenid();
 						if(StringUtils.isNoneBlank(openId)){
 							//发送推送
 							SmsUtil.sendSmsMesge(openId, DataDic.SMSCODE_DELIVERGOODS, null, Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, ConstantWeChat.PUB_GOODS, url, false, SmsConfig.smsGoodsEnd);
 						}
 					}
 				}
 			}

 		} catch (Exception e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 	}

    /**
     * 保存货源消息
     * @param id
     */
    @Transactional(readOnly = false)
    public void saveGoodsMessage(String id){
        Goods goods = get(id);
        if(goods!=null){
            String addressStart = goods.getShipAddress().getProvince() + goods.getShipAddress().getCity() + goods.getShipAddress().getDistrict();    //起点
            String addressEnd = goods.getConsignAddress().getProvince() + goods.getConsignAddress().getCity() + goods.getConsignAddress().getDistrict();   ///终点
            String goodsName=goods.getGoodsname()+goods.getFreightvolume()+goods.getFreightunit();
            String summary=addressStart+"到"+addressEnd+"有新的货源,"+goodsName;
            BscMessage message=new BscMessage();
            message.setTtile(DataDic.MESSAGE_TYPE_NEWGOODS);
            message.setContent(summary);
            message.setSummary(summary);
            message.setContenttype(DataDic.MESSAGE_CONTENTTYPE_KEFU);
            message.setStatus(DataDic.MESSAGE_STATUS_NO);
            message.setSourceid(goods.getId());
            message.setSendtype(DataDic.MESSAGE_SENDTYPE_USER);
            message.setSourcetype(DataDic.MESSAGE_SOURCETYPE_SOURCEGOODS);
            message.setScantype(DataDic.MESSAGE_SCANTYPE_ANDROID);
            message.setUser(goods.getUser());
            bscMessageBiz.save(message);//保存消息
        }
    }

    /**
     * 推送货源消息
     */
    @Transactional(readOnly = false)
    public void GoodsMessagePush() {

            BscMessage bscMessage=new BscMessage();
            bscMessage.setStatus(DataDic.MESSAGE_IS_READ_NO);
            List<BscMessage> bscMessageList= bscMessageBiz.findAllList(bscMessage);//查询未推送的消息数据

            for (BscMessage bscMessages : bscMessageList) {

                String goodsId= bscMessages.getSourceid();//货源id
                Goods goods = get(goodsId);
                if(goods!=null){//数据存在
                    Car car=new Car();
                    car.setFromcity(goods.getShipAddress().getCity());
                    car.setTocity(goods.getConsignAddress().getCity());
                    List<Car> list =carBiz.findAllList(car);//主营线路相同,对应的用户
                    for (Car cars : list) {
                        GoodsPush(bscMessages,cars.getUser());//推送
                    }

                    WlptCollection wlptCollection = new WlptCollection();
                    wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_GOODS);
                    wlptCollection.setFromcity(goods.getShipAddress().getCity());
                    wlptCollection.setTocity(goods.getConsignAddress().getCity());
                    List<WlptCollection> lists = collectionBiz.findList(wlptCollection);//获取关注货源条数
                    for (WlptCollection collection : lists) {
                        GoodsPush(bscMessages,collection.getUser());//推送关注线路相同的用户
                    }

                    BscMessage bscMessage1=new BscMessage();
                    bscMessage1.setId(bscMessages.getId());
                    bscMessage1.setStatus(DataDic.MESSAGE_STATUS_YES);
                    bscMessage1.setIsNewRecord(false);
                    bscMessageBiz.save(bscMessage1);//消息已推送状态保存
                }
            }

    }

    /**
     * 推送货源消息到指定对象
     * @param bscMessage 内容
     * @param user 目标用户
     */
    private void GoodsPush(BscMessage bscMessage,User user) {
        new Thread() {
            @Override
            public void run() {
                try {
                    Thread.sleep(10000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                String summary = bscMessage.getSummary();
                Map<String, String> paramMap = new HashMap<>();
                paramMap.put("TITLE", "货源信息通知");
                paramMap.put("SOURCETYPE ", "3");
                paramMap.put("SUMMARY", bscMessage.getSummary());
                paramMap.put("SOURCEID ", bscMessage.getSourceid());
                paramMap.put("ORDERID  ", "");
                MessagePushUtil.sendPush("货源信息通知", summary, user.getId(), paramMap);

                BscMessage message=new BscMessage();
                message.setTtile(DataDic.MESSAGE_TYPE_NEWGOODS);
                message.setContent(summary);
                message.setSummary(summary);
                message.setContenttype(DataDic.MESSAGE_CONTENTTYPE_KEFU);
                message.setStatus(DataDic.MESSAGE_STATUS_YES);
                message.setSourceid(bscMessage.getSourceid());
                message.setSendtype(DataDic.MESSAGE_SENDTYPE_USER);
                message.setSourcetype(DataDic.MESSAGE_SOURCETYPE_SOURCEGOODS);
                message.setScantype(DataDic.MESSAGE_SCANTYPE_ANDROID);
                message.setUser(user);
                message.setId(IdGen.uuid());
                UserMessage userMessage=new UserMessage();
                userMessage.setMessage(message);
                userMessage.setStatus(DataDic.MESSAGE_IS_READ_NO);
                userMessage.setUser(user);
                bscMessageBiz.saveMessage(message,userMessage);//同步保存消息

            }
        }.start();
    }
}