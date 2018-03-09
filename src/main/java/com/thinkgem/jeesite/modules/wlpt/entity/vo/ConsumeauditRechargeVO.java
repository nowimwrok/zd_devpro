/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.vo;

import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

/**
 * 后台账户充值，管理审核Entity
 * @author 饶江龙
 * @version 2016-08-02
 */
public class ConsumeauditRechargeVO extends DataEntity<ConsumeauditRechargeVO> {
	
	private static final long serialVersionUID = 1L;
	private User user;		// 交易用户ID
	private Consumerecod consume;		// 消费记录ID
	private String type;		// 类型：0后台系统账户充值，1后台充值、2平台提现
	private String auditstatus;		// 审核状态:0:不需要审核；1新建审核；2审核通过；3终审成功4:申请驳回
	private String consumeImg;		// 交易图片:凭据
	private Date beginCreateDate;		// 开始 创建时间
	private Date endCreateDate;		// 结束 创建时间
	private Date beginUpdateDate;		// 开始 更新时间
	private Date endUpdateDate;		// 结束 更新时间
	protected Date createDate;    // 创建日期
	
	public ConsumeauditRechargeVO() {
		super();
	}

	public ConsumeauditRechargeVO(String id){
		super(id);
	}

	@NotNull(message="交易用户不能为空")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	//@Length(min=0, max=64, message="消费记录ID长度必须介于 0 和 64 之间")
	@NotNull(message = "请填写充值信息")
	public Consumerecod getConsume() {
		return consume;
	}

	public void setConsume(Consumerecod consume) {
		this.consume = consume;
	}
	
	@Length(min=0, max=11, message="类型：0后台系统账户充值，1后台充值、2平台提现长度必须介于 0 和 11 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	@Length(min=0, max=255, message="交易图片:凭据长度必须介于 0 和 255 之间")
	public String getConsumeImg() {
		return consumeImg;
	}

	public void setConsumeImg(String consumeImg) {
		this.consumeImg = consumeImg;
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
		
	public Date getBeginUpdateDate() {
		return beginUpdateDate;
	}

	public void setBeginUpdateDate(Date beginUpdateDate) {
		this.beginUpdateDate = beginUpdateDate;
	}
	
	public Date getEndUpdateDate() {
		return endUpdateDate;
	}

	public void setEndUpdateDate(Date endUpdateDate) {
		this.endUpdateDate = endUpdateDate;
	}
	@ExcelField(title = "消费编号", align = 2, sort = 0, value = "consume.consumecode")
	public String consumecode(){
		if(getConsume()!=null&&!Tools.IsNullOrWhiteSpace(getConsume().getConsumecode())){
			return getConsume().getConsumecode();
		}
		return "";
		
	}
	
	@ExcelField(title = "用户名", align = 2, sort = 1, value = "user.loginName")
	public String loginName(){
		if(getUser()!=null&&!Tools.IsNullOrWhiteSpace(getUser().getLoginName())){
			return getUser().getLoginName();
		}
		return "";
		
	}
	
	@ExcelField(title = "真实姓名", align = 2, sort = 2, value = "user.name")
	public String name(){
		if(getUser()!=null&&!Tools.IsNullOrWhiteSpace(getUser().getName())){
			return getUser().getName();
		}
		return "";
		
	}
	
	@ExcelField(title = "手机号码", align = 2, sort = 3, value = "user.phone")
	public String phone(){
		if(getUser()!=null&&!Tools.IsNullOrWhiteSpace(getUser().getPhone())){
			return getUser().getPhone();
		}
		return "";
		
	}
	
	
	@ExcelField(title = "充值前", align = 2, sort = 4, value = "consume.beforemony")
	public String beforemony(){
		if(getConsume()!=null&&!Tools.IsNullOrWhiteSpace(getConsume().getBeforemony())){
			return getConsume().getBeforemony();
		}
		return "";
		
	}
	
	@ExcelField(title = "充值金额", align = 2, sort = 5, value = "consume.consumemony")
	public String consumemony(){
		if(getConsume()!=null&&!Tools.IsNullOrWhiteSpace(getConsume().getConsumemony())){
			return getConsume().getConsumemony();
		}
		return "";
		
	}
	
	@ExcelField(title = "充值后", align = 2, sort = 6, value = "consume.aftermony")
	public String aftermony(){
		if(getConsume()!=null&&!Tools.IsNullOrWhiteSpace(getConsume().getAftermony())){
			return getConsume().getAftermony();
		}
		return "";
		
	}
	
	@Length(min=0, max=11, message="审核状态:0:不需要审核；1新建审核；2审核通过；3终审成功4:申请驳回长度必须介于 0 和 11 之间")
	@ExcelField(title = "审核状态",align = 2,sort = 7,dictType="consumeaudit_status")
	public String getAuditstatus() {
		return auditstatus;
	}

	public void setAuditstatus(String auditstatus) {
		this.auditstatus = auditstatus;
	}
	
	@ExcelField(title = "充值时间", align = 2, sort = 8, value = "createDate")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}

	@ExcelField(title = "更新者", align = 2, sort = 9, value = "updateBy.loginName")
	public String byloginName(){
		if(getUpdateBy()!=null&&!Tools.IsNullOrWhiteSpace(getUpdateBy().getLoginName())){
			return getUpdateBy().getLoginName();
		}
		return "";
		
	}
	
	
}