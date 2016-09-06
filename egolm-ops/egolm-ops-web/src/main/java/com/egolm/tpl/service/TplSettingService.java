package com.egolm.tpl.service;

import java.util.List;
import java.util.Map;

import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;

public interface TplSettingService {

	/**
	 * @description 保存模板对应模块的Json数据结构
	 * @param tplLinkModule
	 * @return
	 */
	public Map<String, Object> saveJson(TYWTplLinkModule tplLinkModule, String sTplNo);
	
	
	/**
	 * @description 根据ID查询Json数据结构
	 * @param sLinkNo 
	 * @return
	 */
	public Map<String, Object> queryJson(String sLinkNo);
	
	
	/**
	 * @description 根据模板中的某一个sLinkNo查询其所有的子模块
	 * @param sLinkNo 模板与模块的关联ID
	 * @return
	 */
	public List<Map<String, Object>> queryModules(String sLinkNo);
	
	/**
	 * @description 通过模板与模块关联ID查询模板对象
	 * @param sLinkNo 模板与模块关联ID
	 * @return
	 */
	public TYWTplManage queryTplBySlinkNo(String sLinkNo);
}
