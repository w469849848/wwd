package com.egolm.tpl.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.EgolmException;
import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.service.TplService;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;

@Service("tplService")
public class TplServiceImpl implements TplService {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public Map<String, Object> queryTemplates(Map<String, Object> paramMap, PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			StringBuffer sql = new StringBuffer("select t.* from tYWTplManage t where 1=1");
			if (paramMap != null) {
				String sTplName = (String) paramMap.get("sTplName");
				String sBelongNo = (String) paramMap.get("sBelongNo");
				String sTplNo = (String) paramMap.get("sTplNo");
				String nTag = (String) paramMap.get("nTag");
				List<String> sBelongNoList=(List<String>)paramMap.get("sBelongNoList");
				if (U.isNotBlank(sTplName)) {
					sql.append(" and t.sTplName like '%" + sTplName + "%'");
				}
				if (U.isNotBlank(sBelongNo)) {
					sql.append(" and t.sBelongNo = '" + sBelongNo + "'");
				}
				if(U.isNotBlank(nTag)){
					sql.append(" and t.nTag = "+nTag+"");
				}
				if(sBelongNoList!=null&&sBelongNoList.size()>0){
					/*StringBuffer sb=new StringBuffer();
					for (String belongNo : sBelongNoList) {
						sb.append(",'"+sBelongNoList+"'");
					}
					String temp=sb.toString().substring(1);*/
					
					String sBegongNo = StringUtil.join("','","'","'",sBelongNoList);
					sql.append(" and t.sBelongNo in ("+sBegongNo+")");
				}
				if(U.isNotEmpty(sTplNo)){
					sql.append(" and t.sTplNo not in('"+sTplNo+"')");
				}
				
				
			}
			List<Map<String, Object>> result = jdbcTemplate.limit(sql.toString(), page);
			map.put("result", result);
			map.put("page", page);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模板信息查询失败");
		}
		return map;
	}

	@Override
	public Map<String, Object> saveTemplate(TYWTplManage tplManage, String moduleItems) {
		try {
			
			String[] module = moduleItems.split(",");
			if (U.isNotEmpty(tplManage.getSTplNo())) {
				//判断模板名称唯一性
				List<TYWTplManage> tplTemp = jdbcTemplate.queryForBeans("select * from tYWTplManage t where t.sBelongNo = ? and t.sScopeTypeID = ? and sTplName = ?" ,TYWTplManage.class, tplManage.getSBelongNo(), tplManage.getSScopeTypeID(),tplManage.getSTplName());
				if(tplTemp != null && tplTemp.size() == 1){
					if(!tplManage.getSTplNo().equals(tplTemp.get(0).getSTplNo())){
						return Egox.egoxErr().setReturnValue(tplManage.getSBelongArea()+"区域的"+tplManage.getSScopeType()+"店铺模板名称已存在，模板修改失败").getMap();
					}
				}else if(tplTemp != null && tplTemp.size() > 1){
					return Egox.egoxErr().setReturnValue("保存模板失败").getMap();
				}
				
				jdbcTemplate.update(tplManage);
				StringBuffer ids = new StringBuffer();
				if(U.isNotBlank(moduleItems)){
					for(int i=0; i < module.length; i++){
						String[] temp = module[i].split("_");
						if(U.isNotEmpty(temp[0]) && !"NaN".equals(temp[0])){
							ids.append(temp[0]+",");
							TYWTplLinkModule updatelink = jdbcTemplate.queryForBean("select * from tYWTplLinkModule t where t.sLinkNo = ?", TYWTplLinkModule.class, temp[0]);
							updatelink.setNSequence(Integer.parseInt(temp[2]));
							updatelink.setSModName(temp[3]);
							jdbcTemplate.update(updatelink);
						}else{
							String addUUID = U.uuid();
							TYWTplLinkModule addlink = new TYWTplLinkModule();
							addlink.setSLinkNo(addUUID);
							addlink.setSTplNo(tplManage.getSTplNo());
							addlink.setSModuleNo(temp[1]);
							addlink.setNSequence(Integer.parseInt(temp[2]));
							addlink.setSModName(temp[3]);
							jdbcTemplate.save(addlink);
							ids.append(addUUID+",");
						}
					}
				}
				if(U.isNotEmpty(ids)){
					jdbcTemplate.execute("delete from tYWTplLinkModule where sLinkNo not in('"+(ids.toString().substring(0,ids.toString().length()-1)).replace(",", "','")+"') and sTplNo = '"+tplManage.getSTplNo()+"'");
				}
			} else {
				Long count = jdbcTemplate.queryForLong("select count(*) from tYWTplManage t where t.sBelongNo = ? and t.sScopeTypeID = ? and sTplName = ?", tplManage.getSBelongNo(), tplManage.getSScopeTypeID(),tplManage.getSTplName());
				if(count > 0){
					return Egox.egoxErr().setReturnValue(tplManage.getSBelongArea()+"区域的"+tplManage.getSScopeType()+"店铺模板名称已存在，新增模板失败").getMap();
				}
				
				String uuid = U.uuid();
				tplManage.setSTplNo(uuid);
				tplManage.setNTag(0);
				jdbcTemplate.save(tplManage);
				if(U.isNotEmpty(moduleItems)){
					for(int i=0; i < module.length; i++){
						String[] temp = module[i].split("_");
						TYWTplLinkModule link = new TYWTplLinkModule();
						link.setSLinkNo(U.uuid());
						link.setSTplNo(uuid);
						link.setSModuleNo(temp[1]);
						link.setNSequence(Integer.parseInt(temp[2]));
						link.setSModName(temp[3]);
						jdbcTemplate.save(link);
					}
				}
			}
			
			
			return Egox.egoxOk().setReturnValue("保存模板成功").getMap();
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("保存模板失败");
			return Egox.egoxErr().setReturnValue("保存模板失败").getMap();
		}
	}

	@Override
	public TYWTplManage queryTemplateById(String sTplNo) {
		String sql = "select t.* from tYWTplManage t where t.sTplNo = ?";
		return jdbcTemplate.queryForBean(sql, TYWTplManage.class, sTplNo);
	}

	@Override
	public Map<String, Object> updateTemplateStatus(String sTplNo, Integer nTag) {
		try {
			String sql = "select t.* from tYWTplManage t where t.sTplNo = ?";
			TYWTplManage tplManage = jdbcTemplate.queryForBean(sql, TYWTplManage.class, sTplNo);
				if(nTag == 1){
					if(tplManage.getNIsHome() == 1){
						Long count1 = jdbcTemplate.queryForLong("select count(*) from tYWTplManage t where t.sBelongNo = ? and t.sScopeTypeID = ? and nIsHome = ? and nTag = 1", tplManage.getSBelongNo(), tplManage.getSScopeTypeID(), 1);
						if(count1 > 0){
							return Egox.egoxErr().setReturnValue(tplManage.getSBelongArea()+"区域"+tplManage.getSScopeType()+"店铺首页模板已经发布一个,不能再发布").getMap();
						}
					}
					
					Long count2 = jdbcTemplate.queryForLong("select count(*) from tYWTplLinkModule t where t.sTplNo = ? and t.sLayoutContent is null", sTplNo);
					if(count2 > 0){
						return Egox.egoxErr().setReturnValue("存在模块未配置数据，不能发布").getMap();
					}
			}
				
			//检查广告位状态是否被占用，如果有占用，将抛出EgolmException异常
			checkAdStatus(sTplNo,nTag);	
				
			tplManage.setNTag(nTag);
			jdbcTemplate.update(tplManage);
		
			//更新模板导航区模板状态
			updateTplMappingStatus(sTplNo,nTag);
			
			return Egox.egoxOk().setReturnValue("更新模板状态成功").getMap();
		}catch (EgolmException e) {
			e.printStackTrace();
			U.logger.error(e.getMessage());
			return Egox.egoxErr().setReturnValue(e.getMessage()).getMap();
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("更新模板状态失败");
			return Egox.egoxErr().setReturnValue("更新模板状态失败").getMap();
		}
	}

	/**
	 * 检查广告位状态是否被占用，如果有占用，将抛出EgolmException异常
	 * @param sTplNo
	 * @param nTag
	 * @throws EgolmException
	 */
	private void checkAdStatus(String sTplNo,Integer nTag) throws EgolmException {
		
		//解析当前模板中所有广告位ID
		List<Map<String,Object>> moduleList = queryModulesForCheckAd(sTplNo);
		List<String> allApIdList=new ArrayList<String>();
		for (Map<String, Object> module : moduleList) {
			String sLayoutContent=(String) module.get("sLayoutContent");
			String sModName=(String) module.get("sModName");
			String sTplName=(String) module.get("sTplName");
			String sBelongArea=(String) module.get("sBelongArea");
			String sPcPath=(String) module.get("sPcPath");
			JSONObject jsonRoot = JSON.parseObject(sLayoutContent);
			List<String> moduleApIdList=new ArrayList<String>();
			if("template/nav1.vm".equals(sPcPath)){
				JSONObject adPosLeftObject = jsonRoot.getJSONObject("ap_M");
				JSONObject adPosRightObject = jsonRoot.getJSONObject("ap_R");
				moduleApIdList.add(adPosLeftObject.getString("nApID"));
				moduleApIdList.add(adPosRightObject.getString("nApID"));
			}else if("template/brand1.vm".equals(sPcPath)){
				JSONObject adObject = jsonRoot.getJSONObject("adPos");
				moduleApIdList.add(adObject.getString("nApID"));
			}else if("template/floor1.vm".equals(sPcPath)){
				JSONArray advertJsonArray = jsonRoot.getJSONArray("datas");
				for (int i = 0; i < advertJsonArray.size(); i++) {
					JSONObject advertObject = advertJsonArray.getJSONObject(i);
					moduleApIdList.add(advertObject.getJSONObject("ap_L").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_R").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_M1").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_M2").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_M3").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_M4").getString("nApID"));
				}
				
			}else if("template/floor2.vm".equals(sPcPath)){
				JSONArray advertJsonArray = jsonRoot.getJSONArray("datas");
				for (int i = 0; i < advertJsonArray.size(); i++) {
					JSONObject advertObject = advertJsonArray.getJSONObject(i);
					moduleApIdList.add(advertObject.getJSONObject("ap_L").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_R").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_1st").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_2nd").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_3rd").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_4th").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_5th").getString("nApID"));
					moduleApIdList.add(advertObject.getJSONObject("ap_6th").getString("nApID"));
				}
			}else if("template/ad1.vm".equals(sPcPath)){
				moduleApIdList.add(jsonRoot.getString("nApID"));
			}
			
			allApIdList.addAll(moduleApIdList);
		
			//如果是启用模板，需要先检查是否有广告位被使用，如果有需要提供在哪里被使用。如果没有，则更新广告位状态为已启用，一个模块一个模块地检查
			if(nTag==1){
				Map<String, String> searchMap=new HashMap<String, String>();
				if(moduleApIdList.size()>0){
					searchMap.put("apID", StringUtils.join(moduleApIdList, ","));
					JSONObject json = HttpHandler.post(TplSettingPopController.HTTP_QUERY_AP_STATUS,searchMap);
					JSONArray dataListJson = json.getJSONArray("DataList");
					if(dataListJson!=null && dataListJson.size()>0){
						for(int i=0;i<dataListJson.size();i++){
							JSONObject adobject=dataListJson.getJSONObject(i);
							String sApStatusID = adobject.getString("sApStatusID");
							if("1".equals(sApStatusID)){
								throw new EgolmException("【"+sModName+"】模块广告位已被使用，请重新选择。");
							}
						}
					}
				}
			}
			
		}
		
		//批量更新模板中所有广告的状态，如果是启用，刚将所有广告位状态更新为“启用：1”，如果是取消启用，则将所有广告位状态更新为“未启用：0”。
		Map<String, String> searchMap=new HashMap<String, String>();
		if(allApIdList.size()>0){
			searchMap.put("apID", StringUtils.join(allApIdList, ","));
			searchMap.put("statusID", nTag+"");
			JSONObject json = HttpHandler.post(TplSettingPopController.HTTP_UPDATE_AP_STATUS,searchMap);
			if(!json.getBoolean("IsValid")){
				throw new EgolmException("更新广告位状态出错。"+json.getString("ReturnValue"));
			}
		}
		
	}

	@Override
	public Map<String, Object> deleteTemplate(String sTplNo) {
		try {
			String sql = "select * from tYWTplManage t where t.sTplNo = ?";
			TYWTplManage tplManage = jdbcTemplate.queryForBean(sql, TYWTplManage.class, sTplNo);
			jdbcTemplate.delete(tplManage);
			
			jdbcTemplate.execute("delete from tYWTplLinkModule where sTplNo = '"+sTplNo+"'");
			
			return Egox.egoxOk().setReturnValue("删除模板成功").getMap();
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("删除模板状态失败");
			return Egox.egoxErr().setReturnValue("删除模板失败").getMap();
		}
	}
	
	@Override
	public List<TYWTplLinkModule>  queryModulesBySTplNo(String sTplNo) {
		try {
			String sql = "select * from tYWTplLinkModule t where t.sTplNo = ? order by t.nSequence asc";
			return jdbcTemplate.queryForBeans(sql, TYWTplLinkModule.class, sTplNo);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据模板ID查询模块集合异常");
			throw e;
		}
	}
	
	
	public List<Map<String, Object>>  queryModulesForCheckAd(String sTplNo){
		
		try {
			String sql="select tm.sModName,tm.sLayoutContent,t.sTplName,t.sBelongArea,m.sPcPath from tYWTplLinkModule tm "
					+" left join tYWTplManage t on tm.sTplNo=t.sTplNo left join tYWModuleManage m on tm.sModuleNo=m.sModuleNo where tm.sTplNo='"+sTplNo+"'";
			return jdbcTemplate.queryForList(sql);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据模板ID查询模块集合异常");
			throw e;
		}
		
		
	}
	
	
	@Override
	public List<Map<String, Object>>  queryFullModulesBySTplNo(String sTplNo) {
		try {
			String queryByTplNoSql = "select a.sModuleNo,a.sModuleName,a.nIsFloor,a.sPcPath,a.sWxPath,b.sLinkNo,b.nSequence,b.sLayoutContent,b.sModName from tYWModuleManage a , tYWTplLinkModule b where b.sModuleNo = a.sModuleNo and b.sTplNo =? order by b.nSequence asc";
			return jdbcTemplate.queryForList(queryByTplNoSql, sTplNo);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据模板ID查询模块集合异常");
			throw e;
		}
	}
	
	
	
	

	@Override
	public Map<String, Object> queryModules() {
		Map<String, Object> datas =  new HashMap<String, Object>();
		try {
			String queryAllSql = "select t.* from tYWModuleManage t where t.nStatus = '启用'";
			List<Map<String, Object>> moduleAll = jdbcTemplate.queryForList(queryAllSql);
			
			String queryModuleTypeSql = "select distinct t.nModuleType from tYWModuleManage t where t.nStatus = '启用'";
			List<String> moduleType = jdbcTemplate.queryForObjects(queryModuleTypeSql, String.class);
			
			datas.put("moduleAll", moduleAll);
			datas.put("moduleType", moduleType);
			return datas;
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("查询所有模块集合异常");
			return null;
		}
	}
	
	
	@Override
	public Map<String, Object> queryModuleUrl(String sTplNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String sql_url = "select t.sBgPath from tYWModuleManage t where t.sModuleNo = (select top 1 a.sModuleNo from tYWTplLinkModule a where a.sTplNo = ? order by a.nSequence asc)";
			String sql_linkNo = "select top 1 a.sLinkNo from tYWTplLinkModule a where a.sTplNo = ? order by a.nSequence asc";
			
			Map<String, Object> map1 = jdbcTemplate.queryForMap(sql_url, sTplNo);
			Map<String, Object> map2 = jdbcTemplate.queryForMap(sql_linkNo, sTplNo);
			
			map.put("sBgPath", map1.get("sBgPath").toString());
			map.put("sLinkNo", map2.get("sLinkNo").toString());
			
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据模板编号查询第一个模块后台管理地址异常");
			throw e;
		}
	}

	@Override
	public Map<String, Object> queryScopeType(String tCommonNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String sql = "select * from tCommon  where sCommonNO = ? and nTag&0=0";
			List<Map<String, Object>> result = jdbcTemplate.queryForList(sql, tCommonNo);
			map.put("datas", result);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("获取数据字典"+tCommonNo+"失败:", e);
			return map;
		}
	}

	/**
	 * @description 根据模板ID更新导航
	 * @param sTplNo
	 */
	private void updateTplMappingStatus(String sTplNo, Integer nTag) throws EgolmException{
		try {
			String sql = "update tTemplateMapping set nStatus = "+nTag+" where sMainTemplateID = '"+sTplNo+"'";
			jdbcTemplate.execute(sql);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw new EgolmException("模板导航区子模板状态更新出错");
		}
	}
	

}
