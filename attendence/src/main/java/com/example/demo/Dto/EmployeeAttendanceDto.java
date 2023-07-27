package com.example.demo.Dto;

import lombok.Data;

@Data
public class EmployeeAttendanceDto {

	private String checkIn;
	private String checkOut;
	private int workingHours;
}
