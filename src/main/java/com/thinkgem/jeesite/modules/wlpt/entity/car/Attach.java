/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 司机账户绑定Entity
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
public class Attach extends DataEntity<Attach> {

    private static final long serialVersionUID = 1L;
    private User user;        // 主账户ID）
    private User reuser;        // 关系用户ID
    private String carId;        // 车辆ID
    private String isagree;        // 是否同意
    private Date beginCreateDate;        // 开始 创建时间
    private Date endCreateDate;        // 结束 创建时间
    private Date beginUpdateDate;        // 开始 更新时间
    private Date endUpdateDate;        // 结束 更新时间
    private String flag;
    private String namesearch;//收缩条件
    private String phonesearch;//收缩条件
    private String type;

    //用于页面展示
    private Motorcade motorcade;//被绑定司机所属车队
    private Motorcade remotorcade;//被绑定司机所属车队
    private String motorcadeId;//被绑定司机所属车队

    public Attach() {
        super();
    }

    public Attach(String id) {
        super(id);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getReuser() {
        return reuser;
    }

    public void setReuser(User reuser) {
        this.reuser = reuser;
    }

    @Length(min = 0, max = 32, message = "车辆ID长度必须介于 0 和 32 之间")
    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    @Length(min = 0, max = 2, message = "是否同意长度必须介于 0 和 2 之间")
    public String getIsagree() {
        return isagree;
    }

    public void setIsagree(String isagree) {
        this.isagree = isagree;
    }

    public Date getBeginCreateDate() {
        return beginCreateDate;
    }

    public void setBeginCreateDate(Date beginCreateDate) {
        this.beginCreateDate = beginCreateDate;
    }

    public Date getEndCreateDate() {
        return endCreateDate;
    }

    public void setEndCreateDate(Date endCreateDate) {
        this.endCreateDate = endCreateDate;
    }

    public Date getBeginUpdateDate() {
        return beginUpdateDate;
    }

    public void setBeginUpdateDate(Date beginUpdateDate) {
        this.beginUpdateDate = beginUpdateDate;
    }

    public Date getEndUpdateDate() {
        return endUpdateDate;
    }

    public void setEndUpdateDate(Date endUpdateDate) {
        this.endUpdateDate = endUpdateDate;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getNamesearch() {
        return namesearch;
    }

    public void setNamesearch(String namesearch) {
        this.namesearch = namesearch;
    }

    public String getPhonesearch() {
        return phonesearch;
    }

    public void setPhonesearch(String phonesearch) {
        this.phonesearch = phonesearch;
    }

    public Motorcade getMotorcade() {
        return motorcade;
    }

    public void setMotorcade(Motorcade motorcade) {
        this.motorcade = motorcade;
    }

    public String getMotorcadeId() {
        return motorcadeId;
    }

    public void setMotorcadeId(String motorcadeId) {
        this.motorcadeId = motorcadeId;
    }

    public Motorcade getRemotorcade() {
        return remotorcade;
    }

    public void setRemotorcade(Motorcade remotorcade) {
        this.remotorcade = remotorcade;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}