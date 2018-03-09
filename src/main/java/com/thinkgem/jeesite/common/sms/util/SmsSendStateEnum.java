package com.thinkgem.jeesite.common.sms.util;

/**
 * ClassName: SmsSendState 
 * @Description: 发送结果枚举类型
 * @author 荣亮
 * @date 2015年5月6日
 */
public enum SmsSendStateEnum {
	/**
	 * @Fields Succeed : 发送成功
	 */
	Succeed,
	/**
	 * @Fields InsufficientBalance : 账户余额不足
	 */
	InsufficientBalance,
	/**
	 * @Fields HaveFilterKey : 有过滤关键字
	 */
	HaveFilterKey,
	/**
	 * @Fields MsgOverstep : 超出限制
	 */
	MsgOverstep,
	/**
	 * @Fields Error : 发生错误
	 */
	Error
	
}
