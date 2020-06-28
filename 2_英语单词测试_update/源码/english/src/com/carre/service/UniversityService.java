package com.carre.service;

import java.util.List;

import com.carre.entity.University;

public interface UniversityService {

	public List<University> findUniversity();

	public void addUniversity(University university) throws Exception;

	public void modifyUniversityNumber(University university) throws Exception;
}
