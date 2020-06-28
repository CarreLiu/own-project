package com.carre.constant;

/**
 * 常量接口
 * @author hellboy
 *
 */
public interface Constant {
	/**
	 * 用户禁用状态
	 */
	public static final String USER_STATUS_DISABLE = "0";
	/**
	 * 用户启用状态
	 */
	public static final String USER_STATUS_ENABLE = "1";
	/**
	 * 过滤器默认字符集
	 */
	public static final String FILTER_CHARSET_UTF8 = "UTF-8";
	
    //返回页面类型
	public static final String CONTENT_TYPE="text/plain;charset=utf-8";
	
	//当前页
	public static final int PAGE_NO = 1;
	
	//页的大小
	public static final int PAGE_SIZE = 5;
	
	//初值0
	public static final int ZERO = 0;
	
	//单词启用状态
	public static final int WORD_VALID = 1;
	
	//单词禁用状态
	public static final int WORD_INVALID = 0;
	
	//单词收藏
	public static final int WORD_FAVORITE = 1;
	
	//单词未收藏
	public static final int WORD_NOT_FAVORITE = 0;
	
	//响应状态码：1 成功
    public static final Integer RESPONSE_STATUS_SUCCESS = 1;

    //响应状态码：2 失败
    public static final Integer RESPONSE_STATUS_FAILURE = 2;

    //响应状态码：3 未授权
    public static final Integer RESPONSE_NO_PERMISSION = 3;
	
	
}
