package com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.integralexchange.Integralexchange;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandarditems;
import com.thinkgem.jeesite.modules.wlpt.service.integralexchange.IntegralexchangeService;

@Service
public class IntegrityExchaneBiz {
	
  @Autowired
  private ConsumeRecodBiz consumeRecodBiz;
  
  @Autowired
  private IntegralexchangeService integralexchangeService;
  
  @Autowired
  private IntegrityBiz integrityBiz;
	
	public  int  integralExchange(String id,int integralss ,int integrityRate) {
		
		return consumeRecodBiz.integralExchange(id,integralss,integrityRate);
	}
	 /**
     * 积分兑换处理
     * @return
     */
    @Transactional(readOnly = false)
    public String exchangeIntegral(int integralss) {
    	User user=UserUtils.getUser();
    	int integrityRate;//积分兑换比例
    	int integralextype;//积分兑换类型
    	int state=0;//返回状态码
    	Userinfo userinfo=user.getUserinfo(); 
    	List<Integralexchange>integralexchangelist =integralexchangeService.findAllList();
    	if(integralexchangelist.size()>0) {
    		System.out.println("=====读取数据=====");
    		Integralexchange integralexchanges= integralexchangelist.get(0);
    		integrityRate = Integer.parseInt(integralexchanges.getExchangerate());
    		integralextype=Integer.parseInt(integralexchanges.getExchangetype());
    	}else {
    		System.out.println("======================写死的数据====================");
    		integrityRate=100;
    		integralextype=0;
    	}
    	//扣除积分

        try {
        	String enename=userinfo.getUser().getUserType();
        	if(Tools.IsNullOrWhiteSpace(userinfo.getUser().getUserType())) {
        		enename=DataDic.ROLE_ENTERPRISE;
        	}
        	IntegrityStandarditems istandar=new IntegrityStandarditems();
        	istandar.setIntegritycode(DataDic.INTEGRITY_POINT_EXCHANGE);
        	IntegrityStandard standard=new IntegrityStandard();
        	standard.setMembertype(enename);
        	istandar.setStandard(standard);
        	state=integrityBiz.deletIntegrityPoint(userinfo,DataDic.INTEGRITY_POINT_EXCHANGE,enename,integralss,istandar);
            if(state==0) {//返回0就是积分没有扣除成功，程序返回
            	return "兑换失败";
            }
        	if(integralextype==0&&state==DataDic.RETURN_STATUS_NORMAL) { // state返回1正常扣除积分，调用增加卓币的方法         integralextype 0 是卓币  
        		state= this.integralExchange(user.getId(),integralss,integrityRate);
        	}
        	
        	if(state==DataDic.RETURN_STATUS_MONEYBUG) {
        		return "积分不足";
        	}
        	if(state==DataDic.RETURN_STATUS_NORMAL) {
        		return "成功兑换"+integralss+"积分" ;
        	}
		} catch (Exception e) {
			e.printStackTrace();
			return "兑换失败";
		}
        return "兑换失败";
    }
}
