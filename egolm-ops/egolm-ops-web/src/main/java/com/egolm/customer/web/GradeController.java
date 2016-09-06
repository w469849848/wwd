package com.egolm.customer.web;

import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.customer.api.IGradeInfo;
import com.egolm.domain.TCustGradeInfo;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @Title: 用户等级信息controller
 * @author TZH_PC
 *
 */
@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/grade")
public class GradeController extends BaseCustController {

	@Resource(name = "idGradeApi")
	private IGradeInfo gradeApi;

	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	@RequestMapping(value = "/leveList")
	public ModelAndView gradeList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			page.setLimitKey("nRequiredIntegral asc");
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TCustGradeInfo");
			Map<String, Object> resultmap = gradeApi.queryTCustGradeInfo(params, page);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

		} catch (Exception e) {
			U.logger.error("用户等级信息查询请求出错,", e);
		}
		return new ModelAndView("/customer/grade-manage.jsp", map);
	}

	/**
	 * 进入新增等级页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddGrade")
	public String toAddCustomer(HttpServletRequest request) {

		return "/customer/add-leve.jsp";
	}
	
	/**
	 * 进入修改等级页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toEditLeve",method=RequestMethod.GET)
	public ModelAndView toEditModulePage(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("customer/add-leve.jsp");
		String sLeveNO=request.getParameter("sLeveNO");
		try {
			TCustGradeInfo leveInfo = gradeApi.findById(sLeveNO);
			request.setAttribute("leveInfo", leveInfo);
		} catch (Exception e) { 
			U.logger.error("新建模块出错失败", e);
		}
		return mv;
	}
	

	/**
	 * 保存新建或修改等级
	 */
	@RequestMapping(value = "/addOrUpdateLeve", method = RequestMethod.POST)
	public void saveModule(@RequestParam(value = "sLeveIcon", required = false) MultipartFile file,
			HttpServletRequest request, Writer writer) {
		try {
			TCustGradeInfo grade = new TCustGradeInfo();
			grade.setNTag(0);
			grade.setSLeveType(request.getParameter("sLeveType"));
			grade.setSLeveNO(request.getParameter("sLeveNO"));
			grade.setNRequiredIntegral(Integer.valueOf(request.getParameter("nRequiredIntegral")));
			grade.setDLastUpdateTime(new Date());
			grade.setSConfirmUser(SecurityContextUtil.getUserId());
			
			// 文件上传
			if (file != null) {
				String fileName = file.getOriginalFilename();
				if (U.isNotEmpty(fileName)) {
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.LEVE_PATH + OSSUtils.getFileNewName(fileName);
					// 上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					// 获取图片路径
					String filePath = OSSUtils.getImgURl(key, bucketName);
					filePath = filePath.substring(0, filePath.indexOf("?"));
					OSSUtils.closeOssClient();
					grade.setSLeveIcon(filePath);
				}
			}

			// 如果没有新上传文件，尝试获取上次上传的文件路径
			if (grade.getSLeveIcon() == null) {
				grade.setSLeveIcon(request.getParameter("sLeveIcon"));
			}

			Map<String, Object> resultMap = gradeApi.saveLeve(grade,SecurityContextUtil.getUserId());
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			U.logger.error("保存会员等级出错失败", e);
			Egox.egoxErr().setReturnValue("保存会员等级出错失败").write(writer);
		}
	}
	
	/**
	 * 删除会员等级
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		String sLeveNO = request.getParameter("sLeveNO");
		try {
			Map<String,Object> resultMap = gradeApi.deleteLeve(sLeveNO);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("删除会员等级出错失败", e);
			Egox.egoxErr().setReturnValue("删除会员等级出错失败").write(writer);
		}
	}
	
	/**
	 * 修改等级状态
	 * @return
	 */
	@RequestMapping(value="/updateTag",method=RequestMethod.POST)
	public void status(HttpServletRequest request,Writer writer){
		String sLeveNO = request.getParameter("sLeveNO");
		String nTag=request.getParameter("nTag");
		try {
			Map<String,Object> resultMap = gradeApi.updateCustTag(sLeveNO,Integer.valueOf(nTag));
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("修改等级状态失败", e);
			Egox.egoxErr().setReturnValue("修改等级状态失败").write(writer);
		}
	}
}
