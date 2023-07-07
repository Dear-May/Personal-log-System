package com.yyy.service;

import java.util.List;


import com.yyy.entity.Like;

public interface LikeService {
	
	public List<Like> findLikes(Integer daily_id); 

	public int addLike(Like like); 

	public Integer deleteLike_one(Integer user_id); 
	
	public int addlikepost(Integer author_id,String message); 
	
	public int deletelikepost(Integer author_id);
	
	public List<Integer> findlikemessage_id(Integer author_id);
	
	public List<String> findlikemessage_message(Integer author_id);
	
}
