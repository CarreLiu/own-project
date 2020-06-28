package com.carre.service.impl;

import com.carre.dao.TestDetailDao;
import com.carre.entity.TestDetail;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestDetailService;

public class TestDetailServiceImpl implements TestDetailService {

	@Override
	public void addTestDetail(TestDetail testDetail) throws Exception {
		TestDetailDao testDetailDao = (TestDetailDao) ObjectFactory.getObject("testDetailDao");
		testDetailDao.insertTestDetail(testDetail);		
	}

}
