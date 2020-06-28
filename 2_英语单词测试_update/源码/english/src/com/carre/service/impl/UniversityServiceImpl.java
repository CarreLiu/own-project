package com.carre.service.impl;

import java.util.List;

import com.carre.dao.UniversityDao;
import com.carre.entity.University;
import com.carre.factory.ObjectFactory;
import com.carre.service.UniversityService;

public class UniversityServiceImpl implements UniversityService {

	@Override
	public List<University> findUniversity() {
		UniversityDao universityDao = (UniversityDao) ObjectFactory.getObject("universityDao");
		List<University> universityList = null;
		universityList = universityDao.selectUniversity();
		
		return universityList;
	}

	@Override
	public void addUniversity(University university) throws Exception {
		UniversityDao universityDao = (UniversityDao) ObjectFactory.getObject("universityDao");
		universityDao.insertUniversity(university);
	}

	@Override
	public void modifyUniversityNumber(University university) throws Exception {
		UniversityDao universityDao = (UniversityDao) ObjectFactory.getObject("universityDao");
		universityDao.updateUniversityNumber(university);
	}

}
