package com.carre.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.carre.constant.Constant;
import com.carre.entity.University;
import com.carre.entity.User;
import com.carre.exception.InputEmptyException;
import com.carre.exception.UserOrPassWrongException;
import com.carre.exception.UsernameExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.UniversityService;
import com.carre.service.UserService;
import com.carre.vo.UserVO;

public class UserAction {

	public String toLogin() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
		List<University> universityList = null;
		universityList = universityProxy.findUniversity();
		request.setAttribute("universityList", universityList);
		
		return "toLogin";
	}
	
	//未登录非法访问
	public String notLogin() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
		List<University> universityList = null;
		universityList = universityProxy.findUniversity();
		request.setAttribute("universityList", universityList);
		request.setAttribute("notLoginMsg", "禁止非法访问，请先登录！");
		
		return "notLogin";
	}
	
	public String login() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UserService userProxy  = (UserService) ObjectFactory.getObject("userProxy");
		UserVO userVO = new UserVO();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		userVO.setUsername(username);
		userVO.setPassword(password);
		User user = null;
		
		try {
			user = userProxy.findUserByUsernamePass(userVO);
			request.getSession().setAttribute("user", user);
		} catch (UserOrPassWrongException e) {
			UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
			List<University> universityList = null;
			universityList = universityProxy.findUniversity();
			request.setAttribute("universityList", universityList);
			request.setAttribute("loginFailMsg", e.getMessage());
			return "fail";
		}
		
		return "success";
	}
	
	public String loginSuccess() {
		HttpServletRequest request = ServletActionContext.getRequest();
		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("loginSuccessMsg", "登录成功，欢迎您" + user.getName() + "!");
		
		return "loginSuccess";
	}
	
	public void findByUsername() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType(Constant.CONTENT_TYPE);
		String username = request.getParameter("username");
		UserService userProxy  = (UserService) ObjectFactory.getObject("userProxy");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			userProxy.findByUsername(username);
			map.put("valid", true);//设置valid属性,在false时,输出message所对应的值
		} catch (UsernameExistException e) {
			map.put("valid", false);
			map.put("message", e.getMessage());
		}
		//返回2个值:message,是否输出该消息:valid
		response.getWriter().print(JSON.toJSON(map));
	}
	
	
	public String regist() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		UserService userProxy  = (UserService) ObjectFactory.getObject("userProxy");
		UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String genderStr = request.getParameter("gender");
		if (genderStr == null) {
			request.setAttribute("registFailMsg", "请勿非法直接访问，注册失败！");
			return "fail";
		}
		Integer gender = Integer.valueOf(request.getParameter("gender"));
		String email = request.getParameter("email");
		String info = request.getParameter("info");
		
		Integer universityId = null;
		String universityIdStr = request.getParameter("universityId");
		String university = request.getParameter("university");
		if (universityIdStr == null) {	//即用户自己输入的大学，需要先添加到表中
			University universityAdd = new University(null, university, Constant.ZERO + 1);
			universityProxy.addUniversity(universityAdd);
			universityId = universityAdd.getId();
		}
		else {	//用户选择列表里的大学
			universityId = Integer.valueOf(universityIdStr);
			University universityModify = new University();
			universityModify.setId(universityId);
			universityProxy.modifyUniversityNumber(universityModify);
		}
		
		List<University> universityList = null;
		universityList = universityProxy.findUniversity();
		request.setAttribute("universityList", universityList);
		
		User user = new User(null, username, password, name, gender, info, email, universityId, null);
		
		try {
			userProxy.addUser(user);
		} catch (Exception e) {
			request.setAttribute("registFailMsg", e.getMessage());
			return "fail";
		}
		
		return "success";
	}
	
	public String registSuccess() {
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("registSuccessMsg", "注册成功！");
		
		UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
		List<University> universityList = null;
		universityList = universityProxy.findUniversity();
		request.setAttribute("universityList", universityList);
		
		return "registSuccess";
	}
	
	//退出登录
	public String logOut() {
		HttpServletRequest request = ServletActionContext.getRequest();
		request.getSession().removeAttribute("user");
		request.setAttribute("logOutMsg", "退出登录成功");
		
		UniversityService universityProxy = (UniversityService) ObjectFactory.getObject("universityProxy");
		List<University> universityList = null;
		universityList = universityProxy.findUniversity();
		request.setAttribute("universityList", universityList);
		
		return "logOut";
	}
	
}
