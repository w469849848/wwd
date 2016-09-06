
package com.egolm.base.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.EgolmException;
import com.egolm.common.EgolmLogger;
import com.egolm.common.advert.AdvertContants;
import com.egolm.common.enums.UserType;
import com.egolm.security.utils.SecurityContextUtil;

/**   
* @Title: TOrgsController.java 
* @Package com.egolm.base.web 
* @Description: TODO(组织机构控制器) 
* @author zhangyong  
* @date 2016年5月14日 上午11:46:51 
* @version V1.0   
*/
@Controller
@RequestMapping("/org")
public class TOrgsController {
	@Resource(name = "tOrgsQueryApi")
	private TOrgsQueryApi  tOrgsQueryApi;
	
	@RequestMapping(value="/queryTOrgsByLevel")
	public void queryTOrgsByLevel(HttpServletRequest request, Writer writer) {
		String nOrgsLevel = request.getParameter("nOrgsLevel");
		if (U.isEmpty(nOrgsLevel)) {
			Egox.egoxErr().setReturnValue("参数为空").write(writer);
			return;
		}
		if (!StringUtil.isInt(nOrgsLevel.trim())) {
			Egox.egoxErr().setReturnValue("参数错误").write(writer);
			return;
		}

		List<String> regionIds = SecurityContextUtil.getRegionIds();
		try {
			List<Map<String, Object>> dataMap = tOrgsQueryApi.queryTOrgs(regionIds, Integer.valueOf(nOrgsLevel.trim()));
			UserType userType = SecurityContextUtil.getUserType();
			if(userType.oneOf(UserType.ADMIN)){
				Map<String,Object> chinaMap = new HashMap<String,Object>();
				chinaMap.put("sOrgNO", AdvertContants.ADVER_CHINA);
				chinaMap.put("sOrgDesc", "全国通用");
				dataMap.add(0, chinaMap);
				Egox.egoxOk().setDataList(dataMap).write(writer);
				return;
			}
			
			Egox.egoxOk().setDataList(dataMap).write(writer);
		} catch (EgolmException e) {
			EgolmLogger.OpsLogger.error(e.getMessage());
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.OpsLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
	
	/**
	 * 根据市编号查区域 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/queryTOrgsByScityID")
	public void queryTOrgsByScityID(HttpServletRequest request, Writer writer) {
		String sCityID = request.getParameter("sCityID");
		if (U.isEmpty(sCityID)) {
			Egox.egoxErr().setReturnValue("参数为空").write(writer);
			return;
		} 
		try {
			Map<String, Object> dataMap = tOrgsQueryApi.queryTOrgsBySReginNO(sCityID);
			boolean result = (boolean)dataMap.get("IsValid");
			if(result){
				List<Map<String,String>> dataList = (List<Map<String,String>>)dataMap.get("DataList");
				Egox.egoxOk().setDataList(dataList).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("获取经销商区域失败").write(writer);
			} 
		} catch (Throwable e) {
			U.logger.error("", e);
			Egox.egoxErr().setReturnValue("获取经销商区域失败").write(writer);
		}
	}
}	
