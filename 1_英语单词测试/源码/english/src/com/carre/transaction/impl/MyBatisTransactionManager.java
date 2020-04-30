package com.carre.transaction.impl;

import org.apache.ibatis.session.SqlSession;

import com.carre.exception.DataAccessException;
import com.carre.transaction.TransactionManager;
import com.carre.util.MyBatisUtil;

public class MyBatisTransactionManager implements TransactionManager {

	public void beginTransaction() {
		SqlSession session=null;
		try {
			session=MyBatisUtil.getSession();
		} catch (Exception e) {
			throw new DataAccessException("数据访问失败",e);
		}
	}

	public void commit() {
		SqlSession session=null;
		try {
			session=MyBatisUtil.getSession();
			session.commit();
		} catch (Exception e) {
			throw new DataAccessException("数据访问失败",e);
		} finally {
			MyBatisUtil.closeSession();
		}
	}

	public void rollback() {
		SqlSession session=null;
		try {
			session=MyBatisUtil.getSession();
			session.rollback();
		} catch (Exception e) {
		} finally {
			MyBatisUtil.closeSession();
		}			
	}

}
