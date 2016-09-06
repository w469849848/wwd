package com.egolm.tpl.service;

import java.util.List;
import java.util.Map;

import org.springframework.plugin.jdbc.PageSqlserver;

import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;

/**
 * @description 模板管理接口
 * @package com.egolm.tpl.service
 * @author H.P.Yang
 * @date 2016年5月20日 下午8:59:27
 */
public interface TplService {

	/**
	 * @description 模板信息列表查询
	 * @param paramMap  查询参数
	 * @param page 分页参数
	 * @return
	 */
	public Map<String, Object> queryTemplates(Map<String, Object> paramMap, PageSqlserver page);
	
	/**
	 * @description 创建模板
	 * @param tplManage
	 * @return
	 */
	public Map<String, Object> saveTemplate(TYWTplManage tplManage, String moduleItems);
	
	/**
	 * @description 查询单个模板信息
	 * @param sTplNo  模板编号
	 * @return
	 */
	public TYWTplManage queryTemplateById(String sTplNo);
	
	/**
	 * @description 模板发布状态更新
	 * @param sTplNo 模板编号
	 * @param nTag 状态
	 * @return
	 */
	public Map<String, Object> updateTemplateStatus(String sTplNo, Integer nTag);
	
	/**
	 * @description 模板删除
	 * @param sTplNo 模板编号
	 * @return
	 */
	public Map<String, Object> deleteTemplate(String sTplNo);
	
	/**
	 * @description 根据模板编号查询模块集合
	 * @param sTplNo
	 * @return
	 */
	public List<TYWTplLinkModule> queryModulesBySTplNo(String sTplNo);
	
	
	/**
	 * 用于生成静态页面
	 * @param sTplNo
	 * @return
	 */
	public List<Map<String, Object>>  queryFullModulesBySTplNo(String sTplNo);
	
	/**
	 * @description 根据模板编号查询模块对象集合
	 * @param sModuleNo
	 * @return
	 */
	public Map<String, Object> queryModules();
	
	
	/**
	 * @description 根据模板编号查询该模板下的第一个模块的后台管理地址
	 * @param sTplNo
	 * @return
	 */
	public Map<String, Object> queryModuleUrl(String sTplNo);
	
	/**
	 * @description 获取店铺类型
	 * @param tCommonNo 字典编码
	 * @return
	 */
	public Map<String, Object> queryScopeType(String tCommonNo);
}
