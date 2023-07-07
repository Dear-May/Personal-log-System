package com.yyy.service;

import java.util.List;

import com.yyy.entity.Comment;

public interface CommentService {
    
    public int addComment(Comment comment);
    
    public List<Comment> findComments(Integer daily_id);
    
    public int deleteComment(Integer daily_id);
    
    public int findUser_id(Integer id);
    
    public Integer deleteComment_one(Integer id); 
    
}
