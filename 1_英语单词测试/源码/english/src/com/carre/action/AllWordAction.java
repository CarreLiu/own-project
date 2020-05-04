package com.carre.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.carre.constant.Constant;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;

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
}
