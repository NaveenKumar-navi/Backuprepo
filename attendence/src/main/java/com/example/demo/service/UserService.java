package com.example.demo.service;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;

import lombok.AllArgsConstructor;
import lombok.NonNull;

@Service
@Transactional
@AllArgsConstructor(onConstructor_ = { @Autowired })
public class UserService implements UserDetailsService{

	private @NonNull UserRepository userRepository;



	public User findByUserName(String userName) {

		return userRepository.findByUserName(userName).get();
	}

	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<User> userOptional = userRepository.findByUserName(username);
		if (!userOptional.isPresent()) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		User user = userOptional.get();
		return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(),
				getAuthority());
	}
	
	private List<SimpleGrantedAuthority> getAuthority() {
		return Arrays.asList(new SimpleGrantedAuthority("ROLE_ADMIN"));
	}
	
//	public Optional<User> findByEmailId(String emailId) {
//		return userRepository.findByEmailId(emailId);
//	}

//	public String forgotpwd() throws ExecutionException {
//		// TODO Auto-generated method stub
//		String otpmessage = otpservice.generateOtp();
//
//		return otpmessage;
//	}
//
//	public User changePasswordFlag(String emailId) {
//
//		Optional<User> userOptional = userRepository.findByEmailId(emailId);
//
//		User user = userOptional.get();
//
//		user.setChangePasswordFlag("Y");
//
//		
//		return userRepository.save(user);
//	}


}
