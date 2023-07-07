package com.yyy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yyy.entity.Like;

public interface LikeDao {
	
	public List<Like> findLikes(Integer daily_id);   //查询指定日志 ID 的所有点赞
	
	public int addLike(Like like);   //插入指定日志 ID 的一条点赞记录
	
	public void deleteLike_one(Integer id); //删除指定日志 ID 的某一条点赞记录
	
	public int addlikepost(@Param("author_id")Integer author_id,@Param("message") String message);   //用户点赞后发送点赞消息给作者
	
	public int deletelikepost(@Param("author_id") Integer author_id);   //删除某个作者的点赞消息
	
	public List<Integer> findlikemessage_id(Integer author_id);  //查询指定用户的点赞消息(查id)
	
	public List<String> findlikemessage_message(Integer author_id);  //查询指定用户的点赞消息(查message)
	
}
