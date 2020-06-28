package com.carre.service.proxy;

import com.carre.entity.TestDetail;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestDetailService;
import com.carre.transaction.TransactionManager;

public class TestDetailProxy implements TestDetailService {

	@Override
	public void addTestDetail(TestDetail testDetail) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		TestDetailService testDetailService = (TestDetailService) ObjectFactory.getObject("testDetailService");
		try {
			tran.beginTransaction();
			testDetailService.addTestDetail(testDetail);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
	}
	
}
