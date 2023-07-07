package com.yyy.controller;

import java.sql.Timestamp;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.yyy.entity.Message;
import com.yyy.service.MessageService;

@RestController
public class LetterRestController {
	
    @Autowired
    MessageService messageService;
    
    //将用户发送的私信信息保存到数据库中
    @ResponseBody
    @RequestMapping(value="/letter/add",method=RequestMethod.POST)
    public Message addMessage(@RequestBody Message message) {
    	
    	Date date = new Date();
    	Message msg = new Message();
    	msg.setSender(message.getSender());
    	msg.setReceiver(message.getReceiver());
    	msg.setOwner_id(message.getSendto());
    	msg.setDetails(message.getDetails());
    	msg.setSendto(message.getOwner_id());
    	Timestamp timeStamp = new Timestamp(date.getTime());
    	message.setTime(timeStamp);
	
    	msg.setSender(message.getSender());
    	msg.setReceiver(message.getReceiver());
    	msg.setOwner_id(message.getSendto());
    	msg.setDetails(message.getDetails());
    	msg.setSendto(message.getOwner_id());
    	msg.setTime(message.getTime());
	 
    	messageService.addMessage(message);
    	messageService.addMessage(msg);
    	return message;		
    	
    }	
}
