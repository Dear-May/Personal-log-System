package com.yyy.service.impl;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.FriendDao;
import com.yyy.entity.Friend;
import com.yyy.service.FriendService;

@Service("friendService")
@Transactional

public class FriendServiceImpl implements FriendService {
	
	@Autowired
	private FriendDao friendDao;
	
	@Override
	public List<Friend> findFriendList(Integer owner_id) {
		List<Friend> list =friendDao.selectFriendList(owner_id);
		return list;
	    }

	@Override
	public int addUser(Integer id) {
		return friendDao.addUser(id);	
		}

	@Override
	public int addFriendRequest(Integer from_id, Integer to_id) {
	    return friendDao.addFriendRequest(from_id, to_id);
	}

	@Override
	public List<Integer> findFriendRequest(Integer to_id) {
	    return friendDao.findFriendRequest(to_id);
	}

	@Override
	public int deleteFriendRequest(Integer to_id) {
	    return friendDao.deleteFriendRequest(to_id);
	}

	@Override
	public int addFriend(Integer owner_id,Integer friend_id) { 
	    return friendDao.addFriend(owner_id,friend_id);
	}   
	    
}
