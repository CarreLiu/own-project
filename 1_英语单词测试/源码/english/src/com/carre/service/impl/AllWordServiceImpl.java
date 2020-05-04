package com.carre.service.impl;

import com.carre.dao.AllWordDao;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;

public class AllWordServiceImpl implements AllWordService {

	@Override
	public String findChinese(String english) {
		AllWordDao allWordDao = (AllWordDao) ObjectFactory.getObject("allWordDao");
		String chinese = allWordDao.selectChinese(english);
		
		return chinese;
	}

}
