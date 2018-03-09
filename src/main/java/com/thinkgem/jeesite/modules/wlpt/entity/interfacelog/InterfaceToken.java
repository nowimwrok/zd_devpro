/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.interfacelog;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 接口令牌生成Entity
 * @author qiao
 * @version 2017-11-13
 */
public class InterfaceToken extends DataEntity<InterfaceToken> {
	
	private static final long serialVersionUID = 1L;
	private String token;		// 令牌
	
	public InterfaceToken() {
		super();
	}

	public InterfaceToken(String id){
		super(id);
	}

	@Length(min=0, max=255, message="令牌长度必须介于 0 和 255 之间")
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
}