package com.yyy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.LikeDao;
import com.yyy.entity.Like;
import com.yyy.service.LikeService;

@Service("likeService")   
@Transactional              

//评论接口
public class LikeServiceImpl implements LikeService{

    @Autowired
    LikeDao likeDao;

	@Override
	public List<Like> findLikes(Integer daily_id) {
		return likeDao.findLikes(daily_id);
	}

	@Override
	public int addLike(Like like) {
		return likeDao.addLike(like);
	}

	@Override
	public Integer deleteLike_one(Integer id) {
		likeDao.deleteLike_one(id);
		return 0;
	}

	@Override
	public int addlikepost(Integer author_id, String message) {
		return likeDao.addlikepost(author_id, message);
	}

	@Override
	public int deletelikepost(Integer author_id) {
		return likeDao.deletelikepost(author_id);
	}

	@Override
	public List<Integer> findlikemessage_id(Integer author_id) {
		return likeDao.findlikemessage_id(author_id);
	}

	@Override
	public List<String> findlikemessage_message(Integer author_id) {
		return likeDao.findlikemessage_message(author_id);
	}
    
}
