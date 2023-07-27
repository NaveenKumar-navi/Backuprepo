package com.example.demo.service.Impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Dto.LoginDto;
import com.example.demo.Utils.PasswordUtil;
import com.example.demo.entity.User;
import com.example.demo.repository.EmployeeRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.security.JwtTokenUtil;
import com.example.demo.service.AuthenticationService;

import lombok.AllArgsConstructor;
import lombok.NonNull;

@Transactional
@Service
@AllArgsConstructor(onConstructor_ = { @Autowired })
public class AuthenticationServiceImpl implements AuthenticationService {

	private @NonNull UserRepository userRepository;

	private @NonNull JwtTokenUtil jwtTokenUtil;

	private @NonNull UserRepository repo;
	
	private @NotNull EmployeeRepository employeeRepository;


	@Override
	public Map<String, Object> logIn(LoginDto request) {

		Map<String, Object> response = new HashMap<String, Object>();

		Optional<User> userOptional = userRepository.findByUserName(request.getUserName());

		if (!userOptional.isPresent()) {
			response.put("Error", "Invalid Username.!");
			return response;
		}
		if (userOptional.isPresent()) {
			User user = userOptional.get();
			//Optional<Employee> employeeObj = employeeRepository.findById(user.getEmployee().getEmployeeId());
			//Optional<UserRole> UserRoleObj = userRoleRepository.findByRoleId(user.getUserRoleId());
			String encryptedPassword = PasswordUtil.getEncryptedPassword(request.getPassword());
			if (!user.getPassword().equals(encryptedPassword)) {
				response.put("Error", "Password is wrong.!");
				return response;
			}
			if (user.getPassword().equals(encryptedPassword)) {
				final String token = jwtTokenUtil.generateToken(user);
//				Optional<UserRole> userRoleOptional = userRoleRepository.findByRoleId(user.getUserRoleId());
//				if (userRoleOptional.isPresent()) {
//					response.put("Role", userRoleOptional.get().getRoleName());
//				}

				response.put("status", "Success");
				//response.put("message", "Logged in Successfully.!");
				response.put("jwt", token);
//				response.put("changePasswordFlag", user.getChangePasswordFlag());
//				if(UserRoleObj.isPresent()) {
//				response.put("Role", UserRoleObj.get().getRoleName());
//				}
//				if(employeeObj.isPresent()) {
//				response.put("EmployeeName", employeeObj.get().getFirstName()+' '+ employeeObj.get().getLastName());
//				response.put("EmployeeId", employeeObj.get().getEmployeeId());
//				}
				return response;
			}
		}
		return null;
	}


	@Override
	public UUID saveUser(@Valid User request) {
		// TODO Auto-generated method stub
		return null;
	}

//	public String changePassword(ChangePasswordDto request, Principal principal) {
//
////		if (null == request) {
////			return "give correct payload";
////		}
//
//		Optional<User> userOptional = repo.findByUserName(principal.getName());
//		User user = userOptional.get();
//		String encryptedNewPassword = PasswordUtil.getEncryptedPassword(request.getNewPassword());
//		
//		if (!request.getNewPassword().equals(request.getConfirmPassword())) {
//			return "password mismatch";
//		}
//
//		else {
//			user.setPassword(encryptedNewPassword);
//			user.setChangePasswordFlag("N");
//			repo.save(user);
//
//			return "password updated successfully";
//
//		}
//
//	}
//
//	@Override
//	public UUID saveUser(@Valid User request) {
//		userRepository.save(request);
//		return null;
//	}
//
//	@Override
//	public String updatePassword(ChangePasswordDto request) {
//		
//		Optional<User> userOptional = repo.findByUserId(request.getUserId());
//		if(userOptional.isPresent()) {
//		User user = userOptional.get();
//		if (!request.getNewPassword().equals(request.getConfirmPassword())) {
//			return "password mismatch";
//		}else {
//			String encryptedNewPassword = PasswordUtil.getEncryptedPassword(request.getNewPassword());
//			user.setPassword(encryptedNewPassword);
//			user.setChangePasswordFlag("N");
//			repo.save(user);
//
//			return "password updated successfully";
//
//		}
//		}
//		return null;
//	}

}
