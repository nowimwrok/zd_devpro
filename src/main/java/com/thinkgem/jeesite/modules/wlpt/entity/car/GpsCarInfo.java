/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.car;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 车辆gps数据，获取keyEntity
 * @author 饶江龙
 * @version 2016-08-17
 */
public class GpsCarInfo extends DataEntity<GpsCarInfo> {
	
	private static final long serialVersionUID = 1L;
	private String tid;		// 车队id
	private String tname;		// 车队名称
	private String cid;		// 辆车id
	private String cname;		// 辆车名称
	private String ckey;		// 车辆key
	private GpsCarLocs carLocs;   ///车辆定位信息
	
	public GpsCarInfo() {
		super();
	}

	public GpsCarInfo(String id){
		super(id);
	}

	@Length(min=0, max=32, message="车队id长度必须介于 0 和 32 之间")
	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}
	
	@Length(min=0, max=100, message="车队名称长度必须介于 0 和 100 之间")
	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}
	
	@Length(min=0, max=32, message="辆车id长度必须介于 0 和 32 之间")
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}
	
	@Length(min=0, max=100, message="辆车名称长度必须介于 0 和 100 之间")
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}
	
	@Length(min=0, max=32, message="车辆key长度必须介于 0 和 32 之间")
	public String getCkey() {
		return ckey;
	}

	public void setCkey(String ckey) {
		this.ckey = ckey;
	}

	public GpsCarLocs getCarLocs() {
		return carLocs;
	}

	public void setCarLocs(GpsCarLocs carLocs) {
		this.carLocs = carLocs;
	}
}