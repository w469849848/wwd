package com.egolm.tpl.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.domain.TTemplateMapping;
import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.service.TplSettingService;

@Service("tplSettingService")
public class TplSettingServiceImpl implements TplSettingService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public Map<String, Object> saveJson(TYWTplLinkModule tplLinkModule, String sTplNo) {
		try {
			String sql = "select * from tYWTplLinkModule t where sLinkNo = ?";
			TYWTplLinkModule link = jdbcTemplate.queryForBean(sql, TYWTplLinkModule.class, tplLinkModule.getSLinkNo());
			if(link != null){
				link.setSLayoutContent(tplLinkModule.getSLayoutContent());
				jdbcTemplate.update(link);
				
				//判断是否是导航模块数据
				if(U.isNotBlank(tplLinkModule.getSLayoutContent()) && tplLinkModule.getSLayoutContent().indexOf("nav") > 0){
					JSONObject json = JSON.parseObject(tplLinkModule.getSLayoutContent());
					JSONArray jsonArr = json.getJSONArray("nav");
					TYWTplManage tpl = jdbcTemplate.queryForBean("select * from tYWTplManage t where t.sTplNo = ?", TYWTplManage.class, sTplNo);
					if(tpl != null){
						List<TTemplateMapping> list = null;
						TTemplateMapping tplMapping = null;
						StringBuffer ids = new StringBuffer();
						for(int i=0,length=jsonArr.size(); i<length; i++){
							JSONObject obj = jsonArr.getJSONObject(i);
							list = jdbcTemplate.queryForBeans("select * from tTemplateMapping t where t.sMainTemplateID = '"+tpl.getSTplNo()+"' and t.sTemplateID = '"+obj.getString("sTplNo")+"'", TTemplateMapping.class);
							if(list.size() == 0){
								tplMapping = new TTemplateMapping();
								tplMapping.setSOrgNO(tpl.getSBelongNo());
								tplMapping.setSMainTemplateID(tpl.getSTplNo());
								tplMapping.setSScopeType(tpl.getSScopeType());
								tplMapping.setSScopeTypeID(tpl.getSScopeTypeID());
								tplMapping.setSTemplateID(obj.getString("sTplNo"));
								tplMapping.setSTemplateName(obj.getString("sTplName"));
								tplMapping.setNTemplateIndex(i);
								tplMapping.setSCreateUser(SecurityContextUtil.getUserName());
								tplMapping.setDCreateDate(new Date());
								tplMapping.setDLastUpdateTime(new Date());
								tplMapping.setNStatus(0);
								jdbcTemplate.save(tplMapping);
								
								ids.append(obj.getString("sTplNo")+",");
							}else{
								tplMapping = list.get(0);
								tplMapping.setSOrgNO(tpl.getSBelongNo());
								tplMapping.setSMainTemplateID(tpl.getSTplNo());
								tplMapping.setSScopeType(tpl.getSScopeType());
								tplMapping.setSScopeTypeID(tpl.getSScopeTypeID());
								tplMapping.setSTemplateID(obj.getString("sTplNo"));
								tplMapping.setSTemplateName(obj.getString("sTplName"));
								tplMapping.setNTemplateIndex(i);
								tplMapping.setDLastUpdateTime(new Date());
								tplMapping.setNStatus(0);
								jdbcTemplate.update(tplMapping);
								
								ids.append(obj.getString("sTplNo")+",");
							}
						}
						
						if(U.isNotEmpty(ids)){
							jdbcTemplate.execute("delete from tTemplateMapping where sMainTemplateID = '"+tpl.getSTplNo()+"' and sTemplateID not in('"+(ids.toString().substring(0,ids.toString().length()-1)).replace(",", "','")+"')");
						}
					}
				}
				
				return Egox.egoxOk().setReturnValue("您提交的模板已保存成功！").getMap();
			}else{
				U.logger.error("查询失败");
				return Egox.egoxErr().setReturnValue("您提交的模板已保存失败！").getMap();
			}
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("您提交的模板已保存失败，错误信息："+e.getMessage());
			return Egox.egoxErr().setReturnValue("您提交的模板已保存失败").getMap();
		}
	}

	@Override
	public Map<String, Object> queryJson(String sLinkNo) {
		try {
			String sql = "select t.sLayoutContent as JsonData from tYWTplLinkModule t where t.sLinkNo = ?";
			return jdbcTemplate.queryForMap(sql,sLinkNo);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("查询Json数据结构异常");
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> queryModules(String sLinkNo) {
		try {
			String sql = "select a.sModuleNo,a.sModuleName,a.sBgPath,b.sLinkNo,b.sModName,b.nSequence,b.sLayoutContent from tYWModuleManage a , tYWTplLinkModule b where b.sModuleNo = a.sModuleNo and b.sTplNo = (select t.sTplNo from tYWTplLinkModule t where t.sLinkNo = ?) order by b.nSequence asc;";
			return jdbcTemplate.queryForList(sql, sLinkNo);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("查询模板相关的模块数据异常"+ e.getMessage());
			throw e;
		}
	}

	@Override
	public TYWTplManage queryTplBySlinkNo(String sLinkNo) {
		TYWTplManage tplManage = null;
		try {
			String sql = "select * from tYWTplManage t where t.sTplNo = (select a.sTplNo from tYWTplLinkModule a where a.sLinkNo = ?)";
			tplManage = jdbcTemplate.queryForBean(sql, TYWTplManage.class, sLinkNo);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据关联ID查询模板信息失败");
		}
		return tplManage;
	}

}
