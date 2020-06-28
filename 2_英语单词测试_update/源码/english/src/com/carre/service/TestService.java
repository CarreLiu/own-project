package com.carre.service;

import java.util.List;

import com.carre.entity.Test;
import com.carre.vo.TestVO;

public interface TestService {

	public void addTest(Test test) throws Exception;

	public List<Test> findAllTests(TestVO test);

	public List<Test> findTestsByDate(TestVO test);

	public Test findTestById(Integer id);

	public Integer findMaxOwnTestId(Integer userId);

}
