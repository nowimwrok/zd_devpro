package com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BscJobAccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.AccountAmount;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.rule.SysTradeRule;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserFlow;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.rule.SysTradeRuleService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserAccountService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserBankinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

@Service
@Transactional(readOnly = true)
public class AccountBiz {
	@Autowired
    private UserBiz userBiz;
	@Autowired
    private UserBankinfoService userBankinfoService;
	@Autowired
    private SysTradeRuleService sysTradeRuleService;
	@Autowired
    private ConsumerecodService consumeRecodService;
	@Autowired
	private WlptUserService wlptUserService;
	@Autowired
	private BscJobAccountBiz bscJobAccountBiz;
	
	@Autowired
    private UserAccountService userAccountService;
	
	
	
    /***
	 * 查询三级虚拟账户详细信息
     * @return
     */
    public JSONObject getInfo(User curUser,String accountType){
    	AccountUtils utils=new AccountUtils();
    	if(Tools.IsNullOrWhiteSpace(curUser.getMemberId())){
    		return null;
    	}
        JSONObject  json= (JSONObject) utils.getInfo(curUser.getMemberId(),accountType);
        if(json==null||!DataDic.RETURN_NORMAL.equals(json.getString("status"))){
        	return null;
        }
        return (JSONObject) json.get("body");
    }
    
    /***
     * 获取账户系统当前状态
     *
     * @param curUser type
     * @return
     */
    public int getlAccountStatus(User curUser){//获取会员账户的电子钱包余额
    	int result=1;
    	AccountUtils utils=new AccountUtils();
    	if(Tools.IsNullOrWhiteSpace(curUser.getMemberId())){
    		return DataDic.RETURN_STATUS_SYSBUG;
    	}
    	JSONObject  json= (JSONObject) utils.getInfo(curUser.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
    	if(json==null||!DataDic.RETURN_NORMAL.equals(json.getString("status"))){
    		if(!DataDic.RETURN_SIGNOUT.equals(json.getString("status"))||!DataDic.RETURN_CHECKOUT.equals(json.getString("status"))){
    			return DataDic.RETURN_STATUS_SYSBUG;
    		}
    		return DataDic.RETURN_STATUS_SYSBUG;
    	}
    	
    	return result;
    }
    
    
    /***
     * 获取会员账户的电子钱包余额
     *
     * @param curUser type
     * @return
     */
    public Double getAmount(User curUser,String type){//获取会员账户的电子钱包余额
    	Double mount=0.00;
    	AccountUtils utils=new AccountUtils();
    	if(Tools.IsNullOrWhiteSpace(curUser.getMemberId())){
    		return mount;
    	}
    	JSONObject  json= (JSONObject) utils.getInfo(curUser.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
    	if(json==null||!DataDic.RETURN_NORMAL.equals(json.getString("status"))){
    		return mount;
    	}
    	JSONObject body=(JSONObject) json.get("body");
    	if(DataDic.AVAILABLE_BALANCE.equals(type)){
    		mount=body.getDouble("availableBalance");
    	}else if(DataDic.UNDETERMINED_BALANCE.equals(type)){
    		mount=body.getDouble("undeterminedBalance");
    	}else if(DataDic.FREEZE_BALANCE.equals(type)){
    		mount=body.getDouble("freezeBalance");
    	}else if(DataDic.LOCK_BALANCE.equals(type)){
    		mount=body.getDouble("lockBalance");
    	}
    	return mount;
    }
    
    /***
     * 获取会员账户的电子钱包余额
     *
     * @param curUser type
     * @return
     */
    public AccountAmount getAccountAmount(User curUser){//获取会员账户的账户金额
    	AccountAmount accountAmount=new AccountAmount();
    	accountAmount.setAvailableBalance(0.0);
    	accountAmount.setFreezeBalance(0.0);
    	accountAmount.setLockBalance(0.0);
    	accountAmount.setUndeterminedBalance(0.0);
    	Double mount=0.00;
    	AccountUtils utils=new AccountUtils();
    	if(Tools.IsNullOrWhiteSpace(curUser.getMemberId())){
    		return accountAmount;
    	}
    	JSONObject  json= (JSONObject) utils.getInfo(curUser.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
    	if(json==null||!DataDic.RETURN_NORMAL.equals(json.getString("status"))){
    		return accountAmount;
    	}
    	JSONObject body=(JSONObject) json.get("body");
    	accountAmount.setAvailableBalance(body.getDouble("availableBalance"));
    	accountAmount.setFreezeBalance(body.getDouble("freezeBalance"));
    	accountAmount.setLockBalance(body.getDouble("lockBalance"));
    	accountAmount.setUndeterminedBalance(body.getDouble("undeterminedBalance"));
    	return accountAmount;
    }
    
    public static void main(String[] args) {
    	AccountBiz accountBiz=new AccountBiz();
    	User user=new User();
    	user.setMemberId("000010000000001");
    	AccountAmount accountAmount =accountBiz.getAccountAmount(user);
    	System.out.println(accountAmount);
    }
    /***
	 * 虚拟账户转账
	 * @param  account
	 * @param  target
	 * @param  memony
	 * @param  tradeType 1）企业之间虚拟子账号调账；2）企业内部虚拟子账户调账； 3）虚拟账户向实体账户划账（本行）；4）虚拟账户向实体账户划账（跨行）
     * @return
     */
    @Transactional(readOnly = false)
    public int virtAcctTransfer(User account,User target,String memony,String tradeType,String targetid,String type,String tradeSettlementId){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	try {
    		int sta = getlAccountStatus(account);
            if(sta!=1){
            	return sta;
            }
            
	    	int check=checkRule(account,memony.toString(),false);
	        if(check!=DataDic.RETURN_STATUS_NORMAL){
	        	return check;
	        }
	        
	    	AccountUtils accountUtils=new AccountUtils();
	        if(Tools.IsNullOrWhiteSpace(account.getMemberId())){
	        	return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject  json1= (JSONObject) accountUtils.getInfo(account.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
	    	if(json1==null||!DataDic.RETURN_NORMAL.equals(json1.getString("status"))){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject accountjson=(JSONObject) json1.get("body");
	    	String fromAccountId=accountjson.getString("accountId");
	    	String fromAccountName=accountjson.getString("accountName");
	    	
	    	String toAccountId=null;
	    	String toAccountName=null;
	    	
	    	if(DataDic.TRANSFER_OUTER.equals(tradeType)||DataDic.TRANSFER_INNER.equals(tradeType)){
	    		if(Tools.IsNullOrWhiteSpace(target.getMemberId())){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	        	}
	    		JSONObject  json2= (JSONObject) accountUtils.getInfo(target.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
	    		if(json2==null){
	    			return DataDic.RETURN_STATUS_ACCOUNTBUG;
	    		}
	        	if(!DataDic.RETURN_NORMAL.equals(json2.getString("status"))){
	        		return DataDic.RETURN_STATUS_SYSBUG;
	        	}
	        	JSONObject targetjson=(JSONObject) json2.get("body");
	        	toAccountId=targetjson.getString("accountId");
	        	toAccountName=targetjson.getString("accountName");
	    	}
	
	    	String toAccountNo=null;
	    	String toBankName=null;
	    	String toBankAddress=null;
	    	String lineNumber=null;
	    	
	    	if(DataDic.TRANSFER_OUTER_BANK.equals(tradeType)||DataDic.TRANSFER_INNER_BANK.equals(tradeType)){
	    		UserBankinfo userBankinfo=userBiz.getUserBankInfo(target);
	            if(userBankinfo==null){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	            }
	            toAccountNo=userBankinfo.getBankcard();
	            toBankName=userBankinfo.getBanktype();
	            toAccountName=userBankinfo.getAccountName();
	            if(Tools.IsNullOrWhiteSpace(toAccountName)||Tools.IsNullOrWhiteSpace(toAccountNo)||Tools.IsNullOrWhiteSpace(toBankName)){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	            }
	            if(toBankName.contains(DataDic.BANK_TYPE)){
	            	tradeType=DataDic.TRANSFER_INNER_BANK;
	            }else{
	            	tradeType=DataDic.TRANSFER_OUTER_BANK;
	            	toBankAddress=userBankinfo.getBankname();
	            	lineNumber=userBankinfo.getUnionpayNo();
	                if(Tools.IsNullOrWhiteSpace(lineNumber)||Tools.IsNullOrWhiteSpace(toBankAddress)){
	                	return DataDic.RETURN_STATUS_SYSBUG;
	                }
	            }
	    	}
	
	    	JSONObject object=(JSONObject)accountUtils.virtAcctTransfer(tradeType, fromAccountId, fromAccountName, toAccountId, toAccountName, toAccountNo, toBankName, lineNumber, toBankAddress, memony, account.getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	    	if(object==null){
	    		String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	    				//保存数据
	        			if(!Tools.IsNullOrWhiteSpace(targetid)){
	        				bscJobAccountBiz.saveJobAccount(account.getId(), targetid, tradeSettlementId, type, DataDic.JOB_ACCOUNT_STATUS_DISPOSE);
	        			}
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}else{
	    			return DataDic.RETURN_STATUS_ACCOUNTBUG;
	    		}
				
			}
	    	
	    	if(!DataDic.RETURN_NORMAL.equals(object.getString("status"))){
	    		if(DataDic.RETURN_BANKBUG.equals(object.getString("status"))){
	    			return DataDic.RETURN_STATUS_BANKBUG;
	    		}
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject body=object.getJSONObject("body");
	    	tradeSettlementId=body.getString("tradeSettlementId");
	    	if(!Tools.IsNullOrWhiteSpace(tradeSettlementId)){
	    		String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	    				//保存数据
	        			if(!Tools.IsNullOrWhiteSpace(targetid)){
	        				bscJobAccountBiz.saveJobAccount(account.getId(), targetid, tradeSettlementId, type, DataDic.JOB_ACCOUNT_STATUS_DISPOSE);
	        			}
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}
	    	}
    	} catch (Exception e) {
    		result = DataDic.RETURN_STATUS_SYSBUG;
			e.printStackTrace();
			// TODO: handle exception
		}
    	return result;
    }
    
    /***
     * 冻结/解冻账户电子钱包余额
     *
     * @param user  tradeType
     * @param menony金额
     * @param tradeType 9：冻结      10：解冻
     * @return
     */
    @Transactional(readOnly = false)
    public int freezeAccount(User user,String menony,String tradeType,String tradeSettlementId){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	try {
    		int sta = getlAccountStatus(user);
            if(sta!=1){
            	return sta;
            }
	    	AccountUtils accountUtils=new AccountUtils();
	    	JSONObject json=this.getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
	    	if(json==null){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	        String fromAccountId=json.getString("accountId");
	        String fromAccountName=json.getString("accountName");
	    	JSONObject object=(JSONObject) accountUtils.freezeAccount(tradeType, fromAccountId, fromAccountName, menony, user.getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	    	if(object==null){
				return DataDic.RETURN_STATUS_ACCOUNTBUG;
			}
	    	if(!DataDic.RETURN_NORMAL.equals(object.getString("status"))){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
    	} catch (Exception e) {
    		result = DataDic.RETURN_STATUS_SYSBUG;
    		e.printStackTrace();
			// TODO: handle exception
		}
    	return result;
    }
    
    
    /***
     * 锁定/解锁账户电子钱包余额
     *
     * @param user  tradeType
     * @param menony金额
     * @param tradeType 5：锁定金额       6： 解锁金额
     * @return
     */
    @Transactional(readOnly = false)
    public int lockAccount(User user,String menony,String tradeType,String tradeSettlementId){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	try {
    		int sta = getlAccountStatus(user);
            if(sta!=1){
            	return sta;
            }
	    	AccountUtils accountUtils=new AccountUtils();
	    	JSONObject json=this.getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
	    	if(json==null){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	        String fromAccountId=json.getString("accountId");
	        String fromAccountName=json.getString("accountName");
	    	JSONObject object=(JSONObject) accountUtils.lockAccount(tradeType, fromAccountId, fromAccountName, menony, user.getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	    	if(object==null){
				return DataDic.RETURN_STATUS_ACCOUNTBUG;
			}
	    	if(!DataDic.RETURN_NORMAL.equals(object.getString("status"))){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
    	} catch (Exception e) {
    		result = DataDic.RETURN_STATUS_SYSBUG;
    		e.printStackTrace();
			// TODO: handle exception
		}
    	return result;
    }
    
    /***
	 * 虚拟账户冻结或锁定金额转账
	 * @param  account
	 * @param  target
	 * @param  memony
	 * @param  tradeType 1）企业之间虚拟子账号调账；2）企业内部虚拟子账户调账； 3）虚拟账户向实体账户划账（本行）；4）虚拟账户向实体账户划账（跨行）
     * @param  isLockWay 是否锁定金额转账  0:否，1：是
     * @return
     */
    @Transactional(readOnly = false)
    public int freezeBalanceTransfer(User account,User target,String memony,String tradeType,String targetid,String type,String tradeSettlementId,String isLockWay){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	try {
    		int sta = getlAccountStatus(account);
            if(sta!=1){
            	return sta;
            }
	    	int check=checkRule(account,memony.toString(),false);
	        if(check!=DataDic.RETURN_STATUS_NORMAL){
	        	return check;
	        }
	    	AccountUtils accountUtils=new AccountUtils();
	    	if(Tools.IsNullOrWhiteSpace(account.getMemberId())){
	        	return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject  json1= (JSONObject) accountUtils.getInfo(account.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
	    	if(json1==null||!DataDic.RETURN_NORMAL.equals(json1.getString("status"))){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject accountjson=(JSONObject) json1.get("body");
	    	String fromAccountId=accountjson.getString("accountId");
	    	String fromAccountName=accountjson.getString("accountName");
	    	
	    	String toAccountId=null;
	    	String toAccountName=null;
	    	
	    	if(DataDic.TRANSFER_OUTER.equals(tradeType)||DataDic.TRANSFER_INNER.equals(tradeType)){
	    		if(Tools.IsNullOrWhiteSpace(target.getMemberId())){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	        	}
	    		JSONObject  json2= (JSONObject) accountUtils.getInfo(target.getMemberId(),DataDic.ELECTRONIC_ACCOUNT);
	        	if(json2==null||!DataDic.RETURN_NORMAL.equals(json2.getString("status"))){
	        		return DataDic.RETURN_STATUS_SYSBUG;
	        	}
	        	JSONObject targetjson=(JSONObject) json2.get("body");
	        	toAccountId=targetjson.getString("accountId");
	        	toAccountName=targetjson.getString("accountName");
	    	}
	    	
	    	String toAccountNo=null;
	    	String toBankName=null;
	    	String toBankAddress=null;
	    	String lineNumber=null;
	    	
	    	if(DataDic.TRANSFER_OUTER_BANK.equals(tradeType)||DataDic.TRANSFER_INNER_BANK.equals(tradeType)){
	    		UserBankinfo userBankinfo=userBiz.getUserBankInfo(target);
	            if(userBankinfo==null){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	            }
	            toAccountNo=userBankinfo.getBankcard();
	            toBankName=userBankinfo.getBanktype();
	            toAccountName=userBankinfo.getAccountName();
	            if(Tools.IsNullOrWhiteSpace(toAccountNo)||Tools.IsNullOrWhiteSpace(toAccountName)||Tools.IsNullOrWhiteSpace(toBankName)){
	            	return DataDic.RETURN_STATUS_SYSBUG;
	            }
	            if(toBankName.contains(DataDic.BANK_TYPE)){
	            	tradeType=DataDic.TRANSFER_INNER_BANK;
	            }else{
	            	tradeType=DataDic.TRANSFER_OUTER_BANK;
	            	toBankAddress=userBankinfo.getBankname();
	            	lineNumber=userBankinfo.getUnionpayNo();
	                if(Tools.IsNullOrWhiteSpace(lineNumber)||Tools.IsNullOrWhiteSpace(toBankAddress)){
	                	return DataDic.RETURN_STATUS_SYSBUG;
	                }
	            }
	    	}
	    	JSONObject json = null;
	    	if(DataDic.YES.equals(isLockWay)){
	    		//转账锁定资金
		        json=(JSONObject) accountUtils.lockBalanceTransfer(tradeType, fromAccountId, fromAccountName, toAccountId, toAccountName, toAccountNo, toBankName, lineNumber, toBankAddress, memony, UserUtils.getUser().getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	    	}else{
	    		//转账冻结资金
		        json=(JSONObject) accountUtils.freezeBalanceTransfer(tradeType, fromAccountId, fromAccountName, toAccountId, toAccountName, toAccountNo, toBankName, lineNumber, toBankAddress, memony, UserUtils.getUser().getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	    	}
	        
	        if(json==null){
	        	String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	    				//保存数据
	        			if(!Tools.IsNullOrWhiteSpace(targetid)){
	        				bscJobAccountBiz.saveJobAccount(account.getId(), targetid, tradeSettlementId, type, DataDic.JOB_ACCOUNT_STATUS_DISPOSE);
	        			}
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}else{
	    				//交易失败和提交失败重新冻结金额
	    				if(DataDic.YES.equals(isLockWay)){
		    				this.lockAccount(account, memony, DataDic.TRANSFER_LOCK,accountUtils.getTradeSettlementId());//锁定
		    			}else{
		    				this.freezeAccount(account, memony, DataDic.TRANSFER_FREEZE,accountUtils.getTradeSettlementId());//冻结
		    			}
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}else{
	    			return DataDic.RETURN_STATUS_ACCOUNTBUG;
	    		}
			}
	    	if(!DataDic.RETURN_NORMAL.equals(json.getString("status"))){
	    		if(DataDic.RETURN_BANKBUG.equals(json.getString("status"))){
	    			if(DataDic.YES.equals(isLockWay)){
	    				this.lockAccount(account, memony, DataDic.TRANSFER_LOCK,accountUtils.getTradeSettlementId());//锁定
	    			}else{
	    				this.freezeAccount(account, memony, DataDic.TRANSFER_FREEZE,accountUtils.getTradeSettlementId());//冻结
	    			}
	        		return DataDic.RETURN_STATUS_BANKBUG;
	        	}
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject body=json.getJSONObject("body");
	    	tradeSettlementId=body.getString("tradeSettlementId");
	    	if(!Tools.IsNullOrWhiteSpace(tradeSettlementId)){
	    		String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	    				//保存数据
	        			if(!Tools.IsNullOrWhiteSpace(targetid)){
	        				bscJobAccountBiz.saveJobAccount(account.getId(), targetid, tradeSettlementId, type, DataDic.JOB_ACCOUNT_STATUS_DISPOSE);
	        			}
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}else{
	    				//交易失败和提交失败重新冻结金额
	    				if(DataDic.YES.equals(isLockWay)){
		    				this.lockAccount(account, memony, DataDic.TRANSFER_LOCK,accountUtils.getTradeSettlementId());//锁定
		    			}else{
		    				this.freezeAccount(account, memony, DataDic.TRANSFER_FREEZE,accountUtils.getTradeSettlementId());//冻结
		    			}
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}
	    	}
    	} catch (Exception e) {
    		result = DataDic.RETURN_STATUS_SYSBUG;
    		e.printStackTrace();
			// TODO: handle exception
		}
        return result;
    }
    
    /***
	 * 个人中心虚拟账户提现
	 * @param  user
	 * @param  menoney
	 * @param  bankId
     * @return
     */
    @Transactional(readOnly = false)
    public int accountCash(User user,String menoney,String bankId,String targetid,String type,String tradeSettlementId,String isLockWay){
    	int result = DataDic.RETURN_STATUS_NORMAL;
    	try{
    		int sta = getlAccountStatus(user);
            if(sta!=1){
            	return sta;
            }
	    	int check=checkRule(user,menoney.toString(),true);
	        if(check!=DataDic.RETURN_STATUS_NORMAL){
	        	return check;
	        }
	    	AccountUtils utils=new AccountUtils();
	    	if(Tools.IsNullOrWhiteSpace(user.getMemberId())){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	        JSONObject fjson=getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
	        if(fjson==null){
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	        
	        String accountId=fjson.getString("accountId");
	        String accountName=fjson.getString("accountName");
	        UserBankinfo userBankinfo=userBankinfoService.get(bankId);
	        if(userBankinfo==null){
	        	return DataDic.RETURN_STATUS_SYSBUG;
	        }
	        String toAccountNo=userBankinfo.getBankcard();
	        String toBankName=userBankinfo.getBanktype();
	        String toAccountName=userBankinfo.getAccountName();
	        if(Tools.IsNullOrWhiteSpace(toAccountNo)||Tools.IsNullOrWhiteSpace(toBankName)||Tools.IsNullOrWhiteSpace(toAccountName)){
	        	return DataDic.RETURN_STATUS_INFOBUG;
	        }
	        String tradeType=null;
	        String lineNumber=null;
	        String toBankAddress=null;
	        if(toBankName.contains(DataDic.BANK_TYPE)){
	        	tradeType=DataDic.TRANSFER_INNER_BANK;
	        }else{
	        	tradeType=DataDic.TRANSFER_OUTER_BANK;
	        	toBankAddress=userBankinfo.getBankname();
	        	lineNumber = userBankinfo.getUnionpayNo();
	            if(Tools.IsNullOrWhiteSpace(lineNumber)||Tools.IsNullOrWhiteSpace(toBankAddress)){
	            	return DataDic.RETURN_STATUS_INFOBUG;
	            }
	        }
	        JSONObject object = null;
	        //转账冻结资金
	        if(DataDic.YES.equals(isLockWay)){
	        	object=(JSONObject) utils.lockBalanceTransfer(tradeType, accountId, accountName, null, toAccountName, toAccountNo, toBankName, lineNumber, toBankAddress, menoney, UserUtils.getUser().getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	        }else{
	        	object=(JSONObject) utils.freezeBalanceTransfer(tradeType, accountId, accountName, null, toAccountName, toAccountNo, toBankName, lineNumber, toBankAddress, menoney, UserUtils.getUser().getLoginName(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()),tradeSettlementId);
	        }
	        if(object==null){
	        	String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}
				return DataDic.RETURN_STATUS_ACCOUNTBUG;
			}
	    	if(!DataDic.RETURN_NORMAL.equals(object.getString("status"))){
	    		if(DataDic.RETURN_BANKBUG.equals(object.getString("status"))){
	    			if(DataDic.YES.equals(isLockWay)){
	    				this.lockAccount(user, menoney, DataDic.TRANSFER_LOCK,utils.getTradeSettlementId());
	    			}else{
	    				this.freezeAccount(user, menoney, DataDic.TRANSFER_FREEZE,utils.getTradeSettlementId());
	    			}
	    			return DataDic.RETURN_STATUS_BANKBUG;
	        	}
	    		return DataDic.RETURN_STATUS_SYSBUG;
	    	}
	    	JSONObject body=object.getJSONObject("body");
	    	tradeSettlementId=body.getString("tradeSettlementId");
	    	if(!Tools.IsNullOrWhiteSpace(tradeSettlementId)){
	    		String status=this.getStatus(tradeSettlementId);
	    		if(!"2".equals(status)){
	    			if("1".equals(status)){
	        			return DataDic.RETURN_STATUS_PAYBUG;//支付等待银行操作
	    			}
	    			return DataDic.RETURN_STATUS_SYSBUG;//支付失败
	    		}
	    	}
    	} catch (Exception e) {
    		result = DataDic.RETURN_STATUS_SYSBUG;
    		e.printStackTrace();
			// TODO: handle exception
		}
    	return result;
    }
    
    /***
     * 电子钱包单日交易总钱--出入帐
     *
     * @param user
     * @return
     */
    public Double getTradeQuotaDay(User user){
    	AccountUtils utils=new AccountUtils();
    	String memberId=user.getMemberId();
    	if(Tools.IsNullOrWhiteSpace(memberId)){
    		return 0.00;
    	}
    	JSONObject json=getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
    	String accountId=json.getString("accountId");
    	Double outer=0.00;
    	Double inner=0.00;
    	JSONObject jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "1", "1", "1");
    	JSONObject bodyOuter=(JSONObject) jsonOuter.get("body");
    	JSONObject paginatorOuter=(JSONObject) bodyOuter.get("paginator");
		String totalCountOuter=paginatorOuter.getString("totalCount");
		if(!totalCountOuter.equals("0")){
			jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "1", "1", totalCountOuter);
			bodyOuter=(JSONObject) jsonOuter.get("body");
			JSONArray arrayOuter=bodyOuter.getJSONArray("records");
			for(Object obj : arrayOuter) {
				JSONObject objJSON = (JSONObject)obj;
				Double amount = objJSON.getDouble("amount")*-1;
				outer=PreciseCompute.add(outer,amount);
			}
		}
		
		JSONObject jsonInner=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "2", "1", "1");
    	JSONObject bodyInner=(JSONObject) jsonInner.get("body");
    	JSONObject paginatorInner=(JSONObject) bodyInner.get("paginator");
		String totalCountInner=paginatorInner.getString("totalCount");
		if(!totalCountInner.equals("0")){
			jsonInner=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "2", "1", totalCountInner);
			bodyInner=(JSONObject) jsonInner.get("body");
			JSONArray arrayInner=bodyInner.getJSONArray("records");
			for(Object obj : arrayInner) {
				JSONObject objJSON = (JSONObject)obj;
				Double amount = objJSON.getDouble("amount");
				inner=PreciseCompute.add(inner,amount);
			}
		}
		
		return PreciseCompute.add(inner,outer);
		
    }
    
    /***
     * 电子钱包当天一开始可用余额
     *
     * @param user
     * @return
     */
    public Double getDayMoney(User user){
    	AccountUtils utils=new AccountUtils();
    	String memberId=user.getMemberId();
    	if(Tools.IsNullOrWhiteSpace(memberId)){
    		return 0.00;
    	}
    	JSONObject json=getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
    	String accountId=json.getString("accountId");
    	Double money=0.00;
    	JSONObject jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "0", "1", "1");
    	JSONObject bodyOuter=(JSONObject) jsonOuter.get("body");
    	JSONObject paginatorOuter=(JSONObject) bodyOuter.get("paginator");
		String totalCountOuter=paginatorOuter.getString("totalCount");
		if(!totalCountOuter.equals("0")){
			jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "0", "1", totalCountOuter);
			bodyOuter=(JSONObject) jsonOuter.get("body");
			JSONArray arrayOuter=bodyOuter.getJSONArray("records");
			JSONObject objJSON = (JSONObject) arrayOuter.get(arrayOuter.size()-1);
			money=objJSON.getDouble("availableBalance");
			return money;
		}else{
			return getAmount(user,DataDic.AVAILABLE_BALANCE);
		}
    }
    
    /***
     * 账户规则检查
     *
     * @param user
     * @return
     */
    public int checkRule(User user,String meney,boolean isCash){
    	int result=DataDic.RETURN_STATUS_NORMAL;
    	if(Tools.IsNullOrWhiteSpace(user.getMemberId())||user.getRule()==null||Tools.IsNullOrWhiteSpace(user.getRule().getId())){
    		return DataDic.RETURN_STATUS_NORMAL;
    	}
    	SysTradeRule sysTradeRule=sysTradeRuleService.get(user.getRule().getId());
    	if(sysTradeRule==null){
    		return DataDic.RETURN_STATUS_NORMAL;
    	}
    	
    	Double amount = Double.valueOf(meney);
    	Double account = getAmount(user,DataDic.AVAILABLE_BALANCE)+getAmount(user,DataDic.UNDETERMINED_BALANCE)+getAmount(user,DataDic.FREEZE_BALANCE)+getAmount(user,DataDic.LOCK_BALANCE);
    	Double amountDay=getTradeQuotaDay(user);
    	Consumerecod consumerecod=new Consumerecod();
    	consumerecod.setAccount(user);
    	consumerecod.setConsumetype(DataDic.CONSUMERECODE_TYPE_CASHMONEY);
    	consumerecod.setConsumestatus(DataDic.CONSUMERECODE_STATUS_SUCCES);
    	consumerecod.setConsumeway(DataDic.CONSUMERECODE_WAY_ACCOUNT);
    	consumerecod.setTimeFlag(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
    	Double dayCash=Double.valueOf(consumeRecodService.cashDay(consumerecod)!=null?consumeRecodService.cashDay(consumerecod):"0.00");
    	
    	Double tradeQuota = Double.valueOf(sysTradeRule.getTradeQuota() != null ? sysTradeRule.getTradeQuota() : "0.00");// 交易限额 单笔交易最高限额
    	//Double tradeCommission = Double.valueOf(sysTradeRule.getTradeCommission() != null ? sysTradeRule.getTradeCommission() : "0.00");// 交易佣金 单笔交易佣金
    	Double lowestAmount = Double.valueOf(sysTradeRule.getLowestAmount() != null ? sysTradeRule.getLowestAmount() : "0.00");// 最低留存额度 电子钱包最低留存额度
    	Double tradeQuotaDay = Double.valueOf(sysTradeRule.getTradeQuotaDay() != null ? sysTradeRule.getTradeQuotaDay() : "0.00");// 单日交易最高限额 单日非同名交易最高限额	
    	
    	Double cashQuota=0.00; // 提现限额 单个账户单日累计提现限额
    	String cashQuotaUnit=sysTradeRule.getCashQuotaUnit(); // 提现限额单位 0：% ,1 ：元
    	if("0".equals(cashQuotaUnit)){
    		cashQuota=PreciseCompute.div(PreciseCompute.mul(getDayMoney(user), Double.valueOf(sysTradeRule.getCashQuota())), 100);
    	}else{
    		cashQuota=Double.valueOf(sysTradeRule.getCashQuota()!= null ?sysTradeRule.getCashQuota():"0.00");
    	}
    	
    	if(amount>tradeQuota){
    		return DataDic.RETURN_STATUS_TRADEQUOTA;
    	}
    	if((account-amount)<lowestAmount){
    		return DataDic.RETURN_STATUS_LOWESTAMOUNT;
    	}
        if(PreciseCompute.add(amountDay,amount)>tradeQuotaDay){
        	return DataDic.RETURN_STATUS_TRADEQUOTADAY;
        }
    	if(isCash){
    		if(PreciseCompute.add(dayCash,amount)>cashQuota){
    			return DataDic.RETURN_STATUS_CASHQUOTA;
    		}
    	}
    	return result;
    }
    /***
     * 获取业务结算单的状态
     *
     * @param user
     * @return
     */
    public String getStatus(String tradeSettlementId){
    	if(Tools.IsNullOrWhiteSpace(tradeSettlementId)){
        	return null;
        }
    	AccountUtils utils=new AccountUtils();
    	JSONObject json=(JSONObject) utils.getTradeSettlement(tradeSettlementId);
    	if(json==null||!"200".equals(json.getString("status"))){
    		return null;
    	}
    	JSONObject body=json.getJSONObject("body");
    	return body.getString("tradeStatus");
    }
    
    /***
     * 用户账号资金变动 推送短信
     *
     * @param
     * @return
     */
    @Transactional(readOnly = false)
    public void pushSms(){
    	AccountUtils utils=new AccountUtils();
    	List<User> memberList=wlptUserService.getMemberList();
    	for(User user:memberList){
    		String memberId=user.getMemberId();
    		String phone=user.getPhone();
    		if(Tools.IsNullOrWhiteSpace(memberId)){
        		continue;
        	}
        	JSONObject json=getInfo(user,DataDic.ELECTRONIC_ACCOUNT);
        	String accountId=json.getString("accountId");
        	JSONObject jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, "2016-12-19", new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "1", "1", "1");
        	JSONObject bodyOuter=(JSONObject) jsonOuter.get("body");
        	JSONObject paginatorOuter=(JSONObject) bodyOuter.get("paginator");
    		String totalCountOuter=paginatorOuter.getString("totalCount");
    		if(!totalCountOuter.equals("0")){
    			jsonOuter=(JSONObject) utils.getFlowDetail(memberId, accountId, "2016-12-19", new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "1", "1", totalCountOuter);
    			bodyOuter=(JSONObject) jsonOuter.get("body");
    			JSONArray arrayOuter=bodyOuter.getJSONArray("records");
    			if(arrayOuter!=null){
	    			for(Object obj : arrayOuter) {
	    				JSONObject objJSON = (JSONObject)obj;
	    				String flowId=objJSON.getString("flowId");
	    				String tradeType=DictUtils.getDictLabel(objJSON.getString("tradeType"), "tradeType", "");
	    				String amount=objJSON.getString("amount");
	    				UserFlow flow=new UserFlow();
	    				flow.setFlowId(flowId);
	    				UserFlow newflow=wlptUserService.getByFlowId(flow);
	    				if(newflow==null){
	    					flow.setContent("尊敬的用户，你的卓大电子钱包"+tradeType+"了一笔资金"+amount+"元。详情请登录www.zhuoda56.com查询。");
	    					wlptUserService.saveFlow(flow);
	    					String[] keyword = {"尊敬的用户,您有一条新的资金流水信息",tradeType,amount};
	    		            User buyer = UserUtils.getByPhone(phone);
	    		            SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_ACCOUNT, buyer.getPhone(),
	    		                    Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null,
	    		                    null, true, SmsConfig.smsCash);
	    				}
	    			}
    			}
    		}
    	}
    }

}
