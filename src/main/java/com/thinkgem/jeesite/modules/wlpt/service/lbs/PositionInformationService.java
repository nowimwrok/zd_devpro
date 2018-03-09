package com.thinkgem.jeesite.modules.wlpt.service.lbs;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.trafficUtils.entity.ParkingInformation;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleEvent;
import com.thinkgem.jeesite.common.trafficUtils.entity.VehicleInformation;
import com.thinkgem.jeesite.common.trafficUtils.geographicInversion.InverseQuery;
import com.thinkgem.jeesite.common.trafficUtils.locationInformation.VHisTrack;
import com.thinkgem.jeesite.common.trafficUtils.locationInformation.VLastLocation;
import com.thinkgem.jeesite.common.trafficUtils.statisticalAnalysis.VehicleQuery;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;

/**
 * 车辆位置信息查询Service
 * 
 * @author Shinelon
 *
 */
@Service
@Transactional(readOnly = true)
public class PositionInformationService {
	
	@Autowired
	private InterfaceLogBiz interfacelogbiz;
	// 通过车牌号查找
	@Transactional(readOnly = false)
	public VehicleInformation getLastLocation(String vclN,String timeNearby) {
		VehicleInformation vpInformation = new VehicleInformation();
		VLastLocation vLastLocation = new VLastLocation();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			vpInformation = vLastLocation.vLastLocation(token,vclN, timeNearby);
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return vpInformation;

	}

	// 通过车架号查找
	@Transactional(readOnly = false)
	public VehicleInformation getLastLocationVin(String vin,String timeNearby) {
		VehicleInformation vpInformation = new VehicleInformation();
		VLastLocation vLastLocation = new VLastLocation();
		try {
			InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
			String token=interfacetoken.getToken();
			vpInformation = vLastLocation.vLastLocationVin(token,vin, timeNearby);
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vpInformation;

	}

	// 查询多辆车的位置
	@Transactional(readOnly = false)
	public List<VehicleInformation> getLastLocationMulti(String vclNs, String timeNearby) {
		List<VehicleInformation> vpInformation = new ArrayList<VehicleInformation>();
		VLastLocation vLastLocation = new VLastLocation();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			vpInformation =  vLastLocation.vLastLocationMulti(token,vclNs, timeNearby);

			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vpInformation;

	}

	// 查询车辆轨迹(车牌号)
	@Transactional(readOnly = false)
	public List<VehicleInformation> getVHisTrack(String vclN, String date1,String date2) {
		List<VehicleInformation> vpInformation = new ArrayList<VehicleInformation>();
		VHisTrack vHisTrack24 = new VHisTrack();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			vpInformation = vHisTrack24.vHisTrack24(token,vclN, date1, date2);
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vpInformation;
	}

	// 查询车辆轨迹(车架号)
	@Transactional(readOnly = false)
	public List<VehicleInformation> getvHisTrackVin(String vin,String date1,String date2) {
		List<VehicleInformation> vpInformation = new ArrayList<VehicleInformation>();
		VHisTrack vHisTrack24 = new VHisTrack();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			vpInformation =vHisTrack24.vHisTrackVin24(token,vin, date1, date2);
			return vpInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 逆地理位置查询
	@Transactional(readOnly = false)
	public VehicleEvent getdecodeAddress(String lon, String lat,String type) {
		InverseQuery inverseQuery = new InverseQuery();
		VehicleEvent vehicleEvent = new VehicleEvent();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			vehicleEvent = inverseQuery.decodeAddress(token,lon, lat, type);
			return vehicleEvent;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	//// 指定时间段停车信息查询
	@Transactional(readOnly = false)
	public ParkingInformation getvQueryPark(String vclN, String vco, String qryBtm, String qryEtm, String parkMins) {

		VehicleQuery vehicleQuery = new VehicleQuery();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			return vehicleQuery.vQueryPark(token,vclN, vco, qryBtm, qryEtm, parkMins);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	// 车辆里程查询
	@Transactional(readOnly = false)
	public ParkingInformation getvQueryMileage(String vclN, String vco, String qryBtm, String qryEtm) {

		VehicleQuery vehicleQuery = new VehicleQuery();
		ParkingInformation parkingInformation = new ParkingInformation();
		InterfaceToken interfacetoken=interfacelogbiz.interfacetokens();
		String token=interfacetoken.getToken();
		try {
			parkingInformation = vehicleQuery.vQueryMileage(token,vclN, vco, qryBtm, qryEtm);
			return parkingInformation;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return parkingInformation;
	}

}
