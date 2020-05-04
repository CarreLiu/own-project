package com.carre.service.proxy;

import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;
import com.carre.transaction.TransactionManager;

public class AllWordProxy implements AllWordService {

	@Override
	public String findChinese(String english) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		AllWordService allWordService = (AllWordService) ObjectFactory.getObject("allWordService");
		String chinese = null;
		try {
			tran.beginTransaction();
			chinese = allWordService.findChinese(english);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return chinese;
	}

}
