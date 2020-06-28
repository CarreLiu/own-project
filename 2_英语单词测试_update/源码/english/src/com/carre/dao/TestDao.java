package com.carre.dao;

import java.util.List;

import com.carre.entity.Test;
import com.carre.exception.DataAccessException;
import com.carre.vo.TestVO;

public interface TestDao {

	public void insertTest(Test test) throws DataAccessException;

	public List<Test> selectAllTests(TestVO test);

	public List<Test> selectTestsByDate(TestVO test);

	public Test selectTestById(Integer id);

	public Integer selectMaxOwnTestId(Integer userId);

}
