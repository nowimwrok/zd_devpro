package com.thinkgem.jeesite.modules.wlpt.biz.creditBiz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.Ratingscale;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.StatisticsOwner;
import com.thinkgem.jeesite.modules.wlpt.entity.comment.TradeComment;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.service.comment.RatingscaleService;
import com.thinkgem.jeesite.modules.wlpt.service.comment.StatisticsOwnerService;
import com.thinkgem.jeesite.modules.wlpt.service.comment.TradeCommentService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityCarownerService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityEnterpriseService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;

/**
 * 诚信档案
 *
 * @author 王铸
 * @version 2016-09-01
 */
@Service
@Transactional(readOnly = true)
public class CreditBiz {
	
	@Autowired
	private StatisticsOwnerService statisticsOwnerService;
	@Autowired
	private RatingscaleService ratingscaleService;
	@Autowired
	private TradeCommentService tradeCommentService;
	@Autowired
	private UserCompanypictureService userCompanypictureService;
	@Autowired
	private IntegrityEnterpriseService integrityEnterpriseService;
	@Autowired
	private IntegrityCarownerService integrityCarownerService;
	
	/**
	 * 根据user ID获取statisticsOwner信息
	 * @param user
	 * @return
	 */
	public StatisticsOwner ownerBiz(User user){
		StatisticsOwner statisticsOwner=new StatisticsOwner();
		if(user!=null){
			statisticsOwner.setUser(user);
			List<StatisticsOwner> list1=statisticsOwnerService.findList(statisticsOwner);
			if(list1.size()>0){
				statisticsOwner=list1.get(0);
			}
		}
		return statisticsOwner;
	}
	
	/**
	 * 根据user ID获取ratingscale信息
	 * @param user
	 * @return
	 */
	public Ratingscale ratingscaleBiz(User user){
		Ratingscale ratingscale =new Ratingscale();
		if(user!=null){
			ratingscale.setUser(user);
			List<Ratingscale> list2= ratingscaleService.findList(ratingscale);
			if(list2.size()>0){
				ratingscale=list2.get(0);
			}
		}
		return ratingscale;
	}
	
	/**
	 * 根据user ID获取评论信息
	 * @param user
	 * @return
	 */
	public List<TradeComment> findTradeComment(User user){
		List<TradeComment> comments=new ArrayList<>();
		if(user!=null){
			comments=tradeCommentService.findByUser(user);	
		}
		return comments;
	}
	
	/**
	 *获取企业荣誉照片
	 * @param UserCompanypicture
	 * @return
	 */
	public List<Map> honorsBiz(UserCompanypicture picture){
		List<Map> honors = new ArrayList<>();
    	UserCompanypicture userCompanypicture=userCompanypictureService.findPicture(picture);
    	if(userCompanypicture.getComanyhonorimg()!=null && !userCompanypicture.getComanyhonorimg().equals("")){
    		String honorimg=userCompanypicture.getComanyhonorimg();
    		String ComanyHonorImgTitle = userCompanypicture.getComanyhonorimgtitle();// 公司荣誉展示图片
    		String img[] = honorimg.split(";");
            String title[] = ComanyHonorImgTitle != null ? ComanyHonorImgTitle.split(";") : null;
            for (int i = 0; i < img.length; i++) {
                if (!"".equals(img[i])) {
                	Map<String, Object> iPd = new HashMap<String, Object>();
                    iPd.put("ComanyHonorImg", img[i]);
                    iPd.put("ComanyHonorImgTitle", title != null && title.length >= i ? title[i] : "所获荣誉");
                    honors.add(iPd);
                }
            }
    	}
    	return honors;
	}
	
	/**
	 *获取企业资质照片
	 * @param UserCompanypicture
	 * @return
	 */
	public List<Map> enterprise(IntegrityEnterprise integrityEnterprise){
		List<Map> honors = new ArrayList<>();
		IntegrityEnterprise  enterprise= integrityEnterpriseService.findEnterprise(integrityEnterprise);
		if(enterprise==null){
			return honors;
		}
		User user=UserUtils.getUserById(enterprise.getUser().getId());
		if(!user.getUserinfo().getStatus().equals(DataDic.AUTHENSUCCES)){
			return honors;
		}
		String idcard=enterprise.getIdcard();//身份证照片
		String businesslicense=enterprise.getBusinesslicense();		// 营业执照
		String roadtransport=enterprise.getRoadtransport();		// 道路运输许可证
		String certificateproperty=enterprise.getCertificateproperty();		// 房产证图片
		String stallscorporate=enterprise.getStallscorporate();		// 档口和法人的照片
		String officespace=enterprise.getOfficespace();		// 办公场所
		String storageplace=enterprise.getStorageplace();		// 存储货物的地方
		String staffphoto=enterprise.getStaffphoto();		// 员工合照
		String bankopening=enterprise.getBankopening();		// 银行开户许可证
		String owncar=enterprise.getOwncar();		// 自有车辆证明
		String upstreamcontract=enterprise.getUpstreamcontract();		// 上游运输合同
		/*if(idcard!=null&&!idcard.equals("")){
			String[] idcards=idcard.split("\\|");
			for (int i = 0; i < idcards.length; i++) {
				if (!"".equals(idcards[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", idcards[i]);
                    iPd.put("ImgTitle", "身份证");
                    honors.add(iPd);
				}
			}
		}*/
		if(businesslicense!=null&&!businesslicense.equals("")){
			String[] businesslicenses=businesslicense.split("\\|");
			for (int i = 0; i < businesslicenses.length; i++) {
				if (!"".equals(businesslicenses[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", businesslicenses[i]);
                    iPd.put("ImgTitle", "营业执照");
                    honors.add(iPd);
				}
			}
		}
		if(roadtransport!=null&&!roadtransport.equals("")){
			String[] roadtransports=roadtransport.split("\\|");
			for (int i = 0; i < roadtransports.length; i++) {
				if (!"".equals(roadtransports[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", roadtransports[i]);
                    iPd.put("ImgTitle", "道路运输许可证");
                    honors.add(iPd);
				}
			}
		}
		/*if(certificateproperty!=null&&!certificateproperty.equals("")){
			String[] certificatepropertys=certificateproperty.split("\\|");
			for (int i = 0; i < certificatepropertys.length; i++) {
				if (!"".equals(certificatepropertys[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", certificatepropertys[i]);
                    iPd.put("ImgTitle", "房产证");
                    honors.add(iPd);
				}
			}
		}*/
		if(stallscorporate!=null&&!stallscorporate.equals("")){
			String[] stallscorporates=stallscorporate.split("\\|");
			for (int i = 0; i < stallscorporates.length; i++) {
				if (!"".equals(stallscorporates[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", stallscorporates[i]);
                    iPd.put("ImgTitle", "档口和法人的照片");
                    honors.add(iPd);
				}
			}
		}
		if(officespace!=null&&!officespace.equals("")){
			String[] officespaces=officespace.split("\\|");
			for (int i = 0; i < officespaces.length; i++) {
				if (!"".equals(officespaces[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", officespaces[i]);
                    iPd.put("ImgTitle", "办公场所");
                    honors.add(iPd);
				}
			}
		}
		if(storageplace!=null&&!storageplace.equals("")){
			String[] storageplaces=storageplace.split("\\|");
			for (int i = 0; i < storageplaces.length; i++) {
				if (!"".equals(storageplaces[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", storageplaces[i]);
                    iPd.put("ImgTitle", "仓储场所");
                    honors.add(iPd);
				}
			}
		}
		if(staffphoto!=null&&!staffphoto.equals("")){
			String[] staffphotos=staffphoto.split("\\|");
			for (int i = 0; i < staffphotos.length; i++) {
				if (!"".equals(staffphotos[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", staffphotos[i]);
                    iPd.put("ImgTitle", "员工合照");
                    honors.add(iPd);
				}
			}
		}
		/*if(bankopening!=null&&!bankopening.equals("")){
			String[] bankopenings=bankopening.split("\\|");
			for (int i = 0; i < bankopenings.length; i++) {
				if (!"".equals(bankopenings[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", bankopenings[i]);
                    iPd.put("ImgTitle", "银行开户许可证");
                    honors.add(iPd);
				}
			}
		}*/
		if(owncar!=null&&!owncar.equals("")){
			String[] owncars=owncar.split("\\|");
			for (int i = 0; i < owncars.length; i++) {
				if (!"".equals(owncars[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", owncars[i]);
                    iPd.put("ImgTitle", "自有车辆证明");
                    honors.add(iPd);
				}
			}
		}
		if(upstreamcontract!=null&&!upstreamcontract.equals("")){
			String[] upstreamcontracts=upstreamcontract.split("\\|");
			for (int i = 0; i < upstreamcontracts.length; i++) {
				if (!"".equals(upstreamcontracts[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", upstreamcontracts[i]);
                    iPd.put("ImgTitle", "上游运输合同");
                    honors.add(iPd);
				}
			}
		}
		return honors;
	}
	
	/**
	 *获取车主资质照片
	 * @param IntegrityCarowner
	 * @return
	 */
	public List<Map> carowner(IntegrityCarowner integrityCarowner){
		List<Map> honors = new ArrayList<>();
		IntegrityCarowner carowner= integrityCarownerService.findCarowner(integrityCarowner);
		if(carowner==null){
			return honors;
		}
		User user=UserUtils.getUserById(carowner.getUser().getId());
		if(!user.getUserinfo().getStatus().equals(DataDic.AUTHENSUCCES)){
			return honors;
		}
		String idcard=carowner.getIdcard();		// 身份证
		String driverlicense=carowner.getDriverlicense();		// 驾驶证
		String owncar=carowner.getOwncar();		// 自有车辆证明
		String qualifycertficate=carowner.getQualifycertficate();		// 从业资格证
		String bodywork=carowner.getBodywork();		// 车身照片
		String auditrecord=carowner.getAuditrecord();		// 年审记录
		String insurance=carowner.getInsurance();		// 保险资料
		/*if(idcard!=null&&!idcard.equals("")){
			String[] idcards=idcard.split("\\|");
			for (int i = 0; i < idcards.length; i++) {
				if (!"".equals(idcards[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", idcards[i]);
                    iPd.put("ImgTitle", "身份证");
                    honors.add(iPd);
				}
			}
		}*/
		/*if(driverlicense!=null&&!driverlicense.equals("")){
			String[] driverlicenses=driverlicense.split("\\|");
			for (int i = 0; i < driverlicenses.length; i++) {
				if (!"".equals(driverlicenses[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", driverlicenses[i]);
                    iPd.put("ImgTitle", "驾驶证");
                    honors.add(iPd);
				}
			}
		}*/
		if(owncar!=null&&!owncar.equals("")){
			String[] owncars=owncar.split("\\|");
			for (int i = 0; i < owncars.length; i++) {
				if (!"".equals(owncars[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", owncars[i]);
                    iPd.put("ImgTitle", "自有车辆证明");
                    honors.add(iPd);
				}
			}
		}
		if(qualifycertficate!=null&&!qualifycertficate.equals("")){
			String[] qualifycertficates=qualifycertficate.split("\\|");
			for (int i = 0; i < qualifycertficates.length; i++) {
				if (!"".equals(qualifycertficates[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", qualifycertficates[i]);
                    iPd.put("ImgTitle", "从业资格证");
                    honors.add(iPd);
				}
			}
		}
		if(bodywork!=null&&!bodywork.equals("")){
			String[] bodyworks=bodywork.split("\\|");
			for (int i = 0; i < bodyworks.length; i++) {
				if (!"".equals(bodyworks[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", bodyworks[i]);
                    iPd.put("ImgTitle", "车身照片");
                    honors.add(iPd);
				}
			}
		}
		if(auditrecord!=null&&!auditrecord.equals("")){
			String[] auditrecords=auditrecord.split("\\|");
			for (int i = 0; i < auditrecords.length; i++) {
				if (!"".equals(auditrecords[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", auditrecords[i]);
                    iPd.put("ImgTitle", "年审记录");
                    honors.add(iPd);
				}
			}
		}
		/*if(insurance!=null&&!insurance.equals("")){
			String[] insurances=insurance.split("\\|");
			for (int i = 0; i < insurances.length; i++) {
				if (!"".equals(insurances[i])) {
					Map<String, Object> iPd = new HashMap<String, Object>();
					iPd.put("Img", insurances[i]);
                    iPd.put("ImgTitle", "保险资料");
                    honors.add(iPd);
				}
			}
		}*/
		return honors;
	}

}
