/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.user;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户身份证Entity
 * @author fjc
 * @version 2016-08-02
 */
public class UserIdcard extends DataEntity<UserIdcard> {
	
	private static final long serialVersionUID = 1L;
	private String imemberid;		// imemberid
	private String idcardnum;		// 身份证号码,主键
	private String sname;		// 真实姓名
	private String isex;		// 性别:0,女;1,男
	private String snation;		// 民族
	private Date tbirthdate;		// 出生日期
	private String saddress;		// 居民住址
	private String scardaddress;		// 发证地址|发证机关
	private Date tvaliddatebegin;		// 有效期开始时间
	private Date tvaliddateend;		// 有效期结束时间
	private String slocalphoto;		// 自己上传的身份证照片[正反面用&amp;分割]
	private String slocaltitle;		// 自己上传的身份证照片名称[正反面用&amp;分割]
	private Date tlocaltime;		// 自己上传的身份证照片时间
	private String suploader;		// 上传者:用户
	private String sinternetphoto;		// 公安系统验证的身份证照片[正反面用&amp;分割]
	private String sinternettitle;		// 公安系统验证的身份证照片名称[正反面用&amp;分割]
	private Date tinternettime;		// 公安系统验证的身份证照片时间：最近一次
	private String bisinternet;		// 是否进行过公安系统身份验证：1,有|0,没有
	private String sinternetmobile;		// 支付核查的手机号
	private String schecker;		// 支付核查的用户
	private String icheckedtimes;		// 被核查的次数
	
	public UserIdcard() {
		super();
	}

	public UserIdcard(String id){
		super(id);
	}
	
	@Length(min=0, max=11, message="imemberid长度必须介于 0 和 11 之间")
	public String getImemberid() {
		return imemberid;
	}

	public void setImemberid(String imemberid) {
		this.imemberid = imemberid;
	}
	
	@Length(min=0, max=20, message="身份证号码,主键长度必须介于 0 和 20 之间")
	public String getIdcardnum() {
		return idcardnum;
	}

	public void setIdcardnum(String idcardnum) {
		this.idcardnum = idcardnum;
	}
	
	@Length(min=0, max=20, message="真实姓名长度必须介于 0 和 20 之间")
	public String getSname() {
		return sname;
	}

	public void setSname(String sname) {
		this.sname = sname;
	}
	
	@Length(min=0, max=11, message="性别:0,女;1,男长度必须介于 0 和 11 之间")
	public String getIsex() {
		return isex;
	}

	public void setIsex(String isex) {
		this.isex = isex;
	}
	
	@Length(min=0, max=100, message="民族长度必须介于 0 和 100 之间")
	public String getSnation() {
		return snation;
	}

	public void setSnation(String snation) {
		this.snation = snation;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTbirthdate() {
		return tbirthdate;
	}

	public void setTbirthdate(Date tbirthdate) {
		this.tbirthdate = tbirthdate;
	}
	
	@Length(min=0, max=200, message="居民住址长度必须介于 0 和 200 之间")
	public String getSaddress() {
		return saddress;
	}

	public void setSaddress(String saddress) {
		this.saddress = saddress;
	}
	
	@Length(min=0, max=200, message="发证地址|发证机关长度必须介于 0 和 200 之间")
	public String getScardaddress() {
		return scardaddress;
	}

	public void setScardaddress(String scardaddress) {
		this.scardaddress = scardaddress;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTvaliddatebegin() {
		return tvaliddatebegin;
	}

	public void setTvaliddatebegin(Date tvaliddatebegin) {
		this.tvaliddatebegin = tvaliddatebegin;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTvaliddateend() {
		return tvaliddateend;
	}

	public void setTvaliddateend(Date tvaliddateend) {
		this.tvaliddateend = tvaliddateend;
	}
	
	@Length(min=0, max=500, message="自己上传的身份证照片[正反面用&amp;分割]长度必须介于 0 和 500 之间")
	public String getSlocalphoto() {
		return slocalphoto;
	}

	public void setSlocalphoto(String slocalphoto) {
		this.slocalphoto = slocalphoto;
	}
	
	@Length(min=0, max=500, message="自己上传的身份证照片名称[正反面用&amp;分割]长度必须介于 0 和 500 之间")
	public String getSlocaltitle() {
		return slocaltitle;
	}

	public void setSlocaltitle(String slocaltitle) {
		this.slocaltitle = slocaltitle;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTlocaltime() {
		return tlocaltime;
	}

	public void setTlocaltime(Date tlocaltime) {
		this.tlocaltime = tlocaltime;
	}
	
	@Length(min=0, max=20, message="上传者:用户长度必须介于 0 和 20 之间")
	public String getSuploader() {
		return suploader;
	}

	public void setSuploader(String suploader) {
		this.suploader = suploader;
	}
	
	@Length(min=0, max=500, message="公安系统验证的身份证照片[正反面用&amp;分割]长度必须介于 0 和 500 之间")
	public String getSinternetphoto() {
		return sinternetphoto;
	}

	public void setSinternetphoto(String sinternetphoto) {
		this.sinternetphoto = sinternetphoto;
	}
	
	@Length(min=0, max=500, message="公安系统验证的身份证照片名称[正反面用&amp;分割]长度必须介于 0 和 500 之间")
	public String getSinternettitle() {
		return sinternettitle;
	}

	public void setSinternettitle(String sinternettitle) {
		this.sinternettitle = sinternettitle;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTinternettime() {
		return tinternettime;
	}

	public void setTinternettime(Date tinternettime) {
		this.tinternettime = tinternettime;
	}
	
	@Length(min=1, max=11, message="是否进行过公安系统身份验证：1,有|0,没有长度必须介于 1 和 11 之间")
	public String getBisinternet() {
		return bisinternet;
	}

	public void setBisinternet(String bisinternet) {
		this.bisinternet = bisinternet;
	}
	
	@Length(min=0, max=20, message="支付核查的手机号长度必须介于 0 和 20 之间")
	public String getSinternetmobile() {
		return sinternetmobile;
	}

	public void setSinternetmobile(String sinternetmobile) {
		this.sinternetmobile = sinternetmobile;
	}
	
	@Length(min=0, max=20, message="支付核查的用户长度必须介于 0 和 20 之间")
	public String getSchecker() {
		return schecker;
	}

	public void setSchecker(String schecker) {
		this.schecker = schecker;
	}
	
	@Length(min=1, max=11, message="被核查的次数长度必须介于 1 和 11 之间")
	public String getIcheckedtimes() {
		return icheckedtimes;
	}

	public void setIcheckedtimes(String icheckedtimes) {
		this.icheckedtimes = icheckedtimes;
	}
	
}