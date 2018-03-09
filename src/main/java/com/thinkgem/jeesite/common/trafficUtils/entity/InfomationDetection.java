package com.thinkgem.jeesite.common.trafficUtils.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 信息验证实体类
 */
public class InfomationDetection extends DataEntity<InfomationDetection> {

    private static final long serialVersionUID = 1L;

    //车辆入网验证属性
    private String result;//查询结果
    private int status;//业务查询状态


    //套牌车验证
    private String area;//区县编码（必填项）如：110101


    //车辆行驶证验证
    private String vclWnrNm;//联系人      字符串类型,可为空值     如：张*
    private String vclWnrPhn;//联系人手机    字符串类型,可为空值      如：150****0000
    private String areaName;//车籍地        字符串类型,可为空值        如：北京
    private String vclTpNm;//车辆类型    字符串类型,可为空值       如：重型半挂牵引车
    private String vbrndCdNm;//车辆品牌    字符串类型,可为空值      如：福田牌
    private String prdCdNm;//车辆型号     字符串类型,可为空值       如：BJ4257SMFJB-S2
    private String cmpNm;//车主、业主     字符串类型,可为空值        如：李*
    private String vin;//车辆识别代码\车架号     字符串类型,可为空值     如：CN0000001
    private String vclTn;//总质量       字符串类型（单位Kg）,可为空值      如：1000000
    private String ldTn;//核定载重量       字符串类型（单位Kg）,可为空值     如：100000
    private String vclDrwTn;//准牵引总质量    字符串类型（单位Kg）,可为空值      如：100000
    private String vclLng;//外廓尺寸-长(mm)    字符串类型（单位mm）,可为空值     如：800.00
    private String vclWdt;//外廓尺寸-宽(mm)    字符串类型（单位mm）,可为空值      如：500.00
    private String vclHgt;//外廓尺寸-高(mm)    字符串类型（单位mm）,可为空值       如：500.00
    private String boxLng;//内廓尺寸-长(mm)    字符串类型（单位mm）,可为空值         如：600.00或--
    private String boxWdt;//内廓尺寸-宽(mm)    字符串类型（单位mm）,可为空值        如：600.00或--
    private String boxHgt;//内廓尺寸-高(mm)    字符串类型（单位mm）,可为空值         如：600.00或--
    private String serviceName;//服务商单位名称    字符串类型 ,可为空值        如：陕西服务商
    private String servicePhone;//服务商联系电话   字符串类型 ,可为空值       如：13811112222


    //道路运输证查询
    private String roadTransport;//道路运输证号码  如：0225895
    private String vdtTm;//有效期  如：2019-07-01/未知


    public InfomationDetection() {
        // TODO Auto-generated constructor stub
    }


    public String getResult() {
        return result;
    }


    public void setResult(String result) {
        this.result = result;
    }


    public int getStatus() {
        return status;
    }


    public void setStatus(int status) {
        this.status = status;
    }


    public String getArea() {
        return area;
    }


    public void setArea(String area) {
        this.area = area;
    }


    public String getVclWnrNm() {
        return vclWnrNm;
    }


    public void setVclWnrNm(String vclWnrNm) {
        this.vclWnrNm = vclWnrNm;
    }


    public String getVclWnrPhn() {
        return vclWnrPhn;
    }


    public void setVclWnrPhn(String vclWnrPhn) {
        this.vclWnrPhn = vclWnrPhn;
    }


    public String getAreaName() {
        return areaName;
    }


    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }


    public String getVclTpNm() {
        return vclTpNm;
    }


    public void setVclTpNm(String vclTpNm) {
        this.vclTpNm = vclTpNm;
    }


    public String getVbrndCdNm() {
        return vbrndCdNm;
    }


    public void setVbrndCdNm(String vbrndCdNm) {
        this.vbrndCdNm = vbrndCdNm;
    }


    public String getPrdCdNm() {
        return prdCdNm;
    }


    public void setPrdCdNm(String prdCdNm) {
        this.prdCdNm = prdCdNm;
    }


    public String getCmpNm() {
        return cmpNm;
    }


    public void setCmpNm(String cmpNm) {
        this.cmpNm = cmpNm;
    }


    public String getVin() {
        return vin;
    }


    public void setVin(String vin) {
        this.vin = vin;
    }


    public String getVclTn() {
        return vclTn;
    }


    public void setVclTn(String vclTn) {
        this.vclTn = vclTn;
    }


    public String getLdTn() {
        return ldTn;
    }


    public void setLdTn(String ldTn) {
        this.ldTn = ldTn;
    }


    public String getVclDrwTn() {
        return vclDrwTn;
    }


    public void setVclDrwTn(String vclDrwTn) {
        this.vclDrwTn = vclDrwTn;
    }


    public String getVclLng() {
        return vclLng;
    }


    public void setVclLng(String vclLng) {
        this.vclLng = vclLng;
    }


    public String getVclWdt() {
        return vclWdt;
    }


    public void setVclWdt(String vclWdt) {
        this.vclWdt = vclWdt;
    }


    public String getVclHgt() {
        return vclHgt;
    }


    public void setVclHgt(String vclHgt) {
        this.vclHgt = vclHgt;
    }


    public String getBoxLng() {
        return boxLng;
    }


    public void setBoxLng(String boxLng) {
        this.boxLng = boxLng;
    }


    public String getBoxWdt() {
        return boxWdt;
    }


    public void setBoxWdt(String boxWdt) {
        this.boxWdt = boxWdt;
    }


    public String getBoxHgt() {
        return boxHgt;
    }


    public void setBoxHgt(String boxHgt) {
        this.boxHgt = boxHgt;
    }


    public String getServiceName() {
        return serviceName;
    }


    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }


    public String getServicePhone() {
        return servicePhone;
    }


    public void setServicePhone(String servicePhone) {
        this.servicePhone = servicePhone;
    }


    public String getRoadTransport() {
        return roadTransport;
    }


    public void setRoadTransport(String roadTransport) {
        this.roadTransport = roadTransport;
    }


    public String getVdtTm() {
        return vdtTm;
    }


    public void setVdtTm(String vdtTm) {
        this.vdtTm = vdtTm;
    }


    public static long getSerialversionuid() {
        return serialVersionUID;
    }


    @Override
    public String toString() {
        return "InfomationDetection [result=" + result + ", status=" + status + ", area=" + area + ", vclWnrNm="
                + vclWnrNm + ", vclWnrPhn=" + vclWnrPhn + ", areaName=" + areaName + ", vclTpNm=" + vclTpNm
                + ", vbrndCdNm=" + vbrndCdNm + ", prdCdNm=" + prdCdNm + ", cmpNm=" + cmpNm + ", vin=" + vin + ", vclTn="
                + vclTn + ", ldTn=" + ldTn + ", vclDrwTn=" + vclDrwTn + ", vclLng=" + vclLng + ", vclWdt=" + vclWdt
                + ", vclHgt=" + vclHgt + ", boxLng=" + boxLng + ", boxWdt=" + boxWdt + ", boxHgt=" + boxHgt
                + ", serviceName=" + serviceName + ", servicePhone=" + servicePhone + ", roadTransport=" + roadTransport
                + ", vdtTm=" + vdtTm + "]";
    }


    public InfomationDetection(String result, int status, String area, String vclWnrNm, String vclWnrPhn,
                               String areaName, String vclTpNm, String vbrndCdNm, String prdCdNm, String cmpNm, String vin, String vclTn,
                               String ldTn, String vclDrwTn, String vclLng, String vclWdt, String vclHgt, String boxLng, String boxWdt,
                               String boxHgt, String serviceName, String servicePhone, String roadTransport, String vdtTm) {
        super();
        this.result = result;
        this.status = status;
        this.area = area;
        this.vclWnrNm = vclWnrNm;
        this.vclWnrPhn = vclWnrPhn;
        this.areaName = areaName;
        this.vclTpNm = vclTpNm;
        this.vbrndCdNm = vbrndCdNm;
        this.prdCdNm = prdCdNm;
        this.cmpNm = cmpNm;
        this.vin = vin;
        this.vclTn = vclTn;
        this.ldTn = ldTn;
        this.vclDrwTn = vclDrwTn;
        this.vclLng = vclLng;
        this.vclWdt = vclWdt;
        this.vclHgt = vclHgt;
        this.boxLng = boxLng;
        this.boxWdt = boxWdt;
        this.boxHgt = boxHgt;
        this.serviceName = serviceName;
        this.servicePhone = servicePhone;
        this.roadTransport = roadTransport;
        this.vdtTm = vdtTm;
    }


}
