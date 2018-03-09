/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscMessage;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户消息Entity
 *
 * @author fjc
 * @version 2017-11-20
 */
public class UserMessage extends DataEntity<UserMessage> {

    private static final long serialVersionUID = 1L;
    private User user;        // 用户ID
    private BscMessage message;        // 消息ID
    private String status;        // 状态:0未读1已经读取

    private String sumUnRead;//统计未读的消息数

    public UserMessage() {
        super();
    }

    public UserMessage(String id) {
        super(id);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BscMessage getMessage() {
        return message;
    }

    public void setMessage(BscMessage message) {
        this.message = message;
    }

    @Length(min = 0, max = 11, message = "状态:0未读1已经读取长度必须介于 0 和 11 之间")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSumUnRead() {
        return sumUnRead;
    }

    public void setSumUnRead(String sumUnRead) {
        this.sumUnRead = sumUnRead;
    }
}