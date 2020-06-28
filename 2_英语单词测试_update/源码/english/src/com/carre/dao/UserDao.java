package com.carre.dao;

import com.carre.entity.User;
import com.carre.vo.UserVO;

public interface UserDao {

	public User selectUserByUsernamePass(UserVO userVO);
	
	public User selectByUsername(String username);

	public void insertUser(User user);

}
