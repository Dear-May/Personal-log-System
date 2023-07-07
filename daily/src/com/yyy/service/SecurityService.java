package com.yyy.service;

public interface SecurityService {

	public boolean passwordSecurityCheck(String password);
	
	public String mixPasswordWithSalt(String password, String salt);
	
	public String SHA256Encrypt(String str);
	
	public String generateSalt();
	
	public String generateToken();
	
	public String generateRandomString(int length);
	
	
}
