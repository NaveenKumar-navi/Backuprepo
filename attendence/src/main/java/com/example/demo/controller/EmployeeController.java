package com.example.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.validation.Valid;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.Dto.EmployeeDtlUploadDto;
import com.example.demo.Dto.EmployeeDto;
import com.example.demo.Helper.Helper;
import com.example.demo.entity.Employee;
import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.response.Response;
import com.example.demo.response.ResponseGenerator;
import com.example.demo.response.TransactionContext;
import com.example.demo.service.EmployeeService;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.NonNull;

@CrossOrigin(origins = "*",maxAge = 3600)
@RestController
@AllArgsConstructor(onConstructor_ = { @Autowired })
@RequestMapping("/employee")
public class EmployeeController {
	
private static final Logger logger = Logger.getLogger(AttendenceController.class);
	
	private @NonNull EmployeeService employeeService;
	
	private @NonNull UserRepository  userRepo;
	
	private @NonNull Helper excelService;
	
	private @NonNull ResponseGenerator responseGenerator;
	
	@ApiOperation(value = "API to Employee Fetched..", response = Response.class)
	@GetMapping(value = "/getEmployee", produces = "application/json")
	private ResponseEntity<Response> fetchs(Principal principal, @RequestHeader HttpHeaders httpHeader)
			throws Exception {
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
		
		String name = principal.getName();
		
		Optional<User> user = userRepo.findByUserName(name);
		
		User userInfo = user.get();
		
		Optional<Employee> employee =  employeeService.getEmployeeDetails(userInfo.getEmployee().getEmployeeId());
		try {
			if(employee.isPresent()) {
				return responseGenerator.successGetResponse(context, "Employee Fetched successfully", employee, HttpStatus.OK);
			} else {
				return responseGenerator.successGetResponse(context, "No Data Found", employee, HttpStatus.OK);	
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
	}
	
	@ApiOperation(value = "API to Employee Update..", response = Response.class)
	@PutMapping(value = "/update", produces = "application/json")
	private ResponseEntity<?> Update(Principal principal, @RequestBody EmployeeDto request, @RequestHeader HttpHeaders httpHeader)
			throws Exception {
		
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
		
		String name = principal.getName();
		
		Optional<User> user = userRepo.findByUserName(name);
		
		User userInfo = user.get();

		employeeService.update(request,userInfo.getEmployee().getEmployeeId());
		
		try {
			return responseGenerator.successResponse(context,"Employee Updated Successfully", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);
		}

	}
	
	@ApiOperation(value = "API to Employee Create..", response = Response.class)
	@PostMapping(value = "/create", produces = "application/json")
	public ResponseEntity<?> create(@ApiParam(value = "Request payload") @Valid @RequestBody Employee request,
			@RequestHeader HttpHeaders httpHeader) throws Exception {
	
		TransactionContext context = responseGenerator.generateTransationContext(httpHeader);
		
		try {
			employeeService.save(request);
			return responseGenerator.successResponse(context,"Employee Insert Successfully", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return responseGenerator.errorResponse(context,e.getMessage(), HttpStatus.BAD_REQUEST);
		}
	}
	
	@ApiOperation(value = "API to Employee Excel Upload..", response = Response.class)
	@RequestMapping(value = "/upload", method = RequestMethod.POST, produces = "application/json")
	public ResponseEntity<?> uploadFile(@RequestParam("file") MultipartFile file,
	@RequestHeader HttpHeaders httpHeader) throws Exception {
		
	TransactionContext context = responseGenerator.generateTransationContext(httpHeader);

	EmployeeDtlUploadDto data = excelService.uploadExcelConditions(file);
	
	String total = String.valueOf(data.getTotalRecords());
	String error = String.valueOf(data.getErrorRecords());
	String upload = String.valueOf(data.getUploadRecords());
	try {
			if (data.getEmployeeDtlList().isEmpty()) {
				return responseGenerator.successResponse(context, total + " Records are upload successfully",
				HttpStatus.OK);
			} else {
				String errorMessage = "Total Records: " + total + " Error Records: " + error + " Upload Records : "
				+ upload + " Review the details please download the error excel";
				return responseGenerator.errorResponse(context, errorMessage, HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return responseGenerator.errorResponse(context, e.getMessage(), HttpStatus.BAD_REQUEST);
	 	}
	}
	
	@ApiOperation(value = "API to Employee Image Upload..", response = Response.class)
	@RequestMapping(value = { "/upload/profile" }, method = { RequestMethod.POST }, consumes = { "multipart/form-data" })
	public ResponseEntity<Object> uploadFile(@RequestParam("file") MultipartFile file) {
		
	try {
			UUID uuid = UUID.randomUUID();
			
			String extension = FilenameUtils.getExtension(file.getOriginalFilename());
			
			File path = new File("D:\\Naveen\\Naveen\\attendence\\src\\upload\\" + uuid.toString() + "." + extension);
			logger.debug("Photo url : " + path);
			path.createNewFile();
			
			FileOutputStream output = new FileOutputStream(path);
			output.write(file.getBytes());
			output.close();
			logger.debug("Photo url : " + file.getOriginalFilename());
			
			return ResponseGenerator.generateResponse(HttpStatus.OK, uuid.toString() + "." + extension,
			"File is uploaded successfully!");
			
		} catch (Exception e) {
			return ResponseGenerator.generateResponse(HttpStatus.MULTI_STATUS, e.getMessage(), null);
		}
	}
	
	@ApiOperation(value = "API to Employee Image Get..", response = Response.class)
	@GetMapping("/getimage/{loadedImagesUrl:.+}")
	public ResponseEntity<Resource> getFile(@PathVariable String loadedImagesUrl) throws IOException {
		
		Resource file = employeeService.getImage("D:/Naveen/Naveen/attendence/src/upload/" + loadedImagesUrl);
		logger.debug("loadedImagesUrl :" + file);
		
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, "image/png").body(file);
	}
	

	@ApiOperation(value = "Employee Dropdown List")
	@RequestMapping(value = "/getEmpDropDown", method = RequestMethod.GET, consumes = "application/json", produces = "application/json")
	private Map<Long,String> fetchs()throws Exception {
		
		Map<Long, String> employee =  employeeService.findAll();
		try {
			return responseGenerator.successResponse( employee + " Records are fetched successfully",
					HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage(), e);
			return responseGenerator.successResponse( employee + " Records are fetched successfully",
					HttpStatus.OK);
		}
		
	}

}
