package com.egolm.tpl.service;

import java.util.List;
import java.util.Map;

import org.springframework.plugin.jdbc.PageSqlserver;

import com.egolm.domain.TOrgCategory;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Org;

public interface CategoryService {

	/**
	 * @description 分类信息列表查询
	 * @param paramMap 查询参数
	 * @param page 分页参数
	 * @return
	 */
	public Map<String, Object> queryCategorys(Map<String, Object> paramMap, PageSqlserver page);
	
	/**
	 * @description 新增分类信息
	 * @param category  
	 * @param cateItems 分类数据
	 * @return
	 */
	public Map<String, Object> saveCategory(TOrgCategory category,String cateItems);
	
	/**
	 * @description 新增分类信息
	 * @param category  
	 * @param cateItems 分类数据
	 * @return
	 */
	public Map<String, Object> updateCategory(TOrgCategory category,String cateItems);
	
	/**
	 * @description 删除分类信息
	 * @param sOrgNO 区域编码
	 * @param sScopeTypeID 店铺编码
	 * @return
	 */
	public Map<String, Object> deleteCategory(String cateItems);
	
	/**
	 * @description 查询分类信息
	 * @param sOrgNO  区域编码
	 * @param sScopeTypeID  店铺编码
	 * @return
	 */
	public Map<String, Object> queryCategoryByParam(String sOrgNO, String sScopeTypeID);
	
	/**
	 * 根据区域ID和店铺类型，获取所有的商品分类
	 * @param sOrgNo
	 * @param sScopeTypeID
	 * @return
	 */
	public List<Category> queryCategoryForTpl(String sOrgNo,String sScopeTypeID);
	
	/**
	 * @description 根据区域等级，获取区域信息
	 * @param orgLevel
	 * @return
	 */
	public List<Org> queryOrg();
	
	/**
	 * @description 加载商品分类
	 * @return
	 */
	public Map<String,Object>  queryCategoryTree();
	
	/**
	 * @description 根据多个区域编号和店铺类型查询商品分类数据
	 * @param cateItems 例(SUZU-1,XIAN-2)
	 * @return
	 */
	public List<Map<String,Object>> queryCategorys(String cateItems);
}
