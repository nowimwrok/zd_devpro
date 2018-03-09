/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BscMessageDao;

/**
 * 消息通知Service
 *
 * @author fjc
 * @version 2017-11-15
 */
@Service
@Transactional(readOnly = true)
public class BscMessageService extends CrudService<BscMessageDao, BscMessage> {

    @Autowired
    private BscMessageDao bscMessageDao;

    public BscMessage get(String id) {
        return super.get(id);
    }


    public List<BscMessage> findList(BscMessage bscMessage) {
        return super.findList(bscMessage);
    }

    public List<BscMessage> findAllList(BscMessage bscMessage) {
        return bscMessageDao.findAllList(bscMessage);
    }

    public Page<BscMessage> findPage(Page<BscMessage> page, BscMessage bscMessage) {
        return super.findPage(page, bscMessage);
    }

    /**
     * 统计未读消息数
     *
     * @return
     */
    public BscMessage sumUnRead(BscMessage bscMessage) {
        return bscMessageDao.sumUnRead(bscMessage);
    }

    @Transactional(readOnly = false)
    public void save(BscMessage bscMessage) {
        super.save(bscMessage);
    }

    @Transactional(readOnly = false)
    public void delete(BscMessage bscMessage) {
        super.delete(bscMessage);
    }

}