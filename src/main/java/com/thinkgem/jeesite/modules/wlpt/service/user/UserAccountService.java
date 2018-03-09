/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserAccount;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserAccountDao;

/**
 * 用户账户系统会员管理Service
 * @author zyj
 * @version 2017-05-17
 */
@Service
@Transactional(readOnly = true)
public class UserAccountService extends CrudService<UserAccountDao, UserAccount> {

	@Autowired
	private UserAccountDao userAccountDao;

	public UserAccount get(String id) {
		return super.get(id);
	}


	/**
	 * 根据会员id查找账户系统数据
	 * @param memberId
	 * @return
	 */
	public UserAccount getUserAccount(String memberId){
		return userAccountDao.getUserAccount(memberId);
	}
	
	/**
	 * 根据会员id和类型返回相应的三级账户id
	 * @param memberId
	 * @return
	 */
	public String getUserAccountid(String memberId,String type){
		String accountid = "";
		if(!Tools.IsNullOrWhiteSpace(memberId)&&!Tools.IsNullOrWhiteSpace(type)){
			UserAccount ua =  userAccountDao.getUserAccount(memberId);
			if(ua!=null){
				switch (type) {
	            case DataDic.BORROWER_ACCOUNT:
	            	//还款户id
	            	accountid = ua.getRepaymentId();
	                break;
	            case DataDic.REPAY_ACCOUNT:
	            	//借款户id
	            	accountid = ua.getBorrowerId();
	                break;
	            case DataDic.DIRECT_ACCOUNT:
	            	//定向支付户id
	            	accountid = ua.getRepaymentId();
	                break;
	            case DataDic.ELECTRONIC_ACCOUNT:
	            	//电子钱包id
	            	accountid = ua.getWalletId();
	                break;
	            case DataDic.REGULATORY_ACCOUNT:
	            	//监管户id
	            	accountid = ua.getSupervisorId();
	                break;
	            case DataDic.INNER_ACCOUNT:
	            	//内部户id
	            	accountid = ua.getInternalId();
	                break;

				}
				
			}
		}
		return accountid;
	}
	
	public List<UserAccount> findList(UserAccount userAccount) {
		return super.findList(userAccount);
	}
	
	public Page<UserAccount> findPage(Page<UserAccount> page, UserAccount userAccount) {
		return super.findPage(page, userAccount);
	}
	
	@Transactional(readOnly = false)
	public void save(UserAccount userAccount) {
		super.save(userAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserAccount userAccount) {
		super.delete(userAccount);
	}
	
}