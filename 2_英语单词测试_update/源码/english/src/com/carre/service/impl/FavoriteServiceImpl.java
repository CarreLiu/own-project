package com.carre.service.impl;

import java.util.Date;
import java.util.List;

import com.carre.dao.FavoriteDao;
import com.carre.dao.WordDao;
import com.carre.entity.Favorite;
import com.carre.factory.ObjectFactory;
import com.carre.service.FavoriteService;
import com.carre.vo.FavoriteVO;

public class FavoriteServiceImpl implements FavoriteService {

	@Override
	public List<Favorite> findEnabledFavoritesByDate(FavoriteVO favoriteVO) {
		FavoriteDao favoriteDao = (FavoriteDao) ObjectFactory.getObject("favoriteDao");
		List<Favorite> favoriteList = favoriteDao.selectEnabledFavoritesByDate(favoriteVO);
		
		return favoriteList;
	}
	
	@Override
	public List<Favorite> findAllFavorites(FavoriteVO favoriteVO) {
		FavoriteDao favoriteDao = (FavoriteDao) ObjectFactory.getObject("favoriteDao");
		List<Favorite> favoriteList = favoriteDao.selectAllFavorites(favoriteVO);
		
		return favoriteList;
	}

	@Override
	public List<Favorite> findFavoritesByDate(FavoriteVO favoriteVO) {
		FavoriteDao favoriteDao = (FavoriteDao) ObjectFactory.getObject("favoriteDao");
		List<Favorite> favoriteList = favoriteDao.selectFavoritesByDate(favoriteVO);
		
		return favoriteList;
	}

	@Override
	public void addFavorite(Favorite favorite) throws Exception {
		FavoriteDao favoriteDao = (FavoriteDao) ObjectFactory.getObject("favoriteDao");
		favorite.setJoinTime(new Date());
		favoriteDao.insertFavorite(favorite);
	}

	@Override
	public void removeFavorite(Integer wordId) throws Exception {
		FavoriteDao favoriteDao = (FavoriteDao) ObjectFactory.getObject("favoriteDao");
		favoriteDao.deleteFavorite(wordId);
	}

}
