package com.egolm.promo;

import java.io.IOException;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.plugin.web.As;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.domain.TYWPromoPicSet;
import com.egolm.promo.service.PromoServiceImpl;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.utils.HttpHandler;

@Controller
@RequestMapping("/promoPicSet")
public class PromoPicSetController {
	@Autowired
	private TOrgsQueryApi  tOrgsQueryApi;
	@Autowired
	private PromoServiceImpl PromoServiceImpl;
	
	public static String HTTP_PROMO_MAIN=HttpHandler.HTTP_HOST+"/egolm-open-web/api/tpl/queryPromoMain";
	
	//上传环境
	private String uploadEnv = ConfigReader.getProperty(ConfigPath.cpath("G:system.properties"), "path.sftp.env", "test");
 	 
	@RequestMapping("/list")
	public String list(@As("page")Page page, HttpServletRequest request) {
		if(page == null) {
			page = new Page();
		}
		page.setLimit(20);
		page.setLimitKey("dUpdateDate desc");
		TYWPromoPicSet promoPicSet = new TYWPromoPicSet();
		String sOrgNO = request.getParameter("sOrgNO");
		String sOrgDesc = request.getParameter("sOrgDesc");
		String sDisplayNO = request.getParameter("sDisplayNO");
		String sDisplayDesc = request.getParameter("sDisplayDesc");
		
		if(U.isNotEmpty(sOrgNO)){
			promoPicSet.setsOrgNO(sOrgNO);
		}
		if(U.isNotEmpty(sOrgDesc)){
			promoPicSet.setsOrgDesc(sOrgDesc);
		}
		if(U.isNotEmpty(sDisplayNO)){
			promoPicSet.setsDisplayNO(sDisplayNO);
		}
		if(U.isNotEmpty(sDisplayDesc)){
			promoPicSet.setsDisplayDesc(sDisplayDesc);
		}
		
		List<String> orgs = SecurityContextUtil.getRegionIds();
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromosPicSet(promoPicSet, orgs, page);
		request.setAttribute("page", page);
		request.setAttribute("datas", datas);
		
 		List<Map<String, Object>> orgList = tOrgsQueryApi.queryTOrgs(orgs, 4);
		request.setAttribute("orgList", orgList);
		request.setAttribute("promoPicSet", promoPicSet);
		return "/promo/picSet/promo-picSet-list.jsp";
	}
	
	@RequestMapping("/add")
	public void add(@RequestParam(value = "filePath", required = false) MultipartFile file,HttpServletRequest request, Writer writer) {
		try {
			Date now = new Date();
			TYWPromoPicSet promoPicSet = new TYWPromoPicSet();
			String sOrgNO = request.getParameter("sOrgNO");
			String sOrgDesc = request.getParameter("sOrgDesc");
			String sDisplayNO = request.getParameter("sDisplayNO");
			String sDisplayDesc = request.getParameter("sDisplayDesc");
			String sScopeTypeID = request.getParameter("sScopeTypeID");
			String sScopeType = request.getParameter("sScopeType");
			String sBackgroundColour = request.getParameter("sBackgroundColour");
			String nId = request.getParameter("nId"); 
			
			
			
			promoPicSet.setsOrgDesc(sOrgDesc);
			promoPicSet.setsOrgNO(sOrgNO);
			promoPicSet.setsDisplayDesc(sDisplayDesc);
			promoPicSet.setsDisplayNO(sDisplayNO);
			promoPicSet.setsScopeType(sScopeType);
			promoPicSet.setsScopeTypeID(sScopeTypeID);
			promoPicSet.setsBackgroundColour(sBackgroundColour);
			
			promoPicSet.setnTag(0);
			if(!U.isNotEmpty(nId)){ //判断 区域和使用范围 是否存在相同的配置  防止出现一个区域，一个使用范围 出现多条重复数据
				List<Map<String, Object>> queryList = PromoServiceImpl.queryPromosPicSetByOrgAndDisplayNo(promoPicSet);
				if(queryList.size()>0){
					Egox.egoxErr().setReturnValue("添加失败,已存在区域为:"+sOrgDesc+",使用范围为:"+sDisplayDesc+"的配置.").write(writer);
					return;
				}
			}
			 
			boolean isUploadPic = false;
			if(file != null){
				String fileName = file.getOriginalFilename();
				if(StringUtil.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.PROMO_PATH+""+uploadEnv+"/"+sOrgNO+"/"+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream()); 
					OSSUtils.closeOssClient(); 
 					promoPicSet.setsBackgroundPicUrl("/"+key); 
 					isUploadPic = true;
				}				
			}
			if(U.isNotEmpty(nId)){
				promoPicSet.setnId(Integer.valueOf(nId));
				
				TYWPromoPicSet updatePromoPicSet= (TYWPromoPicSet)PromoServiceImpl.queryByPk(promoPicSet);
				if(updatePromoPicSet != null){
					promoPicSet.setsCreateUser(updatePromoPicSet.getsCreateUser());
					promoPicSet.setdCreateDate(updatePromoPicSet.getdCreateDate());
					promoPicSet.setsUpdateUser(SecurityContextUtil.getUserName());
					promoPicSet.setdUpdateDate(now);
					if(!isUploadPic){
						promoPicSet.setsBackgroundPicUrl(updatePromoPicSet.getsBackgroundPicUrl());
					}
					
					PromoServiceImpl.update(promoPicSet);
					Egox.egoxOk().setReturnValue("活动背景数据更新成功").write(writer);
				}else{
					Egox.egoxErr().setReturnValue("活动背景数据更新失败").write(writer);
				}
				
				
			}else{
				promoPicSet.setsCreateUser(SecurityContextUtil.getUserName());
				promoPicSet.setdCreateDate(now);
				promoPicSet.setdUpdateDate(now);
				promoPicSet.setsUpdateUser(SecurityContextUtil.getUserName());
				PromoServiceImpl.save(promoPicSet);
				Egox.egoxOk().setReturnValue("活动背景数据新增成功").write(writer);
			}
			
		} catch (IOException e) {
			U.logger.error("活动背景数据操作失败",e);
			Egox.egoxErr().setReturnValue("活动背景数据操作失败").write(writer);
		}  
	}
	
	@RequestMapping("/delete")
	public void delete(HttpServletRequest request, Writer writer){
		try {
			String nId = request.getParameter("nId");
			TYWPromoPicSet promoPicSet = new TYWPromoPicSet();
			promoPicSet.setnId(Integer.valueOf(nId)); 
			promoPicSet= (TYWPromoPicSet)PromoServiceImpl.queryByPk(promoPicSet);
			promoPicSet.setnTag(1);
			promoPicSet.setdUpdateDate(new Date());
			promoPicSet.setsUpdateUser(SecurityContextUtil.getUserName());
			PromoServiceImpl.update(promoPicSet); 
			Egox.egoxOk().setReturnValue("删除成功").write(writer);
		} catch (Exception e) {
			U.logger.error("背景图片删除失败",e);
			Egox.egoxOk().setReturnValue("删除失败").write(writer);
		}
	}
	
	
	@RequestMapping("/addIndex")
	public String addIndex(){
		return "/promo/picSet/promo-picSet-add.jsp";
	}
	@RequestMapping("/loadIndex")
	public String loadIndex(HttpServletRequest request){
		String nId = request.getParameter("nId");
		TYWPromoPicSet promoPicSet = new TYWPromoPicSet();
		promoPicSet.setnId(Integer.valueOf(nId)); 
		promoPicSet= (TYWPromoPicSet)PromoServiceImpl.queryByPk(promoPicSet);
		request.setAttribute("promoPicSetData", promoPicSet);
		return "/promo/picSet/promo-picSet-add.jsp";
	}
	
	
	
	@RequestMapping("/showIndex")
	public String showIndex(HttpServletRequest request){
		String nId = request.getParameter("nId");
		String displayNo = request.getParameter("displayNo");
		request.setAttribute("nId",  nId);
		if(displayNo.equals("web")){
			return "/promo/picSet/promo-picSet-web-show.jsp";
		}
		if(displayNo.equals("wx")){
			return "/promo/picSet/promo-picSet-wx-show.jsp";
		}
		return "404.jsp";
	}
	
	@RequestMapping("/show")
	public void show(HttpServletRequest request, Writer writer){
		try {
			String nId = request.getParameter("nId");
			TYWPromoPicSet promoPicSet = new TYWPromoPicSet();
			promoPicSet.setnId(Integer.valueOf(nId)); 
			promoPicSet= (TYWPromoPicSet)PromoServiceImpl.queryByPk(promoPicSet);
			
			Map<String,String> paramMap = new HashMap<String,String>();
			paramMap.put("orgNO", promoPicSet.getsOrgNO());
			paramMap.put("terminalTypeID", promoPicSet.getsDisplayNO());
			paramMap.put("pageCount", "10");
			paramMap.put("pageIndex", "1");
			JSONObject json = HttpHandler.post(HTTP_PROMO_MAIN,paramMap); 
			Egox.egox(json).write(writer);
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("图片数据获取失败").write(writer);
		}
	}
}
