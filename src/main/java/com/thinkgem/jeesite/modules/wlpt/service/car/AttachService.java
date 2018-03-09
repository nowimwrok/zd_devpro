/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.service.car;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.dao.car.AttachDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 司机账户绑定Service
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class AttachService extends CrudService<AttachDao, Attach> {

    @Autowired
    private AttachDao attachDao;

    public Attach get(String id) {
        return super.get(id);
    }

    /**
     * 查找绑定信息
     *
     * @param attach
     * @return
     */
    public Attach findAttach(Attach attach) {
        return attachDao.findAttach(attach);
    }

    public List<Attach> findList(Attach attach) {
        return super.findList(attach);
    }

    public Page<Attach> findList1(Page<Attach> page, Attach attach) {
        attach.setPage(page);
        page.setList(attachDao.findList1(attach));
        return page;
    }

    @Transactional(readOnly = false)
    public void save(Attach attach) {
        super.save(attach);
    }

    @Transactional(readOnly = false)
    public void delete(Attach attach) {
        super.delete(attach);
    }

    /**
     * 获取用户绑定的司机数目
     *
     * @param attach
     * @return
     */
    public int getUserDriverNum(Attach attach) {
        return attachDao.getUserDriverNum(attach);
    }

}