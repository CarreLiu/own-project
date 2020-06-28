package com.carre.service.impl;

import java.util.Date;

import com.carre.dao.UserDao;
import com.carre.entity.User;
import com.carre.exception.UserOrPassWrongException;
import com.carre.exception.UsernameExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.UserService;
import com.carre.vo.UserVO;

public class UserServiceImpl implements UserService {

	@Override
	public User findUserByUsernamePass(UserVO userVO) throws UserOrPassWrongException {
		UserDao userDao = (UserDao) ObjectFactory.getObject("userDao");
		User user = userDao.selectUserByUsernamePass(userVO);
		if (user == null) {
			throw new UserOrPassWrongException("用户名或密码错误");
		}
		
		return user;
	}
	
	@Override
	public User findByUsername(String username) throws UsernameExistException {
		UserDao userDao = (UserDao)ObjectFactory.getObject("userDao");
		User user = userDao.selectByUsername(username);
		if (user != null) {
			throw new UsernameExistException("用户名(" + username + ")已经被占用");
		}
		
		return user;
	}

	@Override
	public void addUser(User user) throws Exception {
		UserDao userDao = (UserDao) ObjectFactory.getObject("userDao");
		user.setRegistTime(new Date());
		userDao.insertUser(user);
	}

}
