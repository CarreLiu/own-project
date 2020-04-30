package com.carre.service.impl;

import java.util.Date;
import java.util.List;

import com.carre.dao.TestDao;
import com.carre.entity.Test;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestService;
import com.carre.vo.TestVO2;

public class TestServiceImpl implements TestService {

	@Override
	public void addTest(Test test) throws Exception {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		test.setCreateTime(new Date());
		testDao.insertTest(test);
	}

	@Override
	public List<Test> findAllTests(Integer testType) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		List<Test> testList = null;
		testList = testDao.selectAllTests(testType);
		
		return testList;
	}

	@Override
	public List<Test> findTestsByDate(TestVO2 test) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		List<Test> testList = null;
		testList = testDao.selectTestsByDate(test);
		
		return testList;
	}

	@Override
	public Test findTestById(Integer id) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		Test test = null;
		test = testDao.selectTestById(id);
		
		return test;
	}

}
