package com.example.demo.Helper;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.Dto.EmployeeDtlUploadDto;
import com.example.demo.Dto.EmployeeDto;
import com.example.demo.service.EmployeeService;

import lombok.AllArgsConstructor;

@Service
@Transactional
@AllArgsConstructor(onConstructor_ = { @Autowired })
public class Helper {
	
	@Autowired
	private EmployeeService employeeService;
	
	@SuppressWarnings("unused")
	public EmployeeDtlUploadDto uploadExcelConditions(MultipartFile file) {
		List<String> errors = null;
		int totalRecords = 0;
		int uploadRecords = 0;
		int errorRecords = 0;
		EmployeeDtlUploadDto value = new EmployeeDtlUploadDto();
		List<EmployeeDto> list = new ArrayList<EmployeeDto>();
		XSSFWorkbook workbook;
		try {
			workbook = new XSSFWorkbook(file.getInputStream());
			XSSFSheet worksheet = workbook.getSheetAt(0);
			DataFormatter formatter = new DataFormatter();
			totalRecords = worksheet.getPhysicalNumberOfRows() - 1;
			for (int i = 1; i < totalRecords + 1; i++) {
			EmployeeDto empDtl = new EmployeeDto();
			XSSFRow row = worksheet.getRow(i);
			String empName = formatter.formatCellValue(row.getCell(0));
			empDtl.setEmpName(empName);
			String mobileNo = formatter.formatCellValue(row.getCell(1));
			empDtl.setMobileNo(mobileNo);
			String email = formatter.formatCellValue(row.getCell(2));
			empDtl.setEmail(email);
			String address = formatter.formatCellValue(row.getCell(3));
			empDtl.setAddress(address);
			String designation = formatter.formatCellValue(row.getCell(4));
			empDtl.setDesignation(designation);
		
			errors = new ArrayList<>();
			if ("".equals(empName) || null==empName) {
				errors.add("empName is mandatory");
			}
			if (mobileNo==null && mobileNo=="") {
				errors.add("mobileNo is mandatory");
			}
			if (email==null && email=="") {
				errors.add("email is mandatory");
			}
			if (address==null && address=="") {
				errors.add("address is mandatory");
			}
			if (designation==null && designation=="") {
				errors.add("designation is mandatory");
			}
			if (errors.size() > 0) {
				String errorMessage = errors.stream().map(a -> String.valueOf(a)).collect(Collectors.joining(", "));
				errorRecords++;
				list.add(empDtl);
			} else {
			    employeeService.save(empDtl);
				uploadRecords++;
			} 
				value.setEmployeeDtlList(list);
				value.setErrorRecords(errorRecords);
				value.setTotalRecords(totalRecords);
				value.setUploadRecords(uploadRecords);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
			return value;
		}


}
