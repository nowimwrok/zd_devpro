package com.thinkgem.jeesite.common.trafficUtils.entity;


import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 发货接口实体类
 *
 * @author Administrator
 */
public class GoodsRelease extends DataEntity<GoodsRelease> {

    /**
     *
     */

    private static final long serialVersionUID = 1L;
    //发布货源
    private String result;//查询结果
    private String status;//返回状态

    //找车接口
    //多维度找车接口
    private String vid;//车辆ID    例:11651561387135
    private String vno;//车牌号码      例:京A8***8
    private String vco;//车牌颜色       例:2或1     1：蓝色，2：黄色
    private String utc;//最后定位时间      例:1369756801000
    private String lon;//经度        例:  112.610288
    private String lat;//纬度         例:  30.552798
    private String vcltype;//车辆类型      例:  厢式货车
    private String img;    //车辆图片       例:   http://.....
    private String vehicleLength;//车辆长度（单位：毫米）    例:11.9
    private String ratifyLoad;//车辆载重（单位：千克）      例:  18.1

    //车辆ID获取车主信息接口
    private String vehicleno;//车牌号码      例：京A12345
    private String platecolorid;//车牌颜色    例：
    private String vehicleOwnerName;//车主联系人   例：
    private String vehicleOwnerPhone;//车主联系人电话   例：

    //发布货源短信
    private String state; //发送状态     字符串类型1.发送成功；2.发送失败；
    //3.非工作时间禁止发送（每日21:00~07:00禁止发送货源短信）；4.存在敏感词     例：1

    private String msgCotent;//货源信息内容     字符串类型，车主收到的货源短信信息内容
    //（根据输入参数及模板自动生成的货源文本内容）  例：【车旺智运】最新货源信息：
    //江西宜春-安徽阜阳 运28吨建材，求12.5米以上载重25-32吨栏板车，有效期至2017-01-02 ，货主：北京首钢  13811612039。退订回复TD。

    private String count;   //目标车主接收数量     接收到货源短信信息的目标车主数量  例：25

    public GoodsRelease() {
        // TODO Auto-generated constructor stub
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVid() {
        return vid;
    }

    public void setVid(String vid) {
        this.vid = vid;
    }

    public String getVno() {
        return vno;
    }

    public void setVno(String vno) {
        this.vno = vno;
    }

    public String getVco() {
        return vco;
    }

    public void setVco(String vco) {
        this.vco = vco;
    }

    public String getUtc() {
        return utc;
    }

    public void setUtc(String utc) {
        this.utc = utc;
    }

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getVcltype() {
        return vcltype;
    }

    public void setVcltype(String vcltype) {
        this.vcltype = vcltype;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getVehicleLength() {
        return vehicleLength;
    }

    public void setVehicleLength(String vehicleLength) {
        this.vehicleLength = vehicleLength;
    }

    public String getRatifyLoad() {
        return ratifyLoad;
    }

    public void setRatifyLoad(String ratifyLoad) {
        this.ratifyLoad = ratifyLoad;
    }

    public String getVehicleno() {
        return vehicleno;
    }

    public void setVehicleno(String vehicleno) {
        this.vehicleno = vehicleno;
    }

    public String getPlatecolorid() {
        return platecolorid;
    }

    public void setPlatecolorid(String platecolorid) {
        this.platecolorid = platecolorid;
    }

    public String getVehicleOwnerName() {
        return vehicleOwnerName;
    }

    public void setVehicleOwnerName(String vehicleOwnerName) {
        this.vehicleOwnerName = vehicleOwnerName;
    }

    public String getVehicleOwnerPhone() {
        return vehicleOwnerPhone;
    }

    public void setVehicleOwnerPhone(String vehicleOwnerPhone) {
        this.vehicleOwnerPhone = vehicleOwnerPhone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMsgCotent() {
        return msgCotent;
    }

    public void setMsgCotent(String msgCotent) {
        this.msgCotent = msgCotent;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    @Override
    public String toString() {
        return "GoodsRelease [result=" + result + ", status=" + status + ", vid=" + vid + ", vno=" + vno + ", vco="
                + vco + ", utc=" + utc + ", lon=" + lon + ", lat=" + lat + ", vcltype=" + vcltype + ", img=" + img
                + ", vehicleLength=" + vehicleLength + ", ratifyLoad=" + ratifyLoad + ", vehicleno=" + vehicleno
                + ", platecolorid=" + platecolorid + ", vehicleOwnerName=" + vehicleOwnerName + ", vehicleOwnerPhone="
                + vehicleOwnerPhone + ", state=" + state + ", msgCotent=" + msgCotent + ", count=" + count + "]";
    }

    public GoodsRelease(String result, String status, String vid, String vno, String vco, String utc, String lon,
                        String lat, String vcltype, String img, String vehicleLength, String ratifyLoad, String vehicleno,
                        String platecolorid, String vehicleOwnerName, String vehicleOwnerPhone, String state, String msgCotent,
                        String count) {
        super();
        this.result = result;
        this.status = status;
        this.vid = vid;
        this.vno = vno;
        this.vco = vco;
        this.utc = utc;
        this.lon = lon;
        this.lat = lat;
        this.vcltype = vcltype;
        this.img = img;
        this.vehicleLength = vehicleLength;
        this.ratifyLoad = ratifyLoad;
        this.vehicleno = vehicleno;
        this.platecolorid = platecolorid;
        this.vehicleOwnerName = vehicleOwnerName;
        this.vehicleOwnerPhone = vehicleOwnerPhone;
        this.state = state;
        this.msgCotent = msgCotent;
        this.count = count;
    }


}
