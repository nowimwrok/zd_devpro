package com.thinkgem.jeesite.modules.wlpt.biz.gps;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.wlpt.dao.gps.GpsUpdateDao;
import com.thinkgem.jeesite.modules.wlpt.dao.trade.OrderinfoDao;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.gps.GpsUpdate;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;

@Service
@Transactional(readOnly = true)
public class GpsUpdateBiz {
	@Autowired
	private GpsUpdateDao gpsUpdateDao;
	@Autowired
	private CarService carService;
	// @Autowired
	// private SystemService userService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private OrderinfoDao orderInfoDao;
	@Autowired
	private SystemService systemService; 

	/**
	 * 分析数据并存入数据库
	 * 
	 * @param loginName
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> sendRail(String username, String password, String carNum, String railName,
			String railType, String railTime, String railLeaveTime, String railStopTime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		int state = DataDic.RAIL_SUCCESS;
		String message = "";
		try {
			GpsUpdate gpsUpdate = null;
			// DemoList demoList = new DemoList();
			// 检验用户名密码是否对应
			User user = new User();
			user.setDelFlag("0");
			user.setLoginName(username);
			User userCheck = userDao.getByLoginName(user);
			// Map<String,Object> map = demoList.addList();
			// User user = systemService.getUserByLoginName(loginName);
			if (userCheck == null) {
				state = DataDic.RAIL_USERFAILED;
				message = "用户名错误";
			}
			if (username.equals(userCheck.getName()) && password.equals(userCheck.getPassword()) && username != null
					&& password != null) {
				// 判断用户是否存在
				long count = orderInfoDao.findByUserid(userCheck.getId());
				if (count != 0) {
					gpsUpdate = new GpsUpdate();
					gpsUpdate.setId(IdGen.uuid());
					// 判断车牌是否在数据库中
					int count1 = carService.findByCarnumber(carNum);
					if (count1 != 0 && carNum != null && !carNum.equals("")) {
						gpsUpdate.setCarNumber(carNum);
					} else {
						state = DataDic.RAIL_MSGERROR;
						message = "查无此车";
					}
					if (railType != null && !railType.equals("")) {
						gpsUpdate.setRailType(railType);
					} else {
						state = DataDic.RAIL_PARAMERROR;
						message = "围栏类型为空";
						return Tools.getMapResult(state, message, null);
					}
					if (!gpsUpdate.getRailType().equals(DataDic.RAILTYPE_IN)
							&& !gpsUpdate.getRailType().equals(DataDic.RAILTYPE_OUT)) {
						state = DataDic.RAIL_PARAMERROR;
						message = "围栏类型错误,限制0和1";
					}
					if (railName != null && !railName.equals("")) {
						gpsUpdate.setRailName(railName);
					} else {
						state = DataDic.RAIL_PARAMERROR;
						message = "围栏名称错误";
					}
					if (railTime != null && !railTime.equals("")) {
						gpsUpdate.setRailTime(sdf.parse(railTime));
					} else {
						state = DataDic.RAIL_PARAMERROR;
						message = "入围时间错误";
					}
					if (railLeaveTime != null && !railLeaveTime.equals("")) {
						gpsUpdate.setRailLeaveTime(sdf.parse(railLeaveTime));
					} else {
						state = DataDic.RAIL_PARAMERROR;
						message = "出围时间错误";
					}
					if (railStopTime == null) {
						gpsUpdate.setRailStoptime(
								(gpsUpdate.getRailLeaveTime().getTime() - gpsUpdate.getRailTime().getTime()) / 1000
										/ 60);
					} else {
						Pattern pattern = Pattern.compile("[0-9]*");
						if (pattern.matcher(railStopTime).matches()) {
							gpsUpdate.setRailStoptime(Long.parseLong(railStopTime));
						} else {
							state = DataDic.RAIL_PARAMERROR;
							message = "停留时间错误";
						}
					}
					// 其他信息
					if (railType.equals(DataDic.RAILTYPE_IN)) {
						gpsUpdate.setModelCode(DataDic.FENCE_IN);
					}
					if (railType.equals(DataDic.RAILTYPE_OUT)) {
						gpsUpdate.setModelCode(DataDic.FENCE_OUT);
					}
					gpsUpdate.setPushType(DataDic.RAIL_TYPE_DX);
					gpsUpdate.setReadFlag("0");
					gpsUpdate.setUserword(username + "&&" + password);
					Orderinfo orderinfoConf = new Orderinfo();
					orderinfoConf.setSearchinfo(carNum);
					List<Orderinfo> list = orderInfoDao.findCarAndTradeList(orderinfoConf);
					//储存司机信息
					if(list != null && list.size() > 0){
						Orderinfo orderinfo = list.get(list.size()-1);
						Quoteinfo quoteinfo = orderinfo.getQuoteinfo();
						User driverConf = quoteinfo.getDriver();
						if(driverConf != null){
						User driver = systemService.getUser(driverConf.getId());
							gpsUpdate.setReceivePerson(driver.getLoginName());
							gpsUpdate.setReceivePhone(driver.getPhone());
						}else{
							state = DataDic.RAIL_PARAMERROR;
							message = "司机信息为空";
						}
					}else{
						state = DataDic.RAIL_PARAMERROR;
						message = "司机信息错误";
					}
					Date date = new Date();
					gpsUpdate.setCreateDate(date);
					gpsUpdate.setCreateBy(userCheck);
					gpsUpdate.setUpdateBy(userCheck);
					gpsUpdate.setImage("发送成功");
					gpsUpdate.setUpdateDate(date);
					gpsUpdate.setPushFlag(DataDic.RAIL_NOTPUSH);
					System.out.println(state);
					if (gpsUpdate != null && state == DataDic.RAIL_SUCCESS) {
						gpsUpdateDao.insert(gpsUpdate);
						state = DataDic.RAIL_SUCCESS;
						message = "保存成功";
					}
				} else {
					state = DataDic.RAIL_MSGERROR;
					message = "查无此人";
				}
			} else {
				state = DataDic.RAIL_USERFAILED;
				message = "校验失败";
			}
			return Tools.getMapResult(state, message, null);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			state = DataDic.RAIL_PARAMERROR;
			message = "日期格式不对";
			return Tools.getMapResult(state, message, null);
		}
	}

	
	/**
	 * 定时更新推送
	 * 
	 * @return
	 */
	@Transactional(readOnly = false)
	public void getByPushFlag() {
			List<GpsUpdate> list = gpsUpdateDao.getByPushFlag(DataDic.RAIL_NOTPUSH);
			if (list != null) {
				for (GpsUpdate gpsUpdate : list) {
					// 判断车牌存在
					int count = carService.findByCarnumber(gpsUpdate.getCarNumber());
					System.out.println(count);
					if (count != 0 && gpsUpdate.getPushFlag().equals(DataDic.RAIL_NOTPUSH)) {
						// 分割用户名和密码
						// String[] strs = gpsUpdate.getUserword().split("&&");
						// SmsClientSend.sendSms("http://118.145.30.35/sms.aspx",
						// gpsUpdate.getId(), strs[0], strs[1],
						// gpsUpdate.getReceivePhone(), gpsUpdate.getImage());
						// 判断用户存在
						User user = new User();
						user.setDelFlag("0");
						user.setLoginName(gpsUpdate.getReceivePerson());
						user = userDao.getByLoginName(user);
						System.out.println(user);
						if (user != null) {
							long count1 = orderInfoDao.findByUserid(user.getId());
							if (count1 != 0) {
								// 推送短信
								if (gpsUpdate.getRailType().equals(DataDic.RAILTYPE_IN)) {
									String[] keyword = { gpsUpdate.getReceivePerson(), gpsUpdate.getCarNumber(),
											gpsUpdate.getRailName(), gpsUpdate.getImage() };
									SmsUtil.sendSmsMesge(null, gpsUpdate.getModelCode(), gpsUpdate.getReceivePhone(),
											Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_RAILPUSH, keyword,
											null, null, true, null);
									gpsUpdate.setPushFlag(DataDic.RAIL_PUSH);
								}
								if (gpsUpdate.getRailType().equals(DataDic.RAILTYPE_OUT)) {
									String[] keyword = { gpsUpdate.getReceivePerson(), gpsUpdate.getCarNumber(),
											gpsUpdate.getRailName(), String.valueOf(gpsUpdate.getRailStoptime()),
											gpsUpdate.getImage() };
									SmsUtil.sendSmsMesge(null, gpsUpdate.getModelCode(), gpsUpdate.getReceivePhone(),
											Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_RAILPUSH, keyword,
											null, null, true, null);
									gpsUpdate.setPushFlag(DataDic.RAIL_PUSH);
								}
								gpsUpdateDao.update(gpsUpdate);
							}
						}
					}
				}
			}
	}

}
