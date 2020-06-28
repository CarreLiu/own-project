package com.carre.service.impl;

import java.util.Date;
import java.util.List;

import com.carre.dao.TestDao;
import com.carre.entity.Test;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestService;
import com.carre.vo.TestVO;

public class TestServiceImpl implements TestService {

	@Override
	public void addTest(Test test) throws Exception {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		test.setCreateTime(new Date());
		testDao.insertTest(test);
	}

	@Override
	public List<Test> findAllTests(TestVO test) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		List<Test> testList = null;
		testList = testDao.selectAllTests(test);
		
		return testList;
	}

	@Override
	public List<Test> findTestsByDate(TestVO test) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		List<Test> testList = null;
		testList = testDao.selectTestsByDate(test);
		
		return testList;
	}

	@Override
	public Test findTestById(Integer id) {
		Test test = null;
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		test = testDao.selectTestById(id);
		if (test == null) {
			throw new ServiceException();
		}
		
		return test;
	}

	@Override
	public Integer findMaxOwnTestId(Integer userId) {
		TestDao testDao = (TestDao) ObjectFactory.getObject("testDao");
		Integer ownTestId = null;
		ownTestId = testDao.selectMaxOwnTestId(userId);
		if (ownTestId == null) {
			ownTestId = 0;
		}
		
		return ownTestId;
	}


}
