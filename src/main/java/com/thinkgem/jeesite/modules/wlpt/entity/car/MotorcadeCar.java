/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 车队与车辆关联Entity
 *
 * @author liangweishen
 * @version 2017-08-04
 */
public class MotorcadeCar extends DataEntity<MotorcadeCar> {

    private static final long serialVersionUID = 1L;
    private String motorcadeId;        // 车队ID
    private String carId;        // 车辆ID

    public MotorcadeCar() {
        super();
    }

    public MotorcadeCar(String id) {
        super(id);
    }

    @Length(min = 0, max = 32, message = "车队ID长度必须介于 0 和 32 之间")
    public String getMotorcadeId() {
        return motorcadeId;
    }

    public void setMotorcadeId(String motorcadeId) {
        this.motorcadeId = motorcadeId;
    }

    @Length(min = 0, max = 32, message = "车辆ID长度必须介于 0 和 32 之间")
    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

}