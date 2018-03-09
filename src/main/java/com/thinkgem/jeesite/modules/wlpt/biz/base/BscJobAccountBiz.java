package com.thinkgem.jeesite.modules.wlpt.biz.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJobAccount;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscJobAccountService;

@Service
@Transactional(readOnly = true)
public class BscJobAccountBiz {
	@Autowired
	private BscJobAccountService bscJobAccountService;
	
	
	public BscJobAccount get(String id) {
		return bscJobAccountService.get(id);
	}

	
	
	@Transactional(readOnly = false)
	public void saveJobAccount(String userid ,String targetid, String tradesettlementid,String type,String status) {
		BscJobAccount bscJobAccount = new BscJobAccount();
		User user = new User();
		user.setId(userid);
		bscJobAccount.setUser(user);
		bscJobAccount.setTargetid(targetid);
		bscJobAccount.setTradesettlementid(tradesettlementid);
		bscJobAccount.setType(type);
		bscJobAccount.setStatus(status);
		save(bscJobAccount);
	}
	
	@Transactional(readOnly = false)
	public void updateJobAccount(String tradesettlementid,String status) {
		BscJobAccount bscJobAccount = new BscJobAccount();
		bscJobAccount.setTradesettlementid(tradesettlementid);
		bscJobAccount = bscJobAccountService.findByCondition(bscJobAccount);
		if(bscJobAccount!=null){
			bscJobAccount.setStatus(status);
			save(bscJobAccount);
		}
		
	}
	public List<BscJobAccount> findList(BscJobAccount bscJobAccount) {
		return bscJobAccountService.findList(bscJobAccount);
	}
	
	public Page<BscJobAccount> findPage(Page<BscJobAccount> page, BscJobAccount bscJobAccount) {
		return bscJobAccountService.findPage(page, bscJobAccount);
	}
	
	@Transactional(readOnly = false)
	public void save(BscJobAccount bscJobAccount) {
		bscJobAccountService.save(bscJobAccount);
	}
	
	@Transactional(readOnly = false)
	public void delete(BscJobAccount bscJobAccount) {
		bscJobAccountService.delete(bscJobAccount);
	}
	
}
