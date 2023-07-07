package com.yyy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yyy.entity.Daily;

public interface DailyDao {

	public int createDaily(Daily dadily); // 插入一条日志记录	//CST21030 (2023/7/2):这行代码是否被使用 CTS21045(2023/7/2):有被使用，详细见DailyServiceImpl第27行
	
	public List<Daily> selectDailyList(Integer user_id); // 查询指定用户ID的所有日志

	public int deleteDaily(Integer id); // 删除指定日志ID的日志记录

	public List<Daily> findFriendDaily(Integer user_id); // 查询指定用户ID的好友的所有公开日志

	public int updateDaily(Daily daily); // 更新指定日志ID的日志记录

	public int findUser_id(Integer daily_id); // 根据日志ID查询该日志的用户

	public int findDaliylike(Integer daily_id); // 根据日志ID查询点赞数

	public int updateDaliylike(Integer daily_id); // 根据日志ID增加点赞数
	
	public int deleteDaliylike(Integer daily_id); // 根据日志ID增加点赞数

	public List<Daily> findDaily_tag(String tag); // 查询指定标签的所有公开日志(模糊查找)
	
	public String findDaily_details(Integer daily_id); // 根据日志ID查询该日志的内容
	
	public int saveDocument(@Param("usercode") Integer user_id,@Param("content") String content);  // 保存草稿
	
	public String getDocument(Integer user_id);  // 获取草稿
	
	public int deleteDocument(Integer user_id);  // 删除草稿
}
