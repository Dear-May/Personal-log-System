package com.yyy.service;
import java.util.List;

import com.yyy.entity.Friend;

public interface FriendService {
	
	public List<Friend> findFriendList(Integer owner_id);
		
	public int addUser(Integer id);
	
	public int addFriendRequest(Integer from_id, Integer to_id);
	
	public List<Integer> findFriendRequest(Integer to_id);
	
	public int deleteFriendRequest(Integer to_id);
	
	public int addFriend(Integer owner_id,Integer friend_id);
	
}
