package com.example.demo.service.Impl;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.SecureRandom;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.example.demo.Dto.EmployeeDto;
import com.example.demo.entity.Employee;
import com.example.demo.entity.User;
import com.example.demo.repository.EmployeeRepository;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.EmployeeService;


@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeRepository employeeRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private JavaMailSender mailSender;
	
	private final Path root = Paths.get("get");

	@Override
	public Optional<Employee> getEmployeeDetails(Long empid) {
		return employeeRepo.findById(empid);
	}

	@Override
	public Employee save(@Valid Employee request) {
		return employeeRepo.save(request);
	}

	@Override
	public Employee update(EmployeeDto request,Long empId) {
		Optional<Employee> employeeData = employeeRepo.findById(empId);
		Employee empl = employeeData.get();

		empl.setEmpName(request.getEmpName());
		empl.setMobileNo(request.getMobileNo());
		empl.setEmail(request.getEmail());
		empl.setDesignation(request.getDesignation());
		empl.setAddress(request.getAddress());

		return employeeRepo.save(empl);
	}

	@Override
	public Employee save(EmployeeDto empDtl) {
		
		Employee empData = Employee.builder()
				.empName(empDtl.getEmpName())
                .mobileNo(empDtl.getMobileNo())		
                .email(empDtl.getEmail())
                .address(empDtl.getAddress())
                .designation(empDtl.getDesignation())
				.build();
		employeeRepo.save(empData);
		

//		Employee empObj = new Employee();
//
//		empObj.setEmpName(empDtl.getEmpName());
//		empObj.setAddress(empDtl.getAddress());
//		empObj.setEmail(empDtl.getEmail());
//		empObj.setMobileNo(empDtl.getMobileNo());
//		empObj.setDesignation(empDtl.getDesignation());
//
//		Employee employee = employeeRepo.save(empObj);

//		User user = new User();
//		user.setUserName(employee.getEmail());
//		user.setEmployee(employee);

		 SecureRandom random = new SecureRandom();
	        StringBuilder password = new StringBuilder();
	        int length = 5;
	         String CHARACTERS = "0123456789";
	         String common = "Extendo@";

	        for (int i = 0; i < length; i++) {
	            int randomIndex = random.nextInt(CHARACTERS.length());
	            char randomChar = CHARACTERS.charAt(randomIndex);
	            password.append(randomChar);
	        }	
	        
	        String pass = common + password.toString();
	        
			User user = User.builder()
					.userName(empData.getEmail())
					.password(pass)
					.employee(empData)
					.build();
			userRepo.save(user);
			
			sendSimpleEmails(user.getUserName(),pass);

			return empData ;
		}


	public void sendSimpleEmails(String emailId, String password) {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		try {
			MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true);
			message.setFrom("donotreply@extendotech.com");
			message.setTo(emailId);
			message.setText("Welcome To Extendo Technologies.... " + "\n" + "\n" + "Hi Extendo User......" + "\t"
					+ emailId + "\n" + "\n" + "UserName :" + emailId + "\n" + "\n" + "Password : " + password + "\n"
					+ "\n" + "\n" + "\n " + "Thanks For Login....!!!");

			message.setSubject("Extendo Login Credential");
			mailSender.send(mimeMessage);
			System.out.println("Mail Send...");
		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}
	
	
	public Resource getImage(String loadedImagesUrl) {
		try {
			Path file = root.resolve(loadedImagesUrl);
			Resource resource = new UrlResource(file.toUri());
			System.out.println("resource : " + resource);
			return resource;
		} catch (MalformedURLException e) {
			throw new RuntimeException("Error: " + e.getMessage());
		}
		}

	@Override
	public List<Employee> findByDateAndYear(String year, String month, String day) {
		return employeeRepo.findAll();
	}

	@Override
	public Optional<Employee> findById(Long employeeId) {
		
		return employeeRepo.findById(employeeId);
	}

	@Override
	public Map<Long,String> findAll() {
		List<Employee> empData = employeeRepo.findAll();
		Map<Long,String>empDropdown = new LinkedHashMap<>();
		for(Employee emp:empData) {
			empDropdown.put(emp.getEmployeeId(), emp.getEmpName());
		}
		return empDropdown;
	}


}
