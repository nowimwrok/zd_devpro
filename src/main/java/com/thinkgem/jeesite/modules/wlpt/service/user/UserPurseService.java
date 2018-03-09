/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserPurseDao;

/**
 * 用户钱包信息Service
 *
 * @author 饶江龙
 * @version 2016-07-18
 */
@Service
@Transactional(readOnly = true)
public class UserPurseService extends CrudService<UserPurseDao, UserPurse> {

    @Autowired
    private UserPurseDao userPurseDao;
    @Autowired
    private AccountBiz accountBiz;

    public UserPurse get(String id) {
        return super.get(id);
    }


    /***
     * 只修改账户体系中的竞标押金余额
     *
     * @param user         修改的用户对象
     * @param consumeMoney 交易金额
     * @param countWay     类型 0:+ 1:-
     * @return result;
     */

    @Transactional(readOnly = false)
    public int editBidingMoney(User user, Double consumeMoney, String countWay) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_bidmoney = Double.valueOf(upUser.getUserPurse().getBiddingmoney() != null ? upUser.getUserPurse().getBiddingmoney() : 0.00);
        ///计算后的余额
        Double cur_bidmoney = 0.00;
        ///计算后的余额
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_bidmoney = PreciseCompute.add(old_bidmoney, consumeMoney);

        } else {
            cur_bidmoney = PreciseCompute.sub(old_bidmoney, consumeMoney);
        }
        cur_bidmoney = PreciseCompute.round(cur_bidmoney, 2);
        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setBiddingmoney(cur_bidmoney);
        userPurseDao.update(userPurse);
        return result;
    }

    /***
     * 只修改账户体系中的余额
     * 账户的总余额
     *
     * @param user         修改的用户对象
     * @param consumeMoney 交易金额
     * @param countWay     类型 0:+ 1:-
     * @return result;
     */

    @Transactional(readOnly = false)
    public int editWebBalance(User user, Double consumeMoney, String countWay) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Webbalance = upUser.getUserPurse().getWebbalance();
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
        } else {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebbalance(cur_WebBalance);
        userPurseDao.update(userPurse);
        return result;
    }

    /***
     * 只修改账户体系中的冻结资金
     *
     * @param user         修改的用户对象
     * @param consumeMoney 交易金额
     * @param countWay     类型 0:+ 1:-
     * @return result;
     */

    @Transactional(readOnly = false)
    public int editFreeze(User user, Double consumeMoney, String countWay) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Freerze = Double.valueOf(upUser.getUserPurse().getFreezemoney() != null ? upUser.getUserPurse().getFreezemoney() : 0.00);
        ///计算后的余额
        Double cur_Freerze = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_Freerze = PreciseCompute.add(old_Freerze, consumeMoney);
        } else {
            cur_Freerze = PreciseCompute.sub(old_Freerze, consumeMoney);
        }
        cur_Freerze = PreciseCompute.round(cur_Freerze, 2);
        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setFreezemoney(cur_Freerze);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 修改卓币冻结资金
     *
     * @param user         账户
     * @param consumeMoney 消费金额
     * @param countWay     加减
     * @return
     */
    @Transactional(readOnly = false)
    public int editCoinFreeze(User user, Double consumeMoney, String countWay) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Freerze = Double.valueOf(upUser.getUserPurse().getFreezecoin() != null ? upUser.getUserPurse().getFreezecoin() : 0.00);
        ///计算后的余额
        Double cur_Freerze = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_Freerze = PreciseCompute.add(old_Freerze, consumeMoney);
        } else {
            cur_Freerze = PreciseCompute.sub(old_Freerze, consumeMoney);
        }
        cur_Freerze = PreciseCompute.round(cur_Freerze, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setFreezecoin(cur_Freerze);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 修改账户中的可用余额和冻结资金  可用余额减少冻结资金增加
     *
     * @param user         资金变动账户
     * @param consumeMoney 变动资金
     * @param countWay     0:加;1:减
     * @return
     */
    @Transactional(readOnly = false)
    public int editAvbFreeze(User user, Double consumeMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        //账户的冻结资金
        Double old_Freeze = Double.valueOf(upUser.getUserPurse().getFreezemoney()!=null?upUser.getUserPurse().getFreezemoney():0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///冻结资金
        Double cur_Freeze = 0.00;
        ///如果账户体系中可用余额增加则冻结账户余额变动减少
        ///反之,可用余额资金减少,冻结资金增加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.add(old_Available, consumeMoney);
            cur_Freeze = PreciseCompute.sub(old_Freeze, consumeMoney);
        } else {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
            cur_Freeze = PreciseCompute.add(old_Freeze, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cur_Freeze = PreciseCompute.round(cur_Freeze, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebbalance(cur_WebBalance);
        userPurse.setAvailablebalance(cur_Available);
        userPurse.setFreezemoney(cur_Freeze);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 修改账户体系中的可用余额
     * 和账户的总余额
     *
     * @param user         修改的用户对象
     * @param consumeMoney 交易金额
     * @param countWay     类型 0:+ 1:-
     * @return result;
     */

    @Transactional(readOnly = false)
    public int editPureWebBalance(User user, Double consumeMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.add(old_Available, consumeMoney);
        } else {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebbalance(cur_WebBalance);
        userPurse.setAvailablebalance(cur_Available);
        userPurseDao.update(userPurse);

        return result;
    }
    
    /***
     * 修改账户油气
     *
     * @param user         用户
     * @param consumeMoney 消费金额
     * @param countWay     加减
     * @return int1:正常
     */
    @Transactional(readOnly = false)
    public int editPureWebPetro(User user, Double consumeMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
        } else {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setPetrolbalance(cur_WebBalance);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 修改账户可用卓币余额与总余额
     *
     * @param user         用户
     * @param consumeMoney 消费金额
     * @param countWay     加减
     * @return int1:正常
     */
    @Transactional(readOnly = false)
    public int editPureWebCoin(User user, Double consumeMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.add(old_Available, consumeMoney);
        } else {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebcoin(cur_WebBalance);
        userPurse.setAvailablecoin(cur_Available);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 当前用户充值卓币,扣减余额、卓币余额增加
     *
     * @param user         当前用户
     * @param consumeMoney 消费金额
     * @param coinnum      卓币金额
     * @param countWay     加减
     * @return
     */
    @Transactional(readOnly = false)
    public int edidBalanceWebCoin(User user, Double consumeMoney, Double coinnum, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台卓币余额
        Double old_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double old_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double cur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double cur_AvailableCoin = 0.00;
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
            cur_WebCoin = PreciseCompute.add(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.add(old_AvailableCoin, coinnum);

        } else {
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.add(old_Available, consumeMoney);
            cur_WebCoin = PreciseCompute.sub(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.sub(old_AvailableCoin, coinnum);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cur_WebCoin = PreciseCompute.round(cur_WebCoin, 2);
        cur_AvailableCoin = PreciseCompute.round(cur_AvailableCoin, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebcoin(cur_WebCoin);
        userPurse.setAvailablecoin(cur_AvailableCoin);
        userPurse.setWebbalance(cur_WebBalance);
        userPurse.setAvailablebalance(cur_Available);
        userPurseDao.update(userPurse);

        return result;
    }
    
    /***
     * 当前用户充值卓币
     *
     * @param user         当前用户
     * @param user         系统用户
     * @param consumeMoney 消费金额
     * @param coinnum      卓币金额
     * @return
     */
    @Transactional(readOnly = false)
    public int edidBalanceWebCoin(User user,User sysuser, Double consumeMoney, Double coinnum,String consumeway,String id) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台卓币余额
        Double old_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double old_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double cur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double cur_AvailableCoin = 0.00;
        
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        
        if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
        	old_Available=accountBiz.getAmount(upUser, DataDic.AVAILABLE_BALANCE);
        	old_Webbalance=old_Available+accountBiz.getAmount(upUser, DataDic.FREEZE_BALANCE)+accountBiz.getAmount(upUser, DataDic.UNDETERMINED_BALANCE)+accountBiz.getAmount(upUser, DataDic.LOCK_BALANCE);		
        }
        
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        
      ///更新前的平台卓币余额
        Double sold_WebCoin = Double.valueOf(sysuser.getUserPurse().getWebcoin() != null ? sysuser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double sold_AvailableCoin = Double.valueOf(sysuser.getUserPurse().getAvailablecoin() != null ? sysuser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double scur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double scur_AvailableCoin = 0.00;
        
        ///更新前的平台余额
        Double sold_Webbalance = Double.valueOf(sysuser.getUserPurse().getWebbalance() != null ? sysuser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double sold_Available = Double.valueOf(sysuser.getUserPurse().getAvailablebalance() != null ? sysuser.getUserPurse().getAvailablebalance() : 0.00);
        ///计算后的余额
        Double scur_WebBalance = 0.00;
        ///计算后的余额
        Double scur_Available = 0.00;

            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
            cur_WebCoin = PreciseCompute.add(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.add(old_AvailableCoin, coinnum);

            scur_WebBalance = PreciseCompute.add(sold_Webbalance, consumeMoney);
            scur_Available = PreciseCompute.add(sold_Available, consumeMoney);
            scur_WebCoin = PreciseCompute.sub(sold_WebCoin, coinnum);
            scur_AvailableCoin = PreciseCompute.sub(sold_AvailableCoin, coinnum);

        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cur_WebCoin = PreciseCompute.round(cur_WebCoin, 2);
        cur_AvailableCoin = PreciseCompute.round(cur_AvailableCoin, 2);
        
        scur_WebBalance = PreciseCompute.round(scur_WebBalance, 2);
        scur_Available = PreciseCompute.round(scur_Available, 2);
        scur_WebCoin = PreciseCompute.round(scur_WebCoin, 2);
        scur_AvailableCoin = PreciseCompute.round(scur_AvailableCoin, 2);

        if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
        	AccountUtils accountUtils=new AccountUtils();
        	int back=accountBiz.virtAcctTransfer(upUser,sysuser,consumeMoney.toString(),DataDic.TRANSFER_OUTER,id,DataDic.CONSUMERECODE_MODEL_WEBCOIN,accountUtils.getTradeSettlementId());
			if(DataDic.RETURN_STATUS_NORMAL!=back){
				return back;
			}
       
        	UserPurse userPurse = get(upUser.getUserPurse());
            userPurse.setWebcoin(cur_WebCoin);
            userPurse.setAvailablecoin(cur_AvailableCoin);
            
            UserPurse sysuserPurse = get(sysuser.getUserPurse());
            sysuserPurse.setWebcoin(scur_WebCoin);
            sysuserPurse.setAvailablecoin(scur_AvailableCoin);
            
            userPurseDao.update(userPurse);
            userPurseDao.update(sysuserPurse);
        }else{
        	UserPurse userPurse = get(upUser.getUserPurse());
            userPurse.setWebcoin(cur_WebCoin);
            userPurse.setAvailablecoin(cur_AvailableCoin);
            userPurse.setWebbalance(cur_WebBalance);
            userPurse.setAvailablebalance(cur_Available);
            
            UserPurse sysuserPurse = get(sysuser.getUserPurse());
            sysuserPurse.setWebcoin(scur_WebCoin);
            sysuserPurse.setAvailablecoin(scur_AvailableCoin);
            sysuserPurse.setWebbalance(scur_WebBalance);
            sysuserPurse.setAvailablebalance(scur_Available);
            
            userPurseDao.update(userPurse);
            userPurseDao.update(sysuserPurse);
        }

        return result;
    }

    
    /***
     * 当前用户充值卓币
     *
     * @param user         当前用户
     * @param user         系统用户
     * @param consumeMoney 消费金额
     * @param coinnum      卓币金额
     * @return
     */
    @Transactional(readOnly = false)
    public int edidCoin(User user,User sysuser, Double consumeMoney, Double coinnum,String consumeway) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台卓币余额
        Double old_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double old_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double cur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double cur_AvailableCoin = 0.00;
        
        ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        
        if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
        	old_Available=accountBiz.getAmount(upUser, DataDic.AVAILABLE_BALANCE);
        	old_Webbalance=old_Available+accountBiz.getAmount(upUser, DataDic.FREEZE_BALANCE)+accountBiz.getAmount(upUser, DataDic.UNDETERMINED_BALANCE)+accountBiz.getAmount(upUser, DataDic.LOCK_BALANCE);		
        }
        
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        
      ///更新前的平台卓币余额
        Double sold_WebCoin = Double.valueOf(sysuser.getUserPurse().getWebcoin() != null ? sysuser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double sold_AvailableCoin = Double.valueOf(sysuser.getUserPurse().getAvailablecoin() != null ? sysuser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double scur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double scur_AvailableCoin = 0.00;
        
        ///更新前的平台余额
        Double sold_Webbalance = Double.valueOf(sysuser.getUserPurse().getWebbalance() != null ? sysuser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double sold_Available = Double.valueOf(sysuser.getUserPurse().getAvailablebalance() != null ? sysuser.getUserPurse().getAvailablebalance() : 0.00);
        ///计算后的余额
        Double scur_WebBalance = 0.00;
        ///计算后的余额
        Double scur_Available = 0.00;

            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
            cur_WebCoin = PreciseCompute.add(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.add(old_AvailableCoin, coinnum);

            scur_WebBalance = PreciseCompute.add(sold_Webbalance, consumeMoney);
            scur_Available = PreciseCompute.add(sold_Available, consumeMoney);
            scur_WebCoin = PreciseCompute.sub(sold_WebCoin, coinnum);
            scur_AvailableCoin = PreciseCompute.sub(sold_AvailableCoin, coinnum);

        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cur_WebCoin = PreciseCompute.round(cur_WebCoin, 2);
        cur_AvailableCoin = PreciseCompute.round(cur_AvailableCoin, 2);
        
        scur_WebBalance = PreciseCompute.round(scur_WebBalance, 2);
        scur_Available = PreciseCompute.round(scur_Available, 2);
        scur_WebCoin = PreciseCompute.round(scur_WebCoin, 2);
        scur_AvailableCoin = PreciseCompute.round(scur_AvailableCoin, 2);

        if(!Tools.IsNullOrWhiteSpace(user.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(consumeway)){
        	/*int back=accountBiz.virtAcctTransfer(upUser,sysuser,consumeMoney.toString(),DataDic.TRANSFER_OUTER,null,null);
			if(DataDic.RETURN_STATUS_NORMAL!=back){
				return back;
			}*/
       
        	UserPurse userPurse = get(upUser.getUserPurse());
            userPurse.setWebcoin(cur_WebCoin);
            userPurse.setAvailablecoin(cur_AvailableCoin);
            
            UserPurse sysuserPurse = get(sysuser.getUserPurse());
            sysuserPurse.setWebcoin(scur_WebCoin);
            sysuserPurse.setAvailablecoin(scur_AvailableCoin);
            
            userPurseDao.update(userPurse);
            userPurseDao.update(sysuserPurse);
        }

        return result;
    }
    
    
    
    /***
     * 修改充值油气,油气增加、余额就减少
     *
     * @param upUser        消费用户
     * @param petrolMoney 油气金额
     * @param balancenum     余额金额
     * @return 1正常
     */
    @Transactional(readOnly = false)
    public int edidPetrolWebBalance(User upUser,User sysUser, Double petrolMoney, Double balancenum,String paytype) {
        int result = 1;
        ///用户为空,信息缺失
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
      ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        Double oldsys_Webbalance = Double.valueOf(sysUser.getUserPurse().getWebbalance() != null ? sysUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double oldsys_Available = Double.valueOf(sysUser.getUserPurse().getAvailablebalance() != null ? sysUser.getUserPurse().getAvailablebalance() : 0.00);
        if(DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
        	old_Available=accountBiz.getAmount(upUser, DataDic.AVAILABLE_BALANCE);
        	old_Webbalance=old_Available+accountBiz.getAmount(upUser, DataDic.FREEZE_BALANCE)+accountBiz.getAmount(upUser, DataDic.UNDETERMINED_BALANCE)+accountBiz.getAmount(upUser, DataDic.LOCK_BALANCE);
        	oldsys_Available=accountBiz.getAmount(sysUser, DataDic.AVAILABLE_BALANCE);
        	oldsys_Webbalance=old_Available+accountBiz.getAmount(sysUser, DataDic.FREEZE_BALANCE)+accountBiz.getAmount(sysUser, DataDic.UNDETERMINED_BALANCE)+accountBiz.getAmount(sysUser, DataDic.LOCK_BALANCE);
        }
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
      ///计算后的余额
        Double cursys_WebBalance = 0.00;
        ///计算后的余额
        Double cursys_Available = 0.00;
        ///更新前的平台油气余额
        Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的油气余额
        Double cur_WebPetrol = 0.00;
      ///更新前的平台油气余额
        Double oldsys_WebPetrol = Double.valueOf(sysUser.getUserPurse().getPetrolbalance() != null ? sysUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的油气余额
        Double cursys_WebPetrol = 0.00;

            cur_WebPetrol = PreciseCompute.add(old_WebPetrol, petrolMoney);
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, balancenum);
            cur_Available = PreciseCompute.sub(old_Available, balancenum);


            cursys_WebPetrol = PreciseCompute.sub(oldsys_WebPetrol, petrolMoney);
            cursys_WebBalance = PreciseCompute.add(oldsys_Webbalance, balancenum);
            cursys_Available = PreciseCompute.add(oldsys_Available, balancenum);

        cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cursys_WebPetrol = PreciseCompute.round(cursys_WebPetrol, 2);
        cursys_WebBalance = PreciseCompute.round(cursys_WebBalance, 2);
        cursys_Available = PreciseCompute.round(cursys_Available, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        UserPurse sysuserPurse = get(sysUser.getUserPurse());
        if(!Tools.IsNullOrWhiteSpace(upUser.getMemberId())&&DataDic.CONSUMERECODE_WAY_ACCOUNT.equals(paytype)){
        	AccountUtils accountUtils=new AccountUtils();
        	int back=accountBiz.virtAcctTransfer(upUser,sysUser,balancenum.toString(),DataDic.TRANSFER_OUTER,null,null,accountUtils.getTradeSettlementId());
			if(DataDic.RETURN_STATUS_NORMAL!=back){
				return back;
			}
        }else{
        	userPurse.setWebbalance(cur_WebBalance);
            userPurse.setAvailablebalance(cur_Available);
            sysuserPurse.setWebbalance(cursys_WebBalance);
            sysuserPurse.setAvailablebalance(cursys_Available);
        }
        userPurse.setPetrolbalance(cur_WebPetrol);
        sysuserPurse.setPetrolbalance(cursys_WebPetrol);
        userPurseDao.update(userPurse);
        userPurseDao.update(sysuserPurse);

        return result;
    }
    /***
     * 修改充值油气,油气增加、余额就减少
     *
     * @param user        消费用户
     * @param petrolMoney 油气金额
     * @param balancenum     余额金额
     * @param countWay    加减
     * @return 1正常
     */
    @Transactional(readOnly = false)
    public int edidPetrolWebBalance(User user, Double petrolMoney, Double balancenum, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
      ///更新前的平台余额
        Double old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
        ///更新前的可用余额
        Double old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///更新前的平台油气余额
        Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的油气余额
        Double cur_WebPetrol = 0.00;

        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebPetrol = PreciseCompute.add(old_WebPetrol, petrolMoney);
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, balancenum);
            cur_Available = PreciseCompute.sub(old_Available, balancenum);

        } else {
            cur_WebPetrol = PreciseCompute.sub(old_WebPetrol, petrolMoney);
            cur_WebBalance = PreciseCompute.add(old_Webbalance, balancenum);
            cur_Available = PreciseCompute.add(old_Available, balancenum);
        }
        cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);


        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebbalance(cur_WebBalance);
        userPurse.setAvailablebalance(cur_Available);
        userPurse.setPetrolbalance(cur_WebPetrol);
        userPurseDao.update(userPurse);

        return result;
    }
    /***
     * 修改充值油气,油气增加、卓币就减少
     *
     * @param user        消费用户
     * @param petrolMoney 油气金额
     * @param coinnum     卓币金额
     * @param countWay    加减
     * @return 1正常
     */
    @Transactional(readOnly = false)
    public int edidPetrolWebCoin(User user, Double petrolMoney, Double coinnum, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台卓币余额
        Double old_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        ///更新前的可用卓币余额
        Double old_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        ///计算后的卓币余额
        Double cur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double cur_AvailableCoin = 0.00;
        ///更新前的平台油气余额
        Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的油气余额
        Double cur_WebPetrol = 0.00;

        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebPetrol = PreciseCompute.add(old_WebPetrol, petrolMoney);
            cur_WebCoin = PreciseCompute.sub(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.sub(old_AvailableCoin, coinnum);

        } else {
            cur_WebPetrol = PreciseCompute.sub(old_WebPetrol, petrolMoney);
            cur_WebCoin = PreciseCompute.add(old_WebCoin, coinnum);
            cur_AvailableCoin = PreciseCompute.add(old_AvailableCoin, coinnum);
        }
        cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);
        cur_WebCoin = PreciseCompute.round(cur_WebCoin, 2);
        cur_AvailableCoin = PreciseCompute.round(cur_AvailableCoin, 2);


        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebcoin(cur_WebCoin);
        userPurse.setAvailablecoin(cur_AvailableCoin);
        userPurse.setPetrolbalance(cur_WebPetrol);
        userPurseDao.update(userPurse);

        return result;
    }

    /***
     * 修改充值油气,油气增加、卓币就减少
     *
     * @param user        消费用户
     * @param petrolMoney 油气金额
     * @param coinnum     卓币金额
     * @param countWay    加减
     * @return 1正常
     */
    @Transactional(readOnly = false)
    public int edidPetrolWebCoin2(User upUser,User sysUser, Double petrolMoney, Double coinnum) {
        int result = 1;
        ///用户为空,信息缺失
        upUser = UserUtils.findUser(upUser);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///用户为空,信息缺失
        sysUser = UserUtils.findUser(sysUser);
        if (sysUser == null || sysUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        ///更新前的平台卓币余额
        Double upold_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        
        ///更新前的平台卓币余额
        Double sysupold_WebCoin = Double.valueOf(upUser.getUserPurse().getWebcoin() != null ? upUser.getUserPurse().getWebcoin() : 0.00);
        
        ///更新前的可用卓币余额
        Double upold_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        
        ///更新前的可用卓币余额
        Double sysold_AvailableCoin = Double.valueOf(upUser.getUserPurse().getAvailablecoin() != null ? upUser.getUserPurse().getAvailablecoin() : 0.00);
        
        ///计算后的卓币余额
        Double upcur_WebCoin = 0.00;
        ///计算后的卓币余额
        Double syscur_WebCoin = 0.00;
        
        ///计算后的卓币余额
        Double upcur_AvailableCoin = 0.00;
        ///计算后的卓币余额
        Double syscur_AvailableCoin = 0.00;
        
        ///更新前的平台油气余额
        Double upold_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///更新前的平台油气余额
        Double sysold_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        
        ///计算后的油气余额
        Double upcur_WebPetrol = 0.00;
        ///计算后的油气余额
        Double syscur_WebPetrol = 0.00;

        ///加
        upcur_WebPetrol = PreciseCompute.add(upold_WebPetrol, petrolMoney);
        upcur_WebCoin = PreciseCompute.sub(upold_WebCoin, coinnum);
        upcur_AvailableCoin = PreciseCompute.sub(upold_AvailableCoin, coinnum);
        //转换
        upcur_WebPetrol = PreciseCompute.round(upcur_WebPetrol, 2);
        upcur_WebCoin = PreciseCompute.round(upcur_WebCoin, 2);
        upcur_AvailableCoin = PreciseCompute.round(upcur_AvailableCoin, 2);
        
        
        //减
        syscur_WebPetrol = PreciseCompute.sub(sysold_WebPetrol, petrolMoney);
        syscur_WebCoin = PreciseCompute.add(sysupold_WebCoin, coinnum);
        syscur_AvailableCoin = PreciseCompute.add(sysold_AvailableCoin, coinnum);
        //转换
        syscur_WebPetrol = PreciseCompute.round(syscur_WebPetrol, 2);
        syscur_WebCoin = PreciseCompute.round(syscur_WebCoin, 2);
        syscur_AvailableCoin = PreciseCompute.round(syscur_AvailableCoin, 2);

        //油气购买
        UserPurse upuserPurse = get(upUser.getUserPurse());
        upuserPurse.setWebcoin(upcur_WebCoin);
        upuserPurse.setAvailablecoin(upcur_AvailableCoin);
        upuserPurse.setPetrolbalance(upcur_WebPetrol);
        
        //支付油气购买
        UserPurse sysuserPurse = get(sysUser.getUserPurse());
        sysuserPurse.setWebcoin(syscur_WebCoin);
        sysuserPurse.setAvailablecoin(syscur_AvailableCoin);
        sysuserPurse.setPetrolbalance(syscur_WebPetrol);
        
        userPurseDao.update(sysuserPurse);
        userPurseDao.update(upuserPurse);
        

        return result;
    }
    
    
    /***
     * 消费油气金额
     * @param user
     * @param petrolMoney
     * @param countWay
     * @return
     */
    @Transactional(readOnly = false)
    public int consumePetrol(User user, Double petrolMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        ///更新前的平台油气余额
        Double old_WebPetrol = Double.valueOf(upUser.getUserPurse().getPetrolbalance() != null ? upUser.getUserPurse().getPetrolbalance() : 0.00);
        ///计算后的油气余额
        Double cur_WebPetrol = 0.00;

        ///如果是加
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_WebPetrol = PreciseCompute.add(old_WebPetrol, petrolMoney);

        } else {
            cur_WebPetrol = PreciseCompute.sub(old_WebPetrol, petrolMoney);
        }
        cur_WebPetrol = PreciseCompute.round(cur_WebPetrol, 2);


        UserPurse userPurse = get(upUser.getUserPurse());

        userPurse.setPetrolbalance(cur_WebPetrol);
        userPurseDao.update(userPurse);

        return result;
    }

    /**
     * 充值保证金
     * @param user
     * @param consumeMoney
     * @param countWay
     * @return
     */
    @Transactional(readOnly = false)
    public int edidGeunWeb(User user, Double consumeMoney, String countWay) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        
        ///账户保证金
        Double old_Guarant=Double.valueOf(upUser.getUserPurse().getGuaranteemone()!=null?upUser.getUserPurse().getGuaranteemone():0.00);
        Double old_Webbalance =0.00;
        Double old_Available =0.00;
        Double old_Freeze =0.00;
//        if(!Tools.IsNullOrWhiteSpace(upUser.getMemberId())){
//        	old_Available=accountBiz.getAmount(upUser, DataDic.AVAILABLE_BALANCE);
//        	old_Freeze=accountBiz.getAmount(upUser, DataDic.FREEZE_BALANCE);
//        	old_Webbalance=old_Available+old_Freeze+accountBiz.getAmount(upUser, DataDic.UNDETERMINED_BALANCE)+accountBiz.getAmount(upUser, DataDic.LOCK_BALANCE);
//        }else{
        	///更新前的平台余额
            old_Webbalance = Double.valueOf(upUser.getUserPurse().getWebbalance() != null ? upUser.getUserPurse().getWebbalance() : 0.00);
            ///更新前的可用余额
            old_Available = Double.valueOf(upUser.getUserPurse().getAvailablebalance() != null ? upUser.getUserPurse().getAvailablebalance() : 0.00);
            //账户的冻结资金
            old_Freeze = Double.valueOf(upUser.getUserPurse().getFreezemoney()!=null?upUser.getUserPurse().getFreezemoney():0.00);
//        }
        
        ///计算后的余额
        Double cur_WebBalance = 0.00;
        ///计算后的余额
        Double cur_Available = 0.00;
        ///冻结资金
        Double cur_Freeze = 0.00;
        Double cur_Guarant=0.00;
        ///如果账户体系中可用余额增加则冻结账户余额变动减少
        ///反之,可用余额资金减少,冻结资金增加,充值保证金,资金在账户提系中冻结
        if (DataDic.COUNT_WAY_PLUS.equals(countWay)) {
            cur_Guarant= PreciseCompute.add(old_Guarant, consumeMoney);
            cur_WebBalance = PreciseCompute.sub(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.sub(old_Available, consumeMoney);
            cur_Freeze = PreciseCompute.add(old_Freeze, consumeMoney);
        } else {
            cur_Guarant= PreciseCompute.sub(old_Guarant, consumeMoney);
            cur_WebBalance = PreciseCompute.add(old_Webbalance, consumeMoney);
            cur_Available = PreciseCompute.add(old_Available, consumeMoney);
            cur_Freeze = PreciseCompute.sub(old_Freeze, consumeMoney);
        }
        cur_WebBalance = PreciseCompute.round(cur_WebBalance, 2);
        cur_Available = PreciseCompute.round(cur_Available, 2);
        cur_Freeze = PreciseCompute.round(cur_Freeze, 2);
        cur_Guarant = PreciseCompute.round(cur_Guarant, 2);

        UserPurse userPurse = get(upUser.getUserPurse());
        if(DataDic.COUNT_WAY_PLUS.equals(countWay)){//充值
//        	if(!Tools.IsNullOrWhiteSpace(upUser.getMemberId())){
//        		//冻结
//        		int back=accountBiz.freezeAccount(upUser,consumeMoney.toString(),DataDic.TRANSFER_FREEZE);
//            	if(back!=DataDic.RETURN_STATUS_NORMAL){
//            		return back;
//            	}
//            	
//            	userPurse.setGuaranteemone(cur_Guarant);
//                userPurseDao.update(userPurse);
//            }else{
            	userPurse.setWebbalance(cur_WebBalance);
                userPurse.setAvailablebalance(cur_Available);
                userPurse.setFreezemoney(cur_Freeze);
                userPurse.setGuaranteemone(cur_Guarant);
                userPurseDao.update(userPurse);
//            }
        }else{
//        	if(!Tools.IsNullOrWhiteSpace(upUser.getMemberId())){
//        		int back=accountBiz.freezeAccount(upUser,consumeMoney.toString(),DataDic.TRANSFER_UNFREEZE);
//            	if(back!=DataDic.RETURN_STATUS_NORMAL){
//            		return back;
//            	}
//        		
//                userPurse.setGuaranteemone(cur_Guarant);
//                userPurseDao.update(userPurse);
//            }else{
            	userPurse.setWebbalance(cur_WebBalance);
                userPurse.setAvailablebalance(cur_Available);
                userPurse.setFreezemoney(cur_Freeze);
                userPurse.setGuaranteemone(cur_Guarant);
                userPurseDao.update(userPurse);
//            }
        }

        return result;
    }
    
    /**
     * 刷新用户钱包
     * @param user
     * @return
     */
    @Transactional(readOnly = false)
    public int flushWeb(User user,UserPurse purse) {
        int result = 1;
        ///用户为空,信息缺失
        User upUser = UserUtils.findUser(user);
        if (upUser == null || upUser.getUserPurse() == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        UserPurse userPurse = get(upUser.getUserPurse());
        userPurse.setWebbalance(purse.getWebbalance());
        userPurse.setAvailablebalance(purse.getAvailablebalance());
        userPurse.setFreezemoney(purse.getFreezemoney());
        userPurseDao.update(userPurse);
        return result;
    }    

    public List<UserPurse> findList(UserPurse userPurse) {
        return super.findList(userPurse);
    }

    public Page<UserPurse> findPage(Page<UserPurse> page, UserPurse userPurse) {
        return super.findPage(page, userPurse);
    }

    @Transactional(readOnly = false)
    public void save(UserPurse userPurse) {
        super.save(userPurse);
    }

    @Transactional(readOnly = false)
    public void delete(UserPurse userPurse) {
        super.delete(userPurse);
    }

}