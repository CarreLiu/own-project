package com.carre.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.carre.constant.Constant;
import com.carre.entity.Favorite;
import com.carre.entity.Test;
import com.carre.entity.TestType;
import com.carre.entity.User;
import com.carre.entity.Word;
import com.carre.exception.WordEnglishExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.FavoriteService;
import com.carre.service.TestService;
import com.carre.service.TestTypeService;
import com.carre.service.WordService;
import com.carre.util.ResponseResult;
import com.carre.vo.FavoriteVO;
import com.carre.vo.PageInfo;
import com.carre.vo.TestVO;
import com.carre.vo.WordVO2;
import com.github.pagehelper.PageHelper;

public class WordAction {
	private Word word;
	public Word getWord() {
		return word;
	}
	public void setWord(Word word) {
		this.word = word;
	}
	
	public String toAddWord() {
		return "toAddWord";
	}
	
	public String addWord() {
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		HttpServletRequest request = ServletActionContext.getRequest();
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		word.setUserId(userId);
		word.setStatus(Constant.WORD_VALID);
		word.setIsFavorite(Constant.WORD_NOT_FAVORITE);
		word.setErrorTimes(Constant.ZERO);
		word.setCorrectTimes(Constant.ZERO);
		try {
			wordProxy.addWord(word);
		} catch (Exception e) {
			request.setAttribute("errorMsg", e.getMessage());
			return "fail";
		}
		
		return "success";
	}
	
	public String addWordSuccess() {
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("successMsg", "添加成功");
		
		return "addWordSuccess";
	}
	
	public String wordsTest() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		TestTypeService testTypeProxy = (TestTypeService) ObjectFactory.getObject("testTypeService");
		List<TestType> testTypes = testTypeProxy.findTestType();
		request.setAttribute("testTypes", testTypes);
		
		return "wordsTest";
	}
	
	public void searchEnabledWords() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		int testTypeId = Integer.parseInt(request.getParameter("testTypeId"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = simpleDateFormat.parse(beginDateStr);
		Date endDate = simpleDateFormat.parse(endDateStr);
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
		List<Word> wordList = null;
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		if (testTypeId == 1) {	//词库中的单词
			WordVO2 wordVO = new WordVO2();
			wordVO.setUserId(userId);
			wordVO.setBeginDate(beginDate);
			wordVO.setEndDate(endDate);
			wordList = wordProxy.findEnabledWordsByDate(wordVO);
		}
		else if (testTypeId == 2) {	//测试中的错误单词
			TestVO test = new TestVO(userId, 0, beginDate, endDate);	//0是指检索所有测试记录
			List<Integer> idList = new LinkedList<Integer>();
			TreeSet<Integer> idSet = new TreeSet<Integer>();	//使用set是为了去重复
			List<Test> testList = testProxy.findTestsByDate(test);
			if (!testList.isEmpty()) {
				for (Test test2 : testList) {
					String errorWords = test2.getTestDetail().getErrorWords();
					if (errorWords != null && errorWords != "") {	//重点
						String []arrays = errorWords.split(",");
						for (String arr : arrays) {
							if (arr != "" && arr != null)	//重点
								idSet.add(Integer.valueOf(arr));
						}
					}
				}
			}
			if (!idSet.isEmpty()) {
				for (Integer id : idSet) {
					idList.add(id);
				}
				wordList = wordProxy.findEnabledWordsByIds(idList);
			}
		}
		else if (testTypeId == 3) {	//测试中的正确单词
			TestVO test = new TestVO(userId, 0, beginDate, endDate);	//0是指检索所有测试记录
			List<Integer> idList = new LinkedList<Integer>();
			TreeSet<Integer> idSet = new TreeSet<Integer>();	//使用set是为了去重复
			List<Test> testList = testProxy.findTestsByDate(test);
			if (!testList.isEmpty()) {
				for (Test test2 : testList) {
					String correctWords = test2.getTestDetail().getCorrectWords();
					if (correctWords != null && correctWords != "") {	//重点
						String []arrays = correctWords.split(",");
						for (String arr : arrays) {
							if (arr != "" && arr != null)	//重点
								idSet.add(Integer.valueOf(arr));
						}
					}
				}
			}
			if (!idSet.isEmpty()) {
				for (Integer id : idSet) {
					idList.add(id);
				}
				wordList = wordProxy.findEnabledWordsByIds(idList);
			}
		}
		else if (testTypeId == 4) {	//用户收藏单词
			FavoriteService favoriteProxy = (FavoriteService) ObjectFactory.getObject("favoriteProxy");
			FavoriteVO favoriteVO = new FavoriteVO();
			favoriteVO.setUserId(userId);
			favoriteVO.setBeginDate(beginDate);
			favoriteVO.setEndDate(endDate);
			List<Favorite> favoriteList = null;
			favoriteList = favoriteProxy.findEnabledFavoritesByDate(favoriteVO);
			wordList = new LinkedList<Word>();
			for (Favorite favorite : favoriteList) {
				wordList.add(favorite.getWord());
			}
		}
		if (wordList == null) {
			wordList = new LinkedList<Word>();	//使jsp页面显示共0个单词
		}
		else if (!wordList.isEmpty()) {
			Collections.shuffle(wordList);		//乱序,让测试单词乱序显示
		}
		
		
		response.getWriter().print(JSON.toJSON(wordList));
	}
	
	//校验英文单词是否已存在
	public void findByWordEnglish() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		String english = request.getParameter("word.english");
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			wordProxy.findByWordEnglish(userId, english);
			map.put("valid", true);//设置valid属性,在false时,输出message所对应的值
		} catch (WordEnglishExistException e) {
			map.put("valid", false);
			map.put("message", e.getMessage());
		}
		//返回2个值:message,是否输出该消息:valid
		response.getWriter().print(JSON.toJSON(map));
	}
	
	public String toWordsShown() {
		
		return "toWordsShown";
	}
	
	public void findWordsByPage() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		String pageNoStr = request.getParameter("pageNo");
		String pageSizeStr = request.getParameter("pageSize");
		int pageNo = 0;
		int pageSize = 0;
		if (pageNoStr == null) {
			pageNo = Constant.PAGE_NO;
		}
		else {
			pageNo = Integer.parseInt(pageNoStr);
		}
		if (pageSizeStr == null) {
			pageSize = Constant.PAGE_SIZE;
		}
		else {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		int allTime = Integer.parseInt(request.getParameter("allTime"));
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		Integer status = Integer.valueOf(request.getParameter("status"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = null;
		Date endDate = null;
		if (beginDateStr != "")
			beginDate = simpleDateFormat.parse(beginDateStr);
		if (endDateStr != "")
			endDate = simpleDateFormat.parse(endDateStr);
		List<Word> wordList = null;
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		
		WordVO2 wordVO = new WordVO2();
		wordVO.setUserId(userId);
		if (status != -1)  {
			wordVO.setStatus(status);
		}
		
		if (allTime == 1) {	//查询全部时间
			PageHelper.startPage(pageNo, pageSize);
			wordList = wordProxy.findAllWords(wordVO);
			
		}
		else if (allTime == 0) {	//查询给定时间区间
			wordVO.setBeginDate(beginDate);
			wordVO.setEndDate(endDate);
			PageHelper.startPage(pageNo, pageSize);
			wordList = wordProxy.findWordsByDate(wordVO);
		}
		PageInfo<Word> pageInfo = new PageInfo<Word>(wordList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
	
	public void findWordById() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Integer id = Integer.valueOf(request.getParameter("id"));
		Word modifyWord = wordProxy.findWordById(id);
		response.getWriter().print(JSON.toJSON(modifyWord));
	}
	
	//校验英文单词是否已存在,但不包括原单词
	public void findByWordEnglish2() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		String english = request.getParameter("english");
		String primeEnglish = request.getParameter("primeEnglish");
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Map<String, Object> map = new HashMap<String, Object>();
		if (english.equals(primeEnglish) || english.trim().equals(primeEnglish)) {
			map.put("valid", true);
		}
		else {
			try {
				wordProxy.findByWordEnglish(userId, english);
				map.put("valid", true);//设置valid属性,在false时,输出message所对应的值
			} catch (WordEnglishExistException e) {
				map.put("valid", false);
				map.put("message", e.getMessage());
			}
		}
		//返回2个值:message,是否输出该消息:valid
		response.getWriter().print(JSON.toJSON(map));
	}
	
	public void modifyWord() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		Integer id = Integer.valueOf(request.getParameter("id"));
		String english = request.getParameter("english");
		String chinese = request.getParameter("chinese");
		Word modifyWord = new Word(id, null, english, chinese, null, null, null, null, null);
		
		try {
			WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
			wordProxy.modifyWord(modifyWord);
			response.getWriter().print(JSON.toJSON(ResponseResult.success("修改成功")));
		} catch (Exception e) {
			response.getWriter().print(JSON.toJSON(ResponseResult.fail(e.getMessage())));
		}
	}
	
	public void modifyWordCreateTime() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		String english = request.getParameter("english");
		try {
			WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
			Word wordModify = wordProxy.findWordByEnglish(userId, english);
			wordProxy.modifyWordCreateTime(wordModify.getId());
			response.getWriter().print(JSON.toJSON(ResponseResult.success("更新成功")));
		} catch (Exception e) {
			response.getWriter().print(JSON.toJSON(ResponseResult.fail(e.getMessage())));
		}
		
	}
	
	public void modifyWordStatus() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		Integer id = Integer.valueOf(request.getParameter("id"));
		Integer status = Integer.valueOf(request.getParameter("status"));
		try {
			WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
			wordProxy.modifyWordStatus(id, status);
			String english = wordProxy.findWordById(id).getEnglish();
			String statusName = (status == 0) ? "禁用" : "启用";
			String info = "单词" + english + statusName + "成功";
			response.getWriter().print(JSON.toJSON(ResponseResult.success(info)));
		} catch (Exception e) {
			response.getWriter().print(JSON.toJSON(ResponseResult.fail(e.getMessage())));
		}
	}
	
	public void modifyWordFavoriteStatus() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		Integer id = Integer.valueOf(request.getParameter("id"));
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		Integer isFavorite = Integer.valueOf(request.getParameter("isFavorite"));
		try {
			WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
			wordProxy.modifyWordFavoriteStatus(id, isFavorite);
			
			FavoriteService favoriteProxy = (FavoriteService) ObjectFactory.getObject("favoriteProxy");
			if (isFavorite == 1) {
				Favorite favorite = new Favorite(null, userId, id, null);
				favoriteProxy.addFavorite(favorite);
			}
			else if (isFavorite == 0) {
				favoriteProxy.removeFavorite(id);
			}
			
			String english = wordProxy.findWordById(id).getEnglish();
			String isFavoriteName = (isFavorite == 0) ? "取消收藏" : "收藏";
			String info = "单词" + english + isFavoriteName + "成功";
			response.getWriter().print(JSON.toJSON(ResponseResult.success(info)));
		} catch (Exception e) {
			response.getWriter().print(JSON.toJSON(ResponseResult.fail(e.getMessage())));
		}
	}
	
	public void addWordAjax() throws IOException {
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		String english = request.getParameter("english");
		String chinese = request.getParameter("chinese");
		
		Word wordAdd = new Word();
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		wordAdd.setEnglish(english);
		wordAdd.setChinese(chinese);
		wordAdd.setUserId(userId);
		wordAdd.setStatus(Constant.WORD_VALID);
		wordAdd.setIsFavorite(Constant.WORD_NOT_FAVORITE);
		wordAdd.setErrorTimes(Constant.ZERO);
		wordAdd.setCorrectTimes(Constant.ZERO);
		try {
			wordProxy.addWord(wordAdd);
			String info = "单词" + english + "成功添加到个人词库";
			response.getWriter().print(JSON.toJSON(ResponseResult.success(info)));
		} catch (Exception e) {
			response.getWriter().print(JSON.toJSON(ResponseResult.fail(e.getMessage())));
		}
		
	}
}
