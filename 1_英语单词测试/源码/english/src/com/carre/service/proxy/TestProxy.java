package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.Test;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestService;
import com.carre.transaction.TransactionManager;
import com.carre.vo.TestVO2;

public class TestProxy implements TestService {

	@Override
	public void addTest(Test test) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestService testService = (TestService) ObjectFactory.getObject("testService");
		try {
			tran.beginTransaction();
			testService.addTest(test);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public List<Test> findAllTests(Integer testType) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestService testService = (TestService) ObjectFactory.getObject("testService");
		List<Test> testList = null;
		try {
			tran.beginTransaction();
			testList = testService.findAllTests(testType);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return testList;
	}

	@Override
	public List<Test> findTestsByDate(TestVO2 test) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestService testService = (TestService) ObjectFactory.getObject("testService");
		List<Test> testList = null;
		try {
			tran.beginTransaction();
			testList = testService.findTestsByDate(test);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return testList;
	}

	@Override
	public Test findTestById(Integer id) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestService testService = (TestService) ObjectFactory.getObject("testService");
		Test test = null;
		try {
			tran.beginTransaction();
			test = testService.findTestById(id);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return test;
	}

}
