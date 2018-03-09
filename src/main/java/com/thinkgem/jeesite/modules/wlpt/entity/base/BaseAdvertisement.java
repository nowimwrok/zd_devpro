/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * base_advertisementEntity
 * @author 王铸
 * @version 2016-08-06
 */
public class BaseAdvertisement extends DataEntity<BaseAdvertisement> {
	
	private static final long serialVersionUID = 1L;
	private String advertisementId;		// advertisement_id
	private String adverttitle;		// 广告标题
	private String advertname;		// 广告名称
	private String advertbytes;		// 文件大小
	private String advertsize;		// 广告尺寸
	private String positionid;		// 摆放位置
	private String positionname;		// 摆放位置描述
	private String picture;		// 图片全名称
	private String picname;		// 图片名称
	private String linkaddress;		// 链接地址
	private String sortcode;		// 排序码
	private String uploader;		// 上传者
	private String uploadtime;		// 上传时间
	private String accesssystemcode;		// accesssystemcode
	private String isdelete;		// isdelete
	private String backgroundcolor;		// 广告图片的过度背景颜色:6位16进制#800000
	
	public BaseAdvertisement() {
		super();
	}

	public BaseAdvertisement(String id){
		super(id);
	}

	@Length(min=1, max=32, message="advertisement_id长度必须介于 1 和 32 之间")
	public String getAdvertisementId() {
		return advertisementId;
	}

	public void setAdvertisementId(String advertisementId) {
		this.advertisementId = advertisementId;
	}
	
	@Length(min=0, max=256, message="广告标题长度必须介于 0 和 256 之间")
	public String getAdverttitle() {
		return adverttitle;
	}

	public void setAdverttitle(String adverttitle) {
		this.adverttitle = adverttitle;
	}
	
	@Length(min=0, max=256, message="广告名称长度必须介于 0 和 256 之间")
	public String getAdvertname() {
		return advertname;
	}

	public void setAdvertname(String advertname) {
		this.advertname = advertname;
	}
	
	@Length(min=1, max=11, message="文件大小长度必须介于 1 和 11 之间")
	public String getAdvertbytes() {
		return advertbytes;
	}

	public void setAdvertbytes(String advertbytes) {
		this.advertbytes = advertbytes;
	}
	
	@Length(min=0, max=256, message="广告尺寸长度必须介于 0 和 256 之间")
	public String getAdvertsize() {
		return advertsize;
	}

	public void setAdvertsize(String advertsize) {
		this.advertsize = advertsize;
	}
	
	@Length(min=1, max=11, message="摆放位置长度必须介于 1 和 11 之间")
	public String getPositionid() {
		return positionid;
	}

	public void setPositionid(String positionid) {
		this.positionid = positionid;
	}
	
	@Length(min=0, max=256, message="摆放位置描述长度必须介于 0 和 256 之间")
	public String getPositionname() {
		return positionname;
	}

	public void setPositionname(String positionname) {
		this.positionname = positionname;
	}
	
	@Length(min=1, max=256, message="图片名称长度必须介于 1 和 256 之间")
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
		String[] pictures=picture.split("\\/");
		if(pictures.length>1){
		   this.picname= pictures[pictures.length-1];
		}else{
			this.picname=picture;
		}
	}
	
	@Length(min=0, max=255, message="链接地址长度必须介于 0 和 255 之间")
	public String getLinkaddress() {
		return linkaddress;
	}

	public void setLinkaddress(String linkaddress) {
		this.linkaddress = linkaddress;
	}
	
	@Length(min=1, max=11, message="排序码长度必须介于 1 和 11 之间")
	public String getSortcode() {
		return sortcode;
	}

	public void setSortcode(String sortcode) {
		this.sortcode = sortcode;
	}
	
	@Length(min=0, max=255, message="上传者长度必须介于 0 和 255 之间")
	public String getUploader() {
		return uploader;
	}

	public void setUploader(String uploader) {
		this.uploader = uploader;
	}
	
	@Length(min=0, max=255, message="上传时间长度必须介于 0 和 255 之间")
	public String getUploadtime() {
		return uploadtime;
	}

	public void setUploadtime(String uploadtime) {
		this.uploadtime = uploadtime;
	}
	
	@Length(min=0, max=11, message="accesssystemcode长度必须介于 0 和 11 之间")
	public String getAccesssystemcode() {
		return accesssystemcode;
	}

	public void setAccesssystemcode(String accesssystemcode) {
		this.accesssystemcode = accesssystemcode;
	}
	
	@Length(min=0, max=11, message="isdelete长度必须介于 0 和 11 之间")
	public String getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(String isdelete) {
		this.isdelete = isdelete;
	}
	
	@Length(min=0, max=45, message="广告图片的过度背景颜色:6位16进制#800000长度必须介于 0 和 45 之间")
	public String getBackgroundcolor() {
		return backgroundcolor;
	}

	public void setBackgroundcolor(String backgroundcolor) {
		this.backgroundcolor = backgroundcolor;
	}

	public String getPicname() {
		return picname;
	}
}