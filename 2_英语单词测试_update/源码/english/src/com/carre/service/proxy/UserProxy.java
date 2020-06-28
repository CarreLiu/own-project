package com.carre.service.proxy;

import com.carre.entity.User;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.exception.UserOrPassWrongException;
import com.carre.exception.UsernameExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.UserService;
import com.carre.transaction.TransactionManager;
import com.carre.vo.UserVO;

public class UserProxy implements UserService {

	@Override
	public User findUserByUsernamePass(UserVO userVO) throws UserOrPassWrongException {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UserService userService = (UserService) ObjectFactory.getObject("userService");
		User user = null;
		try {
			tran.beginTransaction();
			user = userService.findUserByUsernamePass(userVO);
			tran.commit();
		} catch (UserOrPassWrongException e) {
			tran.rollback();
			throw e;
		}
		return user;
	}
	
	@Override
	public User findByUsername(String username) throws UsernameExistException {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UserService userService = (UserService)ObjectFactory.getObject("userService");
		User user = null;
		try {
			tran.beginTransaction();
			user = userService.findByUsername(username);
			tran.commit();
		} catch (UsernameExistException e) {
			throw e;
		}
		
		return user;
	}

	@Override
	public void addUser(User user) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UserService userService = (UserService)ObjectFactory.getObject("userService");
		try {
			tran.beginTransaction();
			userService.addUser(user);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

}
