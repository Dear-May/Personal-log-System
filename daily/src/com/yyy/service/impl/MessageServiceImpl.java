package com.yyy.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.MessageDao;
import com.yyy.entity.Message;
import com.yyy.service.MessageService;

@Service("messageService")   
@Transactional                

public class MessageServiceImpl implements MessageService{

    @Autowired
    MessageDao messageDao;
    
    @Override
    public List<Message> findMessages(Integer owner_id,Integer sendto) {
    	List<Message> messages = messageDao.findMessagesByOwner_id(owner_id,sendto);
    	return messages;
    }
    
    @Override
    public int addMessage(Message message) { 
    	return messageDao.addMessage(message);
    }

}
