/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.consume;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.dao.consume.ConsumeauditDao;
import com.thinkgem.jeesite.modules.wlpt.dao.consume.ConsumerecodDao;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.util.List;

/**
 * 后台账户充值，管理审核Service
 *
 * @author 饶江龙
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class ConsumeauditService extends CrudService<ConsumeauditDao, Consumeaudit> {

    @Autowired
    private ConsumeauditDao consumeauditDao;

    @Autowired
    private ConsumerecodDao consumerecodDao;

    @Autowired
    private DeallogService deallogService;


    public Consumeaudit get(String id) {
        return super.get(id);
    }








    /***
     * 后台充值
     *
     * @param consumeaudit
     */
    @Transactional(readOnly = false)
    public Boolean recharge(Consumeaudit consumeaudit, Model model) {
        /////获取充值用户信息
        User account = consumeaudit.getUser();
        account = UserUtils.getUserBySearch(account.getPhone());
        if (account == null || Tools.IsNullOrWhiteSpace(account.getPhone())) {
            model.addAttribute("message", "充值用户信息不存在");
            return false;
        }
        consumeaudit.setUser(account);
        ///如果是系统账户充值
        if (DataDic.CONSUMEAUDIT_SYSRECHARGE.equals(consumeaudit.getType())) {

            sysaccountRecharge(consumeaudit);

            ///普通账户充值
        } else if (DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE.equals(consumeaudit.getType())) {

            accountRecharge(consumeaudit);
        }
        return true;

    }

    ///用户充值

    /***
     * 后台账户充值新增记录----新记录不做状态修改,不做资金的变动
     *
     * @param consumeaudit
     */
    @Transactional(readOnly = false)
    public void accountRecharge(Consumeaudit consumeaudit) {
        ////充值用户
        User account = consumeaudit.getUser();
        ////系统账户
        String sysaccount_phone = Tools.readTxtFile(Const.SYSACCOUNT);
        User sysaccount = UserUtils.getUserBySearch(sysaccount_phone);
        ///当前充值金额
        Double rechargeMoney = Double.parseDouble(consumeaudit.getConsume().getConsumemony());

        ///充值账户当前账户余额
        Double account_webbalance = account.getUserPurse().getWebbalance();
        ///当前充值账户可用余额
        Double account_available = account.getUserPurse().getAvailablebalance();

        ///获取系统账户--账户余额
        Double sysaccount_webalance = sysaccount.getUserPurse().getWebbalance();

        ///当前充值账户充值后的账户余额
        Double cur_account_webbalance = account_webbalance + rechargeMoney;
        ///当前充值账户充值后的可用余额
        Double cur_account_available = account_available + rechargeMoney;

        ////系统账户给充值账户充值后的账户余额
        Double cur_sysaccount_webbalance = sysaccount_webalance + rechargeMoney;


        ///充值账户的交易记录
        Consumerecod accountrecode = new Consumerecod();
        ///赋值主键-创建者
        accountrecode.preInsert();
        ///消费账户
        accountrecode.setAccount(sysaccount);
        accountrecode.setSysaccount(sysaccount);///系统账户
        ///充值目标
        accountrecode.setTarget(account);///目标账户

        ///账户余额充值类型==获取到交易流水
        accountrecode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.CONSUMERECODE_MODEL_ACCOUNT));
        accountrecode.setPaycode(accountrecode.getConsumecode());
        accountrecode.setBeforemony(account_webbalance.toString());
        accountrecode.setAftermony(cur_account_webbalance.toString());
        accountrecode.setConsumemony(rechargeMoney.toString());
        ///流出账户的消费前后信息  后台充值的为系统账户流水
        accountrecode.setFlowafter(cur_sysaccount_webbalance.toString());
        accountrecode.setFlowbefore(sysaccount_webalance.toString());

        ///赋值--交易状态--交易方式--交易类型
        accountrecode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_CONING);
        accountrecode.setConsumeway(DataDic.CONSUMERECODE_WAY_BALANCE);
        accountrecode.setConsumetype(DataDic.CONSUMERECODE_TYPE_BALANACE);
        accountrecode.setTrademodel(DataDic.CONSUMERECODE_MODEL_ACCOUNT);

        ///交易描述
        accountrecode.setConsumewaydesp(sysaccount.getLoginName() + "充值:" +account.getLoginName()+ rechargeMoney + "元");
        ///系统后台充值
        accountrecode.setScantype(DataDic.SCANTYPE_BACK);
        accountrecode.setIssysrecode(DataDic.ISSYSRECODE_NO);

        ///后台充值审核记录
        consumeaudit.preInsert();
        consumeaudit.setUser(account);

        ///新的审核信息
        consumeaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT);
        ///对应的交易流水
        consumeaudit.setConsume(accountrecode);
        ///后台用户充值
        consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE);
        consumeaudit.setRemarks(UserUtils.getUser().getLoginName() + "为" + account.getLoginName() + "充值:" + rechargeMoney + "元");

        ////交易流水记录
        consumerecodDao.insert(accountrecode);
        ///审核记录
        consumeauditDao.insert(consumeaudit);
        deallogService.saveDealLog(consumeaudit);


    }

    /***
     * 后台账户充值新增记录----新记录不做状态修改,不做资金的变动
     *
     * @param consumeaudit
     */
    @Transactional(readOnly = false)
    public void sysaccountRecharge(Consumeaudit consumeaudit) {
        ////充值用户
        User account = consumeaudit.getUser();
        ///当前充值金额
        Double rechargeMoney = Double.parseDouble(consumeaudit.getConsume().getConsumemony());

        ///充值账户当前账户余额
        Double account_webbalance = account.getUserPurse().getWebbalance();
        ///当前充值账户可用余额
        Double account_available = account.getUserPurse().getAvailablebalance();

        ///当前充值账户充值后的账户余额
        Double cur_account_webbalance = account_webbalance + rechargeMoney;
        ///当前充值账户充值后的可用余额
        Double cur_account_available = account_available + rechargeMoney;


        ///充值账户的交易记录
        Consumerecod accountrecode = new Consumerecod();
        ///赋值主键-创建者
        accountrecode.preInsert();
        ///充值账户
        accountrecode.setAccount(account);
        accountrecode.setSysaccount(account);///系统账户
        accountrecode.setTarget(account);///目标账户

        ///账户余额充值类型==获取到交易流水
        accountrecode.setConsumecode(OrderNumberUtil.getOrderNo(DataDic.CONSUMERECODE_MODEL_ACCOUNT));
        accountrecode.setPaycode(accountrecode.getConsumecode());
        accountrecode.setBeforemony(account_webbalance.toString());
        accountrecode.setAftermony(cur_account_webbalance.toString());

        ///赋值--交易状态--交易方式--交易类型
        accountrecode.setConsumestatus(DataDic.CONSUMERECODE_STATUS_CONING);
        accountrecode.setConsumeway(DataDic.CONSUMERECODE_WAY_BALANCE);
        accountrecode.setConsumetype(DataDic.CONSUMERECODE_TYPE_BALANACE);

        ///交易描述
        accountrecode.setConsumewaydesp(account.getLoginName() + "充值:" + rechargeMoney + "元");
        ///系统后台充值
        accountrecode.setScantype(DataDic.SCANTYPE_BACK);


        ///后台充值审核记录
        consumeaudit.preInsert();
        consumeaudit.setUser(account);

        ///新的审核信息
        consumeaudit.setAuditstatus(DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT);
        ///对应的交易流水
        consumeaudit.setConsume(accountrecode);
        ///后台用户充值
        consumeaudit.setType(DataDic.CONSUMEAUDIT_ACCOUNTRECHARGE);
        consumeaudit.setRemarks(UserUtils.getUser().getLoginName() + "为" + account.getLoginName() + "充值:" + rechargeMoney + "元");

        ////交易流水记录
        consumerecodDao.insert(accountrecode);
        ///审核记录
        consumeauditDao.insert(consumeaudit);
        ///处理日志
        deallogService.saveDealLog(consumeaudit);


    }


    public List<Consumeaudit> findList(Consumeaudit consumeaudit) {
        return super.findList(consumeaudit);
    }

    public Page<Consumeaudit> findPage(Page<Consumeaudit> page, Consumeaudit consumeaudit) {
        return super.findPage(page, consumeaudit);
    }

    @Transactional(readOnly = false)
    public void save(Consumeaudit consumeaudit) {
        super.save(consumeaudit);
    }

    @Transactional(readOnly = false)
    public void delete(Consumeaudit consumeaudit) {
        super.delete(consumeaudit);
    }

}