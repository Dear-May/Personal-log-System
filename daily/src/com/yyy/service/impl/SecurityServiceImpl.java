package com.yyy.service.impl;

import java.security.MessageDigest;
import java.util.Random;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.service.SecurityService;

@Service("SecurityService")   
@Transactional  
public class SecurityServiceImpl implements SecurityService {
	
	public boolean passwordSecurityCheck(String password)	/* ���밲ȫ�Լ�� */
	{
		boolean lower=false,upper=false,number=false;
		//String regEx = "[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~��@#��%����&*��������+|{}������������������������]|\n|\r|\t";
        //character = Pattern.compile(regEx).matcher(password).find();	//������ʽ��ѯ�Ƿ��������ַ�
		int _length=password.length();
		if (_length<8) return false;	//̫�̵����벻��
		for (int i=0;i<_length;i++)
		{
			char _tmp=password.charAt(i);
			if (_tmp >='A' && _tmp<='Z')
				upper=true;
			else if (_tmp >='a' && _tmp<='z')
				lower=true;
			else if (_tmp >='0' && _tmp<='9')
				number=true;
		}
		if(lower && upper && number)
			return true;
		return false;
	}
	
	public String mixPasswordWithSalt(String password, String salt)
	{
		return salt+password+salt;
	}
	
	public String SHA256Encrypt(String str)
	{
		MessageDigest _messageDigest;
		String _encodeStr = "";
		try 
		{
			_messageDigest = MessageDigest.getInstance("SHA-256");
		 	_messageDigest.update(str.getBytes("UTF-8"));
		 	_encodeStr = byte2Hex(_messageDigest.digest());
		}
		catch (Exception e)
		{
		}
		return _encodeStr;
	}
	
	private String byte2Hex(byte[] bytes){
		StringBuffer stringBuffer = new StringBuffer();
		String temp = null;
		for (int i=0;i<bytes.length;i++){
			temp = Integer.toHexString(bytes[i] & 0xFF);
			if (temp.length()==1){
				//1�õ�һλ�Ľ��в�0����
				stringBuffer.append("0");
			}
			stringBuffer.append(temp);
		}
		return stringBuffer.toString();
	}
	
	public String generateSalt()	/* ������ */
	{
		return generateRandomString(10);
	}
	
	public String generateToken()	/* ����TOKEN */
	{
		return generateRandomString(64);
	}
	
	public String generateRandomString(int length)
	{
		Random r = new Random();
		final String _CHAR="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		String _str="";
		for (int i=0;i<length;i++)
		{
			_str+=_CHAR.charAt(r.nextInt(_CHAR.length()));
		}
		return _str;
	}
	
	public boolean detectStringIsInvalid(String str)
	{
		return (str == null || "".equals(str));
	}
}
