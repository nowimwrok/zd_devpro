/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

/**
 * 车队Entity
 *
 * @author liangweishen
 * @version 2017-08-04
 */
public class Motorcade extends DataEntity<Motorcade> {

    private static final long serialVersionUID = 1L;
    private String no;        // 车队编号
    private String name;        // 车队名称
    private String fromCity;        // 运输路线起点
    private String toCity;        // 运输路线终点
    private String remark;        // 备注

    //用于数据展示
    private int carNum;//绑定车辆数
    private int driverNum;//绑定司机数
    private Car car; //绑定的车辆对象

    //用于查询
    private String searchinfo;      /// 查找信息
    private String carType;     //车型
    private String isSocialCar;  //车辆类型

    public Motorcade() {
        super();
    }

    public Motorcade(String id) {
        super(id);
    }

    @Length(min = 0, max = 32, message = "车队编号长度必须介于 0 和 32 之间")
    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    @Length(min = 0, max = 32, message = "车队名称长度必须介于 0 和 32 之间")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Length(min = 0, max = 32, message = "运输路线起点长度必须介于 0 和 32 之间")
    public String getFromCity() {
        return fromCity;
    }

    public void setFromCity(String fromCity) {
        this.fromCity = fromCity;
    }

    @Length(min = 0, max = 32, message = "运输路线终点长度必须介于 0 和 32 之间")
    public String getToCity() {
        return toCity;
    }

    public void setToCity(String toCity) {
        this.toCity = toCity;
    }

    @Length(min = 0, max = 255, message = "备注长度必须介于 0 和 255 之间")
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getCarNum() {
        return carNum;
    }

    public void setCarNum(int carNum) {
        this.carNum = carNum;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    @Override
    public String getSearchinfo() {
        return searchinfo;
    }

    @Override
    public void setSearchinfo(String searchinfo) {
        this.searchinfo = searchinfo;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getIsSocialCar() {
        return isSocialCar;
    }

    public void setIsSocialCar(String isSocialCar) {
        this.isSocialCar = isSocialCar;
    }

    public int getDriverNum() {
        return driverNum;
    }

    public void setDriverNum(int driverNum) {
        this.driverNum = driverNum;
    }
}