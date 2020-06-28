package com.carre.service.impl;

import java.util.List;

import com.carre.dao.TestTypeDao;
import com.carre.entity.TestType;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestTypeService;

public class TestTypeServiceImpl implements TestTypeService {

	@Override
	public List<TestType> findTestType() {
		TestTypeDao testTypeDao = (TestTypeDao) ObjectFactory.getObject("testTypeDao");
		List<TestType> testTypeList = null;
		testTypeList = testTypeDao.selectTestType();
		
		return testTypeList;
	}

}
