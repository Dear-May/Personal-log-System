package com.yyy.dao;

import java.util.List;

import com.yyy.entity.Comment;

public interface CommentDao {
	
    public int addComment(Comment comment);   //插入一条评论记录
    
    public List<Comment> findComments(Integer daily_id);   //查询指定日志 ID 的所有评论
    
    public int deleteComment(Integer daily_id);   //删除指定日志 ID 的所有评论记录
    
    public int findUser_id(Integer id);   //根据评论ID查询该评论的用户
    
    public void deleteComment_one(Integer id); //删除指定日志 ID 的某一条评论记录
    
}
