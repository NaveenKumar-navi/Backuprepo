package com.example.demo.controller;

import java.util.Map;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.Dto.LoginDto;
import com.example.demo.response.ResponseGenerator;
import com.example.demo.response.TransactionContext;
import com.example.demo.security.JwtTokenUtil;
import com.example.demo.service.AuthenticationService;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.NonNull;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/auth")
@AllArgsConstructor(onConstructor_ = { @Autowired })
public class AuthController {

	private static final Logger logger = Logger.getLogger(AuthController.class);

	private @NonNull ResponseGenerator responseGenerator;
	
	private @NonNull JwtTokenUtil jwtTokenUtil;
	
	private @NonNull AuthenticationService authenticationService;


	@ApiOperation(value = "Logs the user in to the system and return the auth tokens")
	@RequestMapping(value = "/login", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public ResponseEntity<?> login(@RequestBody LoginDto request, @RequestHeader HttpHeaders httpHeader)
			throws Exception {
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);

		try {

			Map<String, Object> response = authenticationService.logIn(request);
			if (response.containsKey("Error")) {
				return responseGenerator.errorResponse(context,"UserName OR Password Incorrect",HttpStatus.BAD_REQUEST);
			}
			return responseGenerator.successGetResponse(context, "Login successfully", response,
					HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Error in LogIn: " + e.getMessage(), e);
			return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);

		}
	}

//	@ApiOperation(value = "change the old password with new password")
//	@RequestMapping(value = "/changePassword", method = RequestMethod.PUT, consumes = "application/json", produces = "application/json")
//	public ResponseEntity<?> changePassword(@RequestBody ChangePasswordDto request, Principal principal,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//
//		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			if (!(request.getChangePasswordFlag().equals("Y"))) {
//				return responseGenerator.errorResponse(context, "changePasswordFlag should be Y",
//						HttpStatus.BAD_REQUEST);
//			}
//
//			String response = authenticationService.changePassword(request, principal);
//
//			if (response == "password mismatch") {
//
//				return responseGenerator.errorResponse(context,
//						"confirm password mismatch", HttpStatus.BAD_REQUEST);
//
//			}
//			if (response == "password updated successfully") {
//
//				return responseGenerator.successResponse(context, "", response,
//						HttpStatus.OK);
//
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error("Error in LogIn: " + e.getMessage(), e);
//			return responseGenerator.errorResponse(e.getMessage(),"", HttpStatus.BAD_REQUEST);
//
//		}
//		return null;
//	}

//	@ApiOperation(value = "API to User Create..", response = Response.class)
//	@PostMapping(value = "/user/create", produces = "application/json")
//	public ResponseEntity<?> createUser(@ApiParam(value = "Request payload") @Valid @RequestBody User request,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
//		try {
//			UUID response = authenticationService.saveUser(request);
//			return responseGenerator.successResponse(context, "", HttpStatus.OK);
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error("Error in User create: " + e.getMessage(), e);
//			return responseGenerator.errorResponse(context, e.getMessage(), HttpStatus.BAD_REQUEST);
//		}
//	}

//	@PostMapping(value = "/forgotpassword", produces = "application/json")
//	private ResponseEntity<?> Forgotpassword(@Valid @RequestBody OtpDTO request, @RequestHeader HttpHeaders httpHeader,
//			HttpServletRequest requestToken) throws Exception {
//		Map<String, Object> response = new HashMap<String, Object>();
//		try {
//			Optional<User> userOptional = userService.findByEmailId(request.getEmailId());
//			ErrorDto errorDto = null;
//			logger.info("\n\n\n" + userOptional);
//			if (userOptional.isPresent()) {
//				String userobject = userService.forgotpwd();
//				User user = userOptional.get();
//				Optional<Otp> otpOptional = otpService.findByEmailId(request.getEmailId());
//				if (otpOptional.isPresent()) {
//					Otp aOtp = otpOptional.get();
//					// aOtp.setUserId(user.getUserId());
//					// aOtp.setEmailId(request.getEmailId());
//					 aOtp.setCraeteDate(LocalDateTime.now());
//
//					aOtp.setOtpNumber(userobject);
//					otpService.saveAndFlush(aOtp);
//				} else {
//					Otp otp = new Otp();
//					otp.setUserId(user.getUserId());
//					otp.setEmailId(request.getEmailId());
//					 otp.setCraeteDate(LocalDateTime.now());
//
//					otp.setOtpNumber(userobject);
//					otpService.saveAndFlush(otp);
//				}
//				otpService.sendSimpleEmail(userobject, user.getEmailId());
//				response.put("message", "OTP Send Successfully.!");
//				return ResponseEntity.ok().body(response);
//			} else {
//				errorDto = new ErrorDto();
//				errorDto.setCode("400");
//				errorDto.setMessage("Invalid Username Or mail Id.!");
//				response.put("status", 0);
//				response.put("error", errorDto);
//				return ResponseEntity.badRequest().body(response);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error(e.getMessage(), e);
//			return responseGenerator.errorResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
//		}
//	}
//
//	@PostMapping(value = "/checkotp", produces = "application/json")
//	private ResponseEntity<?> checkOtp(@Valid @RequestBody CheckOtp request) throws Exception {
//		Map<String, Object> response = new HashMap<String, Object>();
//		try {
//			ErrorDto errorDto = null;
//			Optional<Otp> otpOptional = otpService.findByEmailIdAndOtpNumber(request);
//			Otp otp = otpOptional.get();
//			String requestOtp = request.getOtp();
//			String repoOtp = otp.getOtpNumber();
//			if (otpOptional.isPresent()) {
//				if (requestOtp.equals(repoOtp)) {
//					response.put("status", "Success");
//					response.put("message", "Otp Verify Successfully.!");
//					User userOptional = userService.changePasswordFlag(request.getEmailId());
//					response.put("UserId", userOptional.getUserId());
//					return ResponseEntity.ok().body(response);
//				}
//				errorDto = new ErrorDto();
//				errorDto.setCode("400");
//				errorDto.setMessage("Invalid Otp....!");
//				response.put("status", 0);
//				response.put("error", errorDto);
//				return ResponseEntity.badRequest().body(response);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error(e.getMessage(), e);
//			return responseGenerator.errorResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
//		}
//		return null;
//	}
//
//	@ApiOperation(value = "change the old password with new password")
//	@RequestMapping(value = "/updatepassword", method = RequestMethod.PUT, consumes = "application/json", produces = "application/json")
//	public ResponseEntity<?> updatePassword(@RequestBody ChangePasswordDto request,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//
//		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			String response = authenticationService.updatePassword(request);
//
//			if (response == "password mismatch") {
//
//				return responseGenerator.errorGetResponse(context, messageSource.getMessage("mismatch"),
//						"confirm password mismatch", HttpStatus.BAD_REQUEST);
//
//			}
//			if (response == "password updated successfully") {
//
//				return responseGenerator.successGetResponse(context, messageSource.getMessage("success"), response,
//						HttpStatus.OK);
//
//			}
//
//		} catch (Exception e) {
//			e.printStackTrace();
//			logger.error("Error in LogIn: " + e.getMessage(), e);
//			return responseGenerator.errorResponse(e.getMessage(), HttpStatus.BAD_REQUEST);
//
//		}
//		return null;
//	}

}
