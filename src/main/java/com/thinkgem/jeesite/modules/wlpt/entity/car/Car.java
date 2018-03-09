/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.User;
import org.hibernate.validator.constraints.Length;

import java.util.Date;

/**
 * 车辆管理Entity
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
public class Car extends DataEntity<Car> {

    private static final long serialVersionUID = 1L;
    private User user;        // 用户Id
    private String ismembercar;        // 是否会员车辆
    private String mininame;
    private String number;
    private String carnumber;        // 车牌号
    private String cartype;        // 车型
    private String carlength;        // 车长
    private String lengthunit;        // 车长单位
    private String loadweight;        // 载重
    private String weightunit;        // 载重单位
    private String fromaddress;    //开始地址
    private String toaddress;      //终点地址
    private String mainroad;        // 主营路线
    private String ownername;        // 车主姓名
    private String ownermobile;        // 车主手机
    private String status;        // 认证状态
    private String oftenparkedposition;        // 常停放位置
    private String issocialcar;        // 车辆类型
    private String locationmobile;        // 定位手机
    private String tradecount;        // 订单数
    private String travellicimg;        // 行驶证照片
    private String carsurfaceimg;        // 车辆外观照片
    private String owneridcardnum;        // 车主身份证
    private String owneridcardimg;        // 车主身份证图片
    private String transportcardimg;        // 道路运输许可证
    private String beginCarlength;        // 开始 车长
    private String endCarlength;        // 结束 车长
    private String beginLoadWeight;    //开始吨位
    private String endLoadWeight;      //结算吨位
    private Date beginCreateDate;        // 开始 创建时间
    private Date endCreateDate;        // 结束 创建时间
    private Date beginUpdateDate;        // 开始 更新时间
    private Date endUpdateDate;        // 结束 更新时间

    //扩展属性用于查询
    private String fromprovince;//始发省
    private String fromcity;//始发市
    private String toprovince;//目的省
    private String tocity;//目的市
    private String searchinfo;      /// 查找信息
    private GpsCarInfo gpsCarInfo;  //gps车辆信息
    private GpsCarLocs gpsloc;   //gps定位信息
    private String motorcadeId; //车队ID

    //车源扩展字段
    private String carsourceid;        // 车源id
    private String carsourcemainroad;        // 本次车源行驶路线
    private String contactname;        // 联系人
    private String contactmobile;        // 联系人号码
    private Date departuretime;        // 发车时间
    private String carsourcestatus;        // 车源状态：1:已发布，2:已过期，3:已取消
    private int finishedtradecount;   //完成的订单数
    private Motorcade motorcade;//车队对象
    private MotorcadeCar motorcadeCar; //车队与车辆的关联对象
    
    private String checkareastatus;    //套牌车验证状态：0未校验，1已入网，-1未查询到
    private String checkownerstatus;   //车主真实性验证状态：0未校验，1真实，2姓名不匹配，3手机号码不匹配，-1未查询到（“yes”代表验证通过，车主姓名不正确返回“name”，手机号不正确返回“phone”）
    private String checktruckstatus;   //车辆入网验证状态：0未校验，1已入网，-1未查询到
    private String transportcard;			//道路运输证号码
    private String validityterm;           //道路运输证有效期
    
    
    
    public String getCheckareastatus() {
		return checkareastatus;
	}

	public void setCheckareastatus(String checkareastatus) {
		this.checkareastatus = checkareastatus;
	}

	public String getCheckownerstatus() {
		return checkownerstatus;
	}

	public void setCheckownerstatus(String checkownerstatus) {
		this.checkownerstatus = checkownerstatus;
	}

	public String getChecktruckstatus() {
		return checktruckstatus;
	}

	public void setChecktruckstatus(String checktruckstatus) {
		this.checktruckstatus = checktruckstatus;
	}

	public String getTransportcard() {
		return transportcard;
	}

	public void setTransportcard(String transportcard) {
		this.transportcard = transportcard;
	}

	public String getValidityterm() {
		return validityterm;
	}

	public void setValidityterm(String validityterm) {
		this.validityterm = validityterm;
	}

	public GpsCarInfo getGpsCarInfo() {
        return gpsCarInfo;
    }

    public void setGpsCarInfo(GpsCarInfo gpsCarInfo) {
        this.gpsCarInfo = gpsCarInfo;
    }

    public String getSearchinfo() {
        return searchinfo;
    }

    public void setSearchinfo(String searchinfo) {
        this.searchinfo = searchinfo;
    }

    public String getFromprovince() {
        return fromprovince;
    }

    public void setFromprovince(String fromprovince) {
        this.fromprovince = fromprovince;
    }

    public String getFromcity() {
        return fromcity;
    }

    public void setFromcity(String fromcity) {
        this.fromcity = fromcity;
    }

    public String getToprovince() {
        return toprovince;
    }

    public void setToprovince(String toprovince) {
        this.toprovince = toprovince;
    }

    public String getTocity() {
        return tocity;
    }

    public void setTocity(String tocity) {
        this.tocity = tocity;
    }

    private String addressStart;   //起点
    private String addressEnd;   ///终点

    private String ymdDate;   ///年月日时间


    public String getAddressStart() {
        return addressStart;
    }

    public void setAddressStart(String addressStart) {
        this.addressStart = addressStart;
    }

    public String getAddressEnd() {
        return addressEnd;
    }

    public void setAddressEnd(String addressEnd) {
        this.addressEnd = addressEnd;
    }

    @ExcelField(title = "最小载重", type = 1, align = 2, sort = 7)
    public String getBeginLoadWeight() {
        return beginLoadWeight;
    }

    public void setBeginLoadWeight(String beginLoadWeight) {
        this.beginLoadWeight = beginLoadWeight;
    }

    @ExcelField(title = "最大载重", type = 1, align = 2, sort = 7)
    public String getEndLoadWeight() {
        return endLoadWeight;
    }

    @ExcelField(title = "用户姓名", type = 1, align = 2, sort = 1)
    public String userName() {
        return getUser().getName();
    }

    public void setEndLoadWeight(String endLoadWeight) {
        this.endLoadWeight = endLoadWeight;
    }

    public Car() {
        super();
    }

    public Car(String id) {
        super(id);
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getYmdDate() {
        return ymdDate;
    }

    public void setYmdDate(String ymdDate) {
        this.ymdDate = ymdDate;
    }

    @ExcelField(title = "是否会员车辆", type = 1, align = 2, sort = 2, dictType = "ismembercar")
    @Length(min = 0, max = 11, message = "是否会员车辆长度必须介于 0 和 11 之间")
    public String getIsmembercar() {
        return ismembercar;
    }

    public void setIsmembercar(String ismembercar) {
        this.ismembercar = ismembercar;
    }

    @Length(min = 0, max = 20, message = "车牌号长度必须介于 0 和 20 之间")
    @ExcelField(title = "车牌号", type = 1, align = 2, sort = 3)
    public String getCarnumber() {
        return carnumber;
    }

    public void setCarnumber(String carnumber) {
        this.carnumber = carnumber;
    }

    @ExcelField(title = "车型", type = 1, align = 2, sort = 4, dictType = "car_type")
    @Length(min = 0, max = 10, message = "车型长度必须介于 0 和 10 之间")
    public String getCartype() {
        return cartype;
    }

    public void setCartype(String cartype) {
        this.cartype = cartype;
    }

    @ExcelField(title = "车长", type = 1, align = 2, sort = 5)
    public String getCarlength() {
        return carlength;
    }

    public void setCarlength(String carlength) {
        this.carlength = carlength;
    }

    @ExcelField(title = "车长单位", type = 1, align = 2, sort = 6)
    @Length(min = 0, max = 10, message = "车长单位长度必须介于 0 和 10 之间")
    public String getLengthunit() {
        return lengthunit;
    }

    public void setLengthunit(String lengthunit) {
        this.lengthunit = lengthunit;
    }

    @ExcelField(title = "载重", type = 1, align = 2, sort = 7)
    public String getLoadweight() {
        return loadweight;
    }

    public void setLoadweight(String loadweight) {
        this.loadweight = loadweight;
    }

    @ExcelField(title = "载重单位", type = 1, align = 2, sort = 8)
    @Length(min = 0, max = 10, message = "载重单位长度必须介于 0 和 10 之间")
    public String getWeightunit() {
        return weightunit;
    }

    public void setWeightunit(String weightunit) {
        this.weightunit = weightunit;
    }

    @ExcelField(title = "主营路线", type = 1, align = 2, sort = 9)
    @Length(min = 0, max = 200, message = "主营路线长度必须介于 0 和 200 之间")
    public String getMainroad() {
        return mainroad;
    }

    public void setMainroad(String mainroad) {
        this.mainroad = mainroad;
    }

    @ExcelField(title = "车主姓名", type = 1, align = 2, sort = 10)
    @Length(min = 0, max = 20, message = "车主姓名长度必须介于 0 和 20 之间")
    public String getOwnername() {
        return ownername;
    }

    public void setOwnername(String ownername) {
        this.ownername = ownername;
    }

    @ExcelField(title = "车主手机", type = 1, align = 2, sort = 11)
    @Length(min = 0, max = 20, message = "车主手机长度必须介于 0 和 20 之间")
    public String getOwnermobile() {
        return ownermobile;
    }

    public void setOwnermobile(String ownermobile) {
        this.ownermobile = ownermobile;
    }

    @ExcelField(title = "认证状态", type = 1, align = 2, sort = 13, dictType = "authenStatus")
    @Length(min = 0, max = 11, message = "认证状态长度必须介于 0 和 11 之间")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ExcelField(title = "常停放位置", type = 1, align = 2, sort = 14)
    @Length(min = 0, max = 50, message = "常停放位置长度必须介于 0 和 50 之间")
    public String getOftenparkedposition() {
        return oftenparkedposition;
    }

    public void setOftenparkedposition(String oftenparkedposition) {
        this.oftenparkedposition = oftenparkedposition;
    }

    @ExcelField(title = "车辆类型", type = 1, align = 2, sort = 15, dictType = "car_type")
    @Length(min = 0, max = 11, message = "车辆类型长度必须介于 0 和 11 之间")
    public String getIssocialcar() {
        return issocialcar;
    }

    public void setIssocialcar(String issocialcar) {
        this.issocialcar = issocialcar;
    }

    @ExcelField(title = "定位手机", type = 1, align = 2, sort = 16)
    @Length(min = 0, max = 11, message = "定位手机长度必须介于 0 和 11 之间")
    public String getLocationmobile() {
        return locationmobile;
    }

    public void setLocationmobile(String locationmobile) {
        this.locationmobile = locationmobile;
    }

    @ExcelField(title = "订单数", type = 1, align = 2, sort = 17)
    @Length(min = 0, max = 11, message = "订单数长度必须介于 0 和 11 之间")
    public String getTradecount() {
        return tradecount;
    }

    public void setTradecount(String tradecount) {
        this.tradecount = tradecount;
    }

    @Length(min = 0, max = 500, message = "行驶证照片长度必须介于 0 和 500 之间")
    public String getTravellicimg() {
        return travellicimg;
    }

    public void setTravellicimg(String travellicimg) {
        this.travellicimg = travellicimg;
    }

    @Length(min = 0, max = 500, message = "车辆外观照片长度必须介于 0 和 500 之间")
    public String getCarsurfaceimg() {
        return carsurfaceimg;
    }

    public void setCarsurfaceimg(String carsurfaceimg) {
        this.carsurfaceimg = carsurfaceimg;
    }

    @ExcelField(title = "车主身份证号", type = 1, align = 2, sort = 18)
    @Length(min = 0, max = 30, message = "车主身份证长度必须介于 0 和 30 之间")
    public String getOwneridcardnum() {
        return owneridcardnum;
    }

    public void setOwneridcardnum(String owneridcardnum) {
        this.owneridcardnum = owneridcardnum;
    }

    @Length(min = 0, max = 100, message = "车主身份证图片长度必须介于 0 和 100 之间")
    public String getOwneridcardimg() {
        return owneridcardimg;
    }

    public void setOwneridcardimg(String owneridcardimg) {
        this.owneridcardimg = owneridcardimg;
    }

    @Length(min = 0, max = 500, message = "道路运输许可证长度必须介于 0 和 500 之间")
    public String getTransportcardimg() {
        return transportcardimg;
    }

    public void setTransportcardimg(String transportcardimg) {
        this.transportcardimg = transportcardimg;
    }

    public String getBeginCarlength() {
        return beginCarlength;
    }

    public void setBeginCarlength(String beginCarlength) {
        this.beginCarlength = beginCarlength;
    }

    public String getEndCarlength() {
        return endCarlength;
    }

    public void setEndCarlength(String endCarlength) {
        this.endCarlength = endCarlength;
    }

    public Date getBeginCreateDate() {
        return beginCreateDate;
    }

    public void setBeginCreateDate(Date beginCreateDate) {
        this.beginCreateDate = beginCreateDate;
    }

    @ExcelField(title = "创建时间", type = 1, align = 2, sort = 19)
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

    @ExcelField(title = "更新时间", type = 1, align = 2, sort = 20)
    public Date getEndUpdateDate() {
        return endUpdateDate;
    }

    public void setEndUpdateDate(Date endUpdateDate) {
        this.endUpdateDate = endUpdateDate;
    }

    public String getMininame() {
        return this.mininame;
    }

    public void setMininame(String mininame) {
        this.mininame = mininame;
    }

    public String getNumber() {
        return this.number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getFromaddress() {
        return fromaddress;
    }

    public void setFromaddress(String fromaddress) {
        this.fromaddress = fromaddress;
    }

    public String getToaddress() {
        return toaddress;
    }

    public void setToaddress(String toaddress) {
        this.toaddress = toaddress;
    }

    public GpsCarLocs getGpsloc() {
        return gpsloc;
    }

    public void setGpsloc(GpsCarLocs gpsloc) {
        this.gpsloc = gpsloc;
    }


    //========================================================车源扩展字段====================================================

    public String getCarsourceid() {
        return carsourceid;
    }

    public void setCarsourceid(String carsourceid) {
        this.carsourceid = carsourceid;
    }

    public String getCarsourcemainroad() {
        return carsourcemainroad;
    }

    public void setCarsourcemainroad(String carsourcemainroad) {
        this.carsourcemainroad = carsourcemainroad;
    }

    public String getContactname() {
        return contactname;
    }

    public void setContactname(String contactname) {
        this.contactname = contactname;
    }

    public String getContactmobile() {
        return contactmobile;
    }

    public void setContactmobile(String contactmobile) {
        this.contactmobile = contactmobile;
    }

    @JsonFormat(pattern = "yyyy-MM-dd")
    public Date getDeparturetime() {
        return departuretime;
    }

    public void setDeparturetime(Date departuretime) {
        this.departuretime = departuretime;
    }

    public String getCarsourcestatus() {
        return carsourcestatus;
    }

    public void setCarsourcestatus(String carsourcestatus) {
        this.carsourcestatus = carsourcestatus;
    }

    public int getFinishedtradecount() {
        return finishedtradecount;
    }

    public void setFinishedtradecount(int finishedtradecount) {
        this.finishedtradecount = finishedtradecount;
    }

    public Motorcade getMotorcade() {
        return motorcade;
    }

    public void setMotorcade(Motorcade motorcade) {
        this.motorcade = motorcade;
    }

    public MotorcadeCar getMotorcadeCar() {
        return motorcadeCar;
    }

    public void setMotorcadeCar(MotorcadeCar motorcadeCar) {
        this.motorcadeCar = motorcadeCar;
    }

    public String getMotorcadeId() {
        return motorcadeId;
    }

    public void setMotorcadeId(String motorcadeId) {
        this.motorcadeId = motorcadeId;
    }
}