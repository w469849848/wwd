package com.egolm.tpl.generator;

import java.io.FileWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.Velocity;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.U;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.EgolmException;
import com.egolm.domain.TYWTplManage;
import com.egolm.tpl.generator.bean.Floornav;
import com.egolm.tpl.service.TplService;

/**
 * 静态页面生成定时任务，可以配置在每天早上3点生成一次
 * @author zhangzhi
 *
 */
public class TemplateHtmlGenerator {
	
	private String prefix;//存入redis Key前缀
	private Map<String, ModuleGenerator> moduleConfig; //配置各个模块对应的代码生成实现类
	
	@Autowired
	private TplService tplService;
	@Autowired
	private RedisTemplate redisTemplate;
	
	List<Floornav> floornavList=new ArrayList<Floornav>(); //首页右侧固定楼层导航条
	int floorNum=1;
	
	
	public String preview(String sTplNo) throws Exception{
		
		TYWTplManage tplManage= tplService.queryTemplateById(sTplNo);
		
		String pageType=tplManage.getNIsHome().toString();//1表示首页，0表示专区页面
		String zone=tplManage.getSBelongNo();
		if(U.isBlank(pageType)||U.isBlank(zone)){
			throw new RuntimeException("错误提示：模板的页面类型或者所属区域为空。");
		}
		
		StringBuffer html=new StringBuffer();
		//查询每个模板对应的模块清单,并将其生成html模块页面
		List<Map<String, Object>> moduleList = tplService.queryFullModulesBySTplNo(sTplNo);
		for (Map<String, Object> module : moduleList) {
			String modulehtml= generator(module,zone,tplManage.getSScopeTypeID());
			html.append(modulehtml);
		}
		//如果当前页面模板中有楼层，则需要生成页面右侧导航栏
		if(floornavList.size()>0){
			String modulehtml=generatorFloorNav();
			html.append(modulehtml);
		}
		floornavList.clear();//一个模板生成完后，楼层内容重置为空.
		floorNum=1;//一个模板生成完后，楼层数量要重置为0.
		
		//测试用于存在到单独的文件中
		/*
		FileWriter fileWriter=new FileWriter("d:/"+sTplNo+".html",false);
		fileWriter.write(html.toString());
		fileWriter.close();
		*/
		return html.toString();
	}
	
	
	/**
	 * 定时任务将所有模板都生成一次
	 * @throws Exception
	 */
	public void execute() throws Exception{
		
		//redis KEY格式 ：前缀.页面类型.区域编码.主键ID
		//例如：COM.EGOLM.OPS.TPL.1.HNZU.65bf4373-9ac2-418c-aa25-318bac7c6005
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("nTag", "1");
		PageSqlserver page=new PageSqlserver();
		page.setIndex(1l);
		page.setLimit(1000);
		page.setLimitKey("sTplNo DESC");
		Map<String, Object> templates = tplService.queryTemplates(map, page);
		
		//循环查询所有n已发布状态的页面模板配置数据
		List<Map<String, Object>> templateList=(List<Map<String, Object>>) templates.get("result");
		for (Map<String, Object> template : templateList) {
			floornavList.clear();//一个模板生成完后，楼层内容重置为空.
			floorNum=1;//一个模板生成完后，楼层数量要重置为0.
			try{
				String pageType=template.get("nIsHome").toString();//1表示首页，0表示专区页面
				String zone=(String) template.get("sBelongNo");
				String sScopeTypeID=(String) template.get("sScopeTypeID");
				String sTplNo=(String) template.get("sTplNo");
				if(U.isBlank(pageType)||U.isBlank(zone)){
					throw new RuntimeException("错误提示：模板的页面类型或者所属区域为空。");
				}
				String key="."+pageType+"."+zone+"."+sTplNo;
				
				StringBuffer html=new StringBuffer();
				//查询每个模板对应的模块清单,并将其生成html模块页面
				List<Map<String, Object>> moduleList = tplService.queryFullModulesBySTplNo(sTplNo);
				for (Map<String, Object> module : moduleList) {
					String modulehtml= generator(module,zone,sScopeTypeID);
					html.append(modulehtml);
				}
				//如果当前页面模板中有楼层，则需要生成页面右侧导航栏
				if(floornavList.size()>0){
					String modulehtml=generatorFloorNav();
					html.append(modulehtml);
				}
				
				//测试用于存在到单独的文件中
				/*
				FileWriter fileWriter=new FileWriter("d:/"+sTplNo+".html",false);
				fileWriter.write(html.toString());
				fileWriter.close();
				*/
				//prefix+区域编号+店铺类型+index
				//首页：COM.EGOLM.OPS.TPL.PAGESUZU.1.INDEX
				//专区页面：COM.EGOLM.OPS.TPL.PAGESUZU.f9b6b429-3eef-45ff-abfb-8b341e2969ea
				//将页面存储到redis缓存中
				if("1".equals(pageType)){
					//如果是首页，就存两个KEY，第二个key将做为专区Key用于给其它首页调用
					redisTemplate.opsForHash().put(prefix, zone+"."+sScopeTypeID+".INDEX", html.toString());
					redisTemplate.opsForHash().put(prefix,zone+"."+sTplNo, html.toString());
					System.out.println("redis key=="+prefix+zone+"."+sScopeTypeID+".INDEX");
					System.out.println("redis key=="+prefix+zone+"."+sTplNo);
				}else{
					redisTemplate.opsForHash().put(prefix,zone+"."+sTplNo, html.toString());
					System.out.println("redis key=="+prefix+zone+"."+sTplNo);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
	}
	
	private String generator(Map<String, Object> module, String zone, String sScopeTypeID) throws Exception{
		String sLayoutContent=(String) module.get("sLayoutContent");
		String sModuleNo=(String) module.get("sModuleNo");
		String nIsFloor=(String) module.get("nIsFloor");
		String sPcPath=(String) module.get("sPcPath");
		String sWxPath=(String) module.get("sWxPath");
		if(U.isBlank(sPcPath)){
			System.err.println(sModuleNo+"模块配置缺少模块配置文件sPcPath");
			return "";
			
		}
		if(U.isBlank(sLayoutContent)){
			System.err.println(sModuleNo+"模块配置缺少模块配置数据sLayoutContent");
			return "";
		}
		VelocityEngine ve = new VelocityEngine();
		ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
		ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
		ve.setProperty(Velocity.ENCODING_DEFAULT, "UTF-8");
		ve.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
		ve.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");  
		ve.init();
		Template t = ve.getTemplate(sPcPath);
		VelocityContext ctx = new VelocityContext();
		ModuleGenerator moduleGenerator=getModuleGeneratorInstance(sPcPath);
		JSONObject jsonRoot = JSON.parseObject(sLayoutContent);
		
		//如果当前模块是楼层，则生成右侧固定导航条
		String floorId=null;
		if("是".equals(nIsFloor)){
			Floornav floornav=new Floornav();
			floorId="floor"+(floorNum);
			floornav.setFloorName(jsonRoot.getString("floorName"));
			floornav.setFloorId(floorId);
			floornav.setFloorNum(floorNum+"F");
			floornavList.add(floornav);
			floorNum++;
		}
		moduleGenerator.generate(ctx,jsonRoot,zone,floorId,sScopeTypeID);
		StringWriter sw = new StringWriter();
		t.merge(ctx, sw);
		return sw.toString();
	}
	
	private String generatorFloorNav() throws Exception{
		
		VelocityEngine ve = new VelocityEngine();
		ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
		ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
		ve.setProperty(Velocity.ENCODING_DEFAULT, "UTF-8");
		ve.setProperty(Velocity.INPUT_ENCODING, "UTF-8");
		ve.setProperty(Velocity.OUTPUT_ENCODING, "UTF-8");  
		ve.init();
		Template t = ve.getTemplate("template/floornav.vm");
		VelocityContext ctx = new VelocityContext();
		ctx.put("floornavList", floornavList);
		StringWriter sw = new StringWriter();
		t.merge(ctx, sw);
		return sw.toString();
	}

	private ModuleGenerator getModuleGeneratorInstance(String sPcPath) {
		if(moduleConfig==null){
			throw new EgolmException("没有注入mouduleConfig属性");
		}
		ModuleGenerator moduleGenerator=moduleConfig.get(sPcPath);
		if(moduleGenerator==null){
			throw new EgolmException("没有配置模块【"+sPcPath+"】对应的生成对象");
		}
		return moduleGenerator;
	}
	
	

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public Map<String, ModuleGenerator> getModuleConfig() {
		return moduleConfig;
	}

	public void setModuleConfig(Map<String, ModuleGenerator> moduleConfig) {
		this.moduleConfig = moduleConfig;
	}


}
