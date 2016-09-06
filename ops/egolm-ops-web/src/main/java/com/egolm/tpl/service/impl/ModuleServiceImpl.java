package com.egolm.tpl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

import com.egolm.domain.TYWModuleManage;
import com.egolm.domain.TYWTplManage;
import com.egolm.tpl.service.ModuleService;

@Service("moduleService")
public class ModuleServiceImpl implements ModuleService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public Map<String, Object> updateModuleStatus(String sModuleNo, String nStatus) {
		try {
			if("禁用".equals(nStatus)){
				List<TYWTplManage> list = jdbcTemplate.queryForBeans("select * from tYWTplManage t where t.sTplNo in (select distinct a.sTplNo from tYWTplLinkModule a where a.sModuleNo = ?) and t.nTag=1", TYWTplManage.class, sModuleNo);
				if(list.size() > 0){
					StringBuffer msg = new StringBuffer();
					for(int i=0,length=list.size(); i<length; i++){
						if(i == length - 1){
							msg.append(list.get(i).getSBelongArea()+"区域"+list.get(i).getSScopeType()+"店铺"+list.get(i).getSTplName()+"模板");
						}else{
							msg.append(list.get(i).getSBelongArea()+"区域"+list.get(i).getSScopeType()+"店铺"+list.get(i).getSTplName()+"模板,");
						}
					}
					msg.append("正在使用该模块,不能禁用");
					return Egox.egoxErr().setReturnValue(msg.toString()).getMap();
				}
			}
			String sql = "select * from tYWModuleManage t where  t.sModuleNo = ?";
			TYWModuleManage module = jdbcTemplate.queryForBean(sql, TYWModuleManage.class,sModuleNo);
			module.setNStatus(nStatus);
			jdbcTemplate.update(module);
			return Egox.egoxOk().setReturnValue("更新模块状态成功").getMap();
		} catch (Exception e) {
			e.printStackTrace();
			return Egox.egoxErr().setReturnValue("更新模块状态出错").getMap();
		}
		
	}

	@Override
	public Map<String, Object> deleteModule(String sModuleNo) {
		try {
			List<TYWTplManage> list = jdbcTemplate.queryForBeans("select * from tYWTplManage t where t.sTplNo in (select distinct a.sTplNo from tYWTplLinkModule a where a.sModuleNo = ?) and t.nTag=1", TYWTplManage.class, sModuleNo);
			if(list.size() > 0){
				StringBuffer msg = new StringBuffer();
				for(int i=0,length=list.size(); i<length; i++){
					if(i == length - 1){
						msg.append(list.get(i).getSBelongArea()+"区域"+list.get(i).getSScopeType()+"店铺"+list.get(i).getSTplName()+"模板");
					}else{
						msg.append(list.get(i).getSBelongArea()+"区域"+list.get(i).getSScopeType()+"店铺"+list.get(i).getSTplName()+"模板,");
					}
				}
				msg.append("正在使用该模块,不能删除");
				return Egox.egoxErr().setReturnValue(msg.toString()).getMap();
			}
			
			String sql = "select * from tYWModuleManage t where  t.sModuleNo = ?";
			TYWModuleManage module = jdbcTemplate.queryForBean(sql, TYWModuleManage.class,sModuleNo);
			jdbcTemplate.delete(module);
			
			jdbcTemplate.execute("delete from tYWTplLinkModule where sModuleNo = '"+sModuleNo+"'");
			
			return Egox.egoxOk().setReturnValue("模块删除成功,同时同步删除模板中引用的该模块").getMap();
		} catch (Exception e) {
			e.printStackTrace();
			return Egox.egoxErr().setReturnValue("删除模块出错").getMap();
		}
	}

	@Override
	public TYWModuleManage queryModuleById(String sModuleNo) {
		String sql = "select * from tYWModuleManage t where  t.sModuleNo = ?";
		return jdbcTemplate.queryForBean(sql, TYWModuleManage.class,sModuleNo);
	}

	@Override
	public Map<String, Object> saveModule(TYWModuleManage module) {
		
		try {
			if(U.isNotEmpty(module.getSModuleNo())){
				jdbcTemplate.update(module);
			}else{
				module.setSModuleNo(U.uuid());
				jdbcTemplate.save(module);
			}
			return Egox.egoxOk().setReturnValue("保存模块成功").getMap();
		} catch (Exception e) {
			e.printStackTrace();
			return Egox.egoxErr().setReturnValue("保存模块出错").getMap();
		}
	}

	@Override
	public Map<String, Object> queryModules(Map<String, Object> paramMap, PageSqlserver page) {
		Map <String,Object>map=new HashMap<String,Object>();
		StringBuffer sql= new StringBuffer("select * from tYWModuleManage t where 1=1 ");
        if(paramMap!=null){
        	String sModuleName=(String)paramMap.get("sModuleName");
        	String nModuleType=(String)paramMap.get("nModuleType");
        	if(U.isNotEmpty(nModuleType)){
        		sql.append("and t.nModuleType='"+nModuleType+"' ");	
        	}
        	if(U.isNotEmpty(sModuleName)){
        		sql.append("and t.sModuleName like '%"+sModuleName.trim()+"%' ");	
        	}
		}
        List<Map<String, Object>> result=jdbcTemplate.limit(sql.toString(), page);
        map.put("result", result);
        map.put("page", page);
        return map;
	}

}
