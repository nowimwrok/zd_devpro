package com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.MetroCardUtil;
import com.thinkgem.jeesite.common.utils.SendMailUtil;
import com.thinkgem.jeesite.common.utils.StringUtil;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.AccountUserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardLoss;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecorditem;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPosRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardLossService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecorditemService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosService;
import com.thinkgem.jeesite.modules.wlpt.service.user.AddressService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 一卡通接口
 *
 * @author fjc
 */
@Service
@Transactional(readOnly = true)
public class MetroCardBiz {

	@Autowired
	private AddressService addressService;

	@Autowired
	private UserMetroCardService userMetroCardService;

	@Autowired
	private UserMetroCardRecordService userMetroCardRecordService;

	@Autowired
	private UserMetroCardLossService userMetroCardLossService;
	
	@Autowired
	private UserMetroCardRecorditemService userMetroCardRecorditemService;
	
	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;
	
	@Autowired
	private UserMetroPosService userMetroPosService;
	
	@Autowired
	private UserMetroPosRecordService metroPosRecordService;

	private final ReentrantLock lock1=new ReentrantLock();
	/**
	 * 获取绑定的一卡通信息 根据userid用户id
	 *
	 * @param userid
	 *            非空
	 * @return
	 */
	public UserMetroCard getUserMetroCardByUserid(String userid) {
		if (userid == null) {
			return null;
		}
		UserMetroCard userMetroCard = new UserMetroCard();
		User user = new User();
		user.setId(userid);
		userMetroCard.setUser(user);
		userMetroCard = userMetroCardService.getUserMetroCardByUserId(userMetroCard);
		return userMetroCard;
	}

	/**
	 * 一卡通审核
	 *
	 * @param userMetroCard
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> audit(UserMetroCard userMetroCard) {
		Map<String, Object> result = new HashMap<>();
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";
		String status = "";
		if (userMetroCard == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "信息缺失";
		}
		if (userMetroCard != null && userMetroCard.getStatus() == null) {
			state = DataDic.RETURN_STATUS_AUTHBUG;
			message = "信息缺失";
		}

		try {
			if (state == DataDic.RETURN_STATUS_NORMAL) {
				status = userMetroCard.getStatus();
				userMetroCard.setPassword(userMetroCard.getPassword());
				if (DataDic.METRO_STATUS_SQZ.equals(status) || DataDic.METRO_STATUS_SQBTG.equals(status)) {// 审核中或者审核不通过
					userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
					userMetroCardService.save(userMetroCard);
				} else if (DataDic.METRO_STATUS_SQTG.equals(status)) {// 申请通过
					
					UserMetroCard userMetro = userMetroCardService
							.getUserMetroCardByCardId(userMetroCard.getCardid());
					if(userMetro!=null&&!userMetro.getId().equals(userMetroCard.getId())){//新绑定卡号是否存在
						state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
						message = "该卡号已经绑定过了哦";
					}else{
						Map<String, Object> map = register(userMetroCard.getCardid(), userMetroCard.getPassword(), "VIP会员",
								userMetroCard.getUserAccount(), userMetroCard.getTrueName(), userMetroCard.getMobile(),
								userMetroCard.getIdcard(), userMetroCard.getSex(), userMetroCard.getBirth(),
								userMetroCard.getCardAddress());
						if (map != null) {//注册结果
							String reStatus = map.get("status").toString();
							if (DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)) {// 成功
								message = "成功注册一卡通账户";
								userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
								userMetroCardService.save(userMetroCard);
								User user = UserUtils.findUser(userMetroCard.getUser());
								
								//把绑卡前充值的油气同步到一卡通账号
								if(user.getUserPurse()!=null && user.getUserPurse().getPetrolbalance()>0){
									Map<String, Object> mapre=recharge(userMetroCard.getCardid(), userMetroCard.getUserAccount(), user.getUserPurse().getPetrolbalance(),0.0, user.getUserPurse().getPetrolbalance(), "一卡通充值");
								}
								
							} else {
								state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
							}
							message = map.get("message").toString();
						}
					}
					
					

				} else if (DataDic.METRO_STATUS_ZX.equals(status)) {// 锁定
					Map<String, Object> map = lockCard(userMetroCard.getCardid(), userMetroCard.getUserAccount(),
							DataDic.METRO_LOCK_RESULTSTATUS, "");
					if (map != null) {
						String reStatus = map.get("status").toString();
						if (DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)) {// 成功
							message = "成功锁定一卡通账户";
							UserMetroCard metroCard = new UserMetroCard();
							metroCard.setId(userMetroCard.getId());
							metroCard.setStatus(DataDic.METRO_STATUS_ZX);
							userMetroCardService.save(userMetroCard);// 重新更改状态
						} else {
							state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
						}
						message = map.get("message").toString();
					}
				} else if (DataDic.METRO_STATUS_NORMAL.equals(status)) {// 解锁
					// 正常使用
					Map<String, Object> map = lockCard(userMetroCard.getCardid(), userMetroCard.getUserAccount(),
							DataDic.METRO_UNLOCK_RESULTSTATUS, "");
					if (map != null) {
						String reStatus = map.get("status").toString();
						if (DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)) {// 成功
							message = "成功解锁一卡通账户";
							UserMetroCard metroCard = new UserMetroCard();
							metroCard.setId(userMetroCard.getId());
							metroCard.setStatus(DataDic.METRO_STATUS_NORMAL);
							userMetroCardService.save(userMetroCard);// 重新更改状态
						} else {
							state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
						}
						message = map.get("message").toString();
					}
				} else {
					userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
					userMetroCardService.save(userMetroCard);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
		}
		result.put("state", state);
		result.put("message", message);
		return result;
	}

	/*    *//**
			 * 充值一卡通
			 *
			 * @param user
			 * @param money
			 * @return
			 *//*
				 * @Transactional(readOnly = false) public Map<String, Object>
				 * metroCardRecharge(User user,Double money){ Map<String,
				 * Object> result = new HashMap<>(); int
				 * state=DataDic.RETURN_STATUS_NORMAL; String message="保存成功";
				 * try { User users=UserUtils.findUser(user); UserMetroCard
				 * userMetroCard= getUserMetroCardByUserid(users.getId());
				 * if(users.getId()==null){ state=
				 * DataDic.RETURN_STATUS_INFOBUG; message="登陆失效,请重新登陆"; }
				 * if(userMetroCard==null){ state=
				 * DataDic.RETURN_STATUS_INFOBUG; message="请先申请一卡通账户"; }else
				 * if(userMetroCard.getCardid()==null){ state=
				 * DataDic.RETURN_STATUS_INFOBUG; message="请先绑定一卡通账户"; }else
				 * if(userMetroCard.getUserAccount()==null){ state=
				 * DataDic.RETURN_STATUS_INFOBUG; message="一卡通账户信息缺失"; }
				 * 
				 * if(state==DataDic.RETURN_STATUS_NORMAL){ Map<String, Object>
				 * map=recharge(userMetroCard.getCardid(),
				 * userMetroCard.getUserAccount(), money,0.0, money, "一卡通充值");
				 * if(map!=null){ String reStatus=map.get("status").toString();
				 * if(DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus
				 * )){//充值成功 state=DataDic.RETURN_STATUS_NORMAL; }else{
				 * state=DataDic.RETURN_STATUS_AUTHBUG;//充值失败 }
				 * message=map.get("message").toString(); } }
				 * 
				 * } catch (Exception e) { // TODO: handle exception
				 * e.printStackTrace(); state=DataDic.RETURN_STATUS_AUTHBUG;//失败
				 * } result.put("state", state); result.put("message", message);
				 * return result; }
				 */

	/**
	 * 申请一卡通
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> applicationMetroCard(Address address) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "申请成功";

		if (Tools.IsNullOrWhiteSpace(address.getCity()) || Tools.IsNullOrWhiteSpace(address.getProvince())
				|| Tools.IsNullOrWhiteSpace(address.getDistrict()) || Tools.IsNullOrWhiteSpace(address.getAddress())
				|| Tools.IsNullOrWhiteSpace(address.getLinkman()) || Tools.IsNullOrWhiteSpace(address.getLinkmobile())
				|| Tools.IsNullOrWhiteSpace(address.getPostcode())) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "信息缺失，请填写完整";
		}
		UserMetroCard userMetroCard = new UserMetroCard();
		userMetroCard.setUser(UserUtils.getUser());
		UserMetroCard metroCard = userMetroCardService.get(userMetroCard);
		if (metroCard != null && (DataDic.METRO_STATUS_SQTG.equals(metroCard.getStatus())
				|| DataDic.METRO_STATUS_SQZ.equals(metroCard.getStatus()))) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "已经申请过";
		}

		if (state == DataDic.RETURN_STATUS_NORMAL) {
			if (Tools.IsNullOrWhiteSpace(address.getId())) {
				address.setUser(UserUtils.getUser()); // 保存 申请地址
				address.setIsNewRecord(true);
				address.setType(DataDic.ADDRESS_TYPE_YKTSH);
				address.setDelFlag(DataDic.DEL_FLAG_NORMEL);
				address.setId(IdGen.uuid());
				addressService.save(address);

				if (metroCard == null) {
					userMetroCard.setUser(UserUtils.getUser()); // 保存到用户一卡通表
					userMetroCard.setStatus(DataDic.METRO_STATUS_SQZ);
					userMetroCard.setIsNewRecord(true);
					userMetroCard.setId(IdGen.uuid());
					userMetroCard.setAddress(address);
					userMetroCardService.save(userMetroCard);
				}
                String[] keyword = {address.getUser().getLoginName(),address.getUser().getPhone()};

				SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_Apply, Const.SMSFUN_APPLY_PHONE,
						Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, keyword, null, null, true,SmsConfig.smsUserapply);
			}
		}
		return Tools.getMapResult(state, message, null);
	}

	/**
	 * 注册会员 接口
	 *
	 * @param cardId
	 *            卡号 非空
	 * @param password
	 *            密码 非空
	 * @param memberGroupName
	 *            会员级别 非空
	 * @param userAccount
	 *            工号 非空
	 * @param trueName
	 *            姓名
	 * @param mobile
	 *            手机
	 * @param idCard
	 *            身份证号码
	 * @param sex
	 *            性别 1男 2女
	 * @param birth
	 *            生日 2000-01-01
	 * @param address
	 *            地址
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> register(String cardId, String password, String memberGroupName, String userAccount,
			String trueName, String mobile, String idCard, String sex, String birth, String address) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("cardId", cardId);
		data.put("password", password);
		data.put("memberGroupName", memberGroupName);
		data.put("trueName", trueName);
		data.put("userAccount", userAccount);
		data.put("sex", sex);
		data.put("birth", birth);
		data.put("mobile", mobile);
		data.put("idCard", idCard);
		data.put("address", address);
		try {
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Add_Member", data));
			int status = jsonObject.getIntValue("status");
			String message = jsonObject.getString("message");

			result.put("status", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 充值 接口
	 *
	 * @param cardId
	 *            卡号 非空
	 * @param userAccount
	 *            工号 非空
	 * @param value
	 *            充值金额 非空
	 * @param valuePlus
	 *            赠送金额
	 * @param paidMoney
	 *            实付金额
	 * @param meno
	 *            充值备注
	 * @return
	 */
	public Map<String, Object> recharge(String cardId, String userAccount, Double value, Double valuePlus,
			Double paidMoney, String meno) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("cardId", cardId);
		data.put("userAccount", userAccount);
		data.put("value", value);
		data.put("valuePlus", valuePlus);
		data.put("paidMoney", paidMoney);
		data.put("meno", meno);
		try {
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Add_Value", data));
			int status = jsonObject.getIntValue("status");
			String message = jsonObject.getString("message");

			result.put("status", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 手动同步 消费记录
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public String getConsumption(String billNumber) {
		lock1.lock();
		try{
		Map<String, Object> testMap = new HashMap<>();
		Map<String, Object> detailMap = new HashMap<>();
		UserMetroCardRecord cardRecord = new UserMetroCardRecord();
		cardRecord.setBillnumber(billNumber);
		List<UserMetroCardRecord> varList = userMetroCardRecordService.findList(cardRecord);
		if (varList.size() > 0) {
			return "已存在";
		}
		
		testMap.put("where", "1=1 and BillNumber = '" + billNumber + "'");
		testMap.put("pageIndex", 0);
		testMap.put("pageSize", 1);
		testMap.put("userAccount", "10000");
		
		MetroCardUtil metroCardUtil = new MetroCardUtil();
			
		JSONObject jsonObjectAll = JSONObject
				.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNotePagedV2", testMap));
		if (jsonObjectAll != null) {
			JSONArray array = jsonObjectAll.getJSONArray("data");
			if (array != null) {
				for (int i = 0; i < array.size(); i++) {
					JSONObject object = array.getJSONObject(i);
					UserMetroCard userMetroCard = userMetroCardService
							.getUserMetroCardByCardId(object.getString("CardId"));
					Date consumeDate = new Date();
					if (userMetroCard != null) {
						String operateTime = object.getString("OperateTime");
						if (!Tools.IsNullOrWhiteSpace(operateTime)) {
							consumeDate = DateUtil.fomatTime(operateTime);
						}
						
						UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
						userMetroCardRecord.setGuid(object.getString("Guid"));
						List<UserMetroCardRecord> varLists = userMetroCardRecordService.findList(userMetroCardRecord);
						if (varLists.size() > 0) {
							continue;
						}
						consumeRecodBiz.consumePetroinfo(userMetroCard.getUser().getId(),
								object.getDouble("TotalPaid"), object.getString("Guid"), consumeDate); // 保存记录
						
						UserMetroPos mPos = new UserMetroPos();
						mPos.setUseraccount(object.getString("UserAccount"));
						
						List<UserMetroPos> mposlist = userMetroPosService.findList(mPos);
						mPos = new UserMetroPos();
						if(mposlist.size()>0){
							mPos = mposlist.get(0);
							consumeRecodBiz.receivedPetroinfo(mPos.getUser().getId(),object.getDouble("TotalPaid")); // 保存消费记录
						}
						
						UpdateCardRecord(userMetroCard.getUser().getId(), object.getString("CardId"),
								object.getString("Guid"), object.getString("IsUndo"),
								object.getString("BillNumber"), object.getString("Meno"),
								object.getString("TrueName"), object.getDouble("TotalMoney"),
								object.getDouble("TotalPaid"), object.getDouble("PaidMoney"),
								object.getDouble("PaidValue"), object.getDouble("PaidPoint"),
								object.getDouble("Point"), object.getString("StoreName"),
								object.getString("UserAccount"), consumeDate,"1","0");// 保存到一卡通的消费记录明细
						
						
						//获取该消费记录的明细
						detailMap.put("guid", object.getString("Guid"));
						//detailMap.put("userAccount", "10000");
						
						JSONObject jsonObjectdetail = JSONObject
								.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNoteItemPagedV2", detailMap));
						if (jsonObjectdetail != null) {
							JSONArray arraydetail = jsonObjectdetail.getJSONArray("data");
							if (arraydetail != null&&arraydetail.size()>0) {
								for (int j = 0; j < arraydetail.size(); j++) {
									JSONObject objectdetail = arraydetail.getJSONObject(j);
									if(objectdetail!=null){
										//保存明细
										UpdateCardRecordItem(userMetroCard.getUser(),object.getString("Guid"),objectdetail,consumeDate);
										
									}
									
								}
							}
							
						}
					}
				}
			}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
    		lock1.unlock();
    	}
		return "同步成功";
	}
	
	
	/**
	 * 同步 消费记录
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> syncConsumption() {
		lock1.lock();
		try{
		Map<String, Object> testMap = new HashMap<>();
		Map<String, Object> detailMap = new HashMap<>();
		Consumerecod newCodeBiz = consumeRecodBiz.getNewCodeBiz(null, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME,
				DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL);
		if (newCodeBiz != null) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String dateString = formatter.format(newCodeBiz.getCreateDate());
			testMap.put("where", "1=1 and operateTime >= '" + dateString + "'");
		}
		testMap.put("pageIndex", 0);
		testMap.put("pageSize", 1);
		testMap.put("userAccount", "10000");
		
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject
					.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNotePagedV2", testMap));
			if (jsonObject != null) {
				int status = jsonObject.getIntValue("status");
				int total = jsonObject.getIntValue("total");
				testMap.put("pageSize", total); // 查询所有
				if (status == 0) {
					JSONObject jsonObjectAll = JSONObject
							.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNotePagedV2", testMap));
					if (jsonObjectAll != null) {
						JSONArray array = jsonObjectAll.getJSONArray("data");
						if (array != null) {
							for (int i = 0; i < array.size(); i++) {
								JSONObject object = array.getJSONObject(i);
								UserMetroCard userMetroCard = userMetroCardService
										.getUserMetroCardByCardId(object.getString("CardId"));
								Date consumeDate = new Date();
								if (userMetroCard != null) {
									String operateTime = object.getString("OperateTime");
									if (!Tools.IsNullOrWhiteSpace(operateTime)) {
										consumeDate = DateUtil.fomatTime(operateTime);
									}
									
									UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
									userMetroCardRecord.setGuid(object.getString("Guid"));
									List<UserMetroCardRecord> varLists = userMetroCardRecordService.findList(userMetroCardRecord);
									if (varLists.size() > 0) {
										continue;
									}
									consumeRecodBiz.consumePetroinfo(userMetroCard.getUser().getId(),
											object.getDouble("TotalPaid"), object.getString("Guid"), consumeDate); // 保存消费记录
									
									UserMetroPos mPos = new UserMetroPos();
									mPos.setUseraccount(object.getString("UserAccount"));
									
									List<UserMetroPos> mposlist = userMetroPosService.findList(mPos);
									mPos = new UserMetroPos();
									if(mposlist.size()>0){
										mPos = mposlist.get(0);
										consumeRecodBiz.receivedPetroinfo(mPos.getUser().getId(),object.getDouble("TotalPaid")); // 保存消费记录
									}
									
									UpdateCardRecord(userMetroCard.getUser().getId(), object.getString("CardId"),
											object.getString("Guid"), object.getString("IsUndo"),
											object.getString("BillNumber"), object.getString("Meno"),
											object.getString("TrueName"), object.getDouble("TotalMoney"),
											object.getDouble("TotalPaid"), object.getDouble("PaidMoney"),
											object.getDouble("PaidValue"), object.getDouble("PaidPoint"),
											object.getDouble("Point"), object.getString("StoreName"),
											object.getString("UserAccount"), consumeDate,"1","0");// 保存到一卡通的消费记录明细
									
									
									//获取该消费记录的明细
									detailMap.put("guid", object.getString("Guid"));
									//detailMap.put("userAccount", "10000");
									
									JSONObject jsonObjectdetail = JSONObject
											.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNoteItemPagedV2", detailMap));
									if (jsonObjectdetail != null) {
										JSONArray arraydetail = jsonObjectdetail.getJSONArray("data");
										if (arraydetail != null&&arraydetail.size()>0) {
											for (int j = 0; j < arraydetail.size(); j++) {
												JSONObject objectdetail = arraydetail.getJSONObject(j);
												if(objectdetail!=null){
													//保存明细
													UpdateCardRecordItem(userMetroCard.getUser(),object.getString("Guid"),objectdetail,consumeDate);
													
												}
												
											}
										}
										
									}
								}
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
    		lock1.unlock();
    	}
		return null;
	}

	
	/**
	 * 同步 pos充值记录
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> syncAllAddValue() {
		lock1.lock();
		try{
		Map<String, Object> testMap = new HashMap<>();
		Map<String, Object> detailMap = new HashMap<>();
		Consumerecod newCodeBiz = consumeRecodBiz.getNewCodeBiz(null, DataDic.CONSUMERECODE_TYPE_PETROLRECHARGEPOS,
				DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL);
		if (newCodeBiz != null) {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String dateString = formatter.format(newCodeBiz.getCreateDate());
			testMap.put("where", "1=1 and Type='1' and userAccount<>'10000' and Way='2' and operateTime >= '"+dateString+"'");
		}else{
			testMap.put("where", "1=1 and Type='1' and userAccount<>'10000' and Way='2' ");
		}
		testMap.put("pageIndex", 0);
		testMap.put("pageSize", 1);
		testMap.put("userAccount", "10000");
		
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject
					.parseObject(metroCardUtil.callHttpPost("Get_AllValueNotePagedV2", testMap));
			if (jsonObject != null) {
				int status = jsonObject.getIntValue("status");
				int total = jsonObject.getIntValue("total");
				if(total>=200){
					total = 199;
				}
				testMap.put("pageSize", total); // 查询所有
				if (status == 0) {
					JSONObject jsonObjectAll = JSONObject
							.parseObject(metroCardUtil.callHttpPost("Get_AllValueNotePagedV2", testMap));
					if (jsonObjectAll != null) {
						JSONArray array = jsonObjectAll.getJSONArray("data");
						if (array != null) {
							for (int i = 0; i < array.size(); i++) {
								JSONObject object = array.getJSONObject(i);
								UserMetroCard userMetroCard = userMetroCardService
										.getUserMetroCardByCardId(object.getString("CardId"));
								Date consumeDate = new Date();
								if (userMetroCard != null) {
									String operateTime = object.getString("OperateTime");
									if (!Tools.IsNullOrWhiteSpace(operateTime)) {
										consumeDate = DateUtil.fomatTime(operateTime);
									}
									
									UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
									userMetroCardRecord.setBillnumber(object.getString("BillNumber"));
									List<UserMetroCardRecord> varLists = userMetroCardRecordService.findList(userMetroCardRecord);
									if (varLists.size() > 0) {
										continue;
									}
									consumeRecodBiz.addPOSPetroInfo(userMetroCard.getUser().getId(),
											object.getDouble("PaidMoney"), object.getString("BillNumber"), consumeDate,object.getString("userAccount")); // 保存充值记录
									
									UpdateCardRecord(userMetroCard.getUser().getId(), object.getString("CardId"),
											object.getString("BillNumber"), object.getString("IsUndo"),
											object.getString("BillNumber"), object.getString("Meno"),
											object.getString("TrueName"), object.getDouble("PaidMoney"),
											object.getDouble("PaidMoney"), object.getDouble("PaidMoney"),
											0.0, 0.0,
											0.0, object.getString("StoreName"),
											object.getString("UserAccount"), consumeDate,"2","1");// 保存到一卡通的消费记录明细
									
								}
							}
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally{
    		lock1.unlock();
    	}
		return null;
	}
	
	
	
	/**
	 * 修改一卡通密码 接口
	 *
	 * @param cardId
	 *            卡号 非空
	 * @param password
	 *            新密码 非空
	 * @param userAccount
	 *            工号 非空
	 * @param oldPassword
	 *            旧密码 非空
	 * @return 0成功 -1失败
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> updatePassWord(String cardId, String userAccount, String password, String oldPassword) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("cardId", cardId);
		data.put("userAccount", userAccount);
		data.put("password", oldPassword);
		data.put("newPassword", password);
		try {
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Update_MemberPassword", data));
			int status = jsonObject.getIntValue("status");
			String message = jsonObject.getString("message");

			result.put("status", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 修改一卡通密码
	 *
	 * @param cardId
	 *            卡号
	 * @param password
	 *            密码
	 * @return 0成功 -1失败
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> updateCardPassWord(String userid, String cardId, String password, String oldpassword) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		UserMetroCard userMetroCard = new UserMetroCard();
		int status = DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";
		try {

			if (userid == null || cardId == null || password == null || oldpassword == null) {
				status = DataDic.RETURN_STATUS_INFOBUG;
				message = "信息缺失";
			}
			if (status == DataDic.RETURN_STATUS_NORMAL) {
				UserMetroCard newMetroCard = getUserMetroCardByUserid(userid);

				data = updatePassWord(cardId, newMetroCard.getUserAccount(), password, oldpassword);
				status = Integer.valueOf(data.get("status").toString());
				message = data.get("message").toString();
				if (DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(String.valueOf(status))) {// 修改密码成功
					userMetroCard.setId(newMetroCard.getId());
					userMetroCard.setPassword(SystemService.entryptPassword(password));
					userMetroCardService.save(userMetroCard);// 更新本地密码
				}
			}

			result.put("state", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 重置一卡通密码 接口
	 *
	 * @param cardId
	 *            卡号 非空
	 * @param userAccount
	 *            工号 非空
	 * @param phone
	 *            手机号 非空
	 * @return 0成功 -1失败
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> resavePassWord(String cardId, String userAccount, String phone) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("cardId", cardId);
		data.put("userAccount", userAccount);
		data.put("mobile", phone);
		try {
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("ReSetMemberPassword", data));
			int status = jsonObject.getIntValue("status");
			String message = jsonObject.getString("message");

			result.put("status", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 重置一卡通密码
	 *
	 * @param userid
	 *            用户id
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> resavePassWordCard(String userid) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		int status = DataDic.RETURN_STATUS_NORMAL;
		String message = "操作成功";
		try {
			if (userid == null) {
				status = DataDic.RETURN_STATUS_INFOBUG;
				message = "信息缺失";
			}

			if (status == DataDic.RETURN_STATUS_NORMAL) {
				UserMetroCard newMetroCard = getUserMetroCardByUserid(userid);
				if (newMetroCard != null && !Tools.IsNullOrWhiteSpace(newMetroCard.getId())) {
					data = resavePassWord(newMetroCard.getCardid(), newMetroCard.getUserAccount(),
							newMetroCard.getMobile());
					status = Integer.valueOf(data.get("status").toString());
					message = data.get("message").toString();
				} else {
					status = DataDic.RETURN_STATUS_INFOBUG;
					message = "一卡通账户信息不存在";
				}

			}
			result.put("state", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 锁定 解锁 一卡通 接口
	 *
	 * @param cardId
	 *            卡号 非空
	 * @param userAccount
	 *            工号 非空
	 * @param type
	 *            1锁定 2解锁 非空
	 * @param reason
	 *            原因
	 * @return 0成功 -1失败
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> lockCard(String cardId, String userAccount, String type, String reason) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> data = new HashMap<>();
		data.put("cardId", cardId);
		data.put("userAccount", userAccount);
		data.put("type", type);
		data.put("reason", reason);
		try {
			MetroCardUtil metroCardUtil = new MetroCardUtil();
			JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Lock_Member", data));
			int status = jsonObject.getIntValue("status");
			String message = jsonObject.getString("message");

			result.put("status", status);
			result.put("message", message);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 插入一卡通交易明细
	 *
	 * @param user_id
	 *            归属用户
	 * @param guid
	 *            一卡通的唯一标识
	 * @param isUndo
	 *            是否撤销
	 * @param billNumber
	 *            单据号
	 * @param meno
	 *            备注
	 * @param trueName
	 *            会员姓名
	 * @param totalmoney
	 *            应付金额
	 * @param totalpaid
	 *            实付金额
	 * @param paidmoney
	 *            现金支付
	 * @param paidvalue
	 *            储值支付
	 * @param paidpoint
	 *            积分支付
	 * @param point
	 *            获得积分
	 * @param storename
	 *            操作店面
	 * @param useraccount
	 *            操作工号
	 * @param operatetime
	 *            操作时间
	 * @return
	 */
	@Transactional(readOnly = false)
	public int UpdateCardRecord(String user_id, String cardid, String guid, String isUndo, String billNumber,
			String meno, String trueName, Double totalmoney, Double totalpaid, Double paidmoney, Double paidvalue,
			Double paidpoint, Double point, String storename, String useraccount, Date operatetime,String way,String type) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		User curUser = new User();
		curUser.setId(user_id);
		curUser = UserUtils.findUser(curUser);
		UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
		userMetroCardRecord.setGuid(guid);
		List<UserMetroCardRecord> varList = userMetroCardRecordService.findList(userMetroCardRecord);
		if (varList.size() > 0) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		
		UserMetroCardRecord cardRecord = new UserMetroCardRecord();
		cardRecord.setGuid(guid);
		cardRecord.setIsundo(isUndo);
		cardRecord.setBillnumber(billNumber);
		cardRecord.setMeno(meno);
		cardRecord.setTruename(trueName);
		cardRecord.setTotalmoney(totalmoney.toString());
		cardRecord.setTotalpaid(totalpaid.toString());
		cardRecord.setPaidmoney(paidmoney.toString());
		cardRecord.setPaidvalue(paidvalue.toString());
		cardRecord.setPaidpoint(paidpoint.toString());
		cardRecord.setStorename(storename);
		cardRecord.setUseraccount(useraccount);
		cardRecord.setOperatetime(operatetime);
		cardRecord.setCreateDate(operatetime);
		cardRecord.setUpdateDate(operatetime);
		cardRecord.setUser(curUser);
		cardRecord.setCardid(cardid);
		cardRecord.setWay(way);
		cardRecord.setType(type);
		userMetroCardRecordService.save(cardRecord);
		return result;
	}
	/**
	 * 插入一卡通消费记录明细
	 * @param user
	 * @param recordguid
	 * @param object
	 * @return
	 */
	@Transactional(readOnly = false)
	public int UpdateCardRecordItem(User user, String recordguid, JSONObject object, Date operatetime) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		
		UserMetroCardRecorditem item = new UserMetroCardRecorditem();
		item.setGuid(object.getString("Guid"));
		List<UserMetroCardRecorditem> varList = userMetroCardRecorditemService.findList(item);
		if (varList.size() > 0) {
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		
		UserMetroCardRecorditem cardRecorditem = new UserMetroCardRecorditem();
		UserMetroCardRecord cardRecord = new UserMetroCardRecord();
		cardRecord.setGuid(recordguid);
		cardRecorditem.setRecord(cardRecord); 
		cardRecorditem.setUser(user);
		cardRecorditem.setGuid(object.getString("Guid").toString());
		cardRecorditem.setGoodsitemguid(object.getString("GoodsItemGuid").toString());
		cardRecorditem.setBarcode(object.getString("Barcode").toString());
		cardRecorditem.setGooditemname(object.getString("GoodItemName").toString());
		cardRecorditem.setTotalmoney(!StringUtils.isNoneBlank(object.getDouble("TotalMoney").toString())?"0":object.getDouble("TotalMoney").toString());
		cardRecorditem.setNumber(!StringUtils.isNoneBlank(object.getDouble("Number").toString())?"0":object.getDouble("Number").toString());
		cardRecorditem.setOldprice(!StringUtils.isNoneBlank(object.getDouble("OldPrice").toString())?"0":object.getDouble("OldPrice").toString());
		cardRecorditem.setPaidmoney(!StringUtils.isNoneBlank(object.getDouble("PaidMoney").toString())?"0":object.getDouble("PaidMoney").toString());
		cardRecorditem.setDiscount(object.getString("Discount").toString());
		cardRecorditem.setPoint(object.getString("Point").toString());
		cardRecorditem.setMeno(object.getString("Meno").toString());
		cardRecorditem.setCreateDate(operatetime);
		cardRecorditem.setUpdateDate(operatetime);
		
		userMetroCardRecorditemService.save(cardRecorditem);
		return result;
	}
	
	/**
	 * 同步一卡通pos机的油气
	 * @param useraccount
	 * @param totalmoney
	 * @return
	 */
	@Transactional(readOnly = false)
	public int UpdateMetroPosPetro(String useraccount,Double totalmoney) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		
		UserMetroPos mPos = new UserMetroPos();
		mPos.setUseraccount(useraccount);
		
		List<UserMetroPos> mposlist = userMetroPosService.findList(mPos);
		mPos = new UserMetroPos();
		if(mposlist.size()>0){
			mPos = mposlist.get(0);
		}else{
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		consumeRecodBiz.receivedPetroBiz(mPos.getUser().getId(),totalmoney); // 保存消费记录
		
		return result;
	}
	
	/**
	 * 同步一卡通pos机的油气
	 * @param userid
	 * @param useraccount
	 * @return
	 */
	@Transactional(readOnly = false)
	public int addMetroPosPetro(String userid ,String useraccount) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		
		AccountUserMetroCard userMetroCard = new AccountUserMetroCard();
		
		UserMetroPosRecord record = new UserMetroPosRecord();
		record.setUseraccount(useraccount);
		record.setType(DataDic.METRO_UNLOCK_RESULTSTATUS);
		List<UserMetroPosRecord> recordlist = metroPosRecordService.findList(record);
		if(recordlist.size()>0){
			record = recordlist.get(0);
			userMetroCard.setBeginOperateDate(record.getCreateDate());
		}
		
		userMetroCard.setUseraccount(useraccount);
		List<AccountUserMetroCard> varList = userMetroCardRecordService.findPOSAccountList(userMetroCard);
		if (varList.size() > 0) {
			userMetroCard =varList.get(0);
		}else{
			return DataDic.RETURN_STATUS_INFOBUG;
		}
		if(!Tools.IsNullOrWhiteSpace(userMetroCard.getTotalpaidAccount())&& Double.parseDouble(userMetroCard.getTotalpaidAccount())>0){
			
			consumeRecodBiz.receivedPetroBiz(userid,Double.parseDouble(userMetroCard.getTotalpaidAccount())); // 保存消费记录
		}
		
		
		return result;
	}
	
	/**
	 * 保存挂失一卡通记录
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> lossMetroCardSave(Address address) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "挂失成功";

		if (Tools.IsNullOrWhiteSpace(address.getCity()) || Tools.IsNullOrWhiteSpace(address.getProvince())
				|| Tools.IsNullOrWhiteSpace(address.getDistrict()) || Tools.IsNullOrWhiteSpace(address.getAddress())
				|| Tools.IsNullOrWhiteSpace(address.getLinkman()) || Tools.IsNullOrWhiteSpace(address.getLinkmobile())
				|| Tools.IsNullOrWhiteSpace(address.getPostcode())) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "信息缺失，请填写完整";
		}
		UserMetroCardLoss userMetroCardLoss = new UserMetroCardLoss();
		userMetroCardLoss.setUser(UserUtils.getUser());
		UserMetroCardLoss metroCardLoss = userMetroCardLossService.getByUserMetroCardLoss(userMetroCardLoss);
		if (metroCardLoss != null && (DataDic.METRO_LOSS_STATUS_APPLY.equals(metroCardLoss.getStatus())
				|| DataDic.METRO_LOSS_STATUS_DISPOSE.equals(metroCardLoss.getStatus()))) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "您已申请挂失";
		}
		UserMetroCard userMetroCard = getUserMetroCardByUserid(UserUtils.getUser().getId());
		if (userMetroCard == null) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "一卡通信息已注销";
		}
		if (state == DataDic.RETURN_STATUS_NORMAL) {

			if (Tools.IsNullOrWhiteSpace(address.getId())) {
				Map<String, Object> map = lockCard(userMetroCard.getCardid(), userMetroCard.getUserAccount(), DataDic.METRO_LOCK_RESULTSTATUS, "");//锁定
				if (map != null) {
					String reStatus = map.get("status").toString();
					if (DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)) {// 成功
						message = "成功锁定一卡通账户";
						UserMetroCard metroCard = new UserMetroCard();
						metroCard.setId(userMetroCard.getId());
						metroCard.setStatus(DataDic.METRO_STATUS_ZX);
						userMetroCardService.save(userMetroCard);// 重新更改状态
					} else {
						state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
					}
					message = map.get("message").toString();
				}
				if (state == DataDic.RETURN_STATUS_NORMAL) {
					address.setUser(UserUtils.getUser()); // 保存 申请地址
					address.setIsNewRecord(true);
					address.setType(DataDic.ADDRESS_TYPE_YKTSH);
					address.setDelFlag(DataDic.DEL_FLAG_NORMEL);
					address.setId(IdGen.uuid());
					addressService.save(address);

					userMetroCardLoss.setCardid(userMetroCard.getCardid());
					userMetroCardLoss.setTruename(userMetroCard.getTrueName());
					userMetroCardLoss.setUseraccount(userMetroCard.getUserAccount());
					userMetroCardLoss.setMobile(userMetroCard.getMobile());

					userMetroCardLoss.setUser(UserUtils.getUser()); // 保存到用户一卡通挂失表
					userMetroCardLoss.setStatus(DataDic.METRO_LOSS_STATUS_APPLY);
					userMetroCardLoss.setIsNewRecord(true);
					userMetroCardLoss.setId(IdGen.uuid());
					userMetroCardLoss.setAddress(address);
					userMetroCardLossService.save(userMetroCardLoss);

					String[] keyword = {DataDic.METRO_LOSS_MONEY};
					SendMailUtil.sendCommonMail(DataDic.METRO_CARD_APPLY_EMAIL, DataDic.METRO_CARD_APPLY_EMAILTITLE,
							DataDic.METRO_CARD_APPLY_EMAILBODY);// 邮件
					SmsUtil.sendSmsMesge(null, "lossCard", UserUtils.getUser().getPhone(),
							Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true, SmsConfig.smsValidateCode);// 短信
				}
			}
		}
		return Tools.getMapResult(state, message, null);
	}

	/**
	 * 变更一卡通卡号记录
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> updateCard(UserMetroCard userMetroCard) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";

		UserMetroCard userMetro = userMetroCardService
				.getUserMetroCardByCardId(userMetroCard.getCardid());
		if(userMetro!=null){//新绑定卡号是否存在
			state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
			message = "该卡号已经绑定过了哦";
			return Tools.getMapResult(state, message, null);
		}
		
		//当次挂失记录
		UserMetroCardLoss userMetroCardLoss = new UserMetroCardLoss();
		userMetroCardLoss.setUser(userMetroCard.getUser());
		userMetroCardLoss.setCardid(userMetroCard.getOldcardid());
		//查出当次该卡号挂失记录
		UserMetroCardLoss metroCardLoss = userMetroCardLossService.getByUserMetroCardLoss(userMetroCardLoss);
		if(metroCardLoss==null){
			state = DataDic.RETURN_STATUS_AUTHBUG;// 失败
			message = "该卡号没有挂失记录哦";
			return Tools.getMapResult(state, message, null);
		}
		
		UserMetroCard meUserMetroCard = userMetroCardService.get(userMetroCard.getId());// 查询出存在的信息
		int result= DataDic.RETURN_STATUS_NORMAL;
		if(userMetroCard.getIspayment().equals(DataDic.YES)){
			result= consumeRecodBiz.metroCradLossPayRecodeBiz(meUserMetroCard.getUser());//缴费
		}
		
		if(result==DataDic.RETURN_STATUS_NORMAL){//缴费成功
			//更新卡号
			UserMetroCard metroCard = new UserMetroCard();
			metroCard.setId(userMetroCard.getId());
			metroCard.setCardid(userMetroCard.getCardid());
			metroCard.setStatus(DataDic.METRO_STATUS_NORMAL);// 正常使用
			userMetroCardService.save(metroCard);// 更新卡号为新卡号
			
			//更新挂失记录保存该记录的新卡号
			UserMetroCardLoss metrocardLoss = new UserMetroCardLoss();
			metrocardLoss.setId(metroCardLoss.getId());
			metrocardLoss.setIsNewRecord(false);
			metrocardLoss.setNewcardid(userMetroCard.getIdcard());
			metrocardLoss.setIspayment(userMetroCard.getIspayment());
			metrocardLoss.setUpdateDate(new Date());
			userMetroCardLossService.save(metrocardLoss);
			
			//更新一卡通消费记录
			UserMetroCardRecord userMetroCardRecord = new UserMetroCardRecord();
			userMetroCardRecord.setCardid(userMetroCard.getCardid());
			userMetroCardRecord.setSearchinfo(meUserMetroCard.getCardid());
			userMetroCardRecordService.updateCarId(userMetroCardRecord);// 更新原来的消费记录卡号为新卡号
			if(userMetroCard.getIspayment().equals(DataDic.YES)){
				String[] keyword = { DataDic.METRO_LOSS_MONEY };
				SmsUtil.sendSmsMesge(null, "lossCardDeduction", meUserMetroCard.getMobile(),
						Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, null, null, true,SmsConfig.smsValidateCode);// 短信
			}
		}else if(result==DataDic.RETURN_STATUS_MONEYBUG){
			state = DataDic.RETURN_STATUS_MONEYBUG;
			message = "账户余额不足,扣费失败";
		}else{
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "信息缺失";
		}


		return Tools.getMapResult(state, message, null);
	}

	/**
	 * 一卡通消费记录明细列表
	 * @param page
	 * @param userMetroCardRecord
	 * @return
	 */
	public Page<UserMetroCardRecord> finditemList(Page<UserMetroCardRecord> page, UserMetroCardRecord userMetroCardRecord) {
		return userMetroCardRecordService.finditemList(page, userMetroCardRecord);
	}
}
