/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.consume;

import java.util.ArrayList;
import java.util.List;


import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BalanceVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.CoinVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ConsumerecodPetrolVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Transfer;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.dao.consume.ConsumerecodDao;

/**
 * 用户交易流水信息表Service
 *
 * @author 饶江龙
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class ConsumerecodService extends CrudService<ConsumerecodDao, Consumerecod> {

    @Autowired
    private ConsumerecodDao consumerecodDao;

    public Consumerecod get(String id) {
        return super.get(id);
    }

    /***
     * 获取当天的统计
     * @return  当天的统计:int类型
     */
    public int daynum(Consumerecod consumerecod){
        return consumerecodDao.daynum(consumerecod);
    }

    /**
     * 保存消费记录
     * @param consumerecod
     * @return
     */
    public int insertSave(Consumerecod consumerecod){
       return consumerecodDao.insert(consumerecod);
    }

    /**
     * 修改交易流水状态,通过交易编号
     * @param consumerecod
     * @return
     */
    @Transactional(readOnly = false)
    public int updateByConsumeStatus(Consumerecod consumerecod){
       return consumerecodDao.updateByConsumeStatus(consumerecod);
    }
    public List<Consumerecod> findList(Consumerecod consumerecod) {
        return super.findList(consumerecod);
    }

    public Page<Consumerecod> findPage(Page<Consumerecod> page, Consumerecod consumerecod) {
        return super.findPage(page, consumerecod);
    }

    @Transactional(readOnly = false)
    public void save(Consumerecod consumerecod) {
        super.save(consumerecod);
    }

    @Transactional(readOnly = false)
    public void delete(Consumerecod consumerecod) {
        super.delete(consumerecod);
    }
    /***
     * 通过账户ID查询个人交易相关记录
     * @param consumerecod  分页查询信息 orderid
     * @return
     */
    public Page<Consumerecod> findDetailById(Page<Consumerecod> page, Consumerecod consumerecod) {
    	consumerecod.setPage(page);
    	page.setList(consumerecodDao.findDetailById(consumerecod));
    	return page;
    }
    
    /***
     * 通过账户ID查询个人交易相关记录
     * @param consumerecod  分页查询信息 orderid
     * @return
     */
    public Page<Consumerecod> findWebDetailById(Page<Consumerecod> page, Consumerecod consumerecod) {
    	consumerecod.setPage(page);
    	page.setList(consumerecodDao.findWebDetailById(consumerecod));
    	return page;
    }
    /**
     * 通过账户ID查询充值统计
     * @param consumerecod
     * @return
     */
    public Consumerecod findCountConsumerecod(Consumerecod consumerecod){
    	return consumerecodDao.findCountConsumerecod(consumerecod);
    	
    }
    
    /**
     * 通过参数类型查询与账户相关的交易流水
     * @param consumerecod
     * @return
     */
    public Page<Consumerecod> findDetailBySearchinfo(Page<Consumerecod> page,Consumerecod consumerecod){
    	consumerecod.setPage(page);
    	return page.setList(consumerecodDao.findDetailBySearchinfo(consumerecod));
    }
    
    /**
     * 通过参数类型查询与账户相关的油气交易流水
     * @param petrolVO
     * @return
     */
    public Page<ConsumerecodPetrolVO> findPetrolDetailBySearchinfo(Page<ConsumerecodPetrolVO> page,ConsumerecodPetrolVO petrolVO){
    	petrolVO.setPage(page);
    	return page.setList(consumerecodDao.findPetrolDetailBySearchinfo(petrolVO));
    }

    public Page<Account> findUserAccount(Page<Account> page, Account account) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
    	account.getSqlMap().put("dsf", dataScopeFilter(account.getCurrentUser(), "o", "a"));
        account.setPage(page);
        // 执行分页查询
        page.setList(consumerecodDao.findUserAccount(account));
        return page;
    }
    public Page<Account> findUserWebAccount(Page<Account> page, Account account) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
    	account.getSqlMap().put("dsf", dataScopeFilter(account.getCurrentUser(), "o", "a"));
        account.setPage(page);
        // 执行分页查询
        page.setList(consumerecodDao.findUserWebAccount(account));
        return page;
    }
    
    

    /**
     * 按模块参数类型获取交易流水列表
     * @param models
     * @param page
     * @param account
     * @return
     */
    public Page<Account> findUserAccountByParameterType(String models,Page<Account> page, Account account) {
        // 生成数据权限过滤条件（dsf为dataScopeFilter的简写，在xml中使用 ${sqlMap.dsf}调用权限SQL）
    	account.getSqlMap().put("dsf", dataScopeFilter(account.getCurrentUser(), "o", "a"));
        account.setPage(page);
        // 执行分页查询
       List<Account> list=new ArrayList<Account>();
       if(models.equals(DataDic.TRADE_PARAMETER_TYPE_RECHARGE)){//充值
    	   list=consumerecodDao.rechargeUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_CASH)){//提现
    	   list=consumerecodDao.cashUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_TRADEORDER)){//运单
    	   list=consumerecodDao.tradeOrderUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_TRANSFER)){//转账
    	   list=consumerecodDao.transferUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_BIDDING)){//竞标
    	   list=consumerecodDao.biddingUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_BID)){//招标
    	   list=consumerecodDao.bidUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_OTHER)){//其他类型
    	   list=consumerecodDao.otherUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_PETROL)){//油气类型
    	   list=consumerecodDao.petrolUserAccount(account);
       }else if(models.equals(DataDic.TRADE_PARAMETER_TYPE_COIN)){//卓币类型
    	   list=consumerecodDao.coinUserAccount(account);
       }
        page.setList(list);
        return page;
    }
    
    /**
     * 通过accountID查询用户本月充值金额
     * @param consumerecod
     * @return
     */
    public Account rechargeUserAccountByMonth(Consumerecod consumerecod){
    	return consumerecodDao.rechargeUserAccountByMonth(consumerecod);
    	
    }
    
    /**
	 * 用户转账列表
	 * 
	 * @param transfer  转账信息
	 * @return
	 */
	public Page<Transfer> transferPage(Page<Transfer> page,Transfer transfer){
		transfer.setPage(page);
    	page.setList(consumerecodDao.transferList(transfer));
    	return page;
	}
	
	/***
	 * 获取当天提现的统计
	 * @return  当天的统计:double类型
	 */
	public String cashDay(Consumerecod consumerecod){
		return consumerecodDao.cashDay(consumerecod);
	}

	/**
     * 通过参数类型查询财务统计
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> findUserBalanceList(UserBalanceVO userBalanceVO){
    	return consumerecodDao.findUserBalanceList(userBalanceVO);
    }
    /**
     * 通过参数类型查询财务统计分析
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> findUserBalanceInfoList(UserBalanceVO userBalanceVO){
    	return consumerecodDao.findUserBalanceInfoList(userBalanceVO);
    }

    /**
     * 通过参数类型查询入账和出账统计分析
     * @param userBalanceVO
     * @return
     */
    public UserBalanceVO findUserBalanceCount(UserBalanceVO userBalanceVO){
        return consumerecodDao.findUserBalanceCount(userBalanceVO);
    }
   
    
    
    
}