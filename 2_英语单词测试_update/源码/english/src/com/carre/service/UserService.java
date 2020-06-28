package com.carre.service;

import com.carre.entity.User;
import com.carre.exception.UserOrPassWrongException;
import com.carre.exception.UsernameExistException;
import com.carre.vo.UserVO;

public interface UserService {

	public User findUserByUsernamePass(UserVO userVO) throws UserOrPassWrongException;
	
	public User findByUsername(String username) throws UsernameExistException;

	public void addUser(User user) throws Exception;


}
