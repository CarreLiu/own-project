package com.carre.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.carre.constant.Constant;
import com.carre.entity.Favorite;
import com.carre.entity.User;
import com.carre.factory.ObjectFactory;
import com.carre.service.FavoriteService;
import com.carre.vo.FavoriteVO;
import com.carre.vo.PageInfo;
import com.github.pagehelper.PageHelper;

public class FavoriteAction {
	
	public void findFavoritesByPage() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		FavoriteService favoriteProxy = (FavoriteService) ObjectFactory.getObject("favoriteProxy");
		String pageNoStr = request.getParameter("pageNo");
		String pageSizeStr = request.getParameter("pageSize");
		int pageNo = 0;
		int pageSize = 0;
		if (pageNoStr == null) {
			pageNo = Constant.PAGE_NO;
		}
		else {
			pageNo = Integer.parseInt(pageNoStr);
		}
		if (pageSizeStr == null) {
			pageSize = Constant.PAGE_SIZE;
		}
		else {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		int allTime = Integer.parseInt(request.getParameter("allTime"));
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = null;
		Date endDate = null;
		if (beginDateStr != "")
			beginDate = simpleDateFormat.parse(beginDateStr);
		if (endDateStr != "")
			endDate = simpleDateFormat.parse(endDateStr);
		List<Favorite> favoriteList = null;
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		
		FavoriteVO favoriteVO = new FavoriteVO();
		favoriteVO.setUserId(userId);
		
		if (allTime == 1) {	//查询全部时间
			PageHelper.startPage(pageNo, pageSize);
			favoriteList = favoriteProxy.findAllFavorites(favoriteVO);
			
		}
		else if (allTime == 0) {	//查询给定时间区间
			favoriteVO.setBeginDate(beginDate);
			favoriteVO.setEndDate(endDate);
			PageHelper.startPage(pageNo, pageSize);
			favoriteList = favoriteProxy.findFavoritesByDate(favoriteVO);
		}
		PageInfo<Favorite> pageInfo = new PageInfo<Favorite>(favoriteList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
}
