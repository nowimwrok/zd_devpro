package com.thinkgem.jeesite.modules.wlpt.biz.base;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.bidBiz.BidOrderBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;

@Service
@Transactional(readOnly = true)
public class JobAccountBiz {
	@Autowired
	private BscJobAccountBiz bscJobAccountBiz;
	
	@Autowired
    private AccountBiz accountBiz;
	
	@Autowired
    private TradeBiz tradeBiz;
	
	@Autowired
    private BidOrderBiz bidOrderBiz;
	
	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;
	
	@Transactional(readOnly = false)
	public void ProcessingJobInfo(){
		//获取所有处理中的数据
		BscJobAccount bscJobAccount = new BscJobAccount();
		bscJobAccount.setStatus(DataDic.JOB_ACCOUNT_STATUS_DISPOSE);
		List<BscJobAccount> list = bscJobAccountBiz.findList(bscJobAccount);
		if(CollectionUtils.isNotEmpty(list) && list.size()>0){
			//循环处理数据
			for (BscJobAccount job : list) {
				if(job!=null && !Tools.IsNullOrWhiteSpace(job.getTradesettlementid())){
					String status = accountBiz.getStatus(job.getTradesettlementid());
					int state = DataDic.RETURN_STATUS_NORMAL;
					if(!"1".equals(status)){//不是处理中状态
						
						if("2".equals(status)){//如果已经支付成功
							
							//根据类型做相关处理
			    			if(DataDic.CONSUMERECODE_MODEL_TRADEORDER.equals(job.getType())){//运单
			    				state = tradeBiz.saveOrderinfoEnd(job,2);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_SETTLEORDER.equals(job.getType())){//招标
			    				state = bidOrderBiz.payBidOrderMoneyBiz(job,2);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_CASH.equals(job.getType())){//提现
			    				state = consumeRecodBiz.backCashRecodeBiz(job.getTargetid(),3);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_TRANCF.equals(job.getType())){//转账
			    				state = consumeRecodBiz.transferinfoBiz(job.getTargetid(),2);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_WEBCOIN.equals(job.getType())){//卓笔
			    				
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_PETROL.equals(job.getType())){//油气
			    				
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_INSUR.equals(job.getType())){//保险
			    				state = consumeRecodBiz.editInsurinfoBiz(job.getTargetid(),2);
			    				
			    			}
			    			
			    			
			    		}else{//处理交易失败
			    				
			    			//根据类型做相关处理
			    			if(DataDic.CONSUMERECODE_MODEL_TRADEORDER.equals(job.getType())){//运单
			    				state = tradeBiz.saveOrderinfoEnd(job,-1);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_SETTLEORDER.equals(job.getType())){//招标
			    				state = bidOrderBiz.payBidOrderMoneyBiz(job,-1);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_CASH.equals(job.getType())){//提现
			    				state = consumeRecodBiz.backCashRecodeBiz(job.getTargetid(),-1);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_TRANCF.equals(job.getType())){//转账
			    				state = consumeRecodBiz.transferinfoBiz(job.getTargetid(),-1);
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_WEBCOIN.equals(job.getType())){//卓笔
			    				
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_PETROL.equals(job.getType())){//油气
			    				
			    				
			    			}else if(DataDic.CONSUMERECODE_MODEL_INSUR.equals(job.getType())){//保险
			    				state = consumeRecodBiz.editInsurinfoBiz(job.getTargetid(),-1);
			    				
			    			}
			    		}
					
						//判断是否处理完毕
		    			if(state == DataDic.RETURN_STATUS_NORMAL){
							bscJobAccountBiz.updateJobAccount(job.getTradesettlementid(), DataDic.JOB_ACCOUNT_STATUS_END);//修改数据为处理完毕
						}
					}
				}
				
			}
		}
		
	}

}
