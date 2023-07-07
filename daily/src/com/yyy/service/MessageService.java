package com.yyy.service;

import java.util.List;

import com.yyy.entity.Message;

public interface MessageService {
	
    public List<Message> findMessages(Integer owner_id,Integer sendto);
    
    public int addMessage(Message message);
}
