package com.thinkgem.jeesite.common.utils;

import java.util.HashMap;
import java.util.Map;
import com.alibaba.fastjson.JSON;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.service.base.BcIdGeneratorService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserAccountService;

public class AccountUtils {

	private static String recEncoding = "UTF-8";
	static UserAccountService accountService = ServiceHelper.getUserAccountService();
	static BcIdGeneratorService idGeneratorService = ServiceHelper.getBcIdGeneratorService();
	
	private static String ACCOUNT_API=Tools.readTxtFileForThread(Const.ACCOUNT_API);
	private static String[] ACCOUNT_APIS=ACCOUNT_API.split(",");
	private static String appId = ACCOUNT_APIS[0];
	private static String appSecret = ACCOUNT_APIS[1];
	private static String accountURL=ACCOUNT_APIS[2];
	
	/*测试环境*/
	/*private static String appId = "00001";
	private static String appSecret = "11EE6F1140254BB0BBF8AEDB395F5908";
	private static String accountURL="http://test.api.money56.com:8090";
	private static String accountURL="http://test.api.money56.com:8090";
	private static String virtAcctTransferurl=accountURL+"/acctsys/rpc/transaction/transfer";
	private static String virtAcctListurl=accountURL+"/acctsys/rpc/account/getList";
	private static String getInfourl=accountURL+"/acctsys/rpc/account/getInfo";
	private static String freezeAccounturl=accountURL+"/acctsys/rpc/transaction/freezeAccount";
	private static String freezeBalanceTransferurl=accountURL+"/acctsys/rpc/transaction/freezeBalanceTransfer";
	private static String getFlowDetailurl=accountURL+"/acctsys/rpc/transaction/getFlowDetail";
	private static String getTradeSettlementurl=accountURL+"/acctsys/rpc/transaction/getTradeSettlement";*/
	
//	private static String appId = "00001";
//	private static String appSecret = "11EE6F1140254BB0BBF8AEDB395F5908";
//	private static String accountURL="http://test.front.money56.com:8090/acctsys/v2/acctclient/account";
//	private static String virtAcctTransferCode="5101";
//	private static String virtAcctListCode="3107";//获取二级完整账户信息
//	private static String getInfoCode="3111";//获取三级账户信息
//	private static String freezeAccounCode="5109";//冻结/解冻账户金额
//	private static String lockAccounCode="5107";//锁定/解锁账户金额
//	private static String freezeBalanceTransferCode="5105";//冻结余额转账
//	private static String lockBalanceTransferCode="5103";//锁定余额转账
//	private static String getFlowDetailCode="5307";//查询单个三级账户流水明细
//	private static String getTradeSettlementCode="5201";//查询业务结算单状态
//	private static String getbanknameListCode="1101";//获取银行列表
//	private static String getfullnameListCode="1103";//获取银行支行列表
	
//	/*生产环境*/
//	private static String appId = "00002";
//	private static String appSecret = "F18FF985B682D3A0D323F9B8D604DE09";
//	private static String accountURL="http://139.129.213.81:6767/acctclient/account";
	
	private static String virtAcctTransferCode="5101";
	private static String virtAcctListCode="3107";//获取二级完整账户信息
	private static String getInfoCode="3111";//获取三级账户信息
	private static String freezeAccounCode="5109";//冻结/解冻账户金额
	private static String lockAccounCode="5107";//锁定/解锁账户金额
	private static String freezeBalanceTransferCode="5105";//冻结余额转账
	private static String lockBalanceTransferCode="5103";//锁定余额转账
	private static String getFlowDetailCode="5307";//查询单个三级账户流水明细
	private static String getTradeSettlementCode="5201";//查询业务结算单状态
	private static String getbanknameListCode="1101";//获取银行列表
	private static String getfullnameListCode="1103";//获取银行支行列表
	
	private static String tranCode_Member_List="3103";//获取单个会员的二、三级完整账户列表（3103）
	private static String tranCode_AllMember_List="3101";//获取单个渠道所有会员信息以及二级账户列表（3101）
	private static String tranCode_trace_List="5303";//查询单个会员历史交易明细（5303）
	private static String tranCode_twoflow_List="5305";//查询单个二级账户流水明细（5305）
	private static String tranCode_treeflow_List="5307";//查询单个三级账户流水明细（5307）
	private static String tranCode_member_info="3105";//获取单个会员的二、三级账户信息列表（3105）
	private static String tranCode_member_application="5001";//会员开户申请（5001）
	private static String tranCode_member_application_info="5001";//查询开户状态（5003）
	
	/**
	 * 获取新 的结算单id
	 * @return
	 */
	public String getTradeSettlementId(){
		return idGeneratorService.getNewCalcId(appId, DataDic.POLICY_DAILY);
	}
	
	/***
	 * 虚拟账户转账
	 * tradeType 1）企业之间虚拟子账号调账；2）企业内部虚拟子账户调账； 3）虚拟账户向实体账户划账（本行）；4）虚拟账户向实体账户划账（跨行）
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object virtAcctTransfer(String tradeType,String fromAccountId,String fromAccountName,String toAccountId,String toAccountName,
			String toAccountNo,String toBankName,String lineNumber,String toBankAddress,String amount,String createUser,String createTime,String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tradeType", tradeType);
		parameters.put("fromAccountId", fromAccountId);
		parameters.put("fromAccountName", fromAccountName);
		parameters.put("amount", amount);
		parameters.put("createUser", createUser);
		parameters.put("outTradeTime", createTime);
		parameters.put("tradeSettlementId", tradeSettlementId);
		if(DataDic.TRANSFER_OUTER.equals(tradeType)||DataDic.TRANSFER_INNER.equals(tradeType)){
			parameters.put("toAccountId", toAccountId);
			parameters.put("toAccountName", toAccountName);
		}else{
			parameters.put("toAccountName", toAccountName);
			parameters.put("toAccountNo", toAccountNo);
			if(DataDic.TRANSFER_OUTER_BANK.equals(tradeType)){
				parameters.put("toBankName", toBankName);
				parameters.put("lineNumber", lineNumber);
				parameters.put("toBankAddress", toBankAddress);
			}
		}
		parameters.put("tranCode", virtAcctTransferCode);
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 获取虚拟子账户列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object virtAcctList(String memberId,String status){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("memberId", memberId);
		if(status!=null){
			parameters.put("accountStatus", status);
		}else{
			parameters.put("accountStatus", 0);
		}
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", virtAcctListCode);
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	/***
	 * 查询三级虚拟账户详细信息
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object getInfo(String memberId,String accountType){
		Map parameters=new HashMap();
		Map params=new HashMap();
		String accountid = accountService.getUserAccountid(memberId, accountType);
		parameters.put("accountId", accountid);
		//parameters.put("accountType", accountType);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", getInfoCode);
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 冻结三级账户的可用金额；解冻三级账户冻结金额
	 * @param tradeType 9：冻结金额       10： 解冻金额
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object freezeAccount(String tradeType,String fromAccountId,String fromAccountName,String amount,String createUser,String createTime,String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("tradeSettlementId", tradeSettlementId);
		parameters.put("tradeType", tradeType);
		parameters.put("accountId", fromAccountId);
		parameters.put("accountName", fromAccountName);
		parameters.put("amount", amount);
		parameters.put("createUser", createUser);
		parameters.put("outTradeTime", createTime);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", freezeAccounCode);
		params.put("acct_data", JSON.toJSONString(parameters));
		
		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	
	/***
	 * 锁定三级账户的可用金额；解锁三级账户锁定金额
	 * @param tradeType 5：锁定金额       6： 解锁金额
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object lockAccount(String tradeType,String fromAccountId,String fromAccountName,String amount,String createUser,String createTime,String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("tradeSettlementId", tradeSettlementId);
		parameters.put("tradeType", tradeType);
		parameters.put("accountId", fromAccountId);
		parameters.put("accountName", fromAccountName);
		parameters.put("amount", amount);
		parameters.put("createUser", createUser);
		parameters.put("outTradeTime", createTime);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", lockAccounCode);
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 冻结余额账户转账
	 * @param tradeType  1企业之间冻结金额向虚拟子账号转账；2企业内部冻结金额向虚拟子账户转账； 3虚拟账户的冻结金额向实体账户划账（本行）；4虚拟账户的冻结金额向实体账户划账（跨行）
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object freezeBalanceTransfer(String tradeType,String fromAccountId,String fromAccountName,String toAccountId,String toAccountName,
			String toAccountNo,String toBankName,String lineNumber,String toBankAddress,String amount,String createUser,String createTime,String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tradeSettlementId", tradeSettlementId);
		parameters.put("tradeType", tradeType);
		parameters.put("fromAccountId", fromAccountId);
		parameters.put("fromAccountName", fromAccountName);
		parameters.put("amount", amount);
		parameters.put("createUser", createUser);
		parameters.put("outTradeTime", createTime);
		if(DataDic.TRANSFER_OUTER.equals(tradeType)||DataDic.TRANSFER_INNER.equals(tradeType)){
			parameters.put("toAccountId", toAccountId);
			parameters.put("toAccountName", toAccountName);
		}else{
			parameters.put("toAccountNo", toAccountNo);
			parameters.put("toAccountName", toAccountName);
			if(DataDic.TRANSFER_OUTER_BANK.equals(tradeType)){
				parameters.put("toBankName", toBankName);
				parameters.put("lineNumber", lineNumber);
				parameters.put("toSubBank", toBankAddress);//收款支行
			}
		}
		parameters.put("tranCode",freezeBalanceTransferCode );
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 锁定余额账户转账
	 * @param tradeType  1企业之间锁定金额向虚拟子账号转账；2企业内部锁定金额向虚拟子账户转账； 3虚拟账户的锁定金额向实体账户划账（本行）；4虚拟账户的锁定金额向实体账户划账（跨行）
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object lockBalanceTransfer(String tradeType,String fromAccountId,String fromAccountName,String toAccountId,String toAccountName,
			String toAccountNo,String toBankName,String lineNumber,String toBankAddress,String amount,String createUser,String createTime,String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tradeType", tradeType);
		parameters.put("fromAccountId", fromAccountId);
		parameters.put("fromAccountName", fromAccountName);
		parameters.put("amount", amount);
		parameters.put("createUser", createUser);
		parameters.put("outTradeTime", createTime);
		parameters.put("tradeSettlementId", tradeSettlementId);
		if(DataDic.TRANSFER_OUTER.equals(tradeType)||DataDic.TRANSFER_INNER.equals(tradeType)){
			parameters.put("toAccountId", toAccountId);
			parameters.put("toAccountName", toAccountName);
		}else{
			parameters.put("toAccountNo", toAccountNo);
			parameters.put("toAccountName", toAccountName);
			if(DataDic.TRANSFER_OUTER_BANK.equals(tradeType)){
				parameters.put("toBankName", toBankName);
				parameters.put("lineNumber", lineNumber);
				parameters.put("toSubBank", toBankAddress);//收款支行
			}
		}
		parameters.put("tranCode",lockBalanceTransferCode );
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询会员台账历史流水明细
	 * @param 
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object getFlowDetail(String memberId,String accountId,String beginDate,String endDate,String tradeType,String page,String rows){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tradeStatus", 0);
		parameters.put("memberId", memberId);
		parameters.put("accountId", accountId);
		parameters.put("beginDate", beginDate);
		parameters.put("endDate", endDate);
		parameters.put("tradeType", tradeType);
		parameters.put("page", page);
		parameters.put("rows", rows);

		parameters.put("tranCode",getFlowDetailCode );
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询业务结算单
	 * @param 
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object getTradeSettlement(String tradeSettlementId){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tradeSettlementId", tradeSettlementId);
		
		parameters.put("tranCode", getTradeSettlementCode);
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}

	/***
	 * 获取银行名称列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object getBankNameList(String keyword,String page,String rows){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", getbanknameListCode);
		parameters.put("keyword", keyword);
		parameters.put("page", page);
		parameters.put("rows", rows);
		
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 获取银行支行列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object getFullNameList(String keyword,String name,String page,String rows){
		Map parameters=new HashMap();
		Map params=new HashMap();
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", getfullnameListCode);
		parameters.put("keyword", keyword);
		parameters.put("name", name);
		parameters.put("page", page);
		parameters.put("rows", rows);
		
		params.put("acct_data", JSON.toJSONString(parameters));

		String result=HttpRequestProxy.doPost(accountURL, params, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 会员开户申请
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberApplication(String type,String name,String idCard,String idCardImg,String bizLicenceNo,String bizLicenceImg,String legalName,String linkMan,String linkMobile,String linkAddress){
		Map parameters=new HashMap();
		
		parameters.put("type", type);
		parameters.put("name", name);
		parameters.put("idCard", idCard);
		parameters.put("bizLicenceNo", bizLicenceNo);
		parameters.put("legalName", legalName);
		parameters.put("linkMan", linkMan);
		parameters.put("linkMobile", linkMobile);
		parameters.put("linkAddress", linkAddress);
		
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_member_application);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询开户状态
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberApplicationInfo(String applyId){
		Map parameters=new HashMap();
		parameters.put("applyId", applyId);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_member_application_info);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	
	
	/***
	 * 获取单个会员的二、三级账户信息列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberInfo(String memberId,String accountStatus){
		Map parameters=new HashMap();
		parameters.put("memberId", memberId);
		parameters.put("accountStatus", accountStatus);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_member_info);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 获取单个会员的二、三级完整账户列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberList(String memberId,String accountStatus){
		Map parameters=new HashMap();
		parameters.put("memberId", memberId);
		parameters.put("accountStatus", accountStatus);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_Member_List);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 获取单个渠道所有会员信息以及二级账户列表
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object allMemberList(String memberStatus,String keyword,int page,int rows){
		Map parameters=new HashMap();
		if(StringUtils.isBlank(memberStatus)){
			memberStatus="0";
		}
		if(StringUtils.isNotBlank(keyword)){
			parameters.put("keyword", keyword);
		}
		parameters.put("memberStatus", memberStatus);
		parameters.put("page", page);
		parameters.put("rows", rows);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_AllMember_List);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询单个会员历史交易明细
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberTraceList(String memberId,String accountId,String beginDate,String endDate,int tradeStatus,int tradeType,int page,int rows){
		Map parameters=new HashMap();
		parameters.put("memberId", memberId);
		if(StringUtils.isNotBlank(accountId)){
			parameters.put("accountId", accountId);
		}
		parameters.put("beginDate", beginDate);
		parameters.put("endDate", endDate);
		
		parameters.put("tradeStatus", tradeStatus);
		parameters.put("tradeType", tradeType);
		
		parameters.put("page", page);
		parameters.put("rows", rows);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_trace_List);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询单个二级账户流水明细
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberTwoFlowList(String accountId,String beginDate,String endDate,int tradeStatus,int tradeType,int page,int rows){
		Map parameters=new HashMap();
	    parameters.put("accountId", accountId);
		parameters.put("beginDate", beginDate);
		parameters.put("endDate", endDate);
		
		parameters.put("tradeStatus", tradeStatus);
		parameters.put("tradeType", tradeType);
		
		parameters.put("page", page);
		parameters.put("rows", rows);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_twoflow_List);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
	
	/***
	 * 查询单个三级账户流水明细
     * @return
     */
	@SuppressWarnings("unchecked")
	public Object memberTreeFlowList(String accountId,String beginDate,String endDate,int tradeStatus,int tradeType,int page,int rows){
		Map parameters=new HashMap();
	    parameters.put("accountId", accountId);
		parameters.put("beginDate", beginDate);
		parameters.put("endDate", endDate);
		
		parameters.put("tradeStatus", tradeStatus);
		parameters.put("tradeType", tradeType);
		
		parameters.put("page", page);
		parameters.put("rows", rows);
		parameters.put("appId", appId);
		parameters.put("appSecret", appSecret);
		parameters.put("tranCode", tranCode_treeflow_List);
		Map data=new HashMap();
		data.put("acct_data", JSON.toJSONString(parameters));
		String result=HttpRequestProxy.doPost(accountURL, data, recEncoding);
		Object json=JSON.parse(result);
		return json;
	}
}
