/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.consume;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Transfer;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.BalanceVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.CoinVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.ConsumerecodPetrolVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserBalanceVO;

/**
 * 用户交易流水信息表DAO接口
 * @author 饶江龙
 * @version 2016-08-02
 */
@MyBatisDao
public interface ConsumerecodDao extends CrudDao<Consumerecod> {


    /**
     * 修改交易流水状态,通过交易编号
     * @param consumerecod
     * @return
     */
    int updateByConsumeStatus(Consumerecod consumerecod);
    /**
     * 通过账户ID查询与账户相关的交易
     * @param consumerecod
     * @return
     */
    public List<Consumerecod> findDetailById(Consumerecod consumerecod);
    
    /**
     * 通过账户ID查询与账户相关的交易
     * @param consumerecod
     * @return
     */
    public List<Consumerecod> findWebDetailById(Consumerecod consumerecod);
    
    /**
     * 通过账户ID查询充值统计
     * @param consumerecod
     * @return
     */
    public Consumerecod findCountConsumerecod(Consumerecod consumerecod);
    
    /**
     * 通过参数类型查询与账户相关的交易流水
     * @param consumerecod
     * @return
     */
    public List<Consumerecod> findDetailBySearchinfo(Consumerecod consumerecod);
    
    /**
     * 通过参数类型查询与账户相关的油气交易流水
     * @param consumerecod
     * @return
     */
    public List<ConsumerecodPetrolVO> findPetrolDetailBySearchinfo(ConsumerecodPetrolVO petrolVO);
    
    
	/**
	 * 查找所有账户钱包信息
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> findUserAccount(Account account);

	/**
	 * 查找所有账户钱包信息
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> findUserWebAccount(Account account);

	/**
	 * 用户充值流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> rechargeUserAccount(Account account);

	/**
	 * 用户提现流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> cashUserAccount(Account account);

	/**
	 * 用户运单交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> tradeOrderUserAccount(Account account);

	/**
	 * 用户转账流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> transferUserAccount(Account account);

	/**
	 * 用户竞标交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> biddingUserAccount(Account account);

	/**
	 * 用户招标结算交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> bidUserAccount(Account account);

	/**
	 * 用户其他类型交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> otherUserAccount(Account account);
	
	/**
	 * 用户油气交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> petrolUserAccount(Account account);
	
	/**
	 * 用户卓币交易流水
	 * 
	 * @param user
	 * @return
	 */
	public List<Account> coinUserAccount(Account account);
	
	/**
	 * 用户本月充值金额
	 * 
	 * @param user
	 * @return
	 */
	public Account rechargeUserAccountByMonth(Consumerecod consumerecod);
	
	/**
	 * 用户转账列表
	 * 
	 * @param consumerecod
	 * @return
	 */
	public List<Transfer> transferList(Transfer transfer);

	/***
	 * 获取当天的统计
	 * @return  当天的统计:int类型
	 */
	public int daynum(Consumerecod consumerecod);
	
	/***
	 * 获取当天提现的统计
	 * @return  当天的统计:double类型
	 */
	public String cashDay(Consumerecod consumerecod);
	
	
	 /**
     * 通过参数类型查询财务统计
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> findUserBalanceList(UserBalanceVO userBalanceVO);
    
    /**
     * 通过参数类型查询财务统计分析
     * @param userBalanceVO
     * @return
     */
    public List<UserBalanceVO> findUserBalanceInfoList(UserBalanceVO userBalanceVO);
	/**
	 * 通过参数类型查询入账和出账统计分析
	 * @param userBalanceVO
	 * @return
	 */
	public UserBalanceVO findUserBalanceCount(UserBalanceVO userBalanceVO);
	
}