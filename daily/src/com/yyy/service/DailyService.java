package com.yyy.service;
import java.util.List;

import com.yyy.entity.Daily;
public interface DailyService {
	
	public int createDaily(Daily daily);
	
	public List<Daily> findDailyList(Integer user_id);
		
	public int deleteDaily(Integer id);

	public List<Daily> findFriendDaily(Integer user_id);
	
	public int updateDaily(Daily daily);
	
	public int findUser_id(Integer daily_id);
	
	public int findDaliylike(Integer daily_id);
	
	public int updateDaliylike(Integer daily_id);
	
	public int deleteDailylike(Integer daily_id);
	
	public List<Daily> findDaily_tag(String tag);
	
	public List<String> findDailyimg(Integer daily_id);
	
	public int saveDocument(Integer user_id,String content);
	
	public String getDocument(Integer user_id);
	
	public int deleteDocument(Integer user_id);
	
}
