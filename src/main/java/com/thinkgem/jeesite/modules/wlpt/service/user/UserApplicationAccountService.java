/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserAccount;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserApplicationAccount;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserAccountDao;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserApplicationAccountDao;

/**
 * 会员账户申请Service
 * @author wz
 * @version 2017-05-19
 */
@Service
@Transactional(readOnly = true)
public class UserApplicationAccountService extends CrudService<UserApplicationAccountDao, UserApplicationAccount> {

	@Autowired
	private UserApplicationAccountDao userApplicationAccountDao;
	@Autowired
    private UserDao userDao;
	@Autowired
	private UserAccountDao userAccountDao;

	public UserApplicationAccount get(String id) {
		return super.get(id);
	}
	
	/**
     * 通过条件查询
     */
	public UserApplicationAccount findByCondition(UserApplicationAccount userApplicationAccount) {
		return userApplicationAccountDao.findByCondition(userApplicationAccount);
	}
	
	/**
     * 定时轮询接口绑定memberID到用户
     */
	@Transactional(readOnly = false)
	public HashMap<String,String> bindAccount(){
		List<UserApplicationAccount> list=this.findList(new UserApplicationAccount());
		HashMap<String,String> resultMap=new HashMap<>();
		String state="1";
		String message="绑定成功";
		for(UserApplicationAccount item:list){
			if(item==null){
				continue;
			}else if(StringUtils.isBlank(item.getAccountStatus())||"1".equals(item.getAccountStatus())||"3".equals(item.getAccountStatus())){//开户状态（-3：审核拒绝；1：审核中；3：已审核；6：已开户）
				String applyid=item.getApplyid();
				if(StringUtils.isBlank(applyid)){//applyid未空，无法轮询
					continue;
				}else{
					AccountUtils utils = new AccountUtils();
					try{
						JSONObject json = (JSONObject) utils.memberApplicationInfo(applyid);//查询开户状态
						if(json==null){
							resultMap.put("state", "-1");
							resultMap.put("message", "链接超时");
							return resultMap;
						}else{
							if("200".equals(json.getString("status"))){
					    		JSONObject body=(JSONObject) json.get("body");
					    		String accountStatus=body.getString("accountStatus");
					    		if(accountStatus.equals(item.getAccountStatus())){//开户状态没有改变则不做操作
					    			continue;
					    		}else if("-3".equals(accountStatus)||"1".equals(accountStatus)||"3".equals(accountStatus)){//仅仅更新开户状态
					    			item.setAccountStatus(accountStatus);
					    			item.setIsBind("0");
								    save(item);//更新申请记录审核状态
					    		}else if("6".equals(accountStatus)){//开户成功，更新状态，绑定memberID到用户，保存6个三级账户id
					    			User target = UserUtils.findUser(item.getUser());
					    			if(StringUtils.isBlank(target.getMemberId())){
					    				target.setMemberId(body.getString("memberId"));
					    				//systemService.saveUser(target);//用户管理memberId
					    				target.preUpdate();
					    			    userDao.updateUserInfo(target);
					    			    //UserUtils.clearCache(target);
					    			    
					    				item.setAccountStatus(accountStatus);
						    			item.setIsBind("1");
									    save(item);//更新申请记录审核状态
									    
									    JSONObject mjson = (JSONObject) utils.memberList(body.getString("memberId"), "0");
									    if(mjson==null){
									    	resultMap.put("state", "-1");
											resultMap.put("message", "链接超时");
											return resultMap;
										}else{
											if(!"200".equals(mjson.getString("status"))){
												continue;
											}else{
												JSONObject mbody=(JSONObject) mjson.get("body");
										    	JSONArray array = mbody.getJSONArray("records");
										    	List mlist = array.subList(0, array.size());
										    	JSONObject json1=(JSONObject) mlist.get(0);
										    	JSONArray array1 = json1.getJSONArray("slaveAccounts");
										    	UserAccount userAccount=new UserAccount();
										    	userAccount.setMemberId(body.getString("memberId"));// 会员id
										    	for(Object obj : array1){
										    		JSONObject objJSON = (JSONObject)obj;
										    		if("1".equals(objJSON.getString("accountType"))){
										    			userAccount.setRepaymentId(objJSON.getString("accountId"));// 还款户id
										    		}else if("2".equals(objJSON.getString("accountType"))){
										    			userAccount.setBorrowerId(objJSON.getString("accountId"));	// 借款户id	
										    		}else if("3".equals(objJSON.getString("accountType"))){
										    			userAccount.setDirectpaymentId(objJSON.getString("accountId"));		// 定向支付户id
										    		}else if("4".equals(objJSON.getString("accountType"))){
										    			userAccount.setWalletId(objJSON.getString("accountId"));		// 电子钱包账户id
										    		}else if("5".equals(objJSON.getString("accountType"))){
										    			userAccount.setSupervisorId(objJSON.getString("accountId"));		// 监管户
										    		}else if("6".equals(objJSON.getString("accountType"))){
										    			userAccount.setInternalId(objJSON.getString("accountId"));		// 内部户
										    		}
										    	}
										    	userAccount.setId(IdGen.uuid());
										    	userAccount.setIsNewRecord(true);
										    	userAccount.preInsert();
										    	userAccountDao.insert(userAccount);//保存各种账户id
											}
										}
					    			}else{
					    				continue;
					    			}
					    		}else{
					    			continue;
					    		}
							}else{
								continue;
							}
						}
					}catch(Exception e){
						e.printStackTrace();
						resultMap.put("state", "-1");
						resultMap.put("message", "链接超时");
						return resultMap;
					}
				}
			}else{
				continue;
			}
		}
		resultMap.put("state", state);
		resultMap.put("message", message);
		return resultMap;
	}

	public List<UserApplicationAccount> findList(UserApplicationAccount userApplicationAccount) {
		return super.findList(userApplicationAccount);
	}
	
	public Page<UserApplicationAccount> findPage(Page<UserApplicationAccount> page, UserApplicationAccount userApplicationAccount) {
		return super.findPage(page, userApplicationAccount);
	}
	
	@Transactional(readOnly = false)
	public void save(UserApplicationAccount userApplicationAccount) {
		super.save(userApplicationAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserApplicationAccount userApplicationAccount) {
		super.delete(userApplicationAccount);
	}
	
}