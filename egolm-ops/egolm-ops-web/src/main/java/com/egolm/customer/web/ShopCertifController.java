package com.egolm.customer.web;

import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
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
import com.egolm.common.cust.CustContants;
import com.egolm.customer.api.IShopCertif;
import com.egolm.customer.api.IShopCertifPic;
import com.egolm.customer.api.IShopInfo;
import com.egolm.domain.TShopCertif;
import com.egolm.domain.TShopCertifPic;
import com.egolm.domain.TShopInfo;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @Title: 门店店铺证照信息controller
 * @author TZH_PC
 *
 */
@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/certif")
public class ShopCertifController extends BaseCustController {

	@Resource(name = "idShopCertifApi")
	private IShopCertif shopCertifApi;

	@Resource(name = "idShopCertifPicApi")
	private IShopCertifPic shopCertifPicApi;

	@Resource(name = "idShopApi")
	private IShopInfo shopApi;

	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	@RequestMapping(value = "/certifList")
	public ModelAndView certifList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();

		String sCertifNO = request.getParameter("sCertifNO");
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("dLastUpdateTime desc");
			}
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TShopCertif");
			Map<String, Object> resultmap = shopCertifApi.queryTShopCertif(params, page);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}
			ModelAndView mv = new ModelAndView("/customer/certif-manage.jsp", map);
			mv.addObject("sCertifNO", sCertifNO);
			return mv;
		} catch (Exception e) {
			U.logger.error("店铺证照信息查询请求出错", e);
			return  new ModelAndView("/customer/500.jsp");
		}
		
	}

	/**
	 * 进入新增店铺页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddCertif")
	public ModelAndView toAddCertif(HttpServletRequest request) {

		return new ModelAndView("/customer/certif-info.jsp");
	}

	/**
	 * 进入 编辑店铺证照信息页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOrEditShopCertif")
	public ModelAndView toAddOrEditShopCertif(HttpServletRequest request) {
		String sShopNO = request.getParameter("sShopNO");
		TShopCertif shopCertif = shopCertifApi.findById(sShopNO);
		TShopInfo shopInfo = null;

		TShopCertifPic shopCertifPic = shopCertifPicApi.findById(shopCertif.getSShopNO());
		if (shopCertif != null && shopCertif.getSShopNO() != null) {
			shopInfo = shopApi.findByShopNO(shopCertif.getSShopNO());
		}
		request.setAttribute("shopInfo", shopInfo);
		request.setAttribute("shopCertifPic", shopCertifPic);
		request.setAttribute("shopCertif", shopCertif);
		return new ModelAndView("/customer/certif-info.jsp");
	}

	/**
	 * 保存店铺信息
	 * 
	 * @param file
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/saveFormShopInfo", method = RequestMethod.POST)
	public void saveFormShopInfo(@RequestParam(value = "sURL", required = false) MultipartFile file,
			HttpServletRequest request, Writer writer) {
		try {
			Integer nTag = request.getParameter("nTag")!=null?Integer.valueOf(request.getParameter("nTag")):null;
			String sCertifTypeID = request.getParameter("sCertifTypeID");
			String sCertifType = request.getParameter("sCertifType");
			String sCertifNO = request.getParameter("sCertifNO");
			Date dValidDate = request.getParameter("dValidDate") != null
					? DateUtil.parse(request.getParameter("dValidDate"), DateUtil.FMT_DATE) : null;
			Date dExpiryDate = request.getParameter("dExpiryDate") != null
					? DateUtil.parse(request.getParameter("dExpiryDate"), DateUtil.FMT_DATE) : null;
			String sShopNO = request.getParameter("sShopNO");
			String sMemo = request.getParameter("sMemo");

			TShopCertif shopCertif = null;
			if (sShopNO == null) {
				shopCertif = new TShopCertif();
			} else {
				shopCertif = shopCertifApi.findById(sShopNO);
			}
			if(shopCertif==null){
				shopCertif = new TShopCertif();
				nTag = CustContants.TAG_0;
				shopCertif.setDConfirmDate(new Date());
			}
			shopCertif.setNTag(nTag);
			shopCertif.setSCertifTypeID(sCertifTypeID);
			shopCertif.setSCertifType(sCertifType);
			shopCertif.setSCertifNO(sCertifNO);
			shopCertif.setDValidDate(dValidDate);
			shopCertif.setDExpiryDate(dExpiryDate);
			shopCertif.setSMemo(sMemo);
			shopCertif.setDLastUpdateTime(new Date());
			shopCertif.setSConfirmUser(SecurityContextUtil.getUserId());

			// 文件上传
			if (file != null) {
				String fileName = file.getOriginalFilename();
				if (U.isNotEmpty(fileName)) {
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.CERTIF_PIC_PATH + OSSUtils.getFileNewName(fileName);
					// 上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					// 获取图片路径
					String filePath = OSSUtils.getImgURl(key, bucketName);
					filePath = filePath.substring(0, filePath.indexOf("?"));
					OSSUtils.closeOssClient();
					TShopCertifPic shopCertifPic = null;
					if (sShopNO != null) {
						shopCertifPic = shopCertifPicApi.findById(sShopNO);
					}
					if (shopCertifPic == null) {
						shopCertifPic = new TShopCertifPic();
					}
					shopCertifPic.setSURL(filePath);
					shopCertifPic.setNTag(0);
					shopCertifPic.setDCreateDate(new Date());
					shopCertifPic.setSPicDesc(request.getParameter("sPicDesc"));
					shopCertifPic.setSConfirmUser(SecurityContextUtil.getUserId());
					shopCertifPic.setSCertifTypeID(sCertifTypeID);
					shopCertifPic.setSCertifNO(sCertifNO);
					shopCertifPicApi.saveCertifPic(shopCertifPic, SecurityContextUtil.getUserId(), sShopNO);
				}
			}

			Map<String, Object> resultMap = shopCertifApi.saveShopCertif(shopCertif, SecurityContextUtil.getUserId(),sShopNO);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			U.logger.error("保存店铺证照出错失败", e);
			Egox.egoxErr().setReturnValue("保存店铺证照出错失败").write(writer);
		}
	}

	@RequestMapping(value = "/salectShopList")
	public ModelAndView salectShopList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();

		String sShopName = request.getParameter("sShopName");
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TShopInfo");
			params.put("nTag", 0);
			Map<String, Object> resultmap = shopApi.queryTShopInfo(regionIds, params, page);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

		} catch (Exception e) {
			U.logger.error("店铺信息查询请求出错", e);
		}
		ModelAndView mv = new ModelAndView("/customer/selected-shop.jsp", map);
		mv.addObject("sShopName", sShopName);
		return mv;
	}
	
	/**
	 * 修改店铺证照状态
	 * @return
	 */
	@RequestMapping(value="/updateTag",method=RequestMethod.POST)
	public void status(HttpServletRequest request,Writer writer){
		String sShopNO = request.getParameter("sShopNO");
		String nTag=request.getParameter("nTag");
		try {
			Map<String,Object> resultMap = shopCertifApi.updateShopCertifTag(sShopNO,Integer.valueOf(nTag));
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("修改店铺证照状态失败", e);
			Egox.egoxErr().setReturnValue("修改店铺证照状态失败").write(writer);
		}
	}
}
