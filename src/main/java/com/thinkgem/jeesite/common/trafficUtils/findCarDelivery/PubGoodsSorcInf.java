package com.thinkgem.jeesite.common.trafficUtils.findCarDelivery;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.entity.GoodsRelease;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;

/**
 * 发布货源
 * 
 * @author Shinelon
 *
 */
//@Service
public class PubGoodsSorcInf {

	private GoodsRelease release;
	
	/**
	 * 发布货源接口 提供按始发地、目的地、发货单位、货物类型、所需车辆类型、期望价格、联系方式等信息 发布至车旺智运货源平台服务。
	 * 
	 * @param startArea
	 *            起始地
	 * @param endArea
	 *            目的地
	 * @param vtype
	 *            车型需求
	 * @param vlen
	 *            车长需求
	 * @param vton
	 *            车辆载重需求
	 * @param expTime
	 *            发货有效期
	 * @param sendFreq
	 *            发货频次(1：只发一次；2：每日发货；3：单日发货;4：双日发货；5：其他请备注)
	 * @param cargoId
	 *            货物分类：1:普货2:设备；3:建材4:木材；5:家具6:服装；7:食品8:果蔬；9:粮食10:电器；11:煤炭12:钢材；
	 *            13:冷藏品；14:易碎品
	 * @param gton
	 *            货物重量
	 * @param gvol
	 *            货物体积
	 * @param contact
	 *            联系人
	 * @param contel
	 *            联系人电话
	 * @param refPrice
	 *            货源参考价格
	 * @param priType
	 *            报价类型，1：元/吨，2：元/车，3：元/方
	 * @param gbidType
	 *            货主的报价意向，1：报具体价格；2：双方协商
	 * @param belEup
	 *            发货单位
	 * @param userPhone
	 *            当前调用接口的用户手机号
	 */
	public Map<String, Object> pubGoodsSorc(String token,String startArea, String endArea, String vtype, String vlen, String vton,
			String expTime, String sendFreq, String cargoId, String gton, String gvol, String contact, String contel,
			String refPrice, String priType, String gbidType, String belEup, String userPhone) {
		String jsonstr = ZhiyunOpenapi.pubGoodsSorcInf(token, startArea, endArea, vtype, vlen, vton, expTime, sendFreq,
				cargoId, gton, gvol, contact, contel, refPrice, priType, gbidType, belEup, userPhone);
		String message = "查询成功";
		String jsonObjects = null;
		int state = DataDic.RETURN_STATUS_NORMAL;
		try {
			JSONObject jsonObject = new JSONObject(jsonstr);
			if(!jsonObject.isNull("result")) {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "查询为空";
				return Tools.getMapResult(state, message, null);
			}
			
			jsonObjects = jsonObject.getString("result");
			
			message = String.valueOf(jsonObject.getInt("status"));
			return Tools.getMapResult(state, message, jsonObjects);

		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "查询查询失败";
			return Tools.getMapResult(state, message, null);
		}
	}

	/**
	 * 发布货源短信接口 本接口通过指定车牌号、车牌颜色查询道路运输证号码及有效期等信息。
	 * 
	 * @param vids
	 *            车辆ID(以半角逗号连接支持批量，多个ID号用逗号分隔，最多支持100个车辆ID)
	 * @param startArea
	 *            始发地, 不超过10个字符
	 * @param endArea
	 *            目的地, 不超过10个字符
	 * @param gType
	 *            货物分类（1:普货；2:设备；3:建材；4:木材；5:家具；6:服装；7:食品；8:果蔬；9:粮食；10:电器；11:煤炭；
	 *            12:钢材；13:冷藏品；14:易碎品）
	 * @param vType
	 *            车型需求（0：不限；1：栏板车；2：高栏车；3：厢式货车；4：自卸车；5：冷藏车7：平板车；）
	 * @param gOwner
	 *            货主身份（货主的身份信息，如：北京首钢，不超过10个字符）
	 * @param conPhone
	 *            货主联系电话
	 */
	public Object pubGoodsMsg(String token,String vids, String startArea, String endArea, String gType, String vType, String gOwner,
			String conPhone) {
		String jsonstr = ZhiyunOpenapi.pubGoodsMsg(token, vids, startArea, endArea, gType, vType, gOwner, conPhone);
		JSONObject jsonObject = new JSONObject(jsonstr);
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "";
		try {
			if(!jsonObject.isNull("result")) {
				JSONObject jsonObjects = jsonObject.getJSONObject("result");
				if (jsonObjects.get("result") == null) {
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = "查询为空";
					return Tools.getMapResult(state, message, "");
				}
				release = new GoodsRelease();
				release.setState(jsonObjects.getString("state"));
				release.setMsgCotent(jsonObjects.getString("msgCotent"));

				release.setCount(jsonObjects.getString("count"));
			}
				message = String.valueOf(jsonObject.getInt("status"));

			return Tools.getMapResult(state, message, release);
		} catch (Exception e) {
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_SYSBUG;
			message="系统异常";
			return Tools.getMapResult(state, message,"");
		}
	}


}
