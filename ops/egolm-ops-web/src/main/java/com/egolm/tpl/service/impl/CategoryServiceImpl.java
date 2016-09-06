package com.egolm.tpl.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

import com.egolm.common.goods.GoodsContants;
import com.egolm.domain.TAgentContractGoods;
import com.egolm.domain.TGoods;
import com.egolm.domain.TOrgCategory;
import com.egolm.domain.TOrgGoodsCategory;
import com.egolm.goods.domain.CategoryDto;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Org;
import com.egolm.tpl.service.CategoryService;

@Service("categoryService")
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public Map<String, Object> queryCategorys(Map<String, Object> paramMap, PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			StringBuffer sql = new StringBuffer("select t.sOrgNO,t.sOrgName,t.sScopeTypeID,t.sScopeType from tOrgCategory t where 1=1");
			if(paramMap != null){
				String sOrgNO = (String) paramMap.get("sOrgNO");
				if(U.isNotBlank(sOrgNO)){
					sql.append(" and t.sOrgNO = '"+sOrgNO+"'");
				}
				
				String sScopeTypeID = (String) paramMap.get("sScopeTypeID");
				if(U.isNotBlank(sScopeTypeID)){
					sql.append(" and t.sScopeTypeID = '"+sScopeTypeID+"'");
				}
				
			}
			sql.append(" group by t.sOrgNO,t.sOrgName,t.sScopeTypeID,t.sScopeType");
			
			System.out.println("==="+sql.toString());
			
			List<Map<String, Object>> result = jdbcTemplate.limit(sql.toString(), page);
			
			map.put("result", result);
			map.put("page", page);
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("分类信息查询失败");
		}
		return map;
	}

	@Override
	public Map<String, Object> saveCategory(TOrgCategory category, String cateItems) {
		try {
			String sql = "select count(*) from tOrgCategory t where t.sOrgNO = ? and t.sScopeTypeID = ?";
			Long count = jdbcTemplate.queryForLong(sql, category.getSOrgNO(), category.getSScopeTypeID());
			if(count > 0){
				return Egox.egoxErr().setReturnValue(category.getSOrgName()+"区域的"+category.getSScopeType()+"店铺商品分类数据已创建").getMap();
			}
			Date date = new Date();
			List<TOrgGoodsCategory> orgGoodsCatList = new ArrayList<TOrgGoodsCategory>();
			for(String obj : cateItems.split("-")){
				String[] cate = obj.split(",");
				
				category.setSCategoryNO(cate[0]);
				category.setSCategoryDesc(cate[1]);
				category.setNCategoryLevel(Integer.parseInt(cate[2]));
				category.setSUpCategoryNO(cate[3]);
				category.setNTag(0);
				
				category.setSCreateUser(SecurityContextUtil.getUserName());
				category.setDCreateDate(date);
				
				category.setSConfirmUser(SecurityContextUtil.getUserName());
				category.setDConifrmDate(date);
				
				category.setDLastUpdateTime(date);
				U.logger.error("catLevel -=-=- "+category.getNCategoryLevel());
				if(GoodsContants.GOODS_CAT_LEVEL_ONE.equals(category.getNCategoryLevel().toString())){
					U.logger.error(category.getNCategoryLevel());
					List<TGoods> goodsList = jdbcTemplate.queryForBeans("select * from tGoods where sCategoryNO = ?", TGoods.class, category.getSCategoryNO());
					U.logger.error("agentContractGoodsList  -=-=-=-==  "+goodsList.size());
					for(TGoods goods:goodsList){
						TOrgGoodsCategory orgGoodsCat = new TOrgGoodsCategory();
						orgGoodsCat.setDConfirmDate(date);
						orgGoodsCat.setDCreateDate(date);
						orgGoodsCat.setDLastUpdateTime(date);
						orgGoodsCat.setNGoodsID(goods.getNGoodsID());
						orgGoodsCat.setSCategoryNO(category.getSCategoryNO());
						orgGoodsCat.setSConfirmUser(SecurityContextUtil.getUserName());
						orgGoodsCat.setSCreateUser(SecurityContextUtil.getUserName());
						orgGoodsCat.setSOrgNO(category.getSOrgNO());
						orgGoodsCat.setSScopeType(category.getSScopeType());
						orgGoodsCat.setSScopeTypeID(category.getSScopeTypeID());
						orgGoodsCatList.add(orgGoodsCat);
					}
				}
				jdbcTemplate.save(category);
			}
			if(orgGoodsCatList!=null && orgGoodsCatList.size() > 0){
				U.logger.error("orgGoodsCatList  ==-=-=-=-=-    "+orgGoodsCatList.size());
				jdbcTemplate.batchSave(orgGoodsCatList);
			}
		} catch (Exception e) {
			U.logger.error(e);
			return Egox.egoxErr().setReturnValue("商品分类数据保存失败").getMap();
		}
		return Egox.egoxOk().setReturnValue("商品数据保存成功").getMap();
	}
	
	@Override
	public Map<String, Object> updateCategory(TOrgCategory category, String cateItems) {
		try {
			
			Date date = new Date();
			List<TOrgGoodsCategory> orgGoodsCatList = new ArrayList<TOrgGoodsCategory>();
			StringBuffer sb = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			for(String obj : cateItems.split("-")){
				String[] cate = obj.split(",");
				
				String sql = "select count(*) from tOrgCategory t where t.sOrgNO = ? and t.sScopeTypeID = ? and t.sCategoryNO = ?";
				Long count = jdbcTemplate.queryForLong(sql, category.getSOrgNO(), category.getSScopeTypeID(), cate[0]);
				if(count == 0){
					category.setSCategoryNO(cate[0]);
					category.setSCategoryDesc(cate[1]);
					category.setNCategoryLevel(Integer.parseInt(cate[2]));
					category.setSUpCategoryNO(cate[3]);
					category.setNTag(0);
					
					category.setSCreateUser(SecurityContextUtil.getUserName());
					category.setDCreateDate(date);
					
					category.setSConfirmUser(SecurityContextUtil.getUserName());
					category.setDConifrmDate(date);
					
					category.setDLastUpdateTime(date);
					jdbcTemplate.save(category);
				}
				

				if(GoodsContants.GOODS_CAT_LEVEL_ONE.equals(cate[2].toString())){
					List<TGoods> goodsList = jdbcTemplate.queryForBeans("select * from tGoods where sCategoryNO = ?", TGoods.class, cate[0]);
					U.logger.error("agentContractGoodsList  -=-=-=-==  "+goodsList.size());
					for(TGoods goods:goodsList){
						TOrgGoodsCategory orgGoodsCat = new TOrgGoodsCategory();
						orgGoodsCat.setDConfirmDate(date);
						orgGoodsCat.setDCreateDate(date);
						orgGoodsCat.setDLastUpdateTime(date);
						orgGoodsCat.setNGoodsID(goods.getNGoodsID());
						orgGoodsCat.setSCategoryNO(cate[0]);
						orgGoodsCat.setSConfirmUser(SecurityContextUtil.getUserName());
						orgGoodsCat.setSCreateUser(SecurityContextUtil.getUserName());
						orgGoodsCat.setSOrgNO(category.getSOrgNO());
						orgGoodsCat.setSScopeType(category.getSScopeType());
						orgGoodsCat.setSScopeTypeID(category.getSScopeTypeID());
						int i = jdbcTemplate.queryForInt("select count(1) from tOrgGoodsCategory WHERE nGoodsID = ? and sOrgNO =? and sScopeTypeID = ? ", goods.getNGoodsID(),category.getSOrgNO(),category.getSScopeTypeID());
						if(i==0){
							orgGoodsCatList.add(orgGoodsCat);
						}
					}
					sb2.append(cate[0]+",");
				}
				
				sb.append(cate[0]+",");
			}
			if(orgGoodsCatList!=null && orgGoodsCatList.size() > 0){
				jdbcTemplate.batchSave(orgGoodsCatList);
			}
			System.out.println("===="+sb.toString());
			System.out.println("===="+sb2.toString());
			if(U.isNotEmpty(sb)){
				jdbcTemplate.execute("delete from tOrgCategory where sOrgNO = '"+category.getSOrgNO()+"' and sScopeTypeID = '"+category.getSScopeTypeID()+"' and sCategoryNO not in('"+(sb.toString().substring(0,sb.toString().length()-1)).replace(",", "','")+"')");
			}
			if(U.isNotEmpty(sb2)){
				//删除没选中的分类下的tOrgGoodsCategory
				jdbcTemplate.execute("delete from tOrgGoodsCategory where sOrgNO = '"+category.getSOrgNO()+"' and sScopeTypeID = '"+category.getSScopeTypeID()+"' and sCategoryNO not in('"+(sb2.toString().substring(0,sb2.toString().length()-1)).replace(",", "','")+"')");
			}
		} catch (Exception e) {
			U.logger.error(e);
			return Egox.egoxErr().setReturnValue("商品分类数据保存失败").getMap();
		}
		return Egox.egoxOk().setReturnValue("商品分类数据保存成功").getMap();
	}

	@Override
	public Map<String, Object> deleteCategory(String cateItems) {
		try {
			StringBuffer sb1 = new StringBuffer();
			StringBuffer sb2 = new StringBuffer();
			
			if(cateItems.indexOf(",") > -1){
				for(String obj : cateItems.split(",")){
					String[] cate = obj.split("-");
					sb1.append(cate[0]+",");
					sb2.append(cate[1]+",");
				}
			}else{
				String[] cate = cateItems.split("-");
				sb1.append(cate[0]+",");
				sb2.append(cate[1]+",");
			}
			
			jdbcTemplate.execute("delete from tOrgCategory where sOrgNO in ('"+(sb1.toString().substring(0,sb1.toString().length()-1)).replace(",", "','")+"') and sScopeTypeID in ('"+(sb2.toString().substring(0,sb2.toString().length()-1)).replace(",", "','")+"')");
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("商品分类数据删除失败",e);
			return Egox.egoxErr().setReturnValue("商品分类数据删除失败").getMap();
		}
		return Egox.egoxOk().setReturnValue("商品分类数据删除成功").getMap();
	}

	@Override
	public Map<String, Object> queryCategoryByParam(String sOrgNO, String sScopeTypeID) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<Map<String, Object>> list = jdbcTemplate.queryForList("select sOrgNO,sOrgName,sScopeTypeID,sScopeType,sCategoryNO from tOrgCategory where sOrgNO = ? and sScopeTypeID = ?", sOrgNO, sScopeTypeID);
			StringBuffer sb = new StringBuffer("");
			for(int i=0,length=list.size(); i<length; i++){
				if(i == 0){
					Map<String, Object> mapObj = new HashMap<String, Object>(); 
					mapObj.put("sOrgNO", list.get(0).get("sOrgNO"));
					mapObj.put("sOrgName", list.get(0).get("sOrgName"));
					mapObj.put("sScopeTypeID", list.get(0).get("sScopeTypeID"));
					mapObj.put("sScopeType", list.get(0).get("sScopeType"));
					
					map.put("category", mapObj);
				}
				sb.append("["+list.get(i).get("sCategoryNO")+"],");
			}
			map.put("items", sb.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据区域编号和店铺类型查询商品分类数据失败");
		}
		return map;
	}
	
	/**
	 * 根据区域ID和店铺类型，获取所有的商品分类
	 * @param sOrgNo
	 * @param sScopeTypeID
	 * @return
	 */
	public List<Category> queryCategoryForTpl(String sOrgNo,String sScopeTypeID){
		List<Category> categoryList=new ArrayList<Category>();
		try {
			StringBuffer sql = new StringBuffer("select t.* from tOrgCategory t where 1=1");
			sql.append(" and t.sOrgNO = '"+sOrgNo+"'");
			sql.append(" and t.sScopeTypeID = '"+sScopeTypeID+"'");
			
			List<Map<String, Object>> result = jdbcTemplate.queryForList(sql.toString());
			for (Map<String, Object> map : result) {
				String sUpCategoryNO=map.get("sUpCategoryNO").toString();
				if("00".equals(sUpCategoryNO)){
					Category category=new Category();
					category.setId(map.get("sCategoryNO").toString());
					category.setName(map.get("sCategoryDesc").toString());
					categoryList.add(category);
					loadChildenCategory(category,result);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("分类信息查询失败");
		}
		return categoryList;
	}

	/**
	 * 递归获取子分类
	 * @param parentCategory
	 * @param mapList
	 */
	private void loadChildenCategory(Category parentCategory, List<Map<String, Object>> mapList) {
		List<Category> categoryList=new ArrayList<Category>();
		for (Map<String, Object> map : mapList) {
			String sUpCategoryNO=map.get("sUpCategoryNO").toString();
			if(parentCategory.getId().equals(sUpCategoryNO)){
				Category category=new Category();
				category.setId(map.get("sCategoryNO").toString());
				category.setName(map.get("sCategoryDesc").toString());
				categoryList.add(category);
				loadChildenCategory(category,mapList);
			}
		}
		parentCategory.setChildren(categoryList);
		
	}

	@Override
	public List<Org> queryOrg() {
		List<Org> orgList = new ArrayList<Org>();
		try {
			String sql = "select t.* from tOrg t where t.nOrgLevel in(2,3,4)";
			List<Map<String, Object>> result = jdbcTemplate.queryForList(sql.toString());
			for (Map<String, Object> map : result) {
				String nOrgLevel = map.get("nOrgLevel").toString();
				if("2".equals(nOrgLevel)){
					Org org = new Org();
					org.setId(map.get("sOrgNo").toString());
					org.setName(map.get("sOrgDesc").toString());
					orgList.add(org);
					loadChildenOrg(org,result);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("区域信息查询失败");
		}
		return orgList;
	}

	/**
	 * 递归获取子区域
	 * @param org
	 * @param mapList
	 */
	private void loadChildenOrg(Org parentOrg, List<Map<String, Object>> mapList) {
		List<Org> orgList = new ArrayList<Org>();
		for (Map<String, Object> map : mapList) {
			String sUpOrgNO = map.get("sUpOrgNO").toString();
			if(parentOrg.getId().equals(sUpOrgNO)){
				Org childOrg = new Org();
				childOrg.setId(map.get("sOrgNo").toString());
				childOrg.setName(map.get("sOrgDesc").toString());
				orgList.add(childOrg);
				loadChildenOrg(childOrg,mapList);
			}
		}
		parentOrg.setChildren(orgList);
	}

	@Override
	public Map<String, Object> queryCategoryTree() {
		try {
			String  sql_level3="select * from tCategory where nCategoryLevel = 3  and nTag&1 = 0";
			String  sql_level2="select * from tCategory where nCategoryLevel = 2  and nTag&1 = 0";
			String  sql_level1="select * from tCategory where nCategoryLevel = 1  and nTag&1 = 0";
			
			List<Map<String, Object>> list_level3 =  jdbcTemplate.queryForList(sql_level3);
			List<Map<String, Object>> list_level2 =  jdbcTemplate.queryForList(sql_level2);
			List<Map<String, Object>> list_level1 =  jdbcTemplate.queryForList(sql_level1);
			
			List<CategoryDto> cdtoList3 = new ArrayList<CategoryDto>(); 
			if(list_level3 != null && list_level3.size()>0){
				for(Map<String,Object> level3:list_level3){
				  String sCategoryNO3=  level3.get("sCategoryNO")+"" ;
				  CategoryDto  cdto3 = new CategoryDto();
				  cdto3.setScategoryNO(sCategoryNO3);
				  cdto3.setScategoryName(level3.get("sCategoryDesc")+"");
				  cdto3.setSupCategoryNO(level3.get("sUpCategoryNO")+"");
				  cdto3.setLevel((int)level3.get("nCategoryLevel"));
				  
				  
				  List<CategoryDto> cdtoList2 = new ArrayList<CategoryDto>(); 
				  if(list_level2 != null && list_level2.size()>0){
					  
						for(Map<String,Object> level2:list_level2){
							String sUpCategoryNO2 = level2.get("sUpCategoryNO")+"";
							if(sUpCategoryNO2.equals(sCategoryNO3)){
								  String sCategoryNO2=  level2.get("sCategoryNO")+"" ;
								  CategoryDto  cdto2 = new CategoryDto();
								  cdto2.setScategoryNO(sCategoryNO2);
								  cdto2.setScategoryName(level2.get("sCategoryDesc")+"");
								  cdto2.setSupCategoryNO(level2.get("sUpCategoryNO")+"");
								  cdto2.setLevel((int)level2.get("nCategoryLevel"));
								  List<CategoryDto> cdtoList1 = new ArrayList<CategoryDto>(); 
								  if(list_level1 != null && list_level1.size()>0){ 
										for(Map<String,Object> level1:list_level1){
											String sUpCategoryNO1 = level1.get("sUpCategoryNO")+"";
											if(sUpCategoryNO1.equals(sCategoryNO2)){
												  CategoryDto  cdto1 = new CategoryDto();
												  cdto1.setScategoryNO(level1.get("sCategoryNO")+"");
												  cdto1.setScategoryName(level1.get("sCategoryDesc")+"");
												  cdto1.setSupCategoryNO(level1.get("sUpCategoryNO")+"");
												  cdto1.setLevel((int)level1.get("nCategoryLevel"));
												  cdtoList1.add(cdto1);
											}
										}
								  }
								  cdto2.setChild(cdtoList1); 
								  cdtoList2.add(cdto2);
							}
							
						}
				  }
				  cdto3.setChild(cdtoList2);
				  cdtoList3.add(cdto3);
				}
			}
			return Egox.egoxOk().setDataList(cdtoList3).getMap();
		} catch (Exception e) {
			U.logger.error("获取三级分类树JSON数据失败",e);
			return Egox.egoxErr().setReturnValue("获取三级分类树JSON数据失败").getMap();
		}
	}

	@Override
	public List<Map<String, Object>> queryCategorys(String cateItems) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			
			Map<String, Object> map = null;
			
			for(String obj : cateItems.split(",")){
				
				map = new HashMap<String, Object>();
				
				String[] cate = obj.split("-");
				List<Category> category = queryCategoryForTpl(cate[0], cate[1]);
				
				String sql = "select sOrgName,sScopeType from tOrgCategory t where t.sOrgNO = ? and t.sScopeTypeID = ? group by sOrgName,sScopeType";
				Map<String, Object> cateMap = jdbcTemplate.queryForMap(sql, cate[0], cate[1]);
				
				map.put("sOrgName", cateMap.get("sOrgName"));
				map.put("sScopeType", cateMap.get("sScopeType"));
				map.put("category", category);
				
				list.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("商品分类数据查询失败",e);
		}
		
		return list;
	}
	
	 
}
