package com.carre.dao;

import java.util.List;

import com.carre.entity.Test;
import com.carre.exception.DataAccessException;
import com.carre.vo.TestVO2;

public interface TestDao {

	public void insertTest(Test test) throws DataAccessException;

	public List<Test> selectAllTests(Integer testType);

	public List<Test> selectTestsByDate(TestVO2 test);

	public Test selectTestById(Integer id);
	
}
