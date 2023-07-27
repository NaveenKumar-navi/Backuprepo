package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.Dto.AttendanceListDto;
import com.example.demo.Dto.EmployeeAttendanceDto;
import com.example.demo.Dto.PunchDto;
import com.example.demo.entity.Attendance;

@Service
public interface AttendenceService {

	EmployeeAttendanceDto attendenceCheckIn(PunchDto request,Long employeeId);

	List<EmployeeAttendanceDto> getCheckInData(AttendanceListDto request, Long empId);

	EmployeeAttendanceDto attendenceCheckOut(PunchDto request,Long employeeId);

	List<Attendance> findByEmployeeEmployeeIdAndMonthAndYear(Long empId, String month, String year);


}
