package com.egolm.tpl.service;

import java.util.Map;

import org.springframework.plugin.jdbc.PageSqlserver;

import com.egolm.domain.TYWModuleManage;

public interface ModuleService {

	public Map<String, Object> updateModuleStatus(String sModuleNo, String nStatus);

	public Map<String, Object> deleteModule(String sModuleNo);

	public TYWModuleManage queryModuleById(String sModuleNo);

	public Map<String, Object> saveModule(TYWModuleManage module);

	public Map<String, Object> queryModules(Map<String, Object> paramMap, PageSqlserver page);
}
