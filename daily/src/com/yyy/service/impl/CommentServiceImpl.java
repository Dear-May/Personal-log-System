package com.yyy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.CommentDao;
import com.yyy.entity.Comment;
import com.yyy.service.CommentService;

@Service("commentService")   
@Transactional              

//评论接口
public class CommentServiceImpl implements CommentService{

    @Autowired
    CommentDao commentDao;
    
    @Override
    public int addComment(Comment comment) {
    	return commentDao.addComment(comment);
    }
    
    @Override
    public List<Comment> findComments(Integer daily_id) {
    	return commentDao.findComments(daily_id);
    }
    
    @Override
    public int deleteComment(Integer daily_id) {
    	return commentDao.deleteComment(daily_id);
    }

	@Override
	public int findUser_id(Integer id) {
		return commentDao.findUser_id(id);
	}
    
	@Override
	public Integer deleteComment_one(Integer id) {
		commentDao.deleteComment_one(id);
		return 0;
	}

}
