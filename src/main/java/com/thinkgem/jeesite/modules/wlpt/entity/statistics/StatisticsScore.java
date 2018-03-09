/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.statistics;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 诚信积分统计Entity
 * @author 曾煜佳
 * @version 2016-09-12
 */
public class StatisticsScore extends DataEntity<StatisticsScore> {
	
	private static final long serialVersionUID = 1L;
	private Long zerothCustnum;		// 等级0：会员数量
	private Long zerothAllcredit;		// 等级0：总授信
	private Long zerothDocredit;		// 等级0：可用授信
	private Long zerothDeposit;		// 等级0：押金－担保金
	private Long zerothProportion;		// 等级0：比例
	private Long firstCustnum;		// 等级1：会员数量
	private Long firstAllcredit;		// 等级1：总授信
	private Long firstDocredit;		// 等级1：可用授信
	private Long firstDeposit;		// 等级1：押金－担保金
	private Long firstProportion;		// 等级1：比例
	private Long secondCustnum;		// 等级2：会员数量
	private Long secondAllcredit;		// 等级2：总授信
	private Long secondDocredit;		// 等级2：可用授信
	private Long secondDeposit;		// 等级2：押金－担保金
	private Long secondProportion;		// 等级2：比例
	private Long thirdCustnum;		// 等级3：会员数量
	private Long thirdAllcredit;		// 等级3：总授信
	private Long thirdDocredit;		// 等级3：可用授信
	private Long thirdDeposit;		// 等级3：押金－担保金
	private Long thirdProportion;		// 等级3：比例
	private Long fourthCustnum;		// 等级4：会员数量
	private Long fourthAllcredit;		// 等级4：总授信
	private Long fourthDocredit;		// 等级4：可用授信
	private Long fourthDeposit;		// 等级4：押金－担保金
	private Long fourthProportion;		// 等级4：比例
	private Long fifthCustnum;		// 等级5：会员数量
	private Long fifthAllcredit;		// 等级5：总授信
	private Long fifthDocredit;		// 等级5：可用授信
	private Long fifthDeposit;		// 等级5：押金－担保金
	private Long fifthProportion;		// 等级5：比例
	private Long totlaCustnum;		// 总：会员数量
	private Long totlaAllcredit;		// 总：总授信
	private Long totlaDocredit;		// 总：可用授信
	private Long totlaDeposit;		// 总：押金－担保金
	private Long totlaProportion;		// 总：比例
	private Date createtime;		// 统计时间
	
	private Date beginCreateDate; // 开始 创建时间
	private Date endCreateDate; // 结束 创建时间
	public StatisticsScore() {
		super();
	}

	public StatisticsScore(String id){
		super(id);
	}

	//============================================等级0============================================
	 
	@ExcelField(title="等级0-会员数量", align=2, sort=0)
	public Long getZerothCustnum() {
		return zerothCustnum;
	}

	public void setZerothCustnum(Long zerothCustnum) {
		this.zerothCustnum = zerothCustnum;
	}
	
	@ExcelField(title="等级0-总授信", align=2, sort=1)
	public Long getZerothAllcredit() {
		return zerothAllcredit;
	}

	public void setZerothAllcredit(Long zerothAllcredit) {
		this.zerothAllcredit = zerothAllcredit;
	}
	
	@ExcelField(title="等级0-可用授信", align=2, sort=2)
	public Long getZerothDocredit() {
		return zerothDocredit;
	}

	public void setZerothDocredit(Long zerothDocredit) {
		this.zerothDocredit = zerothDocredit;
	}
	
	@ExcelField(title="等级0-担保金", align=2, sort=3)
	public Long getZerothDeposit() {
		return zerothDeposit;
	}

	public void setZerothDeposit(Long zerothDeposit) {
		this.zerothDeposit = zerothDeposit;
	}
	
	@ExcelField(title="等级0-比例", align=2, sort=4)
	public Long getZerothProportion() {
		return zerothProportion;
	}

	public void setZerothProportion(Long zerothProportion) {
		this.zerothProportion = zerothProportion;
	}
	
	//===========================================等级1==============================
	
	@ExcelField(title="等级1-会员数量", align=2, sort=5)
	public Long getFirstCustnum() {
		return firstCustnum;
	}

	public void setFirstCustnum(Long firstCustnum) {
		this.firstCustnum = firstCustnum;
	}
	
	@ExcelField(title="等级1-总授信", align=2, sort=6)
	public Long getFirstAllcredit() {
		return firstAllcredit;
	}

	public void setFirstAllcredit(Long firstAllcredit) {
		this.firstAllcredit = firstAllcredit;
	}
	
	@ExcelField(title="等级1-可用授信", align=2, sort=7)
	public Long getFirstDocredit() {
		return firstDocredit;
	}

	public void setFirstDocredit(Long firstDocredit) {
		this.firstDocredit = firstDocredit;
	}
	
	@ExcelField(title="等级1-担保金", align=2, sort=8)
	public Long getFirstDeposit() {
		return firstDeposit;
	}

	public void setFirstDeposit(Long firstDeposit) {
		this.firstDeposit = firstDeposit;
	}
	
	@ExcelField(title="等级1-比例", align=2, sort=9)
	public Long getFirstProportion() {
		return firstProportion;
	}

	public void setFirstProportion(Long firstProportion) {
		this.firstProportion = firstProportion;
	}
	
	//============================================等级2============================================
	
	@ExcelField(title="等级2-会员数量", align=2, sort=10)
	public Long getSecondCustnum() {
		return secondCustnum;
	}

	public void setSecondCustnum(Long secondCustnum) {
		this.secondCustnum = secondCustnum;
	}
	
	@ExcelField(title="等级2-总授信", align=2, sort=11)
	public Long getSecondAllcredit() {
		return secondAllcredit;
	}

	public void setSecondAllcredit(Long secondAllcredit) {
		this.secondAllcredit = secondAllcredit;
	}
	
	@ExcelField(title="等级2-可用授信", align=2, sort=12)
	public Long getSecondDocredit() {
		return secondDocredit;
	}

	public void setSecondDocredit(Long secondDocredit) {
		this.secondDocredit = secondDocredit;
	}
	
	@ExcelField(title="等级2-担保金", align=2, sort=13)
	public Long getSecondDeposit() {
		return secondDeposit;
	}

	public void setSecondDeposit(Long secondDeposit) {
		this.secondDeposit = secondDeposit;
	}
	
	@ExcelField(title="等级2-比例", align=2, sort=14)
	public Long getSecondProportion() {
		return secondProportion;
	}

	public void setSecondProportion(Long secondProportion) {
		this.secondProportion = secondProportion;
	}
	
	//============================================等级3============================================
	
	@ExcelField(title="等级3-会员数量", align=2, sort=15)
	public Long getThirdCustnum() {
		return thirdCustnum;
	}

	public void setThirdCustnum(Long thirdCustnum) {
		this.thirdCustnum = thirdCustnum;
	}
	
	@ExcelField(title="等级3-总授信", align=2, sort=16)
	public Long getThirdAllcredit() {
		return thirdAllcredit;
	}

	public void setThirdAllcredit(Long thirdAllcredit) {
		this.thirdAllcredit = thirdAllcredit;
	}
	
	@ExcelField(title="等级3-可用授信", align=2, sort=17)
	public Long getThirdDocredit() {
		return thirdDocredit;
	}

	public void setThirdDocredit(Long thirdDocredit) {
		this.thirdDocredit = thirdDocredit;
	}
	
	@ExcelField(title="等级3-担保金", align=2, sort=18)
	public Long getThirdDeposit() {
		return thirdDeposit;
	}

	public void setThirdDeposit(Long thirdDeposit) {
		this.thirdDeposit = thirdDeposit;
	}
	
	@ExcelField(title="等级3-比例", align=2, sort=19)
	public Long getThirdProportion() {
		return thirdProportion;
	}

	public void setThirdProportion(Long thirdProportion) {
		this.thirdProportion = thirdProportion;
	}
	
	//============================================等级4============================================
	
	@ExcelField(title="等级4-会员数量", align=2, sort=20)
	public Long getFourthCustnum() {
		return fourthCustnum;
	}

	public void setFourthCustnum(Long fourthCustnum) {
		this.fourthCustnum = fourthCustnum;
	}
	
	@ExcelField(title="等级4-总授信", align=2, sort=21)
	public Long getFourthAllcredit() {
		return fourthAllcredit;
	}

	public void setFourthAllcredit(Long fourthAllcredit) {
		this.fourthAllcredit = fourthAllcredit;
	}
	
	@ExcelField(title="等级4-可用授信", align=2, sort=22)
	public Long getFourthDocredit() {
		return fourthDocredit;
	}

	public void setFourthDocredit(Long fourthDocredit) {
		this.fourthDocredit = fourthDocredit;
	}
	
	@ExcelField(title="等级4-担保金", align=2, sort=23)
	public Long getFourthDeposit() {
		return fourthDeposit;
	}

	public void setFourthDeposit(Long fourthDeposit) {
		this.fourthDeposit = fourthDeposit;
	}
	
	@ExcelField(title="等级4-比例", align=2, sort=24)
	public Long getFourthProportion() {
		return fourthProportion;
	}

	public void setFourthProportion(Long fourthProportion) {
		this.fourthProportion = fourthProportion;
	}
	
	//============================================等级5============================================
	
	@ExcelField(title="等级5-会员数量", align=2, sort=25)
	public Long getFifthCustnum() {
		return fifthCustnum;
	}

	public void setFifthCustnum(Long fifthCustnum) {
		this.fifthCustnum = fifthCustnum;
	}
	
	@ExcelField(title="等级5-总授信", align=2, sort=26)
	public Long getFifthAllcredit() {
		return fifthAllcredit;
	}

	public void setFifthAllcredit(Long fifthAllcredit) {
		this.fifthAllcredit = fifthAllcredit;
	}
	
	@ExcelField(title="等级5-可用授信", align=2, sort=27)
	public Long getFifthDocredit() {
		return fifthDocredit;
	}

	public void setFifthDocredit(Long fifthDocredit) {
		this.fifthDocredit = fifthDocredit;
	}
	
	@ExcelField(title="等级5-比例", align=2, sort=28)
	public Long getFifthDeposit() {
		return fifthDeposit;
	}

	public void setFifthDeposit(Long fifthDeposit) {
		this.fifthDeposit = fifthDeposit;
	}
	
	@ExcelField(title="等级5", align=2, sort=29)
	public Long getFifthProportion() {
		return fifthProportion;
	}

	public void setFifthProportion(Long fifthProportion) {
		this.fifthProportion = fifthProportion;
	}
	
	
	//============================================总量============================================
	
	@ExcelField(title="总量-会员数量", align=2, sort=30)
	public Long getTotlaCustnum() {
		return totlaCustnum;
	}

	public void setTotlaCustnum(Long totlaCustnum) {
		this.totlaCustnum = totlaCustnum;
	}
	
	@ExcelField(title="总量-总授信", align=2, sort=31)
	public Long getTotlaAllcredit() {
		return totlaAllcredit;
	}

	public void setTotlaAllcredit(Long totlaAllcredit) {
		this.totlaAllcredit = totlaAllcredit;
	}
	
	@ExcelField(title="总量-可用授信", align=2, sort=32)
	public Long getTotlaDocredit() {
		return totlaDocredit;
	}

	public void setTotlaDocredit(Long totlaDocredit) {
		this.totlaDocredit = totlaDocredit;
	}
	
	@ExcelField(title="总量-担保金", align=2, sort=33)
	public Long getTotlaDeposit() {
		return totlaDeposit;
	}

	public void setTotlaDeposit(Long totlaDeposit) {
		this.totlaDeposit = totlaDeposit;
	}
	
	@ExcelField(title="总量-比例", align=2, sort=34)
	public Long getTotlaProportion() {
		return totlaProportion;
	}

	public void setTotlaProportion(Long totlaProportion) {
		this.totlaProportion = totlaProportion;
	}
	
	
	//============================================统计时间============================================
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="统计时间", align=2, sort=35)
	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
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
	
	
}