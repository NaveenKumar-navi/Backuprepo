package com.example.demo.Dto;

import java.util.List;

import javax.validation.Valid;

import lombok.Data;

@Data
public class EmployeeDtlUploadDto {
	
	
    private int TotalRecords;
    
    private int ErrorRecords;
    
    private int UploadRecords;
    
    @Valid
    private List<EmployeeDto>EmployeeDtlList;
}
