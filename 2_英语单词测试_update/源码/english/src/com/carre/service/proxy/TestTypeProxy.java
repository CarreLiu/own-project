package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.TestType;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestTypeService;
import com.carre.transaction.TransactionManager;

public class TestTypeProxy implements TestTypeService {

	@Override
	public List<TestType> findTestType() {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestTypeService testTypeService = (TestTypeService) ObjectFactory.getObject("testTypeService");
		List<TestType> testTypeList = null;
		try {
			tran.beginTransaction();
			testTypeList = testTypeService.findTestType();
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return testTypeList;
	}

}
