package com.carre.service;

import java.util.List;

import com.carre.entity.Test;
import com.carre.vo.TestVO2;

public interface TestService {

	public void addTest(Test test) throws Exception;

	public List<Test> findAllTests(Integer testType);

	public List<Test> findTestsByDate(TestVO2 test);

	public Test findTestById(Integer id);
	
}
