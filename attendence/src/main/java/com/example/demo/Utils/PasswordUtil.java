package com.example.demo.Utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.apache.commons.codec.binary.Hex;

public class PasswordUtil {

	public static String getEncryptedPassword(String password) {
		MessageDigest algorithm;
		try {
			algorithm = MessageDigest.getInstance("SHA-1");
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("SHA-1 algorithm not found!");
		}
		byte[] digest = algorithm.digest(password.getBytes());
		return new String(Hex.encodeHex(digest));
	}

	public static String alphaNumericString(int len) {

		String AB = "0123456789";
		String pwd = "Extendo@";
		String Password = "";

		Random rnd = new Random();

		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++) {
			sb.append(AB.charAt(rnd.nextInt(AB.length())));
			Password = pwd + sb.toString();
		}
		return Password;
	}

}
