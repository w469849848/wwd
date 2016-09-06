package com.egolm.goods.web;

import java.io.Writer;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.egolm.goods.api.TCategoryQueryApi;

/**
 * 
 * @Title: 分类控制器
 * @Description:
 * @author zhangyong
 * @date 2016年4月15日 下午5:40:05
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/goods/catgory")
public class TCategoryController {
	@Resource(name = "tCategoryQueryApi")
	private TCategoryQueryApi tCategoryQueryApi;
	
	@RequestMapping(value="/categoryJsonTree")
	public void categoryJsonTree(HttpServletRequest request,Writer writer){
		try {
			Map<String,Object> dataMap = tCategoryQueryApi.queryCategoryTree();
			boolean result = (boolean)dataMap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList"); 
				Egox.egoxOk().setDataList(dataList).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("分类结构数据加载失败").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("分类结构数据加载异常",e);
			Egox.egoxErr().setReturnValue("分类结构数据加载异常").write(writer);
		}
	}
}
