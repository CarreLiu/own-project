package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.University;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.UniversityService;
import com.carre.transaction.TransactionManager;

public class UniversityProxy implements UniversityService {

	@Override
	public List<University> findUniversity() {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UniversityService universityService = (UniversityService) ObjectFactory.getObject("universityService");
		List<University> universityList = null;
		try {
			tran.beginTransaction();
			universityList = universityService.findUniversity();
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return universityList;
	}

	@Override
	public void addUniversity(University university) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UniversityService universityService = (UniversityService) ObjectFactory.getObject("universityService");
		try {
			tran.beginTransaction();
			universityService.addUniversity(university);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
	}

	@Override
	public void modifyUniversityNumber(University university) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		UniversityService universityService = (UniversityService) ObjectFactory.getObject("universityService");
		try {
			tran.beginTransaction();
			universityService.modifyUniversityNumber(university);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

}
