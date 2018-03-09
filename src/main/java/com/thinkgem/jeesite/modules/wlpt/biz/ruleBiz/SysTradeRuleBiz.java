/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.biz.ruleBiz;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.rule.SysTradeRule;
import com.thinkgem.jeesite.modules.wlpt.service.rule.SysTradeRuleService;

/**
 * 
 * 规则管理接口
 * 
 * @author fjc
 * @version 2016-10-13
 */
@Service
@Transactional(readOnly = true)
public class SysTradeRuleBiz {

	@Autowired
	private SysTradeRuleService sysTradeRuleService;

	/**
	 * 保存规则接口
	 * 
	 * @param aTradeQuota
	 *            单笔交易最高限额
	 * @param bTradeQuota
	 * @param cTradeQuota
	 * @param aTradeCommission
	 *            单笔交易佣金
	 * @param bTradeCommission
	 * @param cTradeCommission
	 * @param aCashQuotaPc
	 *            单个账户单日累计提现限额 (%)
	 * @param bCashQuotaPc
	 * @param cCashQuotaPc
	 * @param aCashQuota
	 *            单个账户单日累计提现限额 (元)
	 * @param bCashQuota
	 * @param cCashQuota
	 * @param aLowestAmount
	 *            电子钱包最低留存额度
	 * @param bLowestAmount
	 * @param cLowestAmount
	 * @param aTradeQuotaDay
	 *            单日非同名交易最高限额
	 * @param bTradeQuotaDay
	 * @param cTradeQuotaDay
	 * @return
	 */
	@Transactional(readOnly = false)
	public Map<String, Object> save(Double aTradeQuota, Double bTradeQuota, Double cTradeQuota, Double aTradeCommission,
			Double bTradeCommission, Double cTradeCommission, Double aCashQuotaPc, Double bCashQuotaPc,
			Double cCashQuotaPc, Double aCashQuota, Double bCashQuota, Double cCashQuota, Double aLowestAmount,
			Double bLowestAmount, Double cLowestAmount, Double aTradeQuotaDay, Double bTradeQuotaDay,
			Double cTradeQuotaDay) {
		Map<String, Object> map = new HashMap<>();
		SysTradeRule sysTradeRuleA = new SysTradeRule();
		SysTradeRule sysTradeRuleB = new SysTradeRule();
		SysTradeRule sysTradeRuleC = new SysTradeRule();

		sysTradeRuleA.setTradeQuota(aTradeQuota.toString());
		sysTradeRuleA.setTradeCommission(aTradeCommission.toString());
		Double aCash = (aCashQuota != null && aCashQuota > 0) ? aCashQuota : aCashQuotaPc;
		sysTradeRuleA.setCashQuota(aCash.toString());
		sysTradeRuleA.setLowestAmount(aLowestAmount.toString());
		sysTradeRuleA.setTradeQuotaDay(aTradeQuotaDay.toString());
		sysTradeRuleA.setType(DataDic.SYS_TRADE_RULR_A);
		if (aCashQuota != null && aCashQuota > 0) {
			sysTradeRuleA.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNIT);
		} else {
			sysTradeRuleA.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNITPC);
		}

		sysTradeRuleB.setTradeQuota(bTradeQuota.toString());
		sysTradeRuleB.setTradeCommission(bTradeCommission.toString());
		Double bCash = (bCashQuota != null && bCashQuota > 0) ? bCashQuota : bCashQuotaPc;
		sysTradeRuleB.setCashQuota(bCash.toString());
		sysTradeRuleB.setLowestAmount(bLowestAmount.toString());
		sysTradeRuleB.setTradeQuotaDay(bTradeQuotaDay.toString());
		sysTradeRuleB.setType(DataDic.SYS_TRADE_RULR_B);
		if (bCashQuota != null && bCashQuota > 0) {
			sysTradeRuleB.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNIT);
		} else {
			sysTradeRuleB.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNITPC);
		}

		sysTradeRuleC.setTradeQuota(cTradeQuota.toString());
		sysTradeRuleC.setTradeCommission(cTradeCommission.toString());
		Double cCash = (cCashQuota != null && cCashQuota > 0) ? cCashQuota : cCashQuotaPc;
		sysTradeRuleC.setCashQuota(cCash.toString());
		sysTradeRuleC.setLowestAmount(cLowestAmount.toString());
		sysTradeRuleC.setTradeQuotaDay(cTradeQuotaDay.toString());
		sysTradeRuleC.setType(DataDic.SYS_TRADE_RULR_C);
		if (cCashQuota != null && cCashQuota > 0) {
			sysTradeRuleC.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNIT);
		} else {
			sysTradeRuleC.setCashQuotaUnit(DataDic.SYS_TRADE_RULR_UNITPC);
		}

		SysTradeRule sysTradeA = getBySysTradeRule(sysTradeRuleA);
		SysTradeRule sysTradeB = getBySysTradeRule(sysTradeRuleB);
		SysTradeRule sysTradeC = getBySysTradeRule(sysTradeRuleC);
		if (sysTradeA != null && !Tools.IsNullOrWhiteSpace(sysTradeA.getId())) {// 如果记录存在则更新
																				// 否则直接添加
			sysTradeRuleA.setId(sysTradeA.getId());
			sysTradeRuleService.save(sysTradeRuleA);
		} else {
			sysTradeRuleService.save(sysTradeRuleA);
		}
		if (sysTradeB != null && !Tools.IsNullOrWhiteSpace(sysTradeB.getId())) {
			sysTradeRuleB.setId(sysTradeB.getId());
			sysTradeRuleService.save(sysTradeRuleB);
		} else {
			sysTradeRuleService.save(sysTradeRuleB);
		}
		if (sysTradeC != null && !Tools.IsNullOrWhiteSpace(sysTradeC.getId())) {
			sysTradeRuleC.setId(sysTradeC.getId());
			sysTradeRuleService.save(sysTradeRuleC);
		} else {
			sysTradeRuleService.save(sysTradeRuleC);
		}
		return map;
	}

	/**
	 * 查询 根据对象条件
	 * 
	 * @param sysTradeRule
	 * @return
	 */
	public SysTradeRule getBySysTradeRule(SysTradeRule sysTradeRule) {
		SysTradeRule tradeRule = new SysTradeRule();
		tradeRule = sysTradeRuleService.get(sysTradeRule);
		return tradeRule;
	}

	/**
	 * 查询 根据规则分类 123对应ABC
	 * 
	 * @param sysTradeRule
	 * @return
	 */
	public SysTradeRule getBySysTradeRule(String type) {
		SysTradeRule tradeRule = new SysTradeRule();
		SysTradeRule resulttradeRule = new SysTradeRule();
		if (DataDic.SYS_TRADE_RULR_A.equals(type)) {
			tradeRule.setType(DataDic.SYS_TRADE_RULR_A);
		} else if (DataDic.SYS_TRADE_RULR_B.equals(type)) {
			tradeRule.setType(DataDic.SYS_TRADE_RULR_B);
		} else if (DataDic.SYS_TRADE_RULR_C.equals(type)) {
			tradeRule.setType(DataDic.SYS_TRADE_RULR_C);
		} else {
			return null;
		}
		resulttradeRule = sysTradeRuleService.get(tradeRule);
		return resulttradeRule;
	}
}