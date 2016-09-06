
package com.egolm.base.web;

import java.io.Writer;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.egolm.base.api.TCommonQueryApi;

/**   
* @Title: TCommonController.java 
* @Package com.egolm.base.web 
* @Description: 数据字典 
* @author zhangyong  
* @date 2016年5月11日 上午9:45:35 
* @version V1.0   
*/
@Controller
@RequestMapping("/common")
public class TCommonController {
	@Resource(name = "tCommonQueryApi")
	private TCommonQueryApi  tCommonQueryApi;
	
	@RequestMapping(value="/queryByCommonNo")
	public void queryByCommonNo(HttpServletRequest request,Writer writer){
		String commonNo = request.getParameter("sCommonNo");
		if(U.isEmpty(commonNo)){
			Egox.egoxErr().setReturnValue("参数为空").write(writer);
			return;
		}
		
		Map<String,Object> dataMap = tCommonQueryApi.queryTCommonByNO(commonNo);
		Egox.egox(dataMap).write(writer);
	}
	
}
