package com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPosRecord;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * 一卡通POS机绑定接口
 *
 * @author zyj
 */
@Service
@Transactional(readOnly = true)
public class UserMetroPosBiz {
	@Autowired
	private UserMetroPosService userMetroPosService;
	
	@Autowired
	private UserMetroPosRecordService metroPosRecordService;
	
	@Autowired
	private WlptUserService wlptUserService;
	
	@Autowired
	private MetroCardBiz metroCardBiz;
	
	
	/**
	 * 一卡通POS绑定
	 *
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> bindMetroPos(UserMetroPos metroPos) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "绑定成功";

		if (metroPos.getUser()==null ||Tools.IsNullOrWhiteSpace(metroPos.getUser().getId()) || Tools.IsNullOrWhiteSpace(metroPos.getMemberName())
				|| Tools.IsNullOrWhiteSpace(metroPos.getStoreName()) || Tools.IsNullOrWhiteSpace(metroPos.getUseraccount())) {
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "信息缺失，请填写完整";
			return Tools.getMapResult(state, message, null);
		}
		User newuser = UserUtils.findUser(metroPos.getUser());
		if(newuser!=null && newuser.getRole()!=null && !DataDic.ROLE_ENTERPRISE.equals(newuser.getRole().getEnname())){
			state = DataDic.RETURN_STATUS_INFOBUG;
			message = "绑定POS机失败，只能绑定企业用户";
			return Tools.getMapResult(state, message, null);
		}
		
		UserMetroPos mPos = new UserMetroPos();
		mPos.setUseraccount(metroPos.getUseraccount());
		
		List<UserMetroPos> mposlist = findList(mPos);
		mPos = new UserMetroPos();
		if(mposlist.size()>0){
			mPos = mposlist.get(0);
		}
		//判断是否重复绑定pos机
		if ((!Tools.IsNullOrWhiteSpace(mPos.getId()) && !Tools.IsNullOrWhiteSpace(metroPos.getId())&&!mPos.getId().equals(metroPos.getId()))) {
			if(!DataDic.DEL_FLAG_DELETE.equals(mPos.getDelFlag())){
				state = DataDic.RETURN_STATUS_INFOBUG;
				message = "该POS机已经绑定";
			}
			
		}

		if (state == DataDic.RETURN_STATUS_NORMAL) {
			//判断是修改还是添加
			if (Tools.IsNullOrWhiteSpace(metroPos.getId())) {
				metroPos.setIsNewRecord(true);
				metroPos.setId(IdGen.uuid());
				metroCardBiz.addMetroPosPetro(newuser.getId(),metroPos.getUseraccount());//第一次绑定同步绑定前的消费
				recordsave(metroPos,DataDic.METRO_LOCK_RESULTSTATUS);
			}else{
				//判断绑定的用户是否之前绑定的用户
				if(mPos.getUser()!=null && !mPos.getUser().getId().equals(metroPos.getUser().getId())){
					UserMetroPos oldmPos = new UserMetroPos();
					oldmPos.setUser(mPos.getUser());
					
					List<UserMetroPos> oldmposlist = findList(oldmPos);
					//判断之前的绑定用户是否只有一条绑定记录
					if(oldmposlist.size()==1){
						User user = UserUtils.findUser(mPos.getUser());
						if(user!=null && DataDic.YES.equals(user.getIsposuser())){
							wlptUserService.updateisposuser(DataDic.NO, user.getId());//修改用户为非绑定POS机用户
						}
					}
				}
				
				//判断修改的pos机是否相等
				if(!metroPos.getUseraccount().equals(metroPos.getOlduseraccount())){
					metroCardBiz.addMetroPosPetro(newuser.getId(),metroPos.getUseraccount());//第一次绑定同步绑定前的消费
					//查询绑定数据
					UserMetroPos oldmPos = new UserMetroPos();
					oldmPos.setUseraccount(metroPos.getUseraccount());
					
					List<UserMetroPos> oldmposlist = findList(oldmPos);
					oldmPos = new UserMetroPos();
					if(oldmposlist.size()>0){
						oldmPos= oldmposlist.get(0);
					}
					//添加解绑记录
					recordsave(oldmPos,DataDic.METRO_UNLOCK_RESULTSTATUS);
				}
			}
			
			
			
			//保存pos机绑定
			save(metroPos);
			if(newuser!=null && DataDic.NO.equals(newuser.getIsposuser())){
				wlptUserService.updateisposuser(DataDic.YES, newuser.getId());//修改用户为绑定POS机用户
			}
		}
		return Tools.getMapResult(state, message, null);
	}
	
	public UserMetroPos get(String id) {
		return userMetroPosService.get(id);
	}

	/**
	 * 获取POS机信息
	 * @param userMetroPos
	 * @return
	 */
	public UserMetroPos getMetroPosInfo(UserMetroPos userMetroPos){
		return userMetroPosService.getMetroPosInfo(userMetroPos);
	}
	
	
	/**
	 * 保存记录
	 * @param userMetroPos
	 * @param type
	 */
	@Transactional(readOnly = false)
	public void recordsave(UserMetroPos userMetroPos,String type) {
		if(userMetroPos!=null){
			UserMetroPosRecord record = new UserMetroPosRecord();
			record.setUser(userMetroPos.getUser());
			record.setUseraccount(userMetroPos.getUseraccount());
			record.setType(type);
			record.setCreateDate(new Date());
			record.setUpdateDate(new Date());
			metroPosRecordService.save(record);
		}
		
	}

	public List<UserMetroPos> findList(UserMetroPos userMetroPos) {
		return userMetroPosService.findList(userMetroPos);
	}
	
	public Page<UserMetroPos> findPage(Page<UserMetroPos> page, UserMetroPos userMetroPos) {
		return userMetroPosService.findPage(page, userMetroPos);
	}
	
	@Transactional(readOnly = false)
	public void save(UserMetroPos userMetroPos) {
		userMetroPosService.save(userMetroPos);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserMetroPos userMetroPos) {
		userMetroPosService.delete(userMetroPos);
		//记录
		recordsave(userMetroPos,DataDic.METRO_UNLOCK_RESULTSTATUS);
	}
}
