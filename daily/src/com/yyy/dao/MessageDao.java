package com.yyy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yyy.entity.Message;

public interface MessageDao {
    
    public List<Message> findMessagesByOwner_id(@Param("owner_id")Integer owner_id,@Param("sendto") Integer sendto);   //查询指定用户 ID 发送给指定好友 ID 的所有消息
    
    public int addMessage(Message message);   //发送者向接收者发送了一条消息
    
}
