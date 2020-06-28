package com.carre.dao;

import java.util.List;

import com.carre.entity.University;

public interface UniversityDao {

	public List<University> selectUniversity();

	public void insertUniversity(University university);

	public void updateUniversityNumber(University university);

}
