/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 车队与司机关联Entity
 *
 * @author liangweishen
 * @version 2017-08-04
 */
public class MotorcadeDriver extends DataEntity<MotorcadeDriver> {

    private static final long serialVersionUID = 1L;
    private String driverId;        // 司机ID
    private String motorcadeId;        // 车队ID


    public MotorcadeDriver() {
        super();
    }

    public MotorcadeDriver(String id) {
        super(id);
    }

    @Length(min = 0, max = 32, message = "司机ID长度必须介于 0 和 32 之间")
    public String getDriverId() {
        return driverId;
    }

    public void setDriverId(String driverId) {
        this.driverId = driverId;
    }

    @Length(min = 0, max = 32, message = "车队ID长度必须介于 0 和 32 之间")
    public String getMotorcadeId() {
        return motorcadeId;
    }

    public void setMotorcadeId(String motorcadeId) {
        this.motorcadeId = motorcadeId;
    }


}