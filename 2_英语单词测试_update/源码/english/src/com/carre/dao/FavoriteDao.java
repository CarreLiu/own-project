package com.carre.dao;

import java.util.List;

import com.carre.entity.Favorite;
import com.carre.vo.FavoriteVO;

public interface FavoriteDao {

	public List<Favorite> selectEnabledFavoritesByDate(FavoriteVO favoriteVO);
	
	public List<Favorite> selectAllFavorites(FavoriteVO favoriteVO);

	public List<Favorite> selectFavoritesByDate(FavoriteVO favoriteVO);

	public void insertFavorite(Favorite favorite);

	public void deleteFavorite(Integer wordId);

}
