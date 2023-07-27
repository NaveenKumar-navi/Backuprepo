package com.example.demo.controller;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

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

import com.example.demo.Dto.AttendanceListDto;
import com.example.demo.Dto.EmployeeAttendanceDto;
import com.example.demo.Dto.PunchDto;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.response.ResponseGenerator;
import com.example.demo.response.TransactionContext;
import com.example.demo.service.AttendenceService;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.NonNull;

@CrossOrigin(origins = "*",maxAge = 3600)
@RestController
@AllArgsConstructor(onConstructor_ = { @Autowired })
@RequestMapping("/employee/attendence")
public class AttendenceController {
	
	private static final Logger logger = Logger.getLogger(AttendenceController.class);
	
	private @NonNull AttendenceService attendenceService;
	
	private @NonNull UserRepository userRepository;
	
	private @NonNull ResponseGenerator responseGenerator;

	@ApiOperation(value = "Api to Attendance checkIn & checkOut Insert")
	@RequestMapping(value = "/punch", method = RequestMethod.POST, consumes = "application/json", produces = "application/json")
	public ResponseEntity<?> attendenceCheckIn(@RequestHeader HttpHeaders httpHeader, Principal principle,@RequestBody PunchDto request) {
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
		String name = null;
		User user = null;
		try {
			name = principle.getName();
			
			Optional<User> userInfo =  userRepository.findByUserName(name);
             	user = userInfo.get();
             
             EmployeeAttendanceDto empData =  new EmployeeAttendanceDto();
             
			if(request.getCheckIn() == null)
				empData = attendenceService.attendenceCheckOut(request,user.getEmployee().getEmployeeId());
			else
				empData = attendenceService.attendenceCheckIn(request,user.getEmployee().getEmployeeId());
			
			 return responseGenerator.successGetResponse(context, "Punched successfully", empData,HttpStatus.OK);
			 
		}catch(Exception e){
			
			e.printStackTrace();
			logger.error("Error in employee creation :" + e.getMessage(), e);
			return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);
			
		}
		
	}

	@ApiOperation(value = "Api to Employee CheckIn & CheckOut Data")
	@RequestMapping(value = "/getCheckInData", method = RequestMethod.GET, consumes = "application/json", produces = "application/json")
	public ResponseEntity<?>getEmployeeCheckInData(@RequestBody AttendanceListDto request,@RequestHeader HttpHeaders httpHeader,Principal principle) {
		
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
		
		
		try {
				String name = principle.getName();
				
				Optional<User> userInfo =  userRepository.findByUserName(name);
		        User user = userInfo.get();
		         
				List<EmployeeAttendanceDto>attendanceList = attendenceService.getCheckInData(request,user.getEmployee().getEmployeeId());
				
				return responseGenerator.successGetResponse(context,"success", attendanceList, HttpStatus.OK);
				
			} catch(Exception e){
				
				e.printStackTrace();
				logger.error("Error in employee creation :" + e.getMessage(), e);
				return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);
				
		}
		
	}
	
	
}
