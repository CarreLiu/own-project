package com.carre.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.carre.constant.Constant;
import com.carre.entity.User;
import com.carre.entity.Word;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;
import com.carre.vo.PageInfo;
import com.github.pagehelper.PageHelper;

public class AllWordAction {
	public void findChinese() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		AllWordService allWordProxy = (AllWordService) ObjectFactory.getObject("allWordProxy");
		String english = request.getParameter("english");
		String chinese = allWordProxy.findChinese(english);
		response.getWriter().print(chinese);
	}
	
	public String toWordSearch() {
		return "toWordSearch";
	}
	
	public void findWordByCondition() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		AllWordService allWordProxy = (AllWordService) ObjectFactory.getObject("allWordProxy");
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
		
		String english = request.getParameter("english").trim();
		String chinese = request.getParameter("chinese").trim();
		
		List<Word> wordList = null;
		
		if (english != null && !english.isEmpty()) {
			english = request.getParameter("english") + "%";
		}
		if (chinese != null && !chinese.isEmpty()) {
			chinese = "%" + request.getParameter("chinese") + "%";
		}
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		Word word = new Word();
		word.setEnglish(english);
		word.setChinese(chinese);
		word.setUserId(userId);
		
		PageInfo<Word> pageInfo = null;
		//不输入则显示无结果
		if ((english == null || english.isEmpty()) && (chinese == null || chinese.isEmpty())) {
			PageHelper.startPage(pageNo, pageSize);
			pageInfo = new PageInfo<Word>();
		}
		else {
			PageHelper.startPage(pageNo, pageSize);
			wordList = allWordProxy.findWordByCondition(word);
			pageInfo = new PageInfo<Word>(wordList);
		}
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
}
