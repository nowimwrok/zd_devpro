/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 消息通知Entity
 *
 * @author fjc
 * @version 2017-11-15
 */
public class BscMessage extends DataEntity<BscMessage> {

    private static final long serialVersionUID = 1L;
    private String ttile;        // 消息标题
    private String content;        // 消息内容
    private String contenttype;        // 内容类型:1新鲜资讯2活动福利3.物流小秘书4.积分提醒5.客服助手
    private String scantype;        // 消息的系统：0全部1平台2Android3微信4IOS
    private String summary;        // 摘要
    private String sendtype;        // 消息发送类型:0群发1按角色发2按用户发
    private String sourceid;        // 源id
    private String sourcetype;        // 0消息1货源2运单
    private User user;        // 用户id 目标id
    private String status;        // 状态 是否推送0否 1是
    private String isRead;        // 是否读取 0否 1是

    private String sumUnRead;//统计未读的消息数

    public BscMessage() {
        super();
    }

    public BscMessage(String id) {
        super(id);
    }

    @Length(min = 0, max = 255, message = "消息标题长度必须介于 0 和 255 之间")
    public String getTtile() {
        return ttile;
    }

    public void setTtile(String ttile) {
        this.ttile = ttile;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getContenttype() {
        return contenttype;
    }

    public void setContenttype(String contenttype) {
        this.contenttype = contenttype;
    }

    @Length(min = 0, max = 11, message = "消息的系统：0全部1平台2Android3微信4IOS长度必须介于 0 和 11 之间")
    public String getScantype() {
        return scantype;
    }

    public void setScantype(String scantype) {
        this.scantype = scantype;
    }

    @Length(min = 0, max = 60, message = "摘要长度必须介于 0 和 60 之间")
    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    @Length(min = 0, max = 11, message = "消息发送类型:0群发1按角色发2按用户发长度必须介于 0 和 11 之间")
    public String getSendtype() {
        return sendtype;
    }

    public void setSendtype(String sendtype) {
        this.sendtype = sendtype;
    }

    @Length(min = 0, max = 32, message = "源id长度必须介于 0 和 32 之间")
    public String getSourceid() {
        return sourceid;
    }

    public void setSourceid(String sourceid) {
        this.sourceid = sourceid;
    }

    @Length(min = 0, max = 11, message = "0消息1货源2运单长度必须介于 0 和 11 之间")
    public String getSourcetype() {
        return sourcetype;
    }

    public void setSourcetype(String sourcetype) {
        this.sourcetype = sourcetype;
    }


    @Length(min = 0, max = 11, message = "状态 是否推送0否 1是长度必须介于 0 和 11 之间")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Length(min = 0, max = 11, message = "是否读取 0否 1是长度必须介于 0 和 11 之间")
    public String getIsRead() {
        return isRead;
    }

    public void setIsRead(String isRead) {
        this.isRead = isRead;
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSumUnRead() {
        return sumUnRead;
    }

    public void setSumUnRead(String sumUnRead) {
        this.sumUnRead = sumUnRead;
    }
}