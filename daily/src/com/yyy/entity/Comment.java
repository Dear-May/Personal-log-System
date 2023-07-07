package com.yyy.entity;

import java.io.Serializable;//用于标记实现了它的类可以被对象序列化和反序列化。对象序列化可以将Java中的对象转换为字节流，以便在网络上传输或将其保存到磁盘上。而反序列化则将字节流还原为Java对象

//评论
public class Comment implements Serializable{
    private static final long serialVersionUID = 1L;
    
    private Integer id;   //评论的唯一标识符，使用自动生成的主键
    private Integer daily_id;   //被评论的日记的 ID
    private String user_name;   //评论者的用户名
    private Integer user_id;   //评论者的用户 ID
    private String com_detail;   //评论的内容
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Integer getDaily_id() {
        return daily_id;
    }
    public void setDaily_id(Integer daily_id) {
        this.daily_id = daily_id;
    }
    
    public String getUser_name() {
        return user_name;
    }
    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
    
    public Integer getUser_id() {
        return user_id;
    }
    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }
    
    public String getCom_detail() {
        return com_detail;
    }
    public void setCom_detail(String com_detail) {
        this.com_detail = com_detail;
    }
    
}
