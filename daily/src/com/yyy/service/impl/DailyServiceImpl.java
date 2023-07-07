package com.yyy.service.impl;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.DailyDao;
import com.yyy.entity.Daily;
import com.yyy.service.DailyService;

@Service("dailyService")  
@Transactional

public class DailyServiceImpl implements DailyService {
	
	@Autowired
	private DailyDao dailyDao;
	
	@Override
	public List<Daily> findDailyList(Integer user_id) {
		List<Daily> list =dailyDao.selectDailyList(user_id);
		return list;
		}
 
	@Override
	public int createDaily(Daily daily) {
	    return dailyDao.createDaily(daily);
	}
	
	@Override
	public int deleteDaily(Integer id) {
	    return dailyDao.deleteDaily(id);	
	}

	@Override
	public List<Daily> findFriendDaily(Integer user_id) {
	    return dailyDao.findFriendDaily(user_id);
	}

	@Override
	public int updateDaily(Daily daily) {
	    return dailyDao.updateDaily(daily);
	}

	@Override
	public int findUser_id(Integer daily_id) {
	    return  dailyDao.findUser_id( daily_id);
	}
	
	@Override
	public int findDaliylike(Integer daily_id) {
	    return  dailyDao.findDaliylike( daily_id);
	}
	
	@Override
	public int updateDaliylike(Integer daily_id) {
	    return  dailyDao.updateDaliylike( daily_id);
	}

	@Override
	public int deleteDailylike(Integer daily_id) {
		return dailyDao.deleteDaliylike(daily_id);
	}

	@Override
	public List<Daily> findDaily_tag(String tag) {
		tag = "%" + tag + "%";
		return dailyDao.findDaily_tag(tag);
	}

	@Override
	public List<String> findDailyimg(Integer daily_id) {
		String text=dailyDao.findDaily_details(daily_id);
		// 使用正则表达式匹配<img>标签
		Pattern pattern = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>");
		Matcher matcher = pattern.matcher(text);
		
        List<String> results = new ArrayList<>();
        
        // 判断是否存在<img>标签
        if (matcher.find()) {
            // 存在<img>标签
            results.add("OK");
            String srcValue = matcher.group(1);
            String[] parts = srcValue.split("/");
            String imageName = parts[parts.length - 1];
            results.add(imageName);
        } else {
            // 不存在<img>标签
            results.add("no");
            results.add("0");
        }
        return results;      
	}

	@Override
	public int saveDocument(Integer user_id, String content) {
		return dailyDao.saveDocument(user_id, content);
	}

	@Override
	public String getDocument(Integer user_id) {
		return dailyDao.getDocument(user_id);
	}

	@Override
	public int deleteDocument(Integer user_id) {
		return dailyDao.deleteDocument(user_id);
	}
	
}
