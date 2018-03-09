package com.thinkgem.jeesite.modules.wlpt.biz.accounts;

import com.thinkgem.jeesite.common.utils.SendMailUtil;
import com.thinkgem.jeesite.modules.wlpt.dao.accounts.AccountsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 对账
 * Created by 刘欣
 */
@Service
public class AccountsBiz {

    @Autowired
    private AccountsDao accountsDao;

    public void findAccountWebBalance() {
        Double webBalance = accountsDao.findAccountWebBalance();
        if (webBalance!=0){
            SendMailUtil.sendCommonMail("nowimwork@foxmail.com","平台账户对账","平台余额对账有误，对账差额："+webBalance+" 元");
        }
    }


}
