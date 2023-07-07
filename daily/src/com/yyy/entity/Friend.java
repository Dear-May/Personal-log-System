package com.yyy.entity;

import java.io.Serializable;

//好友
public class Friend implements Serializable{
    private static final long serialVersionUID = 1L;
    
    private Integer owner_id;   //拥有该好友关系的用户ID
    private Integer friend_id;   //该用户的好友的用户ID
    private String ownerPicture;   //拥有该好友关系的用户的头像
    private String friendPicture;   //该用户的好友的头像
    private String friendName;   //该用户的好友的名称
    
    public Integer getOwner_id() {
        return owner_id;
    }
    public void setOwner_id(Integer owner_id) {
        this.owner_id = owner_id;
    }
    
    public Integer getFriend_id() {
        return friend_id;
    }
    public void setFriend_id(Integer friend_id) {
        this.friend_id = friend_id;
    }
    
    public String getOwnerPicture() {
        return ownerPicture;
    }
    public void setOwnerPicture(String ownerPicture) {
        this.ownerPicture = ownerPicture;
    }
    
    public String getFriendPicture() {
        return friendPicture;
    }
    public void setFriendPicture(String friendPicture) {
        this.friendPicture = friendPicture;
    }
    
    public String getFriendName() {
        return friendName;
    }
    public void setFriendName(String friendName) {
        this.friendName = friendName;
    }
    
}
