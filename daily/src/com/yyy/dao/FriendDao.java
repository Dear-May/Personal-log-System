package com.yyy.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yyy.entity.Friend;

public interface FriendDao {
    
	public List<Friend> selectFriendList(Integer owner_id);   //查询指定用户 ID 的所有好友
	 
	public int addUser(Integer id);   //当前用户发起了与目标用户的添加好友请求(response)
	
	public int addFriendRequest(@Param("from_id") Integer from_id,@Param("to_id") Integer to_id);   //当前用户向目标用户发起了添加好友请求(addfriend)
	
	public List<Integer> findFriendRequest(Integer to_id);   //查询某个用户接收到的所有未处理的添加好友请求的发送方 ID
	
	public int deleteFriendRequest(Integer from_id);   //删除某个添加好友请求的记录
	
	public int addFriend(@Param("owner_id")Integer owner_id,@Param("friend_id")Integer friend_id);   //当前用户添加了指定用户为好友
	
}
