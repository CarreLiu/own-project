package com.carre.service;

import java.util.List;

import com.carre.entity.Favorite;
import com.carre.vo.FavoriteVO;

public interface FavoriteService {

	public List<Favorite> findEnabledFavoritesByDate(FavoriteVO favoriteVO);
	
	public List<Favorite> findAllFavorites(FavoriteVO favoriteVO);

	public List<Favorite> findFavoritesByDate(FavoriteVO favoriteVO);
	
	public void addFavorite(Favorite favorite) throws Exception;
	
	public void removeFavorite(Integer wordId) throws Exception;

}
