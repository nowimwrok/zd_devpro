package com.thinkgem.jeesite.modules.wlpt.biz.bidBiz;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidOrderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Biddinginfo;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.Bidinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.QuoteBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 招标业务类
 * Created by 刘欣 on 2016/8/13.
 */
@Service
@Transactional(readOnly = true)
public class BiddingBiz extends BaseController {

    @Autowired
    private BidinfoService bidinfoService;

    @Autowired
    private BiddinginfoService biddinginfoService;

    @Autowired
    private BidOrderinfoService bidOrderinfoService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private BidBlinfoService bidBlinfoService;

    @Autowired
    private UserBiz userBiz;

    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;
    
    @Autowired
    private SystemService systemService;

    @Autowired
    private QuoteinfoService quoteinfoService;
    
    @Autowired
    private AccountBiz accountBiz;
    
    @Autowired
	private CollectionBiz collectionBiz;
    
    private final ReentrantLock lock=new ReentrantLock();

    public Bidinfo get(String id) {
        return bidinfoService.get(id);
    }

    public void getBlList(BidBlinfo blinfo, User user) {
        blinfo.setBiddinguser(user);
    }

    /**
     * 发布招标
     *
     * @return 招标信息
     */
    @Transactional(readOnly = false)
    public Map publishBid(Bidinfo bidinfo) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if ((user != null ? user.getUserinfo() : null) != null && DataDic.AUTHENSUCCES.equals(user.getUserinfo().getStatus())) {  //判断是否认证
            if (bidinfo.getId() == null || bidinfo.getId().equals("")) {
                if (bidinfo.getEndtime().getTime() <= new Date().getTime()) {
                    return Tools.getMapResult(4, "招标截止时间不能小于当前时间", null);
                } else {
                    bidinfo.setBiduser(user);   //发标人
                    bidinfo.setBidcode(OrderNumberUtil.getOrderNo(DataDic.MODEL_BIDINFO));  //招标code
                    bidinfo.setBidstatus(DictUtils.getDictValue("发布", "bid_status", ""));
                    bidinfo.setPublishtime(new Date());
                    if (Objects.equals(DictUtils.getDictValue("发布招标时起", "settlement_type", ""), bidinfo.getSettlementtype())) {
                        // 创建 Calendar 对象
                        Calendar calendar = Calendar.getInstance();
                        calendar.setTime(bidinfo.getPublishtime());
                        calendar.add(Calendar.DATE, bidinfo.getSettlementperiod());    //计算结算日期
                        bidinfo.setSettlementtime(calendar.getTime());
                    }
                    Goods goods = bidinfo.getGoods();
                    if (goods != null) {
                        goods.setUser(user);
                        goods.getShipAddress().setLinkman(user.getName());
                        goods.getShipAddress().setLinkmobile(user.getPhone());
                        //保存发货人信息
                        Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getShipAddress(), user);
                        //保存收货人信息
                        Map<String, Object> consignmap = (Map<String, Object>) userBiz.saveAddressBiz(goods.getConsignAddress(), user);
                        //重新赋值发货人
                        goods.setShipAddress((Address) shipmap.get("data"));
                        //重新赋值收货人
                        goods.setConsignAddress((Address) consignmap.get("data"));
                        goods.setDatasource(DataDic.GDS_DATASORCE_BIDGDS);
                        goods.setResidualvolume(goods.getFreightvolume());
                        goodsService.save(goods);
//                        //统计发布的货源数
//                        UserStatistics statistics = new UserStatistics();
//                        statistics.setPubgodscount("1");
//                        UserUtils.userDataSourceCount(statistics);
                    }
                    bidinfo.setGoods(goods);

                    if (bidinfo.getBlinfoList().size() > 0) {   //提货单
                        for (BidBlinfo bl : bidinfo.getBlinfoList()) {
                            bl.setBidgoods(goods);
                            bl.setBiduser(bidinfo.getBiduser());
                            bl.setBltype(DataDic.Bl_TYPE_BIDBL);   //招标提货单类型
                            bl.setBlstatus(DataDic.Bl_STATUS_PUBLISH);  //发布状态
                            bl.setTradestatus(DataDic.BL_TRADE_STATUS_WSC);  //未生成
                            bl.setBidInboundDate(new Date());// 招标方入库时间
                            bl.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_DCK);  // 招标方仓库状态
                            if (bl.getId() == null) {
                                bl.setBlcode(OrderNumberUtil.getOrderNo(DataDic.MODEL_BIDBL));
                                bl.setId(IdGen.uuid());
                                bl.setIsNewRecord(true);
                            }
                            bidBlinfoService.save(bl);
                        }
                        ///是否上传提货单招标
                        bidinfo.setIsupbl(1);
                    }

                    bidinfoService.save(bidinfo);

                    //统计发布的货源数
                    UserStatistics statistics = new UserStatistics();
                    statistics.setPubbidcount("1");
                    UserUtils.userDataSourceCount(statistics);

                    new Thread(){
                        public void run(){
                        	String url = getOauthUrl(ConstantWeChat.SERVICE_URLS+ "bid/toBidding?id=" + bidinfo.getId(), "UTF-8", ConstantWeChat.SCOPE_SNSAPI_USERINFO);
                            String addressStart = goods.getShipAddress().getProvince() + goods.getShipAddress().getCity() + goods.getShipAddress().getDistrict();    //起点
                        	String addressEnd = goods.getConsignAddress().getProvince() + goods.getConsignAddress().getCity() + goods.getConsignAddress().getDistrict();   ///终点
                        	String unit = StringUtils.isNoneBlank(goods.getFreightunit())?goods.getFreightunit():"吨";
                            String[] keyword = {"招标", user.getLoginName(),addressStart,addressEnd, goods.getGoodsname() + " " +goods.getFreightvolume() + unit, "截标：" + Tools.date2Str(bidinfo.getEndtime(),"yyyy-MM-dd")};
                            sendallUser(keyword,url,goods.getShipAddress().getCity(),goods.getConsignAddress().getCity());//推送
                            //SmsUtil.sendSmsMesge("put_bid", "1", "发布招标通知", keyword, ConstantWeChat.PUB_BID, true, "enterprise", url, false);
                       }
                    }.start();
                    
                    return Tools.getMapResult(1, "发布招标成功", bidinfo);
                }
            } else {
                return Tools.getMapResult(6, "招标信息已发布", null);
            }
        } else {
            return Tools.getMapResult(2, "需要认证后才能发布招标", null);
        }
    }


    /**
     * 招标作废
     * @param bidinfo
     */
    @Transactional(readOnly = false)
    public Object repealBid(Bidinfo bidinfo){
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user != null && user.getId() != null ) {
            if (bidinfo.getId()!=null ){
                Bidinfo binfo = bidinfoService.get(bidinfo);
                if(user.getId().equals(binfo.getBiduser().getId()) ){
                    if(DataDic.BIDINFO_STATUS_END.equals(binfo.getBidstatus())){
                        Biddinginfo bding = new Biddinginfo();
                        bding.setBidinfo(binfo);
                        List<Biddinginfo> biddinginfos = biddinginfoService.findList(bding);  //查找招标所有竞标信息
                        for (Biddinginfo bdingInfo : biddinginfos) {
                            ///是否减免保证金--是:减免;否:缴纳
                            if(DataDic.NO.equals(bdingInfo.getIsderate())){
                                ///退还保证金
                                consumeRecodBiz.biddingReturnPayRecodeBiz(bdingInfo);
                                ///退还保证金状态
                                bdingInfo.setGuarantee(DataDic.BIDDING_GURAN_RETURN);
                                biddinginfoService.save(bdingInfo);
                                
                              //发送退还保证金
                                String[] keyword = {bdingInfo.getBiddingmargin()};
                                SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_FREIGHTREFUND, bdingInfo.getBiddinguser().getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keyword, null, null, true, SmsConfig.smsRefund);
                            }
                        }
                        BidBlinfo blinfo=new BidBlinfo();
                        blinfo.setBidgoods(binfo.getGoods());
                        List<BidBlinfo> blinfos = bidBlinfoService.findList(blinfo);
                        for (BidBlinfo bl :blinfos){
                            bl.setBlstatus(DataDic.Bl_STATUS_NOPUBLISH);  //修改提货单状态
                            bl.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YRK);  // 招标方仓库状态
                            bidBlinfoService.save(bl);
                        }
                        binfo.setBidstatus(DataDic.BID_STATUS_FEIB);  //改为废标
                        bidinfoService.save(binfo);
                       //统计废标数
                        UserStatistics statistics = new UserStatistics();
                        statistics.setCancelbidcount("1");
                        UserUtils.userDataSourceCount(statistics);
                    }else {
                        state = DataDic.RETURN_STATUS_AUTHBUG;
                        message = "招标截止状态才能废标";
                    }
                }else {
                    state = DataDic.RETURN_STATUS_AUTHBUG;
                    message = "对不起,您无权限操作";
                }
            }else{
                state = DataDic.RETURN_STATUS_INFOBUG;
                message = "招标信息有误";
            }
        }else {
             state = DataDic.RETURN_STATUS_NORMAL;
             message = "处理成功";
        }
        return Tools.getMapResult(state, message, null);
    }

    /**
     * 退回保证金
     * @param bdingInfo
     */
    @Transactional(readOnly = false)
    public Map<String, Object> biddingReturnPayBid(Biddinginfo bdingInfo){
        int state = DataDic.RETURN_STATUS_NORMAL;
        int result = DataDic.RETURN_STATUS_NORMAL;
        String message = "处理成功";
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user != null && user.getId() != null && !Tools.IsNullOrWhiteSpace(bdingInfo.getId())) {
        	
        	bdingInfo = biddinginfoService.get(bdingInfo);  //查找招标所有竞标信息
            ///是否减免保证金--是:减免;否:缴纳
            if(DataDic.NO.equals(bdingInfo.getIsderate())){
                ///退还保证金
            	result = consumeRecodBiz.biddingReturnPayRecodeBiz(bdingInfo);
            	if(result==DataDic.RETURN_STATUS_NORMAL){
            		///退还保证金状态
                    bdingInfo.setGuarantee(DataDic.BIDDING_GURAN_RETURN);
                    biddinginfoService.save(bdingInfo);
                    //发送退还保证金
                    String[] keyword = {bdingInfo.getBiddingmargin(), Global.LINK_WEB};
                    SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_FREIGHTREFUND, bdingInfo.getBiddinguser().getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keyword, null, null, true, SmsConfig.smsRefund);
            	}else{
            		state = DataDic.RETURN_STATUS_SYSBUG;
            		message = "处理失败";
            	}
            }
                  
        }else {
             state = DataDic.RETURN_STATUS_SYSBUG;
             message = "处理失败";
        }
        return Tools.getMapResult(state, message, null);
    }


    
    
   /**
    * 推送发布的招标给关注的企业
    * @param keyword
    * @param url
    */
	public void sendallUser( String[] keyword, String url,String fromcity,String tocity ) {
		try {
			WlptCollection wlptCollection = new WlptCollection();
			//获取关注招标条数
			wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_BID);
			wlptCollection.setFromcity(fromcity);
			wlptCollection.setTocity(tocity);
			
			List<WlptCollection> list = collectionBiz.findList(wlptCollection);
			if(list.size()>0){
				for (WlptCollection collec : list) {
					if(collec!=null){
						String openId = collec.getOpenid();
						if(StringUtils.isNoneBlank(openId)){
							//发送推送
							SmsUtil.sendSmsMesge(openId, DataDic.SMSCODE_DELIVERGOODS, null, Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, ConstantWeChat.PUB_BID, url, false, SmsConfig.smsGoodsEnd);
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
     * 竞标
     *
     * @param biddinginfo
     * @return Map
     */
    @Transactional(readOnly = false)
    public Map bidding(Biddinginfo biddinginfo) {
    	lock.lock();
    	try{
    		User user = UserUtils.findUser(UserUtils.getUser());
            if ((user != null ? user.getUserinfo() : null) != null && DataDic.AUTHENSUCCES.equals(user.getUserinfo().getStatus())) {  //判断是否认证
                if (!DataDic.ROLE_ENTERPRISE.equals(user.getRole().getEnname())) {
                    return Tools.getMapResult(3, "物流企业才能竞标", null);

                }
                User u=UserUtils.getUserBySearch(bidinfoService.get(biddinginfo.getBidinfo()).getBiduser().getLoginName());
//                if(Tools.IsNullOrWhiteSpace(u.getMemberId())&&!Tools.IsNullOrWhiteSpace(user.getMemberId())){
//                	return Tools.getMapResult(3, "暂不支持账户系统用户与非账户系统用户的交易", null);
//                }
                if (Tools.IsNullOrWhiteSpace(user.getMemberId())&&!Tools.IsNullOrWhiteSpace(u.getMemberId())) {
                	UserBankinfo userBankinfo=new UserBankinfo();
                	userBankinfo.setUser(user);
                	List<UserBankinfo> userBankList=userBiz.findUserBankList(userBankinfo);
                	if(userBankList==null||userBankList.size()==0){
                		return Tools.getMapResult(3, "为了能够及时给您支付运费，请您先绑定银行卡", null);
                	}
                }
                if (biddinginfo.getId() == null || biddinginfo.getId().equals("")) {
                    biddinginfo.setBiddinguser(user);
                    List<Biddinginfo> list = biddinginfoService.findList(biddinginfo);
                    Bidinfo bidinfo = bidinfoService.get(biddinginfo.getBidinfo());
                    
                    ///当前可用余额
                    Double avaliv = Double.valueOf(user.getUserPurse().getAvailablebalance());
                    Double avalivAccount=0.0;
                    if(!Tools.IsNullOrWhiteSpace(user.getMemberId())){
                    	avalivAccount=accountBiz.getAmount(user, DataDic.AVAILABLE_BALANCE);
                    }
                    if(avalivAccount==null){
                    	avalivAccount=0.0;
                    }
                    
                    if (DateUtils.getDistanceOfTwoDate(bidinfo.getEndtime(), new Date()) > 0) {
                        return Tools.getMapResult(5, "招标已截止", null);
                    } else if (!DataDic.BIDINFO_STATUS_PUB.equals(bidinfo.getBidstatus())) {
                        return Tools.getMapResult(6, "当前状态不能竞标", null);
                    } else if (Tools.IsNullOrWhiteSpace(biddinginfo.getBiddingprice())) {
                        return Tools.getMapResult(7, "请填写竞标报价", null);
                    } else if ((avalivAccount < DataDic.BIDGUARANTEE&&avaliv < DataDic.BIDGUARANTEE)&&DataDic.NO.equals(biddinginfo.getIsderate())) {//不使用减免
                    	return Tools.getMapResult(8, "账户余额不足", null);
                    } else if (list.size() > 0) {   //判断重复竞标
                        return Tools.getMapResult(2, "已经参与过竞标", null);
                    } else if (user.getId().equals(bidinfo.getBiduser().getId())) {
                        return Tools.getMapResult(9, "内部招标,请勿投标", null);
                    } else {
                        biddinginfo.setBiddingcode(OrderNumberUtil.getOrderNo(DataDic.MODEL_BIDDING));  //竞标code
                        biddinginfo.setBiddingstatus(DataDic.BIDDING_STATUS_BDING);
                        biddinginfo.setLinkman(user.getName());
                        biddinginfo.setLinkphone(user.getPhone());
                        if(DataDic.NO.equals(biddinginfo.getIsderate())){//不使用减免保证金
                        	biddinginfo.setBiddingmargin((DataDic.BIDGUARANTEE).toString());
                        }else{
                            biddinginfo.setGuarantee(DataDic.BIDDING_GURAN_UNPAY);
                            biddinginfo.setIsderate(DataDic.YES);
                        }
                        
                        if(DataDic.NO.equals(biddinginfo.getIsderate())){//不使用减免保证金
                        	//设置为锁定冻结金额
                            biddinginfo.setIsLockWay(DataDic.YES);
                            int back=consumeRecodBiz.biddingPayRecodeBiz(biddinginfo);
                            if(back!=1){
                            	return Tools.getMapResult(back, "竞标失败", null);
                            }
                        
                        }
                        
                        biddinginfoService.save(biddinginfo);
                        bidinfo.setBiddingcount(bidinfo.getBiddingcount() + 1);  //投标次数+1
                        bidinfoService.save(bidinfo);

                        

                        return Tools.getMapResult(1, "竞标成功", biddinginfo);
                    }
                } else {
                    return Tools.getMapResult(4, "竞标信息已存在", null);
                }
            } else {
                return Tools.getMapResult(3, "认证后才能竞标", null);
            }
    	}finally{
    		lock.unlock();
    	}
    }

    /**
     * 验证招标是否截止 如果是就改变状态
     * @param bidinfo
     * @return
     */
    @Transactional(readOnly = false)
    public Bidinfo checkEndTime(Bidinfo bidinfo){
        if (bidinfo.getEndtime().getTime() < new Date().getTime() && DataDic.BID_STATUS_FAB.equals(bidinfo.getBidstatus())) {
            bidinfo.setBidstatus(DataDic.BIDINFO_STATUS_END);  //截标状态
            bidinfoService.save(bidinfo);
        }
        return bidinfo;
    }


    /**
     * 选择中标
     *
     * @param bidding
     * @return Map
     */
    @Transactional(readOnly = false)
    public Map selectBid(Biddinginfo bidding) {
        Biddinginfo biddinginfo = biddinginfoService.get(bidding);  //竞标
        Bidinfo bidinfo = bidinfoService.get(biddinginfo.getBidinfo()); //招标
        BidOrderinfo bidOrderinfo = new BidOrderinfo();
        bidOrderinfo.setBidinfo(bidinfo);
        List<BidOrderinfo> list = bidOrderinfoService.findList(bidOrderinfo);

        Biddinginfo bding = new Biddinginfo();
        bding.setBidinfo(bidinfo);
        List<Biddinginfo> biddinginfos = biddinginfoService.findList(bding);  //查找招标所有竞标信息
        if (list.size() > 0) {
            return Tools.getMapResult(2, "招标已生成中标合同", "");
        }/* else if (biddinginfos.size() < 2) {
            return Tools.getMapResult(3, "需两家以上的企业竞标", "");
        }*/ else {
            bidOrderinfo.setContractno(OrderNumberUtil.getOrderNo(DataDic.MODEL_BIDORDER)); //合同号
            bidOrderinfo.setBiddinginfo(biddinginfo);   //竞标
            bidOrderinfo.setBiduser(bidinfo.getBiduser());  //招标用户
            bidOrderinfo.setBiddinguser(biddinginfo.getBiddinguser()); //竞标用户
            bidOrderinfo.setContracttotal(PreciseCompute.mul(Double.parseDouble(bidinfo.getGoods().getFreightvolume()), Double.parseDouble(biddinginfo.getBiddingprice()))); //合同总价
            bidOrderinfo.setSettlestatus(DataDic.BID_SETTLE_NOMER);
            bidOrderinfo.setContractstatus(DataDic.BIDORDER_STATUS_NOMER);
            bidOrderinfoService.save(bidOrderinfo);

            for (Biddinginfo b : biddinginfos) {   //更改竞标表中标状态
                if (!b.getId().equals(biddinginfo.getId())) {
                     b.setBiddingstatus(DataDic.BIDDING_STATUS_FAILED);
                    //发送未中标通知
                    String[] keyword = {bidinfo.getBidcode()};
                    SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_NOTBIDED, b.getBiddinguser().getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keyword, null, null, true, SmsConfig.smsUnBided);
                    ///是否减免保证金--是:减免;否:缴纳
                    if(DataDic.NO.equals(b.getIsderate())){
                        ///退还保证金
                        consumeRecodBiz.biddingReturnPayRecodeBiz(b);
                        ///退还保证金状态
                        b.setGuarantee(DataDic.BIDDING_GURAN_RETURN);
                        //发送退还保证金
                        String[] keywords = {b.getBiddingmargin(), Global.LINK_WEB};
                        SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_FREIGHTREFUND, b.getBiddinguser().getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keywords, null, null, true, SmsConfig.smsRefund);
                    }
                } else {
                    b.setBiddingstatus(DataDic.BIDDING_STATUS_GETBID);
                    //发送中标通知
                    User us = UserUtils.getUserById(bidding.getBiddinguser().getId());//获取用户信息
                    
                    Goods goods = goodsService.get(bidinfo.getGoods().getId());
                    String addressStart = goods.getShipAddress().getProvince() + goods.getShipAddress().getCity() + goods.getShipAddress().getDistrict();    //起点
                	String addressEnd = goods.getConsignAddress().getProvince() + goods.getConsignAddress().getCity() + goods.getConsignAddress().getDistrict();   ///终点
                	String title = "尊敬的用户，您有一条中标通知";
                	String[] keyword = {title,us.getUserinfo().getCompanyname(), addressStart,addressEnd, goods.getGoodsname() + " " + goods.getFreightvolume() + goods.getFreightunit(), "恭喜您中标"};
                    
                    SmsUtil.sendSmsMesge(us.getUserinfo().getOpenid(), DataDic.SMSCODE_NOTIFYS, bidding.getBiddinguser().getPhone(), Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_BIDOD, keyword,  ConstantWeChat.NOTICE_BID, null, true, SmsConfig.smsBided);
                    //统计中标数
                    UserStatistics statistics = new UserStatistics();
                    statistics.setUser(us);
                    statistics.setBiddingcount("1");
                    UserUtils.userDataSourceCount(statistics);
                }
                biddinginfoService.save(b);
            }
            bidinfo.setBidstatus(DataDic.BID_STATUS_ZZJY);  //更改招标状态
            bidinfoService.save(bidinfo);

            BidBlinfo bl = new BidBlinfo();
            bl.setBidgoods(bidinfo.getGoods());
            List<BidBlinfo> blinfos = bidBlinfoService.findList(bl);
            for (BidBlinfo blinfo : blinfos) {
                blinfo.setBidOrder(bidOrderinfo);
                blinfo.setBiddinguser(biddinginfo.getBiddinguser());
                blinfo.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YCK);  // 招标方仓库状态
                blinfo.setBidOutboundDate(new Date());  // 招标方出库时间
                blinfo.setBiddingstatus(DataDic.BL_WAREHOUSE_STATUS_YRK);  // 竞标方仓库状态
                blinfo.setBiddingInboundDate(new Date());  // 竞标方仓库状态
                bidBlinfoService.save(blinfo);
            }


            return Tools.getMapResult(1, "生成合同成功", bidOrderinfo);
        }
    }

    /**
     * 招标信息列表
     *
     * @param page
     * @param bidinfo
     * @return
     */
    public Page<Bidinfo> findPage(Page<Bidinfo> page, Bidinfo bidinfo) {
        return bidinfoService.findPage(page, bidinfo);
    }

    /**
     * 竞标信息列表
     *
     * @param page
     * @param biddinginfo
     * @return
     */
    public Page<Biddinginfo> biddingFindPage(Page<Biddinginfo> page, Biddinginfo biddinginfo) {
        return biddinginfoService.findPage(page, biddinginfo);
    }

    /**
     * 竞标详情
     *
     * @param id
     * @return
     */
    public Biddinginfo getBiddingDetail(String id) {
        return biddinginfoService.get(id);
    }


    /****
     * 提货单交易改为未发布状态
     * @param quote_id  报价ID
     */
    public void updateTradeUnPubBiz(String quote_id) {
        QuoteBlinfo quoteBlinfo=new QuoteBlinfo();
        Quoteinfo quoteinfo=new Quoteinfo();
        quoteinfo.setId(quote_id);
        quoteBlinfo.setQuote(quoteinfo);
        //获取提货单列表
        List<String> bllist=new ArrayList<String>();
        List<QuoteBlinfo> list = quoteinfoService.findBLinfoList(quoteBlinfo);
        for (QuoteBlinfo b : list) {
            bllist.add(b.getBlinfo().getId());
        }
        if (bllist.size()>0) {
            bidBlinfoService.updateTradeUnPub(bllist.toArray(new String[bllist.size()]));
            bidBlinfoService.updateBidStatusUnPub(DataDic.BL_WAREHOUSE_STATUS_YRK,bllist.toArray(new String[bllist.size()]));
        }

    }

    /**
     * 未运输状态
     * @param quote_id
     */
    public void updateTradeUnTradeBiz(String quote_id) {
        QuoteBlinfo quoteBlinfo=new QuoteBlinfo();
        Quoteinfo quoteinfo=new Quoteinfo();
        quoteinfo.setId(quote_id);
        quoteBlinfo.setQuote(quoteinfo);
        //获取提货单列表
        List<String> bllist=new ArrayList<String>();
        List<QuoteBlinfo> list = quoteinfoService.findBLinfoList(quoteBlinfo);
        for (QuoteBlinfo b : list) {
            bllist.add(b.getBlinfo().getId());
        }
        if (bllist.size()>0) {
            bidBlinfoService.updateTradeCancel(bllist.toArray(new String[bllist.size()]));
            bidBlinfoService.updateBidStatusUnPub(DataDic.BL_WAREHOUSE_STATUS_DCK,bllist.toArray(new String[bllist.size()]));
        }

    }

    @Transactional(readOnly = false)
    public Object saveBinBlinfo(BidBlinfo blinfo) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "保存成功";
        User currentUser = UserUtils.getUser();
        if (currentUser == null) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if (!userBiz.getUser().getUserinfo().getStatus().equals("2")) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        if (StringUtils.isBlank(blinfo.getContractno()) || StringUtils.isBlank(blinfo.getBatch()) ||
                StringUtils.isBlank(blinfo.getNamematerials()) || StringUtils.isBlank(blinfo.getStandard())
                || StringUtils.isBlank(blinfo.getWidth())|| StringUtils.isBlank(blinfo.getQuantity())
                || StringUtils.isBlank(blinfo.getAddress())) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "缺失发布信息！";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {
            blinfo.setBiduser(UserUtils.getUser());
            blinfo.setBiddinguser(UserUtils.getUser());
            blinfo.setBltype(DataDic.Bl_TYPE_BL);   //招标提货单类型
            blinfo.setBlstatus(DataDic.Bl_STATUS_NOPUBLISH);  //发布状态
            blinfo.setTradestatus(DataDic.BL_TRADE_STATUS_WSC);  //未生成
            blinfo.setBidstatus(DataDic.BL_WAREHOUSE_STATUS_YRK);
            blinfo.setBidInboundDate(new Date());
            blinfo.setBlcode(OrderNumberUtil.getBidCode(Const.System_Module_Enum.All, 3));
            blinfo.setId(IdGen.uuid());
            blinfo.setIsNewRecord(true);
            bidBlinfoService.save(blinfo);
        }
        return Tools.getMapResult(state, message, null);
    }
}
