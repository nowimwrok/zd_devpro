package com.thinkgem.jeesite.modules.wlpt.web.account;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.ruleBiz.SysTradeRuleBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.rule.SysTradeRule;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.MemberVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.TreeFlowVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.TwoFlowVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.traceListVO;
import com.thinkgem.jeesite.modules.wlpt.service.rule.SysTradeRuleService;

/**
 * 账户系统2.0
 * Created by wz
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/account/")
public class SysAccountController extends BaseController{
	@Autowired
	private SysTradeRuleService sysTradeRuleService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private SysTradeRuleBiz sysTradeRuleBiz;
	
	/**
     * 结算单状态查询
     */
	@RequestMapping(value = {"memberSettlement", ""})
    public String memberSettlement(String tradeSettlementId,String flag,Model model) {
		if(StringUtils.isNotBlank(tradeSettlementId)){
			AccountUtils utils = new AccountUtils();
			try{
				JSONObject json = (JSONObject) utils.getTradeSettlement(tradeSettlementId);
				if(json==null){
					model.addAttribute("message", "链接异常");
				}else{
					if("200".equals(json.getString("status"))){
			    		JSONObject body=(JSONObject) json.get("body");
			        	model.addAttribute("result", body);
					}	
				}
			}catch(Exception e){
				model.addAttribute("message", "链接异常");
			}
		}
		model.addAttribute("flag", flag);
		model.addAttribute("tradeSettlementId", tradeSettlementId);
    	return "modules/wlpt/sysAccount/memberSettlement";
    }
	
	/**
     * 我的账户信息
     */
	@ResponseBody
    @RequestMapping(value = "getMemberInfo")
    public Object getMemberInfo(@RequestParam(required=true)String memberId, Model model) {
		AccountUtils utils = new AccountUtils();
		try{
			JSONObject json = (JSONObject) utils.memberList(memberId, "0");
			if(json==null){
				model.addAttribute("message", "链接异常");
			}else{
				if(!"200".equals(json.getString("status"))){
					model.addAttribute("message", json.getString("message"));
				}
		    	JSONObject body=(JSONObject) json.get("body");
		    	JSONArray array = body.getJSONArray("records");
		    	List list = array.subList(0, array.size());
		    	JSONObject json1=(JSONObject) list.get(0);
		    	return new JSONPObject("callback", json1);
			}
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
		}
		return new JSONPObject("callback", null);
    }
	
	/**
     * 我的账户
     */
	@RequestMapping(value = {"myAccountList", ""})
    public String myAccountList(Model model) {
    	String memberId=UserUtils.getUser().getMemberId();
    	if(StringUtils.isBlank(memberId)){
    		model.addAttribute("message", "memberId为空,您不是会员账户");
		}else{
			AccountUtils utils = new AccountUtils();
	    	try{
	    		JSONObject json = (JSONObject) utils.memberList(memberId, "0");
	    		if(json==null){
	    			model.addAttribute("message", "链接异常");
	    		}else{
	    			if(!"200".equals(json.getString("status"))){
	    	    		return "modules/wlpt/sysAccount/myAccount";
	    			}
	    	    	JSONObject body=(JSONObject) json.get("body");
	    	    	JSONArray array = body.getJSONArray("records");
	    	    	List list = array.subList(0, array.size());
	    	    	JSONObject json1=(JSONObject) list.get(0);
	    	    	JSONArray array1 = json1.getJSONArray("slaveAccounts");
	    	    	List list1 = array1.subList(0, array1.size());
	    	    	model.addAttribute("result", json1);
	    	    	model.addAttribute("result1", list1);
	    		}
	    	}catch(Exception e){
	    		model.addAttribute("message", "链接异常");
	    	}
		}
        return "modules/wlpt/sysAccount/myAccount";
    }
	
	/**
     * 账户明细
     */
	@RequestMapping(value = {"accountList", ""})
    public String accountList(String memberId,Model model) {
    	AccountUtils utils = new AccountUtils();
    	try{
    		JSONObject json = (JSONObject) utils.memberList(memberId, "0");
    		if(json==null){
    			model.addAttribute("message", "链接异常");
    		}else{
    			if(!"200".equals(json.getString("status"))){
    				model.addAttribute("message", json.getString("message"));
    			}else{
    				JSONObject body=(JSONObject) json.get("body");
        	    	JSONArray array = body.getJSONArray("records");
        	    	List list = array.subList(0, array.size());
        	    	JSONObject json1=(JSONObject) list.get(0);
        	    	JSONArray array1 = json1.getJSONArray("slaveAccounts");
        	    	List list1 = array1.subList(0, array1.size());
        	    	model.addAttribute("result", json1);
        	    	model.addAttribute("result1", list1);
    			}
    		}
    	}catch(Exception e){
    		model.addAttribute("message", "链接异常");
    	}
    	model.addAttribute("flag", 1);
        return "modules/wlpt/sysAccount/myAccount";
    }
	
	/**
	 * 会员列表
	 * 
	 */
	@RequestMapping(value = {"memberlist", ""})
	public String memberlist(String memberStatus,String keyword, HttpServletRequest request, HttpServletResponse response, Model model) {
		String pageNo = request.getParameter("pageNo");
		String pageSize = request.getParameter("pageSize");
		if(pageNo==null){
			pageNo="1";
		}
		if(pageSize==null){
			pageSize=Global.getConfig("page.pageSize");
		}
		AccountUtils utils=new AccountUtils();
		try{
			JSONObject json=(JSONObject) utils.allMemberList( memberStatus, keyword,Integer.parseInt(pageNo),Integer.parseInt(pageSize));
			if(json==null){
				model.addAttribute("message", "链接异常");
			}else{
				if(!"200".equals(json.getString("status"))){
					model.addAttribute("message", json.getString("message"));
				}else{
					JSONObject body=(JSONObject) json.get("body");
					JSONObject paginator=(JSONObject) body.get("paginator");
					JSONArray array = body.getJSONArray("records");
					List<Map> userList=new ArrayList<>();
					for(Object obj : array) {
						JSONObject objJSON = (JSONObject)obj;
						String memberId = objJSON.get("memberId").toString();
						User mUser=new User();
						mUser.setMemberId(memberId);
						User byCondition = UserUtils.getByCondition(mUser);
						Map map=new HashMap();
						map.put("json", objJSON);
						map.put("user", byCondition);
						userList.add(map);
					}
					int total=paginator.getInteger("totalCount");
					Page pg = new Page(request, response);
					pg.setCount(total);
					pg.setPageNo(Integer.parseInt(pageNo));
					pg.setPageSize(Integer.parseInt(pageSize));
					model.addAttribute("page", pg.setList(userList));
					model.addAttribute("body", body);
					model.addAttribute("memberStatus", memberStatus);
					model.addAttribute("keyword", keyword);
					return "modules/wlpt/sysAccount/menberList";
				}
			}
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
		}
		Page pg = new Page(request, response);
		pg.setCount(0);
		pg.setPageNo(Integer.parseInt(pageNo));
		pg.setPageSize(Integer.parseInt(pageSize));
		model.addAttribute("page", pg.setList(new ArrayList()));
		model.addAttribute("memberStatus", memberStatus);
		model.addAttribute("keyword", keyword);
		return "modules/wlpt/sysAccount/menberList";
	}
	
	/**
	    * 导出会员三级流水列表
	    * @param 
	    * @param request
	    * @param response
	    * @param redirectAttributes
	    * @return
	    */
	    @RequestMapping(value = "exportTreeFlow", method = RequestMethod.POST)
		public Object exportTreeFlow(String accountId,String beginDate,String endDate,String tradeStatus,String tradeType,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
	    	if(StringUtils.isBlank(accountId)){
	    		addMessage(redirectAttributes, "导出用户流水失败！失败信息："+"账户ID错误");
	    	}else{
	    		if(StringUtils.isBlank(beginDate)){
	    			beginDate="2016-01-01";
	    		}
	            if(StringUtils.isBlank(endDate)){
	            	endDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    		}
	            if(StringUtils.isBlank(tradeStatus)){
	            	tradeStatus="0";
	    		}
	            if(StringUtils.isBlank(tradeType)){
	            	tradeType="0";
	    		}
	    		AccountUtils utils=new AccountUtils();
	    		JSONObject json=(JSONObject) utils.memberTreeFlowList(accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,1);
	    		if(!"200".equals(json.getString("status"))){
	    			addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
	    		}else{
	    			JSONObject body=(JSONObject) json.get("body");
	    			JSONObject paginator=(JSONObject) body.get("paginator");
	    			int total=paginator.getInteger("totalCount");
	    			JSONObject result=(JSONObject) utils.memberTreeFlowList(accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,total);
	    			if(!"200".equals(result.getString("status"))){
	    				addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
	    			}else{
	    				JSONObject result_body=(JSONObject) result.get("body");
	    				JSONArray array = result_body.getJSONArray("records");
	    				List<TreeFlowVO> voList=new ArrayList<>();
	    				for(Object obj : array) {
	    					JSONObject objJSON = (JSONObject)obj;
	    					String flowId=objJSON.getString("flowId");
	    					String amount=objJSON.getString("amount");
	    					String availableBalance=objJSON.getString("availableBalance");
	    					String undeterminedBalance=objJSON.getString("undeterminedBalance");
	    					String freezeBalance=objJSON.getString("freezeBalance");
	    					String lockBalance=objJSON.getString("lockBalance");
	    					String oppoAcctId=objJSON.getString("oppoAcctId");
	    					String oppoAcctNo=objJSON.getString("oppoAcctNo");
	    					String oppoAcctName=objJSON.getString("oppoAcctName");
	    					String oppoBankName=objJSON.getString("oppoBankName");
	    					String reversalId=objJSON.getString("reversalId");
	    					String flowStatus=objJSON.getString("flowStatus");
	    					String dealTime=objJSON.getString("dealTime");
	    					
	    					TreeFlowVO treeFlowVO=new TreeFlowVO();
	    					treeFlowVO.setFlowId(flowId);
	    					treeFlowVO.setAccountId(accountId);
	    					treeFlowVO.setTradeType(objJSON.getString("tradeType"));
	    					treeFlowVO.setAmount(amount);
	    					treeFlowVO.setAvailableBalance(availableBalance);
	    					treeFlowVO.setUndeterminedBalance(undeterminedBalance);
	    					treeFlowVO.setFreezeBalance(freezeBalance);
	    					treeFlowVO.setLockBalance(lockBalance);
	    					treeFlowVO.setOppoAcctId(oppoAcctId);
	    					treeFlowVO.setOppoAcctName(oppoAcctName);
	    					treeFlowVO.setOppoAcctNo(oppoAcctNo);
	    					treeFlowVO.setOppoBankName(oppoBankName);
	    					treeFlowVO.setReversalId(reversalId);
	    					treeFlowVO.setFlowStatus(flowStatus);
	    					treeFlowVO.setDealTime(dealTime);
	    					voList.add(treeFlowVO);
	    				}
	    				String fileName = "用户三级流水数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
	    				try{
	    					new ExportExcel("用户三级流水数据", TreeFlowVO.class).setDataList(voList).write(response, fileName).dispose();
	    				}catch (Exception e) {
	    		           addMessage(redirectAttributes, "导出用户三级流水数据失败！失败信息："+e.getMessage());
	    		       }
	    			}
	    		}
	    	}
	    	return "redirect:" + Global.getAdminPath() + "/wlpt/account/memberTreeFlowList?repage";
		}
	
	/**
	    * 导出会员二级流水列表
	    * @param 
	    * @param request
	    * @param response
	    * @param redirectAttributes
	    * @return
	    */
	    @RequestMapping(value = "exportTwoFlow", method = RequestMethod.POST)
		public Object exportTwoFlow(String accountId,String beginDate,String endDate,String tradeStatus,String tradeType,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
	    	if(StringUtils.isBlank(accountId)){
	    		addMessage(redirectAttributes, "导出用户流水失败！失败信息："+"账户ID错误");
	    	}else{
	    		if(StringUtils.isBlank(beginDate)){
	    			beginDate="2016-01-01";
	    		}
	            if(StringUtils.isBlank(endDate)){
	            	endDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    		}
	            if(StringUtils.isBlank(tradeStatus)){
	            	tradeStatus="0";
	    		}
	            if(StringUtils.isBlank(tradeType)){
	            	tradeType="0";
	    		}
	    		AccountUtils utils=new AccountUtils();
	    		JSONObject json=(JSONObject) utils.memberTwoFlowList(accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,1);
	    		if(!"200".equals(json.getString("status"))){
	    			addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
	    		}else{
	    			JSONObject body=(JSONObject) json.get("body");
	    			JSONObject paginator=(JSONObject) body.get("paginator");
	    			int total=paginator.getInteger("totalCount");
	    			JSONObject result=(JSONObject) utils.memberTwoFlowList(accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,total);
	    			if(!"200".equals(result.getString("status"))){
	    				addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
	    			}else{
	    				JSONObject result_body=(JSONObject) result.get("body");
	    				JSONArray array = result_body.getJSONArray("records");
	    				List<TwoFlowVO> voList=new ArrayList<>();
	    				for(Object obj : array) {
	    					JSONObject objJSON = (JSONObject)obj;
	    					String flowId=objJSON.getString("flowId");
	    					String amount=objJSON.getString("amount");
	    					String availableBalance=objJSON.getString("availableBalance");
	    					String undeterminedBalance=objJSON.getString("undeterminedBalance");
	    					String freezeBalance=objJSON.getString("freezeBalance");
	    					String oppoAcctId=objJSON.getString("oppoAcctId");
	    					String oppoAcctNo=objJSON.getString("oppoAcctNo");
	    					String oppoAcctName=objJSON.getString("oppoAcctName");
	    					String oppoBankName=objJSON.getString("oppoBankName");
	    					String reversalId=objJSON.getString("reversalId");
	    					String flowStatus=objJSON.getString("flowStatus");
	    					String dealTime=objJSON.getString("dealTime");
	    					
	    					TwoFlowVO twoFlowVO=new TwoFlowVO();
	    					twoFlowVO.setFlowId(flowId);
	    					twoFlowVO.setAccountId(accountId);
	    					twoFlowVO.setTradeType(objJSON.getString("tradeType"));
	    					twoFlowVO.setAmount(amount);
	    					twoFlowVO.setAvailableBalance(availableBalance);
	    					twoFlowVO.setUndeterminedBalance(undeterminedBalance);
	    					twoFlowVO.setFreezeBalance(freezeBalance);
	    					twoFlowVO.setOppoAcctId(oppoAcctId);
	    					twoFlowVO.setOppoAcctName(oppoAcctName);
	    					twoFlowVO.setOppoAcctNo(oppoAcctNo);
	    					twoFlowVO.setOppoBankName(oppoBankName);
	    					twoFlowVO.setReversalId(reversalId);
	    					twoFlowVO.setFlowStatus(flowStatus);
	    					twoFlowVO.setDealTime(dealTime);
	    					voList.add(twoFlowVO);
	    				}
	    				String fileName = "用户二级流水数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
	    				try{
	    					new ExportExcel("用户二级流水数据", TwoFlowVO.class).setDataList(voList).write(response, fileName).dispose();
	    				}catch (Exception e) {
	    		           addMessage(redirectAttributes, "导出用户二级流水数据失败！失败信息："+e.getMessage());
	    		       }
	    			}
	    		}
	    	}
	    	return "redirect:" + Global.getAdminPath() + "/wlpt/account/memberTwoFlowList?repage";
		}
	
	/**
    * 导出会员交易列表
    * @param 
    * @param request
    * @param response
    * @param redirectAttributes
    * @return
    */
    @RequestMapping(value = "exportTrace", method = RequestMethod.POST)
	public Object exportTrace(String memberId,String accountId,String beginDate,String endDate,String tradeStatus,String tradeType,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
    	if(StringUtils.isBlank(memberId)){
    		addMessage(redirectAttributes, "导出用户失败！失败信息："+"会员ID错误");
    	}else{
    		if(StringUtils.isBlank(beginDate)){
    			beginDate="2016-01-01";
    		}
            if(StringUtils.isBlank(endDate)){
            	endDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    		}
            if(StringUtils.isBlank(tradeStatus)){
            	tradeStatus="0";
    		}
            if(StringUtils.isBlank(tradeType)){
            	tradeType="0";
    		}
    		AccountUtils utils=new AccountUtils();
    		JSONObject json=(JSONObject) utils.memberTraceList(memberId,accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,1);
    		if(!"200".equals(json.getString("status"))){
    			addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
    		}else{
    			JSONObject body=(JSONObject) json.get("body");
    			JSONObject paginator=(JSONObject) body.get("paginator");
    			int total=paginator.getInteger("totalCount");
    			JSONObject result=(JSONObject) utils.memberTraceList(memberId,accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),1,total);
    			if(!"200".equals(result.getString("status"))){
    				addMessage(redirectAttributes, "导出数据失败！失败信息："+"获取数据失败");
    			}else{
    				JSONObject result_body=(JSONObject) result.get("body");
    				JSONArray array = result_body.getJSONArray("records");
    				List<traceListVO> voList=new ArrayList<>();
    				for(Object obj : array) {
    					JSONObject objJSON = (JSONObject)obj;
    				    String tradeSettlementId=objJSON.getString("tradeSettlementId");
    					String amount=objJSON.getString("amount");
    					String outAmount=objJSON.getString("outAmount");
    					String fromAccountId=objJSON.getString("fromAccountId");
    					String fromAccountNo=objJSON.getString("fromAccountNo");
    					String fromAccountName=objJSON.getString("fromAccountName");
    					String toAccountId=objJSON.getString("toAccountId");
    					String toAccountNo=objJSON.getString("toAccountNo");
    					String toAccountName=objJSON.getString("toAccountName");
    					String toBankName=objJSON.getString("toBankName");
    					String tradeStatusTime=objJSON.getString("tradeStatusTime");
    					String remark=objJSON.getString("remark");
    					
    					traceListVO traceListVO=new traceListVO();
    					traceListVO.setTradeSettlementId(tradeSettlementId);
    					traceListVO.setMemberId(memberId);
    					traceListVO.setTradeType(objJSON.getString("tradeType"));
    					traceListVO.setAmount(amount);
    					traceListVO.setOutAmount(outAmount);
    					traceListVO.setFromAccountId(fromAccountId);
    					traceListVO.setFromAccountNo(fromAccountNo);
    					traceListVO.setFromAccountName(fromAccountName);
    					traceListVO.setToAccountId(toAccountId);
    					traceListVO.setToAccountNo(toAccountNo);
    					traceListVO.setToAccountName(toAccountName);
    					traceListVO.setToBankName(toBankName);
    					traceListVO.setTradeStatus(objJSON.getString("tradeStatus"));
    					traceListVO.setTradeStatusTime(tradeStatusTime);
    					traceListVO.setRemark(remark);
    					
    					voList.add(traceListVO);
    				}
    				String fileName = "用户交易数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
    				try{
    					new ExportExcel("用户交易数据", traceListVO.class).setDataList(voList).write(response, fileName).dispose();
    				}catch (Exception e) {
    		           addMessage(redirectAttributes, "导出用户交易数据失败！失败信息："+e.getMessage());
    		       }
    			}
    		}
    	}
    	return "redirect:" + Global.getAdminPath() + "/wlpt/account/traceList?repage";
	}
    
	/**
     * 导出会员用户列表
     * @param 
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
     @RequestMapping(value = "exportMember", method = RequestMethod.POST)
 	public Object exportMember(String memberStatus,String keyword,HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
     	AccountUtils utils=new AccountUtils();
 		JSONObject json=(JSONObject) utils.allMemberList(memberStatus, keyword,1,1);
 		if(!"200".equals(json.getString("status"))){
 			addMessage(redirectAttributes, "导出用户失败！失败信息："+"获取数据失败");
 		}else{
 			JSONObject body=(JSONObject) json.get("body");
 			JSONObject paginator=(JSONObject) body.get("paginator");
 			int total=paginator.getInteger("totalCount");
 			JSONObject result=(JSONObject) utils.allMemberList(memberStatus, keyword,1,total);
 			if(!"200".equals(result.getString("status"))){
 				addMessage(redirectAttributes, "导出用户失败！失败信息："+"获取数据失败");
 			}else{
 				JSONObject result_body=(JSONObject) result.get("body");
 				JSONArray array = result_body.getJSONArray("records");
 				List<MemberVO> voList=new ArrayList<>();
 				for(Object obj : array) {
 					JSONObject objJSON = (JSONObject)obj;
 					JSONObject mainAccounts = objJSON.getJSONObject("mainAccounts");
 					
 					String memberId = objJSON.getString("memberId");
 					String bankAccount = mainAccounts.getString("bankAccount");
 					String accountName = mainAccounts.getString("accountName");
 					String availableBalance = mainAccounts.getString("availableBalance");
 					String undeterminedBalance = mainAccounts.getString("undeterminedBalance");
 					String freezeBalance = mainAccounts.getString("freezeBalance");
 					String name = objJSON.getString("name");
 					String idCard = objJSON.getString("idCard");
 					String createTime = objJSON.getString("createTime");
 					
 					User mUser=new User();
 					mUser.setMemberId(memberId);
 					User byCondition = UserUtils.getByCondition(mUser);
 					String ruleType = byCondition==null?null:(byCondition.getRule()==null?null:byCondition.getRule().getType());
 					
 					MemberVO memberVO = new MemberVO();
 					memberVO.setMemberId(memberId);
 					memberVO.setBankAccount(bankAccount);
 					memberVO.setAccountName(accountName);
 					memberVO.setAvailableBalance(availableBalance);
 					memberVO.setUndeterminedBalance(undeterminedBalance);
 					memberVO.setFreezeBalance(freezeBalance);
 					memberVO.setName(name);
 					memberVO.setIdCard(idCard);
 					memberVO.setMemberStatus(objJSON.getString("memberStatus"));
 					memberVO.setCreateTime(createTime);
 					memberVO.setRuleType(ruleType);
 					voList.add(memberVO);
 				}
 				String fileName = "会员数据"+ DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
 				try{
 					new ExportExcel("会员数据", MemberVO.class).setDataList(voList).write(response, fileName).dispose();
 				}catch (Exception e) {
 		           addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
 		       }
 			}
 		}
 		return "redirect:" + Global.getAdminPath() + "/wlpt/account/memberlist?repage";
 	}
	
	/**
	 * 设置规则
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = {"changeRule", ""})
	public String changeRule(User user, RedirectAttributes redirectAttributes){
		User curuser=UserUtils.get(user.getId());
		if(curuser==null||StringUtils.isBlank(curuser.getId())){
			addMessage(redirectAttributes, "用户不存在");
		}else{
			SysTradeRule rule=sysTradeRuleService.get(user.getRule());
			curuser.setRule(rule);
			systemService.saveUser(curuser);
			addMessage(redirectAttributes, "设置新规则成功");
		}
		return "redirect:" + adminPath + "/wlpt/account/memberlist?repage";
	}
	
	/**
	 * 会员交易列表
	 * 
	 */
	@RequestMapping(value = {"traceList", ""})
	public String traceList(String memberId,String accountId,String beginDate,String endDate,String tradeStatus,String tradeType, HttpServletRequest request, HttpServletResponse response, Model model) {
		String pageNo = request.getParameter("pageNo");
		String pageSize = request.getParameter("pageSize");
		if(pageNo==null){
			pageNo="1";
		}
		if(pageSize==null){
			pageSize=Global.getConfig("page.pageSize");
		}
		if(StringUtils.isBlank(memberId)){
			memberId=UserUtils.getUser().getMemberId();
			if(StringUtils.isBlank(memberId)){
				Page pg = new Page(request, response);
				pg.setCount(0);
				pg.setPageNo(Integer.parseInt(pageNo));
				pg.setPageSize(Integer.parseInt(pageSize));
				model.addAttribute("page", pg.setList(new ArrayList()));
				model.addAttribute("memberId", memberId);
				model.addAttribute("accountId", accountId);
				model.addAttribute("beginDate", beginDate);
				model.addAttribute("endDate", endDate);
				model.addAttribute("tradeStatus", tradeStatus);
				model.addAttribute("tradeType", tradeType);
				return "modules/wlpt/sysAccount/traceList";
			}
		}
		if (StringUtils.isBlank(beginDate)) {
			beginDate = "2016-01-01";
		}
		if (StringUtils.isBlank(endDate)) {
			endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		}
		if (StringUtils.isBlank(tradeStatus)) {
			tradeStatus = "0";
		}
		if (StringUtils.isBlank(tradeType)) {
			tradeType = "0";
		}
		AccountUtils utils=new AccountUtils();
		try{
			JSONObject json=(JSONObject) utils.memberTraceList( memberId, accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),Integer.parseInt(pageNo),Integer.parseInt(pageSize));
			if(json==null||!"200".equals(json.getString("status"))){
				Page pg = new Page(request, response);
				pg.setCount(0);
				pg.setPageNo(Integer.parseInt(pageNo));
				pg.setPageSize(Integer.parseInt(pageSize));
				model.addAttribute("page", pg.setList(new ArrayList()));
				model.addAttribute("memberId", memberId);
				model.addAttribute("accountId", accountId);
				model.addAttribute("beginDate", beginDate);
				model.addAttribute("endDate", endDate);
				model.addAttribute("tradeStatus", tradeStatus);
				model.addAttribute("tradeType", tradeType);
				return "modules/wlpt/sysAccount/traceList";
			}
			JSONObject body=(JSONObject) json.get("body");
			JSONObject paginator=(JSONObject) body.get("paginator");
			JSONArray array = body.getJSONArray("records");
			List list = array.subList(0, array.size());
			
			int total=paginator.getInteger("totalCount");
			Page pg = new Page(request, response);
			pg.setCount(total);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(list));
			model.addAttribute("memberId", memberId);
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/traceList";
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
			Page pg = new Page(request, response);
			pg.setCount(0);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(new ArrayList()));
			model.addAttribute("memberId", memberId);
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/traceList";
		}
	}
	
	/**
	 * 查询单个二级账户流水明细
	 * 
	 */
	@RequestMapping(value = {"memberTwoFlowList", ""})
	public String memberTwoFlowList(String accountId,String beginDate,String endDate,String tradeStatus,String tradeType, HttpServletRequest request, HttpServletResponse response, Model model) {
		String pageNo = request.getParameter("pageNo");
		String pageSize = request.getParameter("pageSize");
		AccountUtils utils=new AccountUtils();
		if(pageNo==null){
			pageNo="1";
		}
		if(pageSize==null){
			pageSize=Global.getConfig("page.pageSize");
		}
		if(accountId==null){
			String memberId=UserUtils.getUser().getMemberId();
			if(StringUtils.isNotBlank(memberId)){
				try{
					JSONObject info=(JSONObject) utils.memberInfo(memberId, "0");
					if(info==null||!"200".equals(info.getString("status"))){
						Page pg = new Page(request, response);
						pg.setCount(0);
						pg.setPageNo(Integer.parseInt(pageNo));
						pg.setPageSize(Integer.parseInt(pageSize));
						model.addAttribute("page", pg.setList(new ArrayList()));
						model.addAttribute("accountId", accountId);
						model.addAttribute("beginDate", beginDate);
						model.addAttribute("endDate", endDate);
						model.addAttribute("tradeStatus", tradeStatus);
						model.addAttribute("tradeType", tradeType);
						return "modules/wlpt/sysAccount/twoFlowList";
					}
					JSONObject info_body=(JSONObject) info.get("body");
					JSONArray info_array = info_body.getJSONArray("records");
					List info_list = info_array.subList(0, info_array.size());
					JSONObject one=(JSONObject) info_list.get(0);
					accountId=one.getString("accountId");
				}catch(Exception e){
					model.addAttribute("message", "链接异常");
					Page pg = new Page(request, response);
					pg.setCount(0);
					pg.setPageNo(Integer.parseInt(pageNo));
					pg.setPageSize(Integer.parseInt(pageSize));
					model.addAttribute("page", pg.setList(new ArrayList()));
					model.addAttribute("accountId", accountId);
					model.addAttribute("beginDate", beginDate);
					model.addAttribute("endDate", endDate);
					model.addAttribute("tradeStatus", tradeStatus);
					model.addAttribute("tradeType", tradeType);
					return "modules/wlpt/sysAccount/twoFlowList";
				}
			}else{
				Page pg = new Page(request, response);
				pg.setCount(0);
				pg.setPageNo(Integer.parseInt(pageNo));
				pg.setPageSize(Integer.parseInt(pageSize));
				model.addAttribute("page", pg.setList(new ArrayList()));
				model.addAttribute("accountId", accountId);
				model.addAttribute("beginDate", beginDate);
				model.addAttribute("endDate", endDate);
				model.addAttribute("tradeStatus", tradeStatus);
				model.addAttribute("tradeType", tradeType);
				return "modules/wlpt/sysAccount/twoFlowList";
			}
		}
		if (StringUtils.isBlank(beginDate)) {
			beginDate = "2016-01-01";
		}
		if (StringUtils.isBlank(endDate)) {
			endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		}
		if (StringUtils.isBlank(tradeStatus)) {
			tradeStatus = "0";
		}
		if (StringUtils.isBlank(tradeType)) {
			tradeType = "0";
		}
		try{
			JSONObject json=(JSONObject) utils.memberTwoFlowList( accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),Integer.parseInt(pageNo),Integer.parseInt(pageSize));
			if(json==null||!"200".equals(json.getString("status"))){
				Page pg = new Page(request, response);
				pg.setCount(0);
				pg.setPageNo(Integer.parseInt(pageNo));
				pg.setPageSize(Integer.parseInt(pageSize));
				model.addAttribute("page", pg.setList(new ArrayList()));
				model.addAttribute("accountId", accountId);
				model.addAttribute("beginDate", beginDate);
				model.addAttribute("endDate", endDate);
				model.addAttribute("tradeStatus", tradeStatus);
				model.addAttribute("tradeType", tradeType);
				return "modules/wlpt/sysAccount/twoFlowList";
			}
			JSONObject body=(JSONObject) json.get("body");
			JSONObject paginator=(JSONObject) body.get("paginator");
			JSONArray array = body.getJSONArray("records");
			List list = array.subList(0, array.size());
			
			int total=paginator.getInteger("totalCount");
			Page pg = new Page(request, response);
			pg.setCount(total);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(list));
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/twoFlowList";
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
			Page pg = new Page(request, response);
			pg.setCount(0);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(new ArrayList()));
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/twoFlowList";
		}
		
	}
	
	/**
	 * 查询单个三级账户流水明细
	 * 
	 */
	@RequestMapping(value = {"memberTreeFlowList", ""})
	public String memberTreeFlowList(String accountId,String beginDate,String endDate,String tradeStatus,String tradeType, HttpServletRequest request, HttpServletResponse response, Model model) {
		String pageNo = request.getParameter("pageNo");
		String pageSize = request.getParameter("pageSize");
		AccountUtils utils=new AccountUtils();
		if(pageNo==null){
			pageNo="1";
		}
		if(pageSize==null){
			pageSize=Global.getConfig("page.pageSize");
		}
		if(StringUtils.isBlank(accountId)){
			Page pg = new Page(request, response);
			pg.setCount(0);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(new ArrayList()));
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/treeFlowList";
		}
		if (StringUtils.isBlank(beginDate)) {
			beginDate = "2016-01-01";
		}
		if (StringUtils.isBlank(endDate)) {
			endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		}
		if (StringUtils.isBlank(tradeStatus)) {
			tradeStatus = "0";
		}
		if (StringUtils.isBlank(tradeType)) {
			tradeType = "0";
		}
		try{
			JSONObject json=(JSONObject) utils.memberTreeFlowList( accountId,beginDate,endDate,Integer.parseInt(tradeStatus),Integer.parseInt(tradeType),Integer.parseInt(pageNo),Integer.parseInt(pageSize));
			if(json==null||!"200".equals(json.getString("status"))){
				Page pg = new Page(request, response);
				pg.setCount(0);
				pg.setPageNo(Integer.parseInt(pageNo));
				pg.setPageSize(Integer.parseInt(pageSize));
				model.addAttribute("page", pg.setList(new ArrayList()));
				model.addAttribute("accountId", accountId);
				model.addAttribute("beginDate", beginDate);
				model.addAttribute("endDate", endDate);
				model.addAttribute("tradeStatus", tradeStatus);
				model.addAttribute("tradeType", tradeType);
				return "modules/wlpt/sysAccount/treeFlowList";
			}
			JSONObject body=(JSONObject) json.get("body");
			JSONObject paginator=(JSONObject) body.get("paginator");
			JSONArray array = body.getJSONArray("records");
			List list = array.subList(0, array.size());
			
			int total=paginator.getInteger("totalCount");
			Page pg = new Page(request, response);
			pg.setCount(total);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(list));
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/treeFlowList";
		}catch(Exception e){
			model.addAttribute("message", "链接异常");
			Page pg = new Page(request, response);
			pg.setCount(0);
			pg.setPageNo(Integer.parseInt(pageNo));
			pg.setPageSize(Integer.parseInt(pageSize));
			model.addAttribute("page", pg.setList(new ArrayList()));
			model.addAttribute("accountId", accountId);
			model.addAttribute("beginDate", beginDate);
			model.addAttribute("endDate", endDate);
			model.addAttribute("tradeStatus", tradeStatus);
			model.addAttribute("tradeType", tradeType);
			return "modules/wlpt/sysAccount/treeFlowList";
		}	
	}
	
	/**
	 * 规则设置
	 * 
	 */
	@RequestMapping(value = "saveRule")
	public String save(Double aTradeQuota, Double bTradeQuota, Double cTradeQuota, Double aTradeCommission,
			Double bTradeCommission, Double cTradeCommission, Double aCashQuotaPc, Double bCashQuotaPc,
			Double cCashQuotaPc, Double aCashQuota, Double bCashQuota, Double cCashQuota, Double aLowestAmount,
			Double bLowestAmount, Double cLowestAmount, Double aTradeQuotaDay, Double bTradeQuotaDay,
			Double cTradeQuotaDay, Model model, RedirectAttributes redirectAttributes) {
		sysTradeRuleBiz.save(aTradeQuota, bTradeQuota, cTradeQuota, aTradeCommission, bTradeCommission,
				cTradeCommission, aCashQuotaPc, bCashQuotaPc, cCashQuotaPc, aCashQuota, bCashQuota, cCashQuota,
				aLowestAmount, bLowestAmount, cLowestAmount, aTradeQuotaDay, bTradeQuotaDay, cTradeQuotaDay);
		addMessage(redirectAttributes, "保存规则成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/account/rule_list?repage";
	}
	
	/**
	 * 规则列表
	 * 
	 */
	@RequestMapping(value = { "rule_list", "" })
	public String list(SysTradeRule sysTradeRule, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		model.addAttribute("ruleA", sysTradeRuleBiz.getBySysTradeRule(DataDic.SYS_TRADE_RULR_A));
		model.addAttribute("ruleB", sysTradeRuleBiz.getBySysTradeRule(DataDic.SYS_TRADE_RULR_B));
		model.addAttribute("ruleC", sysTradeRuleBiz.getBySysTradeRule(DataDic.SYS_TRADE_RULR_C));
		return "modules/wlpt/sysAccount/sysTradeRuleList";
	}
}
