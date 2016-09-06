package com.egolm.tpl.web;

import java.io.OutputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.egolm.common.enums.UserType;
import com.egolm.domain.TOrgCategory;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Org;
import com.egolm.tpl.service.CategoryService;
import com.egolm.tpl.service.TplService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	
	/*商品分类接口 */
	public static String HTTP_CATEGORY;

	@Autowired
	private CategoryService categoryService;
	@Autowired
	private TplService tplService;
	
	/**
	 * @description 分类列表
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page){
		ModelAndView mv = new ModelAndView("tpl/category-list.jsp");
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			
			page.setLimitKey(" sOrgName desc");
			
			String sOrgNO = request.getParameter("sOrgNO");
			String sOrgName = request.getParameter("sOrgName");
			String sScopeTypeID = request.getParameter("sScopeTypeID");
			String sScopeType = request.getParameter("sScopeType");
			
			List<Org> orgList = categoryService.queryOrg();
			
			//如果用户不是管理员和运营人员，则只显示当前人所属区域模板,查询条件下拉里面也仅显示一个区域
			if (!SecurityContextUtil.getUserType().oneOf(UserType.OPERATOR, UserType.ADMIN)) { // 
				sOrgNO = SecurityContextUtil.getRegionId();
				outer:for(Org org1 : orgList){
					for(Org org2 : org1.getChildren()){
						for(Org org3 : org2.getChildren()){
							if(org3.getId().equals(sOrgNO)){
								
								List<Org> orgList3 = new ArrayList<Org>();
								orgList3.add(org3);
								
								org2.setChildren(orgList3);
								List<Org> orgList2 = new ArrayList<Org>();
								orgList2.add(org2);
								
								org1.setChildren(orgList2);
								List<Org> orgList1 = new ArrayList<Org>();
								orgList1.add(org1);
								
								orgList.clear();
								orgList.add(org1);
								
								break outer;
								
							}
						}
					}
				}
			}
			
			request.setAttribute("orglist", JSONObject.toJSONString(orgList));
			
			mv.addObject("sOrgNO", sOrgNO);
			mv.addObject("sOrgName", sOrgName);
			mv.addObject("sScopeTypeID", sScopeTypeID);
			mv.addObject("sScopeType", sScopeType);
			if(U.isEmpty(sOrgName)){
				mv.addObject("sOrgNO", "");
				mv.addObject("sOrgName", "");
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			if(U.isNotEmpty(sOrgNO)){
				paramMap.put("sOrgNO", sOrgNO);
			}
			if(U.isNotEmpty(sScopeTypeID)){
				paramMap.put("sScopeTypeID", sScopeTypeID);
			}
			
			Map<String, Object> datas = categoryService.queryCategorys(paramMap, page);
			
			Page pageReturn = (Page) datas.get("page");
			mv.addObject("datas", datas);
			mv.addObject("page", pageReturn);
			
			Map<String, Object> scopedatas = tplService.queryScopeType("ScopeType");
			request.setAttribute("scopedatas", scopedatas);
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("分类信息查询异常", e);
		}
		return mv;
	} 
	
	/**
	 * @description 新增分类页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView toAdd(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("tpl/category-add.jsp");
		
		try {
			Map<String, Object> scopedatas = tplService.queryScopeType("ScopeType");
			request.setAttribute("scopedatas", scopedatas);
			
			List<Org> orgList = categoryService.queryOrg();
			//如果用户不是管理员和运营人员，则只显示当前人所属区域模板,查询条件下拉里面也仅显示一个区域
			if (!SecurityContextUtil.getUserType().oneOf(UserType.OPERATOR, UserType.ADMIN)) { // 
				outer:for(Org org1 : orgList){
					for(Org org2 : org1.getChildren()){
						for(Org org3 : org2.getChildren()){
							if(org3.getId().equals(SecurityContextUtil.getRegionId())){
								
								List<Org> orgList3 = new ArrayList<Org>();
								orgList3.add(org3);
								
								org2.setChildren(orgList3);
								List<Org> orgList2 = new ArrayList<Org>();
								orgList2.add(org2);
								
								org1.setChildren(orgList2);
								List<Org> orgList1 = new ArrayList<Org>();
								orgList1.add(org1);
								
								orgList.clear();
								orgList.add(org1);
								
								break outer;
								
							}
						}
					}
				}
			}
			request.setAttribute("orglist", JSONObject.toJSONString(orgList));
			
			Map<String, Object> categoryMap = categoryService.queryCategoryTree();
			request.setAttribute("categoryMap", categoryMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("进入分类信息新增页面异常", e);
		}
		
		return mv;
	}
	
	/**
	 * @description 修改分类页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public ModelAndView toUpdate(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/category-update.jsp");
		
		try {
			String sOrgNO = request.getParameter("sOrgNO");
			String sScopeTypeID = request.getParameter("sScopeTypeID");
			
			Map<String, Object> map = categoryService.queryCategoryByParam(sOrgNO, sScopeTypeID);
			request.setAttribute("cg", map.get("category"));
			request.setAttribute("items", map.get("items").toString());
			
			Map<String, Object> categoryMap = categoryService.queryCategoryTree();
			request.setAttribute("categoryMap", categoryMap);
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("进入分类信息编辑页面异常", e);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void saveAdd(HttpServletRequest request, Writer writer, TOrgCategory category){
		try {
			String cateItems = request.getParameter("cateItems");
			if(U.isBlank(cateItems)){
				Egox.egoxErr().setReturnValue("保存失败,未选择商品分类数据").write(writer);
			}
			
			Map<String, Object> map = categoryService.saveCategory(category, cateItems);
			Egox.egox(map).write(writer);
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("商品分类数据保存失败").write(writer);
		}
	}
	
	@RequestMapping(value="/update",method=RequestMethod.POST)
	public void saveUpdate(HttpServletRequest request, Writer writer, TOrgCategory category){
		try {
			String cateItems = request.getParameter("cateItems");
			if(U.isBlank(cateItems)){
				Egox.egoxErr().setReturnValue("保存失败,未选择商品分类数据").write(writer);
			}
			
			Map<String, Object> map = categoryService.updateCategory(category, cateItems);
			Egox.egox(map).write(writer);
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("商品分类数据保存失败").write(writer);
		}
	}
	
	/**
	 * @description 删除分类
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		try {
			String cateItems = request.getParameter("cateItems");
			Map<String, Object> map = categoryService.deleteCategory(cateItems);
			Egox.egox(map).write(writer);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("商品分类数据删除失败",e);
			Egox.egoxErr().setReturnValue("商品分类数据删除失败").write(writer);
		}
	}
	
	@RequestMapping(value="/export",method=RequestMethod.POST)
	public void export(HttpServletRequest request, HttpServletResponse response, Writer writer){
		try {
			String cateItems = request.getParameter("param");
			List<Map<String, Object>> map = categoryService.queryCategorys(cateItems);
			exportCategory(response, map);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("商品分类数据导出失败",e);
		}
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	/**
	 * @description 商品分类数据Excel导出
	 * @param response
	 * @param map 导出参数
	 */
	private void exportCategory(HttpServletResponse response, List<Map<String, Object>> map) throws Exception{
		try {      
            HSSFWorkbook wb = new HSSFWorkbook();      
            HSSFSheet sheet = wb.createSheet("分类数据");      
            HSSFCellStyle style = wb.createCellStyle(); // 样式对象      
     
            style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 垂直      
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 水平   
            sheet.setColumnWidth(0, 2500); 
            
            //表头
            HSSFRow row0 = sheet.createRow((short) 0);
            String[] headlist = {"区域","店铺类型","一级分类","二级分类","三级分类"};
            for(int i=0; i<headlist.length; i++){
            	 HSSFCell ce = row0.createCell(i);      
                 ce.setCellValue(headlist[i]); // 表格的第一行第一列显示的数据      
                 ce.setCellStyle(style); // 样式，居中      
            }
            
            HSSFRow row = null;
            HSSFCell ce = null;
      
            int begin = 0,
            	end = 0,
            	level = 0;
            
            for(int i=0; i<map.size(); i++){
            	Map<String, Object> mapObj = map.get(i);
            	String sOrgName = mapObj.get("sOrgName").toString();
            	String sScopeType = mapObj.get("sScopeType").toString();
            	List<Category> catelist = (List<Category>)mapObj.get("category");
            	//一级列表
            	for(int j=0; j<catelist.size(); j++ ){
            		
            		Category cate1 = catelist.get(j);
            		//一级分类名称
            		String cate1st = cate1.getName();
            		//二级列表
            		for(int k=0; k<cate1.getChildren().size(); k++){
            			
            			Category cate2 = cate1.getChildren().get(k);
                		//二级分类名称
                		String cate2nd = cate2.getName();
                		StringBuffer sb = new StringBuffer();
                		//三级列表
                		for(int p=0; p<cate2.getChildren().size(); p++){
                			Category cate3 = cate2.getChildren().get(p);
                    		//三级分类名称
                			sb.append(cate3.getName()+"、");
                		}
                		
                		row = sheet.createRow((short) (end + 1));
                		
                		ce = row.createCell(0);
                		ce.setCellValue(sOrgName);  
                		ce.setCellStyle(style);
                		
                		ce = row.createCell(1);
                		ce.setCellValue(sScopeType);  
                		ce.setCellStyle(style);
                		
                		ce = row.createCell(2);
                		ce.setCellValue(cate1st); 
                		ce.setCellStyle(style);
                		
                		ce = row.createCell(3);
                		ce.setCellValue(cate2nd);  
                		
                		ce = row.createCell(4);
                		ce.setCellValue(sb.toString().substring(0, sb.toString().lastIndexOf("、")));  
                		
                		end += 1;
                		
            		}
            		sheet.addMergedRegion(new Region((begin + 1), (short) 2, (begin + cate1.getChildren().size()), (short) 2));
            		begin = end;
            	}
            	sheet.addMergedRegion(new Region((level + 1), (short) 0, end, (short) 0));
            	sheet.addMergedRegion(new Region((level + 1), (short) 1, end, (short) 1));
            	level = end;
            }
           
            /**第二种是输出到也面中的excel名称 */
            response.reset();
            response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String("商品分类信息".getBytes("utf-8"), "ISO8859-1")
					+ ".xls");
			 
			 OutputStream outStream=null;    
			   
			 try{    
		        outStream = response.getOutputStream();    
		        wb.write(outStream);    
			 }catch(Exception e){    
			    e.printStackTrace();  
			    throw e;
			 }finally{    
			    outStream.close();    
			 }    
        } catch (Exception ex) {      
            ex.printStackTrace(); 
            throw ex;
        } 
	}
	
	
}
