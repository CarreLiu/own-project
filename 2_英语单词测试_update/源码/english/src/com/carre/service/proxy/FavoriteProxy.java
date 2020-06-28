package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.Favorite;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.FavoriteService;
import com.carre.service.WordService;
import com.carre.transaction.TransactionManager;
import com.carre.vo.FavoriteVO;

public class FavoriteProxy implements FavoriteService {

	@Override
	public List<Favorite> findEnabledFavoritesByDate(FavoriteVO favoriteVO) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		FavoriteService favoriteService = (FavoriteService) ObjectFactory.getObject("favoriteService");
		List<Favorite> favoriteList = null;
		try {
			tran.beginTransaction();
			favoriteList = favoriteService.findEnabledFavoritesByDate(favoriteVO);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return favoriteList;
	}
	
	@Override
	public List<Favorite> findAllFavorites(FavoriteVO favoriteVO) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		FavoriteService favoriteService = (FavoriteService) ObjectFactory.getObject("favoriteService");
		List<Favorite> favoriteList = null;
		try {
			tran.beginTransaction();
			favoriteList = favoriteService.findAllFavorites(favoriteVO);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return favoriteList;
	}

	@Override
	public List<Favorite> findFavoritesByDate(FavoriteVO favoriteVO) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		FavoriteService favoriteService = (FavoriteService) ObjectFactory.getObject("favoriteService");
		List<Favorite> favoriteList = null;
		try {
			tran.beginTransaction();
			favoriteList = favoriteService.findFavoritesByDate(favoriteVO);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return favoriteList;
	}

	@Override
	public void addFavorite(Favorite favorite) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		FavoriteService favoriteService = (FavoriteService) ObjectFactory.getObject("favoriteService");
		try {
			tran.beginTransaction();
			favoriteService.addFavorite(favorite);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public void removeFavorite(Integer wordId) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		FavoriteService favoriteService = (FavoriteService) ObjectFactory.getObject("favoriteService");
		try {
			tran.beginTransaction();
			favoriteService.removeFavorite(wordId);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

}
