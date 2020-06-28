package com.carre.dao;

import com.carre.entity.TestDetail;
import com.carre.exception.DataAccessException;

public interface TestDetailDao {
	public void insertTestDetail(TestDetail testDetail) throws DataAccessException;
}
