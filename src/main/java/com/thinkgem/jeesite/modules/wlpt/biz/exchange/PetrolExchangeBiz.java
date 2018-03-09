package com.thinkgem.jeesite.modules.wlpt.biz.exchange;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchangeRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.service.exchange.UserPetrolExchangeRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.exchange.UserPetrolExchangeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;


@Service
@Transactional(readOnly = true)
public class PetrolExchangeBiz {
    @Autowired
    private UserPetrolExchangeService petrolExchangeService;

    @Autowired
    private UserPetrolExchangeRecordService petrolExchangeRecordService;

    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;

    @Transactional(readOnly = false)
    public void petrolexchangeSave(UserPetrolExchange userPetrolExchange) {
        //获取兑换号
        String exchangeNo = OrderNumberUtil.getOrderNo(DataDic.MODEL_EXCHANGE);
        userPetrolExchange.setExchangeNo(exchangeNo);
        userPetrolExchange.setStatus(DataDic.EXCHANGE_STATUS_BEING);
        userPetrolExchange.setInvoiceStatus(DataDic.EXCHANGE_INVOICESTATUS_UNOPEN);//开票状态
        //添加关系表
        UserPetrolExchangeRecord exchangeRecord = new UserPetrolExchangeRecord();
        exchangeRecord.setCardRecordList(userPetrolExchange.getCardRecordList());
        exchangeRecord.setExchangeNo(exchangeNo);
        exchangeRecord.setStatus(DataDic.EXCHANGE_STATUS_BEING);
        petrolExchangeRecordService.insertExchange(exchangeRecord);//保存关系表
        petrolExchangeRecordService.updateUserCardStatus(exchangeRecord);//修改消费记录状态
        petrolExchangeService.save(userPetrolExchange);//保存申请兑换记录
    }

    /**
     * 修改开票状态
     *
     * @param id
     * @param status
     * @return
     */
    @Transactional(readOnly = false)
    public int editInvoiceStatus(String id, String status) {
        int result = DataDic.RETURN_STATUS_NORMAL;
        if (Tools.IsNullOrWhiteSpace(id)) {
            return DataDic.RETURN_STATUS_INFOBUG;

        }
        UserPetrolExchange userPetrolExchange = get(id);
        if (userPetrolExchange == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        userPetrolExchange.setInvoiceStatus(status);
        int num = petrolExchangeService.updateInvoiceStatus(userPetrolExchange);//保存申请兑换记录
        return result;
    }

    @Transactional(readOnly = false)
    public void petrolexchangeSave1(UserPetrolExchangeRecord exchangeRecord) {
        petrolExchangeRecordService.updateUserCardStatus(exchangeRecord);//修改消费记录状态
    }

    /**
     * 审核
     *
     * @param userPetrolExchange
     * @return
     */
    @Transactional(readOnly = false)
    public int petrolexchangeAudit(UserPetrolExchange userPetrolExchange) {
        int result = DataDic.RETURN_STATUS_NORMAL;

        if (Tools.IsNullOrWhiteSpace(userPetrolExchange.getId())) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }

        UserPetrolExchange exchange = get(userPetrolExchange.getId());
        if (exchange == null) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }


        ///修改的状态
        String upStatus = userPetrolExchange.getStatus();
        //原来的状态
        String oldStatus = exchange.getStatus();
        if (DataDic.EXCHANGE_STATUS_FINALJUDG.equals(oldStatus)) {
            return DataDic.RETURN_STATUS_OVERCONTROLBUG;
        }
        ///如果修改的状态为审核通过
        if (DataDic.EXCHANGE_STATUS_SUCESS.equals(upStatus)) {//&&DataDic.EXCHANGE_STATUS_SUCESS.equals(upStatus)
            String[] rols = {DataDic.ROLE_AUDITCLERK, DataDic.ROLE_FINALCLERK, DataDic.ROLE_POS_AUDITCLERK, DataDic.ROLE_POS_FINANCIAL};
            if (!UserUtils.vialedRole(rols) || (!DataDic.EXCHANGE_STATUS_SUCESS.equals(oldStatus) && !DataDic.EXCHANGE_STATUS_BEING.equals(oldStatus))) {
                //权限不足
                return DataDic.RETURN_STATUS_AUTHBUG;
            } else if (DataDic.EXCHANGE_STATUS_SUCESS.equals(oldStatus)) {///是否一审核
                return DataDic.RETURN_STATUS_OVERCONTROLBUG;//已审核
            }
        } else if (DataDic.EXCHANGE_STATUS_FINALJUDG.equals(upStatus)) {//复核通过
            String[] rols = {DataDic.ROLE_FINALCLERK, DataDic.ROLE_POS_FINANCIAL};
            if (!UserUtils.vialedRole(rols) || (!DataDic.EXCHANGE_STATUS_SUCESS.equals(oldStatus))) {
                //权限不足
                return DataDic.RETURN_STATUS_AUTHBUG;
            } else if (DataDic.EXCHANGE_STATUS_FINALJUDG.equals(oldStatus)) {///是否一复核
                return DataDic.RETURN_STATUS_OVERCONTROLBUG;//已复核
            }
        } else if (DataDic.EXCHANGE_STATUS_FAIL.equals(upStatus)) {//申请驳回
            String[] rols = {DataDic.ROLE_AUDITCLERK, DataDic.ROLE_FINALCLERK, DataDic.ROLE_POS_AUDITCLERK, DataDic.ROLE_POS_FINANCIAL};
            if (!UserUtils.vialedRole(rols) || (!DataDic.EXCHANGE_STATUS_SUCESS.equals(oldStatus) && !DataDic.EXCHANGE_STATUS_BEING.equals(oldStatus))) {
                //权限不足
                return DataDic.RETURN_STATUS_AUTHBUG;
            } else if (DataDic.EXCHANGE_STATUS_FAIL.equals(oldStatus)) {///是否一驳回
                return DataDic.RETURN_STATUS_OVERCONTROLBUG;//已驳回
            }
        } else {
            //权限不足
            return DataDic.RETURN_STATUS_AUTHBUG;
        }


        //审核通过，兑换余额
        if (DataDic.EXCHANGE_STATUS_FINALJUDG.equals(userPetrolExchange.getStatus())) {
            String accountid = exchange.getUser().getId();
            result = consumeRecodBiz.exchangePetroBiz(accountid, Double.valueOf(exchange.getTotalcost()), Double.valueOf(exchange.getTotalcost()));
        }
        if (result != DataDic.RETURN_STATUS_NORMAL) {
            return DataDic.RETURN_STATUS_INFOBUG;
        }
        User dealUser = UserUtils.getUser(true);
        userPetrolExchange.setDealUser(dealUser);
        userPetrolExchange.setDealTime(new Date());
        //添加关系表
        UserPetrolExchangeRecord exchangeRecord = new UserPetrolExchangeRecord();
        //获取消费记录
        List<UserMetroCardRecord> recordlist = getPetrolExchangeRecordInfo(userPetrolExchange.getExchangeNo());
        exchangeRecord.setCardRecordList(recordlist);
        exchangeRecord.setExchangeNo(exchange.getExchangeNo());
        exchangeRecord.setStatus(userPetrolExchange.getStatus());


        petrolExchangeRecordService.updateStatus(exchangeRecord);//修改关系表状态
        petrolExchangeRecordService.updateUserCardStatus(exchangeRecord);//修改消费记录状态
        petrolExchangeService.save(userPetrolExchange);//保存申请兑换记录
        return result;
    }


    public UserPetrolExchange get(String id) {
        return petrolExchangeService.get(id);
    }


    public List<UserPetrolExchange> findList(UserPetrolExchange userPetrolExchange) {
        return petrolExchangeService.findList(userPetrolExchange);
    }

    public Page<UserPetrolExchange> findPage(Page<UserPetrolExchange> page, UserPetrolExchange userPetrolExchange) {
        return petrolExchangeService.findPage(page, userPetrolExchange);
    }

    @Transactional(readOnly = false)
    public void save(UserPetrolExchange userPetrolExchange) {
        petrolExchangeService.save(userPetrolExchange);
    }

    @Transactional(readOnly = false)
    public void delete(UserPetrolExchange userPetrolExchange) {
        petrolExchangeService.delete(userPetrolExchange);
    }

    /**
     * 获取消费记录
     *
     * @param exchangeNo
     * @return
     */
    public Page<UserMetroCardRecord> getPetrolExchangeRecordList(Page<UserMetroCardRecord> page, String exchangeNo) {
        UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
        userMetroCardRecord.setExchangeNo(exchangeNo);
        return petrolExchangeRecordService.getPetrolExchangeRecordList(page, userMetroCardRecord);
    }

    /**
     * 获取消费记录
     *
     * @param exchangeNo
     * @return
     */
    public List<UserMetroCardRecord> getPetrolExchangeRecordInfo(String exchangeNo) {
        return petrolExchangeRecordService.getPetrolExchangeRecordInfo(exchangeNo);
    }

    /**
     * 导出消费记录
     *
     * @param exchangeNo
     * @return
     */
    public List<UserMetroCardRecordVO> getPetrolExchangeRecordbyExportList(String exchangeNo) {
        return petrolExchangeRecordService.getPetrolExchangeRecordbyExportList(exchangeNo);
    }

    /**
     * 修改开票状态
     *
     * @param userPetrolExchange
     * @return
     */
    @Transactional(readOnly = false)
    public int updateInvoiceStatus(UserPetrolExchange userPetrolExchange) {
        return petrolExchangeService.updateInvoiceStatus(userPetrolExchange);
    }
}
