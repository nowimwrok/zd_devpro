package com.thinkgem.jeesite.modules.wlpt.biz.shop;

import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ShopVO;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;

/**
 * 卓大商城
 * @author asus
 *
 */
@Service
@Transactional(readOnly = true)
public class ShopBiz {

	@Autowired
    private ConsumeRecodBiz consumeRecodBiz;
	
	@Autowired
    private ActivityBiz activityBiz;

	@Autowired
	private AccountBiz accountBiz;
	
	@Autowired
	private IntegrityBiz integrityBiz;
	
	@Autowired
    private UserBiz userBiz;
	
	@Autowired
    private TradeBiz tradeBiz;

	@Autowired
    private OrderinfoService orderinfoService;

	@Autowired
	private UserInsuranceService userInsuranceService;

	private final ReentrantLock lock=new ReentrantLock();


	/**
	 * 商品购买
	 * @param shop
	 * @param giftid
	 * @param paytype
	 * @param awardno
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object consumeType(ShopVO shop,String giftid,String paytype,String awardno){
    	lock.lock();
    	try{
    		double total=Double.parseDouble(shop.getTotal());//?获取消费的金额？不确定
        	double coinnum=total;
        	double consumemoney=total;
        	double money =total;
        	int result=1;
        	User u = UserUtils.findUser(UserUtils.getUser());
    		if(u==null||UserUtils.getUser().getId()==null){
        		return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        	}
			String worth = "";
			ActivityAwardrecord activityAwardrecord = new ActivityAwardrecord();
			//获取劵
			if(!Tools.IsNullOrWhiteSpace(awardno)){
				activityAwardrecord = activityBiz.getAwardlistInfoByAwardNo(awardno);
				if(activityAwardrecord!=null && !Tools.IsNullOrWhiteSpace(activityAwardrecord.getWxgift().getGiftworth())) {
					worth = activityAwardrecord.getWxgift().getGiftworth();//获取礼物价值
					money = money - Double.valueOf(worth);//应付金额减去礼物价值为本次话费金额
				}
			}
        	//至少消费一卓币
        	if(coinnum<1){
        		return new JSONPObject("callback", DataDic.RETURN_STATUS_RECHARGEBUG);
        	}
        	if(shop.getShotName().equals("you_qi")){
        			User user = UserUtils.findUser(UserUtils.getUser());
        			if(user==null||UserUtils.getUser().getId()==null){
        	    		return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        	    	}
        			if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)){//卓币支付
        	    		//账户可用卓币余额是否足够
        	        	if(user.getUserPurse()==null || user.getUserPurse().getAvailablecoin()<money){
        	        		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
        	        	}
            		}else if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
            			//账户可用余额是否足够
                    	if(accountBiz.getAmount(user, DataDic.AVAILABLE_BALANCE)<money){
                    		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
                    	}
            		}else{
            			//账户可用余额是否足够
                    	if(user.getUserPurse()==null || user.getUserPurse().getAvailablebalance()<money){
                    		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
                    	}
            		}
                	
                	Consumerecod consum = new Consumerecod();
                    consum.setAccount(user);
                    consum.setConsumetype(DataDic.CONSUMERECODE_TYPE_PETROLRECHARGE);
                    List<Consumerecod> conlist = consumeRecodBiz.findList(consum);//查询是否第一次购买油气
                    //购买油气
                    result=consumeRecodBiz.rechargePetroBiz(UserUtils.getUser().getId(),consumemoney,coinnum,paytype,awardno);
                    if(!DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)){//余额支付
        	    		if(conlist.size()==0&& result == DataDic.RETURN_STATUS_NORMAL &&
        	    				!Tools.IsNullOrWhiteSpace(giftid)&&!Tools.IsNullOrWhiteSpace(shop.getNum())
        	    				&&Integer.parseInt(shop.getNum())>=10){
        	    			activityBiz.savaGiftinfo(giftid, user);//活动
        	    		}
                    }
//                    //消费平台商城增值产品（每超过1000元）就可获得积分
//                    if(coinnum>=1000 && result == DataDic.RETURN_STATUS_NORMAL){
//                		integrityBiz.updateIntegrityPoint(u.getUserinfo(),DataDic.INTEGRITY_POINT_SHOPMONE,u.getRole().getEnname());//更新诚信积分
//                	}

        	}
        	if(shop.getShotName().equals("zd_coin")){
        			User user = UserUtils.findUser(UserUtils.getUser());
        			if(user==null||UserUtils.getUser().getId()==null){
        	    		return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        	    	}
        			Double available = user.getUserPurse().getAvailablebalance();
            		if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
            			available=accountBiz.getAmount(user, DataDic.AVAILABLE_BALANCE);
            		}
            		//账户可用余额是否足够
                	if(user.getUserPurse()==null || available<money){
                		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
                	}
                	result=consumeRecodBiz.rechargeCoinBiz(UserUtils.getUser().getId(),consumemoney,coinnum,paytype);
                	
//                	//消费平台商城增值产品（每超过1000元）就可获得积分
//                	if(coinnum>=1000 && result == DataDic.RETURN_STATUS_NORMAL){
//                		integrityBiz.updateIntegrityPoint(u.getUserinfo(),DataDic.INTEGRITY_POINT_SHOPMONE,u.getRole().getEnname());//更新诚信积分
//                	}
        	}
        	if(shop.getShotName().equals("zd_insur")){
        			User user = UserUtils.findUser(UserUtils.getUser());
        			if(user==null||UserUtils.getUser().getId()==null){
        	    		return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        	    	}
        			if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
            			//账户可用余额是否足够
                    	if(accountBiz.getAmount(user, DataDic.AVAILABLE_BALANCE)<money){
                    		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
                    	}
            		}else if(!Tools.IsNullOrWhiteSpace(paytype)&&DataDic.CONSUMERECODE_WAY_BALANCE.equals(paytype)){
            			//账户可用余额是否足够
                    	if(user.getUserPurse()==null || user.getUserPurse().getAvailablebalance()<money){
                    		return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
                    	}
            		}
        			
                    //购买保险
                    result=consumeRecodBiz.buyInsurBiz(shop.getInsurid(),UserUtils.getUser().getId(),consumemoney,paytype,awardno);
                    //每购买一单保险都会增加积分
                    if(result == DataDic.RETURN_STATUS_NORMAL){
                		integrityBiz.updateIntegrityPoint(u.getUserinfo(),DataDic.INTEGRITY_POINT_INSURANCE,u.getRole().getEnname());//更新诚信积分
                	}
        	}
        	 //消费平台商城增值产品（每超过1000元）就可获得积分
        	if(coinnum>=1000 && result == DataDic.RETURN_STATUS_NORMAL){
        		integrityBiz.updateIntegrityPoint(u.getUserinfo(),DataDic.INTEGRITY_POINT_SHOPMONE,u.getRole().getEnname());//更新诚信积分
        	}
			if(!Tools.IsNullOrWhiteSpace(awardno)&& result == DataDic.RETURN_STATUS_NORMAL){
				ActivityAwardrecord aw = new ActivityAwardrecord();
				aw.setIssue(DataDic.ACTIVITYGIFT_STATUS_USE);
				aw.setId(activityAwardrecord.getId());
				activityBiz.updateIsSue(aw);//设置为已使用
			}
        	return new JSONPObject("callback", result);
    	}finally{
    		lock.unlock();
    	}
    }
	
	/**
	 * 保险确认--新建单
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveInsur(UserInsurance userInsurance){
		int result=1;
		User user=UserUtils.getUser();
		if(user==null||Tools.IsNullOrWhiteSpace(user.getId())){
			result=0;
			return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), null);
		}
		/*if(Tools.IsNullOrWhiteSpace(userInsurance.getApplicant())||Tools.IsNullOrWhiteSpace(userInsurance.getCarnumber())||Tools.IsNullOrWhiteSpace(userInsurance.getGoodsname())
			||Tools.IsNullOrWhiteSpace(userInsurance.getGoodstype())||Tools.IsNullOrWhiteSpace(userInsurance.getTotalweight())||Tools.IsNullOrWhiteSpace(userInsurance.getWorth())){
			result=2;
			return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), null);
		}*/
		if(Tools.IsNullOrWhiteSpace(userInsurance.getApplicant())){
				result=2;
				return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), null);
			}
		userInsurance.setUser(user);	
		userInsurance.setStatus("0");
		if(userInsurance.getApplicantAddress()!=null){
			Map<String, Object> appmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getApplicantAddress(), user);
	    	if((int)appmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
	    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存联系信息失败", null);
	    	}
	    	userInsurance.setApplicantAddress((Address)appmap.get("data"));
		}
		if(userInsurance.getShipAddress()!=null){
			Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getShipAddress(), user);
	    	if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
	    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存始发信息失败", null);
	    	}
	    	userInsurance.setShipAddress((Address)shipmap.get("data"));
		}
		if(userInsurance.getConsignAddress()!=null){
    	Map<String, Object> conmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getConsignAddress(), user);
	    	if((int)conmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
	    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存目的信息失败", null);
	    	}
	    	
	    	userInsurance.setConsignAddress((Address)conmap.get("data"));
		}
    	if(Tools.IsNullOrWhiteSpace(userInsurance.getId())){
    		userInsurance.setId(IdGen.uuid());
        	userInsurance.setIsNewRecord(true);
    	}
    	
		userInsuranceService.save(userInsurance);
		return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), userInsurance);
	}
	
	/**
	 * 运单保险确认--新建单
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveTradeInsur(UserInsurance userInsurance,Model model){
		int result=1;
		User user=UserUtils.getUser();
		if(user==null||Tools.IsNullOrWhiteSpace(user.getId())){
			result=0;
			return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), null);
		}
		if(Tools.IsNullOrWhiteSpace(userInsurance.getOrderno())){
			result=2;
			return Tools.getMapResult(result, Tools.statusMessage(result, "运单号为空"), null);
		}
		if(Tools.IsNullOrWhiteSpace(userInsurance.getApplicant())||Tools.IsNullOrWhiteSpace(userInsurance.getCarnumber())||Tools.IsNullOrWhiteSpace(userInsurance.getGoodsname())
			||Tools.IsNullOrWhiteSpace(userInsurance.getGoodstype())||Tools.IsNullOrWhiteSpace(userInsurance.getTotalweight())||Tools.IsNullOrWhiteSpace(userInsurance.getWorth())){
			result=2;
			return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), null);
		}
		
		Orderinfo oinfo = tradeBiz.getDetailByOrderNo(userInsurance.getOrderno(), user);
		if(oinfo==null){
			result=2;
			return Tools.getMapResult(result, Tools.statusMessage(result, "运单不存在"), null);
		}
		UserInsurance uis = new UserInsurance();
		uis.setOrderno(userInsurance.getOrderno());
		uis = userInsuranceService.getInsurInfo(uis);
		if(uis!=null){
			userInsurance.setId(uis.getId());
		}
		
		Map<String, Object> appmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getApplicantAddress(), user);
    	if((int)appmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存联系信息失败", null);
    	}
		Map<String, Object> shipmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getShipAddress(), user);
    	if((int)shipmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存始发信息失败", null);
    	}
    	Map<String, Object> conmap = (Map<String, Object>) userBiz.saveAddressBiz(userInsurance.getConsignAddress(), user);
    	if((int)conmap.get("state")==DataDic.RETURN_STATUS_INFOBUG){
    		return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG, "保存目的信息失败", null);
    	}
    	
    	userInsurance.setApplicantAddress((Address)appmap.get("data"));
    	userInsurance.setShipAddress((Address)shipmap.get("data"));
    	userInsurance.setConsignAddress((Address)conmap.get("data"));
    	if(Tools.IsNullOrWhiteSpace(userInsurance.getId())){
    		userInsurance.setId(IdGen.uuid());
        	userInsurance.setIsNewRecord(true);
    	}
    	
		//承运发付款
		if(oinfo.getQuoteinfo()!=null&&oinfo.getQuoteinfo().getGoods()!=null&& DataDic.INSUR_PAYPEOPLE_CAROWNER.equals(oinfo.getQuoteinfo().getGoods().getPaypeople())){
			userInsurance.setUser(user);	
			if(!DataDic.INSUR_PAY.equals(oinfo.getInsurispay())){
				String paytype = DataDic.CONSUMERECODE_WAY_BALANCE;
				consumeRecodBiz.tradeBuyInsurBiz(userInsurance.getId(),user.getId(),Double.valueOf(userInsurance.getInsurancefeel()),paytype);//以支付
				oinfo.setInsurispay(DataDic.INSUR_PAY);
			}
			oinfo.setInsurstatus("2");//已完善
			userInsurance.setStatus("1");
		}else{
			userInsurance.setUser(oinfo.getSeller());
			userInsurance.setStatus("1");
		}
		userInsuranceService.save(userInsurance);
		orderinfoService.save(oinfo);
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setId(oinfo.getId());
		//
		tradeBiz.confrimOrderBiz(orderinfo, model);
		return Tools.getMapResult(result, Tools.statusMessage(result, "确认保单"), userInsurance);
	}
}
