package com.thinkgem.jeesite.common.trafficUtils.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

public class VehicleEvent extends DataEntity<VehicleEvent> {

    /**
     *
     */
    private static final long serialVersionUID = -198117612487892277L;
    private String state; //发送状态     字符串1：发送成功，2：车机不在线，3：存在敏感词4:未入网5：发送拒绝
    private String utc;   //发送时间
    private String por;   //输入参数中经纬度所对应的所属省信息
    private String cit;   //输入参数中经纬度所对应的所属市信息；如果为直辖市地区，省市名称保持一致
    private String cou;   //输入参数中经纬度所对应的所属区/县信息
    private String des;   //具体的位置文字地理信息，精确到省市县，方向，偏移距离信息

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getUtc() {
        return utc;
    }

    public void setUtc(String utc) {
        this.utc = utc;
    }

    public String getPor() {
        return por;
    }

    public void setPor(String por) {
        this.por = por;
    }

    public String getCit() {
        return cit;
    }

    public void setCit(String cit) {
        this.cit = cit;
    }

    public String getCou() {
        return cou;
    }

    public void setCou(String cou) {
        this.cou = cou;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

}
