package com.example.demo.controller;

import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.Dto.AttendanceListDto;
import com.example.demo.Utils.PdfGenerator;
import com.example.demo.entity.Attendance;
import com.example.demo.entity.Employee;
import com.example.demo.entity.User;
import com.example.demo.service.AttendenceService;
import com.example.demo.service.EmployeeService;
import com.example.demo.service.UserService;
import com.lowagie.text.DocumentException;

import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@CrossOrigin(origins = { "*" }, maxAge = 3600)
@RestController
@RequestMapping({ "/api/pdf" })
@AllArgsConstructor(onConstructor_ = { @Autowired })
@NoArgsConstructor
public class PdfGeneratorController {

	private @NonNull EmployeeService employeesService;
	
	private @NonNull AttendenceService attendenceService;

	private @NonNull UserService  userService;
	
	@ApiOperation(value = "Employee Attendance Reports")
	@RequestMapping(value = "/employee/Report", method = RequestMethod.GET, consumes = "application/json", produces = "application/json")
	public void generatePdfFiles1(HttpServletResponse response,Principal principal,@RequestBody AttendanceListDto request)
			throws DocumentException, IOException {
		
		String name = principal.getName();
		
		User user = userService.findByUserName(name);
		
		
		Optional<Employee> emp = employeesService.findById(user.getEmployee().getEmployeeId());
		Employee empData = emp.get();
		
		response.setContentType("applicat "
				+ "ion/pdf");
		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
		String currentDateTime = dateFormat.format(new Date());
		String headerkey = "Content-Disposition";
		String headervalue = "attachment; filename=attend" + currentDateTime + ".pdf";
		response.setHeader(headerkey, headervalue);
		List<Attendance> listofbranchemp = attendenceService.findByEmployeeEmployeeIdAndMonthAndYear(user.getEmployee().getEmployeeId(),request.getMonth(), request.getYear());
		PdfGenerator generator = new PdfGenerator();
		generator.generateds(listofbranchemp,empData.getEmpName(), response);
	}
//
//	@GetMapping({ "/branch/loanReport/{branchId}" })
//	private ResponseEntity<?> fetchAlls(@PathVariable("branchId") int branchId, @RequestHeader HttpHeaders httpHeader)
//			throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<BranchLoanReportDto> sceObject = branchMasterService.findBranchId(branchId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("branchMaster.getList"));
//		} catch (Exception e) {
//			return responseGenerator.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/branch/loan/Report/{branchId}")
//	public void generatePdfFiles(HttpServletResponse response, @PathVariable("branchId") int branchId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<BranchLoanReportDto> listofbranchloan = branchMasterService.getbranchlistList(branchId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generateds(listofbranchloan, response);
//	}
//
//	@GetMapping({ "/empfollowreport/{employeeId}" })
//	private ResponseEntity<?> fetchAll(@PathVariable("employeeId") int employeeId,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<EmpReportfollowupDto> sceObject = employeesService.findEmployeesId(employeeId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("employee.getList"));
//		} catch (Exception e) {
//			return responseGenerator.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/employee/status/Report/{paidDate}")
//	public void generatePdfFile(HttpServletResponse response, @PathVariable("paidDate") String paidDate)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		String[] dateParts = paidDate.split("-");
//		String year = dateParts[0];
//		String month = dateParts[1];
//		String day = dateParts[2];
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<EmployeeStatusDto> listofemployees = employeesService.getemployeeList(year, month, day);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generates(listofemployees, response);
//	}
//
//	@GetMapping("/loan/Report")
//	public void generatePdfFile(HttpServletResponse response) throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<LoanDetailsgetallDto> listofloans = loanDetailsService.getLoanList();
//		PdfGenerator generator = new PdfGenerator();
//		generator.generate(listofloans, response);
//	}
//
//	@GetMapping({ "/branch/collection/{paidDate}" })
//	private ResponseEntity<?> fetchAll(@PathVariable("paidDate") String paidDate, @RequestHeader HttpHeaders httpHeader)
//			throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//		try {
//			String[] dateParts = paidDate.split("-");
//			String year = dateParts[0];
//			String month = dateParts[1];
//			String day = dateParts[2];
//			List<BranchCollectionDto> sceObject = branchMasterService.findAll(year, month, day);
//			return responseGenerator.generateResponse(HttpStatus.OK, sceObject,
//					"branchMaster.getList");
//		} catch (Exception e) {
//			return responseGenerator.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/branch/collection/Report/{paidDate}")
//	public void generatePdfFiles(HttpServletResponse response, @PathVariable("paidDate") String paidDate)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		String[] dateParts = paidDate.split("-");
//		String year = dateParts[0];
//		String month = dateParts[1];
//		String day = dateParts[2];
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<BranchCollectionDto> listofbranchcoll = branchMasterService.getbranchcollList(year, month, day);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generatez(listofbranchcoll, response);
//	}
//
//	@GetMapping({ "/loan/collection/{paidDate}" })
//	private ResponseEntity<?> fetchAlles(@PathVariable("paidDate") String paidDate,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//		try {
//			String[] dateParts = paidDate.split("-");
//			String year = dateParts[0];
//			String month = dateParts[1];
//			String day = dateParts[2];
//			List<LoanCollectionDto> sceObject = loanDetailsService.findAll(year, month, day);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("loan.getList"));
//		} catch (Exception e) {
//			return responseGenerator.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/loan/collection/Report/{paidDate}")
//	public void generatePdfFiless(HttpServletResponse response, @PathVariable("paidDate") String paidDate)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		String[] dateParts = paidDate.split("-");
//		String year = dateParts[0];
//		String month = dateParts[1];
//		String day = dateParts[2];
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<LoanCollectionDto> listofloancoll = loanDetailsService.getloancollList(year, month, day);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generatezz(listofloancoll, response);
//	}
//
////	@GetMapping({ "/schudule/{followUpDate}" })
////	private ResponseEntity<?> fetchAlls(@PathVariable("followUpDate") String followUpDate,
////			@DateTimeFormat(pattern = "dd-MM-yyyy") @RequestHeader HttpHeaders httpHeader, Principal principle) throws Exception {
////		this.responseGenerator.generateTransationContext(httpHeader);
////		try {
////			Date followUpsDate = new SimpleDateFormat("dd-MM-yyyy").parse(followUpDate);
////			List<SchudulefollowupDateDto> sceObject = loanDetailsService.findByFollowUpDate(followUpsDate, principle);
////			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
////					this.messageSource.getMessage("schudule.getList"));
////		} catch (Exception e) {
////			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
////		}
////	}
//
//	@GetMapping("/loan/schudules/Report/{followUpDate}")
//	public void generatePdfFileses(HttpServletResponse response, @PathVariable("followUpDate") String followUpDate)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		String[] dateParts = followUpDate.split("-");
//		String day = dateParts[0];
//		String month = dateParts[1];
//		String year = dateParts[2];
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<SchudulefollowupDateDto> listofschudule = loanDetailsService.getschuduleList(day, month, year);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generatezez(listofschudule, response);
//	}
//
//	@GetMapping("/employee/followup/Report/{employeeId}")
//	public void generatePdfFile(HttpServletResponse response, @PathVariable("employeeId") int employeeId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<EmpReportfollowupDto> listofemployeesfollow = employeesService.getemployeefollowList(employeeId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generateed(listofemployeesfollow, response);
//	}
//
//	@GetMapping({ "/loancloser/{loanId}" })
//	private ResponseEntity<?> fetchAlle(@PathVariable("loanId") int loanId, @RequestHeader HttpHeaders httpHeader)
//			throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<LoanClosureDto> sceObject = loanDetailsService.findLoanId(loanId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("loan.getList"));
//		} catch (Exception e) {
//			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/loancloser/Report/{loanId}")
//	public void generatePdfFiless(HttpServletResponse response, @PathVariable("loanId") int loanId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<LoanClosureDto> loanclusore = loanDetailsService.getloanId(loanId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generateeds(loanclusore, response);
//	}
//
//	// MissingReportDto
//
//	@GetMapping({ "/missingreport/{followUpDate}" })
//	private ResponseEntity<?> fetchAllees(@PathVariable("followUpDate") String followUpDate,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//		try {
//			String[] dateParts = followUpDate.split("-");
//			String year = dateParts[0];
//			String month = dateParts[1];
//			String day = dateParts[2];
//
//			List<MissingReportDto> sceObject = loanDetailsService.findAlls(year, month, day);
//
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("loan.getList"));
//		} catch (Exception e) {
//			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/missing/Report/{followUpDate}")
//	public void generatePdfFilesese(HttpServletResponse response, @PathVariable("followUpDate") String followUpDate)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		String[] dateParts = followUpDate.split("-");
//		String year = dateParts[0];
//		String month = dateParts[1];
//		String day = dateParts[2];
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<MissingReportDto> missing = loanDetailsService.getmissingList(year, month, day);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generatezezes(missing, response);
//	}
//
//	@GetMapping({ "/LoanReport/{loanId}" })
//	private ResponseEntity<?> fetchAlles(@PathVariable("loanId") int loanId, @RequestHeader HttpHeaders httpHeader)
//			throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<EmpReportfollowupDto> sceObject = loanDetailsService.findloanIds(loanId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("loan.getList"));
//		} catch (Exception e) {
//			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/Loans/Report/{loanId}")
//	public void generatePdfFilesss(HttpServletResponse response, @PathVariable("loanId") int loanId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<EmpReportfollowupDto> listofemployeesfollow = loanDetailsService.getloanList(loanId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generateeed(listofemployeesfollow, response);
//	}
//
//	@GetMapping({ "/BranchReport/{branchId}" })
//	private ResponseEntity<?> fetchAllesW(@PathVariable("branchId") int branchId, @RequestHeader HttpHeaders httpHeader)
//			throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<EmpReportfollowupDto> sceObject = branchMasterService.findbranchIds(branchId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("branchMaster.getList"));
//		} catch (Exception e) {
//			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/Branch/Report/{branchId}")
//	public void generatePdfFilewsss(HttpServletResponse response, @PathVariable("branchId") int branchId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<EmpReportfollowupDto> listofemployeesfollow = branchMasterService.getbranchList(branchId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generateeewd(listofemployeesfollow, response);
//	}
//
//	@GetMapping({ "/EmployeeCollection/{employeeId}" })
//	private ResponseEntity<?> fetchAllW(@PathVariable("employeeId") int employeeId,
//			@RequestHeader HttpHeaders httpHeader) throws Exception {
//		this.responseGenerator.generateTransationContext(httpHeader);
//
//		try {
//
//			List<EmployeeCollectionDto> sceObject = employeesService.findemployeeIds(employeeId);
//			return ResponseHandler.generateResponse(HttpStatus.OK, sceObject,
//					this.messageSource.getMessage("employee.getList"));
//		} catch (Exception e) {
//			return ResponseHandler.generateResponse(HttpStatus.BAD_REQUEST, null, e.getMessage());
//		}
//	}
//
//	@GetMapping("/Employee/Collection/Reports/{employeeId}")
//	public void generatePdfFilsss(HttpServletResponse response, @PathVariable("employeeId") int employeeId)
//			throws DocumentException, IOException {
//		response.setContentType("application/pdf");
//		DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-DD:HH:MM:SS");
//		String currentDateTime = dateFormat.format(new Date());
//		String headerkey = "Content-Disposition";
//		String headervalue = "attachment; filename=loan" + currentDateTime + ".pdf";
//		response.setHeader(headerkey, headervalue);
//		List<EmployeeCollectionDto> listofemployeescol = employeesService.getempcolList(employeeId);
//		PdfGenerator generator = new PdfGenerator();
//		generator.generatewd(listofemployeescol, response);
//	}

}
