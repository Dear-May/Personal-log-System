package com.yyy.entity;

import java.io.Serializable;
import java.util.Date;

//消息
public class Message implements Serializable{
    private static final long serialVersionUID = 1L;
    
    private Integer sender;   //消息的唯一标识符
    private Integer receiver;   //消息的发送者ID
    private Integer owner_id;   //拥有该消息的用户ID
    private Integer sendto;   //被该消息所发送的用户ID
    private String details;   //消息的具体内容
    private Date time;   //消息发送时间
    
    public Integer getSender() {
        return sender;
    }
    public void setSender(Integer sender) {
        this.sender = sender;
    }
    
    public Integer getReceiver() {
        return receiver;
    }
    public void setReceiver(Integer receiver) {
        this.receiver = receiver;
    }
    
    public Integer getOwner_id() {
        return owner_id;
    }
    public void setOwner_id(Integer owner_id) {
        this.owner_id = owner_id;
    }
    
    public Integer getSendto() {
        return sendto;
    }
    public void setSendto(Integer sendto) {
        this.sendto = sendto;
    }
    
    public String getDetails() {
        return details;
    }
    public void setDetails(String details) {
        this.details = details;
    }
    
    public Date getTime() {
        return time;
    }
    public void setTime(Date time) {
        this.time = time;
    }
    
}
